Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046335B881D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiINMVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINMVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:21:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07927804B1;
        Wed, 14 Sep 2022 05:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbR+zzfjP4HNN6ooguiaJNzRNNhEKhDxbdSNCNP4eJuzVvLJthLxQs6nFvT8oh4Bl0RZCkB4WLY4Q4ec3twkWxhwOzj6wAvMNQW2yEJVzO7LsZt4xS3HZcs4reG86t6qKNhgfsoBx5euYPda5pIORWeoe9qLPFB5AUZASGI5Ha7q/FZLxPpRoe4FWZIU5aw/hMGydFhqZVPlvCfJp22OVk54xD1ftCGRRqgWX2hm3am9RHTwwnx9Wo5xtaJea+qGbZrXXsQ+VyJ/txzUsSILxEgHDZ6h7GDpiI0n5rgTSN4GdWvvyhW7sTbxOHGVnEa7YzLe6jhU7VH+Q+V0Z5pMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdLIMbVqaOsPhbO3kICscAXsiHjjabu2WcZsZzr02p0=;
 b=Z2YT/imcEQvNX/HsxdBI4D/c+fwldOERPC9vF8wJ9i8K3vcOiDbuPB6bIl17T/oIhdBpasi7nzb6hyMZiL78pjIOv03e+HiaPDpwOL0IcvbOWY1VkVtyx+xQYzxsaZHEHpa6vfb5cV/1sMLsuFhLuMZuRknZI05+pfY6DBDAEL5Td4wnAcrxw9TNiBoSKg08gvZKvVA6pHxVmhuT5fL7oU81LDYqXoBpjUxAIMfywCBXANTwQJxKCrbYeH5k7gYty1vtsYloEFWBdAzW1AqtftLnMxJtBGhsP/uv+3fucbmPubld0p58ZybQwF2jOdxJOr5upyzxyeMKaaEgCm6baA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdLIMbVqaOsPhbO3kICscAXsiHjjabu2WcZsZzr02p0=;
 b=Imt7ezaE8OaVpqTV1FazEwnoVdMLpmMnoLUU83EZI9deQudjbkAknhbY3+Gu3sZanVmVCbocL/cDs2bLPym0HVojknelfp/YmIn8z6DpYZTFxFrtljvocDkq2u+Zn/4dS0YHV8lxjy4rGU8fSbs+SUg0LAVb/lD80JSSlvn4wv+cy4M4ns0r8X9kpM+gubzK+t3JjEnkYnKzGznV4o7ikHDb1EaYHRjgQzB1AmAlIITzPHKZlcyvY5paIFIgfQ6tJuSdJgNu72Qoz8SpK+YD1GTnjLxnn1P4SSD8L08YqCxWUypa0EVe2yQ1wtYguXDRtoKiBgvryq41go2KGSjAjQ==
Received: from DS7PR03CA0171.namprd03.prod.outlook.com (2603:10b6:5:3b2::26)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 12:21:36 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::ef) by DS7PR03CA0171.outlook.office365.com
 (2603:10b6:5:3b2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20 via Frontend
 Transport; Wed, 14 Sep 2022 12:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 12:21:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 14 Sep
 2022 05:21:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 14 Sep 2022 05:21:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 14 Sep 2022 05:21:15 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 14 Sep 2022 05:21:12 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH] gpio: tegra186: Check GPIO pin permission before access.
Date:   Wed, 14 Sep 2022 17:51:10 +0530
Message-ID: <20220914122110.7246-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: c19a90cf-3e6e-47c3-19d6-08da964baac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8211l9JAlnzL7JrdeACk8md6K4XkcSSWRTihPGOPsVI+vpUXzRc1CaLufFm8hqLsVO57wAlKEA7NNSpsn8rKlpEd45NAf9rMBMrRRsCOtrzeFWh+96bjMzyJnJbFW7t5VNLPUMAnyEvYXh1HLaTGS36BEV3oaB9CpmHRqgKuhxvtJER1VWWuJ4bL46sAliS4CcvJbZBwNNHXldQzpkipFcImvw0l4i6HZ/1viKvw/WcsxN/D7+fXywleWGl97l/nFh1LDRdlt0nEKr0CBImJUuGe5kBHtHCwK+Zh7yZLNdbibyOIaqW7HkyFmMAhKxfkrO8eHkvxAglptIO263xDMM/IFD1DrtQ4v3JVF6Fe8py3NMHu+B9E5K/oXs4t/VN1V3yuUe5yS28Bt1piY/Qlvia0awJ4G86UgnciCMtbtd9KUXO+an6b6tWvO8pNOn6dafzi+vBFUUfL1y1OeNU6jJtDwvMTjDEfAalDik7K6WFRBk7WLVglH8urioh61RFWj5SwFIGki+tHm6ysbJxgSXpuio22bDhhyF6ZKwtZEiR4GFTpacE4reiOFzdYmpKjVFOemNkjOdTieMFm8Qgr8QO4+2S+zGiOjA7tNNnU8TqR2NGf0VsqOKQC5Crod3b72tPUCYm1XdGMjrPzTZwiL3TJZbIhbIUsKoUn7J/7lsPnkmvjWicL9BIsaK21ijxa2u1EznAt0438cTWW1EbiZeEiIMbgzCxgBGvFd1YsnvBHzgFJJitNtCmrHPGOzhjpyk8m2x/LezgA/nW+/UcarQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(70206006)(336012)(26005)(54906003)(36756003)(47076005)(107886003)(1076003)(82740400003)(316002)(36860700001)(5660300002)(8936002)(356005)(8676002)(7696005)(4326008)(110136005)(2906002)(40480700001)(86362001)(7636003)(83380400001)(186003)(40460700003)(70586007)(82310400005)(41300700001)(478600001)(2616005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 12:21:35.6279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19a90cf-3e6e-47c3-19d6-08da964baac1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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
---
 drivers/gpio/gpio-tegra186.c | 71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 54d9fa7da9c1..e6fc3c9b1e9f 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -26,6 +26,22 @@
 
 #define TEGRA186_GPIO_INT_ROUTE_MAPPING(p, x) (0x14 + (p) * 0x20 + (x) * 4)
 
+#define  TEGRA186_GPIO_VM_REG			0x00
+#define  TEGRA186_GPIO_VM_RW_MASK		0x03
+#define  TEGRA186_GPIO_SCR_REG			0x04
+#define  TEGRA186_GPIO_SCR_DIFF			0x08
+#define  TEGRA186_GPIO_SCR_BASE_DIFF		0x40
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
@@ -129,6 +146,45 @@ static void __iomem *tegra186_gpio_get_base(struct tegra_gpio *gpio,
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
+	offset = port->bank * 0x1000 + port->port * TEGRA186_GPIO_SCR_BASE_DIFF;
+
+	return gpio->secure + offset + pin * TEGRA186_GPIO_SCR_DIFF;
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
+		val = readl(secure + TEGRA186_GPIO_VM_REG);
+		if ((val & TEGRA186_GPIO_VM_RW_MASK) != TEGRA186_GPIO_VM_RW_MASK)
+			return false;
+	}
+
+	val = __raw_readl(secure + TEGRA186_GPIO_SCR_REG);
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
 static int tegra186_gpio_get_direction(struct gpio_chip *chip,
 				       unsigned int offset)
 {
@@ -136,6 +192,9 @@ static int tegra186_gpio_get_direction(struct gpio_chip *chip,
 	void __iomem *base;
 	u32 value;
 
+	if (!tegra186_gpio_is_accessible(gpio, offset))
+		return -EPERM;
+
 	base = tegra186_gpio_get_base(gpio, offset);
 	if (WARN_ON(base == NULL))
 		return -ENODEV;
@@ -154,6 +213,9 @@ static int tegra186_gpio_direction_input(struct gpio_chip *chip,
 	void __iomem *base;
 	u32 value;
 
+	if (!tegra186_gpio_is_accessible(gpio, offset))
+		return -EPERM;
+
 	base = tegra186_gpio_get_base(gpio, offset);
 	if (WARN_ON(base == NULL))
 		return -ENODEV;
@@ -177,6 +239,9 @@ static int tegra186_gpio_direction_output(struct gpio_chip *chip,
 	void __iomem *base;
 	u32 value;
 
+	if (!tegra186_gpio_is_accessible(gpio, offset))
+		return -EPERM;
+
 	/* configure output level first */
 	chip->set(chip, offset, level);
 
@@ -293,6 +358,10 @@ static void tegra186_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	void __iomem *base;
 	u32 value;
 
+	if (!tegra186_gpio_is_accessible(gpio, offset)){
+		pr_err("GPIO not accessible\n");
+		return;
+	}
 	base = tegra186_gpio_get_base(gpio, offset);
 	if (WARN_ON(base == NULL))
 		return;
@@ -1042,6 +1111,7 @@ static const struct tegra_gpio_soc tegra194_main_soc = {
 	.num_pin_ranges = ARRAY_SIZE(tegra194_main_pin_ranges),
 	.pin_ranges = tegra194_main_pin_ranges,
 	.pinmux = "nvidia,tegra194-pinmux",
+	.has_vm_support = true,
 };
 
 #define TEGRA194_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1067,6 +1137,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc = {
 	.instance = 1,
 	.num_irqs_per_bank = 8,
 	.has_gte = true,
+	.has_vm_support = false,
 };
 
 #define TEGRA234_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1

