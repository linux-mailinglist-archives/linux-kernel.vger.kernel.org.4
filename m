Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC10664043
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjAJMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbjAJMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:17:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8991DF0E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:17:03 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CD361EC04A9;
        Tue, 10 Jan 2023 13:17:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673353022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8ioAaLVaj25A2/xWl1Dve5ZJEyxgS9uJVpbZ4jZQrTE=;
        b=HbNyJoR47+aK5u38HQPctAzcI+T6e97ky0ZBuC8w7+4i+2J8+4DFzv6fLrZ5u2DFzDRm9P
        F3ba2dP0meJGvY0CeMMlaUFGRHt5nuJLBQ25H9XmAcHePjm8CRYBjcrfdglfLJJqH5UHqm
        wbVUOz4bg1swlfZFIaRfoxZweX2g50s=
Date:   Tue, 10 Jan 2023 13:17:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Zeng Heng <zengheng4@huawei.com>, michael.roth@amd.com,
        hpa@zytor.com, tglx@linutronix.de,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, liwei391@huawei.com,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Message-ID: <Y71XPl8br2QU2L8E@zn.tnic>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com>
 <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y71V8SRLxZ/Uqkfs@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:11:29PM +0100, Borislav Petkov wrote:
> On Tue, Jan 10, 2023 at 01:01:06PM +0100, Ingo Molnar wrote:
> > From: Zeng Heng <zengheng4@huawei.com>
> > Date: Tue, 10 Jan 2023 18:27:45 +0800
> > Subject: [PATCH] x86/boot/compressed: Register dummy NMI handler in EFI boot loader, to avoid kdump crashes
> > 
> > If kdump is enabled, when using mce_inject to inject errors, EFI
> 
> Why does "EFI" matter here? Any boot loader would do...
> 
> > boot loader would decompress & load second kernel for saving the
> 
> s/&/and/
> 
> > vmcore file.
> > 
> > For normal errors that is fine.
> 
> Useless sentence.
> 
> > However, in the MCE case, the panic
> > CPU that firstly enters into mce_panic() is running within NMI
> > interrupt context,
> 
> "#MC context" it is non-maskable but that's not "NMI interrupt context"
> 
> > and the processor blocks delivery of subsequent
> > NMIs until the next execution of the IRET instruction.
> > 
> > When the panic CPU takes long time in the panic processing route,
> 
> I'm still unclear on the order of events here. It sounds like
> 
> 1. MCE injected
> 2. panic
> 3. kdump gets loaded
> 
> If that is the case, then I presume the flow is:
> 
> mce_panic -> panic -> __crash_kexec()
> 
> Yes?
> 
> If so, then we should make sure we have *exited* #MC context before calling
> panic() and not have to add hacks like this one of adding an empty NMI handler.
> 
> But I'm only speculating as it is hard to make sense of all this text.

IOW, does this help?

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7832a69d170e..55437d8a4fad 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -287,6 +287,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
 		panic(msg);
+		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
 


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
