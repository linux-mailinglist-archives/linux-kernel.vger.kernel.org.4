Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF266731E19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjFOQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjFOQoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:44:46 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6F830D6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:32 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f8cec6641bso22528605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847471; x=1689439471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnu101MlL/lBc9D51wfUyU127xq92KgSEDJgVIsZ6RU=;
        b=h8T/2GAVKqteALxJJb5540KEV/alCgtQntkyvSBDcvSa3xa5Rg4rmBbLAxqtO3pQjI
         lpGyOnZ7y+78365TIet/IfQSUFd5EvYPiivvc47gvuYWDQkTpi3VIq6Oxn4QbkN7aTo0
         Fv7XTGWtgp7ihZ0RC4qg3cp8brgTFLXVRJsvjinPRUPc7VjcsVu4G+kSOOdwia9rHylk
         6GGHz2tJyVzkSa0Q8ErmoQ0yYF1FAFkItR5bEcS8liPPSVartfCqoHP7vikJExHcKKRH
         sbKmRXAq+QIrpvrlicVaa8P3fFqZGY1/IZEUPkca9z3P6o3z1br3HkmUamAx992mMBPt
         CqlA==
X-Gm-Message-State: AC+VfDxMYpjatdQeHEXNV+gH5mUqy0uJ8ncF5EI0zZgB/0EjKgYCWTAk
        uQlSoa6qKrHYV1bGcb4efL0=
X-Google-Smtp-Source: ACHHUZ6tjv3xr59m+gYz8OVXnm1xmB74cCrv0sXwMg/z6UFWTLrHE2IEMmOXvM6S6QfjlV+oyShcwQ==
X-Received: by 2002:a05:600c:295:b0:3f6:af2:8471 with SMTP id 21-20020a05600c029500b003f60af28471mr14466195wmk.26.1686847470651;
        Thu, 15 Jun 2023 09:44:30 -0700 (PDT)
Received: from localhost (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d4342000000b0030e5c8d55f2sm21453538wrr.6.2023.06.15.09.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:44:29 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     leit@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/bugs: Create an option to disable MMIO vulnerability
Date:   Thu, 15 Jun 2023 09:44:14 -0700
Message-Id: <20230615164417.3588162-4-leitao@debian.org>
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

There is no way to disable MMIO Stale data mitigation today at
compilation time. These mitigations are enabled even if
CONFIG_SPECULATION_MITIGATIONS is unset.

Create a new KCONFIG option that allow MMIO mitigation to be disabled in
compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 140af3b30c45..ba64f7c9b08d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2670,6 +2670,16 @@ config MITIGATE_TAA
 	  which is available in various CPU internal buffers by using
 	  asynchronous aborts within an Intel TSX transactional region.
 
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
index 3615bda9573f..b5c171feb05e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -439,6 +439,7 @@ enum mmio_mitigations {
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
 static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
 static bool mmio_nosmt __ro_after_init = false;
+#define MMIO_WARN_MSG "WARNING: MMIO Stale Data speculative mitigation disabled!\n"
 
 static const char * const mmio_strings[] = {
 	[MMIO_MITIGATION_OFF]		= "Vulnerable",
@@ -451,12 +452,17 @@ static void __init mmio_select_mitigation(void)
 	u64 ia32_cap;
 
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
-	     cpu_mitigations_off()) {
+	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN)) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
 
+	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATE_MDS)) {
+		mmio_mitigation = MMIO_MITIGATION_OFF;
+		pr_err(MMIO_WARN_MSG);
+		return;
+	}
+
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
-- 
2.34.1

