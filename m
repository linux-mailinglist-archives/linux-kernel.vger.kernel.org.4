Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACAC6D41F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjDCK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjDCK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:26:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB684212C;
        Mon,  3 Apr 2023 03:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAwCxFWWOuifJ/SrafMz/6vUBxmK2+VZoZLWy4RkxiTctifILg0nO+8IPAlEO9N3KjZqrZm2fn3Q3LZjduYJnQFOshlJ+i+U1AipFu6M8Xd/wOQJZUGSLwLVy/YciWcO5Mc8wmZQNqTyoRmM8daOVmPKHaaDlouHnDcnTi28zHLKb9Kp0aoWrDKxfI/EdMliWbWqGn/QqSxaf6h8LpPQUjEwx/fZYMa0zInjjKwCruCmTIDjjKuy/dDi1PRtF1oiKg8dAsYivvZBpCC0IoMjGegtki8t0p+wu4UiPC+43y27xeuePsMKiulB0PB9TwqCA+SAsIPPaeHM9+5r5xajdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQmCSXqwpCf7GE9DbmhLgOjMqbzs8lpNHdiAwleC5nA=;
 b=CwVsbydhOXKVeXMpLddJr9UyRPAaY4IJASLrehDbbs0Sbns5IyQ0gl5ZqAVT2JFMalhPJpoJpoIwjfu3/4//OVIlqtPZSr2YhWvXIbIP33rG8Oerw2GrymoG5+Cv5KvXxyZj8Ftn45xu+mj3K8zh+TKntBM6+yQD+x7oBkvb5C9UjgmowtaF694g3A7Q6IGEI9qvYmlgB9vf50zCkCPwKRqdgAiY2yt+vbeE6vBD0cphG3RnMI1V08FnOfBiE+VproaKQUBNHgarG+Hrn4LTbr4nN+6bzALCZvClxkwcvLgHj25GSXMlUTk8RvWzguSMZUrtvpQpQywUDQpDfFbwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQmCSXqwpCf7GE9DbmhLgOjMqbzs8lpNHdiAwleC5nA=;
 b=w1kfAjs8omseqfJBPa+XO+bxOq7APOfnVN495+gAEoTmGpDz4CuC7YruUVH7mT8yja7FdHjHpJbAwoDdKtaIN5tNe03TuYNmrpN07yAspBHBGsa3BdNpoPQouE+HCyZE2ZogMbxrNKThwG6oKn7U6CQKpFau8Oc4q/3qwGP6lUc=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 10:26:13 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::d2) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 10:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.26 via Frontend Transport; Mon, 3 Apr 2023 10:26:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 05:26:12 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 3 Apr 2023 05:26:09 -0500
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
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible
Date:   Mon, 3 Apr 2023 15:55:49 +0530
Message-ID: <20230403102551.3763054-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
References: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3c7f3b-f826-4a43-ac05-08db342dd9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iy6xRUam/F4cPkUDkR17OoktWflZAW1kqlO0AY8aV7BHhp2IF941s0aJ4FGRVlx+PZm9clXqnwklHR8Njif/q85tmKoi24ZweQ1PnhM8v7V00mKxQoe6FwXqfEzo3wRugUNdiC5dhPx6bgtde4i5L/XuunjsOSsNF4VepaG/k8PFogW9uTfn0hApfR54km/k6EMOLI31W/YftEFchqVj+rWG/sev7OX+SrV2LKoqtdrvEHbrH8DH0U3tKl6VMeVEBQXdXp1Wa49TGZSh2DL00Kv9WnAfJBXQ7BhWwa9QFxdrwn2sc4c2JxWpg6ZF6uu+sxTtygoYNWXt2WQ7Y59RdMkBOhndW8/VVdfZR/l+iQKn5cLjSPAVu34uduorAQIZQcFgQDZ8M1gRV5faPusYYbIKfjHFTY+F41f//70KcM0vCySE2nLzcHh0QFHUEbcuj9/NDEYs68m73DKWyICW7z0MPS2IszfGaonDgk/VgOcjVJI5+bc5SUheFo92fGGVpnSwk7GRzUaI1iA6Jc5MtLfUseCEMqSBig3ag6XcCsgXDVOA+Kt5gBTu5HdP20fOO/bbAMlj5f/sQQ/V/PYQp7yeczvWW5EdSsHXV3L1qvEP+rLDVI/0EHoTYPj6CSFbEcEBkZnThunen5qUjO7bNWJbouvbW4kzvzkzzfKXdfOYY9uKZl2LkqytPOAW99FL1aE2wMUb8nc7DI2N0LcDREizcekmRf858kk2ec20StA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(2906002)(36756003)(103116003)(82310400005)(40460700003)(40480700001)(2616005)(186003)(83380400001)(336012)(47076005)(1076003)(6666004)(26005)(8676002)(70586007)(36860700001)(4326008)(478600001)(70206006)(81166007)(41300700001)(82740400003)(356005)(7416002)(5660300002)(110136005)(316002)(426003)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 10:26:13.4633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3c7f3b-f826-4a43-ac05-08db342dd9c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx Versal Net compatible to support eMMC 5.1 PHY.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

