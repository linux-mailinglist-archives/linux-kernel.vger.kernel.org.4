Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A176670C16E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjEVOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEVOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:48:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E0BB;
        Mon, 22 May 2023 07:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiadzGfrLza4b5UtlaC/l1o8vxVPjtfSh9hYUYd2e0ezctQ1wN3svWOLp1Kb+7i2Y1LN2bjOa7HwLRx8XvI8n9ZVhoHmQWZs16pXvwVoKVMHpsq8YjxlUeu4iq9l9oTtDtqRQ/QS34qeeJAF3qzQwiATQb5doAp00crv3RsWqdcrYYtWBrhK3m4TlwMmamEe3bjbPYdTeUi9ryeCXPMgtngBQ935Ans44M6xGwV/FNuB4MDzi0xx3ylWFfdLDgQbeft2ocQXgDCDs9iyjd+07Aytq7GxoXWw4CkXb18P8ria1Fzw1gbqiOkzKKJernH4AKmSxt1Mq2zIZXge3CWlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OwvnrtJjJN7kbUPciIfs2JooUDXsYob5gxtep0JNyo=;
 b=T7eml63kIgZrkuO7Je3YwaoewgVN5diHBKyYPmCWlkI3NUYpqEdYtEARGLOJ12YT1rvLpjomgf492Czhx+p/hwAjayD7WoFkUPUC53m5gCIwYENYByGcpK3eXkFSTFRkICSIEKIjfcXgYc4onNFslgtM66R0EiPcubpytcoBhw8R7oM9iomDo0IV3Tt/DyJ0d7VcMQ14iyLZ5qKuxTpLDEYHmM7SZTuMyd+RogOMhCiaqeNlyiqcnHqfaW3RSXKlbQjATI5gk7/h1iBfOnBhWM05qn9v2nj1leFCjt/OPsI9v7WVCXwttIwlj1mXOmpAz3Jefc/caHh2dCceR7Gjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OwvnrtJjJN7kbUPciIfs2JooUDXsYob5gxtep0JNyo=;
 b=YhARbgTOBrgz5jxWUYsfMaxc8NNpDK4CsGIWAqeG/vC0+HEqfsQh6jxuQKqSEFoRdnDmlFXk2lOiVgJELJ7jfEAvN/epONhTm7PsZEamf/1g6/DGA7ZmcC4DjhGrmGozc5YhXyGwi87cyGWszOzIJZaTSXRs+ViFSwMi1aQBiN4=
Received: from BN0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:e4::12)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 14:48:05 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::7d) by BN0PR02CA0007.outlook.office365.com
 (2603:10b6:408:e4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 14:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Mon, 22 May 2023 14:48:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 09:48:03 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "Srinivas Neeli" <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        "Vishal Sagar" <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] arm64: zynqmp: Switch to amd.com emails
Date:   Mon, 22 May 2023 16:48:00 +0200
Message-ID: <80baafe923977bcfc4001dc5016de0731c1bf38e.1684766863.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13392; i=michal.simek@amd.com; h=from:subject:message-id; bh=0f8NqlsEe5pyW+XUqKyAyX+Q023n6ZdyvhB2tgDIvrI=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTshrkWSQlPfrurNsoffL/LyjHojcb/25s3JiacOsgsM ln5peSzjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRmykM8/31LrzefP3uW+7i W7as32e9v16wT5thfhzvlRixb+/ZHp21exyiVzxlTvqhOwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8fb985-56d1-4d85-661d-08db5ad38cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMYQQY4KxE8hreEGjFerDFbfna0zErIQf7o22b/kxY4LWPNmCQMyI7cbryq5SWBMOtS7J1I82J7eJRV/NuTckjf1BPhMfz/6v2Fj49/wXgBfxXgRxlBE89b2ziljDc4fEZh/AwqR0sjAN85bMlVxRmDz0aBHonnQPfVDtobm+1w6fskAAlB/PjPRtlQztdidUWjsXVKamK9sszduzDmfnQLbmo/dlP8+r3FAKh+WOtIBKRNxT7Atre76foXIrANVuO1VJCeoN7GT/04TXnAVZG7A9Yil5qADZvhNoNDl5274QH5/pz2prljplnh5tq9DgTgO/s8sIVuhK8Mf7pOy0sdFRYWjArgw5+cclxBnDbn/RfnhVD6VVXH2mTfWmmTmQby0RNsXAA8VDOcsI7zC2wbyzYEQ9JsSUnW7o0meXwUyuRVWN9xIHzpsN84kp5KrVF3zaYjy61kmbk7qIPqRYQRMCmE6YiMeU5xKjgsKeQUX01lisAkmgZl6ltMXlnrgH6a6S6bjShFhAeRshkylFBfYJgUCdgLK9lYfZRRP8y3R32eDRPJeHtONrqhtAUpTGLYJRbMdqFknVCm1QWnfsUEMGnWVjvAcDmMG8LD/Wingx5OtvB7t34xODOfyvvr0pXoSiDytHhplMW08isr/ft+rfkrTPWFZQut+YSErnvq8B9y+FnAZSX1bv4x/yUG9vfi4SM7UnjVGRZffg3wi3BmsFxLp4MP5KW8SrJJpMPS7s+xlRXUH2NvNJywQe2u18LKrbrjUDxQsKIKZbzzj39tsxPZw9pri3EQd3TkT6DntmoGVntea0UNWlsptPgAr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(40460700003)(8676002)(8936002)(86362001)(26005)(30864003)(2906002)(83380400001)(47076005)(2616005)(36756003)(426003)(336012)(36860700001)(186003)(16526019)(44832011)(7416002)(40480700001)(4326008)(70206006)(70586007)(81166007)(82740400003)(356005)(316002)(110136005)(54906003)(478600001)(82310400005)(41300700001)(2004002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 14:48:05.0376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8fb985-56d1-4d85-661d-08db5ad38cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my and DPs email address to match current setup.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

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
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 2 +-
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
 24 files changed, 26 insertions(+), 26 deletions(-)

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
index ae2d03d98322..5ccb343df4fb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -5,7 +5,7 @@
  * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
  * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
- * Michal Simek <michal.simek@xilinx.com>
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

