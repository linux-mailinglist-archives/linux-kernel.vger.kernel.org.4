Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7115B6C6B82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCWOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjCWOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:49:50 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B3119C4C;
        Thu, 23 Mar 2023 07:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiGinwGb2izLLvcnLmw/xUNO1F92jduUkepwO6HZgmZHpyoXicIuhuj0VSlCB2TeFRpGP02ZT5Fkz6t40BeXnxCPlHSItvMyedyN6WAnoi17xIEvinJSLF61l/nAi4UTM1FYo30LJAIFTcjxqKEyvaAiSz70QvX8DCH8bUg953RBL5UZtJW199J8l2L1SbJhQ3UNSpHd0ogs1I9HaI/dZIO88voC0PGnqN9MK1MyQravoBxCf9Bad23Z5DJfxm1+/iWlZFraaC9absTOTWyjrvXtyEFsq8ubr+ZywdURpIFpRaAgz162lvOQCEn6vqxnEKGRGCD1wo93Gj84/rZMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QI8EZEEEurt30V5FmM6kobkFcNbuiuyjRgyWU7HQAM=;
 b=KmpIU+gjo8rDNyHewpe/TWvvI5oNSwPKuiVYDYx8mCBe5i3kvxmQnWsDKGYEpLmjAaK9v6555vwOGmJTfl+RluZ+wj8TXf+fb3aASfk+SdaQOLr4mPtHzSs38AlXTTRRz0kZgwKKaIp5GRsgfOsju17B+IBo7QMMKdLbmTwTPydPdLCwVmMLg9GgQcTEou//l9W76sRKDIxoyN4YE6CM77rxilSpnPUcz8nWhfRypgkCbunnNSM3MAc5aV4XSlOGXNqjv9LYWjvg1FyERQgEV7Y6cn9OoNClhrfeSYLMmhtmfMcAsjGw67ilzLsxH0vfgXDSLRh9TFjS6aeTVvrHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QI8EZEEEurt30V5FmM6kobkFcNbuiuyjRgyWU7HQAM=;
 b=3Ew2uW7oQsgC/qKHjS+ExQM6d/61ywdbN3Q2fDnN2w/SruiEsXzpdIJGHa8heH+e2Fd+XfGkFCvE8PCquQI+UyVlwr+3inmGdduEf69rbILmgy3TX4gVoYwEthaLe9sXCHGCjjoarkc+FPZRUkT3khGsi074+hJFweYakly7tDynDGy5gJ73kYA0UxgLnEIpizulNWcNUW8SmJU3X+4CzQO+XRrWt/9ScrXUp/HDQEOLfEPMishQ/LbGYozBx3ljo3Ex1Dj/oz76C32dPSdbriCyYnZJ7msVEWoLDH+wdw546MEq59N3p2jqRgsNiGzsb4BItTRL+DFpuhaZBP/2LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB9254.eurprd04.prod.outlook.com (2603:10a6:102:2bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:49:34 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:49:34 +0000
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
Subject: [PATCH v3 4/6] pinctrl: s32cc: embed generic struct pingroup
Date:   Thu, 23 Mar 2023 22:48:31 +0800
Message-Id: <20230323144833.28562-5-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230323144833.28562-1-clin@suse.com>
References: <20230323144833.28562-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0332.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::18) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8e8822-541f-49fd-3e38-08db2badd0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wp0REVSfxrDt7SiL5RCWEhKwFM5v5iHvECoozsg79h5wM523mFA28snt5yyRuynDm5Q6wedFnovVJuyXcofk5yT90dtPLR7Ge+HQftZqVwx33Ncylg+LA2gWwD+BQPCnaNXnLgL+GdU4AMOAVlUIQgUeFkpq/37viET3+4Y8o7Qqnkiwn62cQHqhrAqlqlX7xBSACZU4ihbNsHHYx+2M5uwe9VJhvi7BCuyv3pR+WGGnHAzAOxl4JWHYeohgmTseUJS5f6Tpn8GwdMuGwmmwuhjDcoU5DWypX04S5sWDppBmUUd9scxWtKE7FwZLsGLBeNhz+RPNBEy6VH0TS+BN2wud5O1d1Jym/YplfCGXJby5ettdgIz/GFjf+WkDpExsevYr3O/Tfhht5jBm/c/7ZkYsu7Z8WxqNWPQvdb4eoXJzsas3bNNfjiM/YpvNwNPPZGtWwTJ/bTsT1rqD/XtH8Sa+CAggVIR/8s0TUwmco+bU50wzSN5Aq7oc2ZtWIh2zVwXOAyYdcrf/Hg93EJgVNZH0Ai1hXZ/7dV2lWGq2IY7oUOugK3FGgoXyxAcE+rItg8/JUHVsFjhDLPjdCuKTp+QG874hBo3jbAWMCYemKYWrfadO6KllH5N5YskdJTrHdRg+GjbKzSK5sPkEkX28kzrKcxIpBTHl5DqTX83kZGcFZn7RHF1g+hjz8ig02TEc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(110136005)(54906003)(5660300002)(7416002)(41300700001)(8936002)(6512007)(6506007)(1076003)(26005)(107886003)(6666004)(2616005)(186003)(83380400001)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?54d+MxgUes7bfMrkozaGxbm9Tjuf4+iH5MQNMD3ePSvo1AhV0OlfVBM8BcuT?=
 =?us-ascii?Q?A9OYEPY8tRGNviemDhRPZ61VracVhI8NIYfL3r35AX5rbMPGqjYzaEV8GKQf?=
 =?us-ascii?Q?ebcGGxxD1CVeFjNld/UKtKIsGMhwiVLAVF237CJWLY5qE1IRcVcBWUBouYQq?=
 =?us-ascii?Q?VMos85WqrukjdGmCkromduoBHpwlGy7jZbzak8zX2FJgHVQ8prmHcn4QPF3B?=
 =?us-ascii?Q?t7MOh8Vbtme3G6DNSTRoNazD62CFKe2vlglCq9MOyfV6Xt7CDPRDbw2cok0/?=
 =?us-ascii?Q?/AIBQDC4eoH0hv9JQDHdWioo4nf5gBQ35LHzgnJJdtyiEbW2sE5ek+e4g4HG?=
 =?us-ascii?Q?RWYvc9JKWwXdXgy4jZlty+ev7mfuRdMTAdzA93niordTPRx/4LNjUOQHrjuF?=
 =?us-ascii?Q?OcCVYXaOi0NUzL6JD+LdpqACVBxQizBUQZwhIYQCLoY2615r41ht1abjN9m4?=
 =?us-ascii?Q?jA/+Ozn17TZG/mmvKuKxlJ9kg5MtECgs2fUIpFP8YsX5SMXq7g9XyTaOsdgS?=
 =?us-ascii?Q?0si6JdOwNT0u/2vl3lRGPhvZEGhtD0mbwWkVnn73mPCKrIkBeYlbepsHl5f/?=
 =?us-ascii?Q?HK60mY2D5Zqyj5fSpn5wGbZW8E+3bj0RmLQDl9QXd+biUOwgpfce2HywWZQF?=
 =?us-ascii?Q?J7taaE+13qdD0w+DRhUFGzu2TcTukynyta1o8E65/iIG1txj+7YCaKoXTjKs?=
 =?us-ascii?Q?31TD5aKgfuC1E8F+kTFcYZdMiUOTn4t9vbPOhoYGzA8Xek53EAiuVarxNY35?=
 =?us-ascii?Q?TGQjOCCCfTRDsLA3Cmpoez8BrdTspnxKyuneI6zaEIa9SNxKR59xP2DMeSzH?=
 =?us-ascii?Q?BYiyZpXUw1Vba2rukhkkrJn7Jb7BO3YVv68Awyn2NgOgEAE+HLq+48wumcyT?=
 =?us-ascii?Q?veTJNydH3/q12kB8EF+8bcpUVKjY79oJd5/FHS3hxqCDV4UBOz1aU04sH9LT?=
 =?us-ascii?Q?m0Z+31+fZTzrFukQxLlJNuIz/YcT/H0N3YAjd3+DkzRST+RPuRmJaFfLIOdG?=
 =?us-ascii?Q?+mjQ5a0Wh4EMZoVoaTB5WblgLFfEIuqjlwP6TdyE2UuO+m6zKhr5ALRTd4km?=
 =?us-ascii?Q?NG5kFC4rLVMg/p8zcaIiVho/KRoHH+qbEFG4ru4oPm6XGJGj0QqDmnAT/1BS?=
 =?us-ascii?Q?KrqtIRTqwg/HAEUwm8jwMRGilRbYfAH9pqo9BR+S5NsT06fSkIeRAHWODYRl?=
 =?us-ascii?Q?NsRT6HZTOg57pudFfGTTFhPVegwf94dGy5qZ2QQuncYhcwQ6hlFO7j6uiNi3?=
 =?us-ascii?Q?xrtXdOY3QhO6iSsrvz3h5Lu8bnEsRWAXtBIUVh4Zc3WU7bPrBr+20ynYARbr?=
 =?us-ascii?Q?v4UG9LYwtxyTP/nI4h7fKvqVeEFbetD/42pPixslTNm/JVoz7RTn/svYxY8j?=
 =?us-ascii?Q?yNV6yqlKB99DjU3T5wBVgaVr4+NXJkg4XUvYHvOERhMKkLghX94ShtxHo4ik?=
 =?us-ascii?Q?5FSmTClw0H8xlTOsYr48iu7PmLxLD5UnZPp/qfpVmX834YQ5xnZT0e+c0PS6?=
 =?us-ascii?Q?PE4/rPiHVD2YCVTYqFFtYbfYfbZQ8SJtc9JXV9FrtnOYwV/fMMTQGqX8KSuV?=
 =?us-ascii?Q?YfGkKDkkDO/C7Zw2vy0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8e8822-541f-49fd-3e38-08db2badd0f8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:49:34.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +me0AHNQfKiKJh9aQ7Lz6OzJ1O/Zqwhg0s63HXCxj95Nhh/O1BrQpd2lO5F5XPUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9254
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic data structure to describe pin control groups in S32 SoC family
and drop duplicated struct members.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v3:
- Separate the generic pingroup patch from [PATCH v2 4/4]

 drivers/pinctrl/nxp/pinctrl-s32.h   | 12 ++----
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 57 +++++++++++++++--------------
 2 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 545bf16b988d..850cd668f406 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -15,16 +15,12 @@ struct platform_device;
 
 /**
  * struct s32_pin_group - describes an S32 pin group
- * @name: the name of this specific pin group
- * @npins: the number of pins in this group array, i.e. the number of
- *         elements in pin_ids and pin_sss so we can iterate over that array
- * @pin_ids: an array of pin IDs in this group
- * @pin_sss: an array of source signal select configs paired with pin_ids
+ * @data: generic data describes group name, number of pins, and a pin array in
+	this group.
+ * @pin_sss: an array of source signal select configs paired with pin array.
  */
 struct s32_pin_group {
-	const char *name;
-	unsigned int npins;
-	unsigned int *pin_ids;
+	struct pingroup data;
 	unsigned int *pin_sss;
 };
 
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 36f323f87785..e65c88162d7f 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -188,7 +188,7 @@ static const char *s32_get_group_name(struct pinctrl_dev *pctldev,
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
-	return info->groups[selector].name;
+	return info->groups[selector].data.name;
 }
 
 static int s32_get_group_pins(struct pinctrl_dev *pctldev,
@@ -198,8 +198,8 @@ static int s32_get_group_pins(struct pinctrl_dev *pctldev,
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
-	*pins = info->groups[selector].pin_ids;
-	*npins = info->groups[selector].npins;
+	*pins = info->groups[selector].data.pins;
+	*npins = info->groups[selector].data.npins;
 
 	return 0;
 }
@@ -314,23 +314,23 @@ static int s32_pmx_set(struct pinctrl_dev *pctldev, unsigned int selector,
 	grp = &info->groups[group];
 
 	dev_dbg(ipctl->dev, "set mux for function %s group %s\n",
-		info->functions[selector].name, grp->name);
+		info->functions[selector].name, grp->data.name);
 
 	/* Check beforehand so we don't have a partial config. */
-	for (i = 0; i < grp->npins; i++) {
-		if (s32_check_pin(pctldev, grp->pin_ids[i]) != 0) {
+	for (i = 0; i < grp->data.npins; i++) {
+		if (s32_check_pin(pctldev, grp->data.pins[i]) != 0) {
 			dev_err(info->dev, "invalid pin: %u in group: %u\n",
-				grp->pin_ids[i], group);
+				grp->data.pins[i], group);
 			return -EINVAL;
 		}
 	}
 
-	for (i = 0, ret = 0; i < grp->npins && !ret; i++) {
-		ret = s32_regmap_update(pctldev, grp->pin_ids[i],
+	for (i = 0, ret = 0; i < grp->data.npins && !ret; i++) {
+		ret = s32_regmap_update(pctldev, grp->data.pins[i],
 					S32_MSCR_SSS_MASK, grp->pin_sss[i]);
 		if (ret) {
 			dev_err(info->dev, "Failed to set pin %u\n",
-				grp->pin_ids[i]);
+				grp->data.pins[i]);
 			return ret;
 		}
 	}
@@ -606,8 +606,8 @@ static int s32_pconf_group_set(struct pinctrl_dev *pctldev, unsigned int selecto
 	int i, ret;
 
 	grp = &info->groups[selector];
-	for (i = 0; i < grp->npins; i++) {
-		ret = s32_pinconf_mscr_update(pctldev, grp->pin_ids[i],
+	for (i = 0; i < grp->data.npins; i++) {
+		ret = s32_pinconf_mscr_update(pctldev, grp->data.pins[i],
 					      configs, num_configs);
 		if (ret)
 			return ret;
@@ -641,9 +641,9 @@ static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 
 	seq_puts(s, "\n");
 	grp = &info->groups[selector];
-	for (i = 0; i < grp->npins; i++) {
-		name = pin_get_name(pctldev, grp->pin_ids[i]);
-		ret = s32_regmap_read(pctldev, grp->pin_ids[i], &config);
+	for (i = 0; i < grp->data.npins; i++) {
+		name = pin_get_name(pctldev, grp->data.pins[i]);
+		ret = s32_regmap_read(pctldev, grp->data.pins[i], &config);
 		if (ret)
 			return;
 		seq_printf(s, "%s: 0x%x\n", name, config);
@@ -736,6 +736,7 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
 	const __be32 *p;
 	struct device *dev;
 	struct property *prop;
+	unsigned int *pins, *sss;
 	int i, npins;
 	u32 pinmux;
 
@@ -744,38 +745,38 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
 	dev_dbg(dev, "group: %pOFn\n", np);
 
 	/* Initialise group */
-	grp->name = np->name;
+	grp->data.name = np->name;
 
 	npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
 	if (npins < 0) {
 		dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
-			grp->name);
+			grp->data.name);
 		return -EINVAL;
 	}
 	if (!npins) {
-		dev_err(dev, "The group %s has no pins.\n", grp->name);
+		dev_err(dev, "The group %s has no pins.\n", grp->data.name);
 		return -EINVAL;
 	}
 
-	grp->npins = npins;
+	grp->data.npins = npins;
 
-	grp->pin_ids = devm_kcalloc(info->dev, grp->npins,
-				    sizeof(unsigned int), GFP_KERNEL);
-	grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
-				    sizeof(unsigned int), GFP_KERNEL);
-	if (!grp->pin_ids || !grp->pin_sss)
+	pins = devm_kcalloc(info->dev, npins, sizeof(*pins), GFP_KERNEL);
+	sss = devm_kcalloc(info->dev, npins, sizeof(*sss), GFP_KERNEL);
+	if (!pins || !sss)
 		return -ENOMEM;
 
 	i = 0;
 	of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
-		grp->pin_ids[i] = get_pin_no(pinmux);
-		grp->pin_sss[i] = get_pin_func(pinmux);
+		pins[i] = get_pin_no(pinmux);
+		sss[i] = get_pin_func(pinmux);
 
-		dev_dbg(info->dev, "pin-id: 0x%x, sss: 0x%x",
-			grp->pin_ids[i], grp->pin_sss[i]);
+		dev_dbg(info->dev, "pin: 0x%x, sss: 0x%x", pins[i], sss[i]);
 		i++;
 	}
 
+	grp->data.pins = pins;
+	grp->pin_sss = sss;
+
 	return 0;
 }
 
-- 
2.37.3

