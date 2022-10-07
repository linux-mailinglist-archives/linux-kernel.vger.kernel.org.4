Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBE5F7410
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJGF7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGF7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:59:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577CE1BE97;
        Thu,  6 Oct 2022 22:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvhL29dQ1fzyoklk0yQT3khT/t3dva9+dA3/XU6xpjjQlxXRSRmUoh1dWMs9KsiiH2hV2UQmWrbzOWd4nFdOAOQEvWfPurOIGX/Yh5JdJefMdIb8TkXkYZSV191SSi6Q1CPVed4vhqkKZ5U6oVfGANLeBQGCbRNpr9LAw0NR+bCYjUuYEXF+C2JqmDmITTi+d5c9eJ2UlAABly5DEb+0H2kctsgrRKA7bJfj/48iA3ZESosCueATulghsRRRz9d9YnM3Wx7jkrzytd/Fqb7nGFEBUbfz9wsTUEzYFmS0OyOx/D8sCLwMRnGcmMdFrA9IwV8qtoZcQp+0GVOseW/2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OgyPtrvUXcL6zZfRrp30Q8VLrpti3u4Py2eejB8YU0=;
 b=hY9gRzh+g2EVMP78e29NEoW8QZB/HB8Di3DGlCeIVYTR+VAkqPVJK3ecBmtTOUDiq5/BUJm1HdBDKqD8o51ESREIkuw94yUPERpyXaR0TkmHf7QwExl2WA4Hn7H5QcVjORbr58XtlJ6aUB1GCLjzSDj6Je8uLQqquI8krW2xXealqfkYDIWpcc7f6dHIrUHrsK1h5OcXkOi865vhsHuZSkt76EICfkB99MHkCMAME9ft8f0SzvbPQqEWVu7luXNuRbPiGv1y0Zd89ZysE3SrnPq3XPrZiqh3Casby0eV6myhNXJNvBWoVs8lHfg7mSP5SNkvd36E8pfcdS2dgr/3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OgyPtrvUXcL6zZfRrp30Q8VLrpti3u4Py2eejB8YU0=;
 b=R72Wjkp4LuziCMR1iZ3jL0IjN9/Ai3o2hQdZNoSyY1BMqNMz9htfhKKSSBqWMbCtdamxxggUBxz3p/b5Ixzergkj5QksX+XVDuon9iXKSoqwB2XvwOyXQeygxx86c6UJ6QDD0UzDUVQgzLVwOZMuDKo3fU8scvOIacoGnsehwAeuks0ba/jAU4+4IXzGRn9DcDVatyov+Oui7AT/3VJWW8hS/4XOHeAITVAqvs33q71D+iosXeBsou5SiDgyUV8XCtn6jHscbiWe2hf6fD4E2E74IS/+MT7xirdUcA7jqpWYaU/NdIA1Qi0nLVSIHeYl7JV1RhnUyEscdFNwJ4069A==
Received: from MW2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:907::44) by
 SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Fri, 7 Oct 2022 05:59:47 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::d7) by MW2PR16CA0031.outlook.office365.com
 (2603:10b6:907::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Fri, 7 Oct 2022 05:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 05:59:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 22:59:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 22:59:42 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 6 Oct 2022 22:59:38 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <thierry.reding@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <jonathanh@nvidia.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH v3] gpio: tegra186: Check GPIO pin permission before access.
Date:   Fri, 7 Oct 2022 11:29:36 +0530
Message-ID: <20221007055936.5446-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yz62XmiH8YG3Dtsf@orome>
References: <Yz62XmiH8YG3Dtsf@orome>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c3f2ed-30e4-4a12-b150-08daa829238b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L50ByEaTRwTWpN5C2NFOnI2WvPSZqFle4zaoEWFW3F6Rf/Bmcr1nWkDMgZ3qb91JXyK3dRqQ39CvDAkJprU2iAYN5iWLy7pL77eOJP7NaJMHp2cA/6Po2Q5KeiqPBLxdwGB9pp3u8r15AOoPvQRTnIdr3JXcOKxp2id/cJAcMAYaS977ThzWHnxyDdcVyoF+900Bb+Y3XbgMjRio6WfCWl88Zen4ew90VXBZOiZAWMpkI/irhe8fcI4mIAJKsJKTBDnUuKSZ+c67KnX0MNN/ELk9OVCTKaEi7htPSGoOYCya+Qra3MOApM2IFKuKtmu4G+ahjcK95TL88NSbiblT7Q4v1clMNRCKkMEOm6E5AO6F4x/m6xnr5MsW0n+86G023qrsgDf2sSsZKYAS9+QcdUU6uVr+bbeVW3zj6rsgiyjQsckq60BQZB9AUbEJ3hH0OlAYvKgkBrVZH9AleVPM/QwlBdY+yE5P6zFZSzP9X4FKU1ogVuLAqkiKsTVoe53ICI/f0xVJJh+zoTaxeerQV57iMgDRSnanWC25vZxagBLH9vAn0yBZVw72u4ZzOP8lzrLxYz6pcc4eNtC3UXzD3zC7zT+fDcFP3OPi21Q3Hn0so61dNsVRUldAUYO4KcX9Wvi921V+O/YFGZZB7VvlmzNIf0vIdbIMjWhbcUQO+Gi5r3wXu7g5p7HEwYGNG8xZZ10djYi6WcPuBKLDpohXa8AYTwK5dh0/arqXriHd26mMLglwQybVlZ7BYEmeSU3KfyAAaoZ8SUjgj8LaCGggDA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(70206006)(82310400005)(8676002)(70586007)(316002)(4326008)(110136005)(54906003)(2906002)(41300700001)(86362001)(8936002)(5660300002)(36860700001)(356005)(40460700003)(7636003)(26005)(82740400003)(36756003)(40480700001)(2616005)(426003)(83380400001)(336012)(186003)(1076003)(7696005)(107886003)(47076005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 05:59:46.8891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c3f2ed-30e4-4a12-b150-08daa829238b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change checks if we have the necessary permission to
access the GPIO. For devices that have support for virtualisation
we need to check both the TEGRA186_GPIO_VM_REG and the
TEGRA186_GPIO_SCR_REG registers. For device that do not have
virtualisation support for GPIOs we only need to check the
TEGRA186_GPIO_SCR_REG register.

Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 78 ++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 54d9fa7da9c1..873b476ae8f1 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -26,6 +26,22 @@
 
 #define TEGRA186_GPIO_INT_ROUTE_MAPPING(p, x) (0x14 + (p) * 0x20 + (x) * 4)
 
+#define  TEGRA186_GPIO_VM			0x00
+#define  TEGRA186_GPIO_VM_RW_MASK		0x03
+#define  TEGRA186_GPIO_SCR			0x04
+#define  TEGRA186_GPIO_SCR_PIN_SIZE		0x08
+#define  TEGRA186_GPIO_SCR_PORT_SIZE		0x40
+#define  TEGRA186_GPIO_SCR_SEC_WEN		BIT(28)
+#define  TEGRA186_GPIO_SCR_SEC_REN		BIT(27)
+#define  TEGRA186_GPIO_SCR_SEC_G1W		BIT(9)
+#define  TEGRA186_GPIO_SCR_SEC_G1R		BIT(1)
+#define  TEGRA186_GPIO_FULL_ACCESS		(TEGRA186_GPIO_SCR_SEC_WEN | \
+						 TEGRA186_GPIO_SCR_SEC_REN | \
+						 TEGRA186_GPIO_SCR_SEC_G1R | \
+						 TEGRA186_GPIO_SCR_SEC_G1W)
+#define  TEGRA186_GPIO_SCR_SEC_ENABLE		(TEGRA186_GPIO_SCR_SEC_WEN | \
+						 TEGRA186_GPIO_SCR_SEC_REN)
+
 /* control registers */
 #define TEGRA186_GPIO_ENABLE_CONFIG 0x00
 #define  TEGRA186_GPIO_ENABLE_CONFIG_ENABLE BIT(0)
@@ -80,6 +96,7 @@ struct tegra_gpio_soc {
 	unsigned int num_pin_ranges;
 	const char *pinmux;
 	bool has_gte;
+	bool has_vm_support;
 };
 
 struct tegra_gpio {
@@ -129,6 +146,58 @@ static void __iomem *tegra186_gpio_get_base(struct tegra_gpio *gpio,
 	return gpio->base + offset + pin * 0x20;
 }
 
+static void __iomem *tegra186_gpio_get_secure_base(struct tegra_gpio *gpio,
+					    unsigned int pin)
+{
+	const struct tegra_gpio_port *port;
+	unsigned int offset;
+
+	port = tegra186_gpio_get_port(gpio, &pin);
+	if (!port)
+		return NULL;
+
+	offset = port->bank * 0x1000 + port->port * TEGRA186_GPIO_SCR_PORT_SIZE;
+
+	return gpio->secure + offset + pin * TEGRA186_GPIO_SCR_PIN_SIZE;
+}
+
+static inline bool tegra186_gpio_is_accessible(struct tegra_gpio *gpio, unsigned int pin)
+{
+	void __iomem *secure;
+	u32 value;
+
+	secure = tegra186_gpio_get_secure_base(gpio, pin);
+
+	if (gpio->soc->has_vm_support) {
+		value = readl(secure + TEGRA186_GPIO_VM);
+		if ((value & TEGRA186_GPIO_VM_RW_MASK) != TEGRA186_GPIO_VM_RW_MASK)
+			return false;
+	}
+
+	value = __raw_readl(secure + TEGRA186_GPIO_SCR);
+
+	if ((value & TEGRA186_GPIO_SCR_SEC_ENABLE) == 0)
+		return true;
+
+	if ((value & TEGRA186_GPIO_FULL_ACCESS) == TEGRA186_GPIO_FULL_ACCESS)
+		return true;
+
+	return false;
+}
+
+static int tegra186_init_valid_mask(struct gpio_chip *chip,
+		unsigned long *valid_mask, unsigned int ngpios)
+{
+	struct tegra_gpio *gpio = gpiochip_get_data(chip);
+	unsigned int j;
+
+	for (j = 0; j < ngpios; j++) {
+		if (!tegra186_gpio_is_accessible(gpio, j))
+			clear_bit(j, valid_mask);
+	}
+	return 0;
+}
+
 static int tegra186_gpio_get_direction(struct gpio_chip *chip,
 				       unsigned int offset)
 {
@@ -818,6 +887,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->gpio.set = tegra186_gpio_set;
 	gpio->gpio.set_config = tegra186_gpio_set_config;
 	gpio->gpio.add_pin_ranges = tegra186_gpio_add_pin_ranges;
+	gpio->gpio.init_valid_mask = tegra186_init_valid_mask;
 	if (gpio->soc->has_gte) {
 		gpio->gpio.en_hw_timestamp = tegra186_gpio_en_hw_ts;
 		gpio->gpio.dis_hw_timestamp = tegra186_gpio_dis_hw_ts;
@@ -960,6 +1030,7 @@ static const struct tegra_gpio_soc tegra186_main_soc = {
 	.name = "tegra186-gpio",
 	.instance = 0,
 	.num_irqs_per_bank = 1,
+	.has_vm_support = false,
 };
 
 #define TEGRA186_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -987,6 +1058,7 @@ static const struct tegra_gpio_soc tegra186_aon_soc = {
 	.name = "tegra186-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 1,
+	.has_vm_support = false,
 };
 
 #define TEGRA194_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1042,6 +1114,7 @@ static const struct tegra_gpio_soc tegra194_main_soc = {
 	.num_pin_ranges = ARRAY_SIZE(tegra194_main_pin_ranges),
 	.pin_ranges = tegra194_main_pin_ranges,
 	.pinmux = "nvidia,tegra194-pinmux",
+	.has_vm_support = true,
 };
 
 #define TEGRA194_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1067,6 +1140,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc = {
 	.instance = 1,
 	.num_irqs_per_bank = 8,
 	.has_gte = true,
+	.has_vm_support = false,
 };
 
 #define TEGRA234_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1111,6 +1185,7 @@ static const struct tegra_gpio_soc tegra234_main_soc = {
 	.name = "tegra234-gpio",
 	.instance = 0,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = true,
 };
 
 #define TEGRA234_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1136,6 +1211,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc = {
 	.name = "tegra234-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = false,
 };
 
 #define TEGRA241_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1166,6 +1242,7 @@ static const struct tegra_gpio_soc tegra241_main_soc = {
 	.name = "tegra241-gpio",
 	.instance = 0,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = false,
 };
 
 #define TEGRA241_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1187,6 +1264,7 @@ static const struct tegra_gpio_soc tegra241_aon_soc = {
 	.name = "tegra241-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = false,
 };
 
 static const struct of_device_id tegra186_gpio_of_match[] = {
-- 
2.17.1

