Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7073D038
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjFYKxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFYKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:53:28 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFACE65;
        Sun, 25 Jun 2023 03:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQaKtGM0ypTuAccCYa3MATS3mME2CLTu8cZZXLzaSfXaezdngsDTns0ssQh3ZPkMyx7oGbV+IE8My1cJmLuVkkjg/mEAzkJ5NZSy4e2Fm+AlLxJwWrZPOpP1c+ocKLuM9boTiaPA9OdINYVAOIf8Pd9mGHnqIOObg23WtoDColHaDMSMaBeRPAeslX5rffTlpfRD1glj6ZfruTKBvTPBEVD74ruZH2J3Y4uz7JsxrBOAGqi0iSHn9pN0IPVmofhOEhSfmcUk5UcQ1jExhYjDScGz3A+ZrwRCXKPk2jum57t4krBkOVEOgBQId5VmE+UnYuYxpKRJ/3zZt4pEQvjJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t7pbEf5/Uzs3rhuH43fYbuwS56JW2Y/5FDf/X+BR2o=;
 b=VeWh5vnoQ7bzKaxvoAc68RkCJSF2qjY27pPjJ9YtxMCxhq+DrfR/L5/rmbf0nZvJjaM0wTXoE3jkMOogRCDhN6DyxiWqE2ZeQMiuPDBfy3FhQt8SItxPQ+zJnkweG1ukLWxvniA+WBQ960aBOMLqSRWtiDsCf72yr8e9yejmoTSFtlX7MVDuLdHkMSaDRyJMvlM70zRToMzPZORcKaVcpko6xOIShGQ7vbfKESY/1356t4G83SvPrCT8h5Xnu9jknL/0HIP/cFgGJQ1q2JxLkC+KuK7JpQbrlWJGY090KrTvTuhVV4SqfA3a0u9ACg28CcJAIxjwsJSr9LCpQS8Cew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t7pbEf5/Uzs3rhuH43fYbuwS56JW2Y/5FDf/X+BR2o=;
 b=NoosbulWPjJkgua8H/wUKr/PY2z+dRswTLMF6jHaeXYjmF7IipQw4nUOIwy336o3+7Mv3whmLrrAUE6UERpnSJ/PtyDLpeLusKphhxZ2bB+fmdMT0I4KyPzolOqZSJAJbuqcukhkogCfGHYiOlRLnckUOIdVFVr61B+QwAg+mZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7928.eurprd04.prod.outlook.com (2603:10a6:20b:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 10:53:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 10:53:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] arm64: dts: imx93: add cm33 node
Date:   Sun, 25 Jun 2023 18:55:27 +0800
Message-Id: <20230625105528.4057850-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
References: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c12a5ce-ba64-4e7b-78cb-08db756a6619
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkvccJyfHz43ca1HkKEA8adBKp/U0aiCsIjmuTXrA0rDhokoepDuT6PAltOdh5biJ2GG4xA2a+02WPpBEUgKsNbC+2QtJKqvApwiEwBVCcmUSly5XWjfoXiEzh3iG9xZbtNoIpRcsT1phjrc/+yxPo7kJzu+h70XzRhfv4GFmudcw7rt9BMafEx3RZhQwLYDBeB5D6xl8/nRg/QAb7PY3QLdgDJa4MNU5zxcDxEbmCPEHcFaBIxJIOlDRFn4MCpolCg6aUpxMd14fvgI1nMczfKqSQssSVbYsjRVfRS66EaFIF/6Tm3mESUh4QLXDcYfRtwqgMI8WNfJBOfq9WtuxfDs/NWw8mO4cBFaXFeYDoakRzaOWuKyb5jT7iFWFt0tCOh/oocGFfq1X2ws2L71CZ8uZPKiLbmrK3vnAy0Km1AI2J6E4FKVvnZ4+F2t2K81ouZdmgFBQnYdZtiCFUUrKPIgA5iIUi0wX894c2TSVqV23BmoO7hSA8XHPe9yQffO7Urhd+ScaLKhaqLMfgv6fYuZVUd/R5QfDRBRWpNqBF7HK2L/7n7yR1gYI00G9g3BzEoyEaFhY0RVFpEG9YLuocphBlC5zAcH6ILp1aKWoxrPm9varKf/fSzak3+ghDTM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(316002)(66946007)(66556008)(66476007)(4326008)(478600001)(5660300002)(8936002)(8676002)(86362001)(41300700001)(52116002)(6486002)(4744005)(2906002)(186003)(26005)(1076003)(6512007)(6506007)(38100700002)(38350700002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U9JrP3ScybO/zItg6u/2dcy+ZaqeXiUbwM2mHRAow9VNprWuTlGp4vb0Tfgk?=
 =?us-ascii?Q?E0+cIUCKlvWLV7VOkWer0VgW2EFXX57LVVL5k7sWw2rM/Pqh1dML2d2J9/aY?=
 =?us-ascii?Q?8Myaf+f0lgx4/IOzLKcDak0HfsQWoHmwdjsAV4Ne52BUBn/kEAb7klmffftc?=
 =?us-ascii?Q?JIrK/fL5vNLArmSvtZJdQi4oZG81Bho+F+2fZkGws6QsOCZZbpPcI4PS/bEM?=
 =?us-ascii?Q?myVA/COO6gq38mKIoreZ3L3ha+WatGFGczr8eZ6P4Q7/kHm1xh9BhAmOeI+E?=
 =?us-ascii?Q?MeBmI9o1jUOa1EfvPNOqBS7QPJkI/eeMGCjflC5CVAfPH/mjX/JbzyPru22i?=
 =?us-ascii?Q?OjhkXd6Te+Gd79dR1uMO8hmod7p6Mcjzlm8DmWNkv5pDUpwsde0pY2e0xyiz?=
 =?us-ascii?Q?523rqE9mctClje5GPyQmTGhGb5e0ruRUJHkgeP3jH/94U0wsieNJXQ8L32F9?=
 =?us-ascii?Q?v5TeHmVF9tw/VNU1qDDrUBAzX/M0I9D41D9hSVVomhOIFVHTs/rIvpNQg+Sv?=
 =?us-ascii?Q?Ads26fDX12DH+n0hmKAMioBhbl2r2PutqbZJHxOA+2qWSXtgsyhvE1KMk2bG?=
 =?us-ascii?Q?GF9UtLucKakZe7QPWD3I2PMhKAJFVVUfa3bCYLGCYNCitwOEHTzevHVCkPs9?=
 =?us-ascii?Q?K1KE0nyb4TGQ9g9ELc7lP2L4ctmccx5UX8lebb/OD1Pa4V5duBkZ6L/72u01?=
 =?us-ascii?Q?f15PW8anzr3RwLvK3vRWg+mf8JA/4KWufSv9tYeFUAuopwd/ymaN89McjzNO?=
 =?us-ascii?Q?epiH7knYgrnLcTiS2k3dfyDL45sDLh9iAg9af+A22l8e5NLzG7Mx9GY/dz6L?=
 =?us-ascii?Q?9dEfE5Z5hX8+ju3vHG82La7KAH2TIs7Y+ukmLAwrjOVpSUSXG5SEJ3RG487g?=
 =?us-ascii?Q?Lu+O0ez97RE6OkR7N0Qi292X8WBzyR/7lf13JHfSgrnAUUnFj0N6thgvqjPu?=
 =?us-ascii?Q?Xz7+lhh6nIwNm0FlE8iBJvYCOw0aZsceRSo12IUOajCHcNRT06adKNYsiocz?=
 =?us-ascii?Q?+FW9NuivchdafQhZMNjQQhc6UCm9k9BQvcbsje+oPNU/BX4SCcHbNyyghJS1?=
 =?us-ascii?Q?5eniUX6xiK2kcBlWOuyk970kw3aRy4pTT51nYmMIXh5HJhA2RE5WMxRaLcSC?=
 =?us-ascii?Q?2FK+zbhoXY69Wy6ClkI9wLlSPrxlSQgT92SBFtzd3a7sqGY+lxnVxtQ08AgG?=
 =?us-ascii?Q?JEJKe1DOo6x9JD0W3WDpBJ5Ro9wGxSwYQsukQi2URWhGOTCfDCKKTLE8d5oI?=
 =?us-ascii?Q?VDo3rPgqe+GU1/sjWkARWpJZQduDQ4ZWN1GECAMbPKMDsxxuiwtgLwy2kUOE?=
 =?us-ascii?Q?OOUcQa9PtDuDY9z5RfZW3/GzKGTB+qEgKvRkSgEg6dYGDL1jSTOUKPod9+4m?=
 =?us-ascii?Q?XFe1DjZxfnsnkjkyV9WSoPU7YmYsCE8+7ZVa75YIvbc8L1qL8s7+SGcIoOVJ?=
 =?us-ascii?Q?tzroBE4YWlAledcUGbh+Jn9TxFcfw+lDgi18pJeKt/wHo0K8dytmGBKa+KYZ?=
 =?us-ascii?Q?49MjwLWHh9fwzMguPNJqpdrR91dUzZWccUiiCro6waV6Ls8fChxsn15DXkvC?=
 =?us-ascii?Q?9rf7RtGS/U4jv7gmladgRIKdf7LR/pJE2+O86jCW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c12a5ce-ba64-4e7b-78cb-08db756a6619
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:53:24.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8LKjMZXQeg3tYPe7YFUsuGxQypcOVZXmZOA+cuYgJqigYGe1HsXLsq5vzl35tUWteqWcPuReSY2VwD5wpY43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add CM33 node for i.MX93

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 9aad073b491e..06b0c0150525 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -133,6 +133,12 @@ gic: interrupt-controller@48000000 {
 		interrupt-parent = <&gic>;
 	};
 
+	remoteproc-cm33 {
+		compatible = "fsl,imx93-cm33";
+		clocks = <&clk IMX93_CLK_CM33_GATE>;
+		status = "disabled";
+	};
+
 	thermal-zones {
 		cpu-thermal {
 			polling-delay-passive = <250>;
-- 
2.37.1

