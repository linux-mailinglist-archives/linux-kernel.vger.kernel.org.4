Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A96D40EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjDCJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjDCJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:41:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2491FC2;
        Mon,  3 Apr 2023 02:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4jsksjsLU+TyptpouloxeqoGWYg1onvnSUMbV5cCVT/ShE/ShV4iT7XCXHtu/H0tCJesFFGFOfDOJoIhrwrFlbN2Y/2Gz+NRlK2YXgwCfmYTcprDCdE30cmm8+Nb/4+OBgKL07RTDEJO0QXni6qAdEbl1rL5eiK8W/Twxq0oOcLY1fNGOjPwMUCnigy7RzW1+bbcNDEA+cf4QblK6DX6DcFXH3fNGiNMmXcySIcNgOu3gcm3RtleqSEv5yswNz/fkze5T24jsDAC69gK2xp+5pT1De+KVg73fIuPr8pipdnVNdSrl9IZbS8YWX1Lfwvi/Kfi7/JoyUbtE5lM1Z1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPA3xM9b59Hk4etxvzz1T5JrNmMkkswC5V0ZYJsfY7s=;
 b=Gx7hSp215e87k8oLIm/vH92B0aqBmbjK5SUkC2DKUMhiWQbFX8GPoW+wST70BC+HC9KGiNqudFD7FdRNX/pEKpzLhvRxCY1VbFgWkbJYQz+TyMrQusIDmy+v4tpiEIzhFSywuJwb904BAjTp0d0Ve2sTNJg4ndCKjucqU4KKPJbYDz7BmBW9+UkfHWZwo7pE5RZ22pYxpBj0B3Jfm2+2wZsugRz4IB4jl3ihYy7eTNWpMLE5WZDArQiMvVJzbbrpCgcP1gty87FwRdNqjuPTvOaI0NaO4KZiE0nv683u/WiOcdTO84n1F6jSb1Nwavy0KNvrhZZozBx2GrpsFhc36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPA3xM9b59Hk4etxvzz1T5JrNmMkkswC5V0ZYJsfY7s=;
 b=FTG61WqmgyUejvg28/UsVEBiMwLUVgxwYlF0lUras9kD2S7lfNL8f7c8mUpRc2/rSuXwDycIZXQucNodgsPsAKnsGLf9OJlf8Fqr8r8X/Y4p8oGWJzUx1fWMIDhzDZ6hy8Fnvb69+6vZ8w4qh1Je9gg+PUqG8JYzbTTHjEfDFMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8595.eurprd04.prod.outlook.com (2603:10a6:20b:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:41:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:41:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/4] dt-bindings: clock: imx8mp: Add LDB clock entry
Date:   Mon,  3 Apr 2023 17:46:31 +0800
Message-Id: <20230403094633.3366446-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
References: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e7d3c1-0461-4775-2231-08db3427a06e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvSSo2LIUCGmDnMk81WTghP9/AdQhaR9QCB+/ZPL2y4n6wN5pvd+USzcNw3U1HMlqysuFKeR7aHAqy2Vhk7FVPAUJskj+6/Vg2N7mFU9Eb5SsN63xA9tCR295jzQcIBRCYJIiagAHs86S2KU+78nbWOezbhi3KNJHsPptkEgUoeSwkTU+Zj8QUFNeSYUuikWFWepntl9hluw5OliZm/wa13LkA43INn912npbTMCoWDLYw9Bx1eVXHlp3BplnVljvWQtT7ucD1XJM5XycaFWs4ilo2DNgXmC9Lre35MJVbPSi54YZxhrl+N01peVrhdJe48VLx6nLaw68ZKAEuGpvpjay1htOnH0FaGLYEbKGgu06dYy0MGz+CnBv7xH/rAJshG1Xy1ZHHFJIAZdwMV7/X6y+u/DwY51+UYWUyXSDb6iYsoGmD3ixsBqkTBqCfDkMfmBA4Z8aRdoXMeJzCQXkBL6SkKZt7JvZHNGTqYssc4WSgQphdQVLwNrMSBSPFEa/cFcKk3IbKST5UlbpquI0ndDs4KldaNg2E+DP0NT/8+I0PiwGdMLl0wYQHnlcOMAnTTTjjH3f13DPbGirgQA3statAt7IAyDXnOP7vsWaKaDZljutznEpFyK2iMfdvFV2cC7Dk8ySVV8CUL2/lG4Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(4744005)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PGhD0PGbVOU7k79d1LLMo5zzqNYyeWOiuqr6pICHIjzOJ8ZvJSmyBKO3HauJ?=
 =?us-ascii?Q?Ono/z4Gx7pAZFwNc4RbT3+ibzoucDw/E+EXUA/8+jS2ymNC+cN/iYgELjyiU?=
 =?us-ascii?Q?ySM5wSu9n757qX6HKXg4KKhGswWxfqSTDNlHKBh1/1qeh09SALvMwyQX6Qd7?=
 =?us-ascii?Q?oBCFKmIv21nwjay69idEvIQ/ncKtofUITpTAuwuOLB+qwb2JbZJl1YaRWgn4?=
 =?us-ascii?Q?DWTvok7t8DMTVK6ZMKEyqB66fSss97D2Pe6BUQXtb70Ac804EeoJ2DiOSO83?=
 =?us-ascii?Q?fipBYZWh8HKs3QcnNzol5pZ5fQCDFo3++mxkpysLvyFauEN199B/YnUSD/bY?=
 =?us-ascii?Q?x7RlHzlJjVSFF5LNTJ9sqV1/cwRDW07UEfomSNMDar3ejUyDlvSaw50egovq?=
 =?us-ascii?Q?RnGQZErJ7lEza3IE//zu6w8kx4qr+wzxwCX9JCj/rdR5+P89ST7MZ2tSx+Ku?=
 =?us-ascii?Q?pKZuGSSBn+lUu2vzofdlGGvp65SBny/4He4PEPrIBFjGlnYiSwHVPZzrFrpD?=
 =?us-ascii?Q?OqTHknTkmxJddVzO44LZ/n25GdkBvSVzoziA0w3L9xDAYx48QKGSt5skXON+?=
 =?us-ascii?Q?nDOB3M9DykBbG2EVgmC9K+i/qHw3fUP5MTamUjTAJHLNH4rYi8Bq/MZDik7f?=
 =?us-ascii?Q?KMLUUZoaGpSll7RdcMaodhEMp/7Lz2Cwy2t1cyLnqbTxGay8Z9oQB4ARxj11?=
 =?us-ascii?Q?kk3fhuT0lFjI2TuPt1ZK4ZP94G7xrulL27nUELQXBa4Zr4b7HvP4h1xXCa46?=
 =?us-ascii?Q?EkQHm2uMhuSbgdzeOIFgD4P3RGckPCzIM/Tr2XnUwMIjeURmWGmpjc2+VuZ1?=
 =?us-ascii?Q?GZwkKiHr/AIdeJndKy/bQRtsdf5C/BmEIc3Gojorlp6q9+iL+IC9ziVATlb6?=
 =?us-ascii?Q?M6Hh31fjk7fNWsKpFgSprPP1n/DsBGQ7BIf8bY0yPsQKxN53LG59IaCAflJz?=
 =?us-ascii?Q?Tq/oWvoLG+D/YrCk4lDb2nGs/mlckT4wSyp1RrNxG2AOoDZT0xahggE0spcr?=
 =?us-ascii?Q?7u3/VsoYSRDMlHH3gT9eB3BKJ/pbo7DWzH/S8bVyhZzcEgwFcUKtbZY9b/++?=
 =?us-ascii?Q?h6eYXnGIOWEvcy1eaVCpNcEl7DNU8Q6KRJK2nZEfc1hTrSsj2jnqh794TNn5?=
 =?us-ascii?Q?VQlgYDjM1pypwb5dREaxY84mTiyE+tHN7IluVpyXorDUxRlwlmy1EwZEzvDL?=
 =?us-ascii?Q?Aarx01nE+vlSFY7OoMPMPXc9n/ZeGKOI9/1uGfIyIlsDuhBTfVXD2V3D/pgr?=
 =?us-ascii?Q?tBHgGyHH+C12wZGtweH+ROlsVVqBAi8N361rk3HIeFi7087MVzqtFPqr7O4i?=
 =?us-ascii?Q?ZXVvhV4mRdA/47niqGBJRpnfr95LF8T7wsxsAOkId+tptSrhb0+Pf8ZLnvt4?=
 =?us-ascii?Q?XYkhzULbV7Rqojx/4ZvLBF0+pILrd97Ih52soGfGLiNl6UnbKwIGLFqIjpwo?=
 =?us-ascii?Q?OEyUiDW46xOCuQUG8i8XpuUtoB7kk6TWhxe1K2mqPXTV8EPdNMRf+RseB1fQ?=
 =?us-ascii?Q?cNlmds4j/YpKkRf7ullka+1JUE6D2P5NsO9ngR6QWS8142JuNV4I9cyx1nR+?=
 =?us-ascii?Q?tKdmnCpUXrPuDqvKXBxRzEU209F3PhBdnpka1MvA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e7d3c1-0461-4775-2231-08db3427a06e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:41:40.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18w5MBxYKMgBsfZzT1gazikVEnyeS0AAc3+jGmVlrnjM7Ei5k2UduJab4Eag7VmZspZOxFwgR7hFhLADBswbFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8595
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add LDB clock entry for i.MX8MP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 update subject prefixes

 include/dt-bindings/clock/imx8mp-clock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index ede1f65a3147..3f28ce685f41 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -334,8 +334,8 @@
 #define IMX8MP_CLK_SAI6_ROOT			326
 #define IMX8MP_CLK_SAI7_ROOT			327
 #define IMX8MP_CLK_PDM_ROOT			328
-
-#define IMX8MP_CLK_END				329
+#define IMX8MP_CLK_MEDIA_LDB_ROOT		329
+#define IMX8MP_CLK_END				330
 
 #define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
-- 
2.37.1

