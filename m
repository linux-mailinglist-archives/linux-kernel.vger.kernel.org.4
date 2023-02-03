Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EEC68A241
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjBCSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:49:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E2AA8A00;
        Fri,  3 Feb 2023 10:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEJZHm5da+nPxgO/iaX45xqDwLsTgzNHa0lrzDGOOSc0vDIj/4M3kAsKSyR0hIQu3tE9zTSK//jL+lgQ5sshPx2TlYZaKr75rolqSsbMLpnIOlL1r+w3zQ3cfp96cL0kURmO7wqdscACJ83Q5W0Rezm5r/lM5/XO9sgpzAudgowZ+YsfzhSDtVm5+yNCJiu8jScjao+bAa5X1XT90NmMRuWn56MJEtyZ7WjI+9dZmMtQ8OSdjnpIEOlVS2QANOrVt5ynsZrXAJKxLZMCfRQF41zxN58ae4sRtndO2m1htsTP8nmYZa+/WN+nTxdhZF3FLz5V7Zl5YcVS6PH4t2+h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYdAV5Yqq6NftIFQ9k0l4idvNLK+xmAmd/McYzZ6yP0=;
 b=DaFbBcy/utLBVptJAnu5oBBjNK+P1Y2ZdgTmPADAjld3mtNAFUKgisrlgQUfIzS0iuMrPQ/WFGpKZXI7t9o0w4WWzHVVqXQE5967DlQYVfKXFaMTR/Jb+HUyxNDErbbWDHGUneJKS7n1+9W3KZ0QaEJ+zsmWSGLTAqHz+wS7/dw03XcMf7nhbO2joyZ49Uc8CkBrdkHdpCVrx6aXzM/BIy/F3w/Hu6nTRvXH3l4NyplR0ysHUAJB0dkwjT5pWouBT6Ca8qg1nARDGoUNffiR5jVcxOGFp9UFKslZIGZaOi1jz8OnOO161EmZXuvQWDViFjDjc3xlOnRmOU0EmUPSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYdAV5Yqq6NftIFQ9k0l4idvNLK+xmAmd/McYzZ6yP0=;
 b=rLtuDdbme1uOd0+YL/j6YuUu9UVu7g6zJ/7otz2jCPaFc0Nvwn56G3kkCnktRg58oT5zlqHZMRbqjKA1G1wunOGDgOsQbkR1LzudRJ5JUSpiilMelJOCvhwjTeQqAE8l1aLdP0+SrCO9MZhWBu8vArqlRTpQ5a61qLBBI0Yr3OSo05iloQa4T6heTCrQh7z8eS3M5UN3oaYnBDbHAOkyUjRzGRfu+Cfo2ZXuNCgeq4bCx0Am73jZam4G0od4IF7ljdNGkF1Vsb/s0TnsC4lOaJ8MyrVkQNARyEtIOtVK5JaZi5znACgS6I9EMVjCk3PC1M0VwTCtt11Zh2cCuHoTIA==
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Fri, 3 Feb
 2023 18:49:19 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::c6) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 18:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 18:49:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 10:49:11 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 10:49:11 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Fri, 3 Feb
 2023 10:49:10 -0800
From:   David Thompson <davthompson@nvidia.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <limings@nvidia.com>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1 v/1] gpio: mlxbf: enable GPIO interface and ACPI event for host-gpio[7]
Date:   Fri, 3 Feb 2023 13:49:07 -0500
Message-ID: <20230203184907.18786-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT067:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f473249-a019-4882-bd45-08db06175b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWZaRWq6vo4lDWtYwF5/NRUHtItzF2m+O9g81Eeynaaxsau3O2hKtiWmKF2VCzOoFw/QkH/qV7gT1YJ4limruOU3RMgVkmS73fKf8nDupQZVws32F63QwPTHPbnjt29uU+BbrByjftX6+CaJGO0RTpV5DIkL6UrTbdZEk3GweKmnQpmy6N8Z2fEoDJz3JgDH23eI7K5z95Fd9ypx6uOQHtX2jj4OCSsR55KJN5oXzdtXzKd1bEfN2eBg2gWt8TxF20qTNfYnwT1Cb86wofH6oTKSZ2J/DVnbNYh5aZxDrd9Yf03AN31XW7PBfdkTRoyIZtBbgsFZaDDZaEEA9Do/QotyOHnwGoiysfjRFvn6g1P+hCZvb1hSXHnEuIOuXTnYFfa0PqJN3gqlyEw8UtQ0E+AbpaAzhAu5XYEVLBXQc1mb6kvs+vlg2EPFBg5RdjaaTjMXoB0LhgcqOS+A3t+xAI8Kvpm4+kVHVxzgIaoikmYF00KzrnR7w6abqKy19NYqd+U5V9njxPhCpPXnCUyUxLx4Sjs4stlrD4G2XdiKRNru52g3sSqdJ/TUUt00i+nq79nignm3EXpkoG3/kXHQlhqjtUjH3JndvZKp4NIBLtkCbE+s1XXEMokOp4zPmDblio9xNThyvm1df8ZuolLB/fLeSFKLg3ka/pLyGRhfmuBzmTU01xJRpfJ2uaJ18URTHciu8w2wbkBpL1DHc10Juw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(7636003)(356005)(86362001)(82740400003)(5660300002)(36756003)(4326008)(54906003)(70206006)(316002)(36860700001)(70586007)(8676002)(8936002)(40460700003)(2906002)(40480700001)(41300700001)(7696005)(2616005)(336012)(82310400005)(478600001)(47076005)(426003)(83380400001)(1076003)(26005)(6666004)(107886003)(186003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 18:49:19.0345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f473249-a019-4882-bd45-08db06175b7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds ACPI handling for host-gpio[7] to trigger
the power-button event.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Liming Sun <limings@nvidia.com>
---
 drivers/gpio/gpio-mlxbf.c | 65 +++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf.c b/drivers/gpio/gpio-mlxbf.c
index 1fa9973f55b9..a8b6117c7593 100644
--- a/drivers/gpio/gpio-mlxbf.c
+++ b/drivers/gpio/gpio-mlxbf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
@@ -12,19 +13,30 @@
 #include <linux/resource.h>
 #include <linux/types.h>
 
+#include "gpiolib-acpi.h"
+
 /* Number of pins on BlueField */
 #define MLXBF_GPIO_NR 54
 
 /* Pad Electrical Controls. */
-#define MLXBF_GPIO_PAD_CONTROL_FIRST_WORD 0x0700
-#define MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD 0x0708
-#define MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD 0x0710
-#define MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD 0x0718
+#define MLXBF_GPIO_PAD_CONTROL_FIRST_WORD	0x0700
+#define MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD	0x0708
+#define MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD	0x0710
+#define MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD	0x0718
+
+#define MLXBF_GPIO_PIN_DIR_I                    0x1040
+#define MLXBF_GPIO_PIN_DIR_O                    0x1048
+#define MLXBF_GPIO_PIN_STATE                    0x1000
+#define MLXBF_GPIO_SCRATCHPAD                   0x20
+#define MLXBF_GPIO_INT_SETUP                    0x0040
+#define MLXBF_GPIO_INT_SETUP_GBL_ENA_MASK       0x1
+
+/* GPIO pin 7 is reserved for power good indication on BlueField. */
+#define MLXBF_GPIO_POWER_GOOD_PIN		7
 
-#define MLXBF_GPIO_PIN_DIR_I 0x1040
-#define MLXBF_GPIO_PIN_DIR_O 0x1048
-#define MLXBF_GPIO_PIN_STATE 0x1000
-#define MLXBF_GPIO_SCRATCHPAD 0x20
+/* GPIO pins enabled for interrupt */
+#define MLXBF_GPIO_INT_ENA_DEASSERT             0x3008
+#define MLXBF_GPIO_INT_DEASSERT_ENA_BITS	BIT(MLXBF_GPIO_POWER_GOOD_PIN)
 
 #ifdef CONFIG_PM
 struct mlxbf_gpio_context_save_regs {
@@ -42,17 +54,39 @@ struct mlxbf_gpio_state {
 	/* Memory Address */
 	void __iomem *base;
 
+	int hwirq;
+
 #ifdef CONFIG_PM
 	struct mlxbf_gpio_context_save_regs csave_regs;
 #endif
 };
 
+static int mlxbf_gpio_to_irq(struct gpio_chip *chip, u32 gpio)
+{
+	struct mlxbf_gpio_state *gs = gpiochip_get_data(chip);
+
+	return gs->hwirq;
+}
+
+static void mlxbf_gpio_cfg_irq(struct mlxbf_gpio_state *gs)
+{
+	u64 intr_cfg;
+
+	intr_cfg = readq(gs->base + MLXBF_GPIO_INT_SETUP);
+	intr_cfg |= MLXBF_GPIO_INT_SETUP_GBL_ENA_MASK;
+	writeq(intr_cfg, gs->base + MLXBF_GPIO_INT_SETUP);
+
+	intr_cfg = readq(gs->base + MLXBF_GPIO_INT_ENA_DEASSERT);
+	intr_cfg |= MLXBF_GPIO_INT_DEASSERT_ENA_BITS;
+	writeq(intr_cfg, gs->base + MLXBF_GPIO_INT_ENA_DEASSERT);
+}
+
 static int mlxbf_gpio_probe(struct platform_device *pdev)
 {
-	struct mlxbf_gpio_state *gs;
 	struct device *dev = &pdev->dev;
+	struct mlxbf_gpio_state *gs;
 	struct gpio_chip *gc;
-	int ret;
+	int ret, irq;
 
 	gs = devm_kzalloc(&pdev->dev, sizeof(*gs), GFP_KERNEL);
 	if (!gs)
@@ -63,6 +97,7 @@ static int mlxbf_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gs->base);
 
 	gc = &gs->gc;
+
 	ret = bgpio_init(gc, dev, 8,
 			 gs->base + MLXBF_GPIO_PIN_STATE,
 			 NULL,
@@ -73,8 +108,16 @@ static int mlxbf_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return -ENODEV;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	gc->owner = THIS_MODULE;
 	gc->ngpio = MLXBF_GPIO_NR;
+	gs->hwirq = irq;
+	gc->to_irq = mlxbf_gpio_to_irq;
+
+	mlxbf_gpio_cfg_irq(gs);
 
 	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
 	if (ret) {
@@ -83,7 +126,9 @@ static int mlxbf_gpio_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, gs);
+	acpi_gpiochip_request_interrupts(gc);
 	dev_info(&pdev->dev, "registered Mellanox BlueField GPIO");
+
 	return 0;
 }
 
-- 
2.30.1

