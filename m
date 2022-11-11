Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138676251B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiKKD3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiKKD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D075E9E5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR9uKj7yxDoZgDWx6O7nlLDQoHsqH9P0v0dR/18xYTyBAhDBgwOzBDFNBmbCxopu/vNpA8UG5TAZLCM/00SFswAdaajIhPjh2cbujnkkT/ZmRf7MISAeNKIGjUsFY8rkVfQxR68AObURRMGPJMUFCZB110JBWee3zlh6ZrQv/7qpKooT2xtuyF6YUL+DtSIZxoucVyHCqKayVtOR1p09H8U5zq6SzdhpsxOowiGrKElfq9Zqn6+AY2UxKK4BMo4JnZ31uIYonSr4kWeSsI3qICBMkjapkXdECdKVp5Fm517IgJ5eNbbFOOH4eTZK9Hj5l9t05AE7E8Pj4/BO1+dUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45ZlfSnPATcVCkuW7OpkmI6SoUKfZvDq54LQHVB8cN4=;
 b=YbcpBJLZR/f9oWg3WBAec9AmQvB1HNyxylC6m46ZKM9vXGDRYmped65PhcOJms2dQEJ8liK+fTb+uVIp7madETn0Kk/CzLy9xQdqUcMwjitAlRCiQ8ThAvN0ZBtJXdvAE37gihLMy3sfeoL7bqZZ4FHiKP/2vt8pKHj0pnwSKoIBTgzMk8GJP2uEKLZ9KBghbINtWoRMWnQfRgQPIUJGrWChMQTAQ1k2pbEAJ4ip/dwmRZHUVh4mPMGQnQXENubYiC5tXYNNr3CzjqwGuLA/pBu2QkCptAUSfrYuiUaBmpUA0PvAC6E9qSe5HuGsqZQZA57k2xhMnqjE8k48ji43qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45ZlfSnPATcVCkuW7OpkmI6SoUKfZvDq54LQHVB8cN4=;
 b=gc+vmRWvz5OHZ0GmEOh4zju5+u7KYTh0yjwS0iOzx6+xpVuQZRihpKNKHmjpnngBQxoUEK3fEIbdWh4AcZEma6OlRAUXUN8O3wa8/615qI+8U8EyKBVq3YtoS/kH3tEBlYT6u/8l1lUzwXZU94UtRRALfQFRJF20nuP1V2Mlt7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrian Alonso <adrian.alonso@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 14/14] arm64: dts: imx8mm-evk: add vcc supply for pca6416
Date:   Fri, 11 Nov 2022 11:28:11 +0800
Message-Id: <20221111032811.2456916-15-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7667d8-c702-48ab-39de-08dac394a944
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWHaWM1hK1K2tx/HpFuSwaYio0mUvQXjJsR12aTwDAngbU9xuCp4BxfoHw/VY7TDIiyurEqgbSij1pevbO8OKkp5Xsjw3kfofyHskkMipOwvjj4sNAmC9UlGxnfN+GTPI6Sn141FNxIlIVnA+UxkjF46ekI/h1L+zcEurdxVVqQBhDO75WbotQPgZa4XDQ657sHxS2OE6vCkEIW6Sd3IXuQkcUpwog/s3GQ2/jEOoR1DqkmbgfWRZ7f9QIgSxsDS6OqV5gn300Z9wr8lkL7Jw7HaqyKyzHG0PgD4KHJyesM+Qncg/fOLEnRCKGS3uPFcq+U1KSq0x86IpInknou7bWP0grt+8bVPP23NoaTTxYyUJ0cBrdmq0h4C7yZxnoE0jNIywdKuZD8NnTWkt6WcbRXy7VobN8Tq78So3LX1foDF1ZU0p7jlyq4jZtoMcjw30kOeOeXQ32xxGXhyMalT9u2TLlT0MexOH9WHHrSIjxRvvZQfrqKyMB34MyshvD0ayLEK2rKg4szBwJTvddUuCYGctCSuZlMuYZxkA9kiH90p4aGR5lMgSAFKef33UGJIAn0UTLsQ3LAC0lJeVL1Ot++EAtNI1m7tngOrsujWRT7NY+58GgzHZbE61A9H6dLvyPgq3wIn8Mv4QnJSx4wECwu1srv/2Pk/wPFPy3owCGiljRfIM/UNaix+sPYvXr/SdkIUocd7vU3CgRQIswkBwvMRZE0ultv8iX215Kqv1sIDB0H+L2tifcTGClp5+8mMGEj31JrZyW33jtDmZr7cfQ8iRHy+yfBTefm63d75EDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(6666004)(8936002)(478600001)(41300700001)(5660300002)(4744005)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWcr3uMWIpHRBGRBk8QZOfp+B4SfyAxlJKYLMjYiHpog9LU9BI2B6pjp50aa?=
 =?us-ascii?Q?N39qJt5ytqUvJvhyfs20iBjyG9gX0d++8QtJJ6msuTP2fGdx7My1ATUxk0Iq?=
 =?us-ascii?Q?W3qrfC19xQ1I19dHURB5aI8j4lUa79IOUMhA2oHwzJof8gvoUlk3CJOAeuBl?=
 =?us-ascii?Q?VaaiMgfrA3tSJ+lUXIh0IMyXhoLWZCBtKW0qOUZN7KYp/VMDu8S414YxiiYK?=
 =?us-ascii?Q?i1a34A3HP9Cm4ajL4BjY99eN3wZRcbCKm6e8SQqlWdinTaEQPcyT5hxiypdP?=
 =?us-ascii?Q?h9YALbdZQeMe5clEiegt3OswYQ8A3NFevpg68pMp1odK8TUAlaxrriHdK90X?=
 =?us-ascii?Q?Q8s4JB37+GraDmT6bNDODYx4xYrI/N98vYsKvreP55dygd5bh6oGX083HxaY?=
 =?us-ascii?Q?rM0jBMj5PT9mOahknMFYvOrS3GueHWSXGx+M1RDTDTJG1EW7YWQ9MeExXJ8Y?=
 =?us-ascii?Q?+IneKQfMxQlrHu+8OsiPLTYrd1PiYher+GYE7a75V0dMAYgY9e78EVcUSGkR?=
 =?us-ascii?Q?d0GhbYlMyJKZgQIDciEHv+RT/iiNwYc1xCrHqy9uY/KIlYzcr4sBGYyw1I7d?=
 =?us-ascii?Q?u+WXUgcbSMpCh1coyc5c641Vj7NocrBSZ8YLi6DrPNM5uuvl+63cGwuZxT0v?=
 =?us-ascii?Q?8uBO5rVLfPMFRxr2ivdcNkt2IO6SMPmJvSSJ/RkECEcVXJH8InaahoXn8XVJ?=
 =?us-ascii?Q?u2tsYhrY6T1c3+wf9EE5iDKfPs1GEl7YtBw7j61OzKtSEknUVozDXkIsmnBs?=
 =?us-ascii?Q?PFIh5r8tiz0s1+nioE9AzDBDNbkKxHt56pP2gXtKHMDWgWhQsPYQQma6tShg?=
 =?us-ascii?Q?VKXV8gea/5RM+lhsHO2UrUUJ+NzOqCk0eXUeeiyThIXQs5xIQlZw9xWx9vC1?=
 =?us-ascii?Q?SZ8YAo6q6fnOXjnuVWm8c0jRYZRbu66UF/x9awNdWFbEVZUwkojt+zTxqRkC?=
 =?us-ascii?Q?s0lS1ME4VgBe7HxALVTx07xTGMD/nmreKkzs4XB7k/HotNthmvc/sH0FciJg?=
 =?us-ascii?Q?E/PGu71zhKOOFd7hfPK1/udtIkh6gdhbDFzLVmUrNi7DgUz5rXElZbpQVU0k?=
 =?us-ascii?Q?HrZpq/vUa2RLegc6ZdGwwk1mnyNnTK7VK89Fzhkmu10shn1NJIp3XftQfCtU?=
 =?us-ascii?Q?fQvx9vE3/d3Oo8xYesgijFyZi6SIGOTDrvwi//xKQzPSPcBWD0HP7dUUJHL3?=
 =?us-ascii?Q?OOYCWTd7g+EOppwGiyHwnOtUWijsVVfMuMy8gZPMwUBirKQ4qDaYmrhgm+Yq?=
 =?us-ascii?Q?qWahgVz39DXkehf7ZWUIZe9Ex0Zrmj4wQGtlPkOUzAsEmDYEe3fsj2wT85ZK?=
 =?us-ascii?Q?KoIErPQnYuMvQX3anC8sNyjYUnJNOi6dHOj6+pJWUOeomNVS/DOvYD6mA3Go?=
 =?us-ascii?Q?LvJfJ+mVGNLpVL1PG8TuR9/+fFdxmsfZlW8bG/0ueq3bJSU4cl3CVkdJEOBa?=
 =?us-ascii?Q?7y7e7ANA+QbviuzfaZXpGQY6GdlcNgMCRwtbSOrVT8PkwKFPypOgjR/G6CqA?=
 =?us-ascii?Q?7yEXoKI5GXdcq4is6JacuUSHt9c8R34P2lh376zEPECuw3J7X4Ckn2OIDNO4?=
 =?us-ascii?Q?HBwAAXGmozmVjjpySpcZvvwdhh2ShnoUCna7e9Sq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7667d8-c702-48ab-39de-08dac394a944
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:29.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sznI4n3jdEZWZ1xiDO8H4u5/9JSSFpyL8e/eaS56b8XSiK85qhECEd0TpDlC+3OoQU0vK7LtHXKOtdFj9gZgGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Alonso <adrian.alonso@nxp.com>

pca6146 requires vcc-supply to work on i.MX8MM-EVK board.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index fdbcd2483efc..31144aefe0ba 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -344,6 +344,7 @@ pca6416: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		vcc-supply = <&buck4_reg>;
 	};
 };
 
-- 
2.37.1

