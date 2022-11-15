Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033AB629412
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiKOJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiKOJPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:15:52 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C16D62E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:15:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebzc7/Fzz2TFRgGRFWKPPsZeuuXL/1h/oF5c+slQDLDxYEK9iPrJMG/J1gYhY/xI739zLNuGmRsfLMv5Fn+xmlQ9ctWPoLXZWVmSh/MBJe4kHJgEsCcY7jhc4jtjrAnWnbJ7fGj3Ri9IWtNndMeYssqBTjr23M/ZHyd2SwPAbazkUdMTVaFzRN4m/4QID2taW7yyKulef9VUwBfSrkdmlfTOyIdwtDFOFnQTOpWuxFBuunvt/8OclAF5ZV5uQMciHJbWnOHQBn2jiUlgi7FbSW1gpU7PocqJFpMdBYBnxHTOLLs+b9mrpARawzfidfQKj3S0XGS9r1rWZQpSfUNYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQby33EV02onxRlFM7akkEkA0XvFpAwKcx9wYCEmXOc=;
 b=eArQL9pyJ2FXs+NWtybmUjADzBtff+U+9vIMKB3Og4738DpvCNLKAX+MG/0Zgl9VC75ZdBP/THk9h5baeCrxBMdgquFM8cLMGfR4X+Hfw1iIqVNquIgxfJjQ4ZmiUTXe+/Ml4Loz7Tcz5SxOvCEHUs0FfPnyINnK/+K7Cew+KJHWwScFjLCRh7arJXxsJpuO7ksKFKA75yrGtLZOyPGPFVhqh+8xuEWmOh8A8Klvu259EHM9XFP685GqQnRySroFzqlpONS6HCHempQbGw8jyXo6e4sBH58rqTErm602e1CO8wqlPoplN9K/0drcWpUdXjBrOGOyFWP11ymjL7Qr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQby33EV02onxRlFM7akkEkA0XvFpAwKcx9wYCEmXOc=;
 b=MlEnKuvg5xootN1HGyl+ISYO7AiRC1K318PhBdZq6hXyojSvBvDwQRHPjOim8vRiOIjpjtJPTln8tcREETQM6PyE4ok2l/KNWUKTiUx4FX2extdAYbZz26Hkog/zb5M4zsAt6ZxGxz0t8IbSU7DnVVQ0/a6v/4o8GYbEbRVHSSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:15:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:15:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V5 01/12] arm64: dts: imx8mp: add mlmix power domain
Date:   Tue, 15 Nov 2022 17:16:58 +0800
Message-Id: <20221115091709.2865997-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 7158be27-2762-43bd-4904-08dac6e9fa9a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v88gvRM+RVXMabZpF9Mbgj4FSirbaJHwa3zp2RSB75BRgz4YfOPZAFQ9Tz5MEPreyIU7l98AQPvnWwJkRWBZ1QErV9lLJcaHXB69nBJTcoWoSbx0p8bDDAFEyPDDZaYmpyD/vs26cCpIQggbXFp1LavQLvqt4/1TXS9e94FeskOeCrk0UaExudgyQ0D3M58+iBZZ1XCtr46VVgu69hHSY4rT8iriHSR8yb8Rb2SE74Euxgx222d253a6kJDDlV/Vv+NIafecDQK0jk7uUnGIIouER4FDP2p5gaxY/nRcKtdhTblGVc06bTuVbp0suKZs1RE5hduTpqkEfNRML2sLktwHKtg2pkpJn3e77UqbB9U3FtXeN4NAwB41Jm+i4LY4C51zrlwpWwOqvFr+HLDvoPydnv9sTFkolVHRZ+oq8V7ysQijz+wI2kOgaIEAp3KfEx8YSbbeULUbQFu8L3JdwlpAw6VPCH0Oan0q3S9rZncXFLO/Q0+wS44Gyy/0Il+uMcGEp07uzcjCdk7q5mRfuMkmCAxKtQoiciCEYc5oiTqyAuGbCqTeX0EMQjGjHc7/213AQxVUKOCrqWFfr7t0bqTdkPmpkYRDDVHlCl4MhbgFdzjOOC4HMU81iETHa2hbMPiPi+tqvxIFe++mgDyImLN3vmt5On6q+8DQ0hSqXF0CQY54+fJDzsOd/No6Jv6LSbyhB8li+L10WNQ0pM+LpO0VX6Io+6bG4sNOTMT5N7GgCKZuWfJeVlMBLvueNXmMpuaW37P0Uf28r22xkckF22qyeVpI9lkY9Sk8xRA6Ico=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(83380400001)(2616005)(2906002)(26005)(6506007)(4744005)(8936002)(5660300002)(6666004)(478600001)(6486002)(66476007)(54906003)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MeLDsRH2q2wX0DNj9uboPKiXlr0z/QXKkJj91PLMBtGOzPGE/jilhyylLIZc?=
 =?us-ascii?Q?dafxiKC3fI+L4HRqYg6Ds5CAM4R75N9UOXMkC6q4zq6yfaOv5yvx3GG9Zn+q?=
 =?us-ascii?Q?mqyDGINkK2S8oXu4XGmuOokL+BTW/Qq2YaVSViZD/H5Wg3/OI+JoefIVxEnF?=
 =?us-ascii?Q?aj4eF3UwVzFWPqYI7NF3bDD2soWpw7ooxnLxTZU+GLMyElzsJjBnALLhty4J?=
 =?us-ascii?Q?W3pLLv+Jvn7sSf5ZSedfwVS3YBj4oDcMe7B/ICcQ64bixj74Lg5ZWYshLPaZ?=
 =?us-ascii?Q?Rzac9IDBP6DSqwgMAX19YvEmv0aFSMQHLVYG91/xvFoaEjve4+Ngkk4KXIj9?=
 =?us-ascii?Q?bttPLczQpRB8w/CkVsgx2OFscgWA3vAzIVOcU5CW55R5uv/SuHDuxJll8lEc?=
 =?us-ascii?Q?4vagVvRk07PrbfrXRcZUC+KlI33nWmt2KrK6HyoxEu9t8dYSrSlkUKKa6Jjf?=
 =?us-ascii?Q?t7QFMsBajIFqEPiKG7OiHzje/SK0ombMvuR+SI+0k1gHakXM+6+dypAWon0v?=
 =?us-ascii?Q?t9zWM7qgSAOM/m9bxdTWMZkwRoSUmuB2+zkyGaElA4TNqPTcauMXev8ZyvNE?=
 =?us-ascii?Q?sUgcJAyDxXSvbea7LjijG3Ml9XciNZ+dD/OG1XJuUW32nVrWvE4cSuvAByy5?=
 =?us-ascii?Q?ACFQly91RkzxXEZfvXyPW8ALscvyzs/PmOaFl1CSr5htWTRBULSe1aPh5KnS?=
 =?us-ascii?Q?4GkvsiYnXuXTihKTtG8ATCLb668kp0X8D+kplHPMp0nsFNr38VO7mlMYxjtT?=
 =?us-ascii?Q?WU7i8pzOOR/hbMYPE40ky1NvT0vLZFgFBt6+4ZsbUHN0UL0TLoVTkf4wIXxh?=
 =?us-ascii?Q?A6xkf3y6UP1PFcskiqshN99gdoPQ3rMKkIhIh4BYmwc2PYb6W248kmcGljFK?=
 =?us-ascii?Q?JTp+excbFcwTwxiatGuxq2106iAGORFtCHHSfhf2Kpq7csBukNUk8c2QUTCT?=
 =?us-ascii?Q?FxbhQab/w/mMcmA0FePxAPTZ3n2FoFm8S+ful2rUyqVDetEa8lfQh2npM3V4?=
 =?us-ascii?Q?LHEFAj8E0WPKO6t7ySIpAmpFjuOCaT6gegtdN0Q1n95qOumTYLk8MyfbhK6q?=
 =?us-ascii?Q?D69UMihS+08JrsR8N2HzOZKM1jopIBoxwLVTQ5Vboci8MGgYRLwe/IEZf6iW?=
 =?us-ascii?Q?k2frfW7LJGBlYUsCkXoIdlaaqOr17lQpISUOdSDJBFKU1u1WOy6TvU63yC+V?=
 =?us-ascii?Q?uAba23JiQI8EHqqx2zrvcObrhUwUTsnoUWYET00pUp3GZn5EXZg/p5dqyYxj?=
 =?us-ascii?Q?obcLfEFT9DGDkkn4HchrMFPcO5CqhEWzMHdNa5TaXnylNxAI3IioeGc3/luv?=
 =?us-ascii?Q?pFhSzuT87baorW78woQ+hBFxI9kcvqRPTVfc9iXGjsmaDI0dXjy52ke36ZCk?=
 =?us-ascii?Q?1AoHdDVy1pJ5Z4hyAioQQ3KLVYokjmOgT68hguh+RMAQLeUgSNip2kbBQece?=
 =?us-ascii?Q?+5EDypYTUmqFJwbtBFeL9pwOTUWEj8p/Hqdks3jjI8T18JOS0DS3KizIR41i?=
 =?us-ascii?Q?4uI3rSkNzrlKu7MNMYM4LAuJK8o2ZAf6reFNvIvhW8RNQqEjDWVLlJMDc9Ou?=
 =?us-ascii?Q?W9wL7cye2VTTAusnmfY+4vcm62uaxQU//aFdzDyV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7158be27-2762-43bd-4904-08dac6e9fa9a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:15:46.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b2YAmBEGhVCk1H0akc3hFYdkdfewTrePwxhiA9MdsL0OSH6EBMaI2Iez5DJvEK5cY/DEiMnCAWbJ9G7TC1/Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
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
index 7be02cd100cf..08704d2d9fdf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -631,6 +631,14 @@ pgc_vpu_vc8000e: power-domain@22 {
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

