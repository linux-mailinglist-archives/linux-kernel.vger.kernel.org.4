Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCEA747D90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGEGyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjGEGyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D701701;
        Tue,  4 Jul 2023 23:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke6P1GXbV3kqBT9lHkP3w83j6bBXNWlS0rEh79ayKXedPLwv1Zx+HNw9xMA/hu0n4MczRYfOdsPkuDewscXZ18Z1MSOqXfcobvUcP5/ZfQZja6lp9/sYXdefA6jPoX2w56BXzqByFznNlIwcltz/MTrsQF+OO/MewQDx763Ky7glgYPPqAlMLJXptfEuEZNj5WPey/Yh6x3/Q9575yWONu+nFuLbPbE1/3bnr094F4oIfFEFRARVPKhan3gPqFIzAiQbNHRJV3YrF2myiqmIHmDHdhbfSHryF8tyPAG/64D8xTnOSuyy0zpGzL6Ips3owfSZO2pSmSB0r/sUFeqBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KnpWChdqS1whmGKWMazl9/oJ2x23VzOQ2vXpsgMdXk=;
 b=l+3x6U9esH+Hdn4LVvzD60wmToF0diCkazgdHDHsLxnfxTQSgqTjdIP7shTeduzzqACa8/ilJIwj9hD7Y8EwODUzMRYhNKN54NQ7reIe72jQpc9EOf73Z03WAzKrI/0NxIw1nBRs2ICsQ8Db2fvg43l6Gih/DXOkeFkW/FICQ7dOQliqidwTQ4LkyiTUPM0n8Sne8qBUYUQ3KzAWXwzD12HVrPv97AAUwwNFSj9F0HsXtwyyqbHzt5f3Q4vQMKnwIEEfbONz90NqRizY+xaLkn14wNsTU/1ffaMfW2RLqottbv8gPpk4X/nRzvhg2aNYgzotErXblG8bNSHEi1mfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KnpWChdqS1whmGKWMazl9/oJ2x23VzOQ2vXpsgMdXk=;
 b=N6enRGDI5Q9N+R0S25VqmSWZ3900fXdylc1WOyiF2tIJFYkQvSRQhPuhVJ27dFru9SpGBQF2ZwSVjHL+MyEZHl5RtoMhbLDFgHFYWBoVdeNeA0v8b9LT6dHm9NBI+o2h4cupnU/+O8JwWrYQfVN060/WARFjO01CKWwWz00zaGLenyXUdOTlou1JKiLuu6Mz3XaILWMrpZ5KcfNkVEphnMcNHmRxckEcu4qe0+RvSRILv5J+ZkJMKxfQfURnfpoeiHjMVb1s9Or7zerSEIYlkpc8YFWRbAeW8QvMJea+DXya9C/SeYN6k7HGjG9/Frj1gJmWs+rBINRcHJsTR4wuYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:53:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] clk: imx: clk-imx8qxp-lpcg: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:08 +0800
Message-Id: <20230705065313.67043-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 180c99a2-8557-4237-e080-08db7d24909d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: px9P2722ZWtpmv8X9et0zhR+ybIQuBX2vA9yJ+MqWUycBDnci74akqh0mHbRPgYhRCBECzrEuZtWU7oQX5ImDUNHa1jLGEG62AS/BUYq+K89JyR0gXsIZSPgRRYpDF2Sz37HUSvAG0HLSFRXVqaHGzphCDoPw02xrU/NtT6EDxO4TpLnD3Kuaxo0LN7y0ZiH/fhhg9brsW4C3tDgpiQGjfiwoAL4vuBEaGMcCnvueK3Qq6Ga7xZ+aeR6JZ7mGb8mhICwVKXTh0lQwzgIUyBZ+8Axvb1NRlXXGxAhb1DZzUklIx7tWNoAiqkV5I+JnXGINDAsjsDSn7kXfedXaHB17+TF2Q0k4sz+0/ppJnj/6884281t5AJMv46SO6aAE4prvD7ODVT8GJ8EWEOEgAQK4mKKRqftAFx1TKHmMqSlsGfOMqVH0QTunfyYYZJOmlfzS9edqAx10DVwomiDU5mdENyfpyYddRBkvsP1no4kNnWZvJyQVhwODGG3LFVgL1bWSFSrEzFJKYXy8eQrMARO4A/ThZkWpjQEA2WzboCne5IHFZZjy9HEsoRLgK7BnoKI35xBKUUT8q5XtkX0MwL3/33a4fKwnw32BkLPUOftJ+ikSpA9eIQ1qaUM7nhj69Fi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(8936002)(7416002)(8676002)(110136005)(36756003)(6486002)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVpe1W47j+LcN/koSW8ttFUDTL1kurGkwEcn/4wSUpyXcQTMiVMac5iteuoN?=
 =?us-ascii?Q?8FCtjn52845aBMn/DfykOsU6plkkSTBGSWIkBoCs0ZHru9nGW+/IqrrE7OD5?=
 =?us-ascii?Q?8qgNAjHUO+V8sMinENPm9af7I+i++OmB+uicp+s/BGhpdalt7+lKQF6MJz5T?=
 =?us-ascii?Q?3OXAfXTZjjnqLrDHYwCArpm20YckfRmkyd3TJ6EJTWJTJ4Z1ENbXi94JJLfa?=
 =?us-ascii?Q?iRNdkfI00Bzbo6uUiUpZBrSmt3j8TaYcBR7OTJwOAgAR5y7HNH3nlcon+gmf?=
 =?us-ascii?Q?R/mc0KUpiY86ZWaEfxJLE2p1wW56l7FliTAMEfRQbGUr/Dx124ED+UnnSqxQ?=
 =?us-ascii?Q?TZ2QXifxnGtWsIwlEx7Kw1prakUe/esQ57F8Nd3nwqTJeKByLOyOUgnftFwf?=
 =?us-ascii?Q?rg9s0ENQ2Y54pUQT2Uj7IzmDGOigOBuBg7uGNmM7HAzb6LI0H11CBvU19m13?=
 =?us-ascii?Q?0nzVqk3Ayu6dDFobVvRpTOCOs0rdJLa+9tf0oIA5YtYJQPkZCxdPPsGfSN9d?=
 =?us-ascii?Q?5jVjXRqO1smxhc7sfpDdEHPoH6opcv2TYFfmlb5UU+IDiDbTICQwO2XiFsCm?=
 =?us-ascii?Q?BzY1e8Ji6sysaId/YqSgxIl4cw21q9VGa5V5CicZDzZgfKs4i2aJq3i6p21M?=
 =?us-ascii?Q?5n2k6cPnosEdfc6EUk2K543N/0tDMiC9maNMOGoAv6e+vD9Sj9eqaRxxtFjj?=
 =?us-ascii?Q?UrfvyzMdk0/iEvZyz5weFGY4mgEICjL1N9N6h8NtYFUKJa/I1bh2mIIsjkv4?=
 =?us-ascii?Q?R1DaKLksXG2qO982hCZcQCHdDWBV7LcdaKiLPd/g7Hd6qjou6iUp2hOe+lBJ?=
 =?us-ascii?Q?fKzGKLQpxz7oRnH2zujuEU0sk3XsPw/i8XSIYM1C5hWdY/0r4BBli/0t/u1b?=
 =?us-ascii?Q?l3x0tPCVORTlvyi53Ev/7R5LCsl45BCpoyp6vR70j4UQtOW8NozU76fWlY8p?=
 =?us-ascii?Q?kEoar2zr4EV50cfCQ8agItrP39XFTaNHYu0hW319F3yZVyQxg1hlqrfpKYUr?=
 =?us-ascii?Q?HbWdrDsbzgxkfJDDTZDo2l2ow9sVYcE4AcmMkK9qnRSuJZBLNjKzGFbba5/t?=
 =?us-ascii?Q?wV9FiqicgRCoS5wPFTzr2smzLCz3bzss9YiS9v3+nfeA8PMSUrhlnynzv1L7?=
 =?us-ascii?Q?IHLMUnx/V2kl9prMKGNZ6QWManh8Nu3pSp0aN55VxYAkRI+yvBeJm0Q1OYBS?=
 =?us-ascii?Q?VeFTlHNXG3kJ0VK8Z8KPWPpafw7wtg2kQU8Mb3RLQUr9DBhjyo2840ROUqpC?=
 =?us-ascii?Q?YMvvkyrS84KF9FlPjgEkr5qZUVwumvO3rQGSSMmbo55tcLRKRnpJDgTBAEqU?=
 =?us-ascii?Q?NtaVQHAm+pRhOxSS4NQVnDmq98PhMf06sSEGZ32s0E5MZCMGCLxb7C4YMz2j?=
 =?us-ascii?Q?CHs8phFeDMcsa18Z53qttNNigQJYAAesrkFyKeApNKZFdu67US3NgVUCfIUO?=
 =?us-ascii?Q?GsLZvgeo9dY+AK4NNkljueTCXIWq+lqdGPhh9k1iCqVg9CmyOYUG7sOoXukP?=
 =?us-ascii?Q?9UiOy6CCUv5otowuK9uOya9EcPFLYkGRx788vH0V2MqANn/mFnPbMPkJ0/nq?=
 =?us-ascii?Q?EPYYWZDDqEwoJ6uaoi00r9gpVfQxQ4WssJE184IT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180c99a2-8557-4237-e080-08db7d24909d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:40.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm2gNPC636meavFAOW1dUyYCg+KQfaNl8RRG7+/J6YO7LEyzcwPKdRSK6QtbL7RTyrmTQE/7Du2YRl1+iBPUSw==
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

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index 5e31a6a24b3a..e0ee9a2572d0 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -183,7 +183,6 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
 	unsigned int bit_offset[IMX_LPCG_MAX_CLKS];
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw **clk_hws;
-	struct resource *res;
 	void __iomem *base;
 	int count;
 	int idx;
@@ -193,8 +192,7 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
 	if (!of_device_is_compatible(np, "fsl,imx8qxp-lpcg"))
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

