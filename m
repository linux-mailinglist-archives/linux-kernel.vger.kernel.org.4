Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86E663FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjAJMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjAJMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:01:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03458327
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:01:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d17so11473979wrs.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VolYRiSABhDndYYNEKONj1lyAiYPsl2ohB5ly0YsFTQ=;
        b=m+YDO5LITD9TyN0U8OC2I9QvVqvhTGruhVtt8aHGC8HyOF4qKI3fZM3F1HJ/d4qX3p
         CzqtvXpM3pBRhAF2smMu0K/qFgFr1dcv3bVhE2tp5DASWMNLVHId316rh9YBnXrLmGfc
         7RcL+Azp35ao2sCYy/VYdLqDgHCYktElvUOkqjjR/qy8ZSXhOI1JnuVlh/zyTNFytga4
         QMlSWzu7H+ZLn6b9g0QOSO/HFuvi7mj4VjQczmyz3w2yeImvIb68VltKLWyMDKhN2jQn
         H5X/RpombrCVb7UkWMdFKZsR4DXQsIOMWIN96aR9nCADk/4eRd/EaNX7WvmscQxkGpzV
         oajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VolYRiSABhDndYYNEKONj1lyAiYPsl2ohB5ly0YsFTQ=;
        b=iGN+bHpsLCDOlB2fOfnCYV3xfys75LjyEwhWuDfCmTiF42TpLiXQcBwXggnKq2DWDo
         xmLdedo+wUK2myDrJ9ac2x1gE1OwTLyuu6NDq1XXORVSRsHIELCxSRnoVBdk5LwUfKUS
         ZSVDDKiL1Ws2sLrWzWUUwJuQ15YgfVsoVbUPBdDGSIBTs4GPO5cJ9FGcSHfZgzbc3br1
         3dYi2LUjYLbZvc4n/SARUXZJP7TZDB5y244pcIGlVubGZj0hF6IBWtHHGiNT30uBqYfn
         1wF2Wq4FiR9qVr+eENS5b55schylo75+5F8HhPTP/F3ArAa/iJNRijXVKMEbHVpu7/k/
         12Nw==
X-Gm-Message-State: AFqh2kr6ufG41gyUUQROvhIs+suZzDuOM6O9BkJ6uSZfofshAxjRGnPc
        5/TheUgrl1OyCoW85tfVoJY=
X-Google-Smtp-Source: AMrXdXs1sMRX0sj9pn0lSFFtv7crynJU++DKQ+uMYsZnK4VJaUrKo8IXSWl4uuO7Aak1FiCgs6ivKw==
X-Received: by 2002:adf:fa84:0:b0:28b:ca44:6458 with SMTP id h4-20020adffa84000000b0028bca446458mr27339809wrr.2.1673352069282;
        Tue, 10 Jan 2023 04:01:09 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id q4-20020adfdfc4000000b002bc6c180738sm5241873wrn.90.2023.01.10.04.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 04:01:08 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Jan 2023 13:01:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     michael.roth@amd.com, bp@alien8.de, hpa@zytor.com,
        tglx@linutronix.de, sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, brijesh.singh@amd.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, liwei391@huawei.com
Subject: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in EFI
 boot loader, to avoid kdump crashes
Message-ID: <Y71TglxSLJKO17SY@gmail.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71FJ+G0NGQe3Ppq@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Zeng Heng <zengheng4@huawei.com> wrote:
> 
> > +void do_boot_nmi_fault(struct pt_regs *regs, unsigned long error_code)
> > +{
> > +	/* ignore */
> > +}
> > diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> > index 6debb816e83d..b169c9728d52 100644
> > --- a/arch/x86/boot/compressed/idt_64.c
> > +++ b/arch/x86/boot/compressed/idt_64.c
> > @@ -60,6 +60,7 @@ void load_stage2_idt(void)
> >  {
> >  	boot_idt_desc.address = (unsigned long)boot_idt;
> >  
> > +	set_idt_entry(X86_TRAP_NMI, boot_nmi_fault);
> >  	set_idt_entry(X86_TRAP_PF, boot_page_fault);
> 
> So it's a bit sad to install a dummy handler that does nothing, while 
> something clearly sent an NMI and expects an intelligent reaction - OTOH 
> the unexpected NMIs from from watchdog during a kdump clearly make things 
> worse by crashing the bootup.
> 
> Anyway, I cannot think of a better response here that the boot loading code 
> could do either, so I've applied your fix to tip:x86/boot.

BTW., the changelog had very poor quality, and the patch added no comments 
to explain the presence of the dummy NMI.

The -v2 version below should address most of those problems.

Thanks,

	Ingo

=============>
From: Zeng Heng <zengheng4@huawei.com>
Date: Tue, 10 Jan 2023 18:27:45 +0800
Subject: [PATCH] x86/boot/compressed: Register dummy NMI handler in EFI boot loader, to avoid kdump crashes

If kdump is enabled, when using mce_inject to inject errors, EFI
boot loader would decompress & load second kernel for saving the
vmcore file.

For normal errors that is fine. However, in the MCE case, the panic
CPU that firstly enters into mce_panic() is running within NMI
interrupt context, and the processor blocks delivery of subsequent
NMIs until the next execution of the IRET instruction.

When the panic CPU takes long time in the panic processing route,
and causes the watchdog timeout, at this moment, the processor
already receives NMI interrupt in the background.

In the reproducer sequence below, panic CPU would run into EFI loader
and raise page fault exception (like visiting `vidmem` variable
when attempting to call debug_putstr()), the CPU would execute IRET
instruction when it exits from the page fault handler.

But the loader never registers handler for NMI vector in IDT,
lack of vector handler would cause reboot, which interrupts
kdump procedure and fails to save the vmcore file.

Here is steps to reproduce the above issue (it's sporadic):

	1. # cat uncorrected
	CPU 1 BANK 4
	STATUS uncorrected 0xc0
	MCGSTATUS  EIPV MCIP
	ADDR 0x1234
	RIP 0xdeadbabe
	RAISINGCPU 0
	MCGCAP SER CMCI TES 0x6
	2. # modprobe mce_inject
	3. # mce-inject uncorrected

For increasing the probability of reproduction of this issue, there are
two ways to increase the probability of the bug:

  1. modify the threshold value of watchdog (increase NMI frequency);
  2. and/or add delays before panic() in mce_panic() and modify PANIC_TIMEOUT macro;

Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
[ Tidy up changelog, add comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230110102745.2514694-1-zengheng4@huawei.com
---
 arch/x86/boot/compressed/ident_map_64.c    | 12 ++++++++++++
 arch/x86/boot/compressed/idt_64.c          |  1 +
 arch/x86/boot/compressed/idt_handlers_64.S |  1 +
 arch/x86/boot/compressed/misc.h            |  1 +
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d4a314cc50d6..cbfdefcf9657 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -379,3 +379,15 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	kernel_add_identity_map(address, end);
 }
+
+void do_boot_nmi_fault(struct pt_regs *regs, unsigned long error_code)
+{
+	/*
+	 * Default boot loader placeholder fault handler - there's no real
+	 * kernel running yet, so there's not much we can do - but NMIs
+	 * can arrive in a kdump scenario, for example by the NMI watchdog.
+	 *
+	 * Not having any handler would cause the CPU to silently reboot,
+	 * so we do the second-worst thing here and ignore the NMI.
+	 */
+}
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 6debb816e83d..b169c9728d52 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -60,6 +60,7 @@ void load_stage2_idt(void)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
+	set_idt_entry(X86_TRAP_NMI, boot_nmi_fault);
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 22890e199f5b..2aef8e1b515b 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -69,6 +69,7 @@ SYM_FUNC_END(\name)
 	.text
 	.code64
 
+EXCEPTION_HANDLER	boot_nmi_fault do_boot_nmi_fault error_code=0
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 62208ec04ca4..d89d3f8417f6 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -187,6 +187,7 @@ static inline void cleanup_exception_handling(void) { }
 #endif
 
 /* IDT Entry Points */
+void boot_nmi_fault(void);
 void boot_page_fault(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
