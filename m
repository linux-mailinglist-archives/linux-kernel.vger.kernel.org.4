Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57206C1C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjCTQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjCTQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:46:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3634312;
        Mon, 20 Mar 2023 09:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0GX2W9OBshiJ9S3fwrAXKPE27hYuBNth5MIuLdEIzbQH0iywAduTmiC9sPyozk0D0Xmr7JGwHmywHd3CI+l27NgmqZBi4pm+43PW7fGfscQ7CtE6FAZaL5N6PsIAbMdsaPjV4LWDzP1hLwbUTYzwWqycO2huBVUD56P1NUrtBna5tIa477vVUq2j8NOolyvR3BwQzWvcc4rOFh7FDcK1VSuZ2Xfmwu5KIzTJzLhXXzgq+z2ma5mg1m4x7hOapmS8EuM3QDrv7cmMR1qEXefyHkTGVO1k7NC8cFGQzn5uQLuFF2VOh2fyNHBDrFdTwLwfL0IqxKUFIdFQSijbF6cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atEW99XphxxL5vQX+WSYX8HvoXtoyRlQitZt2ZVpS8o=;
 b=QWjo8tWI94a+1+5TTMFOAwm2Y4RNxT48bCy4Ui3xRNsn+k1W9yRjX77E0zY/t3BeBa10V0L+QwaVp47EhdmjzFS8o69AEOts6PnVEY5QAyqSvGGZk5nE8KoUyzGDF3RgAsfhXkBkbm63jYTaHU91lWT/SgZ76qZl9E9FiR/ITN3gFH96YZx8zKYLZ8OIRWTcEXA6WCjTENXh82+E337UOaDkg+JRMs5CPUrikKlctzvNwcN9UnhuqoLD0CCOKVC/PKFcZKqZ0Ko3knaIUsNGPexNoCwOB3dNsk8FBBbXeIpzfwD06GczRqcxslu0eZFYG0S1eN/VgjUOasgndCiW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atEW99XphxxL5vQX+WSYX8HvoXtoyRlQitZt2ZVpS8o=;
 b=e9WBtq/Tv33XYgJZbfOEAvv4HuHfvslrPcZAqQ0uZNicxx9+M2toW+7ZFFXpEKVGewGVqzyKtAzPZlKr5OwiwaMvEgNSfRIoXT7VZ7JqGzS/DwG0jZkwpld/ttZefZ+LKvJZ1vD0aTguRkHpKlXtugJlxpVCjT0Mu7ypopNql9YIuDcypsJj8dtpIhZrCUBugVWdF2zzIf1BDdj3lbczky0u/2AY7PUbU1YPBtlhHB9AI0PKMCXUKy66r2Mkhhg38jHR4A062BKk+P5XcrAxgJXEAR/5eVWcT0mw18vUDUPsDWxSZCE+QfQpnw1GmmYtxeCaIDwpYpRP0r2TNjcYiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU0PR04MB9274.eurprd04.prod.outlook.com (2603:10a6:10:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:39:52 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:39:52 +0000
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
Subject: [PATCH v2 4/4] pinctrl: s32cc: embed generic struct pingroup and pinfunction
Date:   Tue, 21 Mar 2023 00:38:23 +0800
Message-Id: <20230320163823.886-5-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230320163823.886-1-clin@suse.com>
References: <20230320163823.886-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0170.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::11) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU0PR04MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f96ce3-b218-43ee-abc1-08db2961ba63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77FOf8IM0yiSvut8zmdQxGHN2j9Mx/Qox+rLB2GfOEovplZwBP9Hfnr/XAXrVKzSc8Ga0cqlyvG3Qr7hVohX8ybzS3Yvk2LQtSbbimX8JBMETj+hxzR0ipLSqODh254r8Zqb4Kh5YTnFRh+vkN7mGyeqZocWDT/ijpWXZawKjZWIM5AXBu5CJDqy2mlerCkgH42Cwh7mgM9xJ+cMxdlcoBjdeOLOA62s/kGOl4ib1p+N4j4vPF1uKw0DCbUImZG4GFm6RCwwzdm4hIVSKoeRdmKDAcKESMgQwvh/XK3OmUUTYzu2rE2ZOi1HUQ8zeGKwdLRBw6Gysx7tH5vZ7n188Tkdx46igLrTys0IyI7oUa3sIdIXJqht4Iuo3r78wRXuSDkFmLN/4XHkCL+NcV2gCesUheWlh7pHkjNwNM6RsBJYLkAWNAULtPUq5zNgBYtfpvjdRSjkw2/GMHUgdWSwAC+5WhUXl2ypqgJgDYgyfbLp8NW0dpj0EdBQjGgNc4e3tDaRtcBC3t6e/eJlDqfaExJ3QJyJLRHP901RkpvwBY1ASYCgGTYP+8BV6nepJ/IKPioMBsu6OblFmjadpO9+nKVegB3mQPjny6tB8Wt+fZlFwkfn4FeDNn/v2RGVOPAV1sMFpGMDL5ZbiPsY1CcQI0ZMqncqPB1Pseo4+IIVof1t5lkqSqNa+uxviPV+0nCp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(8936002)(5660300002)(7416002)(86362001)(38100700002)(2906002)(36756003)(4326008)(6486002)(83380400001)(478600001)(6666004)(107886003)(41300700001)(2616005)(186003)(1076003)(6512007)(26005)(6506007)(54906003)(110136005)(316002)(8676002)(66556008)(66476007)(66946007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjkYSf/hoCrvvwt9/spwqkRP7U4PAZgnoQZwrT8+Brb4DBc05mlKReWmxe7R?=
 =?us-ascii?Q?S7SDg4T/2UjgjnyvKShGlVxxdwrPpNFwAujSxUXWgTw/jKgB3rqj4b8uxzMO?=
 =?us-ascii?Q?AJQpV8xxBNtUE4S6xp2cQ/ACgffxp5+N5vMX1hLK+zISORJFAu8cQwoADbm+?=
 =?us-ascii?Q?Elqs+nv0RvQanIGTmn0JkR/ubM90lV8izN4yTc7w/veLumihkJk0MbHyh1ea?=
 =?us-ascii?Q?69NzP7GyRt955ZgALZMy5ptIeu+CthefuC0PqSLRteJU6DxkG38wZKIVd3Sc?=
 =?us-ascii?Q?ShhnpVJQH2y2D/ZARVRHaSqrQMJR5cNMsb+x8QTNJ2o1w0vjkXX44yqgM/U5?=
 =?us-ascii?Q?xjsuyC4WmD2A7KuDaqyJT4RE0q4vnJSnDnneA8WACnd07/eTPVLK4R9yka4G?=
 =?us-ascii?Q?oF8OZu3Sdv32tryGBqcKcAuVykkdBzYD0eeT5muDyE/bo/fJY7bLunDFXewl?=
 =?us-ascii?Q?Ujxy232i7gZdGQEV1kqoEpM5SbfgG/nzc27TZ+XenZDfUkv+u2QoRXnm/I2k?=
 =?us-ascii?Q?IH6EJMEhhtjlWtG5thyXoIg/6dnUEr2UX5wO6bzuDyqt6KEaQut6NaAaqjZ7?=
 =?us-ascii?Q?BvhQJBUt3uSSyuMJKnyuEKERTKYnfBlkSgEK56BB+NDNTMfk0C9CNdiP7o39?=
 =?us-ascii?Q?Rs/KDGKo/TzSdO/zdhQNm5gAOx5C1URsulyebpsOolFrASFn3oSt6ubuOXtz?=
 =?us-ascii?Q?MzYJ96BYks/VZwlLThTNEjzt/fgFXXfnw75wIMeJm1LPnHsbt9wGQN0kRwBn?=
 =?us-ascii?Q?THhFCIsKwbx1/jo89RgS1EnhWBxGdEi/Uokld3pq3IUAEGHLlJDGqfoSATmO?=
 =?us-ascii?Q?bjgj2NOmOUNCzZkvMnKnp/Q0riToVn1d04sLOJlKCpqhuirv0J7TjflchDXC?=
 =?us-ascii?Q?XZE/9CyqNWL7UindwpuT3rJNTVjlVy1vB/gwyv2dQmE8niMPJJvEJGxOfXcH?=
 =?us-ascii?Q?kNFCoUcx8e7FE63/WkV7gAnLOc+HAtRb5WObAh4HtZpf7StB/coMZxvCQh3o?=
 =?us-ascii?Q?ogdhmQAVyWdDrF+hRwEKvjwGECwbjWNTp5yfVZIWeKV322Sg22d6G24pqTNM?=
 =?us-ascii?Q?lAPZEr6wXt6fzeb84oQ65KhuEFlcZb+KXAyMFRozYGiZ46nLddhQMbQbs+WZ?=
 =?us-ascii?Q?8ZKg7gCXyRPE701UU9d4vGZamXwIj0ejU2Awzn7+aVfjGLN5qXD/LeV1+soT?=
 =?us-ascii?Q?cNu0/HmCMaBFbeXsDZljLzHC4bbAXey1x2vsumbskgnoiH14ycL43iqK39lS?=
 =?us-ascii?Q?gEOy7031UdAh5xnnhA8B9N3AHkFBFXyAh/sxC3LkOJwHZb7om8fiQZP7Nvd9?=
 =?us-ascii?Q?5sKxsjDY26WflTZsFASHUvpiTtjW+wkmQ7AeeLbSNFU73z4Tv6T7Apa8/4I3?=
 =?us-ascii?Q?x1OAdVyFdRZtFToh7bcGhvyfs8p4Eiindfq1v3NOigeL8pUHc5mcm1oywjW2?=
 =?us-ascii?Q?9/+kssytyI+8lFe8w9WowMcRXlTEQu54SHm5RDDSXLRymKEhGhaYWdl7pbSy?=
 =?us-ascii?Q?pMJ0ZRBJzmzx13alMCtVJfqcqj0yJ2Zbaw9hbOJNwOKNCjriwHpGjIFIwPsD?=
 =?us-ascii?Q?8aMCAUP/ijAsOO1mHS8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f96ce3-b218-43ee-abc1-08db2961ba63
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:39:52.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1iXnwv0VGmODT/6D3YvSBfZo4hLUDGOZQXoaD9/pyFnttlljifflIXFcw8PKZ4e
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

Use generic data structure to describe pin control functions and groups in
S32 SoC family and drop duplicated struct members.

Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v2:
- Simply use generic 'struct pinfunction' rather than having extra 'struct
  s32_pmx_func'.

 drivers/pinctrl/nxp/pinctrl-s32.h   | 26 ++--------
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 76 +++++++++++++++--------------
 2 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 545bf16b988d..2f7aecd462e4 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -15,31 +15,15 @@ struct platform_device;
 
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
 
-/**
- * struct s32_pmx_func - describes S32 pinmux functions
- * @name: the name of this specific function
- * @groups: corresponding pin groups
- * @num_groups: the number of groups
- */
-struct s32_pmx_func {
-	const char *name;
-	const char **groups;
-	unsigned int num_groups;
-};
-
 /**
  * struct s32_pin_range - pin ID range for each memory region.
  * @start: start pin ID
@@ -56,7 +40,7 @@ struct s32_pinctrl_soc_info {
 	unsigned int npins;
 	struct s32_pin_group *groups;
 	unsigned int ngroups;
-	struct s32_pmx_func *functions;
+	struct pinfunction *functions;
 	unsigned int nfunctions;
 	unsigned int grp_index;
 	const struct s32_pin_range *mem_pin_ranges;
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index cb8a0844c0fa..4ed0cc905232 100644
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
@@ -364,7 +364,7 @@ static int s32_pmx_get_groups(struct pinctrl_dev *pctldev,
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
 	*groups = info->functions[selector].groups;
-	*num_groups = info->functions[selector].num_groups;
+	*num_groups = info->functions[selector].ngroups;
 
 	return 0;
 }
@@ -602,8 +602,8 @@ static int s32_pconf_group_set(struct pinctrl_dev *pctldev, unsigned int selecto
 	int i, ret;
 
 	grp = &info->groups[selector];
-	for (i = 0; i < grp->npins; i++) {
-		ret = s32_pinconf_mscr_update(pctldev, grp->pin_ids[i],
+	for (i = 0; i < grp->data.npins; i++) {
+		ret = s32_pinconf_mscr_update(pctldev, grp->data.pins[i],
 					      configs, num_configs);
 		if (ret)
 			return ret;
@@ -637,9 +637,9 @@ static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 
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
@@ -732,6 +732,7 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
 	const __be32 *p;
 	struct device *dev;
 	struct property *prop;
+	unsigned int *pins, *sss;
 	int i, npins;
 	u32 pinmux;
 
@@ -740,38 +741,38 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
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
 
@@ -780,8 +781,9 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 					u32 index)
 {
 	struct device_node *child;
-	struct s32_pmx_func *func;
+	struct pinfunction *func;
 	struct s32_pin_group *grp;
+	char **groups;
 	u32 i = 0;
 	int ret = 0;
 
@@ -791,18 +793,18 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 
 	/* Initialise function */
 	func->name = np->name;
-	func->num_groups = of_get_child_count(np);
-	if (func->num_groups == 0) {
+	func->ngroups = of_get_child_count(np);
+	if (func->ngroups == 0) {
 		dev_err(info->dev, "no groups defined in %pOF\n", np);
 		return -EINVAL;
 	}
-	func->groups = devm_kcalloc(info->dev, func->num_groups,
-				    sizeof(*func->groups), GFP_KERNEL);
-	if (!func->groups)
+	groups = devm_kcalloc(info->dev, func->ngroups,
+			      sizeof(*func->groups), GFP_KERNEL);
+	if (!groups)
 		return -ENOMEM;
 
 	for_each_child_of_node(np, child) {
-		func->groups[i] = child->name;
+		groups[i] = (char *)child->name;
 		grp = &info->groups[info->grp_index++];
 		ret = s32_pinctrl_parse_groups(child, grp, info);
 		if (ret)
@@ -810,6 +812,8 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 		i++;
 	}
 
+	func->groups = (const char **)groups;
+
 	return 0;
 }
 
-- 
2.37.3

