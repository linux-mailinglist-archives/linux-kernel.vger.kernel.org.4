Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AB6E7EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjDSP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjDSP7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:59:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695AD11A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:59:05 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F3801EC054E;
        Wed, 19 Apr 2023 17:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681919943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rfDyAb8ZiBeP09qSKyPdO93fSg3GVwLhBBZzrbBq4yI=;
        b=L5/7PMESy01IHlS7pkChxm47PJ+JquimQDLx0e0hsYC6Vw0NqSxujvh9KXx9VLoVf+38Pm
        eIF+YpJddWQulocaKT4zc96X22YLRX+3XhJiXPN2HlfCtZxwvXoetJqVR8FVsMDtziuT4m
        wJvm9nRE20lJATSYA/hOnfUTVbQR8CY=
Date:   Wed, 19 Apr 2023 17:59:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc7
Message-ID: <20230419155900.GCZEAPxNiOUP31q+/H@fat_crate.local>
References: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
 <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
 <20230417090412.GAZD0LjH5ZIaGUdoHH@fat_crate.local>
 <20230418012435.fhjxd6moaz6tmnep@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418012435.fhjxd6moaz6tmnep@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 06:24:35PM -0700, Josh Poimboeuf wrote:
> I implemented it in the patch below.

Ha, amazing! Thanks man. :-)

> It was pretty straightforward
> since this case always(?) involves two relocations within a single
> instruction, like:
> 
>  3d9:	48 c7 05 00 00 00 00 00 00 00 00 	movq   $0x0,0x0(%rip)        # 3e4 <x86_wallclock_init+0xa4>	3dc: R_X86_64_PC32	x86_platform+0x8
> 	3e0: R_X86_64_32S	.init.text+0x280
> 
> So objtool warns if the instruction's first relocation is non-init and
> the second one is init.

Sounds plausible to me.

> There are 9 "disallowed store" warnings.  There would have been more,
> but I added per-symbol rate-limiting to keep the total number of
> warnings down.  For example, instead of the x86_wallclock_init() issue
> discovered above, it shows a similar warning from elsewhere:
> 
>   vmlinux.o: warning: objtool: xen_init_apic+0xab: disallowed store of init symbol xen_apic_check to non-init data x86_platform

Obviously a good catch.

However, the only call site is in apic_intr_mode_init() which itself is
__init. So yeah, strictly speaking nothing wrong.

*IF* something calls it later, when __init is gone, then boom.

Dunno, maybe

a) track call sites too but maybe expensive and too much

or

b) make those warnings debug messages in case someone wants to run objtool
in debug mode, feels really bored and wants to fix potential issues.

Or someone has a better idea.

> Anyway, this is kind of experimental.  If any of these warnings don't
> turn out to be useful I could drop some or all them.

Right, I can certainly see potential and as said, since we're already
doing objtool massaging of object files, thought this should be pretty
easy to do. As you've shown. ;-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
