Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0466911A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBIT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBIT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:57:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88085A9F0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:57:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 089FBB822E4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654AFC433EF;
        Thu,  9 Feb 2023 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675972662;
        bh=7mTRRdcjrFDkBAFFKFwksVb4OCr0q5VLSSWtfUuPP/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZUpLSLM679NXl50GT/9kBHopYVdC/0NZ4HUHmKv9D35aSHnYW7jOw+CmWjx+jqf8
         HwT9xJHYTAGOAnmI5x/+Ju8HStycO10BhWKcmvtotTMj2FLYmB707dZQgAV8ONi+CF
         pLrtjRR6wz5jYj4LKywY3fydeiTsK2PY0/NPZwjXthLyg+uTXxkk/BEB/oN7cGLTQR
         mCssaUOpCffBOJOvxmFkQTPZyK6GUJ0oIXVLSE3gmAWsAwK0VHtUzi5fQKtwLBATjA
         XGkqvKloH9mKf+1fMhvMnlVm0NNR9q4wPYtzOftke8TussUor3njQAeZQPwyk2QyPt
         M1JPK+6fsWnzw==
Date:   Thu, 9 Feb 2023 11:57:40 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] objtool: Honey, I shrunk the instruction
Message-ID: <20230209195740.v4dhjuuri53wimui@treble>
References: <20230208171756.898991570@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208171756.898991570@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:17:56PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Boris complained he could no longer build allyesconfig on his 32G desktop
> machine without having OOM terminate either objtool or chrome.
> 
> After talking about these patches on IRC, Nathan mentioned the linux-clang CI
> was also having trouble of recent, and these patches appear to make it happy
> again.
> 
> In total these patches shrink an allyesconfig run by about 6G:
> 
> pre:	5:58.22 real,   226.69 user,    131.22 sys,     26221520 mem
> post:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem
> 
> Also at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core

For patches 1-9:

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

To make the last patch legit we could just have reloc_offset(),
reloc_addend(), reloc_type() helpers to abstract access to rela/rel
fields.

And I'm sure there are other savings we could do to struct reloc, like
single-linked lists, bitfields, etc.

Let me know if you want me to do it.

-- 
Josh
