Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6C65A4AC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiLaNf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLaNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:35:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BA218C
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:35:51 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61BB31EC0493;
        Sat, 31 Dec 2022 14:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672493750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o0ed0270LbR4oSMiWhqbUtlUU3rbUG/UHLY5euGcUOs=;
        b=Npfe4/LhoihV1SevMmBX/L0PSt78NsHqGVmzB3hKlCgt3vI5wBBZTADJ1os5wH8c8kZPMs
        adDfhCgU3OrNMaBcSzJC2laYCFCo/upQmZC5guvTASLpgadxlGEzkUD69TnFU+unWVdoBK
        Tu/VhcPpLsYgEgnK/VRHKVVDnxPO3Io=
Date:   Sat, 31 Dec 2022 14:35:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7A6sTOSudSxSWLB@zn.tnic>
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
 <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y68K4mPuz6edQkCX@zx2c4.com>
 <Y7AFYKWPRXYs7S4m@zn.tnic>
 <Y7AxGiGQYZNJWpCr@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7AxGiGQYZNJWpCr@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 01:54:50PM +0100, Jason A. Donenfeld wrote:
> Nothing special... `-kernel bzImage` should be enough to do it. Eric
> reported it, and then I was able to repro trivially. Sure you got the
> right version?

Yeah, qemu executables confusion here - had wrongly something older of the
version 7.1...

Now made sure I'm actually booting with the latest qemu:

QEMU emulator version 7.2.50 (v7.2.0-333-g222059a0fccf)

With that the kernel with your config hangs early during boot and the stack
trace is below.

Seeing how it says trapnr 14, then that looks like something you are seeing.

But lemme poke at it more.

#0  0xffffffff84738576 in native_halt () at ./arch/x86/include/asm/irqflags.h:57
#1  halt () at ./arch/x86/include/asm/irqflags.h:98
#2  early_fixup_exception (regs=regs@entry=0xffffffff84007dc8, trapnr=trapnr@entry=14) at arch/x86/mm/extable.c:340
#3  0xffffffff846ff465 in do_early_exception (regs=0xffffffff84007dc8, trapnr=14) at arch/x86/kernel/head64.c:424
#4  0xffffffff846ff14f in early_idt_handler_common () at arch/x86/kernel/head_64.S:483
#5  0x2404c74100000cd0 in ?? ()
#6  0xffffffffff20073c in ?? ()
#7  0x0000000000000010 in fixed_percpu_data ()
#8  0xdffffc0000000000 in ?? ()
#9  0xffffffff84007ea8 in init_thread_union ()
#10 0xffffffffff200cd0 in ?? ()
#11 0x0000000000000000 in ?? ()

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
