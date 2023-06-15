Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6E731E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjFOQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjFOQpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:45:00 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F53590
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:37 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b4470e1500so12167911fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847476; x=1689439476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LSIDuAzGUjwULNEFFLWoff2MIu4uiigVl6eBKjinCo=;
        b=CPAnbxpwtfqlBayL9sHpYGgnC+f7w+Vj7Q3286vJdWis0ZeWkObFo9tgWBlFKuwblV
         M8IiwwkPQBcPXwJ3LZElvpco29ASkJo5om5TT+VMJwOqpAmPkzwvzRN8miLFRFmbAEdi
         dpowGxLm6i/fBrxA3b9M9s6g8t1AWuCGWXjyjyO85jCz8qRJwOpj1IlREFcB3lc0gM36
         Grzt3+6Dtcv8e2dPKOHDFYMSZouR/T0zU0h+S1VYi4cid+kiA0MszqszJG038nkR2nWg
         S5aARFN/Lm52iK81dLRUAqb9B8siWMaMbBdmK0QVDksbPXUdoRBJjMIQYORbNEImCXIz
         ng6A==
X-Gm-Message-State: AC+VfDwMBzfrFOp7PQOCOatctZHDpaU/MXT4W4mPxHJEziSGIZ9qLq/5
        Upzp5S+9u1GKCWa+pI0WwSY=
X-Google-Smtp-Source: ACHHUZ4pR9WDwMlm3g3HwOYKuBIeEK8y7RWOY4bSgnAnd5UNBpuROzozma91VhwiCiN8B79aBFE6yg==
X-Received: by 2002:a2e:90cd:0:b0:2ac:8261:5f4b with SMTP id o13-20020a2e90cd000000b002ac82615f4bmr5658ljg.28.1686847476025;
        Thu, 15 Jun 2023 09:44:36 -0700 (PDT)
Received: from localhost (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d4a01000000b003062ad45243sm21533276wrq.14.2023.06.15.09.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:44:35 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     leit@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/speculation: Print error when mitigations are disabled
Date:   Thu, 15 Jun 2023 09:44:17 -0700
Message-Id: <20230615164417.3588162-7-leitao@debian.org>
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

If mitigations are disabled for MDS, TAA, MMIO we want to let users
aware. This is either disabled by "mitigations=off" kernel argument, or,
by CONFIG_SPECULATION_MITIGATIONS=n

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/cpu/bugs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 703649a29181..b678cdd95dc1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -275,6 +275,7 @@ static void x86_amd_ssb_disable(void)
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
 static bool mds_nosmt __ro_after_init = false;
+#define MDS_WARN_MSG "WARNING: Microarchitectural Data Sampling (MDS) speculative mitigation disabled!\n"
 
 static const char * const mds_strings[] = {
 	[MDS_MITIGATION_OFF]	= "Vulnerable",
@@ -284,11 +285,16 @@ static const char * const mds_strings[] = {
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_speculative_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}
 
+	if (cpu_speculative_mitigations_off()) {
+		pr_err(MDS_WARN_MSG);
+		mds_mitigation = MDS_MITIGATION_OFF;
+	}
+
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
@@ -335,6 +341,7 @@ enum taa_mitigations {
 /* Default mitigation for TAA-affected CPUs */
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
 static bool taa_nosmt __ro_after_init;
+#define TAA_WARN_MSG "WARNING: TSX Asynchronous Abort (TAA) speculative mitigation disabled!\n"
 
 static const char * const taa_strings[] = {
 	[TAA_MITIGATION_OFF]		= "Vulnerable",
@@ -359,6 +366,7 @@ static void __init taa_select_mitigation(void)
 	}
 
 	if (cpu_speculative_mitigations_off()) {
+		pr_err(TAA_WARN_MSG);
 		taa_mitigation = TAA_MITIGATION_OFF;
 		return;
 	}
@@ -436,6 +444,7 @@ enum mmio_mitigations {
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
 static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
 static bool mmio_nosmt __ro_after_init = false;
+#define MMIO_WARN_MSG "WARNING: MMIO Stale Data speculative mitigation disabled!\n"
 
 static const char * const mmio_strings[] = {
 	[MMIO_MITIGATION_OFF]		= "Vulnerable",
@@ -448,12 +457,16 @@ static void __init mmio_select_mitigation(void)
 	u64 ia32_cap;
 
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
-	     cpu_speculative_mitigations_off()) {
+	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN)) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
 
+	if (cpu_speculative_mitigations_off()) {
+		pr_err(MMIO_WARN_MSG);
+		mmio_mitigation = MMIO_MITIGATION_OFF;
+	}
+
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
-- 
2.34.1

