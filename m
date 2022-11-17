Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51D262D77F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiKQJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiKQJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:15 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703D2657FD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiV/9gECWwX6ZDPOonu4oT/JV6/VFow9lTBnFdaokydAqR/7V/uf6BhN9WUGdkj3cE5oT+RMmPaVTTSC7jgGWTzdT7UDjlOHmejPSAfq2iP8C9H81aNBDqrqGcDGpB8zE6ywLvRo1qG48NqT4lCbUFZBMtEsuMamuZJqr+rMIXHNgcfw/w/pABrAY+W0tV3SO9AF0bPlyMNCpBnPiprJk2sAFIMFHUcf5Pq2SffrbQa5vg1b5hCbc67FoTLA/AcYvfMoXSz0b5rAvuOWonflqoaHNfSTV943aAZPsOelXiCNWj4hyB4fZoYx2TeAiRvohI26ayjT1P9eqn1mBCqxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtFh/bODZgWayNowEDZUaTJHMNjHPN7c8xTYgr4zAnM=;
 b=jemTMB6t3NTDhmA8njHYp1Q23wbMqUNL/EFG8ndleV7D3gHibnICPiRb418f2rEtS/Bs0ehhznKiAeyf858UZdFkzPYMbmMdY2yO9O7A+mOgb/IY8T0JF78wSOK2XDDg3kGNbIwooQF4mzleuHdZOFsNO1NY4O3LNxrkmT8Ry8PRP81QxZupq81gQqs165bbmP6cY7rj06BbZUjD+v/3dMXvB/ZaUmFb7QZYreh/THsFf6KCO29FcTwyupXA+xCCYoikJTZkKwWvhUTqUiLg2ocOI9mMN/kIlGhEfX+i4Pe1xNJohaLIdmmZ1Ehtrj5Dd0BroY024GuN1jFiX+wKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtFh/bODZgWayNowEDZUaTJHMNjHPN7c8xTYgr4zAnM=;
 b=YOgR2GVngzY+77x+nE3/KbXi4KMb2zu3b2mt6Q9ifbYB5M159GfYgHE+u/OH7ETlTFq+jTLZJLZvy1LmC8qkvETjnyCs+ONWo17Ico4yxAho62SJ7GZ5YeMDFyB7ty3Ah9LAtJXYL/uyxxVg0NJiHNI8kFAl2n7ScImuGLEPmRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8469.eurprd04.prod.outlook.com (2603:10a6:20b:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:53:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:53:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
Date:   Thu, 17 Nov 2022 17:53:58 +0800
Message-Id: <20221117095403.1876071-8-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 572efe18-0a42-4c51-264a-08dac881833e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POo8QveKP3+PKt7WF9/q39KWUfVRdDEpSpW8GYTJ8g5TwvxSyoBT76eL6/S0tUb/PcwcfYShqJyd4Om0VXImdPy0zEpf2Jo/QTngg0yrb348oLZvQSSwIYUqHRlvWIETyJCu0Tr9SV2E89uV0NJPIjrrDkmpVgmjMN4TVOJWYBXhL7b+2smmK1W4brfY3wrOLZVVv7I7vpyW06yJ867l40U97zDK55tbpLZ7ddKy568pl1Gk7AiLkW4LYeZ198de+mBSELVqubUpY98DSDfZpsQOohP4vBPI7GDiRplTiQg6BIGZA1SaJcDxkZP/6Ifh/7M3bjjjenVciMHIsQmIwnbUlV3QfiwDK1SRiIGtUd/0EpSAsLA6O51jyWMppIaB27WYMeSY693xBX3NlZZQcweN8WQ2frMhlC7vdBpm/3fu8gQCoLg/cpJVI+3dW9j+fdMsDZ3P5L+Z8yPv1sxvZyExBBEkJ1RFtmbOfAv8HvLTZIkvxTd7eiHwBasd/oPmx4cz9y8brwNCRncUgAKf6ExlAKh4xdCKfJE0DgFn3MBKuzNWZy/K0y/mrslZwXrZF1NOwxMRO55LcBGEsdfjhQKKzUuUprxNC0bufMcfEG+JNAtCIdYwSAKk5TldnoCEwTCwxhezrTkClxGWf7VKjRiKp9OPDSVRhybvvkDwGcF1EkbxGOG98ZPggi+MkrgpCTGctI161TzRzenIVCiBwz5cEz9d0m58lBClYH9NnxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(66556008)(4326008)(66946007)(8676002)(316002)(66476007)(8936002)(86362001)(41300700001)(5660300002)(478600001)(2616005)(186003)(1076003)(6512007)(52116002)(26005)(6506007)(38100700002)(38350700002)(6486002)(83380400001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dkxQe7tPOXflbuvN+SITRMcHUXQARhmawhzvZBvtciMp92UNm1YXMLDOGs3W?=
 =?us-ascii?Q?JOQNaGoZ0D04VhRw9MdMVqz/1h+lq58O3erD9vHAF4QsggAuJO92aBBdDhPt?=
 =?us-ascii?Q?3Qw+X1JXSqEC3c7AlVeqbenphrvDptRCg+qwX10Or547zDFCHX6Ry3nXcjiS?=
 =?us-ascii?Q?g61poBURfcb3XtgsRyh1Nc0XSc84FCbOnIaVIlNDdfjkM8AjjnUybhSrpWUY?=
 =?us-ascii?Q?1Moqqz6XA+r10lTJqWBE0mjdVZDiaH8m5/G7W1CU4OhG8gIVD1+wpfRwsaqX?=
 =?us-ascii?Q?SFHnzjirpvT7Nj30CMrxfdCp6f8xA0ZRs0XQL99b67MrZJmi1XE3uRw5VLE4?=
 =?us-ascii?Q?idFaWOHZuC45DKMR9pa+Rna9gCSoND8CeL18Op834rh+w6ok+tU5onlkFpzR?=
 =?us-ascii?Q?DskCXMP1fPBlzwYGtKWNn7ru+d99htesc2Go3dkmUz2mINuWsvNk6ZYb0vF/?=
 =?us-ascii?Q?nMGnWXR/LhkTQDl/TC069KvC5T8ZW9sywWdMGpLwbkEsvZEekK7ri53wgTy+?=
 =?us-ascii?Q?GdY3yefOtQ7kBuuXoxM9sYbxsX9r+NwxdtCwySMGBn8PWmelk5HJTa1Cdh5r?=
 =?us-ascii?Q?EqugkWShcwsWMswBsC9W+Llh/I6nzItBdpcms/u0mGTrDnsBizHEOfQqypTy?=
 =?us-ascii?Q?oDTlQnOqVrfPaELofbiAQRTVom+XjS+lUmCvjtSvL7p/R5oxuOksOI9XqsA3?=
 =?us-ascii?Q?3oJ25difFHUsbLIcDgTKbNV6c2ed4f8iKGJEMH/ay+yj3gr+EDW2W8OO1CXE?=
 =?us-ascii?Q?kleuKfDTo9GE+XWQp7qKj1OyYPekLSXPnx4uA537WuGnK4+WTOVOWhfeT15X?=
 =?us-ascii?Q?lUlQyBdcMDTLHbpnMdtReq6ebCzG85PM7qze/9Kg3A8dpbFg50vf6B5yXLEA?=
 =?us-ascii?Q?I8uvUuf93L4wF+Gs+I+2bKyWUnfMUOMlXY33hMW074ovqT2Setr521G5y44f?=
 =?us-ascii?Q?xQzFPHd/Y7tLcr26Wms6FYdvANTq5rnA5VE2DdEYov1x3e3Pc71PP2s8h5yP?=
 =?us-ascii?Q?xckLPhBTS68kjE9LtK4B4Lv4djcbP/+YzFGl0Zy4g+1HyC5Y/6fAcXOXLP04?=
 =?us-ascii?Q?cA3dGdIjWcVlNN+3QRUXkWIulXI91yTf8/1CHCMJB5h4ez1suVJTsVMe11ys?=
 =?us-ascii?Q?3DQghBaoH8yhr3ysiwYHNmK41z8V9ioUZiACODFNxL+M6/xq9RDG8Z4zF2yy?=
 =?us-ascii?Q?e1ehK0g+J4BBhRjaeO8vR0DsPRilsoPe7FEXggbiGpKKIQyaG+jXJvqRPvjN?=
 =?us-ascii?Q?f3+DG5ixCEU4ddldDXma1JASvnY6IO8jgzG77TRYvpeYAHlF3VwntsBwh+QZ?=
 =?us-ascii?Q?ScWTk74rLaSyaV50zqqxfyEcwuNAzxS0ZVKpWDa6drS6nmO02RkeU+YaYR4V?=
 =?us-ascii?Q?D5qygazzpfAuGlArPh8AkWdrVsO0d/0V3Hj8Tc9Cpw58wr9+7JSyccoMEBkd?=
 =?us-ascii?Q?fkh36moxVUZwDjwplF9BNHNDaaL4txpRLWCC7nNIP/sE3EeooN2Kmlr3beFG?=
 =?us-ascii?Q?9oopzOcgJdX2n+oJgFL7hmxJs5cRNCtqm7nwNLVbydTwnsgcdtAqTqMdNC4D?=
 =?us-ascii?Q?FyJncsXBEr7kCdunfG64NS4FqLdYjp9GBRmh+BKI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572efe18-0a42-4c51-264a-08dac881833e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:53:00.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck+D5Ko/jNx8knI1+JcSokbMbT77cuAkRDER82UDb6SIunOO9IA0t+cKRkEBdC4Fu4kpasTmbldXzqi0GnQ2gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8469
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The nxp,dvs-run-voltage
and nxp,dvs-standby-voltage need set for BUCK1, not BUCK2.
BUCK2 is for A53, which is handled by DVFS, so no need dvs property.
nxp,dvs-run-voltage is not needed, since bootloader must configure
voltage to make system boot well.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 4eb467df5ba7..4839a962a170 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -47,6 +47,7 @@ buck1: BUCK1{
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
+				nxp,dvs-standby-voltage = <750000>;
 			};
 
 			buck2: BUCK2 {
@@ -56,8 +57,6 @@ buck2: BUCK2 {
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
 			};
 
 			buck4: BUCK4{
-- 
2.37.1

