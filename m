Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384DF731E17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjFOQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjFOQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:44:36 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F4130C6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:28 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-30e412a852dso6024947f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847467; x=1689439467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/iaRHbMZknbdlPyOxZE8eGdzil5wkV0A7XuLO8jEos=;
        b=e19iUv80fm9DHni/on1OhVwGrsi36TWIKh3BdUodXdtJRIqR5uTOVColyzZw23E46l
         H7vZyfteDVCh4PWoRIN6GB6F8gjWV+3xkJbJLJHVORYyTGi+RjJpRkCfTl2L346U+eWB
         jBFNHt3Yl1NyiyRO6ULLe6DfS3fQAH3ZNxgLcmJejJK3KRqEpwH2IPFDSI3PN0NQTCNG
         xAGsyZJA3keMYoGZbzn3p9f9uAQI55ROds5KXT7GrYateTi4huXWXdWwuBVK30U4ycYD
         mz7cO7323IgsxAAwBlg5SyNxfU2qC5sCyeB2P6Y1TqN/shhZucokHwZFRMtEzTkx3dh8
         QrtA==
X-Gm-Message-State: AC+VfDyHJvMPeRqw+x5gpIGUfNKvb7kGBW2j21U0zLfM8cx/MpNS3vhR
        3CotD+L9fVemd1Nfwe9NRdN7GAIyMWs=
X-Google-Smtp-Source: ACHHUZ4Tf3U78NbDvBaXcy6pNpUoCEg1zhXEIHFBt0r8wCtMdvb9HiNSl0VLtsWo59p+6m3X7D1VUw==
X-Received: by 2002:a5d:4cc1:0:b0:30f:c142:5330 with SMTP id c1-20020a5d4cc1000000b0030fc1425330mr7815963wrt.27.1686847467003;
        Thu, 15 Jun 2023 09:44:27 -0700 (PDT)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0030f9c3219aasm19257509wrt.47.2023.06.15.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:44:26 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     leit@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/bugs: Create an option to disable MDS
Date:   Thu, 15 Jun 2023 09:44:12 -0700
Message-Id: <20230615164417.3588162-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615164417.3588162-1-leitao@debian.org>
References: <20230615164417.3588162-1-leitao@debian.org>
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

There is no way to disable MDS mitigation today at compilation time. MDS
is enabled even if CONFIG_SPECULATION_MITIGATIONS is unset.

Create a new KCONFIG option that allow MDS mitigations to be disabled in
compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 11 +++++++++++
 arch/x86/kernel/cpu/bugs.c |  9 ++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..d25132b2d54f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2649,6 +2649,17 @@ config SLS
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
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 182af64387d0..50f12829dce9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -269,6 +269,7 @@ static void x86_amd_ssb_disable(void)
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
 static bool mds_nosmt __ro_after_init = false;
+#define MDS_WARN_MSG "WARNING: Microarchitectural Data Sampling (MDS) speculative mitigation disabled!\n"
 
 static const char * const mds_strings[] = {
 	[MDS_MITIGATION_OFF]	= "Vulnerable",
@@ -278,11 +279,17 @@ static const char * const mds_strings[] = {
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}
 
+	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATE_MDS)) {
+		mds_mitigation = MDS_MITIGATION_OFF;
+		pr_err(MDS_WARN_MSG);
+		return;
+	}
+
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
-- 
2.34.1

