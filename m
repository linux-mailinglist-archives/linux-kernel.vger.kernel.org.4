Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F26DEB92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDLGKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDLGKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:10:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3ABB8;
        Tue, 11 Apr 2023 23:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noJ1jaCd9YKCpCJw9lqUODTOzjOWOirq/UTrBzwwyPZydeqWRGpLkpqMIcCENevtYK3bIDNqQMrnR4y4x1MgygqzO8XAGQCwkBQcWFC23nIPn0JRJDJEEKXxhS0+XZ24JvvYXcXds8jBdZKGKqPF+S1ZMMF6vP9JA8AeDtjBtyxzAA5C2Rxx+1RMtaaS9gGm0j34XDN9xXsNHw6cNbwSXpbt+xUckQysFk7qx/hs06Kq3H/vKQj9jALGouKpLHTzkntiX46nUxJvsOSuFkdSiO9wfUqf/GE2a9EUFu2nHrXLwnARXsCXtvIMS4cwPFJyroSTiftkwqgasmPRXRzrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4CUJPoV+E8moH1rMSd5KP3VQr0hiYEXtnk3vDxyXM4=;
 b=kXkxRniX6dPiCvi8F3dPCkOabRsizwdJBYgAmw4OCAklYbHSR1+/WdzL0KbMQXuboEqr33Ek0ldKU/Phf8vfO69Zvr8rgenhzfmoc/yTcGSRIN9Ez4Jb5iyR92G7SCQHoQDvsxuCaJ8PnILpV8ukxo0A2WozpDnKZwaphLvREVLvmJcmiPtf1E+MVzrv2KMba+RGy1E3Z2UzGPMTQ/zkrp4K3MOOik7ZUzTCYug/nL/P7Q+qZz4s8Qg4fh/EJr3ahGYujbj4iWCMCZqrEw8qr9Vtr2OnWQ4fn1wjEpZoP0c2BEqIFnx+fiO3z/BLpbu/jZxdJqm0/NotsKDBuyloXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4CUJPoV+E8moH1rMSd5KP3VQr0hiYEXtnk3vDxyXM4=;
 b=hGFfpYA0/B/eFObRXuoqGY35B2hnvv16RKFglFbWfj+BwwBkBqQwSYXWoq4Kanp3acoVJ7FOZE/DR8TjEh+nA5ApKYI4o9fV8iujhevLGv5zR7VlWVh+lJ60oIhpFai1TfuNr2YUB6+jZMTGK3VZt+1Fe18QQVAbVAzE5oWxnyQ=
Received: from DS7PR03CA0313.namprd03.prod.outlook.com (2603:10b6:8:2b::18) by
 BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 06:10:15 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::88) by DS7PR03CA0313.outlook.office365.com
 (2603:10b6:8:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 06:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Wed, 12 Apr 2023 06:10:14 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 01:09:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 23:09:30 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 12 Apr 2023 01:09:27 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] dt-bindings: usb: dwc3: xilinx: Add interrupt-names to include hibernation interrupt
Date:   Wed, 12 Apr 2023 11:38:43 +0530
Message-ID: <20230412060843.149283-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc48877-69ad-4b1f-f43a-08db3b1c9511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JcxkIF0SceoexCxEAmBtX+FbFvwtim+hZDUjzVAS3Uih6Q8keUc3YTWIYwxq0UTkB2crcPy0Km1Oe3fw/4lmqCUbNtYnd+M9iHt00C6d6VAZ6B4vOr7eb1CetNo6oOtqd+8igFd0cDul11OpDbMVZU9X/R5APBkIRe5dpQKMOWq5qoatY9cdAqUsOkhEDJMaSxn+fblov3wBrezSpbfGsR/djUyl7KsqMEyamoY0b4hjr7+YoFltFLpCA0deKKIw7YMfM4WMT/0trXZIxriBYdjDta81GOUm+iL3Fmbaj1EO0R/adn8UJRg+eOhlsapr2I2iAbSUZQeSZN37dz8PZSE5krKnxieJX+BHuaJqjApxG6DMgHVcbA4qppnTlJV+12se2gAk1Xx8NGs3QeqDVeBooCAYJjWHlgPmCTp2AE/FfzwWIjuK9+NEO9lZcmoL3gsWJdl6GelqV3r1zslnTA02B0mggOm7WiptrUY3hTpPORcrCTLvatybs6Cqjstt9pqppD2+Qax927sf95Agg1CSUmNwdWqcr+3d2FqrP5m0XvgKlCMsKBPokPeuKgbkTBgDUeG+lL8yDnuSbv9/t57GFjLUckdw+vnc6zpRksyziOaAm1lFYW4xHFsUQvElfM7hTDjmbvh44tPaPZ7uHh6nEKaR8OuOVhZ9arLz7bD83DYID4w5BGVDb3cPJbQX/ythsnhXLAlH6lTv29mrfjhtQwBKmCQa3NpHWCK8bBRwaqPTJhOESJr8mBgRdu8/kUVIYOgxCorbySnGYUcpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(478600001)(82310400005)(26005)(1076003)(54906003)(186003)(110136005)(8936002)(82740400003)(41300700001)(8676002)(316002)(70206006)(966005)(70586007)(4326008)(6666004)(36756003)(86362001)(40480700001)(356005)(81166007)(44832011)(2616005)(36860700001)(47076005)(2906002)(426003)(336012)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 06:10:14.8224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc48877-69ad-4b1f-f43a-08db3b1c9511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
Added host mode interrupts and "usb-wakeup" interrupt-names optional
property in the binding schema to capture remote-wakeup and connect/
disconnect event in the hibernation state.

Xilinx dwc3-core uses "host" and "otg" interrupts interrupt-names DT
properties from dwc3-core.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Note:
- Xilinx uses dwc3-cores interrupt-names DT property.
  Link:
  Xilinx-dwc3 core: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml#L129
  dwc3-core: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/usb/snps%2Cdwc3.yaml#L42
---
 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
index 098b73134a1b..abc32db2448a 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -44,6 +44,15 @@ properties:
       - const: bus_clk
       - const: ref_clk
 
+  interrupts:
+    items:
+      - description: Handle to the line usb-wakeup used to wake
+          up the host processor.
+
+  interrupt-names:
+    items:
+      - const: usb-wakeup
+
   resets:
     description:
       A list of phandles for resets listed in reset-names.
-- 
2.25.1

