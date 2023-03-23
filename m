Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0216C6B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjCWOuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjCWOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:50:28 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80604EF8C;
        Thu, 23 Mar 2023 07:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqUayn79HBUItgfIOB94WSvz3dszJ+x+u5Ljx+Cha/p0wPH5yUHS2/QlPC3F0RrZoPRpYmY8rjG4LF6Vgqqvgx91uZAwzDFpPOMJELZCBALWr4CIVikTs86QOAaUx+R65NNIoeWSmd8TWSgcY3ZyrBbeBIko+eFqHeO5xxkQNs2jTPHoSsGy1gVW7gaXf6fb+gZZgVF7Y+G4S0lsfMKucIS2Y1DXOwd47QyvMeyvt2psOYxXbHaXEyfnAEpcXKaHzxpQbr4OGPDeKFnMs/3UNzhxmYZZwHfCkJBGhso+2H4r56u/1cZta2gkx2a+LHy49ny4Pd40QWVJArxRwXNSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0PWgupYOZLX8O33zYdT2WcS8EVIDjigMriWTCCCE1U=;
 b=A4MJq1q3z4Zzi/KcPL3/NDtMOgDThOkCZtMGrQfKaNg2NSmu+kID6+WcKPUrFTt8SkwRrIiy0VfCkyhONgJ6HTkz0nIyz50Ri2W5U6HJfeUqgbzLGIVgca4S7QNxDo7QoxG4EUF0FXeYUCGmqJnCluuxqgHyZZiW/M4SG+byUBaa1Z1/slX3SR/OknDeR0Y7qiKFBl021vuM9V8wF+YuZeISA3bWLwm1UU4qGxWWLxZyPXxT3LmbFgfzkvA4SHoyiIQ7ARyerR/ReeAeq5HipYg1kcOhWHWQ9ECFyn21civT9XFDZB8UTDW5JSxciuVCZQEYkxsLCnceY6+o+GXr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0PWgupYOZLX8O33zYdT2WcS8EVIDjigMriWTCCCE1U=;
 b=LaFD1V6SkAUmry+HhPR+31/YsXx43BlwSkKPm0/vgtrRFN9f9fMg4BWW2s/FJOiyhwFHuEKu886zx3VLbY64EQtw4hw3zWrLroHgM8uWFQA8lmL9Q1ar+jLL2o6yg7G9EbPD9xueUHgkk5+mac1EB4N7cXMazv7tvurB/m7PWQtCU3AsFtOGs/1KcdhGMK9yJNnpanQq5jiVzPL2/xGLBwky9ckO65HRcx7RukO+alau4Egw3Us9r4yvqYHISeTxjh3xEre1J2QLNRby8tfGreTfLCLa/t8Zvh9qVDVEdVF4rHBYLcwS5V0TgMUbk4jBYmLn1olrJLbLKnvX1KLP9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB9254.eurprd04.prod.outlook.com (2603:10a6:102:2bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:49:54 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:49:54 +0000
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
Subject: [PATCH v3 6/6] pinctrl: s32: separate const device data from struct s32_pinctrl_soc_info
Date:   Thu, 23 Mar 2023 22:48:33 +0800
Message-Id: <20230323144833.28562-7-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230323144833.28562-1-clin@suse.com>
References: <20230323144833.28562-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0345.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::6) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2b06d9-a5c8-40b4-d984-08db2baddcd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPw1Rts/f5cq5HKoq4wggemKxVK2dwHh7rWgGyrmjqSJtwMJJzNzloM0PlsP8sP0RNBDkAxX7Lc+mO9ovLMtrkS4TATk67LR53Ho32aznhG2sQWFrPh6xE/hMYIhFJNJP17Lt9aQg76TIABJ+36M09QipCr/TcGvWiRCGaABlc5txKfBGQzgCt0u8ZzPRO8d2KJ5xLH1kNYyplr+xrpNkPgOrrjll1Oc1MEJhBj/TPmlJLAGwIxze29/u8xB3jInD2fycxTW0orjGINNViok/nEiA1mB2rMZUG1WPWGakoubuq9x/8/hHPiU5QHvG0UxLLITZcpY3Jbop2VuCMrozbURYdgg/4ABFqZWNoK8OCb4VBQa46CzTxN5OrxusU59mX1TkAFaPZ3xKNrvVO1lLSU58H4ujNCJm+HFQM41RCdQaYGsiBu4IE5qGiBFYb/GBPwcIN+hbK+iAt5hXTvi2FD89PZ39s7RKIP6uuc9GGuZu2/DRIN77ItFEi7T7vko8o5uiOLqURjUm6+3KFDDqbMUZCI9tgdqRq3/b+nROf7ERqxoNuia0lk5Nqpn0Pvyoil1uqgXT4XVz48+0DDHlXilxzie3sSGXz2ukHYxxZ+btKRZ3+fN2Tlb7zos6ipORd9EiJWPx8/Z2rnfBvsXvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(110136005)(54906003)(5660300002)(7416002)(41300700001)(8936002)(6512007)(6506007)(1076003)(26005)(107886003)(6666004)(2616005)(186003)(83380400001)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5pmYUrDlHpbqHkRBVihiJhMwczBFbdiHKRCw0VBUcNAwwIqE4toeERqlNfV?=
 =?us-ascii?Q?NzqI30EN2gKu3MwtSdF+Ckfj4WQJSXJTNJH+bxat46HlPPbDGM9Xu2VWxqjU?=
 =?us-ascii?Q?oH2MGhxXTPF1vMJTiaZc232DYLOE3M3amJxTIECrxe3duetI9/E7FCN9ULML?=
 =?us-ascii?Q?/3HtoTuKttp3KbYKt3DVqHQ+fgV+I83MP46ZoLyYG9DeQ4loYCCG8M1LEXh/?=
 =?us-ascii?Q?zochP5cc6EpQQbazPBCpx7yVhKP4Z7ZzSFjKEo/sPotnmqzFonvOwFSmBd4O?=
 =?us-ascii?Q?EMXwHk2uj04aEv7UN0DA+MaJqBaBAZth2ez8WVJlq5gQM3W2OnbRMGZwpAEm?=
 =?us-ascii?Q?x+m1su0PJTM45OolCS5rzqXOxbnzblIyehExECSchwhRlKwMtgDX74+Vtin6?=
 =?us-ascii?Q?hQghdU0fhTBSgc/Px7AqdIlg4QH3fJTV8OnUg5oQz4dAPCKKoMF9UyBIxIH4?=
 =?us-ascii?Q?jQpFFtJJJ0z/hr6ERWj8Hfrn4qncVir1tcAAYHyZ+PRElGo/GS2GgMKFt4kn?=
 =?us-ascii?Q?FCb8F+sLUC+EgZMMQkidWVxhGj9el0EWWyLroDeNgGepgqbGexnNQKCCdjkI?=
 =?us-ascii?Q?VSsU8Qe6+POYzZJ6UMipQlMJ4h7dPyOXL4F1weSPiGMNm+Is5F6kSc6ntuh7?=
 =?us-ascii?Q?FcBcHcPMkd3ce+HpAIv7Cd/4avzh38fGXvYfyxaEfhbxdZMyhxxhVkMDp40V?=
 =?us-ascii?Q?QpsCHqP1XxHdNbJwwov7BaJL8eLmOVJnXVw9x+10/boxeZigH8a/Vcw8/arm?=
 =?us-ascii?Q?XwZvIhNiFwD2h6FUs29pT8ugHLMdyul22XWNXqq8oje3WZzBpJ4J30DqEJAA?=
 =?us-ascii?Q?mfoQoDOooNXLb94Ez6hXQ6tBgGmMsdc+ELY78s43USzOlENwGimSu6jPCnu4?=
 =?us-ascii?Q?9YK3q0S1gORobFUJf+xdqODcO54SiPbxpg1RHzI0J3Sg11TT7IcAuQU/DeD0?=
 =?us-ascii?Q?4TKNLX6E2gBa5hw36YWx8APJQm0Ve7Mo7hh35fOwNrCAO97/QOpADN864Qu/?=
 =?us-ascii?Q?/T+mXNEj2UTCnGhxPjFjYQdTtlhQAxn72sHDoFHPV2CdFeNxuJnh8CyM2dqU?=
 =?us-ascii?Q?8OMCrB1UVUvwmbTvEADz8helu+WSMxV5QxO+Yb3bcM7tWtrdTVZJuouFQZuf?=
 =?us-ascii?Q?kY5ZAvgqk9BV/czXmMChG2eTn5QvNhuGbD0AdJrgoU4eToT6DQajO6WPQd6E?=
 =?us-ascii?Q?L+/fdi2LT74/gDapTKey0PwP4wTNJt9Xr6tofLN8e/aJK+kZBpaSdUE65i2a?=
 =?us-ascii?Q?3tKduNuxq5gAtwrwC/ccSF0WTZBzatH/5pHskBGAbcFmCXpcIR3KGpocSawn?=
 =?us-ascii?Q?UJC31UA8RJQEs70cMoAySOttOsYLAdXxYW819cOqY4KrfEZh7W2XaX8VGGyF?=
 =?us-ascii?Q?lH+oBikJ7PKk1wT4gZdjliQ0iSI5O08XKLrN6Qyhs6cpO/ML+WhhUrwgJUCL?=
 =?us-ascii?Q?rykp3JnkqtxDqtBTH0d7+xdfEuqLgLRNK6AIFLCropzpItJGP7i167eLtpx7?=
 =?us-ascii?Q?cXJGjagFKJ3jCGnCXod0+/Jm8G/4ONqmNwUSWR/2ggIaj1UpXiFrpjOm3mnY?=
 =?us-ascii?Q?ZG9B3MDMIv0X2sGCSSE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2b06d9-a5c8-40b4-d984-08db2baddcd7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:49:53.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9csOiru6pkro16Rel9yJOGICKxR8RN3OatvVyL6VZLcuZvZP8a6w3mPcZ2ZmFmG
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

The .data field in struct of_device_id is used as a const member so it's
inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
because some members in s32_pinctrl_soc_info need to be filled by
pinctrl-s32cc at runtime.

For this reason, struct s32_pinctrl_soc_info must be allocated in
pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
to represent const .data in of_device_id. To combine these two structures,
a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.

Signed-off-by: Chester Lin <clin@suse.com>
---
(Initial version in v3)

 drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +++++++++-----
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 30 +++++++++++++++++------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c | 10 +++++-----
 3 files changed, 32 insertions(+), 22 deletions(-)

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
index 9124c6c5e5d4..e0944c071c8c 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -721,7 +721,7 @@ static const struct s32_pin_range s32_pin_ranges_siul2[] = {
 	S32_PIN_RANGE(942, 1007),
 };
 
-static struct s32_pinctrl_soc_info s32_pinctrl_info = {
+static struct s32_pinctrl_soc_data s32_pinctrl_data = {
 	.pins = s32_pinctrl_pads_siul2,
 	.npins = ARRAY_SIZE(s32_pinctrl_pads_siul2),
 	.mem_pin_ranges = s32_pin_ranges_siul2,
@@ -732,7 +732,7 @@ static const struct of_device_id s32_pinctrl_of_match[] = {
 	{
 
 		.compatible = "nxp,s32g2-siul2-pinctrl",
-		.data = (void *) &s32_pinctrl_info,
+		.data = (void *) &s32_pinctrl_data,
 	},
 	{ /* sentinel */ }
 };
@@ -740,11 +740,11 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
 
 static int s32g_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct s32_pinctrl_soc_info *info;
+	const struct s32_pinctrl_soc_data *soc_data;
 
-	info = of_device_get_match_data(&pdev->dev);
+	soc_data = of_device_get_match_data(&pdev->dev);
 
-	return s32_pinctrl_probe(pdev, info);
+	return s32_pinctrl_probe(pdev, soc_data);
 }
 
 static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
-- 
2.37.3

