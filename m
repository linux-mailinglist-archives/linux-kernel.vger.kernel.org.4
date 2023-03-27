Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31B56C9B67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjC0G3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjC0G25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:28:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDB49D9;
        Sun, 26 Mar 2023 23:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4q4ysG7/8CaUggGYm3nB6eivh6qVH8sYSVy0mr1vpmPtAVt+p3NOEJ7MUDLZTE6N9XvPadeUTtDHMd++GOO+sc0ZloyqsarrYAvkoxY++tEJIQ0f99b9vBcVsX3qEhZxwB9l/cqhS+TnbYuIPHsopw/gCeXL0UqVUmIivqUxjJGkyayDmWNPVNG/LRo2SS+8bNi0yQPFVZoqR/hpzs/X2e5ig/GV0jqGVSScy/E+fZjiCXK1DQ0vj+XyUVa98Pfx+m3UFN2WfEsKKZr1L4EqqOmywAvVRCgocCQooaRIwdpsDgFRATGZSMILFYQufGy5VLwZBlCoAv6kVDbZsVNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZRs/jyzaHHU9yyQ5B/+4/wBwOdzvv9NMFuYlMaN61Y=;
 b=Krj/hp16fFisPNnhb2nSeF9kZRRKuylroXTEoRnW7k28I8ZeMEkMKafWL2JElB+/kYFGGGayz/kQbs7L5uk4jarZNRH5sUuATafP5yesYEX63I8qcs9ASLB7W+sPrNYu67JFi2T7r6yrdnOGaVnrVGTayVgDYIBt9KA/DJIogTwD5yRxcRrcd5/lBhyD90lBkstwb2SD3ShaOcRJcX8dHYSk04xn+bEz0Yl+9jRK218EDpA0TxkoHDMydcbffEPCDBIMjYtQdquk98YHVmyoaZicu4XFRCsS/zqa3TymMbeIMH5bbP8wZ4kP70K35GFyI3gywsjbe7ZmFZrhelhE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZRs/jyzaHHU9yyQ5B/+4/wBwOdzvv9NMFuYlMaN61Y=;
 b=0okwNQGduJ1v+RwX/nDowZ9pcY7B4z2CG9d3BjnqKvXRXaM8LQC3lHTnq8QfrZnFouYqrG9yyyMtiDe+E0HWn1cO0HYRcdMa7gW7A6TTd7Nnpea5/Fwqc9KFlIesscN0D5ICM5mMhvh+I4qXrYEcwaLFReERSPfNPZYMv0VxqfhstGMXkW+ExLw3BFIuStqWKUfl9dmNVgB7Viv2/CYCK6mmOmQiUtcbwDozYAAQIsvjKLQ2YOBEGpQcFnXO42XONnPxOy0G2BPsiQudtLI4IMSnNZaOMOlqgB9I+7IENhTHgn251eTCUHW83Cz0GF/JmbSIc/Oi8sq+MqNaNjwTLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 06:28:38 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 06:28:38 +0000
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
Subject: [PATCH v5 3/5] pinctrl: s32cc: embed generic struct pingroup
Date:   Mon, 27 Mar 2023 14:27:52 +0800
Message-Id: <20230327062754.3326-4-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230327062754.3326-1-clin@suse.com>
References: <20230327062754.3326-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0020.apcprd06.prod.outlook.com
 (2603:1096:404:42::32) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf65ed5-a50f-4429-f32a-08db2e8c7fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHTxKETHY4fJRVrYeciwle8J0/2I8dHTfsAO2IK9E7iX86aarRcL5Go6SusGAK+ARs5+Gp/UCZD8pI9kOICyNQhqiE8cI+ow+KB6+QJGqtropUrCUEtBlhr036UHmTkop7UaX9KDpdUxxxNowTrDPxmff4VOIHPdUNapfm36LupV8oXLhp2BQAUTlEWTW4QUkG8U4cawiVjmFLcljVN+MZ7lGgMbXaMwrn89wARzZqdf38Y0sMzZI9k57K2Z1yeV2k34WbmnMBBdJMXIk6xs3gmiyMkLgxTHHCseUU4UKQNc21sISbE9AvdlxmCZ75dIW2SfUSKSOgvI5q4Nky7E7U9alzK1SZH/Kf2MA8UAOZKWwa8Mtpr7GuHHk063DTHdRnbBmnmwn6zFIE9iCbrRvy6/KRfnzukaQjwbSQBUvO+KlCITRsQ7Ctf8jaUqrHxQ0BdG6I7WZ8sMgNgm9KmpeqxvD40ZBLjLPOwWYpTGwwqqPYRGuUFL/4S6fEHcLooXkEj3oKKFY6s7iiZonEOo+eSatG1hYusTYyk2hkNEZg+RQmMOBVU7mlxHrIyIx+YodgW0wOKqAzRiT+WpiQhwK/2xDpUBX5+y73KxcwGZPDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(316002)(110136005)(54906003)(478600001)(5660300002)(8936002)(36756003)(86362001)(38100700002)(7416002)(2906002)(4326008)(66556008)(66476007)(8676002)(66946007)(41300700001)(107886003)(6666004)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(6486002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqjYKtTgArjJdnupBOoIYAu5f3vstHRTJJ2WIC1E6ChbJpsku6H5ddne3Pkg?=
 =?us-ascii?Q?r6w4gSUTzYRMN1jmiPKcFn5rFHR5tI1GaqcGnSiRTo8npLSX6tawePau3zGX?=
 =?us-ascii?Q?Fc3gR8uR69B9ZRV+pUtLrR/5idSx1BMrLK5qnsoo61rOaxfx1MOVgRaFaImh?=
 =?us-ascii?Q?3Xhx7+Sb5+lMHiSJwVa6PfwxKdD6CtvT9GzttnEJx3NRo2Fu2TWmqZYgzA3H?=
 =?us-ascii?Q?6CzMnSzu06C3ovqjsJVick8vMtpfSCzUPjmbIdn1TdpFKYLDKdLfP42oCywE?=
 =?us-ascii?Q?DxI5Lw3/Nm08g3fypC4NFoeSrWEeH728ePdRe3SICw/7DmF4GXvQsqdsVgWp?=
 =?us-ascii?Q?2BWNh204aRehfJYnd8O37DnnmnHMPgDUxs07C/+pT8d5Gp4wzt37cN3HlW5/?=
 =?us-ascii?Q?IPbxWf5Wntbz/01R2sECmHp24DvBBPAmkHucUuZ1iMXroMeArJZHxniHajEO?=
 =?us-ascii?Q?iGBXhgdvEllJE4foZWxh+CuHxLdq4okaScuopzbDu5KgcHNaVM19X85/uD5p?=
 =?us-ascii?Q?cKdw9gA/KlPUlyRmTgyPHUUl6F9svpzWJGvCCXWA0hDOq01A1PTQoD+MHi1B?=
 =?us-ascii?Q?MsjJdnY5/4M0X+XTdh2nx3CewlT5tUnyghXk04S3RQsUAuFbB84eiG6LJMxa?=
 =?us-ascii?Q?UlyyC9Jx57JvYyD7v0ZSzUlW619PEW7c1BGfC9NA8NUDQ5v2j1gVPhekr8lU?=
 =?us-ascii?Q?DxQvzN7s4HR3MRmUtpU+iseww/bZEX9MrHyZnjuGJgjfnP0KnUxh0+LMnw/o?=
 =?us-ascii?Q?vsPwkqZS4rbsDtB8SvzJe1nX5Hqv6+Ji1DT8e8cqY33ZYysogYKOv4Xtwq8h?=
 =?us-ascii?Q?rf9qk+ayvvFpPxY0ovPKMFK6YC5yrXdk5guS3taHIzi08aqpPUaY8uYljWgc?=
 =?us-ascii?Q?Vrr2xvbuqfuU1iyc8Smp0r4dVsGCOXRlI06N692K9+xxl0or811loi/ByGSB?=
 =?us-ascii?Q?YEhZFHsmZEffH0k/sb7u3XVJD3G3bmYn63XK4iXgoSaPmjyXkj0Rflp5XAvK?=
 =?us-ascii?Q?PT+f2L5EbZjcStZ87+Oh/7c0d5+9jk1L5Zip7XfBXjmyCdZB/0C5y/FIwGo6?=
 =?us-ascii?Q?8gCvWqdwdYeJ/x6sgW4vDE2NoHySmaoul+7tjKnsOZ67eVnzYbMhFTEs4YZM?=
 =?us-ascii?Q?VYsnSCAdQIldjzjRoWAQdpjZl4Ho0eYy0lyLumDauY28kZBl6k6ZRy2f1ds8?=
 =?us-ascii?Q?psSqWst9ZaQgBKz/zv571nnRTHKOpvuL5j5HgrPn99U8sL5VY8Y0cIDwVN4e?=
 =?us-ascii?Q?iq4cK9xJDw+Uv/qV+vXNcmt5vBqsb6LfRHNsti+m5FrmET5CoJvbHO6H6Sys?=
 =?us-ascii?Q?LTzArMZrLcwBiV7y3r3536mFtIc1BEiCuyz5izJF/BedFyVfOgDqRs4Z32US?=
 =?us-ascii?Q?8P/v9nCOaZu1MP2f7BIpw2/YaC3RC2dOOxEP94H6+a8UlQ1uxJxUMXaH8l5P?=
 =?us-ascii?Q?pKKseRDEIXRyRPVXi/yCAJDUeEY6svo0PbNBnrmK9KG+pdKe7v1oVs06k8Mv?=
 =?us-ascii?Q?LLg8k/IdnbDxwEUwuQLBszzZm0tm7eZqVQdskBl4r5+sgoLShmrnnEfxhLjt?=
 =?us-ascii?Q?hVf41h9wC0SEc1uN7AQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf65ed5-a50f-4429-f32a-08db2e8c7fa8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:28:37.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCwRXumwoYj2PnuGY/p5xNT60Us7unrisAaZEtu2ytIx2WWSEXvDpV5wD02jFyjB
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

Use generic data structure to describe pin control groups in S32 SoC family
and drop duplicated struct members.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
(No change since v3)

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

