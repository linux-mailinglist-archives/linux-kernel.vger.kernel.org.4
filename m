Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7769F723D88
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbjFFJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjFFJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:32:14 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91D1707
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:31:46 -0700 (PDT)
X-ASG-Debug-ID: 1686043899-086e2331350ced0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id F2MTCRbCrfSBX2iC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 06 Jun 2023 17:31:39 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 6 Jun
 2023 17:31:39 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 6 Jun
 2023 17:31:38 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <TonyWWang-oc@zhaoxin.com>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH] x86/cpu: detect extended topology for Zhaoxin CPUs
Date:   Tue, 6 Jun 2023 17:31:42 +0800
X-ASG-Orig-Subj: [PATCH] x86/cpu: detect extended topology for Zhaoxin CPUs
Message-ID: <20230606093142.2901-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1686043899
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2209
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0001 1.0000 -2.0205
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.109673
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoxin CPUs support extended topology enumeration
CPUID leaf 0xb/0x1f.
Right now the kernel uses the legacy CPUID leaf 0x1/0x4
for topology detection for Zhaoxin CPUs.
So add extended topology detection support for these
Zhaoxin CPUs.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/centaur.c | 11 +++++++++--
 arch/x86/kernel/cpu/zhaoxin.c | 10 ++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 345f7d905db6..627a90f5ef52 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -109,6 +109,9 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
+
+	if (detect_extended_topology_early(c) < 0)
+		detect_ht_early(c);
 }
 
 static void init_centaur(struct cpuinfo_x86 *c)
@@ -127,11 +130,15 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, 0*32+31);
 #endif
 	early_init_centaur(c);
+	detect_extended_topology(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
+
+	if (!cpu_has(c, X86_FEATURE_XTOPOLOGY)) {
+		detect_num_cpu_cores(c);
 #ifdef CONFIG_X86_32
-	detect_ht(c);
+		detect_ht(c);
 #endif
+	}
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 05fa4ef63490..37ad1ceb27a1 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -79,16 +79,22 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
 			c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);
 	}
 
+	if (detect_extended_topology_early(c) < 0)
+		detect_ht_early(c);
 }
 
 static void init_zhaoxin(struct cpuinfo_x86 *c)
 {
 	early_init_zhaoxin(c);
+	detect_extended_topology(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
+
+	if (!cpu_has(c, X86_FEATURE_XTOPOLOGY)) {
+		detect_num_cpu_cores(c);
 #ifdef CONFIG_X86_32
-	detect_ht(c);
+		detect_ht(c);
 #endif
+	}
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
-- 
2.17.1

