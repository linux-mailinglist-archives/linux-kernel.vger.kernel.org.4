Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105CD6E79BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjDSM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjDSM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:26:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9E415634;
        Wed, 19 Apr 2023 05:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSsykTe2lZYFVuU+sIy1IA1+nlze3cRQZRn6JDLp/XlhdHzoUckWSfhcWWNrzAUU/yBaTyJQie9vXk84953FPa2UD3ksusLKJO8m/ZxC3oTC+ILlriF73ePflbFtzhys4/0Pj1dcloocY7C6+b/w1HTIyVga6hOiPwhTf4Zzid4UP+K6eXj+uI3lZxIGHtDbZj8jPFHVkQtpvAem2ToiBliC+BzEJUu8zyb0UP+DwfZPKBFu3mAVRZ3uAvb9MbRNGxERZM0nFTBEIPux7ZWlUQOTOT9uaD2haWcVbTGIABjGyVkgPj01IOnj/Z3Y6gkybG4epJt8BbV+xbOZ+pvmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugIHUpo1Yo8MvrNSkzKzeOS5DG0PsdIc4I8edIbHtZ8=;
 b=mwup9q258mmFkW7Luu9FY8jOKVSMRHZCSGhsnszZwm7AWdwSCu0f7M6Ms0jgx7m71A33DHTyBxNGrymm1S97gbdqDqEAxAHsu10gvJmDurKc0S3Vfq59N3dOGAVUJFwe2uE6MeHo5YPMeo2zau1Qs2DcCGmjLuLECVwOiP7T4KgnjrbRx2A5BX+2EkYLI1yaGCyRluru5AxcDGFd4YebFGzhq9LMhG+KEvLhXtJpBjOKSsZRSSbCjhp0/ZaTUOcYaWkPuRAbH+iQRaMqVk6UXSUFpu1slGwYZV9iHcgxOIgJk/Bb1OzZTMrowdoxdWQGge25bwfiZVYZoe82nWfA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugIHUpo1Yo8MvrNSkzKzeOS5DG0PsdIc4I8edIbHtZ8=;
 b=K9EdxwhShohqMqy2F07eArr44aXJEA6nHHvdXCF1u3LQylos7YzAcngLnlTOyTLNA7NMtN4eOeHTIaOMZ4REtYRpxIKAuwg9PuaDkD4qiK7VhZwSt33JTS9Ynx0H1YXsXlFAa2EgVQB96FhqXyQLph3IZ16ndLtW/MsPH3ebZKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 12:26:42 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%9]) with mapi id 15.20.6298.030; Wed, 19 Apr 2023
 12:26:42 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2 4/7] arm64: dts: imx8ulp-evk: added ele-mu
Date:   Wed, 19 Apr 2023 23:25:35 +0530
Message-Id: <20230419175538.855493-5-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419175538.855493-1-pankaj.gupta@nxp.com>
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da246ca-c912-4978-4552-08db40d154ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xa2iVxYIQzGHSXztrI5sITuPsCl0eEOp4KqAyEjwBZD14nuqqi4MLCjikJRjg3NP1efBrpAakcA/7B1acqFKa7Wd+X0TiyVmc8opDOO7oUoEv5dc9XtLkQXWVudsJ/8vIYQ+PW5yDqNObwGidPvOzjm7IJwH+8NSJy+h2fX1mnXB6b32ugDT2sux1JnTse6xjeqng+eG5FRStxLgZoHchwnYtdQxlqQTM75oYxfufzyrOMThhSwBYy7KoGscnCc0PBTgGak0xxSx+Xt4RQWiSXY8R2DpAGb2Lp6/K8mxNJDkrg+I/jMlbj38uLBeF3exg8Lrk82EvPFQC53TG/+MUQ/eGZFj0dMaBfEQpwHiENGxPvY6dG6l0wBv3ypgV6+Q54pPBrj1Qo3sG2iDjrhjlFYEqBFt/kE9lBWURHoC2JSZ/qwgOeYxDPJcShljRzkWBZm+4xyeF0NPSrQSlsUdr39GdiW6v0Ai0DwexV+wIADqQykH7QThRLOWeYhWOS8raKm8yDYDPoe76KmjDfZgYxZ+slLkxURqA/57nVhYsBrsBYKil5/RWnbKgT5+7/KYqg6ey7YT5ca+jw73hOgbb0mRFswg998yxCOSBCq1QNESSg84A5pMbBX0Q/0HhLApph/0plQtg6JvdGiRdxuyB8TZxhfpRb2qoWqb1DC63s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(6636002)(83380400001)(478600001)(2616005)(52116002)(6486002)(6512007)(6506007)(1076003)(26005)(6666004)(66556008)(4326008)(66476007)(41300700001)(66946007)(921005)(316002)(186003)(5660300002)(44832011)(38100700002)(8676002)(38350700002)(2906002)(8936002)(86362001)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1AvQDLKgZLEr5KHgM19nAey8GoCitzmYIjF8QcGusmOjfn10jA7HyKJNQiRP?=
 =?us-ascii?Q?AtcFRajf+ALpP8LEfSAtHAmogiBxGRLpVaGkN9A04eROQ/urCGWPcQ6Zr2Ni?=
 =?us-ascii?Q?e7FMKSoXupg22aesakCz4S90Gi6/pQ+tIu2W6FdtUVbqG2tvERfoVJ1Na+EK?=
 =?us-ascii?Q?7gaqXu97FgSVnGti4Nnnds+Q2zmF7zrLbgcOXfZKCXly1DGVNPb9cI6743Kc?=
 =?us-ascii?Q?o2sMpjSrhnAtgq/5aKiadkxm1Is7SLU5xdWmDJdD/mlpDnxO2pDoikwD+6Ok?=
 =?us-ascii?Q?mrY11qeyioPfitf5JfD1b+3LCAa/EC1GMEnobBtH/6HcH4CbEsWs/ft9KVkc?=
 =?us-ascii?Q?Pjm6I/y6Errv69YBbUHulDuPC6xKK5RoHLGHXRsWsQROxkEbrRe2DxR5+T1C?=
 =?us-ascii?Q?ZGunFWvjy4FcHNcKH+9isjWcV8imIaBmvoaivCetf6LC//xMH5BSlH/McfNu?=
 =?us-ascii?Q?uiDraj6yWqhR/SIvuQI0e2S3qnuOCyb5RbavncGnG7kxe7dLPnK1v5lYA1aL?=
 =?us-ascii?Q?lQp6PXL+JjYfWQLqQsxJHMmFwz9EFfxSnCY4mLq30SKtWRdlWVE/KbYnYidq?=
 =?us-ascii?Q?TvggclOr/KnjmaBL3GejbHNlfXsckDRZCRCY0sjkvAUAB+mUG6kI3cE74tK/?=
 =?us-ascii?Q?9S7v+jj5cFMSjVopVeJCxX5DF3oxJ0peub/i6Twp3tu6Jp4XGLamtY1DnEWL?=
 =?us-ascii?Q?nbzXr9EiMNzhNGxX0xUrOxActdiSG/inK1Q7Ri0ohM1bbAMqRUkIecgV5rmj?=
 =?us-ascii?Q?s7Mso5kngM+4PqIGAv6I23seM1cH8x9BG2O9ejACm2OmkTOizVjzo0mScFhi?=
 =?us-ascii?Q?y0akHFsfnhYBZynFxHyeEXl1CNAcqV+bLE3E63ijwHzADRJ/Xt+FEMSSdtY9?=
 =?us-ascii?Q?ZdWRkG9R+FIx5SWiaDExCoBfmNP3Bp8H9rH2eP0f3LI6+OIP9r6zXODDONS/?=
 =?us-ascii?Q?YW8rrORy35g3ej6BOzOit970rY77SRBCLIAd46VCOJ973TMvJ8YSexq8Jrcf?=
 =?us-ascii?Q?iS715OiOKnj9mqAxcyNW8S7/WZuYcKtxQqXZ//fAlbDw+hO8LlEWe6FHAv4x?=
 =?us-ascii?Q?k7tME1kNQtYuUWjkJeBGlA6WqDBGagOMp9bxeaBTfTvc6WwflKqPhXPoDEHz?=
 =?us-ascii?Q?GJng6XaN31+AdcMyM7sKbE4b1V9TUvDgELyY1sxduy8UzgqThJ22TWCEwJ3Y?=
 =?us-ascii?Q?//8LgNkAYRpxB8L41mGlhMBMAmEVnO3Ts3UDa5fHqPEpENJBekG3caqAys0Z?=
 =?us-ascii?Q?A12d/M7dWrphoPcdeA5Qno9nZ5yitUSjH9aliC2/mkxECIKoB/MQ8fz/XMsM?=
 =?us-ascii?Q?4teLzC0C2b/6D+030FipVCHCh/yht/pB1cVvDwX0gjK4lkaiDe+2gX5Cl81F?=
 =?us-ascii?Q?dk98Vie+NNERD8hzxzZaqbNKfUYPPFzbdXpr2ZoKRYRZtnL9ZODsECSBJ+oG?=
 =?us-ascii?Q?xZVyrwqMt4lP+gNHoBa73ijqg1YBJMRW42SqewKUrfcAKxL73+G8s3ep8/Sz?=
 =?us-ascii?Q?z7NrLBI8E1pr8Xi1YqpqIf3UcNqOpDX3nZI+Cy8UNIHDqtN0HG1BoZUs+G83?=
 =?us-ascii?Q?0dJKvCEcQIYf/CKm7uf8KeBiS5hu6CpG3RB1qLNK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da246ca-c912-4978-4552-08db40d154ca
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:26:42.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKqO8EfxqlIVdniP9p44BMUB2v2YM/mVWI2b9JNPPLNpLcggf2g9rn4GRoBtcYXk6ZAGlUVueXmVEuiphr3GJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added support for ele-mu for imx8ulp-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 32193a43ff49..2ab240258a67 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -113,7 +113,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -160,6 +160,17 @@ s4muap: mailbox@27020000 {
 			#mbox-cells = <2>;
 		};
 
+		ele_mu: ele-mu {
+			compatible = "fsl,imx-ele";
+			mboxes = <&s4muap 0 0 &s4muap 1 0>;
+			mbox-names = "tx", "rx";
+			fsl,ele_mu_did = <7>;
+			fsl,ele_mu_id = <2>;
+			fsl,ele_mu_max_users = <4>;
+			status = "okay";
+			sram-pool = <&sram0>;
+		};
+
 		per_bridge3: bus@29000000 {
 			compatible = "simple-bus";
 			reg = <0x29000000 0x800000>;
-- 
2.34.1

