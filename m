Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7596FD948
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjEJI1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjEJI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:27:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B6A5FED;
        Wed, 10 May 2023 01:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6KLWO55MqvzF3/YM0KwzeMCqkF8IyzMN7WyrIhaqg1UduIrFLsuEph1VPypKTwpulp6gooLj8Fv96bnO24q9H2ZtC6AdPSw9uzPmhKNOaRN02ek10FGXmkd7ySps/jwOuJFEOSSWazbi8RoPRFjKQne7lW+NK+Kn4lYhep63kqfkQdNT/A6U147fa2LYtHoAjDg/LWbIHa+dZNWJCjdZ+fHXuVxlHT9sPlFjIp02E01/nOw5X0LyMUt+K2iWZurw7b0GIJ4kuaLZ0pPEJ40GPC9/mT1N3nzSWxMn+STD6ABnudzfJQse1x9eW9KCQGL3+Nf6FTh1Ki08e93H74CxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qegaFl45+xzMrMOJwwFxmetKK/iBOUIW7nwB06pWkNM=;
 b=PAX5pTAINtQ24TCGZzg35YiZ0MpuY8GfgQUoUT5ykvkJAG0REPZpze1bf06a2UttVL451egyCGgd8ALmL3kNVaXK5FleKckZXJlbvUezOlM4qwIi6czx52eOmUDOzsco5C5NLgiI0ySBM1aRuSDuV3xz5d7aALWKTLeyhHYzavGIriVbUly0YkEr5whE4FtHmaGSfYM9Yzae0y7lrthSx3tDZ78BUiJ8n/SXLkoI8piulJvcaN79bwi/Y4yRnRcdocxawKioYc41azqLHnr4DdJQzIRgY04MBJw5RQJGieSFK2xqxIo+6VWEsDfCNSlNp+fXbfApHjNPqqqnlcVljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qegaFl45+xzMrMOJwwFxmetKK/iBOUIW7nwB06pWkNM=;
 b=FfTonCS/8niTHToR3qMQlG3L6CzNU7BGv7nz0BRSZyhtgoRq7OYq5ShQ7c/ip/tGmaCE6RHzODVtY1ehQMlLiz1QEEJqvt8vwVbn2ZOZVR0oNTHoZayfd3UwCSRirZ9m4c6Je9Ms218Lx4SS0kiajWhA5owLK6x5INLtp3SufSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 08:27:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:27:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/5] arm64: dts: imx93-11x11-evk: enable wdog3
Date:   Wed, 10 May 2023 16:31:53 +0800
Message-Id: <20230510083153.3769140-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
References: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e58734-368d-4cd1-eb7b-08db51305bef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gv0PqyrrBs5QgCB2X3vJNvbiQY+0iiM5viMHrYOH3bNJVnQxGqaawcQ32oJ9Op1/x2fo+x/cl+fvk9GjQzpRoGzdUx02WYKCpSHay5I9uU5KadmcJWUn8P74VrUyJzNL3agoIj+I6KMJDdc09c+IvjnYSYYR7jVI5VLRZKTkAMndIsCNvKl4duZ4tAE/Aw/N+Ue9PJnXlYUDqoGwMhBZTvUE0/MzHpS/XHSW3fu+Cep1jfQcmZz5aYnW2ipak/973z98txHc+UCmsqMOGvUSlAypzTUFZzU8FDTNtbH89a4YtlIc+RMIyfZJK5boHhjjYHVGQy+hlwe/R/oB2I7eDgle2Iq6maH8NLcqX7CYO+4DjnnFfYyhnup6jJQb0V7RtdozM3EZHpJA90AprfCoeNIvFbnxCsCFWI8Jufvb3m6ic8JIkV35NckVk044a0Gkn+gC9Y5PKaurpKjvPl3fBw2OAnExQJibKJjd/LvKx0aJolzoehE5D6qfjvlMmwLq8zDmxwSXqQNFhG1XzHGtwHjI7QZH4mYrl5ZfkvbCSiFV6Y2WNPxEwD1Rqs8gQ3GaBMZlE/QFSoYXTAdJ5l4xV4HA2NqZnoT6TvhcWLWnmuo9lK36yp99EhG/b9nkY8N1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(38100700002)(38350700002)(4326008)(8936002)(8676002)(2616005)(66476007)(66556008)(66946007)(316002)(41300700001)(6506007)(1076003)(26005)(6512007)(186003)(478600001)(86362001)(2906002)(4744005)(6486002)(52116002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYsEbmHRBXfHdI/dGxhdh/5HjqnkT5e/FO93S2YySKMrM1/8jOLRt5HlzGiB?=
 =?us-ascii?Q?3OR8mBEXyPsMa9dWgdDD7Z9Pq85ylrQgtZLx9ZNULmThbAfDeRRaY0b4Dg5X?=
 =?us-ascii?Q?2CRi4cGsHjYi5uB6Vc7LgmEnvtrzHNIQL2Eb6IqXAHZUSOiyk4rNRRkkBT+j?=
 =?us-ascii?Q?v+Q38yqR2n/SscKOKH4fRX8MEMNDGNg9OcJdOUtpblUQGDA5T/KlqxbUGEoR?=
 =?us-ascii?Q?qLtpGjrxgrTy+WuBGHXGw6qK0wLCJ7YX1D+/Tb5wZ8hLOk6sRdyHBcjU7mlC?=
 =?us-ascii?Q?h7rbqjh6cDJ+BkGw7cPGSEggY+xrxXye1jIlxMaSOf0KnJecfJlf2zsYvLhN?=
 =?us-ascii?Q?R+bswKtBHcqhlglTNzeLiBw/WqUnB1b0CZ3H6g/ujBXQLnsQI0XAiHW5TJOr?=
 =?us-ascii?Q?8r4BNyLrxNhZYD6lmJ9qaLlHaTGyNE7Pk8S02EwBJYgsJ9J+cBCwk4l1f3GA?=
 =?us-ascii?Q?KyPOx0kLu0dbWaaJ+7jxOHE/+EIvnpfOcv7E2WExfvh3wgLh8DIqA/3iakR5?=
 =?us-ascii?Q?gzEOBjDn9eEzxEzmESukDBdJRQ0eS8y/Ltq5TmwrH47echxxbycZM2WL6GCa?=
 =?us-ascii?Q?OfldGDmcXcLPV1t+EdUCyvPnpd3jwGoTWKqMt9WRGgEipykFHGtYgpPlEusY?=
 =?us-ascii?Q?XkDvW0qcVn+ubj+GxuHIb4Vq/rlP5bzTfKiniX6NV4TlvTvCotzASBOmKNOy?=
 =?us-ascii?Q?0rug9KFg+z4j8wi9HQ1eqQ0Ri8eERZiZuV9Cbxe3qifZJjQocmD42xT3LpHS?=
 =?us-ascii?Q?1ADvlEa/VgM3o9vEASyz1TSnuwen81nPQnzILLyAhrN1OD+mlMSdyfEV0egF?=
 =?us-ascii?Q?HixB3M2CmhaViLi7BXZuBBOw57l9Rz/LvGs/gSpKhFcPpj/L9xX1lD+lgbHt?=
 =?us-ascii?Q?9xA2b9YBMvC8sxzQiHqgws3H5rAk32xpSK2nEq8najvAseaC8E3S7NMeqqm0?=
 =?us-ascii?Q?6talsVbR1lAndOxcbwnZ5Fo4Uja9BkJwBg+OOJE28vPAE+tY1UTVM42VzDdO?=
 =?us-ascii?Q?42wqliZjQQzp6kJXfZwHChG2gTqioghk8FViNysN0mIdB2Kwfdp2eecjJUpr?=
 =?us-ascii?Q?QLVWUTLZRElDzqhck1jcn4KgwumA0Xi7q29T19s71IPK+N2YO5QovBmxKhka?=
 =?us-ascii?Q?82gQjvkUgF58Eb3llnrlZsvDWhGEjMmTgsw345VB+RZlUiK/5iUO9yVoYl1I?=
 =?us-ascii?Q?2qMT86L/H1qN9k+yypnrWoiaCaj1MEm1DZmCA6I5POqH5Wk9E4T7nyCunySs?=
 =?us-ascii?Q?zYC1TxpJx/seR4ayiwNQsfVDgP9NeV6ly0FDWyQThEywSh4YdmFtSiYCTaaf?=
 =?us-ascii?Q?qtI1nl12vhU6FQ6bHeUTXkN0RVlrl0Yq+N0iCmSeXD0NB4VjXTC3QX4pFFEg?=
 =?us-ascii?Q?a2Qn2xT286mqAc4dedFNjdnKuBMHpii6Phq8u2/BycKJC3h3Dn/cT2O7RQ5r?=
 =?us-ascii?Q?NoCN6YQ5+zI2mNHC6caDnZYFmMdftojuLIXLjG6OBubWjGs4cw56i+A7KFbc?=
 =?us-ascii?Q?m62r4FACFGmkXNfYwCjOMJbhOmY7PhipdA9QSHE0Hs1MisNYcswv9cV3Css2?=
 =?us-ascii?Q?gtz6OFdJtUddDBC6+Ev96NpbQDzbkzrjEdOazv0L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e58734-368d-4cd1-eb7b-08db51305bef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:27:14.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j31Qd/doS0BN9a8iXl5gtsu7b7GpxkVe2oPDTrowi/V0oL+n6wviD68Wi2OfFDpAEPCV23SUYuD1JAOlWFM72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable wdog3 to support watchdog feature

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index fefb93487291..c50f46f06f62 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -116,6 +116,10 @@ &usdhc2 {
 	no-mmc;
 };
 
+&wdog3 {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
-- 
2.37.1

