Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E6770D682
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjEWIBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjEWIAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:00:55 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3D10CA;
        Tue, 23 May 2023 01:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeyTDYg3F3gMGifOtW8klRlXhYI+qeBztHRpmdP2rM3MbhekLpdjN7gPtDmXvavdouvFRTZDZtn2QvZMDdNCcjfZry3ECSU7+N/qKrCtWckqqxkwt/koL1JocOCG6YgICQYqQLNZASM1N0nEkkI/gVhWVD/ZXKz5hc2o5h2dUzcfXBU18KQ3iLP1PFvmb2VknsdPoh0sY/MbP73f93Uzz3TDi5J5yvDAWfZI3qSGEJ6qCIg1Hf+ueA4Kk84riSMtLtwtUMpAeNJaNdNqQKTep2Od7g+yJcmD8ZwWeO40oE63hb7sLLLSlNFev2QlKK/wnBiskAr93sW15a6zZ+Yf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9EhnQ78hCku7lUAPNPEZM4a1je2Nek0a29n0tcASno=;
 b=nsAbnupceGiFi3NrUq1dfIAWASQS9y2AyVOKlxJyQnSucwTLrZXX5iidmA3LpDermeEm9aDrTxg+B3aXQnUCMuxOUOzn1G9/4l1fsDIfEITuBJK7bW/DwB+P6AA39tAlhGNhmTrd9AMKGk9C8VrpUSFd88dfIgqoRwMaXTvljRKas2U7ajQCDvYu3nshrsIUlbqyTcQSF6zspYRQb9S9x3NrA5d0fx3ezcpyvFAi/JfQiOETY4V1iJiH0Hy/sKQrH6IemnbYW7u6VlHIVeGRB5pRqnO73JFY5yujAbo07jOIjCf/+f8RJf+z/wVZ/jOiZqfYTrsM2ioyiTEYQiA3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9EhnQ78hCku7lUAPNPEZM4a1je2Nek0a29n0tcASno=;
 b=4PVUSoWJgtOFjh3QyjCk92b12MLF4vNGZXxvzS3AcMhif63rnDXJirDARbi99vZpbzlvVzxxod2U8aU2BgCetM0b5vttLnNfkgLYYmCJ/fBBYYkUzGJQY0iBuJ5ADxzXCX/G5z66mZuG35QAbmk++JaKznwUuceleOJikyu3Snk=
Received: from CY5PR14CA0002.namprd14.prod.outlook.com (2603:10b6:930:2::12)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:57:02 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:930:2:cafe::47) by CY5PR14CA0002.outlook.office365.com
 (2603:10b6:930:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 07:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Tue, 23 May 2023 07:57:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 02:57:00 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH] dt-bindings: xilinx: Remove Rajan, Jolly and Manish
Date:   Tue, 23 May 2023 09:56:57 +0200
Message-ID: <9b252dd71c82593fa6b137eca2174d9ab6e57f7a.1684828606.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3004; i=michal.simek@amd.com; h=from:subject:message-id; bh=NKJc2kq1nVhiptTBxgUHKpfRZRk9NYR6CyNsuSqsnak=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpScwv3FH+8a7O61dw6VCQlxuF1ke3CvEet8y70XLz1Z+ OSXr+D8jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRT+4M8wveTuoTOCLlPenE tOfVyibuDT+a9zHMT1p66MuPd5V8117/fmO5fxHj2o15QgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fa1d4b-0f6f-4359-b876-08db5b634af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAL5YVmLV9nfJGkVh6X/OiUnvo0JV0ZUa4svMXLawyiP8gPE4tfOb/l9SCKGRvOdEP2l1z8qoBN7oJXYNSZBf2pkF/808pR3+mE3USAz+ZX/ti9F9KzY1S0xgwo6ItCbmq2PTJw7m0w4HToZk558aN4ejnzrPypaL2K7WZQ2VWUTXC17ppQctXXP3y2URWyRfrHU2mdYWnGPacuNJAJo+H+8uXlQwj62vo9K45VQOHXnraAP1ljvrEmRjPanHePALb44ryFSRGZ7iuDKvF4tATUsCB7+rtNeA1cKQ2wlwIFAGTi6BlrpzIJPwh8Q9fKG0WYX9L1xmExUYLXTBPTw2inVQBN/3W6cL+/6WRhSi5YF08dYHnJ47WU8UIaAR8O7tI+jUDVLpxfIlkvQmFxIlWj3+EgeeXtfrBaMcwJYM+AClUxcYHlBCws+DUh92JY7dQOqCXl2G1U8SiAgOKejaDbpYuYNORStbGm0Cd7tQcO1JXQUpbSGpW3p2Hd/D/SVsu6mxQFL8T/6R3QcvWa78VUkC2o1qtIb3U0xyVyBnJyhsBFnyCHYEGblvybcBCy9VDPBLCuyhl7IaH1B4Dffc6ryj+Q2R3+2V795PJLVJdAP298qGWkzmWvQAXNgSS7M+KcVBXdAmtVEAObdcKIFjN/7+M2aU+FEKx2ut8NWd604MGecSTIwQQECK0YAW4iy1rjVe2077jzEPPqjTEobWr8m2xq+9DOp+R+w8aYcWw8jO3f4DYYXiorIRszC8nFbFbBCgMxFkvRI/d/rLoHFfHLIxnpenFU5X69/d636nzQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(186003)(316002)(86362001)(26005)(16526019)(6666004)(2906002)(8936002)(8676002)(40480700001)(36756003)(7416002)(5660300002)(40460700003)(41300700001)(44832011)(478600001)(36860700001)(54906003)(110136005)(356005)(82740400003)(336012)(426003)(81166007)(2616005)(82310400005)(70206006)(4326008)(47076005)(70586007)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 07:57:01.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fa1d4b-0f6f-4359-b876-08db5b634af4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rajan, Jolly and Manish are no longer work for AMD/Xilinx and there is no
activity from them to continue to maintain bindings that's why remove them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml    | 2 --
 .../bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml        | 1 -
 .../bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml         | 1 -
 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml        | 1 -
 4 files changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
index 93ae349cf9e9..5cbb34d0b61b 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
@@ -8,8 +8,6 @@ title: Xilinx Versal clock controller
 
 maintainers:
   - Michal Simek <michal.simek@amd.com>
-  - Jolly Shah <jolly.shah@xilinx.com>
-  - Rajan Vaja <rajan.vaja@xilinx.com>
 
 description: |
   The clock controller is a hardware block of Xilinx versal clock tree. It
diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
index 6b62d5d83476..87ff9ee098f5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
@@ -8,7 +8,6 @@ title: Synopsys DesignWare Universal Multi-Protocol Memory Controller
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
-  - Manish Narani <manish.narani@xilinx.com>
   - Michal Simek <michal.simek@amd.com>
 
 description: |
diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
index 7864a1c994eb..75143db51411 100644
--- a/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
@@ -8,7 +8,6 @@ title: Zynq A05 DDR Memory Controller
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
-  - Manish Narani <manish.narani@xilinx.com>
   - Michal Simek <michal.simek@amd.com>
 
 description:
diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
index cdebfa991e06..24ad0614e61b 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
@@ -8,7 +8,6 @@ title: Xilinx ZynqMP Pinctrl
 
 maintainers:
   - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
-  - Rajan Vaja <rajan.vaja@xilinx.com>
 
 description: |
   Please refer to pinctrl-bindings.txt in this directory for details of the
-- 
2.36.1

