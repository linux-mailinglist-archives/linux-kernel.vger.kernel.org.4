Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E57747D99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGEGys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjGEGyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA351725;
        Tue,  4 Jul 2023 23:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNX+RK0aNLct8rn6KvNxSJixyyr+EIQxePmfoYP8MxNpBOE/OVb/8kPDCtq897pAHzLSqJsc6ieSxlT7+wwZeKSoPYTMByuHOcHXGdpI4VXTUPzfYWxeoLXEHVEPA0X9t37mpmpAa6eWE+9/le6QBaZMTUKX4E/5pj9jTpvzH0efOXns7/3ZllK/AkDK0VHWcS+sQGdPNPuEZItWEgp7a9mXKb9z1FVvazE5/oiMUzT/kmvXa/gLrInkdsNrh6MsZpUuXbBFl4ZCRJyxR9iDNHkzBlhQ+zP7JaDCb7BM8JvAQmMWKL804AWFZslM3rJwkfONdNROO/rsAlbUgsUtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzfS3PCYSF/HiIVWqi7j0l6EPa4d4rcpxaVuQqonWG8=;
 b=MlAiF2mZs701cDGxCoAgEhQBh6iNfCh1vulDtjsgUaPYSEOg/smq8TKvGvCOEEeQn/Awrl5K+2fKMc0rM30c1fVjW7mtNe3KYIS062Q0xI1LUfZVdy0LHKomXDzraQ9T7bW3m9rXEzS+096mdhTZAq+2/fxD61SJnZZb8JqMn+tk1ZHjJu0whbPw/qrdGTKdnxJJIR3pf2AVmjaeU2Q1Eoid+Jsinjapwx+V34sfTIeyxaW80ISSVKXaASTw3KjvSR0mBp9vGVhpzB2LBVn1mFV9LQ4VoMiQdvSJQUh7YS7qT8SYkAZnMyWvcs+VW9dxseBZr9p6UGkutGihBk1ClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzfS3PCYSF/HiIVWqi7j0l6EPa4d4rcpxaVuQqonWG8=;
 b=q0Nh2sl3i8OSTWOwErU6DpXYV4Rmtu4RArjyu2PNyFzX8Lfwaot8G/36BOfmN7Op5jRMC9eQmHLt8taKxctxPdgK5dp0ug4WsV7JFqHlF3siEaM3mNLo0jnrlWs7LS/HtibxBmykk++aUhyyHzCXqEntLG3KMR5oIb0qSRbCQi/CjsfjKHpF17/0t2cCodOKAtCZkY/nMiXi3W/gP671J8sUsZq3XGsiMDODtz4xHDpbrIepYMot8BPWBmWdKI5pVlnYN50dK5CD7XjYcPQ9SavDz4xnUYiHWzMMoE+fvg71StqGQ0jhdXFUoSY9O9Upl37obm15MzSuL9KHxdP8vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:53:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] clk: ti: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:10 +0800
Message-Id: <20230705065313.67043-10-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 34baa21e-9208-4949-4ce4-08db7d249377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+wqAfNorDAhqcoVNHiQTl5wEN8ekyBgwZCJaBd8f8ZURgnHq7vM1n8RyrcneFMiuIf/5v1TFS9W/d84tQg5BXGl6KwWBvBoWC4loDv1YQVUckHtDDav95sWwD8oons0kIBDrfl5jaDosafZxRD26qxHVHIwpdVZxyQKnQ80YavbWkVwmsy1HHvI/o0862ygdb5nIS3aWfOQHh9/LTg86NjGu5Qe0VF6aldFMhOjpbhiRU8Spk5a3riysix8/0HTuhMoXxSeh+4EU8SYzMqRvj0fBG5opaIR+So7v9wMG/8lAjE1WNim/DQr1qmpmylplmeUM50Oxl5RCnhwTUi4yvlQq82q9JZMmIR+OkyrDCJJi/SHby6GQVsx7hB2vLt+/MUvF6Lk19vaZFHXLD1e02uUv78W90+aeltEM89uUkyQoZHa1e1eDlgSNibZFmf3+14LPsD1j1EIu0wlKxJc8ahRdKWLX1E8jKAB+hNpHVt2bmgxw23GxnvS6qQLZVqj7XojVcpBtBWVbP/67s3etrIZh7VoPP2MLn2xoHu8Xa6KhhGzi9eUSltq2k0kbd2bJATnIUEwjSQi6dSMVg88HYMDrsh+Kcu6XGHesVViMNIMXXDP/xQqj8K91lq72JZb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(4744005)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Cp2jr052hVAHTXgqBh5Q9OWpEUIbPxZ4ccsLWvCt9fAI6/VNa7C/6BUHGUI?=
 =?us-ascii?Q?0z8kj9GXgCcTbQgJWOQXPZjnw+Wm+eCag21pHNsrwXC5SeGv+noQKAQ01loz?=
 =?us-ascii?Q?0U1ScQyviaREOf1AvZHrR9ClOez0nRwh/obxi2Apw0R/4xJfH9TWZ4BNiqs4?=
 =?us-ascii?Q?2x/Ev99SADtnofcXHaWbhFWzb3ybHoN06JtEzh1Fhsne/SUW6vNPvNW+dihO?=
 =?us-ascii?Q?dfXbwJleyiSbfdw8p4ewplU2LvpCqwwNit9fNm1RB2rEAxMxAHxftZuzo+kh?=
 =?us-ascii?Q?ArX3rfVlweyDRrs9N5D+5UmwkvLVd66Nc9O8OwYwlDM1K4MiKYKlj75Um3iH?=
 =?us-ascii?Q?LNe3QS3VwzGfAAf/iVHpa1jh8owHdW7SsT21a6cktnBy0ukzZ1rx3zGSxEDT?=
 =?us-ascii?Q?nSWTPqfQIVCrghJW3SBNUR2cILxxZsDg/cR4sWbvwcD+9aVQoUGgQ6nIHPJj?=
 =?us-ascii?Q?KqvKOlRd6DtyPqnyfEkEgvvq9GGIrhzdUaD488rvcgsDFPVIjf7vPqzwteyO?=
 =?us-ascii?Q?C5CQb6tSsAz9AKRx80iSTa3RhkgE+w7seiTottgcYUatVkQvygrr2VjTmxaC?=
 =?us-ascii?Q?VWVK2GN6zGUzQuOkUAg9mDLnM8tOqgWtbNrwTI3jGX8QGp27Vn10D563y0ba?=
 =?us-ascii?Q?he7DBYrt8E5eKs/LbehmyWQqRjBOjWnSepuNioGJ9pgUUvhd3tmE/ScHRc63?=
 =?us-ascii?Q?byKpJ+hQses66t2M529/i+MhnbDOLQMEHUvsMqe34CqYAzwbaLUchvFqMU0c?=
 =?us-ascii?Q?ClGfPigC7TiGNv94DWWJtrBrXkKKfNNf7G15HKa9Yf+awtJyIyGBWc+o8yVu?=
 =?us-ascii?Q?mqqNCiRUXekJ/4JUnjIiJMERjj7Jxt2UWSN/6vMgj515TC+0eOxiK9CPXUbF?=
 =?us-ascii?Q?B52GG4CB7MckDgXMw3HVIP01OxWO1D5tmgZsog4OKqEBb9alBZsJNR/V3IJn?=
 =?us-ascii?Q?2CYsly5iVf+1fagD8pt4jonCWtog47cMHv4XLRCo4hIF3ego8KiWwn7W0Ftg?=
 =?us-ascii?Q?E4Aix8KMT7GM4iHDKisiamuUN2Db8SUAO1InzZdXYiQ3t7AnsTM4beRXaTD0?=
 =?us-ascii?Q?46HUIeLZgOa+d6xYwSzNIGD7e6uykxPnK87L1FvAnZ1h2eqFHgJibUBLFm0T?=
 =?us-ascii?Q?BT8Kh312VmjUpQ6CyRcUiYbp5mmZ8rCCjZXo6eYV02fxBHUtgdo3gN+CnJ3h?=
 =?us-ascii?Q?nnYn+uqbaaJcbX3PefsFnwdHYsDTob7QDZO6wyUwbJkzZgfTqSCCWOvcahcX?=
 =?us-ascii?Q?xK13FnIlehgJueOev56ZXgsMcAGA652NIQt790S30eMm+7kETfj9OIRSsGVc?=
 =?us-ascii?Q?mcM+fSTfHT3jdniDIVadqBmHWOeiHsGELSFpL7WE/+9J9toBtea/FSec6d54?=
 =?us-ascii?Q?KELymXycfCcvzYntlWLys7s1ZeMY5P6k996NttQAoZUHBsWy9/2XjbvDqxN8?=
 =?us-ascii?Q?UnCaJfyATnVTg6cAtR1KEQNdAoEYhrN7TRLW1W4dniBOfI4LeGACZhdSST/D?=
 =?us-ascii?Q?3kKT0c6aZvFXjDo0kFGymMRBriFsRAoHQfUNK80IWE1R1jemxFz25sOt/5v9?=
 =?us-ascii?Q?9kvpmww3SJEUZ+y55SSqaA1jsjcQlH5CpWUpn1Ni?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34baa21e-9208-4949-4ce4-08db7d249377
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:45.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR6++G0mm18LDGmJ/ej1HiHXiGHnNxiXi5ZYr1+muNV+3Apv9hQ7odYXbx48cGFgjK6skxHOwNCNehadaXnTuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/ti/adpll.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index 6ecbba4342c5..ff42ea75cb43 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -881,14 +881,10 @@ static int ti_adpll_probe(struct platform_device *pdev)
 	dev_set_drvdata(d->dev, d);
 	spin_lock_init(&d->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-	d->pa = res->start;
-
-	d->iobase = devm_ioremap_resource(dev, res);
+	d->iobase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(d->iobase))
 		return PTR_ERR(d->iobase);
+	d->pa = res->start;
 
 	err = ti_adpll_init_registers(d);
 	if (err)
-- 
2.39.0

