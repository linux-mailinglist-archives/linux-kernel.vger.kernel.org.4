Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7C715C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjE3KnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjE3KnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:43:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E89113;
        Tue, 30 May 2023 03:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpGVtAbTuuABqGzMZZdrQuWgQdN1FiXeWMzukilPxpUtBrEThRh8G6j9YTG+dpat64TVde3rm/xU2WF3bAw5Vsbct305c/Xvj2RVANk/wDRFJ6IsJLbHY7CES8rAagIwnjWg0/GRncsbxEgaeL14J3Q4tyOh4vfzEMDgUk8XfTOin62oWlIyqgHshTU7VIkp6cN8VTpi0O941hdVCHCCwYd9Z3wdzE8R/YWFaLMnqNyaIlC6fyb9T23FMKykRxKG2YW7mHZHW4tLXWD1K4O1Blm1wyr/i/eFKlIwn9JgLP/NPVpThbb7l1EggIIL5uFUKwSxa4ZkSC9sXtmUDRvhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZmufrcU8o7J4J8CL8v3GgrSnASqsgNMcKhwb9rkS4g=;
 b=I+AMjSlXfbjAzfRvJF3ZDRGmboaLUPqoUbZ7UTKIZsKodeNEoRjEIfsNdUI/Je8L6ItUIBQnCCNLwiYdSPVDshdQKrdFxPaVmj6cBWJlcA90KzMtu2rNwcINqfqTAOthTx1bd5YSD4tH2ahuv+uc+eVAWCONY4WfDXt7Q3JImJrMvlvP91t5XMqfLBR9QeuGA4g3ff6A/xQ2HFcv917kD+SyTPMuxYl6IrJm2ZR8Q8NwyS566tHJop816PYESxK5hiQs2kMBti8ZENzL52lra/Tw+sJG9v0f4Ny3uXvtcmzedOBoMad4BpIvIHBsmG6qXwEItuCIfNYQ+1i5yQ0uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZmufrcU8o7J4J8CL8v3GgrSnASqsgNMcKhwb9rkS4g=;
 b=enYFSgBsRaLycT0YIjb3PN87YZMVJrWVprjAZcy7wvh1J/ZmdLl/Iwfqofe/SYe6styFXMIfCVbsbD+jspH3/+iF1/QI6xHYDdSnFQinjesVcsQhNvi6vTl+Xh04yJfQ7Yym2Oh1AfljIO5ePa3PyFYhVUxbQMkaFQuD2OJpnXg=
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 10:42:46 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::81) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 10:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.21 via Frontend Transport; Tue, 30 May 2023 10:42:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 05:42:44 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Harini Katakam" <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3] arm64: zynqmp: Switch to amd.com emails
Date:   Tue, 30 May 2023 12:42:41 +0200
Message-ID: <108cbbbab29e13d386d38a779fd582f10844a030.1685443337.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13624; i=michal.simek@amd.com; h=from:subject:message-id; bh=gb8iiQ4tExnr3NU0FpwUo/cT0cIfl9PBrRIn0w+lzi4=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTSy5LqDDVFP+4fn9kfEbUqnvV1i8rk8xE/pbdtNDEU7 a2L7vnVEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACaiuohhnqrJvY273kZc7moI nLrJcI7BFsPSZoa5InUeW7i94hccmH2kWr75U3nwpHphAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 355edb52-f584-4155-1f01-08db60fa9ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRKdkhg3KjsrAeMIVE4SYAo23wZbiDSDKP1nhdTghKLCE2+p/8/+yb1GQofOjLAa3InCj8ysAWp1/W2bg3oOvWg5VHqb1KlffgkCMC+ZKQWoFPW/98WY4BxqOs/lGWJ9TDS4rJWfmNmoPf344EU92OIIbZWE+8/TF+w+u6b2gHAS/4d4HXL2CN/A4Yju4ZEtbAqItPmv3mtxsiZhlyhqrSyoUDcCiQAjIT+Je8YikOT93saDWzF3B3pZFZNZdn4/BQHUmdlyd4YvEvjKhiVFmLcIsOadKD1MywLSz4LroHrS1N6jIjQ9P77t7PySJuucSArzwpQcABeUxYmPI9LMEMr6DRBzU+MHtDPncz5hVY84WcnI6OPPFvGXWzXRm2UXCsi+jaj7U8VY0T51ZW6no1KaIIFGuQiubW9yV92ois79tjYi9Q0oWTRCmOyTtHwdWHozRHvIGxHYVm1cdIeMFLnGdvE2UlMicNpXPLkCUBBPb47EmEXJL6wjFWSMPBHqGLevOx4KjgokIQjZ0zcn91XdBYkF6Iz67WiNuUdl69qzE9xqMAQgd37z0HFZYJ9Jq7ce4bNcct5+5zvbF56GCxwTfWN3kCBQ/lXSTaY6Dmxb7Zw6jYhOzzM3LimYxIeMdFx+D1miVvMhD0UxpkMgmRSGJVt+a9rk2r2mAhYwUEj9FAWSFiDFX33pNACLdA5gac+KXQpzVFRpxpjHMDqoN6tNaAyn4llKrJGOsIfpiHK+glAzPuLZ9cL/UPYiwPqPsUrj8gIC7Kskzt88HjLel+mV0FINTPHgRw4kO3VVxI4CGuhvcZhnfVIvonHsNZn+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(16526019)(186003)(26005)(316002)(30864003)(6666004)(2906002)(40480700001)(40460700003)(5660300002)(41300700001)(7416002)(36756003)(44832011)(8676002)(8936002)(478600001)(81166007)(82740400003)(356005)(36860700001)(54906003)(110136005)(336012)(426003)(82310400005)(4326008)(86362001)(2616005)(47076005)(70206006)(70586007)(83380400001)(2004002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 10:42:45.8811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355edb52-f584-4155-1f01-08db60fa9ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my and DPs email address to match current setup.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes in v3:
- Add Laurent's reviewed-by line
- Also convert DP email in xm019 DT

Changes in v2:
- Remove all copyright changes
- Fix DPs name

 arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi         | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts     | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts    | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts    | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 2 +-
 24 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
index 88aa06fa78a8..4c1bd69e7553 100644
--- a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
+++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2018, Xilinx, Inc.
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
index 464e28bf078a..c1ab1ab690df 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
index c70966c1f344..85b0d1677240 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include "zynqmp-sm-k26-revA.dts"
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
index f1598527e5ec..48d6a7202406 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
index 04efa1683eaa..e80484f9b137 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
@@ -4,8 +4,8 @@
  *
  * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
- * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
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
index 381cc682cef9..38b0a312171b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2016 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
index 6e0106bf1294..05be71eab722 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
index ae2d03d98322..b1e933b8a2cd 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -4,8 +4,8 @@
  *
  * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
- * Michal Simek <michal.simek@xilinx.com>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
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
index 6647e97edba3..c8f71a1aec89 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2016 - 2018, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  */
 
 #include "zynqmp-zcu102-revB.dts"
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
index b6798394fcf4..705369766a55 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2016 - 2020, Xilinx, Inc.
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
index 4874e0ad914e..e615286b8eff 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
@@ -4,8 +4,8 @@
  *
  * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
- * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 850b497d7a81..a961bb6f31ff 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2014 - 2021, Xilinx, Inc.
  *
- * Michal Simek <michal.simek@xilinx.com>
+ * Michal Simek <michal.simek@amd.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
-- 
2.36.1

