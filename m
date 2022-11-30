Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6FE63E592
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiK3XhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiK3Xg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:36:58 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6055102F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:36:57 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mh8-20020a17090b4ac800b0021348e084a0so3837849pjb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ac7XTrKyealJvttnej4gqUHiXpbMGi2BgXlQ8TSBek=;
        b=YklaFhYbAovNTKW/H+xKi4bkAw0j+BumngcZB3OlflQPR0hl5TLLW/d3npxDohI8NT
         VgcAbLoHTd44LVdVzGM3yxudxW2ho3QXdF+/SGcfBR0PdrsCn8xQkMDcpYZUOITiq3tm
         ejsfEgqpx0zgTMo0usF5nLH8vXSTbwryscEhsVb1IFTPrKoVppmft3n5n1r9sAeZDxaz
         j5BwvQOzX8Zx2dBw2LVdlOwa6/MDTBkjd39lP3EsJd6aSHUTLgpXDwH+jKqnM1j2M1Io
         Unm/D0mL5mkskraYkuzDrFZIqViANCMp/8MAezMKZeOLngNa+ZVA48UX7PdCIqBwSMBB
         6yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ac7XTrKyealJvttnej4gqUHiXpbMGi2BgXlQ8TSBek=;
        b=l14x3hv2G7lPX/BlDu5A6DpjZbrO540rju1RPbDeVs8OSQQibUQNpg4YWn5eFMmuCM
         Sx5dxrlPvo71iNTGEGzL0yrYF7nk+84tWABL5nwzKYhSUBCh/kCP1ZL9Y3Go21Sq02Yx
         UhR4LU2SWr/kqdrSz9u0hzAquYrDoaLPcyxHiuY9E3x4qL71dkeY11ZBbJIWjd7CFviJ
         +SzQyCjDgm6M7WDa8rBYDnmHGratiWAxWtuX341tw2tVyxu2KeFhE5fqmDuN9EXAaSiH
         4XqNPZ+8A9SIj8P+uyMnZWWXBK0hwP31n1DaDzDhOJ+pwUGPuuMwft9J0lLXFLLFAXjt
         QxiQ==
X-Gm-Message-State: ANoB5pn6PhRbqydr+1vXmPlheXcJoSJPCCQT+YN8j55UCwvJpx0gouhP
        qPpWX+6siiB+fhJ3rPXCV8oju8pqqMI=
X-Google-Smtp-Source: AA0mqf7O2+RC3iulookuc0UqIvdRSsr8CeX5htydeb2IqKZvPiNaaLfq01QOUjTegMhduBkiOk5RT6c56N0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:ea18:0:b0:56c:2d:1e56 with SMTP id
 t24-20020a62ea18000000b0056c002d1e56mr45222870pfh.41.1669851417445; Wed, 30
 Nov 2022 15:36:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:36:49 +0000
In-Reply-To: <20221130233650.1404148-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130233650.1404148-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130233650.1404148-4-seanjc@google.com>
Subject: [PATCH v4 3/4] x86/reboot: Disable virtualization in an emergency if
 SVM is supported
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable SVM on all CPUs via NMI shootdown during an emergency reboot.
Like VMX, SVM can block INIT, e.g. if the emergency reboot is triggered
between CLGI and STGI, and thus can prevent bringing up other CPUs via
INIT-SIPI-SIPI.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 374c14b3a9bf..d03c551defcc 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -530,27 +530,26 @@ static inline void kb_wait(void)
 
 static inline void nmi_shootdown_cpus_on_restart(void);
 
-/* Use NMIs as IPIs to tell all CPUs to disable virtualization */
-static void emergency_vmx_disable_all(void)
+static void emergency_reboot_disable_virtualization(void)
 {
 	/* Just make sure we won't change CPUs while doing this */
 	local_irq_disable();
 
 	/*
-	 * Disable VMX on all CPUs before rebooting, otherwise we risk hanging
-	 * the machine, because the CPU blocks INIT when it's in VMX root.
+	 * Disable virtualization on all CPUs before rebooting to avoid hanging
+	 * the system, as VMX and SVM block INIT when running in the host.
 	 *
 	 * We can't take any locks and we may be on an inconsistent state, so
-	 * use NMIs as IPIs to tell the other CPUs to exit VMX root and halt.
+	 * use NMIs as IPIs to tell the other CPUs to disable VMX/SVM and halt.
 	 *
-	 * Do the NMI shootdown even if VMX if off on _this_ CPU, as that
-	 * doesn't prevent a different CPU from being in VMX root operation.
+	 * Do the NMI shootdown even if virtualization is off on _this_ CPU, as
+	 * other CPUs may have virtualization enabled.
 	 */
-	if (cpu_has_vmx()) {
-		/* Safely force _this_ CPU out of VMX root operation. */
-		__cpu_emergency_vmxoff();
+	if (cpu_has_vmx() || cpu_has_svm(NULL)) {
+		/* Safely force _this_ CPU out of VMX/SVM operation. */
+		cpu_emergency_disable_virtualization();
 
-		/* Halt and exit VMX root operation on the other CPUs. */
+		/* Disable VMX/SVM and halt on other CPUs. */
 		nmi_shootdown_cpus_on_restart();
 	}
 }
@@ -587,7 +586,7 @@ static void native_machine_emergency_restart(void)
 	unsigned short mode;
 
 	if (reboot_emergency)
-		emergency_vmx_disable_all();
+		emergency_reboot_disable_virtualization();
 
 	tboot_shutdown(TB_SHUTDOWN_REBOOT);
 
-- 
2.38.1.584.g0f3c55d4c2-goog

