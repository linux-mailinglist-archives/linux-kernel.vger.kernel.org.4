Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865246F4510
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjEBNgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjEBNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:36:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9506189;
        Tue,  2 May 2023 06:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP7Hcqk5KvYHluj+QHrXJEoHgq+7c1zOQURbsv5lQyTFmbi99ZWC+oLS18i1dCPyHJdyiCiL2GfL9oArGFu/C3M+7yBXba6P/WVRWe1i2DlbPbIFOj2FZlek+CcDLYBtAAyVfCJpbfolAozQhk57PLKMSUuXG9jNzvzR0X+DEwWcoBLannjTQz1yw8rV+twsjLxXuSdu3KU8dgvyFfcOCBvcHAIdPPpUt//g4Xb36LCVNOqmqhaMMUFFp8uuaZcOmCZphbOfNy2OMehtj041bNojtkoJDZrs9uZHbZJtqPe1qkS4Gh6QWjKs4BezAAp9qDTyBtYkBM+315U8OZk7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCKgly+2Mj9c7q+hcfKNsAD6vcPGA+l76NM3TleD0xE=;
 b=IH61vMXVWBNKR0d1CmT5ke5yOXt07vZ4p0M8VUctt8fuCSdL2kPar7RZHlZovWOX+bJe2N2tC7tmhk/txayrzhaRQOdFGERDaUQwP0nXBpMBDWl3XyvswgFUor+eLV7Otf0sPWzG/ETGa86gYKv1ppM/5l2LrxIVQ9DcqfaCGXbM2t9oHseTLaFRFBdqI2Ug2/+RSIdaGZWQ1B2ILQFzJltT4knu5sw41yJIRkyil0Xfy1rkA6tiWqlvIdcXVLyBPSFT7jO/Dapjr42bidQnBDMwEiqavSbRYhxly/i4HaDOcKJ3aMD7DjOmA4JX8BYKHBTZbI880/rt7gpAMPU0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCKgly+2Mj9c7q+hcfKNsAD6vcPGA+l76NM3TleD0xE=;
 b=QY9W/dxSUEzPPWkbhLkWxD0jG2CjsNLBbwBtv3mENFvY2V0ZavkR/F2Vb7Qexn6jqFkwGi+Arof3qO421BFNpp4i7zY6xeX7GtjTOX0Hb5G4NJEtJR6X21awbcSRDuScata7OTSfnTjSthYw/JFTNgvlAZHXcLqDsKgCFRy1lEw=
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Tue, 2 May
 2023 13:36:03 +0000
Received: from DS1PEPF0000E63D.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::f1) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63D.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:36:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:02 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 02/23] arm64: zynqmp: Fix usb node drive strength and slew rate
Date:   Tue, 2 May 2023 15:35:30 +0200
Message-ID: <1b2914e5e6010b174c14603f92626ac3b11a2263.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
References: <cover.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63D:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fdb5ff-be59-4feb-e753-08db4b122ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spABzgjiyC3vU2DXClSDJgrq2zgU1J/GqccKEVztNsZh5wHIw7Fp388Y/1rXka3CZQPuFn/Ifaw+bd9WpM2deIBcltwz7d5W5JsajUAtuYeilEvx6D24oQTegW7kBRZlbceV+sUL7SUk5LRMeQcGqkzkiP+BvhZIU7UuenAp2L0HZSY20YYTrWDj/5H+MQdJR5Nbpi7a3K/MotLZma+nnfqAakCLQaLAub2/rO5ZrAbgDgjiDSTrT+6D0vDqLukLis6Xfx8e4p3swfBKc1moZDHaTYK+DxnxnBzzr1MdQLX1ubJdh6adsEI5PVOzqIRxWc4qx3N+BTIoIJgInIQYBrVrjM/rd76IoD+L7bm+sq+Ca8yFWTYzkounT5Jv8v8tLOVyr2HWz108X/SX4Y1C2siw404LuOQqM+ikDidgerumYTCfzXoht9KVsVCM2Y3DaqPluCQVdLQVr0KB8zSYZqOX+jdeJEg7lpbVuUhc8XE3dfEF0GjHygoWcXLI5wOLJuvJ6dbPhXKyWgSzE80Sr6tIaSknappzWV75m7SuRia0CgfbiaqRNTZPlIFHGFYpBu8gKHGLjJxDYZEqIc6DNsiuZFdoCeMxohOG0pAKR8bhkk23SQDNkFlZQ3M6LdZXqXQ+o1Ds4rNILQi+tOztkV5d1wS0C5KL9Q24GV6NbcOmgw2IkP1bJzKqZOqw8j/shdlJXiSUkS2rMTn5WJRGxYzSkTUatGCXz/SAKRGTirXGUCT9IfxePLiDwgWbmWOQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(110136005)(426003)(336012)(26005)(36860700001)(2616005)(6666004)(478600001)(4326008)(316002)(41300700001)(186003)(83380400001)(47076005)(16526019)(70206006)(70586007)(5660300002)(8936002)(7416002)(30864003)(81166007)(82740400003)(40460700003)(2906002)(356005)(44832011)(40480700001)(86362001)(8676002)(36756003)(82310400005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:03.5461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fdb5ff-be59-4feb-e753-08db4b122ccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
index b610e65e0cdf..2f7a17ec58b4 100644
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
  * "A" – A01 board un-modified (NXP)
@@ -259,19 +260,22 @@ mux {
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
index a52dafbfd59e..4695e0e3714f 100644
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
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -242,19 +243,22 @@ mux {
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
index f89ef2afcd9e..5fa9604f05d1 100644
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
  * Michal Simek <michal.simek@xilinx.com>
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
index 938b76bd0527..a2031187d9b3 100644
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
  * Michal Simek <michal.simek@xilinx.com>
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
index c74bc3ff703b..2dd552cf51fb 100644
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
  * Michal Simek <michal.simek@xilinx.com>
  * Nathalie Chan King Choy
@@ -423,19 +424,22 @@ mux {
 
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
 
@@ -447,19 +451,22 @@ mux {
 
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
index c193579400cf..78043d9de7cc 100644
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
index 11c1eaef9f53..c1779c88ec34 100644
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
index c06c138fa3e5..b857c1950496 100644
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
index 52cdec33f190..e4e09afbdc1a 100644
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
index 699cc9ce7898..791b2ac9fbdb 100644
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

