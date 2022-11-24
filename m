Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E06376C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKXKrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKXKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:47:03 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5114F9F3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:47:02 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id bj12so3206369ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOCeRbpoEibDw8trfgXnocJq/MAqJBN4CTGMZxhpixQ=;
        b=YWEjm0ODQL33o4hiCzXihF9SPErgV2X+LRC719qWE/NEacZXgLXRqEjcsfS91O4Yb4
         IoFB5XA1TAObzkHtcqYNsi3zlz4lwAueHbKOFcqas4TnYR2vstB8r4Z4TYI60qtNXumR
         0vQXjiJDheXVwITKaxWgN9oPkG5gy61aYCLt7o9mGYAVOR70cC50i6p1lVNX0McfPP/+
         PWMUnCBRwWQ/oFQ++ayoG83rZHHHfPAHST9HV1t2ee+xhAYXg7aKUYKovEfokGAPOL5u
         2brTXuDaSUFNiN82N+/90xAFWZYszBy6+nJQVo9E38uFNWMmDHnSiSmWmzHdS/95Eu8p
         rdpw==
X-Gm-Message-State: ANoB5pkhUiP+qSiF1vDrlK+qpwEuh5H/iE7GcuYurdHrVSKJXvGYsS+x
        F7l0AmKIc6oPH3wj3kzodNU=
X-Google-Smtp-Source: AA0mqf5bLmfxHjwrpYUSwp1q5H+TjWBAR+hJPToV2Q8wyT/E0SCsJfTpz0QDg31YJ4kC1m1A0dtfaQ==
X-Received: by 2002:a17:906:1b48:b0:78d:a136:732b with SMTP id p8-20020a1709061b4800b0078da136732bmr12033426ejg.135.1669286820516;
        Thu, 24 Nov 2022 02:47:00 -0800 (PST)
Received: from localhost (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id o17-20020a17090637d100b007aece68483csm278722ejc.193.2022.11.24.02.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:46:59 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
        peterz@infradead.org, pawan.kumar.gupta@linux.intel.com
Cc:     x86@kernel.org, cascardo@canonical.com, leit@meta.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Date:   Thu, 24 Nov 2022 02:46:50 -0800
Message-Id: <20221124104650.533427-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

This patch also defines a SPEC_CTRL_MASK macro, so, we can easily track
and clear if eventually some new mitigation shows up.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/include/asm/msr-index.h | 3 +++
 arch/x86/kernel/cpu/bugs.c       | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4a2af82553e4..704f49580ee1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -54,6 +54,9 @@
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
 
+#define SPEC_CTRL_MASK			(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
+							| SPEC_CTRL_RRSBA_DIS_S)
+
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..88957da1029b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -137,8 +137,15 @@ void __init check_bugs(void)
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
 	 * init code as it is not enumerated and depends on the family.
 	 */
-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		/*
+		 * Previously running software may have some controls turned ON.
+		 * Clear them and let kernel decide which controls to use.
+		 */
+		x86_spec_ctrl_base &= ~SPEC_CTRL_MASK;
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+	}
 
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
-- 
2.30.2

