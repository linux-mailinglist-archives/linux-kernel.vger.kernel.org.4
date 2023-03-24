Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28DD6C7FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjCXOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjCXOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:37:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0919103;
        Fri, 24 Mar 2023 07:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2zkUofELxNDpbpQsOU27Wpnc4xpDjYGnZNWLfK/MFmcBocqu1HneO1LMKIYQxcx+kK5n3RfV9P1Ogg3584J+XrWXN9qrlSykns3oqdNqgBl/9uPS/s5wQOf5ERUB2+7cmuHM9J218iC66HaOWZfLKOanNU/SXX8ms58hL4NI8BGM0i7BNZ8wxA/rIH0zpzqnKUZWjeqn7ls4Zhh1Jev5zm17YdjjFOkLJ9QNBpppwgIxSZJPlF+L+Ou+LrqnFBwmIblKoM2LRzjE5mssLpxcOJYUo7JlMwClxDVsu5NofvM6WAp4ytvw12Ja3C1Gb5NpIY4rH/t4oSZI1Z+N86yvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvLq29R3cJdMNhrDZYSjsggrvLxGzA+VlJIrGEgigSA=;
 b=MqzLjP0mQR8OnYwAswm2k+a3XSo7QZxwA1AcaVMKLfVslbuBuqZTCj68ZI71OQd6JHKfLnODaZt9uGXoyqdeLRYV9PxfJ07VMuS9Q35F0N9cGu2/rKHMExCjUjrMrzVeLduBYefxa0uUTlyi2l8x0jbN+22sREi8sdVJ/FqxI2J0y4C+agJ9bhN3shjHe6fyZ5HxTs1EZXXfc2vu54jKsU55L9uZ1CJdY4es7Us1oA9ciKyDbHhzGJMHHeRA7x0SSvvn731VQOPLexg73bMeNOkjJb9gHZvGAqZx/GDxZhUPL6CL9scBKkLBOvkJx5h4io2Osez4p45+SSBIPT8gxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvLq29R3cJdMNhrDZYSjsggrvLxGzA+VlJIrGEgigSA=;
 b=SmHZy2iN+Idw71PZ6QuEmdlIlAdtmRdkP5xsZ6kItKwTBRfNte6No83j0AaXU8oUrgPo80zeDRsLf6UGsNRu0sDdWgXlK1H4jge/TooIpAvTpwxr/cmQSPQoXbyViL945fBnQWZlh1FwfhXps0UBIsw74ZA7NX8A8nVmnYGUW00HQNm1JG95DNz1d+08vl9t2e3JCYcwr4xf35AClgRo2Wy05zTgfZjA5Mryu98ZVAl+FAO3nO1emuwdm0iHOGrtE4mqZVlqCIbaF7dBMwlIVmuu9ht4srdSZHvPU6Xk5Semd4ZZcgan/SNZUTEjKU9W8RSJaiJp83hlhDfTS2qpXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:37:16 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 14:37:16 +0000
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
Subject: [PATCH v4 1/5] pinctrl: s32: refine error/return/config checks and simplify driver codes
Date:   Fri, 24 Mar 2023 22:36:22 +0800
Message-Id: <20230324143626.16336-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230324143626.16336-1-clin@suse.com>
References: <20230324143626.16336-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:404:a6::22) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bda6f5c-f97f-49f0-8fc4-08db2c754367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKX1Y8r3eXUNLF7WJO1JMgJ4v+1gnhYy8s27uoRH7uOv6xzs08FNMZFJFb6UNp+MOpePLhz4H9SaD5E4q90vVShjWZ/RH4GtadNnCLI/gTrsSZMwactepXo2GbH4f9L4flKUb7duVpJ0sYSdm3f95NN7e24Gke1p2lo8fWHf0mFZeJsSalkM4Ou9YOYMlj9BKxxj6LQEfcXx/iWiiiw9yQepHGLoLubVrLrqhtE8HCTbtCGIPtFe/KI5vLz8jsMgb7bnZCYdws1VSUCVPO+BtiBzuTPuHUY3CHzToxlrbEFpbQDiqovuSll9wx/uKohyJR+19Q87u/gOC7EZKh/MovsytrAhlngj2NeQGcebkUkBS3eR1FWsgfeu3S/miCcq9nrTu5r7AbfZgf+f6jscyP/OzmP687rST/mzamMxIqS3X/GCe4iuv9M4EfdKE9HrdV/P7KWcp6IVcAAMTbURwc5NSp385zgWF5+8T2O4SsWXVZ1Xv8OjMiMC433Yg6gMTkoz2BgswRxp323r/BFroIzPrIKjfjC6MLap4Ua4fCYvx3e5041M8qUmqhaefz6wpVxZpNAjpvA7uY0HGMkPf4zcac3b6+pAlwke6s0DZlg4zcDkFIkJZz3keKXlcehvnjZ6SdmQf0RyTSqtX8wvOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(376002)(39850400004)(451199018)(8936002)(66946007)(66476007)(66556008)(41300700001)(4326008)(86362001)(8676002)(36756003)(38100700002)(6506007)(1076003)(6512007)(6666004)(26005)(83380400001)(186003)(2616005)(107886003)(316002)(6486002)(54906003)(110136005)(478600001)(5660300002)(7416002)(2906002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TfAyX5UQEGkScTcoA4fTEolfucP1J34BTRGRADwzgqR07MBLdaolaI8UYE+m?=
 =?us-ascii?Q?cyaZgip0A1qoebJfJUZqaObVSQ/Yvqed7Y6W7GD4rGCXjuv1bxYfxIWLO2gF?=
 =?us-ascii?Q?4ASt9hXduHEsHUJDOXqexIEwfX5q0AQq8Oa23SYlBHftaa9/H9mVL616DqJ/?=
 =?us-ascii?Q?RjM1R64asiQb4j4Dq/T4lpbvWv1P9VnondgqOS2Gzl0PpgRWANlyqCZMiABe?=
 =?us-ascii?Q?DzwNqOI90W1hV/8dsc20vjcbVTsDeGgizN+6UM5CNb98J7vaF8+u6OnJ/Wfq?=
 =?us-ascii?Q?fs5xN/O1HQQkJK7HMGdOkF26sXVTqVvl0aLBU7G6+150hQvpNvvZ6K3RaxMo?=
 =?us-ascii?Q?vFK0gtO5LLz757Tlgngsknig1EdPoFxdJ/ONVzdB61YfpWseoPl8ZkBhlbno?=
 =?us-ascii?Q?1/X6C8soH6DfUDbtk0iSccnh66XhxCH2Q4z2766bX1GXjf/n5KqG9mstwWiI?=
 =?us-ascii?Q?MfMeB7VleD7Qa/xJnZ46ZqMtquappIjJ1tS6Y0a4nOn9ddH/PuCaQfpv+99f?=
 =?us-ascii?Q?sfOaP62AX9bjxbV2ruEkk9OPV2uWbpCAiSbiROAyGUBrIZExMQ5h43Th7gkb?=
 =?us-ascii?Q?/NATw38O/B7u/t/EmwITXv8ZfYAmKTDuIkwXa3xVg4B2JheboEa8EQ/09mJ/?=
 =?us-ascii?Q?W5JBcEfPFt/reE4utTJr9V7883DMtwtYswLOmS5AHIheky8XiY2o9UV9oqxu?=
 =?us-ascii?Q?Wh0SgOZQdMD05naIRzNX21nNXTGtt5GJZg6HAg+aYFKDdBzvlzcHJAvsi0xh?=
 =?us-ascii?Q?jBgIm9GQqoKITmZCFG29nw/nW7hUgyEjCZCNQke7YAWMu6o2Vv+VeNwWCT96?=
 =?us-ascii?Q?DYjG9tQRDqvpEF3D2/qFupkOG5/xy+vzSCt8vX22Q6CdKDIhiQHzXLlDsZNN?=
 =?us-ascii?Q?woU5k0jd0QMtsioPHDG8qTXc+0oBJeUevos6bRQIRIdQS6KrovnOeg2/yh2q?=
 =?us-ascii?Q?ztJwP/4ORdUSAfb3Z6osmmnUalqeUfSm2fIEXtuEhfQjOtvOfU7rju/IgRZ1?=
 =?us-ascii?Q?/EXd6SndtpM/O7Qo8VGEUj3HlmdJNXA4KP5813llF6TodsyKMX7Pkz4i0fbK?=
 =?us-ascii?Q?VrU+sagL8Wj5nfYy85fCfISfhaNEMQa+Xv4EsltOJ6fc50DJzuMV0nWx9Nrf?=
 =?us-ascii?Q?u5e6Hok5OoiH7OmIyG2aibeB/tPuWX2e6JNSiIW0t7d/h5IApr2CC0F5ndFr?=
 =?us-ascii?Q?0Gsf7pBA7+T8nAbactfe0ITFoPZJsZXq4XG2lqPHNOpT+Vo4OpWVmnKn0ww/?=
 =?us-ascii?Q?ggOPW8Y+yaDXjh2jElLUzZ6zvhW1QcR1IH0fEwI8zdxOXFLjRJC0i2HEikCG?=
 =?us-ascii?Q?1WSug35Nzq2BKFp6eDNDrmfJb2cITVBUS5U7W7sj3J/STFKLwmP2aWRFqyLe?=
 =?us-ascii?Q?q2R68wCuRCqml4/hn+wikRfKWEppYcp21JV9sNHiXO8O5NSp8svaWRxxxzab?=
 =?us-ascii?Q?OpOCdNz6aPy6/Q5cWK9xqkm2ABPWm3y8JSQUZgwEJcywMyEL4DvBgZ0F8mU5?=
 =?us-ascii?Q?FYOE7Hwz7Qo5TOQZ6FxqU/BQopoRUBaLQbL+dXRR+JHhQeHDg1ahzvEInfFw?=
 =?us-ascii?Q?Dvz8aTU+PBsPrHRA6e4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bda6f5c-f97f-49f0-8fc4-08db2c754367
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:37:16.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WUMfrRO8lijD6S1sYJbkFU6nSesajsJMZi2bwEQTlhTTqvJu0t8AMFlMsOfdFyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
(No change since v2)

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
index 5028f4adc389..d9f3ff6794ea 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -757,14 +757,12 @@ static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
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

