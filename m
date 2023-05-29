Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD475714B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjE2N5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjE2N5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:57:10 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626F718F;
        Mon, 29 May 2023 06:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8z62EMLX532VpCIYEdD39JR+MU263uSMLpmies8M4WkrgCiORKM4PQrrJUosrZLZEOiOMo798aavryX/BsBzrPxcmO9k1ao0GVKa6y2eQYhBMoIZrgs16zmYAuTe2VTC8ZnIdh7dFo+O2RrkEz7CuwWebjg5FPRyOCQYO6yBBe/6b4vjRlPx/ujsSApBdtY5mDwt0XsEWQGYKWflGSqT7dlGTohVpek3bQLb3hBErmK2EW+9hznnrBxnOZA832/tJ8pMJ/hvD1TxyvdKXy7vBANrR024YOmlc9vZgtgH3sZrJHniEgJuVRmwhpV4YeM75vU0Nvatzf92LmaJIDfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8a0SkoIDo6jEczOU5I35DlYbs4SJGSq9k4aQ5+tKx0=;
 b=l5mHlavWdi1dfw5uPBMiSYjFVuP/QvSRH84c+w80Ob5NJOXp95Q8XOCrv6GemxWiiu0hC0Z/a9OXZgxJvFa/ieU3iKE14UzLnI0+y2KfHYzx76IBsotnEgH61oPcaZoLX6AEcf7VIz3PMh1+/DQKW3MDS9oAdFWo9IoMVHgHpBz3p6WqDrksFU0r2v0D3muJChBl7875IDNzqjuJ0L7ii0nsP5daQYxKCMFQgRHxveV/N/1QMCGqkI4hAcc/fXS0VXKJcRY0sxRGbGvfjvvcYEIxWJQeFdnJYoVkVPPARyLNXWDzq0ChjSyNdjOqBVobm+WcmD2Dp2i8Hq9+XJJVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8a0SkoIDo6jEczOU5I35DlYbs4SJGSq9k4aQ5+tKx0=;
 b=UROUDcdGnEO5Tp02HZDAw+CyBx73YCpKEiHDhddsXDjrCLMikrT/+vuRoDyy75H7kW/HkNxYJ6E8pWjrIdubW4TyQ5odQbPsnuoGgJSs8ud5Pl4rORa8a1oce3gGGevuj3r9FDGVrNVVV4Z2qaK6BXnx8LIduyUupfvG0WraCQEKCIX4qQwWt2DFh7PQ9EKkR4xNLpqjX6fAQ+Q4aoNW7fQRCNGqH0BCGN6yZHuDPBukX7dYy5oZmBBuIl9S57AGxiD/I3Dnhitsn8uw5DUQpHRjZaQ41fwwvQI2fJyf+xlCrD35xOuFLKGF24qP4Xez7B0FX9FZC5RhrHTcSSJV+A==
Received: from MW4PR04CA0140.namprd04.prod.outlook.com (2603:10b6:303:84::25)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 13:55:27 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::db) by MW4PR04CA0140.outlook.office365.com
 (2603:10b6:303:84::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 13:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 13:55:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 29 May 2023
 06:55:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 29 May
 2023 06:55:17 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 29 May 2023 06:55:15 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v5 1/5] dt-bindings: mailbox: tegra: Document Tegra264 HSP
Date:   Mon, 29 May 2023 16:50:43 +0300
Message-ID: <20230529135044.2746339-2-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
References: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 794a9bf0-3c74-4d0d-6fb1-08db604c5b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SghPGzXuc/LScqoEHyur2I02b2IXWJLkPUfjB0PQ8IrhQJTqTy/GI2gctFNWz7wOzjx0OSE+s9HYWqaOS969sp31jPq73ZBMBV00ES41sTdJgUKdy3Yapydo8ddgHP8ZcTSA4jxHhhea07WTnzx2tWdYmz78gM9re+ni4lSZ6wlnmma3vvYZ6GAQ5xInPhXC9y7ikzUHhZcxuJ9fK/gqymyAi13NktzUOBYwSCU6v1gtRYSAdyziz+o2rRM63iZoxaatQ7X/qKGHo/81HCBG41opZs6fQk2iWPAZ+EIONnmBkBfAW1yclKejKKWCarj2jWrUA/TuNW7McUt+R3YC7n8WAO7T4bcBzWELlCxnhJ0WE8ZD6PdbXR0LsTEcBMlitKSFDqIRFU/Ty4yjV1cY+ne+cJMfOo0k1f04tBNmSFDm/V46gfSW3y83kkrVS/dO2dGcfxHogBTEbBeaTiKRn1PrLDNK13hklrK34p0XEJwA/3AzOfYre+LDWJRFIZ/VldPPgAuSXA98O4D5KImS4dcKBAVvHaDvK4goYAWLL0YQqPLiNa1BFzVuTxmocIgSOigVxOsmS7p89Nd7ZEBcSztpXEG6T8rs15D5rEPJld6cNqNcJCss1Vjykk/Gd3OB1uRMB7n+OTQQDGADf+uissY//W38Y199/AZysgjyibfduAAzeRG9SxXuyN6FTTjzzy+f54Yi4XOudpyEdUvI4B/Ng6wSrVUBxvrL4tcmRWNUKX4+EPQGScVMZt0mdDVB
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(478600001)(70586007)(70206006)(110136005)(54906003)(6636002)(4326008)(316002)(36756003)(86362001)(83380400001)(47076005)(36860700001)(1076003)(26005)(336012)(426003)(186003)(107886003)(5660300002)(41300700001)(82310400005)(8936002)(8676002)(7416002)(15650500001)(2906002)(7696005)(6666004)(40480700001)(2616005)(356005)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 13:55:27.2133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794a9bf0-3c74-4d0d-6fb1-08db604c5b93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for the HSP block found on the Tegra264 SoC.
The HSP block in Tegra264 is not register compatible with the one in
Tegra194 or Tegra234 hence there is no fallback compatibility string.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
index a3e87516d637..2d14fc948999 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
@@ -66,6 +66,7 @@ properties:
     oneOf:
       - const: nvidia,tegra186-hsp
       - const: nvidia,tegra194-hsp
+      - const: nvidia,tegra264-hsp
       - items:
           - const: nvidia,tegra234-hsp
           - const: nvidia,tegra194-hsp
-- 
2.34.1

