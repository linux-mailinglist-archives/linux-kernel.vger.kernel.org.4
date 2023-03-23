Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA66C6B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjCWOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjCWOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:49:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01010244;
        Thu, 23 Mar 2023 07:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikdG1BkUPc3JWWfm6njoiMrkbbnnLoEYd6HN6Y0FvnT2deu4XnCzX9btaBCTMp/TmN/ZzsZ9izgLZE5S/W9hqFWHVcEU+tO3vWB7dNyciNjsovfrLk2VcSYHMeobQA/NUcQxOhkgwzgm5iOiEPgU1qelWg0XOWD94v1XvH/CC96dm4bZ13wy25fxBvrpER4RjBiQir6n7OPqIB+lj73kRdRZepRyYibp0H3klxp7XbIAc7IjWP8e20U3GKKBwQqZgchUwA9p4++0Ns65K5iJ+xE3IcJODXYQM0DNO3S6RHWiCQm0igz6hn12XKpo5uCdExEZ/2YRlHDULdVRLXF+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUVQY39rnq/iC+i1aiK8K33wTWf8DjeE2CewvWWfpFI=;
 b=asybYF0Dy39lYNoyiIEKHsuE1/iQisL5VWbsfrxtuET1469Dh2uZeJqPtnCnzVgc5sYR6hkboyr1X8mAg3DHZwqdYcLAApYl3+txXqT87xYWl3sW6Pw4rspYGxogmNHbCoQc4YewcUorr+eCQi+ySI9fIsdrhtxB9syJFsX6AJaUSaN/meDHX2TB5ee0E2YnozrJ+2ES6V0Fl2zmWND16z3FsgNStK9gJ5iPMotDe1TFxh5zt0UPQ2arAMw1Ac8XMJ+MUJj76uaX9LNpQTBLyyS5sJee6Ww1Lt3NmxsN4H/gBRQ1HB0/02fOHcLmQemHuAFaChCX6ijzMvFx7BufeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUVQY39rnq/iC+i1aiK8K33wTWf8DjeE2CewvWWfpFI=;
 b=0zDN25mmZO4k2iCrgIf/97464Mz4pxPNrtbToaNAI43qwRwRsw5TQBPQNori00537nyK2h65WogczbB0LERqwnMmdlXDhmpIkGjGPVuk9bpXljPHZoDvISSjLoDOUk8rBzYm0M4FMonooNXXvjwvd78hGsuib4ldKsRJnlkXTqAyaMyGo9BNyJHLpdPtFo8HdkfAu4iOVn/2kKT9LlLq7IgF3xft15XVydEOtPHREwv5RHxEYiztuLxgM23vIRTYBKqg3rDRu65fgC+2OTxCjY8msd5FHsfsbK9aLmeHGOanTQGTYWSZxHqBTqU/mToE0jCST47kyQG7o21dv2Cb+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DB9PR04MB9625.eurprd04.prod.outlook.com (2603:10a6:10:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:49:18 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:49:18 +0000
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
Subject: [PATCH v3 2/6] pinctrl: s32: refine error/return/config checks and simplify driver codes
Date:   Thu, 23 Mar 2023 22:48:29 +0800
Message-Id: <20230323144833.28562-3-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230323144833.28562-1-clin@suse.com>
References: <20230323144833.28562-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DB9PR04MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 1370cb59-9cb8-4314-f045-08db2badc799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usos8reJfuf5k4D9djnyfuNf2sHPc9rnhx+7u8GgVv3NTun3I390uFxnpbLgzPODnMddm0yehZjmIJlt1mHamfX6HZZgXdqy8zpUM6kQ2LA2urQ6UZTij//OuSAXnlOrcrxtYRNiIi4kLjJWXmPFuon2GoPdbWg15HfvF7i4LGPN6eZEL6RvWwVVWONhTnCSrWc08tbxRJNqP+QADe4CLX4NrDd+9K0ip7yS183qwm1Smtx/NgXaCSyR8c6EH5PHR9UcICrvlC/a1eF1Fugp8JLBAOwbH5BryqKH/a4DLwyHVHXoKxBZj07s7BE2zkHeK00GKUYe6CRcPEcl4kziMtUN5iunlpDt/R8ILQzS/K/xI+pBHoK/NLSso52KubDHyaYRXLgQdUxhDWd9Y/MKTN+edaxoqOSwMmnS2PLN0juGAVpgN9oeI11gbU1R1RZWKpqn3UOlhsjvkVqxzHzsr2+032xtLeP4e8Y4mNwSemgrB6XZHfnYI6n7Hh9G1CygW8LKVtc9QZpKqw6xUHzkyCd/iTTKqBKF2LdmhcMXAdIqU+Kt/pJI88/yG6DXDRY9oGJngVFAH8r+KCrWj6KS0QmJKS9/5dOi39TJffDTZSxCkppGFg+kuX7q2Uo5B2Ekol0GgHIlSu+EN7S37dv40w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(30864003)(4326008)(66556008)(66946007)(66476007)(8676002)(110136005)(316002)(54906003)(5660300002)(7416002)(41300700001)(8936002)(1076003)(26005)(6512007)(6506007)(107886003)(6666004)(2616005)(186003)(83380400001)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqad8rA3iz99CzF1dNTE9e96mr6/zW8zH6BebPPlZ/PUrQO3f52fWOE4J7OL?=
 =?us-ascii?Q?+7TFpXTXNhxkF0XCoIMNovd77ULpwQdHoUVsRYOoipr+l1xDZwdzmB6PHtWx?=
 =?us-ascii?Q?zXIcqCvj/m8+DGbBnJVp9t+B0IkxThc7dBUpj9In4GTrJn3DAgPBVFmLHX0b?=
 =?us-ascii?Q?76yggri/H8iYASjJayxGl10AZB6tx+M20geVVH7bFw4qwSh7bUjEU1kE09uf?=
 =?us-ascii?Q?Kt3RONYsF2pstzwi98+X6NmW6UpWiQoQ4Mj+n+ZWCep2tedLuxOnHnPGh3de?=
 =?us-ascii?Q?kwq4gT8SMPdKz9n8w1T4UVDeqeBbvsMr4MzMz1UPixXCi/T8B6SqYaHF+eHu?=
 =?us-ascii?Q?aHaXouTdOrDPyHprBt0NZVsZ5S2xtw7wsYuXTnywqu7C9TG4ezMjRfpsjQb3?=
 =?us-ascii?Q?lDujGJt0OvgP3o2p7jjkeNp5xVYQoInUogEs396jsE5rTuqYWwRCGYoIN9OM?=
 =?us-ascii?Q?wGkBUaN9b07F57oUwGYhYlyZIRfNndI7sgaU8crxtC8XJg9z7y4tuV0hzY+H?=
 =?us-ascii?Q?UrgOAGfLktpZiANejtd4oPQVvzRZaToPpeLAWwLCMNuTeobarBOI1oB98Vrc?=
 =?us-ascii?Q?QR2+YJYrWSNdaV9W7vZCW1V4zSNtLZPmSGQhdzWw1XNHL4ekR7BCpsut9VCo?=
 =?us-ascii?Q?FVZDyM8ZyLXltZo2qR58wnvKmkDViMccdAJ7S9eOQOJlsjt2D+yOnDO52+Kz?=
 =?us-ascii?Q?+jRibmUk7SXgSWMEUWTrZnOuBpMXVtqSSDeh1XERdBm3rhCJxlp/eRLJLGp1?=
 =?us-ascii?Q?PpMYt4LG10qYz9C7uin80hJo6GfS66ChM0KHCaB9fayhGxK4164Jm0GJ0vcb?=
 =?us-ascii?Q?GJFcQG0clvL3SU+DpVXfUz0dFle6O+HUrxl3ZdvBFpzEpx1BpRxXw4QfNeGV?=
 =?us-ascii?Q?g9lKFaVhcM5mFrMP5IY0lJ4A8ngdUJd2kFkJQN8uQ1Lzk6zGr4RgEFLfOnwO?=
 =?us-ascii?Q?9wx2p3D9jLOEAl3BT5Z6DIUefwOZq4nyStREs7ruaQbPb1fCduXnpCIHKK12?=
 =?us-ascii?Q?lsi6Q2macznYYzobK8TIjYPI/CqQ+XhXrOZIqVtTLQMo7i3lsZVGr4YChmHW?=
 =?us-ascii?Q?DH6V2QhHXPwm8V5FJskI26cPPBW/po3tVvfwzW3pIT42byOM1G2pRFg0Y2qR?=
 =?us-ascii?Q?XJOGHQV2F92/gloChVc5yJI/K4gLuefHFwDr43kfQH4jZuC1KfM2nfIdyDl2?=
 =?us-ascii?Q?6sjTYk5IRbla4sEkkib0YaGNFk8uv+X9OSzMlfF7C3zHv+nMKlpKGVqW4p5R?=
 =?us-ascii?Q?hdZAnwuftqlFIVKjn8/580C4nOomL/DpAwzHOp1CuWIy5ez3RytMGf+lm/24?=
 =?us-ascii?Q?PgW7ovFQTW8oYEjOTQTFtZA3Jz4rHE2cRS89OFL9NerQ04+WR0M78RjYM1/p?=
 =?us-ascii?Q?VaAbPis1YgYNH2QeKIaYCbrfSaAyEK1Fra/to4KQtAsNLaFylhWWjMzuQtiG?=
 =?us-ascii?Q?GRfeVBsONkOuthRP8lALsNQLXFpdk+shB/WLO6egrE6li4HUIsb4O6iuNBQ4?=
 =?us-ascii?Q?GbxZCW+pobSrzMxk9uAVPVNrDMMG1hTZqMk0HX9D5W2p/qa7Ag4t0hGaEK44?=
 =?us-ascii?Q?eKAO0g0rr+Cb5KqGsR4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1370cb59-9cb8-4314-f045-08db2badc799
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:49:18.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfqslLyLCMRD0MoQVO0PdcxUJDe3I5UXskZj3HC5oEGxvIx83o6Yrn9ArnfXutz5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9625
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
index 0e2d93681769..9124c6c5e5d4 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -754,14 +754,12 @@ static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
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

