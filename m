Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE376C9B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjC0G3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC0G3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:29:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D6346BC;
        Sun, 26 Mar 2023 23:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmWrdSz18eS+akcJ+Ad2W1rHiMuZP48RnLe5Qhs3kho7apUhQS+BGU2E+zOp6WheRHuMOqC2RD8i4EzNX71K84iCEof8igrfiCQdNN+b7x+GPBV6W2siljjc3oQDIz/N1Fbg6qAl+DrlcnqLEHPOR4KMHFWtWe8MbjQ1lTZ0M0DLfku+/LmiwrSV/fkQfKyOCxJUBlmcbF0UVg6uT4CyHK+svgbeymIFRbqaG7kQSf6VAjjf+RnVaXFPxulTWX0KgkjimKziRc819lng+67nPr7IRJuJsiEXhywgEe+Vi/2LMqGKsjtQDIW0zbPNwPr3CpjBlcEoI0ZuuQfFHdVCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN4oSk/fg6PFOW23zvTHHTxM97j8i0UUQgD086d68p0=;
 b=DwZf4fRSizcXMmXEl32sLHKi5zYx7XE5zxker9q12N3zTzBJm8WAZlcrtY35KmHCXC56J/u8VI9GtWtlIP4R1f9XsSyQJIUo/Az6+XDNYgoOMnVzEJmIWPY8prTjqMQWIYOdPEsdBZqa6V2WQ7GQL4bNXiF0pzFm/5UBHQjU1fFtQeoTy8iyvof09BrKmomcOK1Gw7WtRrGzHuLv9fo72eBqc0QoYUUdcLkkmrzhK3F3DRf/5NczcxPmTRu39ymRIl5rojxzDRZ7QCErAP31ID4eHKTteRDYJ1yjafRtRifspwNd/0HjWJXLw2GKofyKuEFgia8ELNiYQok9PVulYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN4oSk/fg6PFOW23zvTHHTxM97j8i0UUQgD086d68p0=;
 b=RulfTfXoQRGsdRYjSVXKnI12GeFriDIBxz5xgCGbHFtk4uvH+wajeNyNLis6TWmb+Tf7de9DSIH7ar6SEWPqipWDHIYHyNpAPMcEpuetkxS5NxzV3paANbq5nC/VHVaj7Lz8mlIPzNSqWLwtCxWzwCW13pGTY4Mke2CLtP6ZGsOV23JSYhIEktRXqnMQI1v3yWWhDz2Qz4AX7Un80w4xc8zJ5xuemtNv/g/o2eebJ5bYjP88vyjKphKKyICOhJUwaKh8QYwqWP8kF8avQ03WwOQzB/zz33ZLHGAV1oCNU9PSgSegL+d3n2nzNk8m9b11t4JlmP2uSpAQa1/Jw4KSmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 06:28:47 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 06:28:47 +0000
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
Subject: [PATCH v5 4/5] pinctrl: s32cc: Use generic struct data to describe pin function
Date:   Mon, 27 Mar 2023 14:27:53 +0800
Message-Id: <20230327062754.3326-5-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230327062754.3326-1-clin@suse.com>
References: <20230327062754.3326-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:404:42::16) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce31f70-f071-4686-55fa-08db2e8c857d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpNhkx2Wg+60O6Nje15ghYLqqjDUaMXlSviXiLkFiA3M1PyR7G2mvcVD85SLSKIe0SVxhmm3opF9AVc3v6d3btSTaIOlOV7GeVogswlP7uNQxCXNtKSs+c1FR97151mYuFdFs31WHI1cnB3+YmrL3I9FXNx3WDjIMKHxG1igY17TgM6G9bCNFc8QW7Mz02kDdlcmL05ZxQrHFRcJny2NFSayuwWUOv/bpMX2X9vOkdQFZigChaEkcJHZi/oPCTdayk1k7DOVHdAyS9Nd+1NzLt+7VC/tIdXuTpp0kNWRWhh8FdDGAv7eoaipLtvrA/0mB16TmUIwPNDxhPZ5gqCVP5JL0QAH0BRzX0oGl2ZfljkGhWDT3yDCeSU1FOJeWBA7cgn7gpnjb10ZxbKX/8XfT7m7oej1pyhPjWphksMFaS2ay+Gz/e7Akhm8ts5Z7LflpYXhRoHHb09mynUM4VyANBLugrABYvqVbNgA9yt/lrVLnnqX3V7/g2aKgWLzQU+rA/vUd6XOOtnZLOYr4VUsKCCCqibr/rqTZzp1uXWz3I2BDtpQ82tPT2kcZDwEzWuKyEEP6xGf7Q2fN9unHcwapcKkZyTDrCMqOWNY31FtOuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(316002)(110136005)(54906003)(478600001)(5660300002)(8936002)(36756003)(86362001)(38100700002)(7416002)(2906002)(4326008)(66556008)(66476007)(8676002)(66946007)(41300700001)(107886003)(6666004)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(6486002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+pAZPUX+WHnikZ1eTtjmunUzFPVJ9u2GDcO5FH1msr1a9plv/s9CHeJ6Hwp?=
 =?us-ascii?Q?qdMT74gMFOojN23PlnC8WI0Pk4839cp/B3Z0DqCEszHI9uwLwp1YtPCqGMqd?=
 =?us-ascii?Q?MxaSSUaAZCeGNuS7dtOx3ImDlrDgBpqB4vEEK3kIg+7vE448g2cbwQn6uPap?=
 =?us-ascii?Q?cBSWUGdORca5O5K+k90qzXsSU+m8XpuRvTzhSqBHIbIctFb5VjSrHzN6XyJL?=
 =?us-ascii?Q?LCLMg8vmKA5/o0tkpZq9LRJDEpyKCCO10zYEv38JPuDaGzxHuhzjPC3gETvC?=
 =?us-ascii?Q?zZWh9fomfbmiP3zYdCi9VU07ZUoUN8R/1xqXoKYQhX2nG4/y0AINH+5nKxUX?=
 =?us-ascii?Q?P15S8pFg8mbd5bkQ/Ph6LhipVVpkN1hT7WN+2/GWymjxv7BYJNhFOQNITnra?=
 =?us-ascii?Q?yj9cMIGi98jHnL6jNiVHSkM4Zt4ZdowN/ClqpRBsW8bd7m87MnthKuBMGF4J?=
 =?us-ascii?Q?4h1qCT2IVgjL0+9CcmF/06vB8UWHwht7OEj61PKGC1DlPfkx8ztbJv5S5hi9?=
 =?us-ascii?Q?wdrRc6hfeCHKw8M8P+H0kgCw0T0l+WNJN4WmjBzWCWHAk+JWX0FurWnrfWFQ?=
 =?us-ascii?Q?5zStEqGd64BGy7XwNqMvYA94TTVNV2b7CDg+TG79xnIni2Tfu57f3W/8oIAU?=
 =?us-ascii?Q?ck9VWAuL+BJh4ir/1uy2cW+3p702linisaoJyA4ADzvVcoAH+Xy58nAme1Tf?=
 =?us-ascii?Q?soLpyw+quHnc2D2ymR2KJ2cvpnJvVOCMgf9g7/Mf3Dm1Vp4F8L9tk5sDd76z?=
 =?us-ascii?Q?FRNBUo0ZiSRWbEj1v4/kB5ECpukMjvpjx1EugX5bBZILGo/m+p0DSYyiuCmj?=
 =?us-ascii?Q?UNYfqlY70U68p7NaU81fPJWSMV8ek9cHyewqi9yQ1WNBFscRlpluXqJRe2BY?=
 =?us-ascii?Q?MIIMuuqlpvYlrxpoXXABocU4rxEfVW0ATMtkVSwBYNie3osuNkr0esJuAT07?=
 =?us-ascii?Q?PNqy2QkzO5wMVoOKediM6NadErzJyNYTDAQ6PXYhuFJ40OlHlIA6CHmptXAt?=
 =?us-ascii?Q?3nO75ur9CMKUo7hCWwaQFeQmVRqTadHloyk5meKbIKFEN9Pv/pZ2t5ZQqawT?=
 =?us-ascii?Q?3mlvoCTwOsa89naKOrESMW2hLY65/cPsZa1wgem12IPR9RF/fnxA7nSOloxP?=
 =?us-ascii?Q?1vQDrpK7F3PyWh1oGFB4eJPOl4viXcQafdBqEedStCj9+vLsqJeeTk8EfQwL?=
 =?us-ascii?Q?jbA6S4tf/F4lxKYy91v6Hh10do+XmZY4NgXKK9zh+Rlon6XZbYOeJXGLwFVG?=
 =?us-ascii?Q?HFS13DqU/Glb64sTfhmZh1sO/cSDkGIMleRgToiqr8tuoh9Q2q6G64uxrMmb?=
 =?us-ascii?Q?eGQeXIQU49+L+uWRGPBGo+sA4WnnQNhQq0hHrktnXL/lEPjlK/qUZDJK4e/f?=
 =?us-ascii?Q?Ykvafmc42YeOlO8b0qGmaThooRjjCXDHxvP524cNk6xAtED99QICjh+hAPe7?=
 =?us-ascii?Q?lZaOomJQKRYLHEJDIIiM0PvN2FQX92jWytTOUi97rOtaP6RNFPM6KcB1dzvd?=
 =?us-ascii?Q?2DVW8JwxP0E+kEYGsjnsYcml0cHOmJ+GxxUj3gxdNE6WzyyQI88iQi6YET9p?=
 =?us-ascii?Q?iVQ/NPfiDuzMm0XB5E0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce31f70-f071-4686-55fa-08db2e8c857d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:28:47.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QJqKXnsyNCiPe5k4Va6vf5PSPNenJoSoUHo8kq6sb4epe0QrscWrDsJrYvgTT2/
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

Replace struct s32_pmx_func with generic struct pinfunction since they
have the same data fields.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
(No change since v3)

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

