Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6E731E18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjFOQp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbjFOQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:44:44 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60C42D75
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:30 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30fc90f359fso3238477f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847469; x=1689439469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDJSQzuktanU2Jg2xVD0F/r0980umpPsJ0j0RWDQ1rg=;
        b=ZqnggpNQElkv8Bi/QjIOp18QIt0ami4HaITF+tfhLAR+5n6Gs6Vi8mFIUsypSpJOge
         uASjsFw3S9D9E8TR1v+lXftx6F+q/bDqFKcIBoHLesIJ73I8NclCbWht2uLm/xCXbENC
         UEwIXQXbyheEtoHD/oJQ35gQzbbrNALWaE4PZnXmjcC0nhpHCX+7ALXvokERcVcp8RnD
         DZToMahPtCi72n50cwxGjfbaq07VCu0oh6JQilwZaKDlm6APRFfoWmpt5g8h7/czFbIF
         QUG3MMq9xys9UgtT4rp5PX2j2Tclqvcd5iCpRbqD5NNrhjavBMo2UQrVphB82CPgHebl
         jzCQ==
X-Gm-Message-State: AC+VfDzrgjyCu2YwULkvoGsfuJAlvb/IwASvdkVJ6uKdR14s7O+KjVNA
        QSDv/PmPg/ZHRpAZsRhZlE8=
X-Google-Smtp-Source: ACHHUZ6MTnd9tDwMGRx7ahXOqi0IkgjY8BrdmE322JxFQy4hyHZc6iJBneVWxvJcemvZc7PGVZNSbg==
X-Received: by 2002:a05:6000:1:b0:30f:bbf1:d195 with SMTP id h1-20020a056000000100b0030fbbf1d195mr9842573wrx.36.1686847468817;
        Thu, 15 Jun 2023 09:44:28 -0700 (PDT)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003095bd71159sm21615015wrz.7.2023.06.15.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:44:28 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     leit@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/bugs: Create an option to disable TAA
Date:   Thu, 15 Jun 2023 09:44:13 -0700
Message-Id: <20230615164417.3588162-3-leitao@debian.org>
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

There is no way to disable TAA mitigation today at compilation time. TAA
is enabled even if CONFIG_SPECULATION_MITIGATIONS is unset.

Create a new KCONFIG option that allow TAA mitigation to be disabled in
compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d25132b2d54f..140af3b30c45 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2660,6 +2660,16 @@ config MITIGATE_MDS
 	  technical information is available in the MDS specific x86 architecture
 	  section: Documentation/arch/x86/mds.rst.
 
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
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 50f12829dce9..3615bda9573f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -336,6 +336,7 @@ enum taa_mitigations {
 /* Default mitigation for TAA-affected CPUs */
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
 static bool taa_nosmt __ro_after_init;
+#define TAA_WARN_MSG "WARNING: TSX Asynchronous Abort (TAA) speculative mitigation disabled!\n"
 
 static const char * const taa_strings[] = {
 	[TAA_MITIGATION_OFF]		= "Vulnerable",
@@ -359,8 +360,9 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off()) {
+	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATE_TAA)) {
 		taa_mitigation = TAA_MITIGATION_OFF;
+		pr_err(TAA_WARN_MSG);
 		return;
 	}
 
-- 
2.34.1

