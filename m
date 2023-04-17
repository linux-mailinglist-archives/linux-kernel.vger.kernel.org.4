Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864476E4FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDQSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:14:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35907E48
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:14:19 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB7381EC01A9;
        Mon, 17 Apr 2023 20:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681755257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3oAv63+EkEw6amRGtsM+gqDlCgqDrwGGKhHm2BH3LAo=;
        b=OsEf+rGAxvIeDCS1wiApbOSCjll5kBRnIuU5S8qFDf2zrPHelPQs/P0C/eo/BWSr4w8zvG
        XkJ48f7aCkLdDqNZ09uvGRGfvoOBrjLVCC4U4kYxfUPGQtlSKfTerC8HIcT5cDXA56C5Mz
        axgM+UoHVp5fBjLZi3AXWGQqEbIUOgM=
Date:   Mon, 17 Apr 2023 20:14:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG REPORT] arch/x86/include/asm/uaccess_64.h:119: Error: junk
 at end of line
Message-ID: <20230417181417.GHZD2MeRSuMWUPEU3V@fat_crate.local>
References: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com>
 <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local>
 <ZDrlMfy+OcDjXwvn@1wt.eu>
 <E8CB02C5-E18C-42F6-93D8-2CC7CB4CB3FF@alien8.de>
 <ZDuzlNOmIT0Gd7fF@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDuzlNOmIT0Gd7fF@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 10:36:36AM +0200, Willy Tarreau wrote:
> ...
> So it just means that the support for the "U" suffix on numbers was
> added in binutils 2.27 and the "L" suffix on numbers was added somewhere
> between 2.27 and 2.29.

Thanks for that - I'd like to document this once I've hashed out with
the toolchain person the proper binutils versions which got this
support. But that'll come later.

> And given that there's a single occurrence of all this in the whole tree,
> that's why I'm proposing to just get back to the good old (1 << 0) instead
> of BIT(0).

Yeah, we have those UC() macro things but they don't work in inline asm
in C code. So yeah, pls do the thing you're suggesting.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
