Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865170C1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjEVPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjEVPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:00:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2913E;
        Mon, 22 May 2023 08:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR4EduzzCXd+3c3E4dVx6jvoPfg0nz070CWRYAjYqI1mJf7+ptaCjZC3E9wl5C7T0/S9+iFXW0dherTIt0TpmhRltCEsZ7LKfPWBEm4wtDRYl1R1cFvqW5cL2u3dah5Z2bfY5n21GIHOlZgFXTyqIBun7xC4vH3u3wORcDQbxFYC2VTPd403Y/dTsAJ7qqeruJxrT9JsBbYm3pkxJo3Uykw8IgGJgBgbm/vRS6k1MuoFQihu1rrgH6dIVzF6nIxNbXjgeL/VmAd7nOzOkfXYNv6J4vlAEb7dPPwenaEcgmf6KuKcpyJKs0uWqpUToFTfAgUUqJjZ3TvrIrkraGq2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5xxkIE+0PsjxjPeqIke+kwynWeRhOGsor6pn9SPPKc=;
 b=ciTh4wuqWIkXUPsvsW9Iu9CIYIrsgiWrbsa2g4vOnSZ/eONaNhSl2sVb0K+Pr5SFziD1qZFa+6brTUuRhN1scBkMRbZs0IUH559aKE6SyJlv4eCwJ/VPcL2dG2l7yM9rllIoU2/J8x5BkrCV/GAwjltbY6iimjIkOTJCvjZKEzh328mA0Dq8HanWUwCnGyQF6Smk6ApYfq34YPY1OeRPhfVWdc09Pjm2T1oUEWFboYeuWFUKUip5bta+ZJis4JjTxuHKPe064nic0XtHqpbHJLMb6sZn0unR6/RVxUtw8+1B9fqrIkK+J82IwPlB34vJ1vLqDvDP6aYUvtWDfkO9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5xxkIE+0PsjxjPeqIke+kwynWeRhOGsor6pn9SPPKc=;
 b=mCSyR5o+CIPDCWaQoaOnGiMudMuf6ek8oQow6egSmdGrJJ77WH3LZMxx/oO6EQiUyCuNb4gFxkxa25yu935ab8qmIfYodHtgb+tYfppqvjebzowhjYCEj99whSR/0ESMETCJ3zKRuSGfJpMmj9bsQNnLtnT5Subixs+ZViOgWT0=
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:00:33 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::6d) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 15:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 15:00:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 10:00:04 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/6] arm64: zynqmp: Fix usb node drive strength and slew rate
Date:   Mon, 22 May 2023 16:59:49 +0200
Message-ID: <379071f44ceb27a0e32d74e13221640922d989d1.1684767562.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1684767562.git.michal.simek@amd.com>
References: <cover.1684767562.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11776; i=michal.simek@amd.com; h=from:subject:message-id; bh=pjfGwPXePTSmdNFAJcJP1UsFe4kDeFZQq1LM3U0sbro=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTs5riEPfovQoO2Z/1iabH6dtJilsefOQlMq9fej374M ryJMWh2RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIrESG2eyhC15oXo2/IROk 9V3KmjFT8eENA4YFLedkdqo77JbTPTdnVpH0Q+vw+vkWAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f3adb9-957a-4990-f6b4-08db5ad54ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nqTgQZmbe0ieHHC0YjtxH6O89QH8Wtrlz4QiQC7S+XW90DnLXt5tB0QDnjyqS/eV7BJrtRtmVgRFgNPApFMsg4f1wuDsp4TKOoXOxj4ZbKdpWlwtYU3h10Z8H695lfTsrX93lyciB07uBZoqqrdfVpMfCLDKNKKmnqXtjOxBKA4pt07VJslJin6yjMuXOqYgclIPPFaX0GOlyPt4VmP0GKglNOng2auZP+fvtfQyS3PSj7NwsjyBLlFGgqdKV26Rm9J/zmfaJ8uAvgKPmsQ9EfWnc3Si/3oVRDwc/NQ8UHqSzJS6kzovJf/9NX3krlupQVq8TJuC6xSmIWd+LM/T1fsdOEi6mhtcwtNarUYay8uAbWsFiGwDwRKZH8PyYGDPg05gMxlvCkVEc7DsVJ57KTrZzXuyfdoaKumjpFa3PeE9mhkx/RMCh07h0hz8DGcdZqXkcSoe7+pW4QUHWJ/6dwobVkvb9IDt0sOKJFy1jo54N8/HxqK2aqkrwTqi1ykDpSIq1E+1DoIIzt5XwgJ29wL5PJcZ44v3o4HR9sfAf8nb6i9pkLrcslH32GTIwZzxL2GrVg3ly9QXQqn8zDCH7By+Tt2Dy3T6oqraQZT3OHtInOJsnK+SxkgltYbUNYuHyhQkLPHU6K/nZlFbGzINHLol1n7HMmT/IGaUaOcHuCNJl/2fjS3dJgU/lhdqbL+HxMeCT0mFXOKOSYb2vG2psKDpKgXrCg2Meh7VA3YodRsGUvyLAzHGbmdNvikXXCy6c4pj6/A0A9XTrQkDjExgjpK9BVsJRNg2c3WntRxRro=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(8676002)(8936002)(7416002)(44832011)(5660300002)(83380400001)(47076005)(36860700001)(186003)(16526019)(2616005)(356005)(26005)(86362001)(336012)(426003)(81166007)(82740400003)(40460700003)(82310400005)(41300700001)(6666004)(40480700001)(478600001)(4326008)(36756003)(70586007)(70206006)(110136005)(316002)(54906003)(2906002)(30864003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:00:33.1100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f3adb9-957a-4990-f6b4-08db5ad54ac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>

As per design, all input/rx pins should have fast slew rate and 12mA
drive strength. Rest all pins should be slow slew rate and 4mA drive
strength. Fix usb nodes as per this and remove setting of slow slew rate
for all the usb group pins.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

c&p more explanation from v1 version.

In design tools all inputs pins are setup like described by default. That's
why it could suggest that there is no need to describe default
configuration in DT. But all MIOs can be used as GPIOs where pinctrl can
change their default values to something else. That's why setting up
default values is to be safe even for input pins. I don't know HW details
to that extend but that values can also change input behavior that's why
having default is not a bad idea.

---
 .../arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso |  8 ++++++--
 .../arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso |  8 ++++++--
 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts     |  8 ++++++--
 .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts     |  8 ++++++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts   | 13 ++++++++++---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts   |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts   |  6 ++++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts   |  6 ++++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts   |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts   |  5 ++++-
 10 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 669fe6084f3f..603839c82599 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -2,7 +2,8 @@
 /*
  * dts file for KV260 revA Carrier Card
  *
- * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2020 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * SD level shifter:
  * "A" - A01 board un-modified (NXP)
@@ -265,19 +266,22 @@ mux {
 	pinctrl_usb0_default: usb0-default {
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 
 		mux {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 7886a19139ee..a91d09e7da4b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -2,7 +2,8 @@
 /*
  * dts file for KV260 revA Carrier Card
  *
- * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2020 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -248,19 +249,22 @@ mux {
 	pinctrl_usb0_default: usb0-default {
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 
 		mux {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 1a7995ee62ce..af3331c133ad 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm015-dc1
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -187,19 +188,22 @@ mux {
 
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			       "MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 869b733a0634..6503f4985f8d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm016-dc2
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -281,19 +282,22 @@ mux {
 
 		conf {
 			groups = "usb1_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO64", "MIO65", "MIO67";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
 			       "MIO72", "MIO73", "MIO74", "MIO75";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 544801814bd5..44d1f351bb75 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU100 revC
  *
- * (C) Copyright 2016 - 2021, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  * Nathalie Chan King Choy
@@ -432,19 +433,22 @@ mux {
 
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			       "MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 
@@ -456,19 +460,22 @@ mux {
 
 		conf {
 			groups = "usb1_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO64", "MIO65", "MIO67";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
 			       "MIO72", "MIO73", "MIO74", "MIO75";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index f36353a51863..a074d8e2b86d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -783,19 +783,22 @@ mux {
 
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			       "MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 3fd47725c2c8..91c9b77f6b1f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -410,20 +410,22 @@ mux {
 
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
-			drive-strength = <12>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			       "MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 4f6429caecff..954044d9899f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -422,20 +422,22 @@ mux {
 
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
-			drive-strength = <12>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			       "MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 8c3fa3fe28d5..ab5e34b43642 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -794,19 +794,22 @@ mux {
 
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			       "MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 0d9b6081dff6..f31365a14f73 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -660,19 +660,22 @@ mux {
 
 		conf {
 			groups = "usb0_0_grp";
-			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 		};
 
 		conf-rx {
 			pins = "MIO52", "MIO53", "MIO55";
 			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 
 		conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			       "MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
 		};
 	};
 
-- 
2.36.1

