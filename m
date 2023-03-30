Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1D6CFC00
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjC3GyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjC3GyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:54:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE616A59;
        Wed, 29 Mar 2023 23:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EySzM83RPKXmhthVlgv7u7Jy0xl+wD25HL1zL7Ew8IRainkc0PsWvWle95HCjkGz8XZ0vL7RPVYgZTdXs7E5w7OXjfIIYZM3n9kXF7jN13F9EeDgcsa3CUFCJlKdN8MlC1WJJu5F499qUA379pHrCzI/lcq/fjpsLAnM6PtbKjUvatu/906wa69wYFoMoiVwLkaB4caEWw32Kh544kFXKFqy1qL1octokuYDopV7nbahlGI6TABrmGhR7hGFfmfK6V0Sh6iDRTxDyOQ3IZsQ1Q0rU7PpmApaLn/4yT0XAQqvILxI8bLFKoituQQO+cFKP3KhMNRu+gdqCJrIDifovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPXsF43lNqdWJWUYD2LqCEsI8xe+3edlhNk42CY+WME=;
 b=HaALa4xq3YvF4DcFPu6GKsPc4wlCS7a+O4EPmfl5peb/Bx4qpamJcOD9ICis/BsBBLPyiF4hTKwNZqOOr23qghuZE8EzKBVm5ui6VkHs4ICx4byaaqxDdte8EP8Oq9wMHcJ6onTh3hER6WVXNc0pK9amrgZqkJGdC2J4UGJZxa+JJKZJtHsaYTt0uhxEGzTexn7yjaIALOo5tP3LXmWhgglEyqGcmX3wuHPF9eN0D2LN8jnpH5Yc133habUg2qlcy2xydSCfyUkEy+aNtaL0V+Cw1tlGaHZYD8TZigSSrW3zeuvixd1i2iGOdVlWJFYYCPl2cfVK3Uwe6AuGlB+Fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPXsF43lNqdWJWUYD2LqCEsI8xe+3edlhNk42CY+WME=;
 b=cuY5dF2FZ3dU5aMbCeVr2Bo+NGLVn7JsG9qgdG5SsG4gKBp5OQeF6Xkgi0VK3PK+hjDZ/L6xFHDSgNZU3yaHE4EpKK8d8JA3V2/UJsyxtSLpx5sQ4viSfIMM0mRBvLReyEJxeO/1TdyU7QnsHn/VznSeh/mThtWzGTicuDNJ5vY=
Received: from MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 06:53:42 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::28) by MW4PR04CA0101.outlook.office365.com
 (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 06:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 06:53:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 01:53:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 01:53:14 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 30 Mar 2023 01:53:11 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible
Date:   Thu, 30 Mar 2023 12:22:39 +0530
Message-ID: <20230330065240.3532010-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330065240.3532010-1-sai.krishna.potthuri@amd.com>
References: <20230330065240.3532010-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d439acb-69e7-4389-9edd-08db30eb7f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YialoQDTP4McaGmwZxSIbHzRq8xx3FFEZOdDWrRh1NucPVjJZWrCUrTlRM5G+NXgGBEce9fysLIwZzrxJZJfUO+FfDkx6sL2KGF7SFexWyD7SOIJYia0f1TUTZvL2n6Oxzd7ymxgXPNdPJZVVrg31Ku4lkYJPDrfHi09B/UAlCLxNwVbepYnOn9omxPaKtGcoo+qyE1qcDtIY1Z4rzphuKPMDlPM37+QdiN+NWz0Lrvaj9lhGkN0mCjqiCnD8odb64KgteofKWglyF9zg/fgBZ457rWrU8H0Jcla+bneHLiV1ZWXbipD8XJRvHdOMKUfaL3DDRUlwm7V1v8MFRXkUJzxfQfmeSrqg2kkWbJ+4KQ+RhAdkwQPbkX6gNvDsPiN4hOgH824CGKqq00uwV/l/qy3+6C6qIO9Ft+xiJ8tt1A5N0LeFqEVSa+nMnoTJGBouJ+UqRP9NNa51fWYTeIe0noyqq5EqrJN3vLSozHzaRtTLd0khoxKbsPhgUvAx2vwXiTS8E55CcFyDJ+BEkOBPD+PcvC7ZMkcJPuWXiqXZ2WTMmhQPNJml7eNYJ7/Ch7qU2/Zqpv/oNul0uzFUXtMAPZKPLuNt1hHpWuPzLOBtk+tNixIVl+wZ15CP40KHjZN6b4UWCRB18xr94s1J+0UsHnEs5LrwDQeowPL0xDo3eOYJwFI0D/apD7XTOQu7v1amQSEOp0WI8JTYbCFBohw73/UafiCJg7Y7NJ3M4emZFU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(8936002)(4326008)(5660300002)(2906002)(7416002)(82310400005)(40480700001)(86362001)(103116003)(36756003)(40460700003)(82740400003)(81166007)(356005)(316002)(478600001)(110136005)(54906003)(6666004)(70586007)(1076003)(26005)(336012)(2616005)(83380400001)(8676002)(70206006)(186003)(426003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 06:53:41.8200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d439acb-69e7-4389-9edd-08db30eb7f9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx Versal Net compatible to support eMMC 5.1 PHY.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 8296c34cfa00..9166ac061b44 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -27,6 +27,7 @@ allOf:
             enum:
               - xlnx,zynqmp-8.9a
               - xlnx,versal-8.9a
+              - xlnx,versal-net-emmc
     then:
       properties:
         clock-output-names:
@@ -62,6 +63,10 @@ properties:
         description:
           For this device it is strongly suggested to include
           clock-output-names and '#clock-cells'.
+      - const: xlnx,versal-net-emmc     # Versal Net eMMC PHY
+        description:
+          For this device it is strongly suggested to include
+          clock-output-names and '#clock-cells'.
       - items:
           - const: intel,lgm-sdhci-5.1-emmc     # Intel LGM eMMC PHY
           - const: arasan,sdhci-5.1
-- 
2.25.1

