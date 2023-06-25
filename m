Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E573D0DB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjFYMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFYMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:21:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081FCE5F;
        Sun, 25 Jun 2023 05:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igOeL44TV0Blx0q+SZTLtqbbZX1XuqXj8AysIp4nMNtCxVqLdWx+imC0YZepBXSQuiQldoitEaNPX2/E0cezLI6yyldYGkXArsI46woCbMfmNcmHqe0T3CkrtqUFt+mujX++G6IwGotI9rxcDzvtD213exYl6w5bfS8Zf/IG7ucIGLzBEoCV0Ndtp7DoOMjAQt7buKaJkvI1j90fKpBDAT2nu3HXo4OmhFUsXlXINSyKY9hRFdWHNy5Gw0OgWxGEBAgA5TR6E98GqHXRbBH8ol/OMwVid1Z7yM0PkdCrpL1ARdEkDrlxjoKU8oRTfMjVWyGYgOBUe9SeoNv6a6j/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYkgR8EJDaTfQzFkO2VR6sIlvZED4fvCtbmOnA1D0og=;
 b=OPSiUofG/TxHUNBOWv0r4ecu5qVuvsbwJGSv4G84mHFYGLQf+HPMd/C85HzDlY9J0VpzFtzHMg5u2vTboJcXavU7G7rIsJmCu1RpMlfNB0vfTDCh2kgEnf3mFnTplMN5EnHPjm0Hhr+ZEdO3pHKLmRXDl12vfdbfClec4GzU7JbJ7+wMw5BnsRL6dcN/oWo0Yjk2Jhj/8ktn/0gUQxGeE5D3/FaiBVqTfKbTXwNGRi64m9uh7BDlVQc4GQczLOndIiBPkGRUOlPrAO3/AiTO3Qfw14nzdEHvYZdx1ycIsgO93YObldfqjJuNcegHRR4etWp5riVckuUZuQKpv1wFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYkgR8EJDaTfQzFkO2VR6sIlvZED4fvCtbmOnA1D0og=;
 b=SPJr8VDZTRA6J6ImW+1tbHlZALKKZRM1t4SULgukqQez4P1LZNH2GU4LpRRI32wTltiHCSGO2dwyomT41+r9RUrU45kHi2y/UZzMoglBBgzIljKH/HHoA7DpDZV9EQug47Np6W84RvfO87LwoQ2p9qWfBCrAmHSErytegAEffKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 12:20:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:20:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] arm64: dts: imx93: add thermal/cma/cm33 node
Date:   Sun, 25 Jun 2023 20:25:45 +0800
Message-Id: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f0d001-2101-49cd-d0b3-08db7576a135
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LboHfC09GSPP/bGb/J/N1qmhFkHM1mGFftF81+0gP+CxGOdMU8/wpqBay0ld1xgBbiOtxo5PKyz49jLv81nqpkmgDphLkWpPT0ibfd/9yedbLaCU5zqXY8O2x1tJJ7HUwV3D4sAFJTbymK9bKkQ+3s0IZmmz+qNaUw90vLopog1QDlYj1FYyLZaH3SZ+Ckpio2uF2G02NBqSALWRsqFLW04nWR72fQeaulj1bgW2h8Pr0qm6K0hM6eUpqeSiQZTEX+a9kcbG2DAoO4KU06NujqPQlbGk74JeLCUjGiMfJ5GzavAJNDjs+gjIlZzhvKy1fRS4syeihOqoSS8fbKHHIVk3OkPCqSiOo3DNPbNXi0jtdQi4mvHW8X961rqzX4yRwyvHngqHTxbD9NP0Mb/C2Ar+Cs4X+7nTj2dUy+NFvfLAdyDIYMhxs0AqePFBjpG/ocK1r8BySNOU+G82LHHx/VOPTU8tDLGv8DrIUoZKowTWwBYZ4qXlTxbZYK/9vxXzqrJda3ikyPBEX1XXVVlhxrsI0lTzk/ka8lI8O4zmQ6kEWlG/faqYBWMTy/GMlxEFJ9bLyqAmAnRlJrp9OpGBPFR9pyRDQMNNzqt/NlVrhGT7qYTrKyn1QPXtKC7Cj9zU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39850400004)(136003)(451199021)(38100700002)(38350700002)(86362001)(478600001)(2616005)(6486002)(52116002)(6666004)(66946007)(316002)(41300700001)(8936002)(8676002)(66476007)(66556008)(4326008)(1076003)(6506007)(26005)(186003)(6512007)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cF1EqIPPCl+Xwy8kd9p2c2LpATyG+/J8Mbl6MgiVEAhOLfLKY5PVSkUocjoC?=
 =?us-ascii?Q?LrRpicQcQe6D2mfhqW4VyjGi6b5/Jsh/5Gs3xlf6XMQ6CXvgnkdQWj6FZ6ee?=
 =?us-ascii?Q?zM1Whiq+08OPLKaY+zGqE4iwPLu6I5EFpuukAz7uWuKYK2X+yqksd3Oq6Fl7?=
 =?us-ascii?Q?sbmJuJKmJqQ4sijVeGwJuYQO8RXmDoGSqLLeFtMy3ohZ+AKiiYKq3xtp5VRh?=
 =?us-ascii?Q?rNJRZNFc6d5p9rjgUUBTFdKWevGL4+tLYWPWvWH42L+iMkD7yH4PZmgcOHfB?=
 =?us-ascii?Q?s6dm1Pb3p4KjoL0cNshEOH7CBixOsYSyl0HgWMXi9ym0Gbntm0Wt1F+RUlh0?=
 =?us-ascii?Q?eDyMFn8s+kbr8zIw09IOfz3bvy5Jz/onfOr+ktUC5GV+eQ0xnt8EmaZUZu79?=
 =?us-ascii?Q?gQg0ryRz5AWmI3NMbC8HVvE3cdiQQ3lhxLn0gP+faP1l6sFxyw2NrcSo/zAc?=
 =?us-ascii?Q?fBFpHeBVgw2XIo4fD7hQUE0FRsJCXn0W6uxRFH1ocGI66r4HjyGJUAEIotlz?=
 =?us-ascii?Q?llJ45SUN9NQqdVQ2E2zxud3UY3L3taYHX9SPrIli/CwhGQxp05LHHKlxiciv?=
 =?us-ascii?Q?3/Iu4rxnGLxGIQKx7AMJNhTn7HS7kyHnu0hTwBLgvVr3q1gYWy8JX0XnDvT3?=
 =?us-ascii?Q?8YOYJEoREgnwchfCy1X8R148NadDlUf4Hq7DeGsyM/vACvQpAnEzfISqQR9G?=
 =?us-ascii?Q?6LiqG1TL39EsoFrrbSvWRbH8boEiqWklh4UhHK3wACms9J2TUYH/TXt3j1kE?=
 =?us-ascii?Q?AEif3SoIppvW4BTBCcvneRROUSE5O5Lv6EmU58EU5HfjZWIttZ1svRw6ZTX+?=
 =?us-ascii?Q?pXzbMV1xdnmyaQXkHLsZX/SQsDOsOqMJSmH6LKMUSOn6iWdgayvx7zqOb4I8?=
 =?us-ascii?Q?CO4J60kxrUGQsB/v4aSKyJSdrBVP9yGBQgrthuXSujnfbsaRyrEH/yjrUSBx?=
 =?us-ascii?Q?jdmRk3bUTYrpDEoPrcqWtSxDqMmGZImMbg6/IUGU3FibtHIiGk8788l5MoZU?=
 =?us-ascii?Q?7LHAwFoJ7uj4txUDVknULuLIwd474h6RE/DmSwc0LKyTSBnAHTImFBd7zsNX?=
 =?us-ascii?Q?Q/D2a5qy3NByHMwT4Vrv0n6Jiks78KCb6G4XHpihcXC/PnxJLbRwpF4iJguk?=
 =?us-ascii?Q?rcGkiqRh5Oyj6PYYimjxdiYqvD2w4dq61H78pmssQ23TKyDq4fhwTJR5P9UP?=
 =?us-ascii?Q?sPNwOOYOvdEWZB+8HYk/GPY/59XQYf0zKDa82aZu8oBdQxQCduJ1pODGDcvZ?=
 =?us-ascii?Q?h2rCrqzn/5Qk2tiBCf+uzFmdjNIdqEGDLcdWOP04bSpmtRT5LBXW6tpbrFwB?=
 =?us-ascii?Q?I5KQAvQ70h1xlJ0QA4JQy515CLp7wNQIfagGy0QgqDKwjkx/7U0kGsFJz7Jl?=
 =?us-ascii?Q?f8+maWxzDqYI1eLj3sgPAF4uBQbU+7bxDgN0rvOrOlMaTIeky+wAwQn+KLrO?=
 =?us-ascii?Q?KP4au1MYmDnW+jIuNeduDOfgUg5X9ry9O1BZNdROpmI+Auf29i2f2ASKf8ru?=
 =?us-ascii?Q?sJPIv1CE6ABhdu/ysBmcOa3nsGSHeS7PqtBlq9HM0DYKT6MMUrQ9+3up8XGt?=
 =?us-ascii?Q?ONAk/IV0YOeIrpX7kCj+eAM+T7VnPAWPiP1hsxG/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f0d001-2101-49cd-d0b3-08db7576a135
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:20:57.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uFR70QuExRdNrnO4F9r/ZlXVhLnQuF4TpPZ3bVQAZlH1oRhzkaHJsLkEAPMjNCXodU/CHq04ULLs/deu+miBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Add label for remoteproc-cm33 in patch 3
 Use Three entries in patch 4

Add thermal, cma, cm33 node for i.MX93

Peng Fan (4):
  arm64: dts: imx93: add thermal support
  arm64: dts: imx93: add cma area for i.MX93 11x11 EVK
  arm64: dts: imx93: add cm33 node
  arm64: dts: imx93: enable CM33 for 11x11 EVK

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 56 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 59 +++++++++++++++++++
 2 files changed, 115 insertions(+)

-- 
2.37.1

