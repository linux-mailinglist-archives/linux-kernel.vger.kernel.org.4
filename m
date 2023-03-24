Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5226C78F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCXHhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCXHhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:37:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554F67EFF;
        Fri, 24 Mar 2023 00:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC9hrsB/i4+GDPf3kFwC8kEORlx0Gkj5uY0COcvxvMY1rmldOZpyZLEYQhKdKl5i29gk6wDurGGo/2YXzW3Stww0S3lRMLigb9pIoU8i3rUKRb9j3pZNu8fy4sbFBoi/rrNjIEBcdVInWLCzW2sZ+EQMcqYLL+xilhHufcKr7e8A6Jhk53oYJ2VhHH3VNlqZ2oetM1VuhmSeHYlQuZenwQBZvImvACeI1zKK+Rw7+Vj6ymvqinnmk8QFeGGFlFB5jS4ZSA6C4I1dAWsTDxw4oH1yzYzcZ2CydmJaXJ0uRgF4awBOgGu2tYMUyexOgi7scbjx06X3gSDjAyrpjSuUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkCF1GGqJ/HUOwoftfsm91+KtugK4sNOjHYBbcMLN0A=;
 b=JiDLSzoskUmVsmzgUDc1SKz8LS6t82MkFqwB95MEBR/yaTUw+KYsga/M0htjxxIkO4jPYOOSGzfWmHlIwZcHXM6RXGU+im10tLdQ6qpb8EpXvzZwaGSolZ4PnKDXNNod5v6q6cKFHA3rpws8jF+SRU8aeNURm+Ni3xP1nPJjO+PLNH1rdt1cwbQyF6e0hfM1VSGb8NNjmEDSRoVYKCGkff3Yd3qOuXiPwOhrzUmfyZWW9DAYLhLsG3CZEb9j94FIM8Gq0f33hwMzoGoHiBG2XaA9lw23dXpcZ4csAtB47RIWNxrQMzABoX97+xM6AWjekZF3kOJc1/P2CZIIRLBoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkCF1GGqJ/HUOwoftfsm91+KtugK4sNOjHYBbcMLN0A=;
 b=IJZvvaYI2veVQENWe898nNG6Q2gj7zDUUDNU35aUtMWthKhZmUwzGONq+QMgSydYK3SRrEtAoyl2vXz3W/OvrZPWcoEMU5qY3IWK3NkDmwMiG8rmRuDXOzoxTtFnYzhJ8Q8jNN5xJUl6UhAflED58wWYVA6Pw+7kaof2s7+0xFA=
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:37:07 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::a) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 07:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Fri, 24 Mar 2023 07:37:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 02:37:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 02:37:03 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 24 Mar 2023 02:37:00 -0500
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
Subject: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible
Date:   Fri, 24 Mar 2023 13:06:29 +0530
Message-ID: <20230324073630.3194724-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
References: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f232be-e7e1-4af5-842a-08db2c3a921b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0JZdoTE5Th16fjUFSJ/cQTWX2FlpSoiyoVrEqz7AdIc1m1umybZ1i/muFmhmh6pPxBdDaVzymIxfCW3oo0nSkQnszxz5AwB8+xO/VMuDW/J0jAqW9uNxon40rGxJJ33AQWLZAuLicNKLo36CupneNf06/x5ycE4Eu8b3Ln1yZ62XW298D3UW4aTgpWQkidMRxZf0ywU08ozvUazeQEZ+2XlcAemKt2AdzyiSs097MQcAp+q6w3HmUqIwB8AcpQ8bq5SyWOGcnsq6k/G4oj2uwBF2qxonX5kfn7nA65igpJh9VlEnIxkh4oRkctqkGABnwgPjtv63plJtZ2dVabkjXLD9Xlr7Rn7z+795XAOtJwgkR1j9unLFmsbCa6JInnjDx1ISD1upXD+YvJZzUapiFuCyzOuTRQP3uzQV3eXPGiw6WivU3z7ey0LkCjC3r6+7sRC+aWQ6gXhIZ4htdUnBzwqodruDFg3VVN+zzhAFqNnKyi3U2I4+uP9sbzZo9sSzyzzU+vwgbjM/iUn3obExgmFFkyDxkvjzailVJzDQWZVaFLVbI4ZLjyN5TaxLduqsvl2Wg7zhmm3hF1znJYTPC8qgDDVmKrtrBYgy74ufK0buTFjzt6xHOr1j+tUL+mJkmldzwr7rIBjjfwJJvlWN1rb4AZ/jlKZb23qwHqeJZveyVnRH0RgZwngXeb0v8aitWETXpMBAeMPOpxteql8N1l8y+9aD5k/qbzbPwDc0N8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(70586007)(4326008)(70206006)(54906003)(8676002)(5660300002)(41300700001)(7416002)(82740400003)(47076005)(1076003)(426003)(81166007)(8936002)(26005)(186003)(316002)(478600001)(2616005)(336012)(82310400005)(6666004)(110136005)(83380400001)(36756003)(103116003)(86362001)(40480700001)(2906002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 07:37:07.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f232be-e7e1-4af5-842a-08db2c3a921b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx Versal Net compatible to support eMMC 5.1 PHY.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 8296c34cfa00..cf44a4b988a7 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -27,6 +27,7 @@ allOf:
             enum:
               - xlnx,zynqmp-8.9a
               - xlnx,versal-8.9a
+              - xlnx,versal-net-5.1-emmc
     then:
       properties:
         clock-output-names:
@@ -62,6 +63,11 @@ properties:
         description:
           For this device it is strongly suggested to include
           clock-output-names and '#clock-cells'.
+      - items:
+          - const: xlnx,versal-net-5.1-emmc     # Versal Net eMMC PHY
+        description:
+          For this device it is strongly suggested to include
+          clock-output-names and '#clock-cells'.
       - items:
           - const: intel,lgm-sdhci-5.1-emmc     # Intel LGM eMMC PHY
           - const: arasan,sdhci-5.1
-- 
2.25.1

