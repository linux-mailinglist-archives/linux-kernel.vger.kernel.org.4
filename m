Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473D573DF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFZMoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjFZMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:44:10 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060210C1;
        Mon, 26 Jun 2023 05:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEAUZUwmq6HfhgazEsFiTB45FzPzmIO/61nMN/qfZO4BY6q9I3ZrCNvUwuT5JnAOg4/PjuqpSWqxGLRUIxTGYrBv59dkstwVf0cNESz8i+qj5qR05SKauF12VoX4dhW9OrcsAde5CXaHBda5g9hGT4OU+E5rmOT8Wz9vn8uWjZ+dcw95z2agdYRWY7Ivw+aMITXPIpX74EpCj5xy54lgUvRKpA0G+Hi2CyVnJpTFw/2rcrjN0Z58T8xk/wQfiTNCgLoVUak52lvmboIYaHd9Qq7l5Mft1UQWLXi6R1BcY5kq++3CPl1hxj0hN2dZ5Jl6h+wMxEDBRQlmielLEetEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQRcx0nLfSmXxFDAULF/0+LbbiP8Ufj0ZtIsYfe8PZ8=;
 b=LCZOg0WUTlbnhoVrVXKjSZCGaqKVplnNDGs35t3QCbnhtpsvStK2KyqHu+NZeye6BYvcs0EamB/R4t0ckl9E4ICF7+wqLBT8lB7gea/EN16K+UAxvOKkIpOu+MT1gr8qH2puL2mbt8osqUYWpWBEwgq0JgfNbCpxW+LZr3ZuHWYMgVILtnshEnnfqDNAbTVCXlCLr+85vjOuL5ZnB3mv2KTlvDxCxUsnwtCJd7oWWPC1jFkPsNZw/pvagWn5Ig+X0IcodY/J6PU6y08DAuIh4HXeVcveeQtAXCqioeA6HOgmyYJQyecftfm6+Kz8nrPbzU8BFWJL/HlEsGiPs0Ru+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQRcx0nLfSmXxFDAULF/0+LbbiP8Ufj0ZtIsYfe8PZ8=;
 b=gyBPKfJtGq6cbDotNlz6xADlHV7meZtZ397XyStxlWD1PLEvGES1hG3x6rErYGxQzJYHeMk4e0BHBixD9N3fqSqnC6AdysKhdJNsYSdxPJGviSDuUvkbeqFFCGsFqwLPDaS9bS67v8fnnHeL2SB+RMwKDjK4Wp6DqgmdFOwDe9wyice2bYYxGe8IGTAhy1eqZqqqZdDI4GL0lkj1+KmUBOdeSro1Vl96jHxro1E77sLqWDO1hRtnEm/R67DR0o+JwW9n2dMnJkcSO65pzoG7sEA+Yhkjnn1HI33uTWmQdKFaV0kEnV1HgwPR38KtbI/obKkczP75nNrLuFYMBbhcfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5320.apcprd06.prod.outlook.com (2603:1096:101:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 12:43:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:43:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] thermal/drivers/qcom: Convert to devm_platform_ioremap_resource()
Date:   Mon, 26 Jun 2023 20:43:30 +0800
Message-Id: <20230626124334.15100-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230626124334.15100-1-frank.li@vivo.com>
References: <20230626124334.15100-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 01553e32-7c29-44be-63b9-08db7643020c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGNU1PW+k7kXnNjI/wfqY7zbF9qZvDMJUg9EdCm9QrXcOvifd9jI6tPgPvk32BcfR3Bck7chc2JBZk2NtomRQV6MwdjcySmRm5YxWUJPjuC2Xi15jRhPIWZ8RuLup6axf0PK7ixSCKmiOljMF46IfNaptFy99dse6o1N2OSPiZ5nJKS49uFpD+qO4B+ySd/2zke+kasZRPK5EDkxAI0WG2mo1HCe6UP9scsGD5h66ILw05yxRPcEG/enuQ5CFmc4X/IrayetVuKEcgZ1SO2kWWAa/r4RRnX+8JrSfjfhLRPOvt4E/NNm/bxy6Tz1CJ5OJk/Wcl3kes/kReB0OnTmNTvHGrglnC0ls/hzkrIjfCSkOocOAUErJ/cGMmT4K0FRK5JswAVyN6EfNIo/7+RbwjyW+mJNICUmJr1dC/q03neLgTcI5pXbhSq5nMU9uG/SDffPlGhkRckJY3X5tBQ88t/TWYS5mXLnWemJrx1P51qbAvjSA1cPUeuTsUIutsdcaTCgrpbHidgNWBdM1L/LvXGfX2qt6RbUd85rNWBLeKSt2f66oQVKP3HXbwGDquqJDKDiMv7eLMzhJ71kB7NnnpDwnnMHNzMKAzGqEYEdi453AAZ+5qaKCqitIYDtbIzM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(2906002)(6486002)(52116002)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(6512007)(26005)(186003)(41300700001)(110136005)(86362001)(478600001)(36756003)(66476007)(66556008)(4326008)(66946007)(316002)(6506007)(1076003)(7416002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xUrrJebIMm5NRuTHzwCd9iutV6COjsgpoULtAtcLTBrBU5Bq4K3B8BzmZBN?=
 =?us-ascii?Q?3mzI1MbXL0ywXNQgrv/SXcS1vA8O72gTZBYiG9L4e0S7tz5sJrDSe+l0l+Ay?=
 =?us-ascii?Q?pu6HvvBoumobNfaes+I06nJFPtXHpyuUS5YIlg5sxCx0yTWfBdJPz3V/kxGf?=
 =?us-ascii?Q?OyTwXb/EzZdWXMLFF+ETi64m7wOuFM+BvfZcNjlucFYmffX99k6INWqQ1bVC?=
 =?us-ascii?Q?XCHar+3OiIOt78Y4qt0xwJhh+fAtHhlEAN1V1omYN3RpK95W7QbKsRtL8opx?=
 =?us-ascii?Q?LHpJ4FDyFhCP/r1OCDvC72cekV5IP7qSQjfAmY/9qu/eLnxzxx38s8OelzG/?=
 =?us-ascii?Q?iO0l0IV29ijTW0URRWMHnvQeO7wDP6GCWkq4CEgAac6gYOcWq0fPOKD6M6AF?=
 =?us-ascii?Q?Asf7KRG+r0Pr9ewZFEtFQCpT8LTtu0Cc+CYjOwauyca/QOqzJH0qJycGbBp4?=
 =?us-ascii?Q?MXv90zPhYA6jw6GgYFkxEPTXCTrd79dhj3jkUtAmXIv0Di+KunJse6I7KbJN?=
 =?us-ascii?Q?Vc2b30IDjPnWmLSZya0PrYxCZUYVX47c/yfbAdtef5tEtvrzWnevkBtxi9rt?=
 =?us-ascii?Q?TRk5qyaI/zptJoAbiSY7D96LnJ+ewrFY7EC5enmG8oFQUWHhX4yqIXn3LTPc?=
 =?us-ascii?Q?Zh2KXxRQGD0D4MHUOSW11kAY2tjOzRHA+FIR+Y0uDiAfVBQlfXthCsjoEZ8a?=
 =?us-ascii?Q?7jU4RIAklxd7uEevEdeiibkzZ/6JmdFK/t5VoTQB1JlvJPjNKF76jyqKQDDg?=
 =?us-ascii?Q?isxXEhWTTDiRsQZqBjIOJiLjqIketz117izled72cF/WBFzxkfqlXKuaeigy?=
 =?us-ascii?Q?h90Tfxam8L6kDkkk268lOBBPvknp47pUO9pzbU1eSZIPtiaxYvHH+H4hCM42?=
 =?us-ascii?Q?WIRUVT1dTl98yXVI1IfRPGUhgWMDgRfK/gezB1UcEYhxZGI368fB/vzuaC+d?=
 =?us-ascii?Q?Cn84kHhVMudDzc7LyM0a4iQVGGi76993z+gP1gdYGB6/UOIkdivQYHCRq9ex?=
 =?us-ascii?Q?MpnYpsD3KNYK5WNmmMJkeP9T0m9Cg/rDhQ1lZVJi5jjgj/q/crIIrMh2uCKd?=
 =?us-ascii?Q?Gg9FRJI8/rV5fPRU71EYTL0WCsWDQU6aQ4hcMQQ787nMdnRZ1Hd6f3/7qgy9?=
 =?us-ascii?Q?hWN6zGoGT/eR6g/8Ar6iXhIVMCYo6KdlswBg4mYnZhkMKBkKq3Ds25xnoDWW?=
 =?us-ascii?Q?f2rJMqLawUHd+F+phmnGfCKK0MQp20k+VgV6JEIRhnqV2K5KyScBCJr2wl5X?=
 =?us-ascii?Q?fypJ+NetY+ZDF5Q62iXiyrLXCHX8Qb2QbKn7EbJgEKqkK33eP0DPS1Almgu1?=
 =?us-ascii?Q?K3PgVKn56lbhCm6TIqjMAF63oorMY/vNvS3gAnyDBpCMumkby0sdk4iOj/QG?=
 =?us-ascii?Q?9VvPuDLX4bKWGaHHu85frnmKRdcXfpwoa1YNBxuN6FXFzl089HepBip8n+PV?=
 =?us-ascii?Q?OZ16sX6g1WpyjHYcgnHJeca9epPKRhypOApLrusklh+stzd4tOFsJaPZhPLx?=
 =?us-ascii?Q?0oOJYLbDeurdRMEerwDsyHtGPxg6HA09tx7x2u1VZMkU/DFm/gYOYv2So1LA?=
 =?us-ascii?Q?5SGVsgwlzVgChK2BH0tYyeZDa97X/thA4LxlKQHr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01553e32-7c29-44be-63b9-08db7643020c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:43:57.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X/UO5nNMePnUzIT+FOQag1B3C5IVU0+wmHizyrLCqFZtv3+C+ot5nAim7jL7kEjrbWtWJM/6snfqGzSUEwihg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/qcom/tsens.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..f2e67adcf4ee 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -890,7 +890,6 @@ int __init init_common(struct tsens_priv *priv)
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
 	u32 ver_minor;
-	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
 	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
@@ -901,8 +900,7 @@ int __init init_common(struct tsens_priv *priv)
 	if (op->num_resources > 1) {
 		/* DT with separate SROT and TM address space */
 		priv->tm_offset = 0;
-		res = platform_get_resource(op, IORESOURCE_MEM, 1);
-		srot_base = devm_ioremap_resource(dev, res);
+		srot_base = devm_platform_ioremap_resource(op, 1);
 		if (IS_ERR(srot_base)) {
 			ret = PTR_ERR(srot_base);
 			goto err_put_device;
@@ -920,8 +918,7 @@ int __init init_common(struct tsens_priv *priv)
 	}
 
 	if (tsens_version(priv) >= VER_0_1) {
-		res = platform_get_resource(op, IORESOURCE_MEM, 0);
-		tm_base = devm_ioremap_resource(dev, res);
+		tm_base = devm_platform_ioremap_resource(op, 0);
 		if (IS_ERR(tm_base)) {
 			ret = PTR_ERR(tm_base);
 			goto err_put_device;
-- 
2.39.0

