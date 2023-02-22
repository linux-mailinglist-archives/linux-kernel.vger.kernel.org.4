Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2F69FE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBVWNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjBVWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:38 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0FA43915
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:20 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w23so9165420qtn.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKnaLUvz03dzH+Nhj/4CLV2CqW7kem3zsIr+xE7cWbY=;
        b=AONcsGL41TxiV4/KM1Lw+I8z3tLBaN6k8vDTCGI67ULKsXkkIpp8kCvU0dB+BdMMJ7
         SW7DoLHR17TNCN/1kaxclzarB29h1EkSJsRHu4P+OuW0cT8nXrY8aSN11AYI5E2lFKy5
         FxbLfKgD7BV409f/JMdV9vV6CpH+VfC/eHyFTtn6fWhPxbOlUa0VkBHI3yr7g6WWbvaI
         1/gusrGcYubP+PhFw68RDc5HbjzhJUTNQHiLg76WjU71ApLE57O1ODFlnpjfy5LE+EEn
         nLRMpbnwI5cs0LQ2F/U5rx4NraeDIFY8ng/Y4Z11duInSTaN9XzsHI1sT+rsdxuj+f1K
         e8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKnaLUvz03dzH+Nhj/4CLV2CqW7kem3zsIr+xE7cWbY=;
        b=m65+zuAEIa/rWL5GmRDf4BB+QY0PP0ManAsJ/YHDdU59QQnvFpFSdljIDz9Nl1MxCI
         KKA7jkYj/WC2g1bdokqeoOxMHToLZSLfifHrnLcI/YkwmcbtqvyunEzWBA9509vL67v8
         NImBRClljaC3eADXBq33vE1te58NEIxVel8ee7NHzZL6m+fDXlpWqMija2DkNBVfcY/v
         S6szTUTGZe9SYdrV23xupySypBMiZPwsqFYYtWy72RoIhUzqxEvZJMAoWjAhU/iqVWKn
         hcCUqhC40B0vHCURCcyIvTS/ffP7i4F5irVYEFWyLaBVOB8208yR01GFRkKJWsKcm0Q4
         ylJw==
X-Gm-Message-State: AO0yUKXWxPXD6auL+VkFxNJ+6LydXJ8UiJv5QR3VTsS89LJZWqtSda7L
        NNl+PECKUbV6Sy3ggnc4uuUtmcs4rg==
X-Google-Smtp-Source: AK7set8x+RkH/L+AxiVbtTj+82I3i49ILT32qjT9hzgsdtOg8ieeGbtootox4fxrFSemgif9Rjmu9A==
X-Received: by 2002:ac8:5fc7:0:b0:3b9:a60f:b2bb with SMTP id k7-20020ac85fc7000000b003b9a60fb2bbmr18333081qta.56.1677103998855;
        Wed, 22 Feb 2023 14:13:18 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id ey17-20020a05622a4c1100b003b86b088755sm4902460qtb.15.2023.02.22.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:13:18 -0800 (PST)
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
Subject: [PATCH 1/6] x86/smpboot: Use CPU number instead of APIC ID for single CPU startup
Date:   Wed, 22 Feb 2023 17:12:56 -0500
Message-Id: <20230222221301.245890-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222221301.245890-1-brgerst@gmail.com>
References: <20230222221301.245890-1-brgerst@gmail.com>
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

Encoding the CPU number directly in smpboot_control skips the APIC ID
lookup when booting a single CPU.  This will enable the boot CPU to use
the same code as secondaries, since the APIC ID array is not populated
during early boot.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/head_64.S | 12 +++++++-----
 arch/x86/kernel/smpboot.c |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0e4e53d231db..c1253aa737ca 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -252,20 +252,22 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	jz	.Lsetup_cpu
 
 	/*
-	 * Secondary CPUs find out the offsets via the APIC ID. For parallel
-	 * boot the APIC ID is retrieved from CPUID, otherwise it's encoded
-	 * in smpboot_control:
+	 * For parallel boot, the APIC ID is retrieved from CPUID, and then
+	 * used to look up the CPU number.  For booting a single CPU, the
+	 * CPU number is encoded in smpboot_control.
+	 *
 	 * Bit 31	STARTUP_SECONDARY flag (checked above)
 	 * Bit 30	STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
 	 * Bit 29	STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
-	 * Bit 0-24	APIC ID if STARTUP_APICID_CPUID_xx flags are not set
+	 * Bit 0-24	CPU# if STARTUP_APICID_CPUID_xx flags are not set
 	 */
 	testl	$STARTUP_APICID_CPUID_0B, %edx
 	jnz	.Luse_cpuid_0b
 	testl	$STARTUP_APICID_CPUID_01, %edx
 	jnz	.Luse_cpuid_01
 	andl	$0x0FFFFFFF, %edx
-	jmp	.Lsetup_AP
+	movl	%edx, %ecx
+	jmp	.Linit_cpu_data
 
 .Luse_cpuid_01:
 	mov	$0x01, %eax
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5b6d72b3d14b..e1a2843c2841 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1140,7 +1140,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 		initial_stack  = idle->thread.sp;
 	} else if (!do_parallel_bringup) {
-		smpboot_control = STARTUP_SECONDARY | apicid;
+		smpboot_control = STARTUP_SECONDARY | cpu;
 	}
 
 	/* Enable the espfix hack for this CPU */
-- 
2.39.2

