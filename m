Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B171E73DF96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFZMoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjFZMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:44:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A51AB;
        Mon, 26 Jun 2023 05:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcVSkrTeoFGLfdhFmEF9DKV7ezdkGk6qxGYpBPFsa7LZ4h1EP+6GO7ltQErOyWKsuHM04EZE8VY5eDrCUEZePS/j9nsjKEamF0pXzFKH44Naibu6P2oMAb1W/se72fHzlGTadscenY22BrsO+jWzzZoOO0D7xWB6pALPzdL63x9dUhVXhu8IaWGJIzIards0QWUMXfKcJFsljLpbiZhEmBgekJwOJ1zhhxyF9QlKnlplv7AE+4rvh00qWptivO420WgC+vxkjVUxcO9YNQ+TWqUMelyHL2DcRt8XI2lfWVb7AjNZzkpbv3jPP/ibi+8gEjTojP3HbnS2aGRomJV1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI00eUvuJ3p1dpdEmTbYMMg6JzFYG8FVxweSUEdPXms=;
 b=CtkAxYDl2q+e7ZJwbl1Qdxid6RfjKE5mmU5hVL+ChPwNMxSvOzQtQ75Rty/meIs1aX/uIJWxgj58JqPrQc+nXroyDZyOiXrYtVOjsx2xeUilVA0xkN/65pfi3FQnEhvqcqYe3BRki/10juS+JV/B9jkoZqAFBBiq4UzpfrVWmfYRZtVz3tekBGOdNWiAlOG2XeZ0/rjR30s5D8yfUHo5t/plfpsHRhcFP828XYQPq8bmGsFfH7RDCRANbjjPxMZX7vUOoj4s3nR6pdAz3wZhc9lqtrUPbE1r4bs4KFYRtExtqNy9p3ImVgMRL1maslC/Sz2sXjU1a+slOSkfrf+jTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI00eUvuJ3p1dpdEmTbYMMg6JzFYG8FVxweSUEdPXms=;
 b=R9My/m3LK9j9AfrEhFvIhc78ZvUC5Ds6ulPfAJ9cASCY2Fx+Vv+AIPyyY/U5zAwXqxSyJON4kBpQ5aJ0j2BAco0LAuaDAh/Ng/q2HyWhC2XkVrjDYAatktdHBlzJyQlbQgTeDNLklhwSZnb126XPlibyhsfxhSBm/LueX5wohIIErX30nQl/Wcz5pnkdyuZvqmt1VrM4ZbkSQlgBw/r4Zqd9AXaIqfM3j9DAb14/84rdxCJsfk1zt/Q2e4iNF6GVA3jhS1gd0TtfkywE6tVajIioSalpyTgFY7a8cp9NlxvmeRiuufJ+g4mGBeMy2XwuNX4dqPanPgD+hfFXtA6cpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5320.apcprd06.prod.outlook.com (2603:1096:101:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 12:44:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:44:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] drivers/thermal/ti-soc-thermal: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 26 Jun 2023 20:43:33 +0800
Message-Id: <20230626124334.15100-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8cfa6f25-9ac1-4d58-0f00-08db764307f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZ6O/rVxIFaY41fZOmaXvKk2UHMFUSLdydSDJOa82cc/0yHm5d2t27QhtJWDHfdM5CxrXCp8AaPq8bYCUDHcE7622svmODnaT6fS9tX189u0O2YpQ/TzdspuwKvgVIjf97RJKyuYkA4Qf/lsAL+6Lx6WBSxVhycho0WZbpJ76BygHlBM0Mch+CcKdSXypBp/UgHrPYdbZI+qikkHrZMAlB02AE7lN9s73SwO8HiGNzjPZa1XGCJ8s8geRDww2r/t7J97bwbin3Qz/YGYLJnXicSH5V/poQDMk27B/rhj2JT2eOmgB0t054G40AEq9waOp8ErI2+4kxc/dBmoM8+gqw1TPS/O7RJvklvZC6m0fPOyaYvv/o4UNMfhBrtR7oUMXMOkoYSNj9VhSAkParHzdjjIfoQxXjkx4lvdl/7mjgriwMzoe+iZvMbQ2EnN76n3zO9nx8K2yhFqAx0bVzMX0i7LP+AKyHpILzy1Jux4oeWLJ2zJm3QpryywELcSgMT9cRkive+uGlYib8x5GqLtv8Dv3I1S0HcDx/s7RAapd2jgTbJRqKBPKG3pId3pFYXI76fYm9BSuVPzrMxsYFhPddLA2cMHMwWmaCDLOkUUfG3X9vGxXp3LT2Zz80T6TIF2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(2906002)(4744005)(6486002)(52116002)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(6512007)(26005)(186003)(41300700001)(110136005)(86362001)(478600001)(36756003)(66476007)(66556008)(4326008)(66946007)(316002)(6506007)(1076003)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbCsAraBX2rsdlfCI1w9+746zrqaBfFwB9rwvnZqddVNAnSyYs+BFLgeENJ3?=
 =?us-ascii?Q?DdJA60hj2nOXLyByeS8/4nzb30kHIgKrVky7oLpbV+HZrbyKQSvvzyj4RuN5?=
 =?us-ascii?Q?Kq5MxmUntLbQhayPRMicKp6n8B1ypIgA3RuQPZG7CPDkNOxM6YH35SvuJIr+?=
 =?us-ascii?Q?/HJ6QsHwGCSDZV2QpammqttmeqhLpYuJpWwbpCT8p5hkFoJh8hbd+qEBWzzY?=
 =?us-ascii?Q?b0jepYdQWBOfrJsgvms7dYNcBGubE0RFWUhngMVv57QY3ecmwG6KmJX+0sg6?=
 =?us-ascii?Q?3xDJIAhfqjBVhRDsMRl5XfMJ7CUCwzVyI472v28tQFwQsWIoto4IaV56nOZ7?=
 =?us-ascii?Q?rU+LAP7MahYvQUmTS3UPAxly+c4BVECXHnd0oTwp7c9B4qMS2NaXeikzBZ9N?=
 =?us-ascii?Q?QFOYroN41gUr2Cs8e8qOeYuYzY6YVHT+h1fXPOI0HGEE3icywnr5MTmC1xl1?=
 =?us-ascii?Q?l739P4m1yWWdyTTqoHzx9o1TTYwoXlJ220Q39IUVbNMd+w1F8ts3dX9jHtTK?=
 =?us-ascii?Q?fV1Y1eR49JFHtkXas9+7x4Ktyo/eaMIOjEx+dwe+d58XHfS6pPBfqKxgwoQR?=
 =?us-ascii?Q?0i2Dm5yH/yKm6x4da57n2+aY3ZojokYvtyh0XCkUx33mzRqEz0g1A292lcMj?=
 =?us-ascii?Q?YM5MRWAnRASUBNxMrMQdTfTZgJmZ2IuoxzHzirPWmhOIftswk/HhmTjIwfwh?=
 =?us-ascii?Q?HNr1WjHhWnymh6ia2YlZqudGxLpoOcyy57cOmrlVKp8UDm0zBjCHT+uscQWz?=
 =?us-ascii?Q?DUnRoQ5L1+IoPv7YyQ7U5w23pZ2bz5M8TNYAGJeLLPOvWZZLpgXRe77o6GRv?=
 =?us-ascii?Q?UouA64CBle8tC8v+bfeHexXCTK9/ueGIuFkdkOAGbwKgylw2Uz1P0ntJ/Cua?=
 =?us-ascii?Q?9u8dR/2rmIHmOHbW0YWI9RQM5kii/Xja75w2FbiDJ4xzMRO0A6ca7oLMHvBS?=
 =?us-ascii?Q?3kX7cAaxLqa6lLLjzuqIPJq80jQJWVkke64VwUi7Mq2ZbzLZyZaBVZ0rHqji?=
 =?us-ascii?Q?qoFWhwap1b0mSxsT7QjamHXcETgwYPZD7H3lfYPF/sE3Q9H29I0nnCiy7jZq?=
 =?us-ascii?Q?KDInZH/4xEoElvn+kLXVXiJxGdInxNTbn3UAMcYt9kXT5CDCzYZ5t2yPL5it?=
 =?us-ascii?Q?PeWa9DYcP+vtmOs26r+foQhySzTzkU9JFqVrM877U9wPsQoJyguBlkOR581g?=
 =?us-ascii?Q?fwQFBXC9/UQVvoE0o2b26+DeBHTg3l0bmkVHrWLAlpGARCU9H26Je5tecJYU?=
 =?us-ascii?Q?iB791TOSvytLUcwI17dnhDV+h+3U7rJ38rGrfcynGFxyoGKOPxGzEgPwuWUJ?=
 =?us-ascii?Q?wgzRwVDIxQNUqKKtUMk3KBReYMys89LbPDuWSDatrS/yaqHEgiQA7hF0T5B1?=
 =?us-ascii?Q?tJdTPwLfVCWDS2RJNbVh3kzgUlTM+3T+TGK1d1CwDAqoDuS01fzqaODrRER2?=
 =?us-ascii?Q?wAbR8WfGAuBFiQbnv2HGfKpl2DGa6X7orBdQXz9g+/6ImYNJpNkdd0kk3j6p?=
 =?us-ascii?Q?D9OpplWfQrp4wibeAH/4NHXWEIui/urPHtaLYbjO03yaRRInJ1uSjro9sEFp?=
 =?us-ascii?Q?1MSCFq/oFlRFtxn9eDLSXSbaP5OxHTeQJLtTBmAb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfa6f25-9ac1-4d58-0f00-08db764307f6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:44:07.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7StTcf7TNJpn28jfsWCaUIFsXmKjo0+iCQ7FnVOK7wx38wtCHKhq4xFQvsEmb4HL/rbullCuq/TUIp47NDTLQ==
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

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index a1c9a1530183..0066b9150920 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -847,10 +847,9 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
 	do {
 		void __iomem *chunk;
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		chunk = devm_platform_get_and_ioremap_resource(pdev, i, &res);
 		if (!res)
 			break;
-		chunk = devm_ioremap_resource(&pdev->dev, res);
 		if (i == 0)
 			bgp->base = chunk;
 		if (IS_ERR(chunk))
-- 
2.39.0

