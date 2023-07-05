Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0056747D91
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGEGyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjGEGyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2741731;
        Tue,  4 Jul 2023 23:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izVxK0zlyPE5flV/5a0OyERcWpAKuOjfLYHm6AemY6Wv+p54CeZ42lATlwpneLjFTTVEuYKoNCYzkQii+0v3FVvmLP2V1/S8bEUYnouBFnKKq4yfR5VOs5qEFHhe0Vcjl2M3Il/4GXpCL5NJKbIPAx0KCnYLQaMFT/rr2FBuOIRlUkMDl1dPUiVT+hRUJQap5Cn+1GUjMu7IzZevim3I4nJ/CcTB+VhP0jD66Hw6seC0UiPABABBpuREk8aENxR/qZQe6hzozVvkfOFntchZRaDEjwBa6AB582yN6Zafq0vd5vYc56eh7OY4B2mCZZ2Nf7FWaGezExYEZK/9zFrVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj9rqVQCNo5ZpAW2exUoHf2IL2rvhv/KYMOJ/LgeDMM=;
 b=A/htToCjZLw+qLUpdmV3twQ9OwRZqMJN6PDjc9DD/DVA+q9WKyIXEh9f2v1N6fTZwYxiCEGrGTL0Eao71FHCiZywznAFhdf4U/zGRm/n9vasKDZm5LtiOPpgcfZ/WxLzmNEGZMPfP+1hOf7DweDFjh5U6tlGGzqhObwH5h7DfIbsglpwRHm0OVRb0M5MYFB9CuaAeZ5IR7GE3vu9ynkBzZMpXwrpVqrCNtaCh6BAS7g6Af1if9gNAhehQ5DB6LRN1S7MfYPUVzyttRjKr1+fCZyQIEDHGdOw5Ab6o3u+fXu4i+JpssRaPA+TYh9ONVdDRwUKnwyCj9bsQLxLiM7VeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj9rqVQCNo5ZpAW2exUoHf2IL2rvhv/KYMOJ/LgeDMM=;
 b=nXbaEy8QL2SVZMMjCBGQAIoLJA2VPfu76assKoX6BNxbmwJmtdxA9BnAo2hAAAgRy64y+txTH6+lULSinNR76G8+8wLviyFSG3Lj4g6oRZV1cTBut5CDbjnCYfvcIaeXPrDDMRTnVm1BDNxYUunenGNljVa3i+jG3VEqG7aGaOuXEZ9E5eDeWfIBBhb3Fh67URrpiO5zcbcedavyd4eVN4tEiEL2L+CKGRPLEZm8wRJ4G1ewa31hL0h+qCipyhWUIXi70xkXBfUp2/YRmkgrarMELyhg9uWxWKBISLj+rVKHnyR73DjCRpJfWxr48pHMTwdSj8HVY1m4SXOMisjDwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6087.apcprd06.prod.outlook.com (2603:1096:101:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:53:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] clk: axm5516: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:03 +0800
Message-Id: <20230705065313.67043-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 834d2f7e-2c9c-4f29-e0cb-08db7d248a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlOrBhMZdcExNQ4+u3KJp1beEb44eiCdByBNJrmolnyqlSmKZk93RyzCVD9/G0tS7OZ5ou+DsL0/OeSI0nTnmb7yZPX/yZWmxFgJ2R2eKDzSwyPzt9u1JLLKUlftN7g1LsVh6k/uLQYZfCis3WLbdGukb5Ak/zqgu4V/dJmvDLG7gUwd9kojNqZ2tI2H/cFYpA62K+1HztTn01dSP4u0rzd713m9vr+k5rDaa9Yv/2om3BTdPATpE+YUDYTWR2QmWd39V4+wC9PBHn3M0WMu6RDIYlvhgUulu5F0wOY6tBPzXlbKchTPlfDBpRuWQ4TnRPpRQaeHtUxLeLzOK6xlINlFpavelfTZhr2W1g8GmX1Iot0Hx0j5r/q6NmqkYZKt1x+qWlCHC2wQ66xC+S5rf96U2kYS0QMFWHxzFhF20PxqkvC1UHbBHvV3XLSJNsTQjcJ/HrTagQ/ERG5uYp2H4+a4R2n06KFsFylLMmAZIZCNVyf7ASKhJm9l078tgUKBNoT/2FCWT2p9onCv6ItQeiBikNLmrVFrBPvlGp9qKolsubKYm6pEP/LyLCCqlj5A7C5XpkAk38y9uq1mKJPfdw5S4ysoa4umE9seEIlPXXRphUS2CmrWufNd3jnzRnQr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(41300700001)(38100700002)(4744005)(6666004)(52116002)(38350700002)(83380400001)(2616005)(186003)(6506007)(1076003)(6512007)(86362001)(6486002)(110136005)(316002)(478600001)(66946007)(36756003)(66556008)(66476007)(4326008)(8936002)(8676002)(26005)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+9bzcZFM6d9oN6szLYuoThFjXIuhiqTcQuHYhzuNjd+TTYnjwyGUnoZFd15n?=
 =?us-ascii?Q?IY33qvkrwr9tE6kPF3aDl17RuJdMeE316hwY3D9khmT5TZXK+TqM1hIIT3wj?=
 =?us-ascii?Q?ZoMAnYEgVWnhZtEYIliuh9Q7QORt1rOHbCvSJvgyYQ/KoY4qUWXxkpschMeM?=
 =?us-ascii?Q?saTz+T5abAbRI4VGv3XO5KXoaJNYCuOnOfNP0OSjK0Z9cj4DEpjgdhBBqxWJ?=
 =?us-ascii?Q?KOQwy/5nqmQB/riH67pMsOA8TgtOjQvqXIHnMltYS25vo9cO/u/WfqhJl+OP?=
 =?us-ascii?Q?K/YUWLi81k1mw77MEmtX8lVosexIq8zrKQIIyxfxqnxQVlUKGeiGxVh++hby?=
 =?us-ascii?Q?xsqR8NyqzP2nuU8a4JwKUb1XY5ihHXcfxnxKoy6EZgR1tkQmymFOJB6XblRS?=
 =?us-ascii?Q?OKTK9OG8J/nu633y89DlMXuoZVzFhlcwfWk0WwQuzoPFEL+kGuDtskaAXudX?=
 =?us-ascii?Q?ATY8nVJPiGAacvA7Hdd8cSG3+m+OF5SF+YeJOJmZYMo1XtUR2+teeBCcuL0Z?=
 =?us-ascii?Q?eIRwEi22H3HcIqIxxmVVgxz/+0gvgxR4wlANH6cDjFJJu5T7RdzgVgTthV7X?=
 =?us-ascii?Q?Slnlvv5OUp2CRA4gLHxP+wuJGHgwFsUJY0hv7BD0lGXh9+Mbv5+IwCx5tWCS?=
 =?us-ascii?Q?PBBQtV6Mkq0R/gZu/TaklNYGCLWRkh07dKxX4C6QlITIxUF1wNmX70OZkCNG?=
 =?us-ascii?Q?eIhh9wodxiELR2KdUurwOla2uim0VAAxunSMKWJ7wAyApe6VEGOYr7V5mjxF?=
 =?us-ascii?Q?LtdErVlmUEV0lzfrhrGTB7zXdSBNSYTKFJ9TuNAGa1fXXPU1T9v26KR7z5Wr?=
 =?us-ascii?Q?7Gg+j4skLNhsbBBQiO4nLu/CBPb4IZ/2u/A2R2MbuqIphIVfe+zkYioY+vme?=
 =?us-ascii?Q?FQ/p4YKVJH0ohbup3HNPFdM3/Wn6aI/rqxBt18xdofcEQa8YqY3JY3Ou10H/?=
 =?us-ascii?Q?CT03woWkteNnT1hYtpX8x7jfNoE4jn9r4z+30fxymt9VMvRPQc569awlH8NH?=
 =?us-ascii?Q?LsyJ3gcqtaa+ZS3zBVHL+TOCeVnDP+FY55GwNU6Nl8fNqNU3WgfH5MG94TVq?=
 =?us-ascii?Q?UBO35lXf5zI+GZ9VCWZn7dTt0ic46831IT0SjY3lA1ZYB7vgOyHFeSEsPyAg?=
 =?us-ascii?Q?KUxK28h38tPqbVstsiScLW8Bs+doRiakI4qfqP9Bgl9RdIq+zIRdb5unnG50?=
 =?us-ascii?Q?OtuVHacR2FwxX1If+MC9UZw5vrMQbuz36RzYt32pTNL73piu0zZDGkQqjbOQ?=
 =?us-ascii?Q?Hdz5Eonjg54PK0fbQPSIpo/w9yb4wlIkdBVxTCfmHWezhSTN7wrPixd81DYV?=
 =?us-ascii?Q?kIAoHW+UPmh8Y26eqy4Za1bPPSfVU661+cXfuokl5LgO+B7Pu51waf7KPTkb?=
 =?us-ascii?Q?6ue4Z4tDLP2rUPEUYmunKZIVGso/4ivvg2nkiJFYgxi5etl+HISnfJCa4SzY?=
 =?us-ascii?Q?f/986PISL6u8d+rQnJNh5feN45H4AcI1pH6s6bvvWucIA6JML1E0IjGzQEHq?=
 =?us-ascii?Q?Vdk5GRCFx8dTgkkVHYQMCoCoXvHzKW0RiegwtJvFuNWVgx02hJPpgPp3tg3W?=
 =?us-ascii?Q?nz/nfv7NrXMTe4a1efnfH0cALv4B6JvBvAVyhUK2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834d2f7e-2c9c-4f29-e0cb-08db7d248a16
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:29.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8aLgJXWKSEk0/0Szoy7zHf/Wi70y6EomHmtYx0p+03C0CLKE7ugpXOEiC1Pm++2lRgp1TspnpNY89lI56VF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/clk/clk-axm5516.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-axm5516.c b/drivers/clk/clk-axm5516.c
index 1afcfdf2e6f9..4a3462ee8f3e 100644
--- a/drivers/clk/clk-axm5516.c
+++ b/drivers/clk/clk-axm5516.c
@@ -541,14 +541,12 @@ MODULE_DEVICE_TABLE(of, axmclk_match_table);
 static int axmclk_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
-	struct resource *res;
 	int i, ret;
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	size_t num_clks;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

