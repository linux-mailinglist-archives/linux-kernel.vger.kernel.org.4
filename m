Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3810E65CABF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbjADAY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbjADAYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:24:45 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94B165B3;
        Tue,  3 Jan 2023 16:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCUs5WVZwKdQ9Mp6YwoxGxB8h8oH396RRKws5cznn6o8CdaSRWql7mdR8GX/+w4utJrndLQtsHtCrRA0aqfQ2tL1DSj1girfrAuf14uqcEV1ALOKr5XeUr0pz61H3WbN6AC2hPZw1RD3u2d6bSqEKSHgI3XVd3LrMkaKH8YiqCNJlo7f6MVIRdKECoOiflNpZqGdk2wiHqSu4NZcCgHFfGWNGVlSabSPXZQyvq5qF6bIWxEUnyP4HVMIRJ9K6+URJUShPB4HnRnO1pHp2Nwov1qyhxKmg/zeWXzdnp3TgO3DkAtSt1afkTY2Kb2T1QGIbrKNSKTbf6uM50s4ujYuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3X6UqGs/lid7qpCSPFF22NyTk11GxcXP/d7jWuTROo=;
 b=I47HU1itlQfhSnt9pBHnG5eb9NbRrAcvjlN7uwKBW52n/X5jToTsaX/90AnARkUqDLzk9N+wGAJzU1DFYRRZ3xQC32gzxQJ7ha6lJbq873trFRV6YcXSsG02NH1N1ZW+Ns66iS9Py8G3PxBn3bptYsk4OMw+0epJ+aXLxBO5aLGwExh3L5OyrTOvuMhOIejHWrVduydG7k32nsU43XXuyT38MIVzHTA8R2bur9UbM99vCskJcT01RjNmws9UhhLY18G6TqwhuiNs3CIc/dz0iERJteL/R9Iw1MAkB7cyprItY9N6av2C1d2j4MrS7iz4PuM0ckhsvjNqlmwJjzuCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3X6UqGs/lid7qpCSPFF22NyTk11GxcXP/d7jWuTROo=;
 b=FueXikG/2RGlrm+0hFZ1JeVI3lIY6EuIBcRjmHn2tYsptycjgm0Hy+luRdoP0UC7l3spjpEq0b+amidWI6/04nqaRz+KGSeC9fyRhHmoA6StRPNlUIwttGxw2odSvx7xY90Mb36hR0q2KBdTmr5HKCpLhLW0iJ7BhooUUR1okKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:24:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:24:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/5] arm64: dts: imx8mm: correct iomuxc-gpr compatible
Date:   Wed,  4 Jan 2023 08:25:43 +0800
Message-Id: <20230104002545.3473598-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
References: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 513c6697-1ce1-409a-9a42-08daedea1278
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crtCFCfNbUPd+190w+8Xdnh+hBC7uLJtb9Up9QzSo9esQjIJ/6IzHpQONjGrjJFxA0cI/BKIjpuD43c0aRG+Dc9QZW0xE59Chi9YphxVs0BERkMEVoYzT9eXx0fzwvrCTXLIL22OOHoPv/i94USGslDFOdoS3wtXLLhv6pqgaCGyrbWXc6myWn8tVXN6wrTpebwJZozRJeXHvIuYdc4oQf967uOklymq2O4aVeFm0IL59sEzi7shNo6eUQxl7g9rBQw8u2llH7kF/XgPVQ/XAym54StEE1l+KyykLTX3YOalwfn2A+zf9aQyScJPNZRnea1rv4MYuMtLa4AOsBmoWhzXJjoxTustlIYAQe4z+Y+88EsaA/Gj7yB0kqzClND0bsAkGUvfzTOdnMYBv2Y9Pq37yxiT79wj4pt4MWwCKhzauvRkK/H6006Qm16Xs5kpVPeY9kBSu8Z+6YD3aDqPqY9ptslpHQXB5QC/o/FVOFFsRs8p4sTivMaZlbUUKSRRDWIwsF+hk8yix9PkDh4dpuy6Mk7HzqqmgzFsNF6ZM4c8HYk6n5H1Kuhm5jsHeVAmKQsIujatniBdpEKrdhuqsBsi6aIQFRHxmEtc1SbQ9kGtAUCd8V+7XtAF+/u/7PrancLicvfSdkVbcZlWTLZCpHwQ+pMBc0Dgeel+1oT64TXTk7mEYFfbZy0b1Cu617p0dEjhPQDIdWcim1oljDC6thcW3A+iZ3vFNpMptyrqC8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(26005)(186003)(6512007)(83380400001)(1076003)(2616005)(86362001)(38100700002)(38350700002)(2906002)(316002)(4326008)(66946007)(41300700001)(4744005)(8936002)(5660300002)(8676002)(66476007)(478600001)(66556008)(6486002)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gzE5o82Q79MCBkxXjmPP4E8s+y8L2o3n1kcTS1DYH5FIdofaSFrAtiBHiOBP?=
 =?us-ascii?Q?DZx89Q08tabAmwc0npl8PiXCVf9UBiobfZujhurOZfYrUETVGOWSPCvy7YW6?=
 =?us-ascii?Q?RzG/SaVckpQJavMa2ZzSzsXlxBUNsZI9O/zYUcQknn4rPBnUQPRchJD8Y6R7?=
 =?us-ascii?Q?jlhQsdYd0J/vOdEibgFzP9kmFgr3Mm162DRrcylsITGRtQXb57TZLxKB6agR?=
 =?us-ascii?Q?qXJPdf7zxSO9W4bUSMhb5B0wBGhn29TfAJJ3LEC0smIHQxEOAjm5E+mWqkgW?=
 =?us-ascii?Q?8XsvFCl40fPToqtjVVelScY7evCg88or7IMczsV827QQK06EUmWd3j8Vxbd9?=
 =?us-ascii?Q?ZUhNvuoiq5l3a2WGm3k0toqZNG2EI1nkMnrcVKzMCiSsebWbmvaGdzzR1xnX?=
 =?us-ascii?Q?ul5zfQt4tku6z54F+/PSaMF3ngV1aqscg7wnPOBtbWBFwgtC6O7PgId34RUd?=
 =?us-ascii?Q?Ck3S4itqEvzZ9UNyPU+EQRNTxvCLtJ66Qu4fO23ytsKzqH39GRv+MaYe7MXw?=
 =?us-ascii?Q?BBnGTPUMUj60v3C6YRBPxjpppO/zxixzq2STEvME6r3ZTZVR0cx2w8zpndTi?=
 =?us-ascii?Q?dZiF+lIVOzMP7JVysZujeVxk7ti2/US9p9Sy3lKOGwX1F9MY+yG7yJPm5dWc?=
 =?us-ascii?Q?ZiMdaEN1yzvOOkmgMAIOU/MU+O3bHcia5xn+l7k8gS7CBHM5oerK7/3GjmEj?=
 =?us-ascii?Q?Q0NZ77H63cNqTSFi5FUM6fdD58JdSErzIqkjYb75vjFdUPwvRKi5E4If+TaX?=
 =?us-ascii?Q?Dmdle2zkNlvoT8VWOog4Zfv2YjdyvdC/icNSaWSzj9qxoN8uyikKrfxt8tjF?=
 =?us-ascii?Q?sfsJ8Wm4dnFilNghWpdnDeU5ogcMg9zlW7q6Q6EHjwoF3QM7YaFrzf8JyBVg?=
 =?us-ascii?Q?gIUw3R9oUU3fV5SjO11l0TyAMNVCNgAJCbJRQhKN96mD0ndI89NoJDq/BDxv?=
 =?us-ascii?Q?USSMCih+nz8x2iQYQltZt+oik001188I4aYYoC8QELxXdqXSQOB+Ncz67osT?=
 =?us-ascii?Q?b6tCHTBxeH7vPD4P2J67l42QDntmjiLPBm8UiWmPA8uHVdTBm4v6TkgKefqb?=
 =?us-ascii?Q?2vH2YLJOQW9I9M7gMlBylQSqNd0vwKRHR8XO/DuSBpoN5K8uIB0CPLT9g1l/?=
 =?us-ascii?Q?/Fa/uoZ8QgKMabha2i8Bz9sWC29d+v0i3WccDcIfCP+chqashoVJlnj0Lyo3?=
 =?us-ascii?Q?ZtcDjb+nMYyJUOX3s/Qg9ZDKbT865Oo04vaYOxLeG0NHaLUMS2Lpzyhz/YTM?=
 =?us-ascii?Q?QR49AdzxV5cTAOvQ69MWNuWk5L+qegO+4rs6eeIc/JpkHpHMbu9xlFI2/rHE?=
 =?us-ascii?Q?u7oVwAsSkx+qvU3Vz/3TQaxpnlMq7TGcKav7DO0UHr9BMOpb2F8fX8bKR1Y1?=
 =?us-ascii?Q?pFIumnQdI6cZBSCTFO1VL7qSdLnIMlFKbrf+fshrNeNpMGay6iVmTZyLRv2P?=
 =?us-ascii?Q?xIlGrHI61q5r1wgpwC8J67xXgu9MkNTwixXMpzIw2OwRw1eClRJ4pd+ov6ji?=
 =?us-ascii?Q?pu3dqex5S424sjHJOMiYlZOiFKShnj6Ak5aRFVr2z4uYUviJQiST5bfGPU1C?=
 =?us-ascii?Q?U0obEAjvSrh3EPqA4m9PsYlPF9jVMNpfplpGWzx1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513c6697-1ce1-409a-9a42-08daedea1278
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:24:41.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGfxqab6qKCBOu0BUu4zMMg0zwitYmefM0e9iWUcqkmobOoPaqxGYxZAX99fFmkH3i+nsPVKimnmDVBgXALqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4ee89fdcf59b..42cc6ad1b607 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -550,8 +550,8 @@ iomuxc: pinctrl@30330000 {
 				reg = <0x30330000 0x10000>;
 			};
 
-			gpr: iomuxc-gpr@30340000 {
-				compatible = "fsl,imx8mm-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
+			gpr: syscon@30340000 {
+				compatible = "fsl,imx8mm-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.37.1

