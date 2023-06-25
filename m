Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2F73D10B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjFYMku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjFYMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:40:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DFE6F;
        Sun, 25 Jun 2023 05:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co7uOvqBGv+ifZeeLTMWRyodaQoFWOA8jcC2TGuZug4eT6U/nCMY865AcJs4hiYX1lLv7wIYFHyQQciQ0VrbdKDZ4D44Xrmr7Zb46RyreyId0jbJhU37VlD5z1ehjx7wq0/o8B521kRctojdLY0Zio01I8sa2xdOJN2nN1wnz6PwTHrbFEGQpE9p6giexLy/RlU21bUG2PhtF4WKGP8sSym+Uvh/+C3ZoAG7Mkis1Vl7C1CW3Qlj1Yru827OnVmKC3zByEZ7X9GmC3MoCPvHmwbuczpzclt/MFN0YWkNnBRNLa9Lg2K09Zaw3uzZ6gBytfWGl26EgjGpFvHt3lbe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuM/ukF/l3gZiDND4CA2zoFIs2rhs6lO+NSWfd9w6P4=;
 b=fJlcmwmAJuMqfq+skTfGzFW+xTZT2HEP1TiDBwgnD8mG5nkdxiNk4pEKEN5X1Ab0U3vJEdvG+d6s3xqQSYh3GQc2fQ6sr/qO7chFhA3gpIr21EO6Mp/Z8S0dPYsFtbeIeUxbsd2Dmefp7LzkWLyexHjcq+g0d2AhP7dcvuv2yyOOI+/qDWwLqnejaVakOapzc6jqe5wircHiXGBOLgYkOZKtvDthS2TtyURc8FretCBA+RJwBclD7FZUcuJM+qg3djPSFrkXawSP4r6RQMxyXKoEa1bVpOjIqx72pin1Aiux5/EuKev4DwpVm1pk1jbSu6hrdzwYUIzpZ0hcRPWICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuM/ukF/l3gZiDND4CA2zoFIs2rhs6lO+NSWfd9w6P4=;
 b=FG64nxoA7+wXgz8K4D4WVEF3B4BrP+xinxQHK7wZYV+aD5F0GKnFLuBjA0iTwPQf1WXmqSdMNVgpLZ2q8JsUQaoi+a7OCSaySkDSLc8T+khvWvSepYzyFGhsZfS4TSj9fg88fRiZ3wX4wEY2uWRdgfjorILi7Ft3+0fLC9V9TC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:38:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:38:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 09/10] arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl setting for eMMC
Date:   Sun, 25 Jun 2023 20:42:37 +0800
Message-Id: <20230625124238.4071717-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a6bc7f-755d-46ae-e007-08db75791007
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OM+WKKSKC3/CapjowpNtmNYfTQZ2zDaGgqksW9/2NZTKMXUsBA4Y12NCxd3Z6V+1cAQa+34UkfEGsnVvJLvLb7oD2jupnMhnCen05oWhQePV7xsBuPn/HjO11P2sBDzVnosXfOVkvizv+cGEJIMPVySMaBMfF7QChNlxAhRr83t2UDwWMYZUFl7t57+6msaAHHjp2UMxO/3NBs/+TX5CaBjb4H4ufTytxHkYxxIMBBkX8tarKRT3J6SzZMSZjNaL07kk+0aqgg0SGz6hFqGxHdR7aHI/0tDlY7xXbeh2tftkTyCz+UouXeNxb11gizEAuJt4ZzT6HkZ7rfuv9c8AxPa+QbNCtFPZXqhbnDgpbu4IkMN1M3o7J/I9mx9ijPzF0Qp4uaSIOEvp35we/HHbHRYsksbopEhb7fk7yM5dnlSA4hPm/9dhBYDmLDjwf4Qf72QTFRjgH+2gzz4mc6XO4/UanaYlsKYOJnk/aipkK5A+uaELJ0OiovNlB8/c9StaznLQ4oZec5Ez/BlAnCH6ZzPq/PcNTamhK0yGK88kSOTih6uX1fb0XxkA4yUQQey1pzwLzFgBZpdeC9VTN0mA4sDHVbflqUjD/QWVdlbOYf4f3tyfD1VYfZmhRcljErtC8QTPBl8J8Mwic/oHGc0MHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(54906003)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S+aLuqOaiyQVszKZCXfqRUQuwwJIckvWoV1E1PKh3MzasMcshkIFzljfc8cA?=
 =?us-ascii?Q?503NtVLDCeBG8X6s24WH88tNIOWIlwmTbFZpuoWBhwCe3ArqCibPm7pdqM3s?=
 =?us-ascii?Q?3x1/dzvzNtNayTsG8XKoVYbK/8ydkddfXXZDNTn2d96MjSXUGWDADetdS+Ej?=
 =?us-ascii?Q?Gpuz71gkf3Viej1aceDt/wwKYfEJ3B7cjvEkIyXYwesWgCPIpgxwNlGQUEt8?=
 =?us-ascii?Q?9JcfjZEwp1ArtQA5q1FeS8T4nIU1EvZ4gM2EtSqyfOznGImVUkbykuazOcyb?=
 =?us-ascii?Q?dh7UsLgGD4xG19WzF2dPxyBUMPE2F7NqPEocfs5DTyCkGkSpjHbIM5HBfKVg?=
 =?us-ascii?Q?yUoTMPF2epDZGL6HTIHO2rTBIyNLAHMMgZzihKmdzS1wcPRUI17sRdhZ+2Ct?=
 =?us-ascii?Q?tOr/XO8N2q98CcFgRWBhxQuzBuCEnx6c4MxXsEwNNxd2rgbT/bKvMFW3OkUd?=
 =?us-ascii?Q?gi1Vz9yuBrez4BEUBMkcsXpcZolAjiIo3LGmsVJXeIDkG/9BfGGT0FRdGxjY?=
 =?us-ascii?Q?/j8ST4gtEemGVCgRsrKC3482bw5zcjstnsl6AhIiMZD5mCBQaHtd3LzOKec3?=
 =?us-ascii?Q?3V8g4ApgWEnBH/f2Do80HUuZ+gmiT+LyJmV6dnBXf5QJkYe5MP1rbp06nM7Z?=
 =?us-ascii?Q?hMU68fmIWyzYfUficUz6hEBnB3/Dvivszh4kUgpOXQDYmrUHnNslfa1Wpuvx?=
 =?us-ascii?Q?RZPdV4kO+4uIPlc4LWV0OXa8a86dli6j+8JLIOQeQmAvoh0wa65TdpeKtWVi?=
 =?us-ascii?Q?BKZ/P0shrflTbP9xDOOfEEXZsLf5oGBIiDTRiVllCH4bLpj5Ao/6Lp5i9q8h?=
 =?us-ascii?Q?PrGf2geG/yDpv7oAcYCihk0OosLQBBztWm+0vpUpYhPu7dwUxuRLzP9U5lqj?=
 =?us-ascii?Q?pBcPw26vV2X2nPC7s7MDWlHpepixzwUwLREM3NIaUvwXJaEpmG3bhtiU0Kqb?=
 =?us-ascii?Q?srq/Mq4+nnPzYGKdzg36unlPqimE4DbtdvXnoAyVGgyLmYVt7mLENC4mDvot?=
 =?us-ascii?Q?hA6KtNF7dJBxH6Gjm9lf55YSWy37Z176hV9BK3RDhupXJCAfbW45BIFOivHC?=
 =?us-ascii?Q?FzcDGKndokRf4RCG/AG5q3B15+kjr0GFcAQinVlopdCLWjKi5y1b57BAjyye?=
 =?us-ascii?Q?Lk8C/62U8ep02ZItNoCwPvmZsn7k8LFNRuGMweiDFM2iVITfwM6qPAQ6jTgT?=
 =?us-ascii?Q?ywjCx0poILTirGgadJEizqrKXhp9vKFEiMQQS7qwZt/b8eZhzPPbO013CprP?=
 =?us-ascii?Q?qq+WfueEo0xEeld9Dd3ohXKQEpwqf+4h5xb8s+JGAhWWpF9vxk5XCjxHrDmC?=
 =?us-ascii?Q?oVzapsQjOMusucfgkDw+ghleZDcR2PkrU8m9Bp6tgADgeIiHVn9Upm1tKjHm?=
 =?us-ascii?Q?4F/wpWWdMmSG66tpYOu1FXjmrSyHdh1T9QA9je7aR9VDo3hPneIXLGzcy0TG?=
 =?us-ascii?Q?9HM6gv4cw+0L1cB71oBR7ZP91OAJRgMAZrVzyUELnFvZ3EbG4hhQFZVr5Mzh?=
 =?us-ascii?Q?YhcBGdtlK2AHkPOE0G5oLTlPum9TBWwGnUUSEjZyzSQlLz4+F8eFwy7wjh5u?=
 =?us-ascii?Q?b2WHmobmuVm9EUw1gpSDTYq6km995+gEcRUCSNRN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a6bc7f-755d-46ae-e007-08db75791007
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:38:22.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zv9TBrB7aABBbFbkQZao/S9Gvo/ZYLJ7MZ8XCflh7ebnANSBlZ6oPkwn2+tXVTF6/LPT9+6VtqglzEh0keIiAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add 100MHz and 200MHz pinctrl setting for eMMC, and enable 8 bit bus mode
to config the eMMC work at HS400ES mode.

Also update to use Standard Drive Strength for USDHC pad to get a better
signal quality per Hardware team suggests.

Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index e459dc35e469..ab7af705bbca 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -121,9 +121,11 @@ &lpuart5 {
 };
 
 &usdhc0 {
-	pinctrl-names = "default", "sleep";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc0>;
 	pinctrl-1 = <&pinctrl_usdhc0>;
+	pinctrl-2 = <&pinctrl_usdhc0>;
+	pinctrl-3 = <&pinctrl_usdhc0>;
 	non-removable;
 	bus-width = <8>;
 	status = "okay";
@@ -202,17 +204,17 @@ MX8ULP_PAD_PTF15__LPUART5_RX	0x3
 
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
-			MX8ULP_PAD_PTD1__SDHC0_CMD	0x43
-			MX8ULP_PAD_PTD2__SDHC0_CLK	0x10042
-			MX8ULP_PAD_PTD10__SDHC0_D0	0x43
-			MX8ULP_PAD_PTD9__SDHC0_D1	0x43
-			MX8ULP_PAD_PTD8__SDHC0_D2	0x43
-			MX8ULP_PAD_PTD7__SDHC0_D3	0x43
-			MX8ULP_PAD_PTD6__SDHC0_D4	0x43
-			MX8ULP_PAD_PTD5__SDHC0_D5	0x43
-			MX8ULP_PAD_PTD4__SDHC0_D6	0x43
-			MX8ULP_PAD_PTD3__SDHC0_D7	0x43
-			MX8ULP_PAD_PTD11__SDHC0_DQS	0x10042
+			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
+			MX8ULP_PAD_PTD2__SDHC0_CLK	0x10002
+			MX8ULP_PAD_PTD10__SDHC0_D0	0x3
+			MX8ULP_PAD_PTD9__SDHC0_D1	0x3
+			MX8ULP_PAD_PTD8__SDHC0_D2	0x3
+			MX8ULP_PAD_PTD7__SDHC0_D3	0x3
+			MX8ULP_PAD_PTD6__SDHC0_D4	0x3
+			MX8ULP_PAD_PTD5__SDHC0_D5	0x3
+			MX8ULP_PAD_PTD4__SDHC0_D6	0x3
+			MX8ULP_PAD_PTD3__SDHC0_D7	0x3
+			MX8ULP_PAD_PTD11__SDHC0_DQS	0x10002
 		>;
 	};
 };
-- 
2.37.1

