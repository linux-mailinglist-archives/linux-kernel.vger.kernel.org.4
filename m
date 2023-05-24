Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05270F493
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjEXKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjEXKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:50:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2EE97;
        Wed, 24 May 2023 03:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcYEXQTDrY81jA8xNI4j1K7RzAfVqhP/a4tE4EWKOgOR3PRCnv9/lkiANoWgZNVc5ce+MKRK15BvfiQSpZ9i1jHXIvPMNyxesFU603x3lut4Jbzzg1wrHwnMBeYqdQO2fZqv226iCcmilCyjqiOZXgOioWXD5WWX3lEMfz3XjtJyZOwcHF8OD9p0PESObI2WJqDukhaYOUs6gDhPqgGQAQYKS59KA4Lq1TeCbZYIiZm9n4dnLFINtTjy8tjwfCGmFyJOvpAnJ6ugPX4irtDOP/oD2lSZFqbDOamwtISb/nCWuhY1Hl3zVaxD5wA1p5UbmAnSrXa1xdIat0d4cIB34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bZMrETjg/hEwmAUSMBY8Wleo490eLcpplxUE+F6Jxc=;
 b=hH9ZL2BqljJo8N5j8Z0ApUlLGbviaf1M3zISQzhlmrw5F8Ae0I8SJKQF2XmrEwW+Goi/6zn95zcAoQFGGVNcPDorhiJ4kJ5eWMriUwsqnW+Z/y8XKMDddTKtlZTTomzR+qoSjzS9vMWT2Wsra3W5DkPdvtL0YA0MvE98lI++Lp4Nq08yZGxN9M7T+6ociyU0r0jt5a8eGbgSaDfAHcKA0g4qmEnPJaduA6m1S66F698vylghUtODaDlHYEjN3d9WKJqGMyYs+zDnhzB4bEGGYUHe4SWpFks9QjyJGAw9tICFEbp4VcgOky6Cq0Fov0xgrzRvCsXEtQglBdiGbHcWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bZMrETjg/hEwmAUSMBY8Wleo490eLcpplxUE+F6Jxc=;
 b=FOipL5VmGxbR4tqzpGurYnwdARu0CiHqrG1dj/cakOFdSmSO5G52Ce/om4MJLIkjcTySS5iyMTbbHCFEWa6ZtmsZzuIV4b1MkSCeX1nRhj/8GlWSR/WAvkAsRGyXBVhxTMCYUK+k/ZQw+8dbHwI6OenF3jJ2wEinuXudBhJGFt/y/91MBmDH3RH13OHbxvhEeYYjytSonS41HITCsaiMCMSEcyYmHUElYxRP8qceH/gyyoKrFyg0xKlhHw6QIyb+2pHP1BptP7Q5XjFbWHtf1qZN1tbnBY/GQbwW/bJL0Qntt1mVfTkJem8ev0cyoMRmRb9LfZU6ms4jj+iPIdpG4w==
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 10:50:37 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::31) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Wed, 24 May 2023 10:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 10:50:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 24 May 2023
 03:50:27 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 24 May 2023 03:50:26 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 24 May 2023 03:50:24 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH v4] gpio: tegra186: Check GPIO pin permission before access.
Date:   Wed, 24 May 2023 16:20:21 +0530
Message-ID: <20230524105021.9418-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ZGztRb_CreLi_rYv@surfacebook>
References: <ZGztRb_CreLi_rYv@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: cc554c52-7b10-464d-8c3d-08db5c44b564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyrXbjeiUaIUlAJwjC0sq0ZRrwr38ROdu5VZH2yUPXrQCgnsbMo9eooSUZW4Ttl21yQDk7oXY5d5pbD/hUUy92xot5uHdZnqDgu4wZiDxcjMnCEOzyavYewMmv+FGF5gK/Fb7GGb3oELyqsP6uU8pAf1C83y4vQMCcDaksYSg3I2xXRuj1cVq/khcCX2NHgZq6DBRZERIZ10+Rij2ioy6ByHtCMUv94OxSg01ggnNfNFHLMkImOAwgwUeSvXWBK4Y1HqTYM7ri40QdyUE3dVEo6g8jQ1PBiApSMg7ArNuTBslbUJwG+JZ6JVTuKjma1PVIa/k5RSNG0xFJljHKHyyUJ9X61ptGDf2aDxdTAE6cwUSwXhQxZzvfz35+aXeDpySoRP+LH3EQ1p25PkP70siXcswkdjyStEoGosS0cZ0bJ+7+yUvRqhpet902pk4nWXxCgZ8VD349eGEpS8wu0g+Wiu6qtRb1J1uTNpgkuR4VUTYPjlcCQlAHAI0uyHCXWhRQ0ihp2lJKjrX8CkEKqUkdijSFxWtH8WSr1OoGlyPtdfeBKe97beZTi9V+MeEZrEbOrdhVb7zeGxVkX8SmQzCbVZprRXePC7ysburoOfxRpF145Dv5ns//Nga1hrxNy7KXQehyXfhwYm7uHZm1QWbji4TCVR6KS3yMPNleSVZnFQYxd/sLTogREMX/Qkz0F67NzQh7W+goIUwso6dHFQCwrhhGu1eFqLAi28d9fFmleK0rmNylNVZ3NGF8j0l59q
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(110136005)(47076005)(336012)(478600001)(86362001)(2616005)(426003)(36860700001)(70586007)(83380400001)(70206006)(2906002)(82310400005)(4326008)(186003)(26005)(1076003)(82740400003)(40480700001)(6666004)(316002)(107886003)(41300700001)(7696005)(36756003)(8676002)(5660300002)(40460700003)(356005)(7636003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 10:50:37.2916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc554c52-7b10-464d-8c3d-08db5c44b564
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 78 ++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index b904de0b1784..464b0ea3b6f1 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -27,6 +27,22 @@
 
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
@@ -81,6 +97,7 @@ struct tegra_gpio_soc {
 	unsigned int num_pin_ranges;
 	const char *pinmux;
 	bool has_gte;
+	bool has_vm_support;
 };
 
 struct tegra_gpio {
@@ -130,6 +147,58 @@ static void __iomem *tegra186_gpio_get_base(struct tegra_gpio *gpio,
 	return gpio->base + offset + pin * 0x20;
 }
 
+static void __iomem *tegra186_gpio_get_secure_base(struct tegra_gpio *gpio,
+						   unsigned int pin)
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
+				    unsigned long *valid_mask, unsigned int ngpios)
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
@@ -816,6 +885,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->gpio.set = tegra186_gpio_set;
 	gpio->gpio.set_config = tegra186_gpio_set_config;
 	gpio->gpio.add_pin_ranges = tegra186_gpio_add_pin_ranges;
+	gpio->gpio.init_valid_mask = tegra186_init_valid_mask;
 	if (gpio->soc->has_gte) {
 		gpio->gpio.en_hw_timestamp = tegra186_gpio_en_hw_ts;
 		gpio->gpio.dis_hw_timestamp = tegra186_gpio_dis_hw_ts;
@@ -958,6 +1028,7 @@ static const struct tegra_gpio_soc tegra186_main_soc = {
 	.name = "tegra186-gpio",
 	.instance = 0,
 	.num_irqs_per_bank = 1,
+	.has_vm_support = false,
 };
 
 #define TEGRA186_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -985,6 +1056,7 @@ static const struct tegra_gpio_soc tegra186_aon_soc = {
 	.name = "tegra186-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 1,
+	.has_vm_support = false,
 };
 
 #define TEGRA194_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1040,6 +1112,7 @@ static const struct tegra_gpio_soc tegra194_main_soc = {
 	.num_pin_ranges = ARRAY_SIZE(tegra194_main_pin_ranges),
 	.pin_ranges = tegra194_main_pin_ranges,
 	.pinmux = "nvidia,tegra194-pinmux",
+	.has_vm_support = true,
 };
 
 #define TEGRA194_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1065,6 +1138,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc = {
 	.instance = 1,
 	.num_irqs_per_bank = 8,
 	.has_gte = true,
+	.has_vm_support = false,
 };
 
 #define TEGRA234_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1109,6 +1183,7 @@ static const struct tegra_gpio_soc tegra234_main_soc = {
 	.name = "tegra234-gpio",
 	.instance = 0,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = true,
 };
 
 #define TEGRA234_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1135,6 +1210,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc = {
 	.instance = 1,
 	.num_irqs_per_bank = 8,
 	.has_gte = true,
+	.has_vm_support = false,
 };
 
 #define TEGRA241_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1165,6 +1241,7 @@ static const struct tegra_gpio_soc tegra241_main_soc = {
 	.name = "tegra241-gpio",
 	.instance = 0,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = false,
 };
 
 #define TEGRA241_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1186,6 +1263,7 @@ static const struct tegra_gpio_soc tegra241_aon_soc = {
 	.name = "tegra241-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = false,
 };
 
 static const struct of_device_id tegra186_gpio_of_match[] = {
-- 
2.17.1

