Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88216C9B62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC0G2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjC0G2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:28:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C2435BE;
        Sun, 26 Mar 2023 23:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXiukYbFbNeC3QzGvvs+6URc4CJ9KLXiMmrYYlzcBe1dNK2gTsI4t8cYHjkxyUwotr6l6P7cLPEZCdEFjhauzgk2kqSDTz/g4Nyi2uqCKxfGkOCekubzGJWapxo2ta27keLnBF7PLuvAKm577IBiZYf04zh9/QulcDGgbDBN9P7PS6m+NzqxlAPumNt+z8UpBVZpT9BdHmt+z2ZIfia2G0td65SZ2+D3JGm5z6KbC1u7dAAbJ/ceL/RvlHtxfhWLtqf5VUTgdblZ2JsHjIE64NWo+hlefRKRyvDXWIa0l8Bor3Loa0NYdU8PP1XaAB7MUL8TBqqiXv2FDuCkZ0mXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvLq29R3cJdMNhrDZYSjsggrvLxGzA+VlJIrGEgigSA=;
 b=TvqsxIhSUkCpwDLadhWUqb3HQZJLDWUaeDmf1kN12HriigQv7IXnEhPz29zr34Xicyd90t/grZNP8+N8zDekphBycvOq8jXVSy1+f4qlZULVyhCo5D9mlSkT51lEj+ATIuwiywFaCQCnEzPd0l9iCJdEcfPmWt29MyzjeO6WbG/2FOwlbs1ZAqy+N1+vodbKFS039V788jAThgMl/gX4218rtWr4RF0AcWqWwCbjX1lIfh5XMcl+bV9TmEDPdbHst9bdtDa1XjtbGRp28+ZPkr1iDAsTEbLMyiJa721xcwWfQWqc6YX9KEpYg1ATCkidh3s+eA7dyutkbLCxoC6VmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvLq29R3cJdMNhrDZYSjsggrvLxGzA+VlJIrGEgigSA=;
 b=OEVfaKAcmQ+Mxi8KL/Za+jpmbbg+nOO2QbH2HxsibhlzdlqSh6wvtoG4H+Zyo3HXMtEtjUw8IPzTCXppx8HVvNUAdLQUzWKZ5ncquo1dbkSrabDgl55rsMiV+8jwf6cwI2WT7CVjo41E2NBfoUBd7dOleOhELMY5fC/4ZebEJ26ltuNK8/Yk/3w59TGeVDlB8CjOnXy0/guJ+rpNqXMOleZaj5sOrODUYY51hkVuH77ZLt+sXxxMd78l/QCdRfelePLYWsQiOwTqhAtCDOoRKDzjDti59zQbB7gf+fB6otvw83eUV9adlVtWyd9DB94/WHvOAKxeTgf0/nYTWBnklw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 06:28:14 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 06:28:14 +0000
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
Subject: [PATCH v5 1/5] pinctrl: s32: refine error/return/config checks and simplify driver codes
Date:   Mon, 27 Mar 2023 14:27:50 +0800
Message-Id: <20230327062754.3326-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230327062754.3326-1-clin@suse.com>
References: <20230327062754.3326-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:404:42::28) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 51498c8a-4693-4c9c-e1c8-08db2e8c717e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +v4Eov5sEhdeIZYQ0T+qhyyXUNvLWiaxCLLdL/8S71ewsdB/D/m7RvBjAWfKT01KRndDHLzvea0vA45r5Wnaunhy+//n0MD6fgVf4VhC0sPBWXuO3z1VUY01/ODykNTSoGZSpe/OHAj2bFopQoa1jurZvEOs2/6NWFo6oguS0/meoyL7SZFsEwzieomVLkmvc8/ve51Fh/T6F93pLvrTeytopPYRbK7dpCfcnZdYlGW8kSUwiVd/BOBgdsS6li2JE9kLbErWQZiG563Y/JgeAXJrni2l91Bb+UCj6N94qc9yr5ydSuH38Cm/Z6W+Cbr8slTQIn8TPvuk0QwkJ+YMA0YdQfXxTbin8R1WuadJaxUuyeH7aeodPXzgxSu7wwl+gDTsMblvnv1GCeakM0ZxsjBA7BLTBoz6AWxLOnnkVSlROI0JTh4msgXam/su/NvPqfKAt82mrgcYq8fej0S56Gq8B9/SQnkz6U6FgX1WaglRe1wwf9HQNv0bMUA47mM+dwGiAaIuB1wyGDlyoTVrNoXi68z1+ioT3cb/bSmflNpKqVqRFRYnvgxPBJReTNGH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(316002)(110136005)(54906003)(478600001)(5660300002)(8936002)(36756003)(86362001)(38100700002)(7416002)(30864003)(2906002)(4326008)(66556008)(66476007)(8676002)(66946007)(41300700001)(107886003)(6666004)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTzDX2D/P26DYSpSlFKyc/n2IuvnJ/bEGGtc3FcTxKgtRPpUBKORmdad97Lu?=
 =?us-ascii?Q?O6rCpLe2hhE7UFwr4njRlka8X+4JTgp0T77QxG6dfQqYDoOrznJ8bg0y3A9T?=
 =?us-ascii?Q?F0p3FmvrvUGEHVvD+SqNdFFZWa8PrFrFbu/JtPULA+pOsG45MZXMVLqStT1E?=
 =?us-ascii?Q?bGQVKrPAjwhGvKQ9K2rf7IANT/MMmSGL5n0vP4dlSaP+gek6sOFfpKm0o1Fw?=
 =?us-ascii?Q?DM/RPoWdquu9u/ttyBqarwWj9jyn9uxWKSQvKvE/KWFrxH90MI+mYZHJPxp0?=
 =?us-ascii?Q?Y/7yLu7Y1TJedX9N7aZojU5NN1IP0baRsBHXXTQDUbLU3AJHwJZsWCSQTKzp?=
 =?us-ascii?Q?8Zqee2RiDgYULgawRQolGWzsRAGF/y29n6zxxnrOa8xGs0vb8990A0Jgcu6e?=
 =?us-ascii?Q?DBVLRtVNpbsKGDKyIK3biYXgWQzwMgCbD0r2RtgxH7SGDv8tMnZX0/3XurEq?=
 =?us-ascii?Q?xxoygbzcyftfA7ljAsK9CSsgioTePr+QS8+YI7XekmCmrfirAkUeHW7i1aiv?=
 =?us-ascii?Q?juiEEiI8ghSsojgremLVAoD6cA7kotdwXKJmTT/vaSrz4NhYVrDKkmdUEUPu?=
 =?us-ascii?Q?93i3vkd1EGy36cT/+yaIGgVGfnlMcOW3zM4nJjLwmDvPMmOXxCJaRc9uZv1H?=
 =?us-ascii?Q?oF3n6e/TvLKaKHNEc2dqswhk7XQKLVfZZNm8KS78v+Da1jmXJ5Nyyw3sn9zg?=
 =?us-ascii?Q?8gLZvXEeMbP26qOmZv7vfA3I9GzRpD62EWrT1MIbT0SCHavKeDf8+NttK5Bz?=
 =?us-ascii?Q?gfi3qAl7E4q5XhSLPHbH4S0W4EXfa7oHMNro3CDUoO77+9Qy/52BR6cbQqMj?=
 =?us-ascii?Q?Jo+vIHpglhN+2vGBaVYJp9OV9Lm+hII3OlJLbSoC/1xjpZnyB5saVtEh5+0A?=
 =?us-ascii?Q?D+suoexoIAL+j2Hun3ypBXDCLlSwxrtnuxV6VzdXH+Rj6XiKkRDMjyoS16FL?=
 =?us-ascii?Q?yCuy0h2JJ3nCgjAz+CPYyCu2VizIgdkBizUNKZNh7UPUThk3u5mulL+H5Y0f?=
 =?us-ascii?Q?gMQWkJFyetkV27ZPN/Ypo1GMOSuZ11IXwukBcV12WqjxndYCOTwC6yHNKVGb?=
 =?us-ascii?Q?I01MPfjiAOylx28ECC0m0H6N7ncXsBppbarF/f6NJurdvUxwd3IzdTDvIYMe?=
 =?us-ascii?Q?tB5WCBncz5Y4a90CwRLTFbBQ2mmiHKEsGaY6iKjaq6Qm7HEu0noKdhli3d6v?=
 =?us-ascii?Q?HsOptGqRGMPxig4x8YcZ9u+At67R0B1zkVi+pDt0ZHupBLRVJxoCUnNgieYs?=
 =?us-ascii?Q?tOAlSseRhQLixNAdE2cATU6qmNFHEP1LaCvqKoKIotFgxpWJ8iDU/nWDO3M9?=
 =?us-ascii?Q?f8Ns5S5l2q0HSaV7PVSI7qVMXt6iR0nlHNPiiKvQ1n2LXwHo0jDYATY3f4cu?=
 =?us-ascii?Q?0NSwrLcMyq6bWhZrmOwRGVdKKGrIMi9eLnuj/rS5Jua1AlqakfwLVhHQiViA?=
 =?us-ascii?Q?EWIOiRG97vPC9JyOYsL2fXm6VZ0191YYDTLwWJvnLaGT4tpMQ1kPyQebjZU2?=
 =?us-ascii?Q?VlAlYJg1ouOiMCU9L9e+Xtr/5TFgb2KFF7gON8Gd2kCLIJyaX7bBGGOhzt6b?=
 =?us-ascii?Q?uI1K/g6fUGgjp0T+wxc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51498c8a-4693-4c9c-e1c8-08db2e8c717e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:28:13.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUzKCLR5KrU9Uza7eF73EfwmXxtyZvnq4UrO6voW6nhu9jYvkZKX0W42N496OYlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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

