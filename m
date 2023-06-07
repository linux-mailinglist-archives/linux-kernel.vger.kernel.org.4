Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440277254D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbjFGGyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbjFGGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:53:57 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A61BFC;
        Tue,  6 Jun 2023 23:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAsokwXbDT9GYWfyvMvoeKsnWSCwHxQSvDbBzv1vLisE/Da1PeN2BthseoNQakTLgcwkJjLGA0D5ZVowH4Tj91UUZwvsvBs03bZNBdNvyC7z7jtJ+OOsBtFBzohV5mudA93t5p5xXv6z96Amh/KZDLUDCRnJXYKnkd/kt1e+USq268frC9/jRQ/koYLZkWIa8YJupE5VKHUl0eVQOEEQPM1V+/Xs4RJJjNi8sW2KeIHeX2SsCveGv5hFrnf76V3Ixwy5Bj6s57ZRGSvb5qX+JYn74ecVK/OuT5cKE57gQC8b/CvjYgeiehsstxOsVLur99bBYLDODuRdlZxhV8IZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfIQ/670RShMdx6/kmDzYmWvUKOjXCKAEiDiJSzQ390=;
 b=PbVxw3CnixIJrZLH1VISfhMWPfPrdCH/P4gDNvjgiN/flbQF8oqFyvUyckV+HuCMRdQv7bIttniQ78vGSI2XWdcIeqw760c6Zgr5CONED5Xk2WwLeOSe+uVIB7Pis2eIP6IbjU4z1Ks/obaIIU9I3jUP5akZ6FHns7KUUnQM2ZUWZvRQH9MEg6IArrgpO5kqm0+eQWJufwP6dnr3vQntuaxe0EU9t87CBV+pVcUOBmEzeptj6dMePNU/QK/JNKU2Z/CIMnuZ6ixxl9vcWyTD8HrL2bCZjz9q4cpeF+gvxXZ3MdoBfy4fX00/tF1Pm2YLWDV2661Ok4OxUeQK7ikh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfIQ/670RShMdx6/kmDzYmWvUKOjXCKAEiDiJSzQ390=;
 b=kvZ7MPnWWUDfLfDg0LVhv1ckJ+6FvYZgztEmhY3l+noT+fU/yRZzz1qkHvSVxASUDHbqmphAJzLsfuGmMO2V5l9O3Ap3OTfDri3hLyGjUFyUWdF0bXn6XSaO66xT7edSeF+wSnLU6rRzOY5V0rK6yNgG2Qt2lX3EZZq1mX1p8QE=
Received: from SJ0PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:33f::26)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 06:53:35 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::cd) by SJ0PR05CA0051.outlook.office365.com
 (2603:10b6:a03:33f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 06:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 06:53:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:53:29 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:53:26 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 2/2] dt-bindings: firmware: add reset-controller property
Date:   Wed, 7 Jun 2023 12:21:21 +0530
Message-ID: <20230607065121.2265076-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607065121.2265076-1-piyush.mehta@amd.com>
References: <20230607065121.2265076-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d30bee3-0551-4aa6-0150-08db6723e9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZhjb+k4m8ALHWeLAne3+EPNPdtdZ1VDvn49p3QxE9PUKbLbaSiH9rFrdTVB6N7jBy0bC81l2lUPDWRat3wsLaa8faz2z6UMpf0up5kFNzFWLP30gtj14h8LVk2Lbgs7bH/VEncHwyh//zpsw0lpYF/itoB1uHj2W8jmkdFTLuZxsDQvRn1xafNsclznbET+KdFNVXw42hQEjSwooKRIP+wVX19RXWjwRwWzWjIWO4MFsepMAHOqkLUiuhpUuzyXMKKN5RcPIgyGolccSFr+PVrt1wAD5cl9ijbunkbZ0h7ySkafZLunRYX+73JlPh/LkaTqr75DhEIjly5eWtW84Kk/U4jTm3WXNZbgAVTxnCcLe0piuahwSjb19Zuy/bOzcMHtzc8ayjtgV0WgQ9W8BZEmWG1lHlAFY94nY7UGC5R2q9S8sYUO75zwby+LRY5J+mmVlGWSMqRaSgf+0Dq3GNIhXzNDZZGGIUmIM5cslY7N9sPIWDEeE6uYq8m7aphHQcHCE5BdL+oBj7e+VQ+9U6kQpfEhIbgjNjK4mi0zJOMlWJkpzVCr+Gq7WyK+amlSa9Ga18c0pD+mUxiZ2VKtQQyPj75wJPFlY4XTC1nSUrRhkrxJOPL8eQi0NEaDZ/zVCaRXx5drvikZ3RJ/eNZJk9EaSsX5QHtmmvRt05MzXLwiKMbNQl6/trnHFHpe1oFtSlWS4YeqqA9IkMsHwrJAuv8H5GrG7lYbv7eHKgufBZ79oYM2DOTd6TfsTkOuW+KIFuAlL3ylJdZ5AGpbSL1F6lIQXAM3ZrmqMDarTsrjh0Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(2906002)(110136005)(54906003)(41300700001)(8936002)(82310400005)(8676002)(5660300002)(82740400003)(356005)(36756003)(44832011)(316002)(4326008)(81166007)(70206006)(70586007)(40480700001)(6666004)(478600001)(36860700001)(186003)(83380400001)(47076005)(336012)(2616005)(426003)(26005)(1076003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:53:34.5366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d30bee3-0551-4aa6-0150-08db6723e9c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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

The reset controller is responsible for managing both device-level resets
and individual PMC (Power Management Controller) block resets.

To facilitate this functionality reset-controller property is added to the
firmware device tree binding.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index f14f7b454f07..04d875a535d3 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -59,6 +59,12 @@ properties:
       controller.
     type: object
 
+  reset-controller:
+    $ref: /schemas/reset/xlnx,zynqmp-reset.yaml#
+    description: The reset-controller has the ability to reset lines connected
+      to different blocks and peripherals in the SoC.
+    type: object
+
 required:
   - compatible
 
@@ -84,6 +90,11 @@ examples:
         clocks = <&ref>, <&alt_ref>, <&pl_alt_ref>;
         clock-names = "ref", "alt_ref", "pl_alt_ref";
       };
+
+      zynqmp_reset: reset-controller {
+        compatible = "xlnx,zynqmp-reset";
+        #reset-cells = <1>;
+      };
     };
 
 ...
-- 
2.25.1

