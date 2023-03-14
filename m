Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A66B96D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjCNNu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjCNNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:50:37 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF860A76A4;
        Tue, 14 Mar 2023 06:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV3p5P/OO7lG/AntuNPiSbORA5D31GM+QvJguwvL4Xkta4EYnRu47XaLOPGZ29RBdsiZQcKbJDDtranMBITX4YJo9YpSx4C4Of9EDFD2IBO8/Rf9WaALF6C+BMXiOnIhUYVSYnuDhbh5pk8DLSxZ452WsORLjRwtgaHELfmDJbMGrv2Lbp/g4WVY3aJ3Dtv0o8jKRtBzNYf21uN1ZTtMXnwEDhS4h5GFNMSciQHtYqHQnbDdMHDksbwsKj32VpoY1OBK50kY/hiVpsRWhvXo3EZidIrgn4kbgVND3hnMCNojewmUBeWRc4AtTaEf+PH/d+jcEnQpO1oRFDduK6OqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSYhHwEHCj4GgUa37gwyrn0krmirMvAhFzjeijjhJcM=;
 b=OULt/lWi53OZTbKE3m+PlEQplfBiLRfLjjG92KLwnjfJy1mVme3TKv93FYT4Mt1E/1DLzzX6TU72eIjeD++H2qvY5fYsQRJEbiqXCltqceoaAAowuOPQpcnt9NvRY1Iw7CWoPZzDZvpMATSo2cgmO0vVuheG2fHW6I2j3P+xgkXujJ8exJcZjA/xhfB8mdwKhPfWxFw4VwR4tz0PoNGNqNtnOLqHy2QnhtNArqmkZqLYz6Pi8d8+fiv1HQt5ntW+APnb8ZvO1VYZ4O1b3ZWYHdDBsZ08Glvk8LFVUjKJ8EJpu/VntOh0w1dA6LtI9BokHpWZp0yC3/Huae7QBw6oLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSYhHwEHCj4GgUa37gwyrn0krmirMvAhFzjeijjhJcM=;
 b=tMeR7+T6dIw1ZI+ZgXHRWnf5T67StBNG0yWhkAlKYbf520CIYx/tnUb4apn1zvqBvDxznZjW0UXwJ8TZ3xXeubhS2JwjUKhfugKwBUeQrw7AGwWxBM4Q4+fzJ3UBr3caL/7daO+8xOuCJ7chIuIRTIeR42SK+1e9lfZSn8W2ifo/U/U/ASQDDhTmmOzywP6p3bWeMaNeGwEleoZa2D9iSK66lIV0rFlmTvrygWDzFU3KQ0O+DyX1QcLlxDG8Rrq5yFx/YMsp/FQNLGZ+Iwtc+QLxctBw3iRsd2vbGD4LY9kh3jXwdddHxgW2OeH1UgxqUwiyd2ykXV/BEvQl5U2o6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25) by AS5PR04MB9895.eurprd04.prod.outlook.com
 (2603:10a6:20b:651::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 13:47:08 +0000
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::2b1f:7e5:94d0:3ba9]) by AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::2b1f:7e5:94d0:3ba9%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 13:47:08 +0000
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
Subject: [PATCH 3/3] pinctrl: s32cc: embed generic struct pingroup and pinfunction
Date:   Tue, 14 Mar 2023 21:46:42 +0800
Message-Id: <20230314134642.21535-4-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230314134642.21535-1-clin@suse.com>
References: <20230314134642.21535-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3428:EE_|AS5PR04MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbdc19d-9a3d-45a8-0069-08db24929acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PdMiN577keC9xW6epd+PM3OIy8oc8EF5ueM3gzg2Qhicll95wvjAfIpz+5M8LY6qnTmnADzqVTNPlPpMdLpJBIMr84UAQ4g1Ah2Q9ulQuljlgMS+/w+TQeO3G4HbBiAHMYci4N763X8tQoC5ia1bX0/6g+Ds1iv04hkVcAfTh4Fl7unbnbZE9FEJffAvXmFZvP1Y4OA5dtFLjHzPnG5k+iGBLPHf/1H0Zm+Kcx5LjYsfGqzeMl1Zo7jO5SJw6TapVTGW7pZpvBAtjsQ86FOcjOFoqnTT/mFmsoMoYXXbS/pzRWlzfj2Kr6mhj9Ekpb9Rq6IKZH3oeC1R96QKCyRXWP5r6vXyI0MFEwZQMY1PyqQzeqLT9bOZhzq0RB2moz1gnZ7YFJrl3VU1/jWuzbLF1XxXjEYX037q/ToOwQ1G8QSzCCGX3tGOECO9WEjxrfG11gSz+1cv9E7ryVSG4+gW/3gAIdodBbCMEGkgKv4UEiXANo8xdId+m98D2WnXi56L+K2JuSJaveaf7bQETPjTNGtRi8FiBU4GkV9tM0VBMom6JiuChBAwJKwi997b/C+DXUNbBZ/emqLfaxjIDfALFBdh1PqMzNM0FE09uY0Fe/CNTU+SlbDoW1cnsrgGursmjOnP6reSSCQoZHGLs/IbMLpKcBpvWe4tnFZXLwAMuWm3xzAiYA6oYf07a/E+Blm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(8936002)(36756003)(54906003)(478600001)(110136005)(316002)(66476007)(8676002)(66946007)(4326008)(66556008)(7416002)(41300700001)(2906002)(5660300002)(86362001)(6486002)(6512007)(6506007)(1076003)(26005)(6666004)(107886003)(186003)(2616005)(38100700002)(83380400001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KADydvRg47cLt+SK/D2BiotqvWVFjSizOqI3ivk7ZLwDV1K21GzhMMovNcRb?=
 =?us-ascii?Q?z5uka4nE1g3f6cXqwFlUF8V5PfkvHVVP6U26Eem2DE2z8mk6JBihNdaIA0RN?=
 =?us-ascii?Q?Pfg/BErv1ASmJ3WKMwGcD+JmkxaTYRufxPrYmHCL39UXBghqvQiOFsupINDP?=
 =?us-ascii?Q?XiS+xHXHlbi3BFKN9ZcGG3DLdszog2A3/RoSbcAhgDWPeWe2WRdy221UjIoG?=
 =?us-ascii?Q?B75GbddlX4Bj0XgC+sb8nU55mkRdLBT1FGmi/SHQAomLS2nBuLHjMaXx2gWG?=
 =?us-ascii?Q?N0XMXV6mCJuPtnRQimolWuSrSSHLfs1NaTdhL3H/1CaJlpTxEiuKF8/FzfDJ?=
 =?us-ascii?Q?fy42hCssucNeV+Lsw28ir33mKJbsi0Mjkl7cmMHJcPors+ReQig3Z/ur8At2?=
 =?us-ascii?Q?DbL+GNEgi/4CVozXgdG3kzzmKDpC+YJwKSkbNAlASUdHrbxk5mcUTE+7UieP?=
 =?us-ascii?Q?tJR/OnqtiI6PhnSLxAIlwxVU/9+y5Ht0xHlKvHZ6uwVsdD61msbg89+Pzi1k?=
 =?us-ascii?Q?n6vkcrx5HuK6eNauUu5BK/VrXt2rRbJRZCBwq+m/KLqQ/GnZ+Jca/p66c4N2?=
 =?us-ascii?Q?1zwhUIk5dRa40fWa9qL66efqaHrxdY5q16ILZT5SDjThhD1bafrmETTgZ6Ii?=
 =?us-ascii?Q?+6z79gl6JrXwMCAQSdHlU81Bk0x9hXSEn16RCL9h8Xh71xJJxj3X9Vm60qEw?=
 =?us-ascii?Q?kpiADgTAFJgbvOvyZKNLNAee/TMIR311dMWMR/KdobQ0lzgkNAay8SH4X04O?=
 =?us-ascii?Q?bFXLK+x+2qHj9lmPgaYSePSrg2u/+MSJ6mj5ErvQNjV9vK2fR4LsWH7xowtq?=
 =?us-ascii?Q?yRJJQj+hjmZ1vea0FSxNzlrLAWfC1VR3HW1HgOitJkQ24efEvbyXufEEd9RT?=
 =?us-ascii?Q?v8MuxdMLJana4z7yb2cyJfUjex6DhKI+yNHiLw/0jImeJvApw8c19sxHjaVu?=
 =?us-ascii?Q?/R7du0VijXqnseMvmGQyRxhpWhoShMxQYHE6G0m+dq1EYuUsx8HhCq5n1wOr?=
 =?us-ascii?Q?pS2XzAh6EKvBYcY4s5rk7685Pof6lh30Ee5zbxgt4LF7owVJaYrvIsYfui9p?=
 =?us-ascii?Q?ehGHsyhIDIQekv4FZCFGItLybKHXnSmerKlnTD9tok0wM2AvCvLFYOe26HE4?=
 =?us-ascii?Q?3ZHJVvHNpFUFd9j1SU0b0+gSb+TJ8vAAqnpWWxV2Gkre9ocmrdGvVm6B2wlh?=
 =?us-ascii?Q?o4rSBlloyEmW5X+pJ9AxPmB+8lY9aFsCcEf/t9Se4MOkt26WS6tbm7BncCJd?=
 =?us-ascii?Q?d+X6wpIMKIFR1Sn3jJV2QFBAtTMQJgDLyUzLORY79bxm0/bwNoSAv2OB7sqq?=
 =?us-ascii?Q?7UKLY5UJMxxHY6URfwMSq/fxImM/1wuiwui+tpvwVhPsPK7Q3WpzsDCkBQZv?=
 =?us-ascii?Q?aIqA08f3uN++Hij3LFZ0tsDQXCzJdObQyqZRvG+avGMgZzR3QjkvFtPl25i3?=
 =?us-ascii?Q?zLlNazPr1VnpBY3G4fzux0kSNx8IxVK+XIo2+za68ipxHlCSyIitNY+nZGpM?=
 =?us-ascii?Q?2XNJH7vA8eTLViY8PKuhqS5ns+Xt4rlHXHnujRDgH4IzAtNEHEVRfUfDKTLP?=
 =?us-ascii?Q?qgRJTIvEL48Ja8+OG4k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbdc19d-9a3d-45a8-0069-08db24929acc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 13:47:08.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBGdgA8JzEHD/PmGqHj3GBoG9qUUKmgGj72b8C7N7VtBaJJYWtn7S8v+jTJqJ2jN
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

Use generic data structure to describe pin control functions and groups in
S32 SoC family and drop duplicated struct members.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/pinctrl/nxp/pinctrl-s32.h   | 22 +++-----
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 78 ++++++++++++++++-------------
 2 files changed, 49 insertions(+), 51 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 545bf16b988d..1a0aa1995908 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -15,29 +15,21 @@ struct platform_device;
 
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
 
 /**
- * struct s32_pmx_func - describes S32 pinmux functions
- * @name: the name of this specific function
- * @groups: corresponding pin groups
- * @num_groups: the number of groups
+ * struct s32_pmx_func - describes an S32 pinmux function
+ * @data: generic data to describe function name and associated groups.
  */
 struct s32_pmx_func {
-	const char *name;
-	const char **groups;
-	unsigned int num_groups;
+	struct pinfunction data;
 };
 
 /**
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 9508fc1e9a90..76442c1bc7be 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -191,7 +191,7 @@ static const char *s32_get_group_name(struct pinctrl_dev *pctldev,
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
-	return info->groups[selector].name;
+	return info->groups[selector].data.name;
 }
 
 static int s32_get_group_pins(struct pinctrl_dev *pctldev,
@@ -201,8 +201,8 @@ static int s32_get_group_pins(struct pinctrl_dev *pctldev,
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
-	*pins = info->groups[selector].pin_ids;
-	*npins = info->groups[selector].npins;
+	*pins = info->groups[selector].data.pins;
+	*npins = info->groups[selector].data.npins;
 
 	return 0;
 }
@@ -317,23 +317,23 @@ static int s32_pmx_set(struct pinctrl_dev *pctldev, unsigned int selector,
 	grp = &info->groups[group];
 
 	dev_dbg(ipctl->dev, "set mux for function %s group %s\n",
-		info->functions[selector].name, grp->name);
+		info->functions[selector].data.name, grp->data.name);
 
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
@@ -355,7 +355,7 @@ static const char *s32_pmx_get_func_name(struct pinctrl_dev *pctldev,
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
-	return info->functions[selector].name;
+	return info->functions[selector].data.name;
 }
 
 static int s32_pmx_get_groups(struct pinctrl_dev *pctldev,
@@ -366,8 +366,8 @@ static int s32_pmx_get_groups(struct pinctrl_dev *pctldev,
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
-	*groups = info->functions[selector].groups;
-	*num_groups = info->functions[selector].num_groups;
+	*groups = info->functions[selector].data.groups;
+	*num_groups = info->functions[selector].data.ngroups;
 
 	return 0;
 }
@@ -611,8 +611,8 @@ static int s32_pconf_group_set(struct pinctrl_dev *pctldev, unsigned int selecto
 	int i, ret;
 
 	grp = &info->groups[selector];
-	for (i = 0; i < grp->npins; i++) {
-		ret = s32_pinconf_mscr_update(pctldev, grp->pin_ids[i],
+	for (i = 0; i < grp->data.npins; i++) {
+		ret = s32_pinconf_mscr_update(pctldev, grp->data.pins[i],
 					      configs, num_configs);
 		if (ret)
 			return ret;
@@ -646,9 +646,9 @@ static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 
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
@@ -741,6 +741,7 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
 	const __be32 *p;
 	struct device *dev;
 	struct property *prop;
+	unsigned int *pins, *sss;
 	int i, npins;
 	u32 pinmux;
 
@@ -749,38 +750,40 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
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
+	pins = devm_kcalloc(info->dev, grp->data.npins,
 				    sizeof(unsigned int), GFP_KERNEL);
-	grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
+	sss = devm_kcalloc(info->dev, grp->data.npins,
 				    sizeof(unsigned int), GFP_KERNEL);
-	if (!grp->pin_ids || !grp->pin_sss)
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
 
@@ -791,6 +794,7 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 	struct device_node *child;
 	struct s32_pmx_func *func;
 	struct s32_pin_group *grp;
+	char **groups;
 	u32 i = 0;
 	int ret = 0;
 
@@ -799,19 +803,19 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 	func = &info->functions[index];
 
 	/* Initialise function */
-	func->name = np->name;
-	func->num_groups = of_get_child_count(np);
-	if (func->num_groups == 0) {
+	func->data.name = np->name;
+	func->data.ngroups = of_get_child_count(np);
+	if (func->data.ngroups == 0) {
 		dev_err(info->dev, "no groups defined in %pOF\n", np);
 		return -EINVAL;
 	}
-	func->groups = devm_kcalloc(info->dev, func->num_groups,
-				    sizeof(char *), GFP_KERNEL);
-	if (!func->groups)
+	groups = devm_kcalloc(info->dev, func->data.ngroups,
+			      sizeof(char *), GFP_KERNEL);
+	if (!groups)
 		return -ENOMEM;
 
 	for_each_child_of_node(np, child) {
-		func->groups[i] = child->name;
+		groups[i] = (char *)child->name;
 		grp = &info->groups[info->grp_index++];
 		ret = s32_pinctrl_parse_groups(child, grp, info);
 		if (ret)
@@ -819,6 +823,8 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 		i++;
 	}
 
+	func->data.groups = (const char **)groups;
+
 	return 0;
 }
 
-- 
2.37.3

