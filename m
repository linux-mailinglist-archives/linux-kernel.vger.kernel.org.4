Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F3B6E1950
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNApb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDNApM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12hn2238.outbound.protection.outlook.com [52.100.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8145F26B8;
        Thu, 13 Apr 2023 17:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcW9db70yjlo+u65AUm76UKjTI4HbTC//Aoj8i9pxatcvrGk8KU11u4nBuUGSsLAe1eh3ROGkPwCYk5474Yo+jm3/Xu/jYmEJ5TMaSxmbAKAcEjG29t7/G8hzoGjUuaEK1sCvArbcx6LXr+3vKHbYJQo+0V042X+fMANKIm+znFgmVwm4QmAlcmwO/2+e2KhMy+KDAbpwCMFvABvvmL/SHFmKN6jX67OtApqxE79YXBlZD0uMXP4FcQbbvAfN/XyvPb8usvw+ojR3aC0MiepUH4QfUyzywDoEFoNwc8hvHoIgRn4ueqWGndCoog8+NIkBSf5PD1bjXUktLQqu3MWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VuXydsVhYEwxRK1w0P8PtVMEifqFFyAoGYf+LUBVEg=;
 b=jo140fIGEn7FFg4K8iu9OgZEo6+Bgey6TkQEAppUkgz18U7uSZ8EI95p95cWeDkKQ7F1DSv5OCG+CWQixnqx2dEL08AZNAZkVrmxYgZokNk7WXjpqePgd4lMpolQaj8KfuG374F0mdUzqi+MiXmh/wrbSd7NMlgMX8ZqHUhWXyv061VBUUFlYc0Da6V2teWDDTOjkjLQHSt5aXB4kr6PVLztuZlN6KvhRTDxD3p2H4OkRIQaI25JS8d5o+Gz2oVQInOKX4BAwRcfKwtLb8Qbq18yhaiqI0HgsNxsfxb0jH008A7Tq1k19kGyWC8Oi/rqgEB2piOvaYc8gEhT/UqqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VuXydsVhYEwxRK1w0P8PtVMEifqFFyAoGYf+LUBVEg=;
 b=NJJLdtjlrl9s9CSZtg8CMkXNKFRLvi9qYbHviwgB/BMElFK83OhwVa4vwGJkBoG81g591fqP9DsBKeRYYxvWVra06ew35o6W6QHYmlHN6vKRklIXE9LoasX92ysHDPK9SOKpltLiLjxNvBTMhW5E3zs2DWB2LAQGDUcAgkA3w/vKU/tKQgdYU6hJWfDl60UIlxdKH2UsAv304efJ+pF3VrvhKV1zlaeIWwvrVBVnNCZoj5Xgp6pok2mqMhxb1KwaAeq9vlebblJT/bJ5dISv/3Wah0nomqUWjd9P/IQgGCDydrsgFvQK1jvY3cazxcTb8cV9F8/OQVTVECqy/8RFnw==
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 00:45:09 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::6b) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 00:45:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:45:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:45:02 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:45:02 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 8/9] hte: handle nvidia,gpio-controller property
Date:   Thu, 13 Apr 2023 17:44:54 -0700
Message-ID: <20230414004455.19275-9-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: d377e27d-c0d1-4b8c-f2c4-08db3c817fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvFhk/0H/3m6XWvqxcv+x9ofcwfniO1SoglmbEZwmvBDBZJd1C7iXc++B8CzoxP80O6Fd5+S01MduxD+7hVGOSmOv47PJYdIHwHF3C9jwavZmRDMMSdPfuOX1Onq41tJrDuxNgNa+nW6sLtez3LixziK/eYiJRj20V+AfCvpdirbYJsh74dSWpY/T6tjCakYUrcOxHMuE0pZNr9e9aP+bfjlDsmYqjabsEx3e45kGn4GLb9qhmcdIxpfc+h6C6M0xEyzzxzBhVqV6ndj1PWP1X89NpKepnn3wo1ag/aiZZwrktuF+c3OrnCIKXkKTBUioOwQyrbc/KOFvZgvgnGFH0Ylz45VMFKlpypF1MpJbTc/Jmz7WHfah+ooxZj6guFWO67BzlodXNXDuEfE/+rDrEA7QAqGDpN4dX6/p7FAKAIPlKTdvVW8J4SbroS3KPrCJIi4pPjwoe7LLNYUEZibCvSjqmIjpzhv3oiGSpF8lThGnsrFv7SXlfrraamcOI2VIwCtw7NnKJQskO0Z54OBaqbjGv5NYcR3qUIeA7CJy8Q+C3IA9ES3BmSpLlWEtEVvarZDIvC1quM+4QlyGwTvR/KdvSeNa0f3ThCYftwi6YQEaanpiedyVnyvEwMNsXPmZRaraV2aRf6iFQWcBeZWajgwTeyYqck7yxFAVUqah+RfykQESsZTHjiX4VCgO/B3T2qQKz41DwwERq153vBS/EOZAHednRqSyfAUzNNdNjgiqceTkn0zUTARWefzHktVoPPf4lUBwjpl1jf9zmxwBG/O05wRTpK4mmlRJQWExDpnTWxQUya1GWXEmyOukIoD1alFvO04/NLJp7KbJ/7iPv+L1hprSsJ1BMBvyPPYsoHZXJ5PCzws9qZyuUO/leDn
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(5400799015)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(107886003)(70206006)(426003)(1076003)(2616005)(34020700004)(70586007)(336012)(47076005)(82740400003)(4326008)(83380400001)(478600001)(6666004)(7696005)(26005)(110136005)(186003)(7416002)(36756003)(316002)(5660300002)(82310400005)(7636003)(921005)(356005)(41300700001)(2906002)(8936002)(40460700003)(40480700001)(86362001)(8676002)(83996005)(2101003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:09.5753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d377e27d-c0d1-4b8c-f2c4-08db3c817fdc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

