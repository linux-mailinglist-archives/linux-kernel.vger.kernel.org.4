Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5596E194B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDNApp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDNApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2233.outbound.protection.outlook.com [52.100.157.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DBE40FD;
        Thu, 13 Apr 2023 17:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXR7N2jUA9f70SB0WR0ZVhMVS9PHzxGG5IIT25ElPisMOJENSWQuNXl3ZBeGIHBDGHHcAO6ECTnynIW0+Mxqigp+m55YvYNwCMRsIMFwEXTxQNFUO2EwXOmyiGOmOJiXN0tId85uPeTBxlBKg2sSQd2u+yQV/4hRKqVUsxa8NSL/vOCKKqMTHNmgnU6hVu1HtGSeufRMHWQ+SPNXe/UWlo8TrR0Dqh9u5QCrGvw70h08WvMKPCctLn8Ywj2E6tGkMagYTAoFzXiy1dWI4MxszaQhPw6MMk8It+oRUkLryxNG6qgeE1nA3cHEAbjljM8z0EulPnOFJ/lIT1jQoc+zgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0B4e4waDo/8ygYRfAUPi4j/yHBgi9ZU9AnjB6UuD5k=;
 b=KcGjZDGPYE7lSyijQexX9eRYRJsws2AbD4t8PePoBAKZQbO272pZfdGd4QuNCrJiN6iepqomQDZrtdIA4teiuUD880r2L0A41GT8ezOhZrbRj0Li+DVCx0UPr4xsdLWm5EjeB24gzriWA32ttbFrWkJVjNoP1GDfKw01qryamsdFQAh3mq7cWPyO/BMlMW7vryfEawjBQLAt6GreQ6Q7HdL+TV/kdyo0D7cMyKh8pqgBWkooMt2EzqUXvq4MxHy7GHDHJFLpDd/r1mqf1qFrmW+UeE1puOQhLGH46SMjfOz2yjob5Hs9bZinfQvwPvX1gV04QImkvk01kF+5QWYHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0B4e4waDo/8ygYRfAUPi4j/yHBgi9ZU9AnjB6UuD5k=;
 b=pqVji3cx3ZfPFTyzikkMZcb2HaPhDfuX4MY7shLJW2Vc3ObfbPR7psSOo+LIrQTQvfabe19P0EOqZnT7Yu8kU5IAmgtGGmNlOz11s5/MDKCoH7l/Pd3vdgJEAp0U9hZR6sveDgy5L/BNNrX4nMSUKF0A0hIBc75lCFj1cKpHXOfO24cF+LzLK+jWSOrEcku07P5Cx3NKu3Ln8D0nt1wRpPgrEpVa5K6W3pvdh+f5QjkuPOjikJiYBccw9ni7zvGpHZk0zvcoOhG2rfufddfyoNSJwYk13lPSpGQZm6nkkNwC9froN/X7GfPJDoHUQcbHBT/WxpRmbX9e+V6E5fRhSQ==
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 00:45:14 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::6f) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 00:45:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:45:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:45:03 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:45:03 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 9/9] gpio: tegra186: Add Tegra234 hte support
Date:   Thu, 13 Apr 2023 17:44:55 -0700
Message-ID: <20230414004455.19275-10-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e68dc6d-848a-4177-f71c-08db3c818211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMPc5E7fOWXmu5zdiqWUx+aaXC6baQCFy0iwNl33dRFohQVOSD8cSrwdAWcxrSi5i+xsfP7kMIgxxek025dYUiaqptoQwY9bvcrOR+/EGWwVzWuaOLNJd0ccN5Ecibu396GC8r2A/32xjyDbvnDFjW0/Eyl8gESeVUzEoX5SgkNxU+a6rb7k2izTHXM7cYZbPJsG8qF0fnh4hfYMixtoKQPpQzO7bTnf9AKzJSRFiAhwoP1V6re1CC1ZN+RXmj6dykHFvYz8J11Vhdidrs7a7cfeSBUdif6N6F0tofbMTM669NBHtBOOQZKdD68H1Rt8iUnoTs/WoeXzJW816pXr9UH8DYZ88wzhN3T9bH6WMzMKl3NRkVFPXC+WXXxgh4jXxtF/g9/Gg3Jp/a0VZQ9iN45qPREEwr/cOVzKfa0b2E74PkKgyFrEdxETibUB21sNeMk+jObipVNtaWKSP+PP4tVP5Yl8X0q35ULJppgNgd53yuGpr4QjAAsVoPMErORAGNcpIFajJjKM3UUWGW+n/ktxVVU3DnZvAe9UQ5zJZEsH6cJKJ3PXYZCTEPbCNmzdqJ/vn8SyMjrElLmvZiFteBnQ9CVDEz3nUOLwpB+U2Rqa++RHiwr1WxESp96lef7ddv7W4vGs8h6BhF6H8PDie4cc+nd6cT6Hk7rnlGGsjv5hYt2WcQa7PPvYsFSeIpWaOYwzIb+aY4LyBkyxtkDdMebd9+/pAuojjUnHHM/8v1mXUEXFJkNNqZ5KpjgwrAz1IxjcM5VSlO+9vtN9GNg0w2XZE2o8DBjY40ziU4AXDBETsWR6UlHVqPbAsf2ZzIFwhw0Rjp6D0avKsYfk1wXlivEADdg58JcpQgAIGROeWMpda5xaM1X8o4xCM5MhCkm5
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(5400799015)(36840700001)(40470700004)(46966006)(6666004)(7696005)(40460700003)(4744005)(4326008)(36756003)(70586007)(70206006)(110136005)(2906002)(7416002)(86362001)(356005)(7636003)(41300700001)(5660300002)(8676002)(8936002)(82740400003)(82310400005)(921005)(316002)(34020700004)(478600001)(40480700001)(1076003)(336012)(26005)(426003)(2616005)(36860700001)(107886003)(186003)(47076005)(83380400001)(83996005)(2101003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:13.2782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e68dc6d-848a-4177-f71c-08db3c818211
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable timestamp support for the Tegra234, has_gte variable needs
to be set true.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 14c872b6ad05..b904de0b1784 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1134,6 +1134,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc = {
 	.name = "tegra234-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_gte = true,
 };
 
 #define TEGRA241_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1

