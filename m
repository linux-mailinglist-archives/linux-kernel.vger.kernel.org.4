Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8B654B63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiLWC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiLWCz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:55:59 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FBF26AE6;
        Thu, 22 Dec 2022 18:55:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW39Z8fDByjvFAPRHNHBFspowt4g3+qDf0YKMNAmWH/5qLdWoYEutzhxNetCMjCNSHxnLYUq5gJWixB9Qw7OymC4BnA2VyHiIWKeOF1gvWC0fuOE4aTe5DKAX5MSFDFEp9wDCICcwLP+sVICVjk9F4Uizv+E+Ci9PZeJVAK8ZxXuODy5T5kCeLJYqtLDXmLEK3pDpk9XSYK4bZzERKB3RS4zZOdrzIDzMyhE3olWjj1iXgKnA11GHRFKQqUma7adrqj+PIVhGfP4/wylwgecFzzueNaQgN5b8gJBfoiS0Jb/VhM39Idgy8WXlWwQfdA+clC23Fou6zenZE55iABNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/ngvhuZZFaTbs0StsHJBcT+Z9Ckg1+LLy4epjMIiN0=;
 b=coRzCgYmKVtjFMUF85lITTPiK+aJiTIWMjUu4Jz4ap0g0CIy/mmSo9DBhtZeFhheB37OaxM6Z7Zgh9ox6FRkuw5SwIx7UUhqkOg5TOYE06+wJ0qpIN+eago/6dCJ7zUMSuXo7bU4OQBAV8cykO3W0Y4LyaZFdepTI3eljs/HiJWR9RW9XuDvXv5wbzpNt3Q2cFv7F8rDG/5CWYK8g4Xd+B3rivvoUym9SGwq4Cm2hY5EJkky/1RT67tEWtKc9kwSM50OKH+sIAk0XMoiJUHzStUxLbbbFOBddBYflkZaMv51jPLZjkpHG3bwS5mINLi0SXQa+Ox6cLGxNK4jKzL+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/ngvhuZZFaTbs0StsHJBcT+Z9Ckg1+LLy4epjMIiN0=;
 b=VIDK52D4m001DZDffosW7ubccMZCwMpE9RfT7I3UpK4S00DBx4dyoBPZyi+tqr+jaEHm+Wxs06tSSi34ELuEhAhhv97raCfVq17l5DcMi2BWXclSeqPTeIo38lmW/HbDHkT6u0JVkDdW/K4Bb1hhb0p6omZHfu6/5wHTHLwT33k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 02:55:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 02:55:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/5] arm64: dts: imx8mm: correct iomuxc-gpr compatible
Date:   Fri, 23 Dec 2022 10:57:01 +0800
Message-Id: <20221223025703.15784-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223025703.15784-1-peng.fan@oss.nxp.com>
References: <20221223025703.15784-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 460868e5-9150-4fe0-5410-08dae491355c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5oXU80FAxRdyW1gKzg44bQdvzr98yfDb13OMB7L40zJJHi+UlKtQvVJCEtoLQ0vFs6o2hyWeEscLBPtWtBVhC7bHeBG+mJFbEK4ldz+vWLsacDdfjfSz6f4sdnLrTuGctG5dYCyIEq3br6VcFXn1KOMyyWxb0Pymqxm9kC2jXN4Vi6BpEFDSrBeCpX6A3NpOoNPJ8R4UmjnY10Q0Tw/wWzPq2uLNHSrRUC3AsrqCHmlKZprxy3zpXfW6i4EEdooUh2iRbqWpiSLxKGig/f/65qTGr2Kp0cVHcPllU7HJbQeE2rUVy3fJttcn9qQVnYzLgAupku6hA6yqpt7XQ2Humlhu5Q4ORDOZIf0dCx8ko2AmkL3c6UdKNRzbKt8TudXmJgfRRiAmQqcjDYlhE90+e8KcMb7gkUKXfhrBhyJgigPSYdf0oVgOEQu53fvqarScWyup00xuL++6FRqOJH3CZF904Gfnnf0Gu11LXUSIonxwUT2g4rUk8+4bTLcGyDQebr2h/r5GVwYiFA0Al28V0lCcPMNq4KimzPvYadUb8/Tbr637zjfSAuK+NmfmoO9uvALOBNUwIL9aS+2wOYM883+bBXCa4AZ11zOLWX2/+LAmvICuhw078AItOMjMYnZOBC7mvA9X2GWUJk99qC4Plven5AlgK1gqIJ10lw4khyE3KKyVaWxtF5IG2+By3cJwWO/UreaRETmsfjConNpCF0NRnZnXjBKGhbrsVQPYhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(6512007)(66556008)(8676002)(66946007)(4326008)(66476007)(6666004)(186003)(26005)(6506007)(2616005)(6486002)(1076003)(52116002)(478600001)(83380400001)(316002)(86362001)(41300700001)(4744005)(8936002)(5660300002)(38350700002)(2906002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VylfPsacA1aKHTwCp/ja9d81jNzSIdPWqf+IgWLJrGEZVf0z3DLfoEb1ClId?=
 =?us-ascii?Q?Daia0L74+Ko27DcO4ubjpnh4uqxHQzocCkczfGGQYRooBZqNg4YX9n3aWns0?=
 =?us-ascii?Q?uldmUelCx2Cy142E37rc9dcR1Xtv2zO0q62GPzz7Q0MQHIO0C3eDp5km9O/Z?=
 =?us-ascii?Q?AeMFR9Va/X1SZxPZo4/gJ/x9FXRd3CrmiTwLQXZpM/z8flwlJqiFvGhX5UyG?=
 =?us-ascii?Q?G+i0FiUiVSSdv/rceKPN5OoRIEAYld431mk1/GoZf42/Fs4Vw60SwaLzVXAX?=
 =?us-ascii?Q?dB/wDqlrh1vZ9EicRLL/CLkc5z2pTWauys9oEBia3sMnmcGXfihlrCNZ7+rl?=
 =?us-ascii?Q?XBXMFP1odJ/LwQQipGjNkxjQuLXswxSzI43mfBX2KPZDazMQAYK8jKENX5GW?=
 =?us-ascii?Q?wEwbLtN9oCB7fEJFOvX4l9j27cmvQb5olgM0/PdCOkaytzfp66dQpq0tbz+5?=
 =?us-ascii?Q?paeCyn8pYkdQ9lwDhkH1H3rAC10Q2QPFW5oQIgXcpqb7CAzYVDvWC5ZE4Jq7?=
 =?us-ascii?Q?mgCmuU/wM9YlCi+0AIuRZFQi6GLvLNJJGYVNxwHwX3aTgARK2Q3lmUeFS+Ew?=
 =?us-ascii?Q?bGBnWpI+Mn5nCQV8DjPSrh9gtHSwib76jLaflDVF3BMWUPmG14NsTDcp5rwc?=
 =?us-ascii?Q?awexvsWkvIBrliTAFChU2LVtHij5ePGMROl7c2//vPfDTPGExzwebFyJWpVP?=
 =?us-ascii?Q?CnNWtTnoY2+u+tvKU1DOelAelsb9YKOThRA7oirhXSQ+iRTPL9R4WqNIqlhL?=
 =?us-ascii?Q?AAyK5LCMMEAfgdV5Lyv7+XX2zYqx0hlR7su07g19hRsVrFrRtGR2ULwWZXU+?=
 =?us-ascii?Q?DioRRHPAEZ0HUIVNF5dt3nFWrqPeNsUTu4YPfDKPfp6qOqMeRC7f4/Ao/CXY?=
 =?us-ascii?Q?OnalyVHnhydi/DD3G9+0Ivw+F3jG4Van3IBZZggpZ6IuUivv0wdOMXxM9bdx?=
 =?us-ascii?Q?9W6EctnCrvNHDrFKKPYjBOrFqEkTMDq4//yH30bEqwYNS1DiZCgS79dsIc/c?=
 =?us-ascii?Q?gLhbcUpFTDKw4oqv4lRGSoWv8mqb3+csWjeHvGDk8+T2d5QuBELXW1VGfhHu?=
 =?us-ascii?Q?Cf9POuLcqhHk4wvw1E0tWvUS4R8b6mUorkimB0H7NjmWj+vrCmcacpiXOZfT?=
 =?us-ascii?Q?VwHmQVGujmv5MpUIOwVIOAOFy2WIVlEUs4hfshtt+glyltWoU/gEOmYbburN?=
 =?us-ascii?Q?ApvosNp+8lWYHoMFFQOyGxTc7ncdk3BDmuw6AUDztBH5eoYkVlE9ogpgANaG?=
 =?us-ascii?Q?pHIHMPgySVXa/Ikht0CqyKkJULoQz6Ly69esn9c8GLmGj1u2RGRc0kFyHsJF?=
 =?us-ascii?Q?EalXgORqCmLSQU3n0h8uyNqV0iVQ39i+JWzfHFaMSJV34rOOO+R+WmXhe0Dt?=
 =?us-ascii?Q?LXff40RcJnGoj3FnZdpjYLcxH2YS3Sh8vzTh+Bl5Fm5kCcLmvev82m6p2H38?=
 =?us-ascii?Q?ojzchFpOP9EqVbIxzCC9jdIBKojsmIJPGYuslaZD91KOTlenkmf6ON/mRlYH?=
 =?us-ascii?Q?3dr5wrOOSOFS1WZFedjZsVWeLjABKve+mDyegK6ssf8mIeVkNxDds1j8ijgg?=
 =?us-ascii?Q?QC9FkRbalATAK7gILZwOz7woHvYZTFEQAZ4a9qSO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460868e5-9150-4fe0-5410-08dae491355c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:55:54.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqJa5vl5WMSBwnVwutSq//M+BW1AThkFmE6ZEE6JdV6MpVY3SJ+GX1DG5+cG8eB3GNlgXqv3pOHGqv+ykBgpGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The IOMUX Controller General purpose register group are unique almost
per SoC, i.MX8MM is not compatible with i.MX6Q. So correct it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4ee89fdcf59b..6bcc170d7b84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -551,7 +551,7 @@ iomuxc: pinctrl@30330000 {
 			};
 
 			gpr: iomuxc-gpr@30340000 {
-				compatible = "fsl,imx8mm-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mm-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.37.1

