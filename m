Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634F0654B67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiLWC4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiLWC4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:56:12 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D72CC99;
        Thu, 22 Dec 2022 18:56:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVNNLhoSD6RCNeJcsMitmyDixXV8oFt1U46oOyp9YklQc3mHJxr46kgeQCMOnw74y6/+sCR5UPD09+u3sm9dbXU8DJG9UxBz6V09fyZL5cRcZVjQLwEDEgWyLUd9ysxM7D9kcFQFX+dGfKXw5cjfgr+3dXimDfhECBP1dnOKhVTR5y9S3drRr9DAMSAJ3nryzPy7uj+jYvm9QDcBVDJwb4HS3pI6RUj/jdS45Y+EZGItaIWwQCXXexr3QjxSFABbKEIJPrY/pDwob2UlOZC36gA2uSFocBppFZzfYOuE2Rmingbm2QGnhCf8guayxuVdA3cOREjMUFz6jJm2S9H35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRD4u7vtFffSiJDlJLJra2xsb0kfaat7iDxwTJ3kUJw=;
 b=Z5A9byO8PPAqyvG85sPsXdhjuM89/130sXrvtlbgD9J7alQ3PG0xGPx3IgAwIl3e/Pt8DxVEN0Ne3cXixEdaJkMF06wtYgPPQDnAdS855S03myCuSj8yMa8MU5is0kUXV0RW6YNi8beEFusqjDX0eGkkVP8R++0YMxLp2SPTZtIjRY8FMQSto2BbBhi7SXIZZn/dbCFIG3T53/YS0SWpt4zjHsr4vd1T8v3T7WvFsl0njun6sOLdT3ZltQFoHNTjAbZ9grFMwJt4H8cy/yVM3KMp+08j25S8H1q8MRsVXud+NJZTO8VJljVpcso2PFqRtD2Tc6uKLwRC2q+fyxONBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRD4u7vtFffSiJDlJLJra2xsb0kfaat7iDxwTJ3kUJw=;
 b=WW2pphmw89Tl2XA/mAcZB0LVEJfITc8R6uVzADYQfahUrchV7+QLtwdWPZBwZ+z6BSV92h1kkiAyrWMhxmoHcNYi8zso91Nw1HViAzZQSzBbyYDsWeTnPHx+MSl1XkAaveV6XDIYbjXFrUZV+Y1oz+IwiDBgaaQywJhVv/HLfvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 02:56:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 02:56:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/5] arm64: dts: imx8mp: use syscon for iomuxc-gpr
Date:   Fri, 23 Dec 2022 10:57:03 +0800
Message-Id: <20221223025703.15784-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64b9f3ab-3db4-43cd-6a67-08dae49139b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56CewvLQyRBu6zEaeqiYShOkxvcw7n5uBlFrM4r2PkZyyK4t+/5UKo5o1TxmQoXXUz4WWvLOwysgxoKxFEDboCtrD4JsLq2lvVbPOXHMgpszYG2SQH+1agGrwpX4OE7R+eMxah4N/DbK4A4/sAveVJlfMpBGNH9qY56DZMxf9+puVr3KIdhD12g4LGzNCi5jKmytGvZ9aeK5w3w6SxRfSM1qLlCLDQ4IwYRi5CtMTd+52FODBZnw9Jal1L/0WqVZT5wchclKWSf+hF7cN+r7Unn1zS7eU5b+ktxKBMJXGmekiuqzkraW3nvSJD2AcNjAAH17+gXt57rjohHiFyLznUpTbLQkpJWy9iGjMB2ITLikQRm5eMqbYJu9IsZEJM2oRkX+cCx5iGKhCvB5kLaTbGU7Q29A46EvfX/1cxIJ2dPvXyGbfWYV9Wl6Y6SM6jrwll0/gpuxmH/dsHQtWVBlhjHwAkxfG0X5uV1Ggmvray29iaPPlGgG9Z49f49J0ss5ti5zG8/ZKgyl/t/KsLs2XUp7MIjLcDDg/FHUQeQrP2MnJmWwb5wwn31LabFhOnk1YxZ7sPkITePxr3oBDR81U4EMApLkcANCixh+LWmKp+yBzog/hjoKD9QBsHRDuw9Dj5xwjFtmEf+003QvYRmHMkoFa+n8dD28+GXc09QoeHRcsbKa1hlV7IoDAO8EiARbiXSDkihCwMTjMo0YbYbLPXe6jpKlg3Lv9QSf7WWSov0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(6512007)(66556008)(8676002)(66946007)(4326008)(66476007)(186003)(26005)(6506007)(2616005)(6486002)(1076003)(52116002)(478600001)(83380400001)(316002)(86362001)(41300700001)(4744005)(8936002)(5660300002)(38350700002)(2906002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cYRwF4MLARZ0ko/f2P7jl1MuAlbvMgUW8knuO86mshaq50O86sGMipTZWy9+?=
 =?us-ascii?Q?De2tuPO5juElLKk0POc6QdPVhroJzK3dGsCW0r6RzMrsDQvYkI+qOKsINM4U?=
 =?us-ascii?Q?YD+dICsriUBNkZR5PpAjxlhsVCwaL0C9PFihBa3Jn2ectKiHiYq1KjoaVkau?=
 =?us-ascii?Q?OVl09hSxwEqFEscUbEgQFF/1L3wQlK4B8fDn6nNVu2sFEwep6iAtk4dyxLDQ?=
 =?us-ascii?Q?vzVAiE7ZJM6/Fm5WBtGzGXuH+zWqdqGA45qVWhIlhzcmUdsfc4uZEZtEDt77?=
 =?us-ascii?Q?mpIqQs2ev6S8gm1PMvl4ZhkqIiLuB7FSQ8T6owlqySiOd+MCl55ibJ9law1A?=
 =?us-ascii?Q?xzKd9B6Ga1AtLKusd4EftPhyliAyTd/o3lIjHLMXnH2KzdKdQy6fITzYwLau?=
 =?us-ascii?Q?fJifQS1Im6iP5SmaRYgSB+7yHTkZiFGqdOyQHMEnckXZU5upnJMIzA2EwNcT?=
 =?us-ascii?Q?5wYbZOzGQc5LTiiUBulGgf0LiavIzS/6EFGcF/orneb/3k3JwOY2MYRDbDnV?=
 =?us-ascii?Q?W1Iij6N9ZSPNdefLa6FaMiPU6j9WofWlOOnA0G0Trzhk6rebRuE+Odf9rUGS?=
 =?us-ascii?Q?3nS+5Y4aMtOMSUhwACdWP8420Ujp9CteP5vcT0kChVQPXtMpA6dZny7XoweA?=
 =?us-ascii?Q?0A3/4MdQNY2zntY58K7FFoF+7h+GV04aClGAJCM2A3Pw4eJmRXexx0didqlz?=
 =?us-ascii?Q?XbbC/rzeSnFDeC70fIdEvYsljxhOWO9D0jvn4VBPYUzq7GenHA/Hz/jNir3R?=
 =?us-ascii?Q?BJDuwyZA0xZjVtyqAGGqJxzQmFRuelAQ+pnX9FzwpIvg0tZ32FikPcA3h8Kh?=
 =?us-ascii?Q?aKfiicLlAYcKu2YWSQ06bED1RqGT83+n5RqCZ3TcWRMTnb6DJ31BphrUR/s4?=
 =?us-ascii?Q?jQlcmn4z97oVZSDKyJWpKcE48fl76HeufAysUxgKOzBquUPo0ZPEPkGDJ0CL?=
 =?us-ascii?Q?+zGhHPR2rBrtpD6l+PSg6aX3p03+WUfrdzpXyxlsCAdLBa6Oj4al98LeTOWK?=
 =?us-ascii?Q?XDupn1DYjrgdMzmmhruEBMDSEEKRLxoIvr6as1iwXtC0oh10xA+QmMDLU89W?=
 =?us-ascii?Q?G4PlWJdvOinvTncGRMEs6BO8ckR9KZtcAq1BC5N2t8jxVUqDbzJt/NtOp0Hg?=
 =?us-ascii?Q?8bApNWVA0UaXYZL1/Db033/O7I3NyZyQSvh+UlPYxP28yszC2nwvx/k/VCv5?=
 =?us-ascii?Q?eORUcrfJwrcn7Gm6R0s/gjoieR7WY8uSqZJ/WC2PwmsTvvd+iTWtPHqyYhKw?=
 =?us-ascii?Q?HsdFlBfQyHX0/lm8kRGLyc9/5ezvlIVxFLSabQdfO30tDBerf+G1DBd9kQ4w?=
 =?us-ascii?Q?BKUxjrXB+nTeJPMAmjbDFVJ3Wgywn7tsf8avBvoLg6CAMkt5nGtWqCLbS6Wu?=
 =?us-ascii?Q?gRJ9yiniYks8+T5eVIOwG/EH2uSyQkzbpg4N5Z2N7Hu3F05Wegvq8q+EsFaM?=
 =?us-ascii?Q?vVzQsBEk/yOUrWpVNlXFMq83cosU79YnQOJcBW9KSYwDjsIIQDQxU1XcVIFN?=
 =?us-ascii?Q?rmlQog4l2mYrFMZNJKeDGZ/BEyPvPbPJT8YKtC5j1b68JBbKOwnsyHw7DaK1?=
 =?us-ascii?Q?pC5gZcJfuchVGg1TMh+ZlxtG/VksMbR+7SZNJYIE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b9f3ab-3db4-43cd-6a67-08dae49139b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:56:01.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqtEw0XwTmCjVEaG+8ZDEmge1R5Ehx4w0y88JDtEAvpAnRRXfY3AJM0z+nqdCGN3qL7Z8QKa5Va4DITLj1a3Lw==
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

It is preferred to use syscon per bindind doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 7a6e6221f421..9e5260721931 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -412,7 +412,7 @@ iomuxc: pinctrl@30330000 {
 				reg = <0x30330000 0x10000>;
 			};
 
-			gpr: iomuxc-gpr@30340000 {
+			gpr: syscon@30340000 {
 				compatible = "fsl,imx8mp-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
-- 
2.37.1

