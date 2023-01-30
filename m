Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8068203A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjAaAAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjA3X7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:59:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183625E20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:59:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17CDA6131D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EE1C433AA;
        Mon, 30 Jan 2023 23:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675123181;
        bh=SAulgTtc3QwDC6udFNlKXdv8TdHBxYduwIkA4m5CySc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODR60H2IseZ3eKAnFNgYfUj4t27tKTTV5dv6v0tRYA4USgiZNNgHiqezYi0+w6EA4
         WDz2aSVeWa+0h9Dig6Ia1ojRqWJR8eKOix2RMxL27XTCm6TugGNfMJn35G1jGlLl7x
         fTXBzvrVVdblUawxT2kiz1v3BVRTHKTEN6MDH96TWEsmT5kUx6THJXPAAil4Rwz9ZN
         ASbhdt7WDDUxzxPIYD8r/Te4WwoV88SQSoppg1FCXvLPPh01vcvCD0GP0MysAaCfm8
         OQGPWuB19oUB2qSBbjyTI5jIDkPeaDGjiKtmnYt3jGO6ZFXOZuL4KJUESRRlWotgaC
         mSVvSKExF4e+Q==
Date:   Mon, 30 Jan 2023 15:59:39 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] objtool: reduce memory usage of struct reloc
Message-ID: <20230130235939.5kuau4d7agbmxqal@treble>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
 <20221216-objtool-memory-v2-5-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216-objtool-memory-v2-5-17968f85a464@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 04:01:01PM +0000, Thomas Weißschuh wrote:
>  void elf_reloc_set_type(struct reloc *reloc, int type)
>  {
> +	if (type >= (1U << (8 * sizeof(reloc->type))))
> +		WARN("reloc->type out of range: %d", type);
> +
>  	reloc->type = type;
>  }
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index 33ec6cf72325..2b5becad5a0a 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -77,10 +77,10 @@ struct reloc {
>  	struct symbol *sym;
>  	struct list_head sym_reloc_entry;
>  	unsigned long offset;
> -	unsigned int type;
>  	s64 addend;
>  	int idx;
>  	bool jump_table_start;
> +	unsigned char type;
>  };

I'd rather not because

  a) the helper function isn't very intuitive and we'll probably forget
     to use it

  b) some arches need more than 256 types (see for example aarch64 which
     objtool may need to support one of these days)

That said, feel free to rearrange the struct fields to at least get some
of those bytes back.

-- 
Josh
