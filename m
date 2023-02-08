Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13368E521
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 01:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBHArU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 19:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHArS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:47:18 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EB91A962
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 16:47:16 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 512E92C0230;
        Wed,  8 Feb 2023 13:47:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1675817234;
        bh=sxrkqoBA46MSiyRhqLrsgt4m4xQTJR1RSEA2G8k/b/s=;
        h=From:To:Cc:Subject:Date:From;
        b=bkErCex/Q0whceHXgu8f04WKhw1bqp5j/7HlmcxgZ+43d0gnVZXlHaNfxecJ1DhpC
         uPkSBbIthDULSYIXllvHghWozI1NFNd9vq3V11sCToZ8H6/pPYx3fJBvTQNrfPDZMV
         t7JeUjbfTnCp9MYVZ3oPgoiryS9H2semDqHPwNemdVm99fwc+K4xI68LBYPXDXape6
         HyXhdCWf1bmDueNEvsiSo+++ISDYhI8LYyz002RlqFjQml8mNLLACXoIGRZWzAJrcF
         XlHxVDgHKVu7nNgeuVLon5mulr9nqZbc6CynhZLZsp1jez6MIZmmTq4CTqmmzhp7wx
         eJJIp7hgpqrLg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63e2f1120000>; Wed, 08 Feb 2023 13:47:14 +1300
Received: from joshuas-dl.ws.atlnz.lc (joshuas-dl.ws.atlnz.lc [10.33.25.20])
        by pat.atlnz.lc (Postfix) with ESMTP id 2B01113ED4A;
        Wed,  8 Feb 2023 13:47:14 +1300 (NZDT)
Received: by joshuas-dl.ws.atlnz.lc (Postfix, from userid 1634)
        id 27FFF363723; Wed,  8 Feb 2023 13:47:14 +1300 (NZDT)
From:   Joshua Scott <joshua.scott@alliedtelesis.co.nz>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Joshua Scott <joshua.scott@alliedtelesis.co.nz>
Subject: [PATCH] x86/cpu/amd: Work-around for family 17h models 00h-0fh erratum 1019
Date:   Wed,  8 Feb 2023 13:47:01 +1300
Message-Id: <20230208004701.438-1-joshua.scott@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=a6lOCnaF c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=m04uMKEZRckA:10 a=9QTkX_AFq_kQv4ssNCAA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata 1019 can result in a false-positive micro-op queue parity error,
which could result in a system reset.

Set the appropriate mask bit to disable detection of the affected error.

Signed-off-by: Joshua Scott <joshua.scott@alliedtelesis.co.nz>
---
 arch/x86/include/asm/msr-index.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
index d3fe82c5d6b6..3c8b95829838 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -527,6 +527,8 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_DE_MC_CTRL_MASK	0xc0010403
+#define MSR_AMD64_DE_MC_CTRL_MASK_UOPQ_BIT	 3
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f769d6d08b43..c329be80930f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -29,6 +29,7 @@
=20
 static const int amd_erratum_383[];
 static const int amd_erratum_400[];
+static const int amd_erratum_1019[];
 static const int amd_erratum_1054[];
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erra=
tum);
=20
@@ -995,6 +996,13 @@ static void init_amd(struct cpuinfo_x86 *c)
 	    !cpu_has_amd_erratum(c, amd_erratum_1054))
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
=20
+	/*
+	 *  Turn off detection of micro-op queue parity errors on
+	 *  machines susceptible to erratum #1019.
+	 */
+	if (cpu_has_amd_erratum(c, amd_erratum_1019))
+		msr_set_bit(MSR_AMD64_DE_MC_CTRL_MASK, MSR_AMD64_DE_MC_CTRL_MASK_UOPQ_=
BIT);
+
 	check_null_seg_clears_base(c);
 }
=20
@@ -1123,6 +1131,10 @@ static const int amd_erratum_400[] =3D
 static const int amd_erratum_383[] =3D
 	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
=20
+/* #1019: A Thread May Spuriously Report a Micro-Op Queue Parity Error *=
/
+static const int amd_erratum_1019[] =3D
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x0f, 0xf));
+
 /* #1054: Instructions Retired Performance Counter May Be Inaccurate */
 static const int amd_erratum_1054[] =3D
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
--=20
2.39.1

