Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063406E2056
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDNKLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDNKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:10:54 -0400
X-Greylist: delayed 988 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Apr 2023 03:10:37 PDT
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF44198D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:10:37 -0700 (PDT)
X-ASG-Debug-ID: 1681466044-086e237e53010c0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id 2oyFb70X5fSWHZgr (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 14 Apr 2023 17:54:04 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 14 Apr
 2023 17:54:04 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 14 Apr
 2023 17:54:02 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <pbonzini@redhat.com>, <kim.phillips@amd.com>,
        <babu.moger@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
        <TonyWWang-oc@zhaoxin.com>, <sandipan.das@amd.com>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH] x86/cpufeatures: extend CPUID leaf 0xc0000001 support for Zhaoxin
Date:   Fri, 14 Apr 2023 17:53:34 +0800
X-ASG-Orig-Subj: [PATCH] x86/cpufeatures: extend CPUID leaf 0xc0000001 support for Zhaoxin
Message-ID: <20230414095334.8743-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1681466044
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4032
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107399
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

Extend CPUID leaf 0xc0000001 to support SM2, SM3, SM4, PARALLAX, TM3,
RNG2, PHE2, RSA.

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

All these features have two relative CPUID bits, one bit implies the
existence of the feature and the other bit with postfix "EN" implies
the availability of this feature. Eg, SM2 implies Zhaoxin CPU have SM2
algorithm support, SM2_EN implies user can use relative instructions
with SM2 algorithm.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/include/asm/cpufeatures.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d7215c8b7923..98f3ac6ec66d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -145,9 +145,13 @@
 #define X86_FEATURE_RDRAND		( 4*32+30) /* RDRAND instruction */
 #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
 
-/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+/* VIA/Cyrix/Centaur/Zhaoxin-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_SM2			( 5*32+ 0) /* Chinese cipher security hardware support of SM2 */
+#define X86_FEATURE_SM2_EN		( 5*32+ 1) /* SM2 enabled */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
+#define X86_FEATURE_CCS			( 5*32+ 4) /* "sm3 sm4" Chinese cipher security hardware support*/
+#define X86_FEATURE_CCS_EN		( 5*32+ 5) /* "sm3_en sm4_en" sm3 sm4 enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
 #define X86_FEATURE_XCRYPT_EN		( 5*32+ 7) /* "ace_en" on-CPU crypto enabled */
 #define X86_FEATURE_ACE2		( 5*32+ 8) /* Advanced Cryptography Engine v2 */
@@ -156,6 +160,16 @@
 #define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
 #define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier */
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
+#define X86_FEATURE_PARALLAX		( 5*32+16) /* Parallax auto adjust processor voltage */
+#define X86_FEATURE_PARALLAX_EN		( 5*32+17) /* Parallax auto adjust processor voltage enabled */
+#define X86_FEATURE_TM3			( 5*32+20) /* Thermal Monitor v3 support */
+#define X86_FEATURE_TM3_EN		( 5*32+21) /* TM3 enabled */
+#define X86_FEATURE_RNG2		( 5*32+22) /* RNG v2 present */
+#define X86_FEATURE_RNG2_EN		( 5*32+23) /* RNG v2 enabled */
+#define X86_FEATURE_PHE2		( 5*32+25) /* PHE v2 present */
+#define X86_FEATURE_PHE2_EN		( 5*32+26) /* PHE v2 enabled */
+#define X86_FEATURE_RSA			( 5*32+27) /* RSA hardware support */
+#define X86_FEATURE_RSA_EN		( 5*32+28) /* RSA enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* LAHF/SAHF in long mode */
-- 
2.17.1

