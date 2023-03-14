Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E66B96D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjCNNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjCNNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:50:10 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD2198;
        Tue, 14 Mar 2023 06:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpugFDuq3XQuCeB2Pl0Inu5xHvAHBZ8hfB0Q3RtjqV1hBzflumI1KO6CGIsJAX+KyxYaCg5/IL9mIV/CMQgvjNyt8yPT6w71m/u2ePPkGj4ybYfMD9aqMXF7BUX8rq+hSbFHhW+3QMwnxvOS5Y7m0MtBWP6t3kqzvlEbad8wXpKkjc7I2D8rZ5hJaNfMq60CZs+WrNC/KxxTIA5E/uE1Nj/PfJ2sFdfEnUx2ETLw0ZQoOyTbGUSymsmzbET/eKyafW1xI10zNVZwtTZ8M3d1PKtrpwhCtWGpxZRUQE7YmDu3yKHIXSkIrYo2lGxh1gWUVl/mbIbsQoB5xbmyPLKvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqm/XdSR62KN5aS9i0BteRN+t8gdhBVkWJEuNnB/Fm0=;
 b=L20cAyPJnmnFJKJnpqHablj9PN0YknTF9bRG9qKrGBFsDtXXMYFIf2AA94wTYQP+clhTXRm5AwWMvq/gth+erNu7+kj4DkgIYyg0IofKN5JfJJx6lWLhnMZ/wQ5Afs84mr50fxGvjD7n5kNnquU0sK6kPiR2viFRp8Vbu5VclD7b0ji5RP74OIj8CTWqN9EitIh4eP7OOXakwS32jUH+y9Y5vuQJ9070iHMhwrBK85BCh4PgOqd3FrKmSXoMe93x/h+YW+8u8YmWJkRFhS6aG8R0cp+4quQPOQ5WOKkrR7HXHMs+XaOfAG/r0hndYp1hvv2485WUNG83F7QPh+lVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqm/XdSR62KN5aS9i0BteRN+t8gdhBVkWJEuNnB/Fm0=;
 b=ArKLAnBZj3a9oiUoo8XsQ67gDvANDzhS6PRdxgd7NjN2oyLft1wj9mR4Dm04iDAso+zv4ESP7ZiRs42ZKYe28Ns274NAh3AMvPG9S1Fw4BCH7hRo3JJ8y2tauSGx4WmBnhR7xytRH9xlg8No898Z1Rcr4XS3ZqrcxP3pCcMTFt1AF+Vvax8WMXjs0YMW5PP7BGAUa4BfcMYzZA1yNlW71AsiA+Ji1UnSuxyXmXe9sPif29plQ9hAmdnCSnlecKoLsoxCPfK7Xprl3xacbdeOb8MYOnQCACtTLyl6ManFpHQG7U4d3nn4aYEmRmf5LpHDMBnIKa1iQabeI6FNBvvh+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25) by AS5PR04MB9895.eurprd04.prod.outlook.com
 (2603:10a6:20b:651::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 13:47:00 +0000
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::2b1f:7e5:94d0:3ba9]) by AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::2b1f:7e5:94d0:3ba9%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 13:47:00 +0000
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
Subject: [PATCH 1/3] pinctrl: s32: refine error/return/config checks and simplify driver codes
Date:   Tue, 14 Mar 2023 21:46:40 +0800
Message-Id: <20230314134642.21535-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230314134642.21535-1-clin@suse.com>
References: <20230314134642.21535-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3428:EE_|AS5PR04MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: e1037569-3b47-43c5-6054-08db24929626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zCt/ZhMxq4cJ/NaYGxrUlW/wGFZRbZ++kjPBts8irhVTLSTDlPmrHXqFVYiXrLqm0k3G3FJVOYj1s6QjTGENw9n0La/ipPD2ckJzOAviyIJINEPTV7pzCorR5lUS0SHv5kOBeDpVCKeI9EKPPfGKJiJ64A8KMtQpLomux0GYS33sI5PZnEhvmz0jrbSQHI8ltVwBHzz383RPNwi0pl9B0PbpST6q9gUfGC/CtnTkYI7ktR3Ou5CB1LeiEPD97sTud576Yt8WZnzy0JHX0qPBKaYcMtJsjydPezCzfs7NUA0qE+s1Xw6ZYzM/c4rhuxfzO6iSiHU7dG4djSWo1Jk9Y+3O4+QoYfGTA/LlL0Ls5QoPVs/hQ25H/INPctODweX6q79vFlSVylvletYkNLG3psU6US51nKMTqtERnElpawxNlHqX7zlDpnGM+J+aaWi0x4iJJ1mZmlIYDrXRvWVJI7et+LqvftRXX+9A2GxXApLuTvFLlxiw4IzlwdQ50bdHXdKaZwczikOLAGelSLEmSemmy6tvXIqncnZ2Ia1D8oAyY/OYOGRHnwhEAJiq8eDipo24PG8hcH/K3G3b8Kq73nUuxlCpAlpyw7LlmcARpsSzDN0eNAP4Mb6dZT4KZgcgHJbL+Y7vsM8Sjk3GRNAfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(8936002)(36756003)(54906003)(478600001)(110136005)(316002)(66476007)(8676002)(66946007)(4326008)(66556008)(7416002)(41300700001)(30864003)(2906002)(5660300002)(86362001)(6486002)(6512007)(6506007)(1076003)(26005)(6666004)(107886003)(186003)(2616005)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9vTYAusktNGHsfoSZy3U7fXha/N0GEBFWopT+DT3DyGkb+T0IxUGI1wBTi6i?=
 =?us-ascii?Q?9TRjLrPbReyI4OvbkJ4QUDWwWop2hrmR/0yOvl8JapmJcWjd8Pm5TY0UBg4h?=
 =?us-ascii?Q?8FbgzBoQ3vEJMZVOSa/I/jhgv6ugT/7ELXU566GJd2+eDbTkcUj6AdXavc0u?=
 =?us-ascii?Q?JJDBUb/bxAW3hjBXgQjhPIAqpdzIpwAEoN34tiXRGWHmaAdgBXAedV6aHPCb?=
 =?us-ascii?Q?VYgcIaF16t1GgJm4dN9VuICBp++OWYW7U5RYj0pNoGjnMw0uFoYNlLi9Poqy?=
 =?us-ascii?Q?74DmJtx+1eM4r+2Q6VgTSWGt2McGV9yjQuOWBRlP/j8sQaYggKBfOpQHdonr?=
 =?us-ascii?Q?KPtDAowTC59/1eoiU+DWD0guz7qZhQjOZ9S2umfba9dxaMahvpniYi4Yrfdq?=
 =?us-ascii?Q?JZ9tRllVPby7Fx4Iw8J8xqwDM8TrLrK3tyTIs67Sb1muK9Wc57QbPQ9yIteM?=
 =?us-ascii?Q?XVpH94v6chYbSX7kmrzvLD8Bd79yAWkdUj47MNJOSZWvoXfdDj+o/7zmyD2y?=
 =?us-ascii?Q?O7tScQRxT3WfrQjypaPnLWEb1gOophXqjMLuxHmWsKEhv0qRr3tiIwprOWO8?=
 =?us-ascii?Q?t1evsZ7uuf+JTcn2inwKnsJgUJKUjkSNj77NKvfMwLVtDgtLLditg40P2rkt?=
 =?us-ascii?Q?eol5YP7DFISzRmm+D0eUifLtCoeLHfSA9CWDPMlc8dZwF8q2THmU9Lxi8eci?=
 =?us-ascii?Q?a0M8EHcZjPPM9f5T3Z7GGwZiuqpFdKQj/g6aLSai538PGBT2a9h6rjxARsrv?=
 =?us-ascii?Q?neV7T9H97b12ssTS4bUqsEn5wck5nzz7HPg7KM3cAxF3EGcXUZqg6HErzfB7?=
 =?us-ascii?Q?1+paGQ8t/Wy2c+C/+qDr0oK4knmisaqNIFgHGaiUWhZX8E0OEJFogxcblTIr?=
 =?us-ascii?Q?0T1S2PKPlRNhCTXXtNLOytp+EMkPMCN5S0IiR2u8Q7zBXBXx49imWQOK+kUA?=
 =?us-ascii?Q?TSEmMusrEqXfJFJe/IzsU3qHcPsOd3hqB0Fmy5Q3o4uGe1ggQMPy9ZRN7218?=
 =?us-ascii?Q?0Unn4uZSQuCP2o/K0Gt7pNVyNC2s0WgspOJdhwaQTDPJC7nl968lqI9a2k1J?=
 =?us-ascii?Q?wr5f19/GiezOeUx2PV9sBSWEyq4oSP2ohFuvtF5t/C+X+pIe3z5ZIZZ5NTkB?=
 =?us-ascii?Q?YslbIW2K5JTm6bzm5jKfnr0sghFDKs1vpgi8m+T0Hyk/CBbIo1Q/k0XIMj6V?=
 =?us-ascii?Q?ub1t0WK4RcOfIOKLJch3fvOfrnDZ0pEbpdJIkLXvFB+DjoJp5rXsqLfd/G+t?=
 =?us-ascii?Q?h2VshiRQeCLDVASytn3xVPSzRxmtwDZ+06MKyWi/uMRjMsCKVXXNfZtbsoX4?=
 =?us-ascii?Q?c4rUCif7RNHqYFfocXIRAaKpqQ/uT9f5qeRZ2B+b6suuoG4UaT8YPzU03w9N?=
 =?us-ascii?Q?/FdnQ/DWRGByczOf3YBikhqE2HpIiMemj6+HXu4GGxC2P/CDr101Qp4f8Lii?=
 =?us-ascii?Q?vewY7leMAyRS+hM4O2RU3pKLefl/mGFzP8GaMJdb3Q6vvzDeL8u7JpBPey/n?=
 =?us-ascii?Q?CvzL1i+ohX0mz55XGTgu4vkQDoIMxQtVuRfNx52gl/hsqadQaUX/v5vdollx?=
 =?us-ascii?Q?SmFOk29hr4+0cC0pOl0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1037569-3b47-43c5-6054-08db24929626
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 13:47:00.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZo7yKPgtoa7djKHQE4yZOxnuEaV3Pt9FqhbNcZp7PVUrJ9x9g0jTHDDJuUO3DN8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9895
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
---
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 141 +++++++++++++++-------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c |   8 +-
 2 files changed, 78 insertions(+), 71 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index e1da332433a3..7a38e3216b0c 100644
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
@@ -401,15 +406,13 @@ static void s32_pmx_gpio_disable_free(struct pinctrl_dev *pctldev,
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
+	list_for_each_entry_safe(gpio_pin, tmp, &ipctl->gpio_configs, list) {
 
 		if (gpio_pin->pin_id == offset) {
 			ret = s32_regmap_write(pctldev, gpio_pin->pin_id,
@@ -417,7 +420,7 @@ static void s32_pmx_gpio_disable_free(struct pinctrl_dev *pctldev,
 			if (ret != 0)
 				goto unlock;
 
-			list_del(pos);
+			list_del(&gpio_pin->list);
 			kfree(gpio_pin);
 			break;
 		}
@@ -461,7 +464,8 @@ static const int support_slew[] = {208, -1, -1, -1, 166, 150, 133, 83};
 
 static int s32_get_slew_regval(int arg)
 {
-	int i;
+	unsigned int i;
+
 	/* Translate a real slew rate (MHz) to a register value */
 	for (i = 0; i < ARRAY_SIZE(support_slew); i++) {
 		if (arg == support_slew[i])
@@ -542,10 +546,11 @@ static int s32_pinconf_mscr_update(struct pinctrl_dev *pctldev,
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
@@ -559,11 +564,9 @@ static int s32_pinconf_mscr_update(struct pinctrl_dev *pctldev,
 	if (!config && !mask)
 		return 0;
 
-	ret = s32_regmap_update(pctldev, pin_id, mask, config);
-
-	dev_dbg(ipctl->dev, "update: pin %d cfg 0x%x\n", pin_id, config);
+	dev_dbg(ipctl->dev, "update: pin %u cfg 0x%x\n", pin_id, config);
 
-	return ret;
+	return s32_regmap_update(pctldev, pin_id, mask, config);
 }
 
 static int s32_pinconf_get(struct pinctrl_dev *pctldev,
@@ -604,10 +607,13 @@ static void s32_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				 struct seq_file *s, unsigned int pin_id)
 {
 	unsigned int config;
-	int ret = s32_regmap_read(pctldev, pin_id, &config);
+	int ret;
+
+	ret = s32_regmap_read(pctldev, pin_id, &config);
+	if (ret)
+		return;
 
-	if (!ret)
-		seq_printf(s, "0x%x", config);
+	seq_printf(s, "0x%x", config);
 }
 
 static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
@@ -710,7 +716,7 @@ int s32_pinctrl_resume(struct device *dev)
 }
 #endif
 
-static void s32_pinctrl_parse_groups(struct device_node *np,
+static int s32_pinctrl_parse_groups(struct device_node *np,
 				     struct s32_pin_group *grp,
 				     struct s32_pinctrl_soc_info *info)
 {
@@ -722,21 +728,20 @@ static void s32_pinctrl_parse_groups(struct device_node *np,
 
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
@@ -745,12 +750,8 @@ static void s32_pinctrl_parse_groups(struct device_node *np,
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
@@ -761,9 +762,11 @@ static void s32_pinctrl_parse_groups(struct device_node *np,
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
@@ -771,8 +774,9 @@ static void s32_pinctrl_parse_functions(struct device_node *np,
 	struct s32_pmx_func *func;
 	struct s32_pin_group *grp;
 	u32 i = 0;
+	int ret = 0;
 
-	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
+	dev_dbg(info->dev, "parse function(%u): %pOFn\n", index, np);
 
 	func = &info->functions[index];
 
@@ -780,18 +784,24 @@ static void s32_pinctrl_parse_functions(struct device_node *np,
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
+				    sizeof(char *), GFP_KERNEL);
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
@@ -804,6 +814,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	struct regmap *map;
 	void __iomem *base;
 	int mem_regions = info->mem_regions;
+	int ret;
 	u32 nfuncs = 0;
 	u32 i = 0;
 
@@ -815,13 +826,12 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	ipctl->regions = devm_kzalloc(&pdev->dev,
-				      mem_regions * sizeof(*(ipctl->regions)),
-				      GFP_KERNEL);
+	ipctl->regions = devm_kcalloc(&pdev->dev, mem_regions,
+				      sizeof(*(ipctl->regions)), GFP_KERNEL);
 	if (!ipctl->regions)
 		return -ENOMEM;
 
-	for (i = 0; i < mem_regions; ++i) {
+	for (i = 0; i < mem_regions; i++) {
 		base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
@@ -851,24 +861,26 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	}
 
 	info->nfunctions = nfuncs;
-	info->functions = devm_kzalloc(&pdev->dev,
-				       nfuncs * sizeof(struct s32_pmx_func),
-				       GFP_KERNEL);
+	info->functions = devm_kcalloc(&pdev->dev, nfuncs,
+				       sizeof(struct s32_pmx_func), GFP_KERNEL);
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
+				    sizeof(struct s32_pin_group), GFP_KERNEL);
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
@@ -923,12 +935,9 @@ int s32_pinctrl_probe(struct platform_device *pdev,
 
 	ipctl->pctl = devm_pinctrl_register(&pdev->dev, s32_pinctrl_desc,
 					    ipctl);
-
-	if (IS_ERR(ipctl->pctl)) {
-		dev_err(&pdev->dev, "could not register s32 pinctrl driver\n");
-		return PTR_ERR(ipctl->pctl);
-	}
-
+	if (IS_ERR(ipctl->pctl))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ipctl->pctl),
+				     "could not register s32 pinctrl driver\n");
 #ifdef CONFIG_PM_SLEEP
 	saved_context = &ipctl->saved_context;
 	saved_context->pads =
diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index 5028f4adc389..0b0b06f12b8a 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -746,8 +746,8 @@ static int s32g_pinctrl_probe(struct platform_device *pdev)
 	if (!of_id)
 		return -ENODEV;
 
-	return s32_pinctrl_probe
-			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);
+	return s32_pinctrl_probe(pdev,
+				 (struct s32_pinctrl_soc_info *) of_id->data);
 }
 
 static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
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

