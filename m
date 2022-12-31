Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF5165A4AF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLaNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLaNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:41:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B902E9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:41:01 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F1041EC0493;
        Sat, 31 Dec 2022 14:41:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672494060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m7rCTpk9c3/hvAowOtgf/iURb5jKAxrFcYb/Bg6gYRQ=;
        b=Tjc0FU6RHjhOvvCJfJrEuEBEOAExLE5buF0lpG62t4mKcXRx7eZHjNH6zMgr4zuhVmlB+3
        HQkg3c3WFNG6YBQ17h7XTBLpD0yE3yfWEWpHL/7tl3cQtaMdI7McVw7GcdBNba16CYno0d
        NxAQ+L/Vk4LcN4m0LEUuo4cp93aDJJI=
Date:   Sat, 31 Dec 2022 14:40:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7A76+IBS4fnucrW@zn.tnic>
References: <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y62MdawGaasXmoVL@zn.tnic>
 <Y68Js5b0jW/2nLU4@zx2c4.com>
 <Y68Zf/MKmX3Rr18E@zn.tnic>
 <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
 <Y69B40T9kWfxZpmf@zn.tnic>
 <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
 <Y69h6ur79SMhu61F@zx2c4.com>
 <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 05:06:55PM -0800, H. Peter Anvin wrote:
> This needs to be something like:
> 
> kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd));
> kernel_add_identity_map(sd_addr + sizeof(*sd),
> 	sd_addr + sizeof(*sd) + sd->len);

It still #PFs with that:

(gdb) bt
#0  0xffffffff84738576 in native_halt () at ./arch/x86/include/asm/irqflags.h:57
#1  halt () at ./arch/x86/include/asm/irqflags.h:98
#2  early_fixup_exception (regs=regs@entry=0xffffffff84007dc8, trapnr=trapnr@entry=14) at arch/x86/mm/extable.c:340
#3  0xffffffff846ff465 in do_early_exception (regs=0xffffffff84007dc8, trapnr=14) at arch/x86/kernel/head64.c:424
#4  0xffffffff846ff14f in early_idt_handler_common () at arch/x86/kernel/head_64.S:483
#5  0xc149f9894908788d in ?? ()
#6  0xffffffffff2003fc in ?? ()
#7  0x0000000000000010 in fixed_percpu_data ()
#8  0xdffffc0000000000 in ?? ()
#9  0xffffffff84007ea8 in init_thread_union ()
#10 0xffffffffff20088d in ?? ()
#11 0x0000000000000000 in ?? ()

/me goes to dig more.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
