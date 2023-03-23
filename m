Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD46C6B86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjCWOuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjCWOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:50:07 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E7EC54;
        Thu, 23 Mar 2023 07:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K68DjeHnAteFebQ99cU3PVQTs3BcieWZ6dZ7gP8sk3VCkyRPcJvvTGGuMkMqL9GuAjayBKYO8JAlz648ZDVatCxC4R5354xjWS1pxSGPqMHqU9CYKYWhsrsXqnnciZco7DDIQXFcR77b+EX5gXoZmp1MmepyeQbRwMiBODRwmt7BI39Rcb5DckjOTj7VVEestcayoM4OsDkoLTE+GidMlpcuvJ4RJKiXGHzsznT/pCZ4HnfCCWjsujf5uglACCT3gWSVV707JgtRhJeyEToyNVb6dlEZje9aA0mfE53WSCAolj29/vKXoo5+1QtlM1mPrgUrRxIXWeOM8cdsE/QjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPHjBpbyjqpZdYucP8HA6SoZjt7wrYl9ZeRBprvTChA=;
 b=ionni5yFjUH6rtqC+dSqFRyIXOl6DpiTFH+Rm4bkWNuyJXwy7Kg77XxsAJbuV46HtraBqBZsBoxAh8c75SIR2/NrY4nbz2Q1bFAfcXfsFYR7cLqA9n7KzgK0TAosUBLSvQCnaVPj/3BGDVga6WA3RJ7JgtptN65I9efHzSMWTrRV6cyvtrKFyhHYeD/im6R1+cDi02ttei/6pZrx+5vRiQe4Da+hFIsNXz9jaXLLl4z9V4Uc7X1+9ViEL2Kmc1Sx+5iXx1mPfu5PbQSIxOHJWNovJWQpxWhrBN+4rKM58giYJc5tfd9oL6OBLSYLHWsXGzlcCjdAzHMhnc66IJroZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPHjBpbyjqpZdYucP8HA6SoZjt7wrYl9ZeRBprvTChA=;
 b=UwkqAC7UlSiRLlPM421F30zhzD/OePLC5nLxjtk53HpFgB9qVfuFdVS//eM7RXpOTw/VByTSw1eeQnCT4uYP9CC1IXONM86uNKbcgIUW0XERVW9SAJkqLfdvdr95VLf45IfP3lZNkKWmWCuOySi02o9bnbOIaxlHLeJzTeyX7bCkLvyo92Vve+cdPEtS6xc6miBq8IwVFPGQjJu6scpJQe0PjjO1Cr4sJPWMdysNdgxP/oBoSwDGO31eBu+64aTOcNQhX6PKqG8qkUNZyZxTSgAvI0U8oV/bw4M/LdqvQ1xAhm8X3ufkak0Z28IlhOiWoH3tkfmBxc2JuAJzoII2+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB9254.eurprd04.prod.outlook.com (2603:10a6:102:2bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:49:44 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:49:44 +0000
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
Subject: [PATCH v3 5/6] pinctrl: s32cc: Use generic struct data to describe pin function
Date:   Thu, 23 Mar 2023 22:48:32 +0800
Message-Id: <20230323144833.28562-6-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230323144833.28562-1-clin@suse.com>
References: <20230323144833.28562-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 82adb6c0-8611-4115-9c9f-08db2badd70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8aWPrRQggVFxedVCl6hzOye8r3WnkDQmr41C6fBxFBKDOk5EJHDu82fYC1gPwq8XFyPAA6EPOsPPPIU5OwQoa7eAaufyGDakkcusLRYWcBiPmnA1TOQB2GqzjfGRR/qOnW6u++2/IjvLFP3Q4F9Ze+2YISU3oUBn+JEtggZ0sb5BVZdMIAzen8+qjcZMm2EKyWOvHyipHnwgDNMrELM8ypeN3BO5V810Z7KAhMrCXsleBTOuW6NpRbUDiUY4iEjuRktAJBBdNb640EqCLuO7om3es/tYVPWREQyrYbGsXBVeUWV06/1jaGURYiviOnPe1EnJIImZRoGwgSyQC6yTayaYXZTfNqsmeHe0TDUsMXqvW2Oi7AuI5RE9GUhZI0xKElDD66kBs/NpBtjKspCxlGK9wHO5OOeMNmAtDv/DWgwwi6XmL9WT9lmrtbsV24c4yK3qX1kUzE8e9xdXtFEsjgb/mG0Z1LSNrrA83OEyK3yORbFRGs3kR48kkQwx9JMLZLVZKgX913l0spk+z/jRJa6VYIsTF4Y3rOU3JzpqRwJbjTivMMWe1PvlbDTcNjeuAy0xsJO1kUo905/cN0SWUmhsvTpTuYGP9R1fZx+ZcyV1haqMhm/1yBfj16QbT2SCG8qBsccSsem0gkNL/h4ALBGADgJz//S4OLD3z6/WuzQgJlBJKWylq8KiWtGTtue
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(110136005)(54906003)(5660300002)(7416002)(41300700001)(8936002)(6512007)(6506007)(1076003)(26005)(107886003)(6666004)(2616005)(186003)(83380400001)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8n6QPhWcFA+BtNYB0yJ6iSme1XTr9lrOioRp821tNksTVOhSaYh2uwM+p8wK?=
 =?us-ascii?Q?8YCpjbYB/9+lKAkrYCZb+1xqm2H2Ddx463CFlKNmgAQtnIstynPCx6pmRg1P?=
 =?us-ascii?Q?5FaZK8BX8dasg/aK9eh5EPt/fi7//OR7Nu2ruBZU90uE8Lwc2PhHnuSxl7QS?=
 =?us-ascii?Q?wX94dQ3rtia8MZmjSN+t8iiWU6IuNRGB2HSfBRdWAP+rWFGpkYqgjBlrnS3A?=
 =?us-ascii?Q?lOQ7xys3YBmlBL/sSIOb265jSK6cc1aECAExXZauogdRj7krmM961lBFvkX9?=
 =?us-ascii?Q?sb+/oeab3sZ1DKCBuwoNrSN65nPz6qzkviqOWJdJhfo9d/Kn9OXNH8yIWgS5?=
 =?us-ascii?Q?84Fjzw49R6QkazXYbMHHyaJASG39t08GDApUx8E10y16GUzIX80t4Efj8onZ?=
 =?us-ascii?Q?cVZse0mjI+4daLHFGaXbgagmwFDClEhx6hnql92TzAFGGZKCCceGxMpY9kJE?=
 =?us-ascii?Q?DynDLpsr27w6s8y/qrrdAtGy/AgXR1mjmTqZeWTxmCVg9PYzRM3+sKIdKCRF?=
 =?us-ascii?Q?g3fdtMYJepXXEO84902U9dPdOAbb35iHfgJhJ2gT1fNe0+kwjncNATLzxmq2?=
 =?us-ascii?Q?7ABUtSnUWqoxcIpeEZTiEnYMM/WmWfanYeh8KhgRHbxUUrPjPxJ/DyJjO/e+?=
 =?us-ascii?Q?ropwxXvBy8hHWK3sJuTo/XbcKvzLEYHVLqOup2ljkj5RWXbAkSYNqAdLNTXD?=
 =?us-ascii?Q?rTFtI9xuivJwWIRqKzIrs91d2NWqSVoyOoXSZcPL8C/NiYb5bAZVS7CqTr4w?=
 =?us-ascii?Q?qBwZsRDEQImQ1mVusA5M+sfQZ1OJyCfZQM0LR01SSD1x8khs2i2m21fcB5bs?=
 =?us-ascii?Q?FMpg9E4k1hsDf2me/eR0ngSaZgafO4+N9d+YnwPYGwmiad7x+yvfhzLa7oks?=
 =?us-ascii?Q?LZAouREpPLDr6S98TLzBAntHF1yJclgwyYM2w+HirzavIMQKSz5/rFiCtjzT?=
 =?us-ascii?Q?lnWAj7L0urLrO7apdgShyu0NB7Ak0snYq5KVTWfCKzEjOmg2Rzhrvqf+PRuR?=
 =?us-ascii?Q?76pI0N7TNvLKGFbXVbsoFzjCiNruHJCyr3iTVtQiVCBKZ20/0Vjdw9T4CULe?=
 =?us-ascii?Q?9uMIcVcPo4sGn0M6Ej5nzlFpmaH0VhoWALQ8G8UrNsYvqiS2Us+lIgmQkMop?=
 =?us-ascii?Q?rq+2QwrUhLGgzX2cjViWE4hsYSnbHcnIMFpY8rtgwzZwhqOGfHX0VKmsv7KA?=
 =?us-ascii?Q?+Y0osRhvrtbXClWy5y4k7Qk6Qkwf/4CRcLxgAVmiVqqU9I7d+5ov1YLdulMi?=
 =?us-ascii?Q?NqD6/nYlauyCaIf2WMWbLL5eWaJtj9S1nWYzEIRNGetxnvrsq+egdsB6UHlg?=
 =?us-ascii?Q?N3LkV+03Pc7t1zXnyft3fl6mQAZvMcWcoBY8uw5DdNevriT6vEe2FBNGBgSq?=
 =?us-ascii?Q?Ww2fxQR5kpdXdz+3CYiKAPTVk0y6S5G+PYenpDRT9fw++Mv59pOLsD88Wj42?=
 =?us-ascii?Q?l0OGcoUPkXzdCWlkC4TTOBSSJga7/AnN8qrvGHQSu3AjiFbJJKLz9hOvEjPM?=
 =?us-ascii?Q?CJaV08omfoULUk4g/VSA5D/6tzh9/jAVgltpjPC+N/KP7bIUgQ4FLp8ZrAJC?=
 =?us-ascii?Q?qOQR0xsLx3vOr0FKU/o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82adb6c0-8611-4115-9c9f-08db2badd70a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:49:44.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO2GH/Gi+nMJwlPU3+PEWPmH6BjdeBkv1uPx29i+8jXiGar7kJmQFQ0T4tIqmykY
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

Replace struct s32_pmx_func with generic struct pinfunction since they
have the same data fields.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v3:
- Separate the generic pinfunction patch from [PATCH v2 4/4]
- Fix the data type declaration and remove unncessary type casting
  developed in v2.

 drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +-------------
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 850cd668f406..2f7aecd462e4 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -24,18 +24,6 @@ struct s32_pin_group {
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
@@ -52,7 +40,7 @@ struct s32_pinctrl_soc_info {
 	unsigned int npins;
 	struct s32_pin_group *groups;
 	unsigned int ngroups;
-	struct s32_pmx_func *functions;
+	struct pinfunction *functions;
 	unsigned int nfunctions;
 	unsigned int grp_index;
 	const struct s32_pin_range *mem_pin_ranges;
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index e65c88162d7f..8373468719b6 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -364,7 +364,7 @@ static int s32_pmx_get_groups(struct pinctrl_dev *pctldev,
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
 	*groups = info->functions[selector].groups;
-	*num_groups = info->functions[selector].num_groups;
+	*num_groups = info->functions[selector].ngroups;
 
 	return 0;
 }
@@ -785,8 +785,9 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 					u32 index)
 {
 	struct device_node *child;
-	struct s32_pmx_func *func;
+	struct pinfunction *func;
 	struct s32_pin_group *grp;
+	const char **groups;
 	u32 i = 0;
 	int ret = 0;
 
@@ -796,18 +797,19 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 
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
+
+	groups = devm_kcalloc(info->dev, func->ngroups,
 				    sizeof(*func->groups), GFP_KERNEL);
-	if (!func->groups)
+	if (!groups)
 		return -ENOMEM;
 
 	for_each_child_of_node(np, child) {
-		func->groups[i] = child->name;
+		groups[i] = child->name;
 		grp = &info->groups[info->grp_index++];
 		ret = s32_pinctrl_parse_groups(child, grp, info);
 		if (ret)
@@ -815,6 +817,8 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 		i++;
 	}
 
+	func->groups = groups;
+
 	return 0;
 }
 
-- 
2.37.3

