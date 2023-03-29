Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD96CD11E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjC2EQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjC2EQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:16:42 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868889D;
        Tue, 28 Mar 2023 21:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGMy63Yf43g8BKxAaCDg0lk3LrXXXuqGrhX9T19IVsXlMVYU6Leu6NevOVy7kvwMtdNdv2OVrrmrSo6WRb0LInFuM7BgKXrCKVsZvg+FFXTKZjRxft61Rzbvd7arq89Oel9tRjbAz/A3cazay2ROcE9SeIwHneAFu+DIzTQHlIfwtkV/TFqW5J1TSEmXkyVIcevzy6VcBPhNt/K1Ly6jR31wv/5b+FLcefIuUcsoMN7O3bQF6iIyMjsx13w/Wzzsc1iY4Ef5R6CTswL9jHMCYP2z8zvKgTHGkYco0omtbF8YRSrZ5vETb5FP5gj06jVrU7mdv8IjO/6mRrUmjyM2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY271GVdjDTVu0xzUg7/MJelKT6l3q4vXCNO9R/VMJo=;
 b=hNJuuP8c/ezqFmxkzduS4gBIDEDR/4gGdZ42X61wJo6RzgtuZq+Fjti4m6d5dMuNPSyGRp3qxiW10ItvXu6uL39KIPtJAa1QppNqdjTO1EapK8dsU0CY7+b8RgDr4AufG9UzA5V8pLjBG8Ug0PNQImZxIB9NeVa9eRp/DJlBV2smY5hLwLNnK5QPvnhk/WW4QmWZzMS9Ns34UcvKznT1rnOUU8ZbzxrbApGcyhIOry2Mu6D47T91Dq/w1jqyfWbfwSWejJUKcYdeBkFEtLCsgCshvBClS9NAiZKlfAmbfXypM1Quk0FiGVcJ8Im8qVm1J6XeK4ZDdx81uJ1VH2s+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY271GVdjDTVu0xzUg7/MJelKT6l3q4vXCNO9R/VMJo=;
 b=iLmPe5ma/gIITgLz3FNyrTWN93Akk4b6CeAwukswJym7YeDxkWIcqPXq2ITk9gwH2klqmYkCN2slEkarCP6J8CcI7Xa6MMc4xk3rQ2DmHOdz1zwd6LSz8RZXdFokBCw2GvDJsKeTmv6HdWXRKN7sBNfod+IW2nifx9WJLzkDlE7B7cbUwH7MRfHF71iaPZV54T+tq0wkrOX5QHiREBqZmNrihblB80wkeTk4yhJJJvaNJW9xhtgA8qdspYKsCbWRb1tA0HqUh0VITPCh8KEknb+erz/+mp7+KOkOwDlkkQ14bgJk5/72joqrK8kKEv5c22Sws8QnXWGUGFcC2osHyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 04:16:36 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 04:16:36 +0000
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
Subject: [RESEND PATCH v5 5/5] pinctrl: s32: separate const device data from struct s32_pinctrl_soc_info
Date:   Wed, 29 Mar 2023 12:16:30 +0800
Message-Id: <20230329041630.8011-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230327062754.3326-1-clin@suse.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d720582-d8fc-45e0-ff07-08db300c62f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAShNmYCXQjSbK2x6Lke3MMF+a7DSF2PSyiWADCQ2JEfwcbRMWj90lUvOTQihPyiMyTsfkWQ1GKwAvSJK/gVeOw6XyGlScX96AV67sPNG9r3Ws34k0XyZ578Xcbvdr2oEkki97RqdWLPMP8/7X5PyaQKUe4LDxSo34ueplNJqLfCHkZXdW6Uf87uZzaMApQkRTD79LLydQVMAbRkb7kFKcs7+krAk6JCjEHcF1Yl+dmNUa5tXJYyoc0Bmk8bFUu/PJYfwj/WKnFd6unfY7DH2OthOwKgrWJNpGTJz1a0AgtMzw71esb3iJbsrnxyVv5GmfZYP+dYtk4pucU6cop1sYyUAArrLNOGtgzt7iGU5ymwQQXoIZcTFLLbQ0UCav0LaQHS5s4O+DkaQiOJ/BRW/jZC9VEYZUW0z82TteyCV8eul6ux1kHY8+/z5nxKecIev2VA4+nnSlU4BodZkVVAOMBCNXk2GVyNQgxpb03ZO89U4Yt8z+pgi/ufE7J1oY3rxvBql2ynDV3chrJ25YU0I7cpjQ2u3xo7nipe9DW2rcoKVGZcYhYuPHzFmqWjBMIO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(376002)(396003)(136003)(346002)(451199021)(83380400001)(107886003)(6666004)(86362001)(110136005)(316002)(54906003)(26005)(186003)(6512007)(41300700001)(6506007)(1076003)(2616005)(6486002)(8676002)(8936002)(38100700002)(36756003)(478600001)(66556008)(4326008)(7416002)(5660300002)(66476007)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BAkp8QRo+fFCxjHPCBvalsu1izElYV2zpCN5ZLT3+IYCby+0nHWhEur48g2C?=
 =?us-ascii?Q?/MUjuoqL7+5ih19986KrEVBIrPMTk101JsA9rjrH1nQgJO25vhWO81/mP6R8?=
 =?us-ascii?Q?n6v/qkwj2MlaHAuqA1Iku3EmseYPQLh5OaiPTHrod8XK4Y1/K9PDpBnKCEhh?=
 =?us-ascii?Q?NaaJ1aB6grhloPX0mMQTpsGB2Gkz5b9JQg4ujEHabpxEo1f6TPmrpKYAJG+P?=
 =?us-ascii?Q?UvN+ygWas22Pe4Y3q84tsL+91IH+l9Tdko77b6ox2hGAKw3DycIWZ54EvrUX?=
 =?us-ascii?Q?X26edHO5Lzq3gcpJPQgebEoa6rM0m0uKy0gn7GVe8Hkfr/aWubwAAwclAG8b?=
 =?us-ascii?Q?BW7F8NqCArRdP3QJguRyUueK1LWkcrmJjkoqcImSS+LUB3dQMTr1vU2Xi3rx?=
 =?us-ascii?Q?vPIv5IVS/j2EQyqRWDClICW1I3bUz1CkA0Wt85BLRSsuvLNGzt2pR7yKaEWs?=
 =?us-ascii?Q?FPag1QuJ0tDDnAsgYsUQS/A52n/Df8jLtBL0ccQCvjl12NZUA5fScXJOk2m9?=
 =?us-ascii?Q?JaaX8n92tBQZT9i+1F+G7ktr9WnnTd6a8fFrXBbAgbtUOSlaS+jsaRo0WrM3?=
 =?us-ascii?Q?Avg9g5NttTCh/7U6J4NGMG+x24ahN0/1jbPd5qYH3O8kfuijnQKLrnV3eL1V?=
 =?us-ascii?Q?Q3vJfCXbykXuBsngUwsImXAX5Gtfc4q6hLLijcCdHbj/im+K0j8WMaJn1pgz?=
 =?us-ascii?Q?u5PMQGu3zhOn/0wT//Yb29JmwXfWooD0wQM8sZRI53STT1wNWG1jBgT0jDj0?=
 =?us-ascii?Q?FJnZ4qxkUvgL3bCl78YKBXIP1l9FIzgQvKJdI+vS8RPOa1ZI3oO6yJauRjQl?=
 =?us-ascii?Q?no3AeD1wiAnf8EUehBw7bAM4Ubzsep7BZpliRb/f9ElTQlYoW8QNaR+B9III?=
 =?us-ascii?Q?Y2nVVxyqqfOsypuzJ/IeadJxIa2Ex92iCNXIFYxmS36YtY+GkLYzqjVFWTem?=
 =?us-ascii?Q?cWASllT1JIbEMxgOnL7R86C9wQ18m2RgFiI8ibl962kjKIv0KrUUPBCI+M3C?=
 =?us-ascii?Q?NCpMvYAFGPopRjZhHy1NCGcyYaBdYdfv1nPOIjW+XqFDh5mEXH2kWvilA6gI?=
 =?us-ascii?Q?EDUmKLPESlvzXUkHBX1MrvxroFJLLbDryp7nzVEBLcBeMmgiM5cHh/8MbkLk?=
 =?us-ascii?Q?ZSS1/9AnjD6aPUvI085LER0gL3DsH1VGLihxEkECtmL4ntum3c7Zbsak8fMk?=
 =?us-ascii?Q?BLpwu9AKwxJYJ/6IOe78Tl62yGnnKiDIHq/ubZlSoFNDIZfYCzelG1NkmzDK?=
 =?us-ascii?Q?M7VGjMIstOmVpnXGAkHoq0IEQjiS3FZDymRm2jc5NAjNvQ1Bv7Sqzfh/wtPD?=
 =?us-ascii?Q?X9Nlltk1bSOvaeU9ziSJ65FrvI89wGfZY0xF+iaPuP7q4HGG9m0FkPnhSD6a?=
 =?us-ascii?Q?hJ7ecgMIu/wj+UoqyEasU0f5tRBqUjT0XqMzpNgfElcoHmWgKAzjikWF0QV2?=
 =?us-ascii?Q?r0cT7XuDT+QlKO+Dxd9YmUmFpYtWbDvcq+UAeBuIJ80ap3BOwseCdMbcXPN4?=
 =?us-ascii?Q?Okck6MzUrfRXukNjODt+bwRLtEExyLSrnqP5LUp6hYxdPTnJSzli+5S1XV7U?=
 =?us-ascii?Q?VhaPuPiIb3TX6kA9Tjo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d720582-d8fc-45e0-ff07-08db300c62f4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 04:16:36.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmdmHWnmpMXCSXEpoSZ6X3eqx2dSAGP5QnY0bz1gDtvcUvxuc85PTtLIzHWbY6WJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .data field in struct of_device_id is used as a const member so it's
inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
because some members in s32_pinctrl_soc_info need to be filled by
pinctrl-s32cc at runtime.

For this reason, struct s32_pinctrl_soc_info must be allocated in
pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
to represent const .data in of_device_id. To combine these two structures,
a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.

Besides, use of_device_get_match_data() instead of of_match_device() since
the driver only needs to retrieve the .data from of_device_id.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
(This is a patch revised from the previous [PATCH v5 5/5], Message-ID:
 <20230327062754.3326-6-clin@suse.com>)

Changes in v5:
- Remove unnecessary (void *) type casting found in pinctrl-s32g2.
- [NEW] Add the const qualifier on the s32_pinctrl_data.

 drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +++++++++-----
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 30 +++++++++++++++++------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c | 14 +++++---------
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 2f7aecd462e4..add3c77ddfed 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -34,24 +34,28 @@ struct s32_pin_range {
 	unsigned int end;
 };
 
-struct s32_pinctrl_soc_info {
-	struct device *dev;
+struct s32_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
 	unsigned int npins;
+	const struct s32_pin_range *mem_pin_ranges;
+	unsigned int mem_regions;
+};
+
+struct s32_pinctrl_soc_info {
+	struct device *dev;
+	const struct s32_pinctrl_soc_data *soc_data;
 	struct s32_pin_group *groups;
 	unsigned int ngroups;
 	struct pinfunction *functions;
 	unsigned int nfunctions;
 	unsigned int grp_index;
-	const struct s32_pin_range *mem_pin_ranges;
-	unsigned int mem_regions;
 };
 
 #define S32_PINCTRL_PIN(pin)	PINCTRL_PIN(pin, #pin)
 #define S32_PIN_RANGE(_start, _end) { .start = _start, .end = _end }
 
 int s32_pinctrl_probe(struct platform_device *pdev,
-			struct s32_pinctrl_soc_info *info);
+		      const struct s32_pinctrl_soc_data *soc_data);
 int s32_pinctrl_resume(struct device *dev);
 int s32_pinctrl_suspend(struct device *dev);
 #endif /* __DRIVERS_PINCTRL_S32_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 8373468719b6..41e024160f36 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -106,7 +106,7 @@ s32_get_region(struct pinctrl_dev *pctldev, unsigned int pin)
 {
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pin_range *pin_range;
-	unsigned int mem_regions = ipctl->info->mem_regions;
+	unsigned int mem_regions = ipctl->info->soc_data->mem_regions;
 	unsigned int i;
 
 	for (i = 0; i < mem_regions; i++) {
@@ -688,8 +688,8 @@ int s32_pinctrl_suspend(struct device *dev)
 	int ret;
 	unsigned int config;
 
-	for (i = 0; i < info->npins; i++) {
-		pin = &info->pins[i];
+	for (i = 0; i < info->soc_data->npins; i++) {
+		pin = &info->soc_data->pins[i];
 
 		if (!s32_pinctrl_should_save(ipctl, pin->number))
 			continue;
@@ -713,8 +713,8 @@ int s32_pinctrl_resume(struct device *dev)
 	struct s32_pinctrl_context *saved_context = &ipctl->saved_context;
 	int ret, i;
 
-	for (i = 0; i < info->npins; i++) {
-		pin = &info->pins[i];
+	for (i = 0; i < info->soc_data->npins; i++) {
+		pin = &info->soc_data->pins[i];
 
 		if (!s32_pinctrl_should_save(ipctl, pin->number))
 			continue;
@@ -831,7 +831,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	struct resource *res;
 	struct regmap *map;
 	void __iomem *base;
-	int mem_regions = info->mem_regions;
+	unsigned int mem_regions = info->soc_data->mem_regions;
 	int ret;
 	u32 nfuncs = 0;
 	u32 i = 0;
@@ -869,7 +869,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 		}
 
 		ipctl->regions[i].map = map;
-		ipctl->regions[i].pin_range = &info->mem_pin_ranges[i];
+		ipctl->regions[i].pin_range = &info->soc_data->mem_pin_ranges[i];
 	}
 
 	nfuncs = of_get_child_count(np);
@@ -904,20 +904,26 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 }
 
 int s32_pinctrl_probe(struct platform_device *pdev,
-		      struct s32_pinctrl_soc_info *info)
+		      const struct s32_pinctrl_soc_data *soc_data)
 {
 	struct s32_pinctrl *ipctl;
 	int ret;
 	struct pinctrl_desc *s32_pinctrl_desc;
+	struct s32_pinctrl_soc_info *info;
 #ifdef CONFIG_PM_SLEEP
 	struct s32_pinctrl_context *saved_context;
 #endif
 
-	if (!info || !info->pins || !info->npins) {
+	if (!soc_data || !soc_data->pins || !soc_data->npins) {
 		dev_err(&pdev->dev, "wrong pinctrl info\n");
 		return -EINVAL;
 	}
 
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->soc_data = soc_data;
 	info->dev = &pdev->dev;
 
 	/* Create state holders etc for this driver */
@@ -938,8 +944,8 @@ int s32_pinctrl_probe(struct platform_device *pdev,
 		return -ENOMEM;
 
 	s32_pinctrl_desc->name = dev_name(&pdev->dev);
-	s32_pinctrl_desc->pins = info->pins;
-	s32_pinctrl_desc->npins = info->npins;
+	s32_pinctrl_desc->pins = info->soc_data->pins;
+	s32_pinctrl_desc->npins = info->soc_data->npins;
 	s32_pinctrl_desc->pctlops = &s32_pctrl_ops;
 	s32_pinctrl_desc->pmxops = &s32_pmx_ops;
 	s32_pinctrl_desc->confops = &s32_pinconf_ops;
@@ -960,7 +966,7 @@ int s32_pinctrl_probe(struct platform_device *pdev,
 #ifdef CONFIG_PM_SLEEP
 	saved_context = &ipctl->saved_context;
 	saved_context->pads =
-		devm_kcalloc(&pdev->dev, info->npins,
+		devm_kcalloc(&pdev->dev, info->soc_data->npins,
 			     sizeof(*saved_context->pads),
 			     GFP_KERNEL);
 	if (!saved_context->pads)
diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index d9f3ff6794ea..224a12ce70ed 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -721,7 +721,7 @@ static const struct s32_pin_range s32_pin_ranges_siul2[] = {
 	S32_PIN_RANGE(942, 1007),
 };
 
-static struct s32_pinctrl_soc_info s32_pinctrl_info = {
+static const struct s32_pinctrl_soc_data s32_pinctrl_data = {
 	.pins = s32_pinctrl_pads_siul2,
 	.npins = ARRAY_SIZE(s32_pinctrl_pads_siul2),
 	.mem_pin_ranges = s32_pin_ranges_siul2,
@@ -730,9 +730,8 @@ static struct s32_pinctrl_soc_info s32_pinctrl_info = {
 
 static const struct of_device_id s32_pinctrl_of_match[] = {
 	{
-
 		.compatible = "nxp,s32g2-siul2-pinctrl",
-		.data = (void *) &s32_pinctrl_info,
+		.data = &s32_pinctrl_data,
 	},
 	{ /* sentinel */ }
 };
@@ -740,14 +739,11 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
 
 static int s32g_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(s32_pinctrl_of_match, &pdev->dev);
+	const struct s32_pinctrl_soc_data *soc_data;
 
-	if (!of_id)
-		return -ENODEV;
+	soc_data = of_device_get_match_data(&pdev->dev);
 
-	return s32_pinctrl_probe
-			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);
+	return s32_pinctrl_probe(pdev, soc_data);
 }
 
 static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
-- 
2.37.3

