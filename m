Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C863ACAD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiK1Pc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiK1Pc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:32:29 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6CD108
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:31:59 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id m19so14693509edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOSg/B4UTmp4btrP74NZ2/GqvQw24Sg6iyetxuaSaXI=;
        b=o4vzGZa3gADNsViK9LouO6GPOPq52ZFT90BhOjQkCWfGxS4JnG7xm7+hwgBAnlcdK4
         kLesKeeLoU4FWOrGmS+6Z2fdFo3ps8E3hkbd6iikd2wMcHfrV0yAB47LENogJiL50mt6
         YIiNVP8KEOUaSWOj/n6YXVqfIfjRNioWZuhywB7hXSBgx0I7e7BhP1frR2wJBMaLW4aj
         IMVrKURVC3h/+07jQSfwofQcPyJxNtsWIST0PeVHzZc5z8sXjdIRjigBsFUzkY7SMrjU
         jsvQIdkfSm5g6c6kfgAFn+kwwTREluCin76s7HQdoUBb0yhOz5qL9bG/I3UDgC6OGS7e
         aJpg==
X-Gm-Message-State: ANoB5pmZN1knCwZ+wz+vgfqW7hqOHcs14Z1iNLF2cWLeERn9oNqjwXlJ
        tZwZ8t9//JImcWjCjccBjDw=
X-Google-Smtp-Source: AA0mqf41mPmyAcB6kVIXc9HRpogBe3v8wlDWWI+1QVvhDCgq2IB1HitMlL1Xfd+FXtv/hHKgAIyskA==
X-Received: by 2002:a05:6402:5406:b0:467:4b3d:f2ed with SMTP id ev6-20020a056402540600b004674b3df2edmr30871045edb.101.1669649518027;
        Mon, 28 Nov 2022 07:31:58 -0800 (PST)
Received: from localhost (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906538900b0073de0506745sm4429682ejo.197.2022.11.28.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:31:57 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
        peterz@infradead.org
Cc:     x86@kernel.org, cascardo@canonical.com, leit@meta.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v3] x86/bugs: Explicitly clear speculative MSR bits
Date:   Mon, 28 Nov 2022 07:31:48 -0800
Message-Id: <20221128153148.1129350-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently x86_spec_ctrl_base is read at boot time, and speculative bits
are set if configs are enable, such as MSR[SPEC_CTRL_IBRS] is enabled if
CONFIG_CPU_IBRS_ENTRY is configured. These MSR bits are not cleared if
the mitigations are disabled.

This is a problem when kexec-ing a kernel that has the mitigation
disabled, from a kernel that has the mitigation enabled. In this case,
the MSR bits are carried forward and not cleared at the boot of the new
kernel. This might have some performance degradation that is hard to
find.

This problem does not happen if the machine is (hard) rebooted, because
the bit will be cleared by default.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/include/asm/msr-index.h |  4 ++++
 arch/x86/kernel/cpu/bugs.c       | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4a2af82553e4..22986a8f18bc 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -54,6 +54,10 @@
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
 
+/* A mask for bits which the kernel toggles when controlling mitigations */
+#define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
+							| SPEC_CTRL_RRSBA_DIS_S)
+
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..4030358216c8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -137,8 +137,16 @@ void __init check_bugs(void)
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
 	 * init code as it is not enumerated and depends on the family.
 	 */
-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		/*
+		 * Previously running software, like kexec for example, may
+		 * have some controls turned ON.
+		 * Clear them and let the mitigations setup below set them
+		 * based on configuration.
+		 */
+		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
+	}
 
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
-- 
2.30.2

