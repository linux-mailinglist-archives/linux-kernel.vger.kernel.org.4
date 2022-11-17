Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167DE62D777
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiKQJww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiKQJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:52:44 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB459175
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:52:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAj7cBf67dgOeGlP8c7Y/Nnd5d6gcWKilFSTZbF2o6fsZfFNdEWVxO8V06Ln4btXwayLHqYV+lQk1f7Kk4xTZGIIBuGgo/9tzzSYpyOw4TGUJw4wSyHVDHSvS+Hi5o0iit0/PIXs+U53aCDu4Fdwak8Qs5olL+7Kf4ZqSCNAlTT/r449sB6v8o5bEJxuwd2lJ2KIkDJGKrUUCA20+QCuP5TKW+ymOmhWW8IVpXD5D63Sjdj9PjJ6chJuRZnT0K9LVB5qzXoDOYjL46QMVZi8v6RSLUTXPN4H5sHeoprcbdmG7+rSqHtsY6VDRtMVP/0M8Ii+N+8c+3jb5NhsrdbMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao6NseS8rbvP1++u5+L5yna44qijHUMTNj8N9eeGdV8=;
 b=hUkQVbgeO/Bnx2xoRUBlBaeAjEPvoLfCDYBUFfx+zJSuVDA/v13mpEE7sMSuwVAnyJ1ntL0kKaTeJuHPqSTHwxFIxDzcVKfQUJriTatSPGClcHtSkcaRlqYa2nn5TJgGN1ROvk4iuLmipZbb6Elg2iEn6e4agrQhtcTNlAlilRu7Z57l3IROI0xpt//9HUrSdi2wna9tNi+E+nopCzhIxT6YtHl8csDXOLwxAsuYJlTMJtXJ9qZR7etpN1CnL9SS6V0G7V/BY5TZBUSgy9bip/Ex8Z1Wa490hOxMFmRQ4R36wPlDdU64nYuYNcvNJsVZy4Jl4smQN7f1r5ffcmp1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao6NseS8rbvP1++u5+L5yna44qijHUMTNj8N9eeGdV8=;
 b=Ox8kYFFEjmPoPLK3hr8TEWhw5xQ51FlJLuph0qM6p721BTNSOobVld7HXjWRLN2EoSSkEgf5o+meBoi30EZHC147R+FLp7/hxATl8gBNgX3RaBSx0EZhj7AAp2cWHLuT+k1+Ce+sFk9NLszGNuT5ttdVtOwJPoW+A+cpAdyr89k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:52:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:52:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 01/12] arm64: dts: imx8mp: add mlmix power domain
Date:   Thu, 17 Nov 2022 17:53:52 +0800
Message-Id: <20221117095403.1876071-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: c462512f-8ce9-42f3-5367-08dac8817771
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69ImQHIqazDYKgeKuhURYvtmBjNCqmd+uV/5CwAzeomaQv6qt7HnNftI2qdy3SovydkL4snBI8Qv46hyEGiQuUzkWr5WUS4blg2Azz72JFqInFJzT2Zr52sB1PpX9AWPV37mN5xiBBfpvxkgR8eTVQi7hEb+dRt7zxo6ukwGMq4goPuUqGGw7jm3dCZkEfBVIh3AbYQNMy5BFEyUThqStglO4APVwdmqprbYPRzpTVsHMvNRiJ9DTdgWxVCgmjDjzZihxEeIw+ryovJu2WTREtMaFf4mw3yWgP9XfLwAp6MqyNIq/vLWzSRC0x4mRDLEWs0mp73MY0N92H9KVX6+ThQ+o1NUjw8E9QuPyIk1sVsW7jFuy3eXWT/eIL2yat/TK0BdzUh/EoFqcmleU8itaF4pFUafwEoUcW2KOMBmCb7HsecZzQ3AqK635+1piK3fhUaIZhYKnl/wq48UKfEq8zCUINnribJDE4ikZ5jW6wMpL5BNv8ICxTQru/JPnDbFJ+dKBoBuHUef7E6XnlkNnvYxNUYVyMBc9vmYxZA23aU/+H8sJCbw6qLu3zoX5c0UpCE/l5N73uAdeFGs4u6CmGTpdqBtrqaMz2PzXTysvTw2sNJJOVrjQbEEhWg6pIY54m0tZGYbzgwoO8QXLdkSCfMDBdSCjeMAUpoYYqXzH+OCrVZghCzlEKh33Qm+6opOb4x4UPigTtssdTK0jW9P/CXJFPoawYO4uGKuY6xLFJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(83380400001)(86362001)(38350700002)(38100700002)(8936002)(4744005)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(54906003)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ZpWSlM7BM/SRaAzv0HG4DH7Fxxkowkx3cUyu7Ce4BzKx5M9sSAa8PJ3+sO1?=
 =?us-ascii?Q?pRjjlHRaAyjjTTCxT5JlTZIR3Xk7MfhW2taMxAdW4rM9oMYxGAs8DLrOvhu6?=
 =?us-ascii?Q?Gn4ZNbHMKfvBf4GuCmxEKD4zCXxKgfIAx5eGOQUeONzt0jDGAbDambDWog8K?=
 =?us-ascii?Q?rwSc3gCoRckmyukoVjaRf1Wc8Xyb9i5ddsuvd9tnKxmrc0ZyELztlHdaQ03y?=
 =?us-ascii?Q?dhDYLDc6l5o/R/y4o9bGXz4SxpQ5HKRHpeZUIBehwhM5kDDek8bfoig9HQDW?=
 =?us-ascii?Q?w76RxPcc7PLOZobz6O9b4wcdCILeZ9Knu3i4worvty8AZcf1lLnegn+SnKCX?=
 =?us-ascii?Q?4Xu7N1V1EAdo6DG4Oh0qaLzFYWK2u+GgXvoeSnUIn7BjR7+oHzqGsfnbs8hC?=
 =?us-ascii?Q?w8kB5R0bcq/ed+8gZl/1yDXFlPjGs8rov4sobC3QxxzaKOCIYdLbc76S3V9P?=
 =?us-ascii?Q?TH6C+3pApREkcq6ecN4ZypPDZYTY6li6aWt+SRPWQ3YRjQkwoHahIoYFXQk2?=
 =?us-ascii?Q?Ko+sM4tzq+gXlUK9tscf18ZsP1eHb5iE5+KVCaMj/WWuL8z5UuJbZzW0r+7H?=
 =?us-ascii?Q?Iqw+xTHQirkRf3v7jZr/vsyQAGYmDquIWcHhRfasgKcalHkKTo21cKuZ0pNd?=
 =?us-ascii?Q?TEePkqYKGBmWSJCikwPCH5yB2Hs2c28VldhfVcjVNYnwg82iIpQM0P21j+JO?=
 =?us-ascii?Q?TJsHnmH+Z3xHj6mg1CHnNnSd9QG+8XbB5rbygFLmSAdLP9bqTHdeA9fdOFkw?=
 =?us-ascii?Q?ZsfeMaH/YBEYDTeGLhcie4D4s51l572zIBrgX6kOVi4myaOmumJu5egm9kq4?=
 =?us-ascii?Q?MYbzrj+5KY72ON1dxZqGExn5aOWb1QC5H6cJz4zPjgCkogPcP+DJ80Twc4tB?=
 =?us-ascii?Q?Hu3P9e7iGNGRG0UXbVi3Z3qoK9Y3hMyZ+l4U0MJDxabcqd3SQzXVsy0TbN2O?=
 =?us-ascii?Q?WcJq+Q0ynlY3I2zQCDr/tMY+F8LHLiAyeUXSDPA0eTrT9/BqdjVkTcG0AKhx?=
 =?us-ascii?Q?JrhbUFzEOC13NsAPSY+t6xqym6RCsGCxzs08y/sMKfA/5X048AWJTj877Gto?=
 =?us-ascii?Q?Cc2g0AtIixprnbQ/QY/VAVtxkgRkXNbq22/ulHTwtysZgWWyKEs3hY4rqei3?=
 =?us-ascii?Q?UjVBnEgI+dI03iLpE2e+CBA394INJS5maO4w2irEj0PfcGRrfJAaNGAEsBtW?=
 =?us-ascii?Q?ARJQtb7Kg33NYVFb223/97zTWKHPiXQ0qIy9qMlpX37uWbn98cXTVP3EzWIJ?=
 =?us-ascii?Q?pWzIg8/XAcZ34qIM8J/GxvgNm2XMERFfxUp7KGnD1uggghjUf9JFQMaOGnef?=
 =?us-ascii?Q?vGpzhu/BCaaLYFLqZx9BDZXjcOK6XGF0b/ofn+snJObzrGawapQfhJwaT3uP?=
 =?us-ascii?Q?fGxvp2AYVXDhzQdaAO4yxRgNev0xZt40fmHhIe4alJq76ivavVGDLEuYqXWI?=
 =?us-ascii?Q?uIunWM/5VrHYTgSfE+2I/+3V/gvqa/K2btYo5SmQk7Z9B+pvvONhj8YQuFsW?=
 =?us-ascii?Q?tqiL3LJUxB9cQJwcY2yqTyrv3UG7IZyA62FwA4HR45XaUa028DPrXksws2fM?=
 =?us-ascii?Q?UyNvpcNTLPekhSLjMLjZlsSQHNnqX3JZGL++i+4b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c462512f-8ce9-42f3-5367-08dac8817771
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:52:41.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ27B1naLK+g9ofhxKzkpKYfQlLtEL3RIns8PiYDn3zxS68sEojpAku+WxbFmM4L3R4qht417EIy/fBJ2UmDeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mlmix power domain

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 4fc90477b419..7a6e6221f421 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -632,6 +632,14 @@ pgc_vpu_vc8000e: power-domain@22 {
 						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
 						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
 					};
+
+					pgc_mlmix: power-domain@24 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
+						clocks = <&clk IMX8MP_CLK_ML_AXI>,
+							 <&clk IMX8MP_CLK_ML_AHB>,
+							 <&clk IMX8MP_CLK_NPU_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.37.1

