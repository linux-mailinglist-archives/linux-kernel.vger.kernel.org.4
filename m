Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75871330D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjE0Hge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjE0Hg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:36:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD2DC9
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:36:24 -0700 (PDT)
Received: from nazgul.tnic (dynamic-002-247-254-198.2.247.pool.telefonica.de [2.247.254.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 234DD1EC06EE;
        Sat, 27 May 2023 09:23:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685172224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EccVBHabIGbLCtNLMzuwGkc2JriX9LRyjMLOs3mmoA8=;
        b=kXgGNvfH0DlUJsqtiJyX/1TSZnRDd3rvn5RoA+gW1pqEMT/2bX0UNw59y4Ytuwc4DZXwKs
        wgkgjNCjkusAHdg7u4ahUGS2mMUvnO36aC9rhyxZN8xkHg3tMjdW7Fc8fBt8+VpmSLN7dz
        Vh+hPRXEptCW27fYwV3Rqt4UrLjoiCs=
Date:   Sat, 27 May 2023 09:23:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
Message-ID: <20230527072338.GAZHGv+no2LZASyLWM@nazgul.local>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
 <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
 <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
 <e6cd1909-2776-28d2-ccc0-4b3d2d09e9ce@intel.com>
 <49861038-B8CA-4CDD-BD44-73066FF453F3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49861038-B8CA-4CDD-BD44-73066FF453F3@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 02:55:21PM -0700, Nadav Amit wrote:
> So my tool takes a branch trace and then simulates the code execution.
> As a preparatory step I need to disassemble the code, yet as I do not
> know where the symbol starts and its size, I can only disassemble one
> instruction at a time. [ I prefer to disassemble the whole symbol at once

So in this particular case, the exception handling ends up being part of
__get_user_nocheck_8, see the end of this mail.

However, the symbol table says it is of size 19:

123630: ffffffff81b89310    19 FUNC    GLOBAL DEFAULT    1 __get_user_nocheck_8

which means the trailing exception handling is not part of that symbol
when looking at the size. And that's where your tool fails.

Close?

And if so, your tool could simply look at the next symbol's address and
attribute the trailing bytes to the previous symbol.

If you look at the disassembly at the end, some other option has added
INT3 padding to the end of the symbol so that the next one is aligned.
But you can simply skip over those 0xcc insn bytes.

And skipping over those 0xcc bytes is something your tool needs to
handle anyway because they're not part of the symbol either.

> These are only 2 things that break to one extent or another. I can
> have workarounds for them (I already do). I just see no reason to
> treat these two symbols differently.

Right, the kernel should not dance just because some tool says so. And
every time a new tool pops up, there are patches to "fix" the kernel.

> I seriously see no downside

The downside is polluting the symbol table unnecessarily. If it doesn't
have to be there then it shouldn't be.

And yeah yeah, this particular case can be fixed easily but the bigger
issue remains: we have a lot of local symbols which get discarded around
the tree. Does that mean that because your tool cannot handle that, we
have to stop using local symbols?

What happens if we do something else weird in the future and your tool
breaks again?

Also, why can't your tool handle such cases gracefully instead of having
to "fix" the kernel each time?

Thx.

ffffffff81b89310 <__get_user_nocheck_8>:
ffffffff81b89310:       90                      nop
ffffffff81b89311:       90                      nop
ffffffff81b89312:       90                      nop
ffffffff81b89313:       90                      nop
ffffffff81b89314:       90                      nop
ffffffff81b89315:       90                      nop
ffffffff81b89316:       48 8b 10                mov    (%rax),%rdx
ffffffff81b89319:       31 c0                   xor    %eax,%eax
ffffffff81b8931b:       90                      nop
ffffffff81b8931c:       90                      nop
ffffffff81b8931d:       90                      nop
ffffffff81b8931e:       e9 9d a3 01 00          jmp    ffffffff81ba36c0 <__x86_return_thunk>
ffffffff81b89323:       66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
ffffffff81b8932a:       00 00 00 00
ffffffff81b8932e:       66 90                   xchg   %ax,%ax
ffffffff81b89330:       90                      nop
ffffffff81b89331:       90                      nop
ffffffff81b89332:       90                      nop
ffffffff81b89333:       31 d2                   xor    %edx,%edx
ffffffff81b89335:       48 c7 c0 f2 ff ff ff    mov    $0xfffffffffffffff2,%rax
ffffffff81b8933c:       e9 7f a3 01 00          jmp    ffffffff81ba36c0 <__x86_return_thunk>
ffffffff81b89341:       cc                      int3
ffffffff81b89342:       cc                      int3
ffffffff81b89343:       cc                      int3
ffffffff81b89344:       cc                      int3
ffffffff81b89345:       cc                      int3
ffffffff81b89346:       cc                      int3
ffffffff81b89347:       cc                      int3
ffffffff81b89348:       cc                      int3
ffffffff81b89349:       cc                      int3
ffffffff81b8934a:       cc                      int3
ffffffff81b8934b:       cc                      int3
ffffffff81b8934c:       cc                      int3
ffffffff81b8934d:       cc                      int3
ffffffff81b8934e:       cc                      int3
ffffffff81b8934f:       cc                      int3

ffffffff81b89350 <__pfx_inat_get_opcode_attribute>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
