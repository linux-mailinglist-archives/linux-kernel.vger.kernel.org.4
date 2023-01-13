Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C27F668E26
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjAMGhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjAMGfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:35:52 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2F46F943;
        Thu, 12 Jan 2023 22:26:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR/2LBp6k2g2wmdQu5BAxuyx6l7UFY/tmql3ENa0/FdsaD2mg7bfBIQ83TEOaKrj32MAcKFMfkgqDKk6bLXGS9v3j6chB35V0T3xfSeBijj6GGq6c/0abUl5SM6BHAUvfzoeqglmFR3F9AhbnTkJAJPZZGNPljUnDJP9QQvs2ee30ezL+dS+KM0pG06dWqvfXWHVCz2J9J9yzlJ4KRj0+Y5KTWKzQWOAAdE+BRcp62MUYLwWwoouNzJplWIZGab/6MSvZyGrLx3bZzZ1AVoz7gGIlJXvQUnsnH6GR/OJoYhWbaBK8cA61tPiP17Ez4ViVpwHcyC+Z2S0hs5DOed2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpW268/VxyVkDzr4sOD6JU8yrZ4OQxfHe00650Ulg8g=;
 b=jX9IjZKqQt9s5mMxGD7Yq85rG0QNhJWIawx4FpeiVMTQQk113tL2WeZ3sufrtUqJbLbkM71g1JUaQ8oDPS5VIYEVUq5JrWmQACXdswIdMjIcE0k8NBVHUuMMVZZYXVq7dYVy3Ao32+CfGnXAkZDBUkm1PTkK9xk6YHsLK6xPo77MjrkFiKHfXB08Kb+8xzQ2orucnr+xR/22a9KmmaqUpsSYW14LTz2rT7sKneUXJoIFd48p0R67hW0UAk3EtQMlH0odEY2Ufg61V7Vv/gfXVXeJokqX3m/15avUOhYIwPWTRxfE3Z2nFgiCdGN+g+em2BQOfCPlGsyIeSZ+TBni0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpW268/VxyVkDzr4sOD6JU8yrZ4OQxfHe00650Ulg8g=;
 b=TjnPSKgx3b0Q3Bwp9L+782p8KdiPbuxfGFynwFZVRMbtq00nD59UjiC4miybUIui3kNskDKfxs4OKDigDW1xvj+lLv+FZAFhvSfKHjH5JNCmcW9WTndUSrLX9YXvJ6QPkozLswwwzKiV0Y3oSyp1Rszr8Xysjf0I5F1hd5OVAVk=
Received: from AM6PR08CA0027.eurprd08.prod.outlook.com (2603:10a6:20b:c0::15)
 by DU0PR10MB7611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 06:26:03 +0000
Received: from VI1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:c0:cafe::2c) by AM6PR08CA0027.outlook.office365.com
 (2603:10a6:20b:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 06:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.200) by
 VI1EUR03FT005.mail.protection.outlook.com (100.127.144.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 06:26:03 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.34; Fri, 13 Jan
 2023 07:25:59 +0100
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.34; Fri, 13 Jan 2023 07:25:59 +0100
Received: from localhost.localdomain (10.167.1.184) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.2375.34; Fri, 13 Jan 2023
 07:25:57 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmitry.torokhov@gmail.com>, <andriy.shevchenko@linux.intel.com>,
        <Jonathan.Cameron@huawei.com>, <lis8215@gmail.com>
CC:     <Gireesh.Hiremath@in.bosch.com>, <sjoerd.simons@collabora.co.uk>,
        <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: [PATCH] driver: input: matric-keypad: switch to gpiod API
Date:   Fri, 13 Jan 2023 06:25:38 +0000
Message-ID: <20230113062538.1537-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.184]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR03FT005:EE_|DU0PR10MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 31904926-aee6-4e11-1c6c-08daf52f0b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lHjb+ZSiJgwTeVAzWFIZweQsBjjYJRJ1t5iBy4JvDYOqnVIiip3bD5qW/lGAC9Y2EiC/hjED5rQJwziet+aBypu/IXFsp2dBtCNBnQZJ0VZvZlxmQ+IDTlzs54iPqWjtKP6aHI/wU4ADwwaa2ZSKjVeMmuL+asIaZxK86ggYChSlxBfiU39j1/ZCnLsCwrDghQPJuSghrpsCV5LRfC+Kh1gpUj8w2fxB3NE6chELqIrB6UTTMhq6LcOkkyH8Tul5linAVKffUgNKUYX2SgLpFIyCe2LzFstx21U7ct7CQ9rixV0aa5X7p6qFXpw1vT/+IAPX/bELSnTooAjUV/USzZEg1uKbkAq35zRNE8/fljL3R5UYKoR1gt8JRI/v6K/PLY0vcWDEXu5ePers5eQ87lFwIDraAibo1e65wQUTmSw/XWEIZ3mWuZM31sQIiXSIGIOaatriO6LhQVhNJ7w4zpqjaeThoQ0VtjFExiEXqwcdqqRyBirCuDp9WmYds4FAfzu57G3bBVYfvPLa5fQ2HAWU0j1450kACxA4Hm0qBxi8LyPCe1cvtHayxtzsODvMDbR6+/2RGQiPEBQlUbm/aaF+gUvgITpB0mKue2bJu0G29yZoOBPJNaY7o+orG/bv5f5lD/RWVEEr5iP6JyCJOuR3IVQGUeKCU+s0rAnmcQtxDDGOWlZGua69MXDoz4JPC+CF6eWOmobP6b/CjAI47S10jWlxbmPJhyo7l0QW0Y=
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(86362001)(16526019)(316002)(40480700001)(26005)(5660300002)(186003)(478600001)(1076003)(2616005)(41300700001)(47076005)(54906003)(70206006)(4326008)(110136005)(336012)(70586007)(82310400005)(8936002)(83380400001)(40460700003)(8676002)(6666004)(107886003)(36860700001)(82960400001)(82740400003)(356005)(2906002)(81166007)(2876002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:26:03.0687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31904926-aee6-4e11-1c6c-08daf52f0b81
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7611
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

switch to new gpio descriptor based API

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 drivers/input/keyboard/matrix_keypad.c | 77 ++++++++++++--------------
 include/linux/input/matrix_keypad.h    |  4 +-
 2 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 203310727d88..3697f203b3cc 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -50,11 +50,11 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
 	bool level_on = !pdata->active_low;
 
 	if (on) {
-		gpio_direction_output(pdata->col_gpios[col], level_on);
+		gpiod_direction_output(pdata->col_gpios[col], level_on);
 	} else {
-		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
+		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
 		if (!pdata->drive_inactive_cols)
-			gpio_direction_input(pdata->col_gpios[col]);
+			gpiod_direction_input(pdata->col_gpios[col]);
 	}
 }
 
@@ -79,7 +79,7 @@ static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
 static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 			 int row)
 {
-	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
+	return gpiod_get_value_cansleep(pdata->row_gpios[row]) ?
 			!pdata->active_low : pdata->active_low;
 }
 
@@ -92,7 +92,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 		enable_irq(pdata->clustered_irq);
 	else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+			enable_irq(gpiod_to_irq(pdata->row_gpios[i]));
 	}
 }
 
@@ -105,7 +105,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 		disable_irq_nosync(pdata->clustered_irq);
 	else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+			disable_irq_nosync(gpiod_to_irq(pdata->row_gpios[i]));
 	}
 }
 
@@ -128,7 +128,7 @@ static void matrix_keypad_scan(struct work_struct *work)
 	memset(new_state, 0, sizeof(new_state));
 
 	for (row = 0; row < pdata->num_row_gpios; row++)
-		gpio_direction_input(pdata->row_gpios[row]);
+		gpiod_direction_input(pdata->row_gpios[row]);
 
 	/* assert each column and read the row status out */
 	for (col = 0; col < pdata->num_col_gpios; col++) {
@@ -233,7 +233,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
 static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	unsigned int gpio;
+	struct gpio_desc *gpio;
 	int i;
 
 	if (pdata->clustered_irq > 0) {
@@ -245,7 +245,7 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 			if (!test_bit(i, keypad->disabled_gpios)) {
 				gpio = pdata->row_gpios[i];
 
-				if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
+				if (enable_irq_wake(gpiod_to_irq(gpio)) == 0)
 					__set_bit(i, keypad->disabled_gpios);
 			}
 		}
@@ -255,7 +255,7 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	unsigned int gpio;
+	struct gpio_desc *gpio;
 	int i;
 
 	if (pdata->clustered_irq > 0) {
@@ -267,7 +267,7 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 		for (i = 0; i < pdata->num_row_gpios; i++) {
 			if (test_and_clear_bit(i, keypad->disabled_gpios)) {
 				gpio = pdata->row_gpios[i];
-				disable_irq_wake(gpio_to_irq(gpio));
+				disable_irq_wake(gpiod_to_irq(gpio));
 			}
 		}
 	}
@@ -310,27 +310,21 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 	/* initialized strobe lines as outputs, activated */
 	for (i = 0; i < pdata->num_col_gpios; i++) {
-		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
+		err = gpiod_direction_output(pdata->col_gpios[i], !pdata->active_low);
 		if (err) {
 			dev_err(&pdev->dev,
-				"failed to request GPIO%d for COL%d\n",
-				pdata->col_gpios[i], i);
+				"Unable to set direction for COL GPIO line %i\n", i);
 			goto err_free_cols;
 		}
-
-		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++) {
-		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
+		err = gpiod_direction_input(pdata->row_gpios[i]);
 		if (err) {
 			dev_err(&pdev->dev,
-				"failed to request GPIO%d for ROW%d\n",
-				pdata->row_gpios[i], i);
+				"Unable to set direction for ROW GPIO line %i\n", i);
 			goto err_free_rows;
 		}
-
-		gpio_direction_input(pdata->row_gpios[i]);
 	}
 
 	if (pdata->clustered_irq > 0) {
@@ -346,15 +340,15 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++) {
 			err = request_any_context_irq(
-					gpio_to_irq(pdata->row_gpios[i]),
+					gpiod_to_irq(pdata->row_gpios[i]),
 					matrix_keypad_interrupt,
 					IRQF_TRIGGER_RISING |
 					IRQF_TRIGGER_FALLING,
 					"matrix-keypad", keypad);
 			if (err < 0) {
 				dev_err(&pdev->dev,
-					"Unable to acquire interrupt for GPIO line %i\n",
-					pdata->row_gpios[i]);
+					"Unable to acquire interrupt for ROW GPIO line %i\n",
+					i);
 				goto err_free_irqs;
 			}
 		}
@@ -366,15 +360,15 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 err_free_irqs:
 	while (--i >= 0)
-		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+		free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
 	i = pdata->num_row_gpios;
 err_free_rows:
 	while (--i >= 0)
-		gpio_free(pdata->row_gpios[i]);
+		gpiod_put(pdata->row_gpios[i]);
 	i = pdata->num_col_gpios;
 err_free_cols:
 	while (--i >= 0)
-		gpio_free(pdata->col_gpios[i]);
+		gpiod_put(pdata->col_gpios[i]);
 
 	return err;
 }
@@ -388,14 +382,14 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 		free_irq(pdata->clustered_irq, keypad);
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+			free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++)
-		gpio_free(pdata->row_gpios[i]);
+		gpiod_put(pdata->row_gpios[i]);
 
 	for (i = 0; i < pdata->num_col_gpios; i++)
-		gpio_free(pdata->col_gpios[i]);
+		gpiod_put(pdata->col_gpios[i]);
 }
 
 #ifdef CONFIG_OF
@@ -404,8 +398,9 @@ matrix_keypad_parse_dt(struct device *dev)
 {
 	struct matrix_keypad_platform_data *pdata;
 	struct device_node *np = dev->of_node;
-	unsigned int *gpios;
-	int ret, i, nrow, ncol;
+	struct gpio_desc **gpios;
+	struct gpio_desc *desc;
+	int i, nrow, ncol;
 
 	if (!np) {
 		dev_err(dev, "device lacks DT data\n");
@@ -443,7 +438,7 @@ matrix_keypad_parse_dt(struct device *dev)
 
 	gpios = devm_kcalloc(dev,
 			     pdata->num_row_gpios + pdata->num_col_gpios,
-			     sizeof(unsigned int),
+			     sizeof(*gpios),
 			     GFP_KERNEL);
 	if (!gpios) {
 		dev_err(dev, "could not allocate memory for gpios\n");
@@ -451,17 +446,17 @@ matrix_keypad_parse_dt(struct device *dev)
 	}
 
 	for (i = 0; i < nrow; i++) {
-		ret = of_get_named_gpio(np, "row-gpios", i);
-		if (ret < 0)
-			return ERR_PTR(ret);
-		gpios[i] = ret;
+		desc = gpiod_get_index(dev, "row", i, GPIOD_IN);
+		if (IS_ERR(desc))
+			return ERR_PTR(-EINVAL);
+		gpios[i] = desc;
 	}
 
 	for (i = 0; i < ncol; i++) {
-		ret = of_get_named_gpio(np, "col-gpios", i);
-		if (ret < 0)
-			return ERR_PTR(ret);
-		gpios[nrow + i] = ret;
+		desc = gpiod_get_index(dev, "col", i, GPIOD_IN);
+		if (IS_ERR(desc))
+			return ERR_PTR(-EINVAL);
+		gpios[nrow + i] = desc;
 	}
 
 	pdata->row_gpios = gpios;
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 9476768c3b90..8ad7d4626e62 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -59,8 +59,8 @@ struct matrix_keymap_data {
 struct matrix_keypad_platform_data {
 	const struct matrix_keymap_data *keymap_data;
 
-	const unsigned int *row_gpios;
-	const unsigned int *col_gpios;
+	struct gpio_desc **row_gpios;
+	struct gpio_desc **col_gpios;
 
 	unsigned int	num_row_gpios;
 	unsigned int	num_col_gpios;
-- 
2.20.1

