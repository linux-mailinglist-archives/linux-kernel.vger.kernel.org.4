Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2E73367F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbjFPQt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345382AbjFPQtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:49:45 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACFC3599
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:49:40 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-311183ef595so687344f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934179; x=1689526179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uhzZuJe360nFGAcunJNwjhI8gCVocTqioPQqrIFFiQ=;
        b=DsLgA1fLkx4QAIY4ds8anmyBbyqUPAskgnvF85pgrxBkZc4j4bdAt4Q3+SREdOtgfl
         wF0g5M0KRmcBwUwJ8HWr4048uT6AoPmRrVUqgTixwK9Dz00A0ts2Ecn3bKMslAMt/IAL
         UxTIqCex5kzN0SbwORwyx+mXO/LJaSCoOziRPt7yJGn6E6nWY0bddJLQSWbgpzkGsPiD
         jiEac83CDUVbvXrqS340shJ5IVVt8EkEsUUi7lB/jNNpvenvk3ezQMTI9KjDfi2q7P1O
         9DAaXLy/I30up2bf1rhp9TR0WTUZDOJcPGyIIG0r/bztCxCTs8czW4M4H1lYcOA30cuw
         SDAw==
X-Gm-Message-State: AC+VfDxzIIHqKDoFwVQTysIXW0ECIF2m19imqGx5Z8s3lWaMIypDaTUR
        CF++f6J6eZSk/6dm1ocq0cs=
X-Google-Smtp-Source: ACHHUZ7nSX1DziSv47VUmpy7d9dJJlRYkRRezh9hhMtxnPr6pAciww+ES3f3LduDaKH+kUECLJB3vg==
X-Received: by 2002:adf:d0c8:0:b0:2ee:f77f:3d02 with SMTP id z8-20020adfd0c8000000b002eef77f3d02mr1756166wrh.0.1686934178869;
        Fri, 16 Jun 2023 09:49:38 -0700 (PDT)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b002c71b4d476asm24041377wrv.106.2023.06.16.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 09:49:38 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@fb.com,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v2] x86/bugs: Break down mitigations configurations
Date:   Fri, 16 Jun 2023 09:48:50 -0700
Message-Id: <20230616164851.2559415-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to disable MDS, TAA, MMIO Stale data mitigation today at
compilation time. These mitigations are enabled even if
CONFIG_SPECULATION_MITIGATIONS is unset.

Create a new KCONFIG option for each mitigation under
CONFIG_SPECULATION_MITIGATIONS that allows these
mitigations to be disabled by default at compilation time.

It is still possible to enable these mitigations by passing kernel
parameters, even if they are disabled by default.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
V1->V2: Change the default value of the global mitigation flag, other
	than disabling at the function itself, so, it could be
	re-enabled/overwritten if a parameter is passed.

---
 arch/x86/Kconfig           | 31 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..ba64f7c9b08d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2649,6 +2649,37 @@ config SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
+config MITIGATE_MDS
+	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
+	depends on CPU_SUP_INTEL && X86_64
+	default y
+	help
+	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
+	  a hardware vulnerability which allows unprivileged speculative access
+	  to data which is available in various CPU internal buffer. Deeper
+	  technical information is available in the MDS specific x86 architecture
+	  section: Documentation/arch/x86/mds.rst.
+
+config MITIGATE_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL && X86_64
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+
+config MITIGATE_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL && X86_64
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 182af64387d0..ba653830796f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -267,7 +267,11 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_MDS)
 static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+#else
+static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_OFF;
+#endif
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -327,7 +331,11 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_TAA)
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+#else
+static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_OFF;
+#endif
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -428,7 +436,11 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
+#if IS_ENABLED(CONFIG_MITIGATE_MMIO_STALE_DATA)
 static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+#else
+static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_OFF;
+#endif
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
-- 
2.34.1

