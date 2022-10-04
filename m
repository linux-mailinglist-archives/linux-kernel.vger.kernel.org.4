Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C318F5F3D75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJDHtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJDHtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:49:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95040BF7;
        Tue,  4 Oct 2022 00:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bt6mDOEfU/q5pP9Ndvyx9EZmmkR3v63+GaFPOBSIAwo3592MuX+eR+9QNqCC7xEt4sRvlt/p/Ddvhjmr2opmByO68zuRwMppxoxUCJKcgHh5wj0bh/DBb2DIcX9QRHGH/PE6XGyHPUq9MMxmxgORIDy7HsBL7+vIaIRhWqUsMRkszHQ9a8eYKHRe0YJBN+bxStG0WIXDmQTYqpe8L8VBS9vkJR8pJwKXijFtwYLMMjvltY4Bkli/6C/v6K4tM1tHIVuBwn+e1xUe1ZOCL5bH4LNnYbtv0Abqg18NOJJ9Ury70iDL4pNdo8m3VWiPrXeHxBvHQ8tN4Cz2kqiV7WdYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpAc9FxD+ctGh/7wZPNZsTSJXjl39cyxbuhUuM0CpM4=;
 b=nF143xSDb2aNtVf0oRzW29bsYHjGgxl7bxeVo7vZJPAIlZdjQowbJaO1mE/MAIG0WUJLTY+eJkFmCviKBE8SNgro2ObqB02+WhGI1KvkOUebh0GwUfg4cTalQfRaVzfylDIwYY5NySK1jd6zE0jI4zzr57EHhlTO1NvyGKWwaOcfoQFdM/cJr/FEfThlEv17aEoscOv/fnpfAV4VkTCZ9++IBGEvajakkuS367ISDv6/iaYU25nEB55OGzITYDkph6db7GrEqKuaZvrylHk08RpPsQO+eXTLCA6IgNuGSOIXpWzXLWfo4a7+kxKHo2uP9AVV9ob4jRVCYsREoWPe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpAc9FxD+ctGh/7wZPNZsTSJXjl39cyxbuhUuM0CpM4=;
 b=j6bEP42s2JEuxjvFJBuflMjdrHeLUT7bEgIgZAhui8fkjasOBK/VcUvcaMRvydDRICkpJl2+V2VFdRSPRRCXCb9JdqWm11sZa2iiHS1aDQXTBB2kXTvuIOjISYd1Ct3dxicv5fNVzpbkqG7MNm5EOK/ehMRhOPj8GRpETRX8QGApm5AAfzXlmCuuMVJf2NoXF8dHyGcxCqcmBC3huOXvVXZHBq2wZxTwzZhYPBqXUWJzwqNlhYXg8sRjBCbEnV51eBqzbbBvW9ZuRXOiOaxaeIxj6WAHaefpiM+1KKK7n0z087/gc/Ml01VOdUVc6zpu+sbKhxM4NFfuCBbhHVOlyQ==
Received: from BN8PR15CA0064.namprd15.prod.outlook.com (2603:10b6:408:80::41)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 07:48:57 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::49) by BN8PR15CA0064.outlook.office365.com
 (2603:10b6:408:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Tue, 4 Oct 2022 07:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Tue, 4 Oct 2022 07:48:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 00:48:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 4 Oct 2022 00:48:53 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 4 Oct 2022 00:48:51 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <thierry.reding@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <jonathanh@nvidia.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH v2] gpio: tegra186: Check GPIO pin permission before access.
Date:   Tue, 4 Oct 2022 13:18:45 +0530
Message-ID: <20221004074845.29583-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YyHVoihMuKNRFXAS@orome>
References: <YyHVoihMuKNRFXAS@orome>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|CH2PR12MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2691a36a-f153-4fdd-006c-08daa5dce4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1Ber+dt5LE3x7wUZFcLBSij8JsqmCvBNk1Qev+XUf3ux7rMvKZ0UICuXI8RizsE29Z2Eza5V6F/oFHqzImLrHJY2MN/k21C6mcAPX/SaWY8Te767cbXMlpj1lLc76mMk0fD+lQ7C6huX50MmSXkSwYtoDH2VA+P4QsxIXPe+J3+fCvxScTZug5NUSq4arrcs0ZJzKCyq+J1EtSGdmQABmwKQ3z2+bpZA8136YZ5LX2GoWuiVcOuEvcdfb7KQIbJS1sv9MXa7Nyke++2ULBX3cw3m4j1w6V3yM1oCZSW3oV4nTkY9S47ZvQZTs6yvFjlQ73ul9eOhnDwsuJmCLG4a5yJ4VzW0qDIYpSL8pbds3odrNeyHh2BtqwSj3AxX/pntvKw1wfBtSZ3CvFDU4xsbTU1NPoPzLYTaadhhAEMXsxoOQAXbYIJDMbhtoAzwd8j6ZzUngZM8jPuiXlAkTJDJfATDQyRCiaOlJVyM01VNKVGKlmp9OfBFOlZCsiHvoxMqA7LB0f/IHpPpQycxPoi5JFGJVqkOfItBlrmhXhaNk8gPPUnUCuVsXM6R9FucbF4PVioyQvylel6GM6JOWo3TKAhlPG3aW4hDCrLQFF0kxptm32yCKvFlwqPE9SXo70Ph4vYlYVuhM/jD1fGAP3SY6IaQZ6MjiRkqq7REJyxcyrqKBTDQAE4ST4wloE1GdPsmJSsN/Ja8an60DvirDyHKos4qX5nmC3LG6DwEXre8UIkmF3tFypPfWEMIsjj0GxV+yXeB9uD15M/3Pnz/1lw7g==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(1076003)(186003)(2616005)(356005)(82310400005)(2906002)(316002)(36756003)(70206006)(107886003)(6666004)(40460700003)(70586007)(54906003)(478600001)(110136005)(41300700001)(8676002)(4326008)(336012)(7636003)(40480700001)(86362001)(7696005)(8936002)(26005)(5660300002)(426003)(47076005)(82740400003)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 07:48:57.3622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2691a36a-f153-4fdd-006c-08daa5dce4c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
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
 drivers/gpio/gpio-tegra186.c | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 54d9fa7da9c1..34b6c287d608 100644
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
@@ -77,6 +93,7 @@ struct tegra_gpio_soc {
 	unsigned int num_irqs_per_bank;
 
 	const struct tegra186_pin_range *pin_ranges;
+	bool has_vm_support;
 	unsigned int num_pin_ranges;
 	const char *pinmux;
 	bool has_gte;
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
+static inline bool tegra186_gpio_is_accessible(struct tegra_gpio *gpio, u32 pin)
+{
+	void __iomem *secure;
+	u32 val;
+
+	secure = tegra186_gpio_get_secure_base(gpio, pin);
+
+	if (gpio->soc->has_vm_support) {
+		val = readl(secure + TEGRA186_GPIO_VM);
+		if ((val & TEGRA186_GPIO_VM_RW_MASK) != TEGRA186_GPIO_VM_RW_MASK)
+			return false;
+	}
+
+	val = __raw_readl(secure + TEGRA186_GPIO_SCR);
+
+	if ((val & TEGRA186_GPIO_SCR_SEC_ENABLE) == 0)
+		return true;
+
+	if ((val & TEGRA186_GPIO_FULL_ACCESS) == TEGRA186_GPIO_FULL_ACCESS)
+		return true;
+
+	return false;
+}
+
+static int tegra186_init_valid_mask(struct gpio_chip *chip,
+		unsigned long *valid_mask, unsigned int ngpios)
+{
+	struct tegra_gpio *gpio = gpiochip_get_data(chip);
+	int j;
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
@@ -763,6 +832,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->soc = device_get_match_data(&pdev->dev);
 	gpio->gpio.label = gpio->soc->name;
 	gpio->gpio.parent = &pdev->dev;
+	gpio->gpio.init_valid_mask = tegra186_init_valid_mask;
 
 	/* count the number of banks in the controller */
 	for (i = 0; i < gpio->soc->num_ports; i++)
@@ -1042,6 +1112,7 @@ static const struct tegra_gpio_soc tegra194_main_soc = {
 	.num_pin_ranges = ARRAY_SIZE(tegra194_main_pin_ranges),
 	.pin_ranges = tegra194_main_pin_ranges,
 	.pinmux = "nvidia,tegra194-pinmux",
+	.has_vm_support = true,
 };
 
 #define TEGRA194_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1067,6 +1138,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc = {
 	.instance = 1,
 	.num_irqs_per_bank = 8,
 	.has_gte = true,
+	.has_vm_support = false,
 };
 
 #define TEGRA234_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1111,6 +1183,7 @@ static const struct tegra_gpio_soc tegra234_main_soc = {
 	.name = "tegra234-gpio",
 	.instance = 0,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = true,
 };
 
 #define TEGRA234_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1136,6 +1209,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc = {
 	.name = "tegra234-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_vm_support = false,
 };
 
 #define TEGRA241_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1

