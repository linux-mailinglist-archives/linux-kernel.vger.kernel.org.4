Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455CE72876D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjFHSn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFHSn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:43:26 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45785193;
        Thu,  8 Jun 2023 11:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ32AmXuFHVhIjUW/xEirFMW/b0gkpMFrnWdwqBrZD3djfH14xWeKT6x3kNd40dQ2vpCXSzIeOrSxgvoNKQg7dfsG3TxfkuGSVrdgBHToCYLybKf/tla02MlIvkFyFzJBwGyq1fj00sKdD7fcRx+MU0Jyc8Af+K+Q8/7OoLd7r/Pi4An/LTlrf06jWDtIukNFhi6whnCXYvU0jl/GRnNAaXDtOxPJnoksQCYvo5AGy6mZysAQhGcqL8iCZc5RLzfMhvuaDXZ5zoHNDOxL7x1FF/VgdY2Fl45tlIrWSbi68xLroJOOaBff2QkIE9OticBJbmUL4m6FH8q9XXM5duzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0kLYYFMmlWLDdjBbZsIKlz1qGfpSElO/O9ORLtN9CA=;
 b=l2fZkpFMH34kWsAoGk0NhiooqTfnFX9ECZeaK8kFCPxDLF06qaIZfhB/mqONTNXtg2NcwrEoLNS8Mwvqgr/beiSsiWxq3Dna7R4MDsNts1cvG/dT8/fcGS06UlaB+9ZkC5b0hlxgYMbz8IHLCEyGoWoth18viIWLID5482lLxnWVj2DlKRnso7/J1MwcdXxbNfEkmvktYjqngD9Wgocu0xfBnpwveTDUOeSGPGXo3sSpRa9Hb5rwk35PEeG5eW4PgFBfTXRgDhec78eQeiM+R4aVBE1lORW4hQ4ZxLR0y0ypwgW5ZYktLmHdt+SzOaEOD7IbFKF62tZTY66xtCOyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0kLYYFMmlWLDdjBbZsIKlz1qGfpSElO/O9ORLtN9CA=;
 b=V8muGYHWJuKpxk+RH0aB3me2z1iPbqwA/1cVOPXOEJyow2ntA5jxyboSpOVzO9EF3iExtpMoZYMPG1ZVKsvaO1DZ2uw9PL9/RO4gOWg475iqelT+Qgdvgutw4eNWZV2rYiIn7d2gLcTiqJOyeTAiFWqNfOzBx47/VGRbds1phN4=
Received: from SA9PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:6e::6)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Thu, 8 Jun
 2023 18:43:22 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::8f) by SA9PR11CA0001.outlook.office365.com
 (2603:10b6:806:6e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.25 via Frontend
 Transport; Thu, 8 Jun 2023 18:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Thu, 8 Jun 2023 18:43:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 13:43:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 11:43:02 -0700
Received: from xhdvnc101.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 8 Jun 2023 13:42:59 -0500
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <michal.simek@xilinx.com>, <michal.simek@amd.com>, <git@amd.com>,
        <shubhrajyoti.datta@xilinx.com>, <srinivas.neeli@xilinx.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <srinivas.goud@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V2] gpio: zynq: fix zynqmp_gpio not an immutable chip warning
Date:   Fri, 9 Jun 2023 00:12:52 +0530
Message-ID: <1686249772-26231-1-git-send-email-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cc4dba-785b-429f-b002-08db68503b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dj+B5aJFXRNEYsnUIN/2b8Ijhehzr7Dr9jvHVS/m2N3FmywK56kCM1a19OLo+/9Ne2CV+SmoWQjFoVkQRLuHteEM2MWhhr96E8G9+iukklozHTav+BrrWWuvwGtOXBM40UXX1Tpw5h8XvTcJgL5vIa9ZuQrEN05cT7fAdqAmvisIK0i1QgRklbaQ4G5MKljBuTT1GpTlHNetuuD5cnG8OPryuMPAj0fEigLgCn9hRMo4O1gdeHEv/dBP64OJgo5xwldfSiYGEVFZeDnhAxINWun+mDhwgOyE4tI79HtX5530F2Wz0v01Y+cyZg/Wh4m2XDj+jg0IF16S1gURwrsqjZE6Hg5IrZ4DEs+joDUvQozwadWVjFDsMwtuPy2lPTusZy9lAk8W7VSk6VTe3ddpoX48xs9/7j9j61tukSp7ZXLWeRw8OlyzJpAqDfQDHJKeLKAIqLBCx7h5g7n3s86zWqYgn+nG/HBK54gzSZLdsgjUBjzPgf4G5Oq8lZEI46lmKm/h0dxXuqrCxxdVHrKxFJJ8d8T3hUMviGjQWEI9l0el3eV5Syimt4jGH0CLmFfUtYqIeyevFsnA61sSw/6uTcs/d0I7NqnCGdl/+6pl/3BES7lTi6aBR3AblvuEK5CbN/VQdwdEp6rYJ0g+P3h+ejNO76GEjnL4+SQrSBWwq4G1k4yLC1dvz1+SARd46hDdNEqhAuHqUkDchtmO7LlOc/WqWrgClUrDReVAVvAKMCuVXPsaUAdbw1GJ+aouVUCE4svExol8HHVlfmdRPQQQ/xkt2DRk36PZlWxkvqngK5csTgOkx/5hHFMPnNs5LdYxSpsAFxCz7GWO1QqqO/urTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(41300700001)(26005)(40460700003)(86362001)(426003)(478600001)(70586007)(6666004)(54906003)(316002)(4326008)(110136005)(356005)(40480700001)(36756003)(186003)(70206006)(81166007)(2616005)(336012)(82740400003)(921005)(83380400001)(5660300002)(8936002)(8676002)(36860700001)(47076005)(44832011)(2906002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 18:43:20.8245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cc4dba-785b-429f-b002-08db68503b8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the struct irq_chip const and flag it as IRQCHIP_IMMUTABLE,
call gpiochip_disable_irq() in the .irq_mask() callback and
gpiochip_enable_irq() in the .irq_unmask() callback to fix
"gpio gpiochip1: (zynqmp_gpio): not an immutable chip" warning.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Add gpiochip_disable_irq() in the .irq_mask() callback
and gpiochip_enable_irq() in the .irq_unmask() callback
---
 drivers/gpio/gpio-zynq.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 06c6401f02b8..c334e46033ba 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -151,8 +151,8 @@ struct zynq_platform_data {
 	int bank_max[ZYNQMP_GPIO_MAX_BANK];
 };
 
-static struct irq_chip zynq_gpio_level_irqchip;
-static struct irq_chip zynq_gpio_edge_irqchip;
+static const struct irq_chip zynq_gpio_level_irqchip;
+static const struct irq_chip zynq_gpio_edge_irqchip;
 
 /**
  * zynq_gpio_is_zynq - test if HW is zynq or zynqmp
@@ -404,9 +404,12 @@ static int zynq_gpio_get_direction(struct gpio_chip *chip, unsigned int pin)
 static void zynq_gpio_irq_mask(struct irq_data *irq_data)
 {
 	unsigned int device_pin_num, bank_num, bank_pin_num;
+	const unsigned long offset = irqd_to_hwirq(irq_data);
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(irq_data);
 	struct zynq_gpio *gpio =
 		gpiochip_get_data(irq_data_get_irq_chip_data(irq_data));
 
+	gpiochip_disable_irq(chip, offset);
 	device_pin_num = irq_data->hwirq;
 	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num, gpio);
 	writel_relaxed(BIT(bank_pin_num),
@@ -425,9 +428,12 @@ static void zynq_gpio_irq_mask(struct irq_data *irq_data)
 static void zynq_gpio_irq_unmask(struct irq_data *irq_data)
 {
 	unsigned int device_pin_num, bank_num, bank_pin_num;
+	const unsigned long offset = irqd_to_hwirq(irq_data);
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(irq_data);
 	struct zynq_gpio *gpio =
 		gpiochip_get_data(irq_data_get_irq_chip_data(irq_data));
 
+	gpiochip_enable_irq(chip, offset);
 	device_pin_num = irq_data->hwirq;
 	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num, gpio);
 	writel_relaxed(BIT(bank_pin_num),
@@ -590,7 +596,7 @@ static void zynq_gpio_irq_relres(struct irq_data *d)
 }
 
 /* irq chip descriptor */
-static struct irq_chip zynq_gpio_level_irqchip = {
+static const struct irq_chip zynq_gpio_level_irqchip = {
 	.name		= DRIVER_NAME,
 	.irq_enable	= zynq_gpio_irq_enable,
 	.irq_eoi	= zynq_gpio_irq_ack,
@@ -601,10 +607,11 @@ static struct irq_chip zynq_gpio_level_irqchip = {
 	.irq_request_resources = zynq_gpio_irq_reqres,
 	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
-			  IRQCHIP_MASK_ON_SUSPEND,
+			  IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static struct irq_chip zynq_gpio_edge_irqchip = {
+static const struct irq_chip zynq_gpio_edge_irqchip = {
 	.name		= DRIVER_NAME,
 	.irq_enable	= zynq_gpio_irq_enable,
 	.irq_ack	= zynq_gpio_irq_ack,
@@ -614,7 +621,8 @@ static struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_set_wake	= zynq_gpio_set_wake,
 	.irq_request_resources = zynq_gpio_irq_reqres,
 	.irq_release_resources = zynq_gpio_irq_relres,
-	.flags		= IRQCHIP_MASK_ON_SUSPEND,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
@@ -962,7 +970,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 
 	/* Set up the GPIO irqchip */
 	girq = &chip->irq;
-	girq->chip = &zynq_gpio_edge_irqchip;
+	gpio_irq_chip_set_chip(girq, &zynq_gpio_edge_irqchip);
 	girq->parent_handler = zynq_gpio_irqhandler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(&pdev->dev, 1,
-- 
2.25.1

