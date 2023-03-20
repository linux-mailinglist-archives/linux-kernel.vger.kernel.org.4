Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84A66C1C66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCTQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjCTQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:45:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467C14237;
        Mon, 20 Mar 2023 09:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBFUU2JPiGaFa+SlrwNffh0Idv0EoYWB0Wd1epWWgdP6k1fb99Hx8VNeWAZFxpVlLRU1HeaqypNLwnHnLUmAqLqlHorn9fziuitSEBwbzRCyucq5j+JWjM8HG8JyeGnu9gSkNh13GmyAowrxpEpGDYjNJCmPft+1IOO/CTnuSRbKaLJj4x9uGJFU6+8LOhZRJfsI7hS5VLsoebLM9eB31fBreLQQ13wH9m4SyYZj9xZ4chvynHOu67i04rYu/EHPfdhLugGEVpaVUY1oDvNV8LwHObCXQ5yz39VHWnLx2dDqXVWYVlRKRnPXOewY+hXDS6MGDkkiP9aO0owpdLHqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6XFF4HqWe/7xjL1xMujk9Z0saez063aTDC2xCGJWcw=;
 b=QY0+Uap6BijAr5OFs2NTYVeYmIPHWgRDeBg/TaVpPilKTak5OARmnJtxHF988jE4/uhB1zYVC9eMGDah3PlQ6cSvOFrNJv+QVGS6jRcV/S4kJ+rOofg68MXFDA4Oytux39MzolvBg1c3WP+/81z5J9QtuVl49SRDXmSwoUW2bIp6PKtznkJcSbvdynTX14zF741zwLmUWtb22nsgyJFpefHOCWJ+G7kQTcYdzc7igDiqhQFYh0tROybRLuAGWhtmpSbQaVEqOk0aDNBfwO9ghZr97/Mpc0avVJ2IlGg3C7w1eZaOkwp4DCFaSVXMGQUDOEnNSi6aGspWXL6KkezRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6XFF4HqWe/7xjL1xMujk9Z0saez063aTDC2xCGJWcw=;
 b=oj7jjfnlZnSFF+FeoqfIjhggSkFgniAx7kUv/lwE5fJ4SrNvU7lIlBJsHvnxOJBasFU1/FdIMIfqXANsxDcKYaJ+/EgjexZ2LTqXje4aTrAEyiivElMEy41TS+pci9kGqzFx1V25hPwFmibP9OLgGBhF1P2C0ZILkk9vLv1lT9drr4Et1yCgbg8VD13pLtcGipmt2z54N9IAyTy4vGasN74tuQsTa/VrrWvuPQ1qD37xGNoquu/CUjpsWHiX2RY3EcTY2Pk107qRCuGoMSNtSLpizgSxoNW5APqK5qpwPYLCUCaBeAKWkeLyyeX9y9p7mAlMaoPIRpiwb/d+Tq/qXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU0PR04MB9274.eurprd04.prod.outlook.com (2603:10a6:10:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:39:32 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:39:32 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2 2/4] pinctrl: s32: refine error/return/config checks and simplify driver codes
Date:   Tue, 21 Mar 2023 00:38:21 +0800
Message-Id: <20230320163823.886-3-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230320163823.886-1-clin@suse.com>
References: <20230320163823.886-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0150.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::17) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU0PR04MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: d292625f-c580-4748-6f14-08db2961aee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ra2BkvKV+NiSU1mNDy8ao5MG/Bzy5dS9KstUSMfm53BU6QuEjJaT1ZnUwFxg1OPBMjKlW0anp7gsL6hjTY+DenBkJFW8f/FcawmY+8RQFwSRaEjhEhql/jW6kMi9VIKIoY4/yAYa5IX8H26NXVr8SI5Db+pvdMyQX1cCF9fAaPaWpXX6vTU/Ujv6lSWI1MLY19ChMR5ZQJEznntuB3t8A4mirzZVl0DUkoSDqSsdgjj5skZP1Uahi83ES3ROUwznL5no/J9lCIqo+8hSPP1JeuBS2ccBZNSUQM0fMdAMErzDrcH87ktZXfs5ey9yWFMePHLuuhI6BEGKaRnDYvf20P7pCECes4rx5NlemSNYyuGJo/4UetO8S4ci7XlgBaZ7+Von9doF0YaNJUVGfClBG3PfEF13AfZrceJr2gbGvykHL9M/TQu/q2Fcxano8Hzq7iwIiO4GUV4mRvRe/Khlc524RDZGKWd0KVGs63QfdAeeElyo66x/L27UwQJsNiUkg6IaRsREQoPMH9hJzpkiKZWtSbGQtTJKL0VQmy+pX3/zmOvdy05rFG9vuvUw8Z8i3r4L+Kv4jdFshUjp49bVIYRkCh9wufXrY9ycza2V/0Vy04dvqRVM8QS5Jue91qoS8YWwkxNVn/tGzCwPuGuu9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(8936002)(5660300002)(30864003)(7416002)(86362001)(38100700002)(2906002)(36756003)(4326008)(6486002)(83380400001)(478600001)(6666004)(107886003)(41300700001)(2616005)(186003)(1076003)(6512007)(26005)(6506007)(54906003)(110136005)(316002)(8676002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zpCmj0r3ZVzDbbYbiw9eyofIwm+2EKKwxCR1yVI6I36OwNUATGjM8q8pM7Mq?=
 =?us-ascii?Q?Iev8hpsByw6XbRYSg4rILyGVM03YVYk+oGkkue0if4vaK67JNrYuXZoMZzPz?=
 =?us-ascii?Q?x+3Ye7gCkumsJteWADtF8qkx7ayuC0Rm+AH07mHn1/W9FZS0NpUEaKcUmrDm?=
 =?us-ascii?Q?Fp9Ah8zUdPvLm+tdEHA0JbrxCBlQsX7y0xbDUm7/u+2ZnZBDfaRNB1ozVq9k?=
 =?us-ascii?Q?p9TdGCfUWhi14Go9eTmuipm0FYpL6OBZIx2dbR+bV469zL/ECpr7sDgqdGDk?=
 =?us-ascii?Q?WzNxHMcxF5itblFfRgQlRHB6sVfzy5wvLLN4ZIEHjqv4YJDCXrDYljF/F+LP?=
 =?us-ascii?Q?olDrhJEvziEiJhhmwh45ncxZmbX/bVI8838FxEP0MdZ1zM6lwOynDaMDQNUx?=
 =?us-ascii?Q?2Oasoe025ckk7dFXW+v2umVyvJ09/qJ/eyiJKq6nRlLDoBVs9eG2yoCYAWAc?=
 =?us-ascii?Q?1eqaSA1wpbvvF3HexQXPuokjY4YAk6IAOZK56mAsJgJT+R1+NIehQTxONzIa?=
 =?us-ascii?Q?y3hMTA9qYPBSyOh+m1WG0yV1bDW3qSkIH3Ufmot8YbFuhXC2lBdbWSKVrt0c?=
 =?us-ascii?Q?4iCBnpseKqZl6r2Juh8FeLDb4N+OwVH2ITDW6LfF3mIFUreJfxthpP8v5UxI?=
 =?us-ascii?Q?/3hucO72P+iWUylZDjXLwKAyE80RFBlVjhOP4YNLxIgiTXxZ78yNM1/JonPe?=
 =?us-ascii?Q?wqKtypd/vOqRvvlB85p6Sw8riQO5kF98hbq5nc5QKUXqLkZvb3i7YYkI33ve?=
 =?us-ascii?Q?oGC5mZcF9k50jFj7xVSCUBG3KrI2Q1LDqgSmP/h89sxMJs8lUeR8N3dbTnjg?=
 =?us-ascii?Q?pRPIrca16TMW82hAhTBYOGM8bp6icd4UF/vHzOm2JN5IE+bD7ZwB5VdoFNZ7?=
 =?us-ascii?Q?ITX+nvKDoP81CKSx2ISruyc7Jy3ebghogdZvRBpATG7jfAwse6dXbb0exZXD?=
 =?us-ascii?Q?G579RstU8KpQaTFSM0A31Vj2+YSF67lK+ZKihIE8HzdEgViAxD2ktg7zIBWC?=
 =?us-ascii?Q?YuRwbiDgNpaiD/uCF1CxMq3Lxzv21hdvnFaBvV9D25wvBZ1549PmkRlja2JN?=
 =?us-ascii?Q?dySqc9iNmKHNlS3g0fWfgmfrH0G4vnIQdoDlw5PYcD49D1Bob0g4vJMbHDuk?=
 =?us-ascii?Q?RrntpHDXo2VWzYNenIFR9ZwLceW7vNcEqxe7W16FJfDqQ8vXISdsflOukYET?=
 =?us-ascii?Q?jStkv/Nh6+1SQu306XNT2Iom7eYVwx5s1Bz75Aay97OqPaSnjiJKDPSd5Ssx?=
 =?us-ascii?Q?LuCmfFYl/p/jECi4T58Yl1p1V3oV/PbZUHrUsY0HDkvtoRLyhhcdVGwnQqvL?=
 =?us-ascii?Q?id/Iol9dsjmtz76a3zshggNUk6fqo15b2LYyDYuKDFtYvUbjs86TsyO+q50y?=
 =?us-ascii?Q?LOB+ScCQ8+KWxOydmdv+Q6knzrrXImxI+9ZiuO/kd9Kuf5KMy7cvdPDFrswZ?=
 =?us-ascii?Q?CnZmTXjyQv9Ev5fTd1RDTMlXdGlS5kS6GQ0+yoloKWSs+N6DFZaHeG3M4czv?=
 =?us-ascii?Q?GSN1p3Y4l1Qnjlbo4qngQyGR7nS2TRrsP4yrg69fLVrZ6Jwz3MSptbCpL8tu?=
 =?us-ascii?Q?n1fxLXVbvUstcTJJ6I8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d292625f-c580-4748-6f14-08db2961aee3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:39:32.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klKHDpaVJKYnc/Vf83pakGtfdrk7rMEXRQ34HTBun9yHq/ykwAZsJGPND7CXFCra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9274
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve error/return code handlings and config checks in order to have
better reliability and simplify driver codes such as removing/changing
improper macros, blanks, print formats and helper calls.

Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v2:
- Enhance sizeof() arguments.
- Fix blanks and remove unnecessary parentheses.
- Move s32g_pinctrl_probe() changes to the patch [1/4].

 drivers/pinctrl/nxp/pinctrl-s32cc.c | 141 +++++++++++++++-------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c |   4 +-
 2 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index e1da332433a3..f698e1a240ef 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -28,7 +28,8 @@
 #include "../pinctrl-utils.h"
 #include "pinctrl-s32.h"
 
-#define S32_PIN_ID_MASK		GENMASK(31, 4)
+#define S32_PIN_ID_SHIFT	4
+#define S32_PIN_ID_MASK		GENMASK(31, S32_PIN_ID_SHIFT)
 
 #define S32_MSCR_SSS_MASK	GENMASK(2, 0)
 #define S32_MSCR_PUS		BIT(12)
@@ -46,7 +47,7 @@ static struct regmap_config s32_regmap_config = {
 
 static u32 get_pin_no(u32 pinmux)
 {
-	return (pinmux & S32_PIN_ID_MASK) >> __ffs(S32_PIN_ID_MASK);
+	return (pinmux & S32_PIN_ID_MASK) >> S32_PIN_ID_SHIFT;
 }
 
 static u32 get_pin_func(u32 pinmux)
@@ -108,7 +109,7 @@ s32_get_region(struct pinctrl_dev *pctldev, unsigned int pin)
 	unsigned int mem_regions = ipctl->info->mem_regions;
 	unsigned int i;
 
-	for (i = 0; i < mem_regions; ++i) {
+	for (i = 0; i < mem_regions; i++) {
 		pin_range = ipctl->regions[i].pin_range;
 		if (pin >= pin_range->start && pin <= pin_range->end)
 			return &ipctl->regions[i];
@@ -224,8 +225,7 @@ static int s32_dt_group_node_to_map(struct pinctrl_dev *pctldev,
 
 	n_pins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
 	if (n_pins < 0) {
-		dev_warn(dev, "Unable to find 'pinmux' property in node %s.\n",
-			np->name);
+		dev_warn(dev, "Can't find 'pinmux' property in node %pOFn\n", np);
 	} else if (!n_pins) {
 		return -EINVAL;
 	}
@@ -317,20 +317,25 @@ static int s32_pmx_set(struct pinctrl_dev *pctldev, unsigned int selector,
 		info->functions[selector].name, grp->name);
 
 	/* Check beforehand so we don't have a partial config. */
-	for (i = 0; i < grp->npins; ++i) {
+	for (i = 0; i < grp->npins; i++) {
 		if (s32_check_pin(pctldev, grp->pin_ids[i]) != 0) {
-			dev_err(info->dev, "invalid pin: %d in group: %d\n",
+			dev_err(info->dev, "invalid pin: %u in group: %u\n",
 				grp->pin_ids[i], group);
 			return -EINVAL;
 		}
 	}
 
-	for (i = 0, ret = 0; i < grp->npins && !ret; ++i) {
+	for (i = 0, ret = 0; i < grp->npins && !ret; i++) {
 		ret = s32_regmap_update(pctldev, grp->pin_ids[i],
 					S32_MSCR_SSS_MASK, grp->pin_sss[i]);
+		if (ret) {
+			dev_err(info->dev, "Failed to set pin %u\n",
+				grp->pin_ids[i]);
+			return ret;
+		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static int s32_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
@@ -375,8 +380,8 @@ static int s32_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
 	int ret;
 
 	ret = s32_regmap_read(pctldev, offset, &config);
-	if (ret != 0)
-		return -EINVAL;
+	if (ret)
+		return ret;
 
 	/* Save current configuration */
 	gpio_pin = kmalloc(sizeof(*gpio_pin), GFP_KERNEL);
@@ -387,7 +392,7 @@ static int s32_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
 	gpio_pin->config = config;
 
 	spin_lock_irqsave(&ipctl->gpio_configs_lock, flags);
-	list_add(&(gpio_pin->list), &(ipctl->gpio_configs));
+	list_add(&gpio_pin->list, &ipctl->gpio_configs);
 	spin_unlock_irqrestore(&ipctl->gpio_configs_lock, flags);
 
 	/* GPIO pin means SSS = 0 */
@@ -401,23 +406,20 @@ static void s32_pmx_gpio_disable_free(struct pinctrl_dev *pctldev,
 				      unsigned int offset)
 {
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct list_head *pos, *tmp;
-	struct gpio_pin_config *gpio_pin;
+	struct gpio_pin_config *gpio_pin, *tmp;
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&ipctl->gpio_configs_lock, flags);
 
-	list_for_each_safe(pos, tmp, &ipctl->gpio_configs) {
-		gpio_pin = list_entry(pos, struct gpio_pin_config, list);
-
+	list_for_each_entry_safe(gpio_pin, tmp, &ipctl->gpio_configs, list) {
 		if (gpio_pin->pin_id == offset) {
 			ret = s32_regmap_write(pctldev, gpio_pin->pin_id,
 						 gpio_pin->config);
 			if (ret != 0)
 				goto unlock;
 
-			list_del(pos);
+			list_del(&gpio_pin->list);
 			kfree(gpio_pin);
 			break;
 		}
@@ -461,7 +463,8 @@ static const int support_slew[] = {208, -1, -1, -1, 166, 150, 133, 83};
 
 static int s32_get_slew_regval(int arg)
 {
-	int i;
+	unsigned int i;
+
 	/* Translate a real slew rate (MHz) to a register value */
 	for (i = 0; i < ARRAY_SIZE(support_slew); i++) {
 		if (arg == support_slew[i])
@@ -542,10 +545,11 @@ static int s32_pinconf_mscr_update(struct pinctrl_dev *pctldev,
 	unsigned int config = 0, mask = 0;
 	int i, ret;
 
-	if (s32_check_pin(pctldev, pin_id) != 0)
-		return -EINVAL;
+	ret = s32_check_pin(pctldev, pin_id);
+	if (ret)
+		return ret;
 
-	dev_dbg(ipctl->dev, "pinconf set pin %s with %d configs\n",
+	dev_dbg(ipctl->dev, "pinconf set pin %s with %u configs\n",
 		pin_get_name(pctldev, pin_id), num_configs);
 
 	for (i = 0; i < num_configs; i++) {
@@ -559,11 +563,9 @@ static int s32_pinconf_mscr_update(struct pinctrl_dev *pctldev,
 	if (!config && !mask)
 		return 0;
 
-	ret = s32_regmap_update(pctldev, pin_id, mask, config);
+	dev_dbg(ipctl->dev, "update: pin %u cfg 0x%x\n", pin_id, config);
 
-	dev_dbg(ipctl->dev, "update: pin %d cfg 0x%x\n", pin_id, config);
-
-	return ret;
+	return s32_regmap_update(pctldev, pin_id, mask, config);
 }
 
 static int s32_pinconf_get(struct pinctrl_dev *pctldev,
@@ -604,10 +606,13 @@ static void s32_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				 struct seq_file *s, unsigned int pin_id)
 {
 	unsigned int config;
-	int ret = s32_regmap_read(pctldev, pin_id, &config);
+	int ret;
 
-	if (!ret)
-		seq_printf(s, "0x%x", config);
+	ret = s32_regmap_read(pctldev, pin_id, &config);
+	if (ret)
+		return;
+
+	seq_printf(s, "0x%x", config);
 }
 
 static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
@@ -710,7 +715,7 @@ int s32_pinctrl_resume(struct device *dev)
 }
 #endif
 
-static void s32_pinctrl_parse_groups(struct device_node *np,
+static int s32_pinctrl_parse_groups(struct device_node *np,
 				     struct s32_pin_group *grp,
 				     struct s32_pinctrl_soc_info *info)
 {
@@ -722,21 +727,20 @@ static void s32_pinctrl_parse_groups(struct device_node *np,
 
 	dev = info->dev;
 
-	dev_dbg(dev, "group: %s\n", np->name);
+	dev_dbg(dev, "group: %pOFn\n", np);
 
 	/* Initialise group */
 	grp->name = np->name;
 
 	npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
-
 	if (npins < 0) {
 		dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
-			np->name);
-		return;
+			grp->name);
+		return -EINVAL;
 	}
 	if (!npins) {
-		dev_err(dev, "The group %s has no pins.\n", np->name);
-		return;
+		dev_err(dev, "The group %s has no pins.\n", grp->name);
+		return -EINVAL;
 	}
 
 	grp->npins = npins;
@@ -745,12 +749,8 @@ static void s32_pinctrl_parse_groups(struct device_node *np,
 				    sizeof(unsigned int), GFP_KERNEL);
 	grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
 				    sizeof(unsigned int), GFP_KERNEL);
-
-	if (!grp->pin_ids || !grp->pin_sss) {
-		dev_err(dev, "Failed to allocate memory for the group %s.\n",
-			np->name);
-		return;
-	}
+	if (!grp->pin_ids || !grp->pin_sss)
+		return -ENOMEM;
 
 	i = 0;
 	of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
@@ -761,9 +761,11 @@ static void s32_pinctrl_parse_groups(struct device_node *np,
 			grp->pin_ids[i], grp->pin_sss[i]);
 		i++;
 	}
+
+	return 0;
 }
 
-static void s32_pinctrl_parse_functions(struct device_node *np,
+static int s32_pinctrl_parse_functions(struct device_node *np,
 					struct s32_pinctrl_soc_info *info,
 					u32 index)
 {
@@ -771,8 +773,9 @@ static void s32_pinctrl_parse_functions(struct device_node *np,
 	struct s32_pmx_func *func;
 	struct s32_pin_group *grp;
 	u32 i = 0;
+	int ret = 0;
 
-	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
+	dev_dbg(info->dev, "parse function(%u): %pOFn\n", index, np);
 
 	func = &info->functions[index];
 
@@ -780,18 +783,24 @@ static void s32_pinctrl_parse_functions(struct device_node *np,
 	func->name = np->name;
 	func->num_groups = of_get_child_count(np);
 	if (func->num_groups == 0) {
-		dev_err(info->dev, "no groups defined in %s\n", np->full_name);
-		return;
+		dev_err(info->dev, "no groups defined in %pOF\n", np);
+		return -EINVAL;
 	}
-	func->groups = devm_kzalloc(info->dev,
-			func->num_groups * sizeof(char *), GFP_KERNEL);
+	func->groups = devm_kcalloc(info->dev, func->num_groups,
+				    sizeof(*func->groups), GFP_KERNEL);
+	if (!func->groups)
+		return -ENOMEM;
 
 	for_each_child_of_node(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[info->grp_index++];
-		s32_pinctrl_parse_groups(child, grp, info);
+		ret = s32_pinctrl_parse_groups(child, grp, info);
+		if (ret)
+			return ret;
 		i++;
 	}
+
+	return 0;
 }
 
 static int s32_pinctrl_probe_dt(struct platform_device *pdev,
@@ -804,6 +813,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	struct regmap *map;
 	void __iomem *base;
 	int mem_regions = info->mem_regions;
+	int ret;
 	u32 nfuncs = 0;
 	u32 i = 0;
 
@@ -815,13 +825,12 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	ipctl->regions = devm_kzalloc(&pdev->dev,
-				      mem_regions * sizeof(*(ipctl->regions)),
-				      GFP_KERNEL);
+	ipctl->regions = devm_kcalloc(&pdev->dev, mem_regions,
+				      sizeof(*ipctl->regions), GFP_KERNEL);
 	if (!ipctl->regions)
 		return -ENOMEM;
 
-	for (i = 0; i < mem_regions; ++i) {
+	for (i = 0; i < mem_regions; i++) {
 		base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
@@ -851,24 +860,26 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	}
 
 	info->nfunctions = nfuncs;
-	info->functions = devm_kzalloc(&pdev->dev,
-				       nfuncs * sizeof(struct s32_pmx_func),
-				       GFP_KERNEL);
+	info->functions = devm_kcalloc(&pdev->dev, nfuncs,
+				       sizeof(*info->functions), GFP_KERNEL);
 	if (!info->functions)
 		return -ENOMEM;
 
 	info->ngroups = 0;
 	for_each_child_of_node(np, child)
 		info->ngroups += of_get_child_count(child);
-	info->groups = devm_kzalloc(&pdev->dev,
-				    info->ngroups * sizeof(struct s32_pin_group),
-				    GFP_KERNEL);
+
+	info->groups = devm_kcalloc(&pdev->dev, info->ngroups,
+				    sizeof(*info->groups), GFP_KERNEL);
 	if (!info->groups)
 		return -ENOMEM;
 
 	i = 0;
-	for_each_child_of_node(np, child)
-		s32_pinctrl_parse_functions(child, info, i++);
+	for_each_child_of_node(np, child) {
+		ret = s32_pinctrl_parse_functions(child, info, i++);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -923,11 +934,9 @@ int s32_pinctrl_probe(struct platform_device *pdev,
 
 	ipctl->pctl = devm_pinctrl_register(&pdev->dev, s32_pinctrl_desc,
 					    ipctl);
-
-	if (IS_ERR(ipctl->pctl)) {
-		dev_err(&pdev->dev, "could not register s32 pinctrl driver\n");
-		return PTR_ERR(ipctl->pctl);
-	}
+	if (IS_ERR(ipctl->pctl))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ipctl->pctl),
+				     "could not register s32 pinctrl driver\n");
 
 #ifdef CONFIG_PM_SLEEP
 	saved_context = &ipctl->saved_context;
diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index f99f88615ef6..9f521312f768 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -755,14 +755,12 @@ static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
 static struct platform_driver s32g_pinctrl_driver = {
 	.driver = {
 		.name = "s32g-siul2-pinctrl",
-		.owner = THIS_MODULE,
 		.of_match_table = s32_pinctrl_of_match,
-		.pm = &s32g_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&s32g_pinctrl_pm_ops),
 		.suppress_bind_attrs = true,
 	},
 	.probe = s32g_pinctrl_probe,
 };
-
 builtin_platform_driver(s32g_pinctrl_driver);
 
 MODULE_AUTHOR("Matthew Nunez <matthew.nunez@nxp.com>");
-- 
2.37.3

