Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31646D17AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCaGm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCaGmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:42:53 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F861A46B;
        Thu, 30 Mar 2023 23:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE4kU8/mVMIeMiXsqYgjsdAoJnjw/IMrwfKpzlq47/2FzNqaHrikF5SVWm8e7Jx6Ih+y5Rqzglte1gnTW5OdUiFFwYlpC2QWBix1Siw/sZFYXbhnLj+eIH6r4C/kWd4lUt607K6Py3fWPenNHBUhUYfRJpS3+XU9YxHoX6wB6m9jBiEdzdMmWam6NND4yZWDnAl/lokNaiuUPS7Rcluj+I8x+oGhTs2sGfKmoPx0bFTCB0TVzrFSLu4K73vA8i/5rS3xQAjYGC3Mv0+y9FRYCDySQ1xv0Q78nbCY5KEmA+4j/qZmQtzV4SDDuiTB4vLhj5YHjduuGjcdGi46SIerrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6oPcZghug/ZEgcY1WbIheuHW9mGDyQAqRqQya5i1s0=;
 b=Ae2UBeknkhNA4MEoVRrS9pZQKgw/Fx1FOsHG3EYj1XLBhBidMTYY3UBoKk9JbiyT27RmaLx1r1Jk2JgxRlDpwRUsGOXK5K9Fa43vF1UUKd5hY8ulf5uPapWcgzPLzLDRcRoKb+PLUMNUpgACdKLpGHdcSI5YTnNEhoKEtjI+H5KRch0W9wbhp70dS8pm44SuXRWZmTM7UFdq/n1E9Xl7/xmH5TW6p1b+31vejYL3i5Pb2tUYTM2E1txK1yKNI5xh6ifREZC4I1/T+3pEDpSuD5GVjjL6XA4mYj4JaMgVoVbGoDYgKFXe8bE2xgPHRfR2bb08D49I1EWY+nqT3GGphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6oPcZghug/ZEgcY1WbIheuHW9mGDyQAqRqQya5i1s0=;
 b=MQANq5BMXfvje93cqHr5LdyBHGwAY47fMIA4m4wQM4aTmCdjyYxtoKuTrzScPHZMkbBv4I9fQ5g7pNM8+heBiZCOZCkYaTpuSHWU4bA7wUWqjI/F05PI2it5FIAReg0gBCuJf/lCpZyituxsWkgPbyFvezjDbNTh7Q+bnpLKgWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 06:41:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:41:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/6] clk: imx: Add 300MHz freq support for imx9 pll
Date:   Fri, 31 Mar 2023 14:46:29 +0800
Message-Id: <20230331064629.2475338-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
References: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e40b98-a0a7-4c02-a999-08db31b3043e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vCu9qwvvM1/ilcxRvXb2ioe+eVmLHjyRIkpq1jrj7v/h165qU7e6hSpUyjCjqgyQbVMDDknH3RPj6XObsd4CCB4/2YvqSOnGbElYO91OtAhPa75sdYhGtWg8AxKzze7j6d2G/rTesFP9dWz+9W6uEcEo0kdaBZSaMBJggcCAgfKbnsM1Glim9xVGhsD5FLIqzwTJPT5mYtI8ghGUhVE1PRd3RxSbt/sG7oRFpJGC/4VYZX1nb+ArCEWymV3ajOfTJcvK2piHO4Mq6tolEt8h9WZj6ySf4BoCmiptwQT8RHv5pPd6kagbWS3rxaeFJV8+DJjPflg9SeM4N/QBw/Zab4Id+BsdohLy+ExSI4aXbx2UAS/yKXe39BZwgRA57r8faFczDSeCR4bVhteiHdmjiXz+u58x/3FlCDbJSIPwmmlWtkCdStnPK3VgXaE2VRkxErhe4xY2B2M8Evcw9/A4zdjTw/OUVdlPg975wL5dyfyaWGe4yOSaMJl/QjECLzAmp8hi1bIdpDocJY1RcElqCLS8/szyUNwVDL4UUCM8WLpx1DjEyS4RfZTtDsF5BIk2MyFvzOhvm9s9xTzHgGQ0USXg/Uae4SOLkz1+HuSaySr69PdBA2YeR8gqkUnG8Cf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2616005)(2906002)(4744005)(4326008)(38350700002)(38100700002)(41300700001)(83380400001)(86362001)(8936002)(66946007)(66556008)(6506007)(26005)(1076003)(186003)(6512007)(66476007)(8676002)(316002)(5660300002)(54906003)(6666004)(7416002)(52116002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jzPe1lygDvofp8Mdnlat8ldFzZYsmj2WPXDf7nPIzbkgs635a07h0BXHRQSi?=
 =?us-ascii?Q?MiecCC+o1mSMns5S77U9RPUCMSyhIoh8+EDvyZN5V2hk7sPidiFHkAzRcPto?=
 =?us-ascii?Q?fMqnXGMrm38HgNXJI+smOExx3HqsFcB2e3graH9XdhyOeLfXanbqqQMyZniz?=
 =?us-ascii?Q?anXy7cdC6IbmidV3robwiOus6GRMjdtNNT+78+cHjZ7uzJuNP6RVB2wnEcA+?=
 =?us-ascii?Q?eRXRrGELhPz5KlB4X7HDpe5iOwZV1h3AgsbG3XVnmXcvourZ+NiXmU3GPkie?=
 =?us-ascii?Q?MBMwQxr//tPv35T7a3PeF/ClgThBkf9Po8nmiTk4oxwT4GhMeMCWU67it2po?=
 =?us-ascii?Q?DWEvcZtXIOLQ2mLX3CS2mlcP0Y+M1sOVYb1cXA0COEr2kI6Wvfnxe5rRGwDG?=
 =?us-ascii?Q?0xzSfA0sxfQdYYhS5vwkJE8vJKk8MJl3AoinDNCxAJldt9tAg7WaFiXFjKfZ?=
 =?us-ascii?Q?Y4FjtsyLWPw4VrA3A5EILlL41tHG/Qwl1FoUcB3U//DFN82BlhshJXug4URl?=
 =?us-ascii?Q?VDTHzuV6Bzxv2NH4TBcwaB1EEZq48E9lw+TP9D5SEJNGQ2rm0XTK7ccEQJqD?=
 =?us-ascii?Q?kmL374BGMVF3GAoDAU6OcWW1YIQ7Upbw26rgN2vVVNqfL+YZMgDQnOWmb7R2?=
 =?us-ascii?Q?IfxGPU8CPI2A8ODuS0WfNBHvENSz//NKvYgCsBqmxe9Qvx/axxqKl2H7GW/b?=
 =?us-ascii?Q?k/W90AZkXs/CRyZUI/+xhOEIrx3/s05A7zUJkQmxMbizu3wIITSWbaN0mM7R?=
 =?us-ascii?Q?xt4NAm4DUq2Di5JqwsrYysDRCFcSEf4Qzacc7NcENYF/z+FMXzJSStTce68l?=
 =?us-ascii?Q?H9/7NudzSWEST+xzemgreLWlSb6YRiEqA1/br3s71HitVxCLgBtdOIWWVB2a?=
 =?us-ascii?Q?xfB5k8Hfny2Fm2oXoJpksLP1r9UozA0YuNJdmEFnSSz5yptBLLEYCUyFD8jc?=
 =?us-ascii?Q?i+UkWyzBtLXnXfJkRfrrF5PU3xX0YFZ73MbukMhTtmjMlDtv+zAQ9dwFohZ1?=
 =?us-ascii?Q?+m50ut3pFwi8O0I5cAsp/GUEfd0qpB9NqH/xK+w6B5d5qQ8J+q2yklizyCBR?=
 =?us-ascii?Q?6yKNl/wXmzsJciDy4ilf/hIk2rySNKgrG1oVhejAhDSpnhs4iAd0sW2eBdOO?=
 =?us-ascii?Q?ZQIwTHbPJ6rMQRVqvHiJ0RvGz8q07HA8COKO3/BMIrZg418FhUbuNi1RIPoq?=
 =?us-ascii?Q?y3XyBRHcgCxW51ezSOS41LG8oUyjE+mczVxK/VPrn0FoZD9UJJR11sfQJFqQ?=
 =?us-ascii?Q?RIJXYKhLac0JhpTBIpkdMz7yWqW1H3QjJa/V6B+Q9f1dbMTDDmDB8yrlgPIx?=
 =?us-ascii?Q?cbMK+CL/8jNUfZfEIgv8l7BPfrotaziCDBR0WOjcI0Dx4I+T8EgE4I0bzHbS?=
 =?us-ascii?Q?nlgmsDkWejC6iE9yBiYlN4C9bn5E/aaKopNWdip98cdcvrEzlZN8pgpVPpYy?=
 =?us-ascii?Q?FpPlVQ2TGeG9lG5vZClwRK/xtNL6KU8wZXCVThc881+lnESEa+VhywVYUlz3?=
 =?us-ascii?Q?Nt9ad9MvdhEXYBnBKa5q2DDDk9z4MGRIOs60Whi83TnOuWLRWSfm8fUB3Ffv?=
 =?us-ascii?Q?WClxZKWssiHxp40pnEXtdHk0gck2VriVufoIGg0i?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e40b98-a0a7-4c02-a999-08db31b3043e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:41:54.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+xVrDohg8qfJxnVHVqNgQZyJHPnwOSJt3h8eIFvr3/PjyRbRT2s181pIPrKSj/q3Hx88sjsHlWmCKtnT7YdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9271
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Add 300MHz frequency config support on i.MX93 PLL.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 2c4e64db828f..4bfebdb8d7a9 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -85,7 +85,8 @@ static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
 	PLL_FRACN_GP(484000000U, 121, 0, 1, 0, 6),
 	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
 	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
-	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10)
+	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10),
+	PLL_FRACN_GP(300000000U, 150, 0, 1, 0, 12)
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll = {
-- 
2.37.1

