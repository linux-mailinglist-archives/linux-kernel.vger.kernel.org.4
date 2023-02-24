Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF96A1EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBXPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBXPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:42:47 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B16CF10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:46 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id bo10so13032801qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxLgPS/+5KaXp/zoBtDBtP/uxsWooxCOhQ7CVpDn18k=;
        b=eyz1NKA00Lw2zBJw8qWnAYNwLyG+xI/YX6tKFdo4qjQC7aTvd9ur+YngDoECcktC1O
         +ThFpMX7Frg4dvJLeYi5HMSUqBnTSFTVRXeY+uJT9lqnHbhITIK9MfIoH8U7iTnBEdyi
         Dr7wR+yDGaolXkfKsx5o8zKSXEYm/QKUWEZCct+SUm3L03XglZMNi4qlzi1NO2XsYdbx
         ARf3PaIVAeDozw7kpd2psyoo/XpciY1VueM9I1UX9FVNF7iuGPprDdf+pMhPjOxI7n74
         ZJ+pzX+iyqYiUKJwk3l4+fdDvnxiVJKYApdd+Fl0o3E3vjKO6VLrA/We/cZSpcQPNTo2
         2vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxLgPS/+5KaXp/zoBtDBtP/uxsWooxCOhQ7CVpDn18k=;
        b=QG367u4356pshh6UTyagnfB7/q0wuSmF2FOb/pshnrXg5iWCSkGz4/MMsHVGeJFlKb
         1dUbLd8ae6qPFAQjSFrsb9Gycm1oy4xoxKAFKYusdvirdDUX3e5FMjC8efWwkp5x95P8
         w8geJbJ8w62PVZszhph/RXG2ZC0JL7rBsnGnk5gReF8O/FBwuo8QS0dkGhlFuq5UuDUm
         mrcsqYTRPI5G9jen7rN5AUVp3xW42KEapY1TkwcBas74dknseCv/t249Kn9p8vQSQK4c
         okFQJjPtErD7/BhqZap4y1pFTFD5Xd2Ixd6rNVk62D9Tw/M4KKkhAJkrs09rBtyflsQs
         Ll2Q==
X-Gm-Message-State: AO0yUKX29uGgBe/6TJyjWsdrX4jgR278fkOVGMOALR25nJh3JpauVXP5
        t6DK2mI3Wl1dG4fmXt+R45gkRidg3g==
X-Google-Smtp-Source: AK7set/8adr9Nmz1qqVvBS9AERl/aAB+DC9nYmbW++QIDj62CrSWY86Vln4pqsTCGj0Mir/6WesSzg==
X-Received: by 2002:a05:6214:528b:b0:56e:982c:30 with SMTP id kj11-20020a056214528b00b0056e982c0030mr31996916qvb.16.1677253365172;
        Fri, 24 Feb 2023 07:42:45 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id e26-20020a05620a015a00b0073b399700adsm1276131qkn.3.2023.02.24.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 07:42:44 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 5/5] x86/smpboot: Remove STARTUP_SECONDARY
Date:   Fri, 24 Feb 2023 10:42:35 -0500
Message-Id: <20230224154235.277350-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224154235.277350-1-brgerst@gmail.com>
References: <20230224154235.277350-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All CPUs now use the same setup path.  Remove STARTUP_SECONDARY and
renumber the remaining flags.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/smp.h | 5 ++---
 arch/x86/kernel/head_64.S  | 5 ++---
 arch/x86/kernel/smpboot.c  | 6 +++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b4b29e052b6e..97a36d029b0e 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -202,8 +202,7 @@ extern unsigned int smpboot_control;
 #endif /* !__ASSEMBLY__ */
 
 /* Control bits for startup_64 */
-#define STARTUP_SECONDARY	0x80000000
-#define STARTUP_APICID_CPUID_0B	0x40000000
-#define STARTUP_APICID_CPUID_01	0x20000000
+#define STARTUP_APICID_CPUID_0B	0x80000000
+#define STARTUP_APICID_CPUID_01	0x40000000
 
 #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 8bd29ab523dd..f629bf74217b 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -240,9 +240,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * used to look up the CPU number.  For booting a single CPU, the
 	 * CPU number is encoded in smpboot_control.
 	 *
-	 * Bit 31	STARTUP_SECONDARY flag (checked above)
-	 * Bit 30	STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
-	 * Bit 29	STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
+	 * Bit 31	STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
+	 * Bit 30	STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
 	 * Bit 0-24	CPU# if STARTUP_APICID_CPUID_xx flags are not set
 	 */
 	movl	smpboot_control(%rip), %ecx
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1a2843c2841..c159a5c2df9f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1140,7 +1140,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 		initial_stack  = idle->thread.sp;
 	} else if (!do_parallel_bringup) {
-		smpboot_control = STARTUP_SECONDARY | cpu;
+		smpboot_control = cpu;
 	}
 
 	/* Enable the espfix hack for this CPU */
@@ -1580,7 +1580,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		 */
 		if (eax) {
 			pr_debug("Using CPUID 0xb for parallel CPU startup\n");
-			smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_0B;
+			smpboot_control = STARTUP_APICID_CPUID_0B;
 		} else {
 			pr_info("Disabling parallel bringup because CPUID 0xb looks untrustworthy\n");
 			do_parallel_bringup = false;
@@ -1588,7 +1588,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	} else if (do_parallel_bringup) {
 		/* Without X2APIC, what's in CPUID 0x01 should suffice. */
 		pr_debug("Using CPUID 0x1 for parallel CPU startup\n");
-		smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_01;
+		smpboot_control = STARTUP_APICID_CPUID_01;
 	}
 
 	if (do_parallel_bringup) {
-- 
2.39.2

