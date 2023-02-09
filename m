Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB682690071
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBIGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBIGhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:37:11 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B911A25B94;
        Wed,  8 Feb 2023 22:37:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCl2Y+rCIdJye1kjrlpoHTdUm7qgTaLH2qERBUBy99htnXZFP5IFi9tXWb89QYm4VOpVnxefkCRkstiBHcz7A/yEw9AFprxFRJzUJC2sEwFiAf+VNexK0pJNbhSD8vsLgU+iYsgdsYAvhC0ZNW82EWEdLarWUPE6VACO4BdosZPTWANZrITI1C2elzD+RpKYwd7LXSpT5aNMK2mekEW1A7kGWGEUS5yn/v4QDyMrm3O8hJk0J31m1cXXOKhftukKXImtPUQQdlzsHOvh20NjIXPgjJusb0k8txm2oDjEyyQXjB/0SAXhlucaSvJ3EArPi1EtkRgW9VsJnJAbUCMC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tIRmbYwTAeBLe9c8790tpkL/yj/P7/Z9KeZrtxiHwQ=;
 b=VlCGJCTu+Y3iPSEQ9mcvm61ZI5BwK6MfV8JOX7TGFVs3U4ACCWmotmXd00NzsZxnaF4tiFq173C52PBUB3SW2r/J5BhlILNic0qEPohBoxT1Ci4Em53ea6gsblCKEjlmYPexr9ECcIh1c/IoZsrenQp8I8D8eV8XG4g5IKodasVMdoM87X0UsS6pTNFch3HYqykQ0rk+kqL+OIbwHESJGldme0WeTiKIAkTxSRVZ+J88o2OtXfpRDHX2PAHNdC+vKJnBS86T4612MI/pSct/Va7iXydUNekUHYQiNLDTAfANzMGeIqPtp4a9GdKryUtfZasfKzdCuOz4+vdtHNj8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tIRmbYwTAeBLe9c8790tpkL/yj/P7/Z9KeZrtxiHwQ=;
 b=QniOdtZIYTjQzZ+7A6RBJN+oBS9zP/MG+WRyLo/R0ogC8yzgyF2a4tDAG6ibC8ncRCBKSLWOrm8pD2yEMdXxWOI23KkXE9wyFsB5orgWwT29ntgDcvng9aqe7Yn10igTu85FNy6EeFBbfyHhf+HOi69dllM3eCzyTt/z2p7bxkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:37:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Thu, 9 Feb 2023
 06:37:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/6] remoteproc: imx_rproc: correct i.MX8MQ DDR Code alias mapping
Date:   Thu,  9 Feb 2023 14:38:11 +0800
Message-Id: <20230209063816.2782206-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: ab15e328-3210-4a95-4f04-08db0a681056
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNzMJPk7jXIWG2TbiKRbSINL3Lure/G2Js/QLr2Wa+nIWdGcN+MjDYxgSU2pRn5BQbhk+g3/FBPWXHE+G3dUlELttDwemHbAUH9K28DTazBy+6czFoL3KXULXztponY5rBZBRU49O0t9pki4GcUfCvBfNRNQVPb5/6jUy7bK0s9BAyW6BnYGXN6/YnLlPze3kZix5e8XPV7fide1JgmxFJmRBfCCDdSNGjpJL8H6d/bqsr7UBncjjJ+vDEUc+YDuqdcIiOP5TtLA5vvkD5KkDFuelgXleWaTRBbFpgcJIRYpsA79kOlXIl5Go149rSpBmVIXBok824WStTZqLKD1pqDbrEUSqI58TuhKVdMDL28p22jltDsDHSd8NUbp90URneEx4jrbNwEOnhrFf6zcqVdY5r4QWiXUgKh0nmmZz2/pNLtD0Ar70atI2YxLrEuCLWWhyMH5whfJ2Oes73YAODTCdaUeiWC5Vu5/6ehbwrUiYin48yqHwzL59aDWs4HEXmjN1IgSasYoEQwiLCxlJFCwekKvm7b/eNhUGy1Tgv1neDDG7LHInZQ8I33CHDfvWd5/3fUSZiv2tlnSCfBqgG1ASDCXsCEHuFfPcSHXeo1Fi40hYguPHen8B73RvbskhDrxRNqMkjqmBVkf+NCRkKQFjtNvaCd8kynnaQp+A9Wk5rx6kwH4hTIxvHh3Hu7qsEt43KHEykkpcV8Q0IJvCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(6506007)(6512007)(6666004)(1076003)(86362001)(478600001)(6486002)(5660300002)(52116002)(83380400001)(4744005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8+WMKjS2Dgxid2ngbNQzn6ZNAz5s/MdDoUsy9QDCf8QMdtA/HNqhfqrXgdLz?=
 =?us-ascii?Q?IubfTq9lTLvDn8I5F/XRnbImw1Par6pKtkKd8ocplXvb6Pc/A3vmLuEx5boy?=
 =?us-ascii?Q?tgvNkaZ+y0LlnIigCW4JGv2B51wj+1M2hItRr3ndtnXyLhioobAl64aPN6tf?=
 =?us-ascii?Q?vc8WYMBci7kilWW5yt1Zrx/FSBlYhfXnYvR1P+teNGpkqXqYr+/2VcyfvK/V?=
 =?us-ascii?Q?JfNDuK60XTbdvlinBgNI8HxsRBajm5UI3zgRItN7CVcGMmmzABVXELzHTaAS?=
 =?us-ascii?Q?YdZY3ETtwhWSdz2krTNFR3IVOfU+n2+47HydE4alt4D4dVV37Ttz8+yNzjlO?=
 =?us-ascii?Q?KfcPAi3RgNx1kw6V/rtLV/5o0dZh5f7wHbwbIQd2rAl8gSHXpzM6myMpdN5n?=
 =?us-ascii?Q?Ln5WXnWZMnd54XbGfD9uhh7+BttybzchjWmAPLmL/NfXvPCdYtQ+XsClcuKA?=
 =?us-ascii?Q?s6rVIOIMS5RbTXnDNmZ8XYuFw4iRXkLrKb4lE5WcWCihBittXqB0a7cG4el9?=
 =?us-ascii?Q?wYjco7at1Ysey5tm9UbJBgyJELL4nhMVNdEJJCvhgmY1tUAVCNeZgDwa0eCl?=
 =?us-ascii?Q?18YRnjJDYJMWIiNPT0FzQLcUt24gOcmukfBcXqvIlE6m0/5Uri/8uVqWUMzc?=
 =?us-ascii?Q?rWBOlH3PMn029YhDlMWzSARta2s375jMJ2KGtIMJA691nkISNmQjoJ+YslZV?=
 =?us-ascii?Q?pSCll2kgHxCJwvcWmcDE5YIF0def0C3Wc11dYFN/tevc3pcFdE0Gh2NUHI4S?=
 =?us-ascii?Q?RXcIWJ/fD+Xi3K9+9IwGRU83sSDCfAazJYnlvDf/LJbAPSzWIPtcAjUWhqAg?=
 =?us-ascii?Q?jWqOBYxgfbr4GqdknyIxlxWXWrHYbNYFt96cHArxm64CnU+sJBfEHLvCM9E3?=
 =?us-ascii?Q?Nvl1THMXWTQrlT1lTVOmXBmiX9Jc1AI/4SIhSJTwmXkX7C+98/ivi8kp7heo?=
 =?us-ascii?Q?XW3/4wadYWYLjphMjWG3NB8LdaNnnMK2tJwYHT3DQTkKDTBw9TB8ZLmHozU6?=
 =?us-ascii?Q?vSclpErhbcjo7S7HSai4fnAR/611Kjrtgw8PDyZawFAUyhp6H4LQU/rYniG8?=
 =?us-ascii?Q?y3CJa1iU9S2Qi1F7BaB+MnBvaDpJQAWqp9y5dGzK0mZb7iKerHTl8gKLR4IJ?=
 =?us-ascii?Q?+OXVoQ35E8IjAPPsc+OxwVSL58R77vPfNnppUJQaMloMs5F24WOxZNdxasj2?=
 =?us-ascii?Q?S35GU6+prUUrWaCwcsLk9k8IyOaUzTVT2yVlO3b6dF4SG/PXlq0bfy/GVnOG?=
 =?us-ascii?Q?dYOPNGFq3MVCPn7mX+KGiha3uUvZJBEIcW2LEU0GsKyRWcj4l72wszKpChz0?=
 =?us-ascii?Q?0RHheyiI1eoUzTT2VvQbfelzZMO2oePF/wxKDxtxk6NFWkDza2lFZtbIwhFB?=
 =?us-ascii?Q?pAQl3NLrZYIH1v6i8ueyWZOj2HZUwmQyfp7vm5p0RRbfvsQProxVHnl9nmgK?=
 =?us-ascii?Q?0UPL5Z6hJorm6L3rzovr8bt1Z40xTc38/0KqRzhYcxvqLQyl7AfR+R0+6bh7?=
 =?us-ascii?Q?gOOKebKsnG3MqfWqFwojR1tp+Zb8Rfl4etv7BQEggQYNwyVctweGeTdcrWH0?=
 =?us-ascii?Q?O/Fp8PLLAhD0/0M33paPaVl2s1ctTnS5pmc7Jzdm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab15e328-3210-4a95-4f04-08db0a681056
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:37:07.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnJZ5jtQEjhbe9luE418UyhzCXzkKvoh1Q6LdsthepeNmOUFzGjyiZnpw5SHQo5qSsiczH+bWLQSuhFd7SOSiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MQ DDR starts at address 0x40000000, so correct it for
the DDR code alias.

Fixes: 4ab8f9607aad ("remoteproc: imx_rproc: support i.MX8MQ/M")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9fc978e0393c..6bc2f988fd4c 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -206,7 +206,7 @@ static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
 	/* QSPI Code - alias */
 	{ 0x08000000, 0x08000000, 0x08000000, 0 },
 	/* DDR (Code) - alias */
-	{ 0x10000000, 0x80000000, 0x0FFE0000, 0 },
+	{ 0x10000000, 0x40000000, 0x0FFE0000, 0 },
 	/* TCML */
 	{ 0x1FFE0000, 0x007E0000, 0x00020000, ATT_OWN  | ATT_IOMEM},
 	/* TCMU */
-- 
2.37.1

