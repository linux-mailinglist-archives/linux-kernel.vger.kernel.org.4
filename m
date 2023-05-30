Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77E715419
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjE3C7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3C7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:59:37 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A88B0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:59:31 -0700 (PDT)
X-ASG-Debug-ID: 1685415561-086e23313601ed0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id 0rZJ12bGafuGpPNd (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 30 May 2023 10:59:21 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 30 May
 2023 10:59:21 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 30 May
 2023 10:59:19 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <terry.bowman@amd.com>, <bp@alien8.de>, <feng.tang@intel.com>,
        <TonyWWang-oc@zhaoxin.com>, <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH] tools/x86/kcpuid: Add extended CPUID leaf 0xc0000001 support
Date:   Tue, 30 May 2023 10:59:22 +0800
X-ASG-Orig-Subj: [PATCH] tools/x86/kcpuid: Add extended CPUID leaf 0xc0000001 support
Message-ID: <20230530025922.4801-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1685415561
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5834
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.109363
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

CPUID leaf 0xc0000001 EDX bit2/3/6-13 are used by VIA/Cyrix/
Centaur to defined CPU features.

Zhaoxin use CPUID leaf 0xc0000001 EDX as:
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 0]  SM2
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 1]  SM2_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 4]  SM3 SM4
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 5]  SM3_EN SM4_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 16] PARALLAX
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 17] PARALLAX_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 20] TM3
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 21] TM3_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 22] RNG2
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 23] RNG2_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 25] PHE2
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 26] PHE2_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 27] RSA
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 28] RSA_EN

SM2/SM3/SM4 imply the instructions support for Chinese cipher security
algorithm generations 2/3/4.
PARALLAX is the feature of Zhaoxin CPU that automatically adjusts
processors's voltage as a function of temperature.
TM3 is the abbreviation of Thermal Monitor version 3.
RNG2 is the abbreviation of Random Number Generation version 2.
PHE2 is the abbreviation of Padlock Hash Engine version 2.
RSA implies Zhaoxin hardware support for RSA algorithm.

This tool support extended CPUID leaf range: [0x80000000...], add
extended CPUID leaf 0xc0000001 support too.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 tools/arch/x86/kcpuid/cpuid.csv | 25 +++++++++++++++++++++++++
 tools/arch/x86/kcpuid/kcpuid.c  | 19 +++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index e0c25b75327e..3725f69c404e 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -449,3 +449,28 @@
 0x8000001F,	0, EBX,   11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
 0x8000001F,	0, ECX,   31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
 0x8000001F,	0, EDX,   31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
+
+# Leaf C0000001
+# VIA/Cyrix/Centaur/Zhaoxin-defined Extended CPU features
+0xC0000001,	0, EDX,     0, sm2,	SM2 instructions present
+0xC0000001,	0, EDX,     1, sm2_en,	SM2 enabled
+0xC0000001,	0, EDX,     2, rng,	RNG (Random Number Generator) present (xstore)
+0xC0000001,	0, EDX,     3, rng_en,	RNG enabled
+0xC0000001,	0, EDX,     4, sm3_sm4,	CCS (Chinese Cipher Security) sm3 sm4 present
+0xC0000001,	0, EDX,     5, sm3_sm4_en,	SM3 SM4 enabled
+0xC0000001,	0, EDX,     6, ace,	ACE (Advanced Cryptography Engine) crypto (xcrypt) present
+0xC0000001,	0, EDX,     7, ace_en,	ACE enabled
+0xC0000001,	0, EDX,     8, ace2,	ACE engine V2 present
+0xC0000001,	0, EDX,     9, ace2_en,	ACE V2 enabled
+0xC0000001,	0, EDX,    10, phe,	PHE (PadLock Hash Engine) present
+0xC0000001,	0, EDX,    11, phe_en,	PHE enabled
+0xC0000001,	0, EDX,    12, pmm,	PMM (PadLock Montgomery Multiplier) present
+0xC0000001,	0, EDX,    13, pmm_en,	PMM enabled
+0xC0000001,	0, EDX,    16, parallax, Parallax auto adjust processor voltage present
+0xC0000001,	0, EDX,    17, parallax_en, Parallax enabled
+0xC0000001,	0, EDX,    20, tm3,	Thermal Monitor V3 present
+0xC0000001,	0, EDX,    21, tm3_en,	TM V3 enabled
+0xC0000001,	0, EDX,    25, phe2,	PHE V2 SHA384/SHA512 present
+0xC0000001,	0, EDX,    26, phe2_en,	PHE V2 enabled
+0xC0000001,	0, EDX,    27, rsa,	RSA XMODEXP/MONTMUL2 instructions present
+0xC0000001,	0, EDX,    28, rsa_en,	RSA enabled
diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 24b7d017ec2c..94d3ec1a25c9 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -73,8 +73,9 @@ struct cpuid_range {
 /*
  * basic:  basic functions range: [0... ]
  * ext:    extended functions range: [0x80000000... ]
+ * ext1:   extended functions range: [0xc0000000... ]
  */
-struct cpuid_range *leafs_basic, *leafs_ext;
+struct cpuid_range *leafs_basic, *leafs_ext, *leafs_ext1;
 
 static int num_leafs;
 static bool is_amd;
@@ -334,12 +335,14 @@ static int parse_line(char *line)
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
 
-	if (index & 0x80000000)
+	if ((index >> 28) == 0x8)
 		range = leafs_ext;
+	else if ((index >> 28) == 0xC)
+		range = leafs_ext1;
 	else
 		range = leafs_basic;
 
-	index &= 0x7FFFFFFF;
+	index &= 0x0FFFFFFF;
 	/* Skip line parsing for non-existing indexes */
 	if ((int)index >= range->nr)
 		return -1;
@@ -519,7 +522,12 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	struct cpuid_range *range;
 	u32 func_idx;
 
-	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
+	if ((index >> 28) == 0x8)
+		range = leafs_ext;
+	else if ((index >> 28) == 0xC)
+		range = leafs_ext1;
+	else
+		range = leafs_basic;
 	func_idx = index & 0xffff;
 
 	if ((func_idx + 1) > (u32)range->nr) {
@@ -537,6 +545,7 @@ static void show_info(void)
 		/* Show all of the raw output of 'cpuid' instr */
 		raw_dump_range(leafs_basic);
 		raw_dump_range(leafs_ext);
+		raw_dump_range(leafs_ext1);
 		return;
 	}
 
@@ -565,6 +574,7 @@ static void show_info(void)
 	printf("CPU features:\n=============\n\n");
 	show_range(leafs_basic);
 	show_range(leafs_ext);
+	show_range(leafs_ext1);
 }
 
 static void setup_platform_cpuid(void)
@@ -582,6 +592,7 @@ static void setup_platform_cpuid(void)
 	/* Setup leafs for the basic and extended range */
 	leafs_basic = setup_cpuid_range(0x0);
 	leafs_ext = setup_cpuid_range(0x80000000);
+	leafs_ext1 = setup_cpuid_range(0xC0000000);
 }
 
 static void usage(void)
-- 
2.17.1

