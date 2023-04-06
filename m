Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210896D9E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbjDFRUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbjDFRTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB118AD3C;
        Thu,  6 Apr 2023 10:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf5SA45oQ4xYcXnIOTbnSOQdXJ9Yx+AcfyUmwN/+ImKaHQy9iYcjJTsXm1wv8fslIT/5MifrCF4sx6yXDG6uF5Lp+EkWt+bDVbD9BGwh5kQ5fZT9MwBJmx9TaiHIoC1aaAeuYOQwJRYPNaPERBonLR3WwAP8+Qc4bjjCRafHnUuu29+ZLQbgop1XK9RDnwlgTg1/Y1FYiwg8wh0WCdzRQLupqPhV+vBV6420KfCknAR+2ZQY9H31/Bid0tiLIny7qHsukFOXFkZUA2NWkcSbr6fqW3TsMCcAHEnULU/vjDF6ayi5jCKzvmAx/m9FvE60YjafiBktUGuKOxD5vFHCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VuXydsVhYEwxRK1w0P8PtVMEifqFFyAoGYf+LUBVEg=;
 b=SMN4IfviBGRDJzTMVh9GiHj2jv/yrjG6zZSae3NfHHAVXKW84wQ3M8AdhGPWaUA9Y8bNPb2oSM56FgYRiA1nEVRYqBEV14QGzcR5cSzZUVczheubUZrw+5FBPsLFL+isWSoBCluda2Nl3qwOicowwATFmSfmtoIE5Hj74NbFTAVJGhdR6l/Wxx0Bo7pQ25P34y3iEA5ptFqzz+eK2kkfZGf61AJIE+CEpfcFxrXI+jQ7HMoD4h2vGioklzUyUBlB0EG/ruJjze27k89o4MzjLB75R55+sJ3EQY0ilqR2HQ/A//DDuDnhdYXabz5s3sZAeZpg3+Dy9hg0H3/EkqGLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VuXydsVhYEwxRK1w0P8PtVMEifqFFyAoGYf+LUBVEg=;
 b=sIjtPB1v2Um4FjQ2kzklU46/M73/FrGhs82rbHkSNC/erDpGTnx2n7o7fbA8Mkfw5SDW0bXnYjDxrtjxZ2x2LXpOhdfFHnfYB7vGIRjqsnv01Ha6yKHGWtdj6YDc/hPz5dkul+MCdV7Qz79Yoy73GXSXOhZl29OGfWE2kdZfyVuWghGsa0FxWEm3kLJlS3VBTqKdMNYFeOUfx+OHzRL4R1PTnhZz1klIK47j6FLM30a9zqUXc95kYAyoktQWCYyk0FGFakCK3CrdcxI+ccUkRQX8yEjuez6N3Co1HFxw2K9VkvPjQWTxuvZih9ATs4s0CQZhM4pSOpnYG4XOz2/g1w==
Received: from DM6PR06CA0006.namprd06.prod.outlook.com (2603:10b6:5:120::19)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 17:18:58 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::80) by DM6PR06CA0006.outlook.office365.com
 (2603:10b6:5:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 17:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.33 via Frontend Transport; Thu, 6 Apr 2023 17:18:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:42 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:42 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 09/10] hte: handle nvidia,gpio-controller property
Date:   Thu, 6 Apr 2023 10:18:36 -0700
Message-ID: <20230406171837.11206-10-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bda54bf-04b4-4772-4d45-08db36c3021f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU6AGDBfJc4Xz9zCyg2gH+WecGzibCPAgoREHJB0kxoj4kEEx41ALQvFTu0A7SbIPYtTZDNLVOlm/Z4o+fP4T6eaVkCRRFbogQXVaF4GeMw3Ojfb4c7UstidhJD3YgyawbpdihotWxO4yTX+7iU8uWJeGU6GE5/G7p8bYBnmNJ9isHb7bC14Ssd9F7q1uEARJFXuI5KZiB3DICD4aokXCONe0KD7pXZHE7veWAg9gbGVyu9RXJNpad1Dl1va0yyT+jQWmlQvfZAU8pouCECS3jH+bkwkaGpXGYKIRUj7/cflA7J9UUurAi6vdwha39N77T9JsfaMIUsXOCez4Pae41vbtYvJps+QuoDietRqfSeo6yUSQgyTrzc+sQCRLVEHGOZYk3TLvwlC/YjqBtkVabX5O/o8pGXMlUWvTxkReQZTtIUrHhXHmkJRzU310VK48zdPTTGXPUPsAAcHC4D1hC2X/0v+HN1jtkFxmF/LbWKnQcrEDZHRKIC+3O0ZMPS08Nun9zaQ8oDHO21Cm864QCszp9qB/pyzw11TlIzfpfHlEA+SkY8cSW7/HN6Ld2So7INsAP4mau5yugQ6gOvc1bn+TCWpbbawf/ync4NVe7iddEv7CvgxiNjTdHi1nz2zKAmkvUlTlmpTvHeUWyQ6WftLltRuGPfSmQqG5OZ9109JTaiIwdtTlzLfw7teZ5JBrnN85tlrEzbxB2LeY5lK9Nqxk2x7DXVHyOePyWayXwzZboSmZlQZpDOfnJhh2lcOKWXdO14jKAYiHGgNQ7p0kGbut+9HHR9g0CA6nQFeGRhyGB+tPERMoj8moA5UEiVV
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(36756003)(7416002)(2906002)(4326008)(5660300002)(82310400005)(40480700001)(8936002)(7636003)(356005)(86362001)(70206006)(41300700001)(82740400003)(8676002)(70586007)(921005)(47076005)(336012)(83380400001)(2616005)(426003)(36860700001)(6666004)(107886003)(186003)(1076003)(26005)(110136005)(316002)(7696005)(478600001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:18:58.3623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bda54bf-04b4-4772-4d45-08db36c3021f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt binding adds nvidia,gpio-controller property from Tegra234 SoC
onwards to simplify code handling gpio chip search. The gpio chip search
is needed for the AON GPIO GTE instances to map the hardware timestamp
GPIO request (coming from the GPIO framework) to the tegra HTE
providers. The patch also adds new gpio chip match function to match
from the fwnode instead of the gpio controller label. The addition
of the property does not break ABI for the existing Tegra194 code.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/hte/hte-tegra194.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 945c68c5e476..2c485ff5be22 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -679,6 +679,11 @@ static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
 	return !strcmp(chip->label, data);
 }
 
+static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
+{
+	return chip->fwnode == of_node_to_fwnode(data);
+}
+
 static int tegra_hte_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -687,6 +692,7 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct tegra_hte_soc *hte_dev;
 	struct hte_chip *gc;
+	struct device_node *gpio_ctrl;
 
 	dev = &pdev->dev;
 
@@ -754,15 +760,23 @@ static int tegra_hte_probe(struct platform_device *pdev)
 		gc->match_from_linedata = tegra_hte_match_from_linedata;
 
 		if (of_device_is_compatible(dev->of_node,
-					    "nvidia,tegra194-gte-aon"))
+					    "nvidia,tegra194-gte-aon")) {
 			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
 						tegra_get_gpiochip_from_name);
-		else if (of_device_is_compatible(dev->of_node,
-						 "nvidia,tegra234-gte-aon"))
-			hte_dev->c = gpiochip_find("tegra234-gpio-aon",
-						tegra_get_gpiochip_from_name);
-		else
-			return -ENODEV;
+		} else {
+			gpio_ctrl = of_parse_phandle(dev->of_node,
+						     "nvidia,gpio-controller",
+						     0);
+			if (!gpio_ctrl) {
+				dev_err(dev,
+					"gpio controller node not found\n");
+				return -ENODEV;
+			}
+
+			hte_dev->c = gpiochip_find(gpio_ctrl,
+						   tegra_gpiochip_match);
+			of_node_put(gpio_ctrl);
+		}
 
 		if (!hte_dev->c)
 			return dev_err_probe(dev, -EPROBE_DEFER,
-- 
2.17.1

