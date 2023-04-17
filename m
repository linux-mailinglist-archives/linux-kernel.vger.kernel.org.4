Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC546E50CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDQT0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDQT0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:26:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA88F65B9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:26:10 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4A3A1EC063A;
        Mon, 17 Apr 2023 21:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681759568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ctd6FUk5ost2tH+czhZg3cUaJX0lMVsHZ0jeULbjVp8=;
        b=qCRzqqAcfo6nrERMbkfiv1N2/06EBGWx8tWIoHuvpLb+iEPpkM8JSFnxPZ4IQjOQaGusf3
        X2oNJ77cFgIqNi9nI4pQKPWEEtdcroYIUj027dGVongRflq2Yx8zUWp3N5G/10vKUlcsAn
        CY2Z5YJedmxn6V2n6Y51TolYEF9hMGI=
Date:   Mon, 17 Apr 2023 21:26:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Willy Tarreau <w@1wt.eu>, Jingbo Xu <jefflexu@linux.alibaba.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG REPORT] arch/x86/include/asm/uaccess_64.h:119: Error: junk
 at end of line
Message-ID: <20230417192604.GJZD2dTM64OGLdJj2E@fat_crate.local>
References: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com>
 <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local>
 <ZDrlMfy+OcDjXwvn@1wt.eu>
 <E8CB02C5-E18C-42F6-93D8-2CC7CB4CB3FF@alien8.de>
 <ZDuzlNOmIT0Gd7fF@1wt.eu>
 <20230417181417.GHZD2MeRSuMWUPEU3V@fat_crate.local>
 <F3AC1D23-D1B7-4036-BF52-1CC4FD6C3EAD@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F3AC1D23-D1B7-4036-BF52-1CC4FD6C3EAD@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:32:19AM -0700, H. Peter Anvin wrote:
> We do have assembly-aware macros for this; I believe they are called _UL() etc.

It doesn't work even if I do:

#define ALT_FLAG_NOT            BIT_MASK(0)

and that macro has the UL() wrappery for the __ASSEMBLY__ preprocessor case
because where it gets used, ALTERNATIVE_3() in __clear_user(),
__ASSEMBLY__ is there not defined, ofc - it is C code.

So it does:

"# ALT: oldinstr3\n" "661:\n\t" "rep stosb" "\n662:\n" "# ALT: padding3\n"...
  " .4byte " "((((((1UL))) << ((0) % 64)) << 16) | ((18*32+ 4)))"

which those old gas things don't have support yet for.

And U and L suffixes are C-syntax, strictly speaking. So assembler
numbers don't need them. Even if binutils has support for them:

$ binutils-gdb> git tag --contains e140100a5da85568e83ffe8e77d3f5e4a59ddee8 | head 
binutils-2_27
...

$ binutils-gdb> git tag --contains 86b80085c889cd388fa677a5ae9053fd4be3776c | head 
binutils-2_28
...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
