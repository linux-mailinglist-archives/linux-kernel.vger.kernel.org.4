Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA56060EF50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiJ0FMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiJ0FMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:12:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71651157F4F;
        Wed, 26 Oct 2022 22:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq4h9n/MCbYXPlJxS33PLH6De9yYTKlJ5qXHSwvUhUsuHLyIvcgnuo0a9MdWLToqLG/Jkkfbcl9DuZqP/KnFuySrY6Lv1aPLaK+CF5qRCo4uAfm/TcN++5P1ptURmUlxs00GIjOsm4Wk4dVcGNuoh94otPXjpAMos+Q5XC+ixQoXl3/y03Ds9GjCpWD/AC67zCpE5sE7jdKpSyxzYmSyn3DIrtDfsPObGJPJ2V7kC1ISbZlrVLaMkakEEVDJEaZsuMKxQEErMunff4mgl/i+cpp272Gzcq3TQH3dHDOGo23XnwkAXQz0MdQiRSoFqjY8bkVsMUpTxeL/8u2zVkLpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp65ZGY/O7wSqnODHkOoPhSjiPMCFJREY6pa2BEluRo=;
 b=M8ijXYCUzBeYLO/H5q+KPeGfOpjzMMGTDtE/dAc+Ivl71yRUGVlS1YTRbEJHQdMhYEhC1tqOazQrUYM7dN/OYgtm3q2DEDe8t4wqBfrxlLIcWlpoIvFemaMBQrO70vkkxprEl3otbxqSmSgAXG5N4lGxQ+RFv6zqp0a01CKqvl+b1vL1dVLuRhCqqNn6SGmtQaMXCihYXFJThvIYYuBr5ab5lrSdSBSC9wBP51o/AzdyhIe9hpwSYmwyhppKx1C3Wyw8ACNNxHbI0srO+2gH/ZhgbtaOhp3th9/oJpIto07cjegiPHAUR1qPzkmarALEoNNFJSkpLqiCJgPjsde/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp65ZGY/O7wSqnODHkOoPhSjiPMCFJREY6pa2BEluRo=;
 b=n6VVikvRUj0+5CGXzCdHtXsYOX9ptdCVh7z8dwsMgGL+gIE8nA9CRT82tYSSv8pcaLogNM46xHV1LWjFF+AiiMM94bofWbFgbMCfwy+PoDr6KzfXq6cMrY6VMTbMkRtaWS4NocrzT74/L7SblcEXx0I3M+MpGAI4Zm1L1JHx0dwdBwVJxowz7KSBA7kkINGX9Dyw2GqCntbYg27UeEkhMvFhrHUX18V839pSbcEZo6mHT8KDtO76yywilx1+Po2wlWRm1evoRMizsOKcyJYLhYQ6wL6Dgsx/BUBDnt6ovRBRmycqPLUbEOrj5CWc7yHZIlZtPc1SJwU1jWhDNSoaFg==
Received: from MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::33)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 05:12:32 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::4c) by MW4P222CA0028.outlook.office365.com
 (2603:10b6:303:114::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14 via Frontend
 Transport; Thu, 27 Oct 2022 05:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 05:12:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 26 Oct
 2022 22:12:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 22:12:28 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 26 Oct 2022 22:12:25 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Date:   Thu, 27 Oct 2022 10:42:13 +0530
Message-ID: <20221027051214.22003-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221027051214.22003-1-vidyas@nvidia.com>
References: <20221027051214.22003-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|SA0PR12MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ed527f-44ca-4c7e-48dd-08dab7d9da1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtC3P7DU7NYWgeTL/G34j0YRPFGtrZMxX5zOG9w4xOsZ384WCRgpgNeSdP3nDBuDVXZEsK3JvX8cMPeQVLgwjrWbnTfodWAzGZrM3va5pswKHvvOyvAzg0JkerA5Awvykh42gEIvxWTQfFexoUiyhPHTr59gpgjB+a+nKE6dqaHW7p2AsqYI4TdKQFnKAmftX0l5NDv40XboktfJi9RZ1TmwkcOfLZdo6IrKvAbRWKzIovceocxt8w5XsfRkGStBjThgwbjyCRbeH79mbt0T83mys6UOxCIRN1sidLg8Vr9ylT1eisEHQST3LgjI4ShBGGZBHgkbHbG8QwMMl6/smBooIBZd3yHArXjfX2jupsDyNMvq7SBUTa5CLv0V95A+Fofoor/DbdibKcTCCvqGkKenKkQewB03gzIzElJY93Tb0VDepAdzCMsYELonz6ysVDXbqi4n6wUepm2E92mU6CVgu4C7E4uoNrovYQibJtACOS27t0x6K1FV5aW9UIyPI4eaFHaKPnFRHX5ckinrDCjXD2uBqbkZwtHkjhkKyXU2L1MbLImVVP7ie0qcQwVws1nPovKYiicNmtpt5uqOuojTTtJgintetNQKpOF+FjW01PskC0TmTPp8bAYsyDjosxDNCtZTPndLQFlpl0l00mlkF2ebK2eblxUjVsq5k9p8xloNjqvHIJCO8J6auGvFYjlA1nu/GMFvl+c2kMVF/+gSj/MXLgxjrpHbnhXH+rS+c6VPNkajW789v8Qp7dyBUH8Zme0ciO7hHRtUkDhpFA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(478600001)(70206006)(70586007)(41300700001)(40460700003)(86362001)(4326008)(8676002)(7636003)(8936002)(356005)(82740400003)(40480700001)(36756003)(54906003)(6636002)(110136005)(316002)(336012)(2616005)(1076003)(186003)(82310400005)(426003)(47076005)(7696005)(2906002)(36860700001)(6666004)(83380400001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 05:12:32.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ed527f-44ca-4c7e-48dd-08dab7d9da1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ECAM aperture for Tegra234.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml  | 10 ++++++++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml          |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index 75da3e8eecb9..15cc2d2055bb 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -27,6 +27,7 @@ properties:
       - nvidia,tegra234-pcie
 
   reg:
+    minItems: 4
     items:
       - description: controller's application logic registers
       - description: configuration registers
@@ -35,13 +36,17 @@ properties:
           available for software access.
       - description: aperture where the Root Port's own configuration
           registers are available.
+      - description: aperture to access the configuration space through ECAM.
+          This is applicable only for Tegra234.
 
   reg-names:
+    minItems: 4
     items:
       - const: appl
       - const: config
       - const: atu_dma
       - const: dbi
+      - const: ecam
 
   interrupts:
     items:
@@ -305,8 +310,9 @@ examples:
             reg = <0x00 0x14160000 0x0 0x00020000>, /* appl registers (128K)      */
                   <0x00 0x36000000 0x0 0x00040000>, /* configuration space (256K) */
                   <0x00 0x36040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-                  <0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-            reg-names = "appl", "config", "atu_dma", "dbi";
+                  <0x00 0x36080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+                  <0x24 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+            reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
             #address-cells = <3>;
             #size-cells = <2>;
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 7287d395e1b6..7e0b015f1414 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 5
     items:
       enum: [ dbi, dbi2, config, atu, atu_dma, app, appl, elbi, mgmt, ctrl,
-              parf, cfg, link, ulreg, smu, mpu, apb, phy ]
+              parf, cfg, link, ulreg, smu, mpu, apb, phy, ecam ]
 
   num-lanes:
     description: |
-- 
2.17.1

