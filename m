Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378DA704F92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjEPNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjEPNmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:42:09 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7A35A8;
        Tue, 16 May 2023 06:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsNVCwnhxi7Ny9tsoA9X/e7a962ZcTGRz+CDtia3D5v5GYUiAwR1r8Gbn3LePjRwN3IwAkZY3xFxWSbA13vLdgl4mlA6FUvCJwP6+M0Fi2vYMafC5L971ciu4Pj9WN8Rdq6cYiSz17jUHFSbmTkrwYURnGzGfsyAqZeh+cjDeC7r3xJCpzsBDdrEP7GWfxMfbAqkDzWRGwR1Bry8rklb6JKhy0KTUNBw0O7ku3n1c1Ceq3CBysPqRqy2OeTkAzVkYQArbNPYlozSvz5GeS0TCrIpgVE6rwOGs1mz45lw2NGl0H/LTQM8pt9K3dCBa5iO/zAgBB5WQMhy3gEm8geb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31KpL5SmXhGXwGXhFm6nQ0z5l6QraVkIq8Th+9imLZ4=;
 b=Kpe5+M4qwYVnDtPoOaZCf0PjYNaptYlDkRA8/xCjfPfXmBfgfO3qV0C539WAvXqRxHrTWwvgorAxnHx5fwpVWUZNnDhBi2qbk9AVmNFloc2jQksgsOoeMa4fKvxV83mvPIyoZzRIwCP6Pmxh6z5lVymiheTCZYEkAl9Xm0LpmUuDdQhMdce45UbD+5lR7mhkbGgszEvG/zozh9HFhIKEDlfjAO+R1N4X1l6qyUpc0MS00zlNm4NhhYsDo9gUFa2O7tnDhAXlVAIqyWNWVxPOsHrorVP5xRsEHkFE70N5nLGdwUTghnC0a9oB/rSQwtyg5klhfS6ZDbqttefpUI3VXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31KpL5SmXhGXwGXhFm6nQ0z5l6QraVkIq8Th+9imLZ4=;
 b=VNzjDHRq5hb/zZeB48LBG8BkK2pcbJ4MIGXyJKx7ktwAA1W6xzEC0mHXi9G6PyroSss9xOgXfQ8HL9I4zijuCgIn0O/fb/iI5xx61X8FBmr9Xh4etX8MzhKeO30viwGu/f/AOeES/yO1/6BS8PWqc1Crfo4+oxNdjXPWwKDOl7Y=
Received: from BN9PR03CA0151.namprd03.prod.outlook.com (2603:10b6:408:f4::6)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 13:41:57 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::c9) by BN9PR03CA0151.outlook.office365.com
 (2603:10b6:408:f4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31 via Frontend
 Transport; Tue, 16 May 2023 13:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 13:41:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 08:41:54 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Switch to amd.com emails
Date:   Tue, 16 May 2023 15:41:40 +0200
Message-ID: <4c3426077075683b866f144b633cf5218a688c7c.1684244480.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15304; i=michal.simek@amd.com; h=from:subject:message-id; bh=6wb6tq/bqaRyAyJi1fp4SbBgpt4XtxTSok5RMLl1oTU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTkDsEAk+mam6VfHF89k8NO13vLC4fVJ3zOM/Rlzdjgo u74gKOoI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykPJBhwaQNrh1LVWfILvg8 22iz7tP4FEmDAIb5Wa5p+qoHIq/uirvTKeHbaOrZEOYAAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9ca622-a2d6-4afa-0789-08db5613511d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMv52VOTLKLNq6lixnDWq2shXmbCAkAma6vLl9j0y1wt9It3ZfLDBBHOWTbxU5zAc2MK1w4+KrLf1xWcr6x0xA2ZHCmidSZWZt6m2DUg1StTRZtKkDVnQmoytiTUPJGj78DhFvIKze0yJJLib9YyyBHxOcuvTl6Zl82ON2EGRqlSCnIIy4i7GH8Qeq+1bu6gA3wIGGg5P2TpaTdjx51hSmCjL2WuCW2yOlZxnMq/JZ0SJg82/hdyKjhVllXOIzxhJdPGoR1aM6SWDlj5iNEq08SbuaRV4HJCzk8pxiIG1lla+V6oC3W7p162RnmqurV/+yLsniwWKR9bpQrExBBGlgOj7nNMLuzeyeOqQmvpnkCkv1IYqoPgu6/+FXhMFbcpGYEnWiKgtHRDrcMYHqnfWc+E2kx6ulmKXoPBh3UihGqF0qHG3kbM4eDIcnhmTk9YQGj1R2Vs55GBDkzPA70h7xEwO3phVJwMYGl9ZEQv0t8v0Zwb1O2cv9YGoEx/peJrIgSlOaZJ/Rjk2aiEfq2eCk33c5DyMzSDdlvf1ohwvF9mv9kE7/M6qQim0wCdlR/Y3qIrOFg9WZ7eghJ3V50Z3oKld+3En3e1PYhjtkS3A0G6ZYoTcwkaCRZKWCH/C+EHmXh7HLlX8wqEORYHO8CDN01ea1Bbhwo1Gc5YuJrxl7gmbQBRjQleB6BuTZVPMJ0yg6LevLGc6A7YUwAOfPg8H0iFrNAt9zLbMQHWwu8T2qrCau+CpytP5Uj7dJPYcCPCLp4FHf/MWOq/omDXhLy6+K9o8I2T0+yq3c453+T2yDVOs+XphWPVhz0emuUKWE2c
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(478600001)(110136005)(54906003)(16526019)(186003)(82740400003)(2906002)(82310400005)(30864003)(26005)(316002)(4326008)(70206006)(70586007)(7416002)(5660300002)(8676002)(8936002)(41300700001)(44832011)(81166007)(356005)(86362001)(36756003)(40460700003)(36860700001)(40480700001)(47076005)(2616005)(336012)(426003)(83380400001)(2004002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:41:56.7812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9ca622-a2d6-4afa-0789-08db5613511d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my and DPs email address to match current setup.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts      | 5 +++--
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi         | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 5 +++--
 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts     | 5 +++--
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 5 +++--
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 7 ++++---
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 5 +++--
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 5 +++--
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 7 ++++---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts    | 5 +++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts    | 5 +++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 7 ++++---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 5 +++--
 24 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
index 88aa06fa78a8..1495272e5668 100644
--- a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
+++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
@@ -2,9 +2,10 @@
 /*
  * dts file for Avnet Ultra96 rev1
  *
- * (C) Copyright 2018, Xilinx, Inc.
+ * (C) Copyright 2018 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 719ea5d5ae88..f04716841a0c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -5,7 +5,7 @@
  * (C) Copyright 2017 - 2022, Xilinx, Inc.
  * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index bebbe955eec1..669fe6084f3f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -9,7 +9,7 @@
  * "Y" - A01 board modified with legacy interposer (Nexperia)
  * "Z" - A01 board modified with Diode interposer
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 8e66448f35a9..7886a19139ee 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 464e28bf078a..8d1c54e00556 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -2,9 +2,10 @@
 /*
  * dts file for Xilinx ZynqMP SM-K26 rev1/B/A
  *
- * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2020 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
index c70966c1f344..664ea7d99049 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
@@ -2,9 +2,10 @@
 /*
  * dts file for Xilinx ZynqMP SMK-K26 rev1/B/A
  *
- * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2020 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include "zynqmp-sm-k26-revA.dts"
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
index f1598527e5ec..774fb773886e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
@@ -2,9 +2,10 @@
 /*
  * dts file for Xilinx ZynqMP ZC1232
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
index 04efa1683eaa..7c27b0e9a522 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
@@ -2,10 +2,11 @@
 /*
  * dts file for Xilinx ZynqMP ZC1254
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
- * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
+ * Siva Durga Prasad Paladug <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index f89ef2afcd9e..1a7995ee62ce 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 868ca655a220..869b733a0634 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
index 381cc682cef9..af48920f854c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -2,9 +2,10 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm017-dc3
  *
- * (C) Copyright 2016 - 2021, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
index 6e0106bf1294..0128766020a7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -2,9 +2,10 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm018-dc4
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
index ae2d03d98322..6f6f000c60ab 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -2,10 +2,11 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm019-dc5
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
- * Michal Simek <michal.simek@xilinx.com>
+ * Siva Durga Prasad Paladug <siva.durga.prasad.paladugu@amd.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 70c48079575d..544801814bd5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2016 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  * Nathalie Chan King Choy
  */
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
index 6647e97edba3..348ba2659a51 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
@@ -2,9 +2,10 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 Rev1.0
  *
- * (C) Copyright 2016 - 2018, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include "zynqmp-zcu102-revB.dts"
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
index b6798394fcf4..aed5da733c2e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
@@ -2,9 +2,10 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 Rev1.1
  *
- * (C) Copyright 2016 - 2020, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include "zynqmp-zcu102-rev1.0.dts"
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index d600eeb5b2b7..230ef94d5dcb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
index f7d718ff116b..63419deb5b33 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2016 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include "zynqmp-zcu102-revA.dts"
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 473fae564906..d178a4f898c9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index c8ba9ed157be..38b11594c074 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 09773b7200f8..8af0879806cf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2016 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index e0305dcbb010..f76687914e30 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
index 4874e0ad914e..2b43f7e0d619 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
@@ -2,10 +2,11 @@
 /*
  * dts file for Xilinx ZynqMP ZC1275
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
- * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
+ * Siva Durga Prasad Paladug <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 850b497d7a81..cd129e7102c1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -2,9 +2,10 @@
 /*
  * dts file for Xilinx ZynqMP
  *
- * (C) Copyright 2014 - 2021, Xilinx, Inc.
+ * (C) Copyright 2014 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
-- 
2.36.1

