Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8065D113
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjADLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjADLAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:00:30 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC11713E95;
        Wed,  4 Jan 2023 02:59:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhGg9k2VVEieGQ7U7t1ZiXJ75saoJqzkaMAjHbLgbx+IUktNt8ty505jK+8zlwuyh/z49De/wF7My2/cryKzyrdvMziEGpsou7pSl9KGMVLqDVea7oPnMH+BAZ3xRiTK2picF34ohxYhNns+ZqkQ5fO2i6+eBnyTu+EzcCi+D4EnZ+mvwoExV70OgGF5G2kdExCNpk5KlglON4LZcSyLUYH5ArRn+k425PLjZjxxDDmUtPMVoq7jTv0TMROl2mSW2mpb2obPkB3meuHq/xwg9vik+oE9bBiKvvUIiio2Wgh+FJVkqYvCs+MZZSeRHyq/UeHmYIPCNsILAc+WWh68Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6CiegboVE7urDb7K9mZCgm5h6p6eAA5uqbc013jGxo=;
 b=HW89DVnmt+cPH9faS2Ysv+me6kBffpnKeUV79nzzt69cIVP0pdYQq909hqNqUd3prkH/WFw7lHjDNsMOz7fToK+TnSrfAOAr/OF0fFXq3D/rnkxDFzBmzJq5ijD013OFT6UfhADGM+xbilT/0TTL/mxkW6dYnHjfJ5SX8u6ILiRcdSVgQ6TeVn0ldJ5jF0BUD51LfAfYeKhegytDvEYgGrlqnRox2prqtt66Jm3Xh/uniJdW5iElSVKv8HmtVPxIs1htJaxLWx4uPVx9wdRUgNzIlk4iXF4cKngG790PyWhU/HilOPt1A3qnQFgun4JKTP00HbMsdkEECh2Sf0Gs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6CiegboVE7urDb7K9mZCgm5h6p6eAA5uqbc013jGxo=;
 b=DQdrYcWh0hkkY6IynyVO9MX+5j4sShchyL8Ys3Kb2UROejI2VR1ClAKUfZm+VYnaK+pJKDOnaEkF7A8NmNbawFIfWPyE8Cab/9hOPtVnFCmyUw3TuFVJHW/XcyIX+7eZNIx4cATA+RSY2mz8VhsF+JK/dMlMUDCcHoJqdfs5WJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 10:59:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 10:59:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] clk: imx: get stdout clk count from device tree
Date:   Wed,  4 Jan 2023 19:00:30 +0800
Message-Id: <20230104110032.1220721-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
References: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 2779fcd3-c594-4cfa-ccd5-08daee42bb58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eF84p/nok+KV65s3cp5iT8OO4fy6PqhAt5weX01XpTJ7QwNkM0yH6A2piPH0pSVNmtXHJWyfFW+CqymszFn03mFPjvYUtiSj6FQOMz9Rz8EChq0OtSDmUv2IqciZMLDY8uX8BOegnyevzYWUOQmNAiblo0WoS1bV/qmgulfJwCIeIq5geeElTx8Whr0Rtdl1iSU6brOFIR+N9uxSPZEJD6C+z1lGCiQjcEkflJtVNxR9icAQOC/qPnDAQqvitls1ZE0JOdO9+Te6aNVJ9p5C1Go6bosrvKLn1upuvipzk6v64jULWXXZKD9AwjggqC8sCwmNrGbucs51TftU9Jz+xBF2uwd2tU3L0kDLVKQD4qotkF+uN+VHt9qX8r3z7bXIX5mgTW6j5uTsMbD2EqOqI/CxPUmjj68BK1qyS2hKEB5k9/H5veZv8jpeCh4jzyTWtRPmYWDhmHFpMpxegothCrnxVewWEX4YXVrvTKUPfakSiHxwyxtaPVyPurNhscQYMl16PLw6WRYTCzds6PDUGgIlVUdw7ezUI7eZFq1XI42FQuCwIC4jIKsz9v0d5TD7PlQ36t8ad2/qyse5ID5NPGZEeQ+1Sg5rNsucuLB0u3bPFJYTUf8Mida77gB9innhYFwykIJExBT+1yYytflCFKiRXNey/bR4t7e1NNTxafpB6+eRUZqb1fQM7B1kcvjvbcVAy8QMhp8lgQs3hOam+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(2906002)(8936002)(38100700002)(38350700002)(5660300002)(41300700001)(7416002)(86362001)(83380400001)(52116002)(66946007)(6486002)(66556008)(478600001)(6666004)(8676002)(4326008)(66476007)(316002)(1076003)(186003)(6506007)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2Lc73o8w533c1VpXWfv/tF8nVMPzlGOohRPnUnFkrpRtPfYErcgZBiDquRB?=
 =?us-ascii?Q?mCVsEWiuoDTTlXp0PpXELUHWwoE8XRC8zV4y3e7zCRWUF8/SDRSHpixXSghN?=
 =?us-ascii?Q?wHJqADYHLaRN0Vlyi62NeVYVTJmuPWRPDwn2JFcep6/MJtv3PGsZluwLjLyk?=
 =?us-ascii?Q?XYJEYDoyzeaEfbn7QYEz7/vcRAfhclS08FiPvx/CqEqNqYmCSw5N29dJMwBr?=
 =?us-ascii?Q?h3tbuVeLt+ndN4KUNFj0q6AR3LAjI127OhWCmtlXpzOWenD/2eRNk7dPJpsc?=
 =?us-ascii?Q?YIla0KqvVT2VFCV1YyyCVChmK06/A/UXtLqBG2dc1H0M2FaLsy3mXHrY4YUm?=
 =?us-ascii?Q?i8yifPuHbajTI2DYirNj2X3hsmgJBkDXRNQAIpCMpcX1l8BfK8JGzokiUGSA?=
 =?us-ascii?Q?pwrq9hKbQMByLIybUnkPc8cPplY4EC7Q0E/yQGbSGaTCZrT/fGhR0yXZ3W6l?=
 =?us-ascii?Q?QREKqdF7fLjQyjTfelkMHN/Ux3tVWvvw3PuvWa54vyEkAhj7KnCt4uS8uRkE?=
 =?us-ascii?Q?z2EFyRGcdbRf/JxPHlj+mOkJ3qxcM8vTzmTga5zFP2WzpWzL9HCx8Ktn9/54?=
 =?us-ascii?Q?npAn90lTLWKUu/jlxiuoiBsj9A7VwFEOY9a9cc70AysJJ8wSUfYquPBCpbfW?=
 =?us-ascii?Q?ktee467s6cTj+9+e4ynTtzZDuJuBlLjHnsxHvlDTQWWW4VmOs/KlA6nfGnNZ?=
 =?us-ascii?Q?E343MdkQf9TQHDyh5E3Q3sZNuuK/hOMfMLZn9RD7maq/vAf9PQg6Win3TYQi?=
 =?us-ascii?Q?ZaxcKL9Ya7CfevYINJs4MBPpOhxBgxVyYJdv0XyHH4YVnTlmkLWhQnjqXVEP?=
 =?us-ascii?Q?ivb5mZLiYqCrxIgr3jyd08BfTITEpusu1xAjJtrcsApVZDYBZMjv+ZW8bWqk?=
 =?us-ascii?Q?324+coTmQJ3f4N7Ew82ylBbr0Z0Kis4ksPZwlef92fyy9ljXaxYQNRqn0mPp?=
 =?us-ascii?Q?oRwhTFoQnVjyioz7RYC5z6c3mY49foeZbuaUVZHMpE6O3vT29W0DrW2Hi8Ik?=
 =?us-ascii?Q?rmdPZwh8KqaRBAAO1QmzAC1BU3Q2S7Wu4oPdK0YYnDrqDj7Srq1Ek2O7BYs5?=
 =?us-ascii?Q?8kAZ2049i9lCmXqQBcXM+4GiGavrsDGzpEN3iXQHzFnSf82lLfxVbnoYD7rW?=
 =?us-ascii?Q?SMJPF3RfZ1hxvQSLXCuPnKbOdTgbFE3vawzz2dYbx05aRf3BaUVSCqOZTXkV?=
 =?us-ascii?Q?vDOYoqh4ILyYLBVkbHE+FXuWVeRD9Q5dSMmwTX4e473X1cYCLhnSmbXJdmK/?=
 =?us-ascii?Q?dokgz4jikkXWCtb05hysdCPIAYmYZrRH4zBlaCbrft4YZrjF24slhox+cEOp?=
 =?us-ascii?Q?MycSC42ZLyoKP1fh5/RK97yYC7Y+aKZzH8Jf0+NnmwgDF2R+dzf4JANa//lM?=
 =?us-ascii?Q?IlPh0yacWPOTk80BvcmCrPJDrYUL2dUSkb5MaeIDdQQppMO+8oPbca9q7kkZ?=
 =?us-ascii?Q?bPTupNrYsG2VClTrXT0xJrSnuKhWWrp0UynHnx83VT/iN0PY5pcVzQapRW0P?=
 =?us-ascii?Q?e63oacn47OQxwqVEuIS2qrtKXf3oZ2G0y5/xIWZRdcaeAD8tSFBQClsS/Tf4?=
 =?us-ascii?Q?Hx83Y8yU0RpZ8+udcu+ayj6+DvHb/AfUAaGYG0yH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2779fcd3-c594-4cfa-ccd5-08daee42bb58
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 10:59:20.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCwZH2vaNFAWNDLaKvL3nXAkLnU4UEXxgHpqPgKRR9LLDZL3AUzhc4DXIkxaDod/1wOFA2OTKuq1LEpv2EqfUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Currently the clk_count is specified by API users, but this
parameter is wrongly used, for example, i.MX8M clk driver use 4,
however the uart device tree node only use 2 clock entries. So
let using of_clk_get_parent_count to get the exact clock count.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 5b73a477f11f..df810f0ee16d 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -167,6 +167,8 @@ __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
 
 void imx_register_uart_clocks(unsigned int clk_count)
 {
+	unsigned int num __maybe_unused;
+
 	imx_enabled_uart_clocks = 0;
 
 /* i.MX boards use device trees now.  For build tests without CONFIG_OF, do nothing */
@@ -174,14 +176,18 @@ void imx_register_uart_clocks(unsigned int clk_count)
 	if (imx_keep_uart_clocks) {
 		int i;
 
-		imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
-		if (!imx_uart_clocks)
+		num = of_clk_get_parent_count(of_stdout);
+		if (!num)
 			return;
 
 		if (!of_stdout)
 			return;
 
-		for (i = 0; i < clk_count; i++) {
+		imx_uart_clocks = kcalloc(num, sizeof(struct clk *), GFP_KERNEL);
+		if (!imx_uart_clocks)
+			return;
+
+		for (i = 0; i < num; i++) {
 			imx_uart_clocks[imx_enabled_uart_clocks] = of_clk_get(of_stdout, i);
 
 			/* Stop if there are no more of_stdout references */
-- 
2.37.1

