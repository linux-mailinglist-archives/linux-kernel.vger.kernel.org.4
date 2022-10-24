Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103E760989D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiJXDQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJXDP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:15:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2B676546;
        Sun, 23 Oct 2022 20:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0f3NUnt3AWdX5iDxD0bQR69I4O18+FCxEr2QQeTjGYUfEpaNM4NXk/YW6ZLA8V68LBrUOfi2Fw4ayYHMeuP/szmgrQi/wQd9NgKGKt4V+3OJV7KDgRcYnBMe01ARGm5NN8Q6Md5dEKvFHhPWz/g8zr9oSSk68q2MRL4dxnMPdQ6OAPzRINy7YIaRJTcxB0eIIjVL+hFITby7/vhPnwHivKLZ78KyCo0jD63aKGn6EmnX0Twnww9LkFBfHS/yFfoe3Lbu5Y5O9Gdtbcgjj7qJWMVjQuqf1Dg6DdWiE0AdzwI1iuJBNuUp4O9i90jL0plDUxdY7iRXNqSkJFBtIfLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45ZlfSnPATcVCkuW7OpkmI6SoUKfZvDq54LQHVB8cN4=;
 b=koxAce1vAGSwQH6LgUOgZcfyVyOxVIATGkDgshw5UU+AaeqigKP5tra/opfCtC/CkrtRerjZyOHgcf1UD3yvlVw/6mvzJ2OHTMgLWuvmL7I8Y2liJeoOltzpZvDGRSK8CqiuhmwKyN3ZtFzSUxL98KILZCekM0fS6Ep4QaBzWfnrELKvy5zSfjnxna0fSa4/pgLfezrPg3C84iLzYceZnh4VDbs4NbFPWEuK5n3uiVQDFf08nMIYVTIUO1yjVgAD81TAMEbU07k8Diz/ufzhKubFmLCOyN+BdhEaV7d2B23cwapX43SLWrbPPTAHg168ijIig5qInm6rvz23gceaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45ZlfSnPATcVCkuW7OpkmI6SoUKfZvDq54LQHVB8cN4=;
 b=XzchkRWwOzdhqQPqL0KIbuh0dezlAnLRHX1cPTB8vSoagGWFvEGLo3nFk0x0orHd0T/XU9niQMHea++gOX3R4ycrC900y0RIQZMFN9ZNlyWWRH2CXghXHNkJitCTzv6L4KVJIligSr8Gtm5DQRo5gYG+NHRWlOUdm3Q17q1aw8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 03:13:15 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:13:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrian Alonso <adrian.alonso@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 15/15] arm64: dts: imx8mm-evk: add vcc supply for pca6416
Date:   Mon, 24 Oct 2022 11:13:51 +0800
Message-Id: <20221024031351.4135651-16-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 60102b10-95dc-4a59-397f-08dab56db0ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qG0FMRaqTo+Q4rcB9QTfgYy1SXysZmr4v3kdB3bH4KMP+uIFvNAdyBQSdGoNO29zXmuSw4EwUyCY9zRXtnJZg/acfWymMB46YNIDBAoP2Yt4maK38pUWaHVKkvPbEVZfW6s6tPJOJZRPy2comzWTRl0uXZlC8l6V6nlCC1sTPmrsgBGRaKkjE4Z7HSjJWBR+xGZTeUD0cARecB8VtwPB+Y5yUJ6fgaYFrPQj8rAaGh27b5NPhwJMZeNrWjQMt3a/r5s799LHU0b1eUvgWZmV2OJv9g8yxsqw93qpAS6c6HNap2V/xJ46sQPpdZDRmNAlaEbwwGieOd6ABxMd1M45wyjw9iOnZgJAcYDJhfenXrL246gkm7/9po2fmbIaNWgBaor8Sx/YJf1I90/BuiohVCvOmkHfL85uAe8R8stfzRW2W1TuRUhdsUugnc8m2qXfvaa/JqB/JwCQV86B9Daqzd/7pw0v5ulcMhGk8UH7qv9C+zN53u5FHsvWOi4OZrad0mxSBtj4j8orykFFTVwCPaWSTl0sk/Ivd08L6zXx0tDwsIqa2gJVNycg3nbHKSgAVOp34Hp8h8yZ3y9gzxmDBd2x2sYxdpVli/GuRgtyLmE72oO+uZIYhXGIRPmdAqt3WONd1iEyXiINlzzgpZnUEopL6bO7UfScYvN3ATzL2AZdga0STgxFm4u5r4Es/tfeCvqSbhL01LiYNz2A2GdgRUYO8Vf22sbG1FQJzY/1ARVdB3vR/6cH0TLsddoJGlp63+x/9POxrjjqzKrde26IhsUDkfB+IBznBA2R4Lka3SI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(4744005)(186003)(38350700002)(38100700002)(8936002)(4326008)(2906002)(66556008)(66476007)(8676002)(66946007)(5660300002)(54906003)(41300700001)(86362001)(316002)(2616005)(6506007)(52116002)(26005)(6512007)(6666004)(478600001)(1076003)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D9ER5AsmyXXUFLiHyk4Yrp89kHJstez4PlWdJBCuhUjS9BgSLf4Vn71vdsGq?=
 =?us-ascii?Q?wCs9ZRV2AhQk+/3/yhD+rLNdVobq2iPkeAPo083A0dJ2oBVj4JLKvsGpReKZ?=
 =?us-ascii?Q?mFkRtr5jN1Yu7/RIvaD9Ekj0GrmaJliX3Z8yrCfsZiiev6hGct+xiC4MKpr8?=
 =?us-ascii?Q?efwvFnNRu2cs74aHR2wdl8QIhsyje60Gwz1gieRKQ90Mk/0RutfFA1Qu1VWK?=
 =?us-ascii?Q?kqD74E4XQXKgNIIF/YkrdT8vW+UszPi/EID8BFKreBcBvTxv21gjh94RyXkb?=
 =?us-ascii?Q?rZlfzufC88CbWDl1Z9SKLJLmfUlJzzl3gFIdUzh0YqZ8A4K5Dyhbs6yFvmoj?=
 =?us-ascii?Q?NVlghTCQGmc+pDcXWbHUi081TLI4vcZ74aNMKZ0EwaPijOXjRat6m04Ni7IZ?=
 =?us-ascii?Q?D3a3hcNJeAvXFDE98WK3hq3d2kdGj6CPgOreU7gNzmBeUIMZUV8H9bPZz2Mx?=
 =?us-ascii?Q?LMvVkXJnSUSoiYhDYaoHY+N7+X0NYuzeDyfHWMq2oV4SLlf8gdyid4qaxLA9?=
 =?us-ascii?Q?K66LKkZSjj/11pDg+WAc2xJ9gAK8BPa9bpuO/wPNE30okIea4n3Jw6TltxOr?=
 =?us-ascii?Q?fyRGh6PLa1HEP1B/SfUf83xs19BGRcyYHpMQLcY/vknVBtlQc4QV56mCbzUV?=
 =?us-ascii?Q?nAxYrj7HKDDDc3/vdT4jP4VhnR7qw5G1YMwQAfk34Ps+U/HfjyVxUhB9g6jW?=
 =?us-ascii?Q?PL3cZOwffeIVv2LrcjpDM9U8FTrJiPVU/5/Jbdfh8Xv/BTQR4vKunsKzsc7i?=
 =?us-ascii?Q?+KPNXoWEqQBzbnnsfplQzR8grUodsNiXwl/Q19gYzNW54yAlr4MPhnOD3FLr?=
 =?us-ascii?Q?tXH6CsJtN4aISEueUX0E+s3NrV5zYfm0fPUbOwnWAZX6AeZLJW3TSBDQ+7ZW?=
 =?us-ascii?Q?J4n1fVGnhFkeANpL+Lh6Z9KE2azZ1DmZGvi4PDv09hA0SCBmDl4ca4NsyZI9?=
 =?us-ascii?Q?xcqkti2ZsOdVp3tlPNrGDp105BVcB4Gn9Dg+q7TLRz16NXibvrV9zJKsylE5?=
 =?us-ascii?Q?Of/DXavTMWvco79cbehfQvhRuVz0vU3q1q2GBBHWcrcPSBDGF3EGtQroGON3?=
 =?us-ascii?Q?V6t+UQjSxgDHMMTuPvQzSuw9WtddP1CuELCmhUBBDTBQwbrDrKGTKgUP17eX?=
 =?us-ascii?Q?YaJAZKihBaVwbZ2XDL7eF2IF0VT7dhKgNzGVWRIyjRYwfWerJmSlqG7m5bYn?=
 =?us-ascii?Q?qBwWNJIzeLyVnz/TJQo9goGJ2aUWeBlQeUhsOOvA0oBP1LDe826FeCliKXrn?=
 =?us-ascii?Q?InMQ4vvpmO9uBNGVpkLx4HNXJ4aNQEtNSJ520xdt+LwrVAM+zJeP+CkH8Wzq?=
 =?us-ascii?Q?mk5QLIbYQCgltV3Ve13ZGpEk6bK6kFqvsp7BzCvboqewA1+H43sWXKO/kvdc?=
 =?us-ascii?Q?+AtR0C7UJ2lcWylUyUqqNjPUJrx2cIYdXWKbBLKfmNOPcOEkkfMZOfR+DgIc?=
 =?us-ascii?Q?ijId15l8tod9AHXhREXkcdkkxrn5+raSHzmnmMaHhSNLuhLEXiaOqULiAPcW?=
 =?us-ascii?Q?uKFmOkoxObU8h2fY68duWbBmHuoIYUKp3ICACkYkHEhh7jx9nL7QAoZzyaWG?=
 =?us-ascii?Q?czgHQKj9QBiwZHrV1fcCVxV0OpdfIpI45HRbTAEl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60102b10-95dc-4a59-397f-08dab56db0ef
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:13:15.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0+DeCgt9zEeR4mzlMEeltwNCkR4DKf+9MiaXxbx/HNQ0MJ0x7bOJHc0Lq45G1ajG5/rH8AK2b7iwJHTKyFSLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825
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

