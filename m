Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD42E7507DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjGLMNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjGLMN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:13:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D831BF8;
        Wed, 12 Jul 2023 05:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5vaGTzHyOHpd+dyKUMAnd+D/6ngkwsczGEFoITKROil6KA3nHWN02dMInASb9KQhf4m9kYL8WehWf0TSgvt71TkNIlqP3n+pkQL3AkZC5/BgYuJ/VDhy3x6as/wQDV06yCwA2sieMaIzQ0QNb40CujA7wA0SlvrHnVa1F2ZqHLGsrMWl0aew4USFP+NghQBHglEdDTKl8H8AFYSVkrrnckyoj7UvskdJx4nqTGDp2lVilnZcYN2oyliuEcVWWnCuGlZvb1M6hju0IL1cbgI0dH+u36H7yhIUu1Tt5hdCj3WScr0nZ6TO2Zk/dFJxP0LPaKoURauFsb56S5zbQJkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n5f4SvA+AThBf5AoCDJjgWiZMHntoS5YK2M8gAUBmw=;
 b=HJYnsQhfHWWklo9rcDTFOKTexrkXl8CVr210NDoqTXnp8VNmYbAR6cUhIfh1tRuHlrXTUn4oftFJRHBFAzPflsv+BUHd/g5W9RzFrnysqlIu3/yqSME7JWVJxvQhssoDMgYbNtN3LRHzoD0+LqahpX0uHYL4jaq6l9caxVEj00bsQIB91a4E6sfnLjR4L6uwGvYtkG2JaR/D56kXYKM2qQZb8qTkWGD5BBFWoLMIpRUGpw8g/iAEVGwSm91Rdd+yv4eDbZryczCJ42tQCnN7zmBPI0QlKly9j5fTzD1QMLXBUdA4hxqsrgOT62vThVUEAQPP+Tl71R5IBGW2lPv42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n5f4SvA+AThBf5AoCDJjgWiZMHntoS5YK2M8gAUBmw=;
 b=ZxFZvmU7C+9pDrlCCgRKSvlEA42/8gIdVjeNBopsK8hD+zub7L3uWrAOdIRRC1OZvT8XTnveMNXA7709CwozweJBWKNaBYbFtDmjZLp+tmX8lULEiSKloooEvSIUqvpBlCWoRyEsR94borWKatV6rWLZj5tQlgwZdbUkJCvF+1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 12:13:17 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 12:13:17 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 3/7] arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele_fw dma-range
Date:   Wed, 12 Jul 2023 17:42:15 +0530
Message-Id: <20230712121219.2654234-4-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8638:EE_|GVXPR04MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: d1287d6b-5152-4ba1-a2c1-08db82d15fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4irKeT7BoURpT94LHItA52ra3tkKTpsOEEWC7wD99xAqifriv2gro9Sp3SyGq8Y60gOX3XZJU7H2wZ48qpXn8HyMSjjSbWp14pqXm4xyn1AX566IkRGmEkPQ6I980jBOMloiz++h5CVKE/bTkZ+gSCvE/IuZQa0shs5GVWrhPFjDQfE9bQYEWKOpYJV6iZKxcosue45ml0UzeL6roxH58p5Q1OPsMo0/tKkHQ33tAI73er+nBLar97KFvOOowiQo+kxMS/K8VSJ3E3CqeKO47yuwqGLV3s5pMCc+bSN4irvuY1vOGiK+JJirjDaNDgrpkW2iDgq/s0dwWZxNAxMJJsNJtc903S8Ed96abPK26ijDi4E3efdED07b/o3pkh4ZjVSQfENhRF29TtxCdCeU8hKtp1Npk5OdmAl0E/2p7/QeqQYGXaEBp1uzSrbm4hK32/+qpkfdWoWwqUTshpDlCVKOhrIq+clWQbFYY+Cu6FETlEnIO5ma1Vs64wfX33xinyjJWRjsnyG3WvlZ2QU36SkKjfMRWBrWsNQaTAhypRpe9iFL/HIB/7Dy+jS08rQ/9kDjpk92UCV+0b/NhNVnRzds2AjgIqgmCQeb8ed/w6CQ+Tj006q8HvUS0a6OvYumQCBdR9jTyYw6AMJfPeV8rF5ZT2EdmN325bog4K2ByE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(52116002)(6486002)(6506007)(1076003)(26005)(6512007)(186003)(66946007)(2906002)(316002)(44832011)(41300700001)(66556008)(4326008)(66476007)(7416002)(6636002)(8676002)(38350700002)(8936002)(921005)(5660300002)(38100700002)(86362001)(36756003)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCVgG74vACLOhm8X674uZU11ETtOW0EKZwdEP2+Q9yven2vv4Gfta35IH9o3?=
 =?us-ascii?Q?hO9dhEkQksebId74sks7cBv0hqjj2NG7lFhOT3rRWGNAr/G9Z0WYl7Fg0EZy?=
 =?us-ascii?Q?NSu3CC2K+XqqSdB0r+C9Ssh5Fx2dks/KiU70UDDr/wdkakQ2R+twyhNWXGe4?=
 =?us-ascii?Q?mOGFgsOEDtJlYHI4MAtIy2umPPm0hBcv4YduhdsI/FUsnnMSB4Qv6cgv8tkz?=
 =?us-ascii?Q?RnbR5KKaGSfNWt0Xid1NpJRX7D8r0Cwnj2Gy1vA6w4IAWl9W+VhlfQfLm8AY?=
 =?us-ascii?Q?H8HTWCIOsVuY4DPnlMULejlcYMSwb9qRP7LxSb3FT8qiWUpsVdauvduluS3C?=
 =?us-ascii?Q?PtIMUob8HZ40oSejzKBMab+lui6aBcDi+ZGThL7G+SG/LjTM65taSyaS1gqQ?=
 =?us-ascii?Q?zGMInRCD7VRPLRUp1mcGa8CMvAPyff/59ML8IcVOG3FPyUienT7cFPhZdeiJ?=
 =?us-ascii?Q?IYnze/lkqZzi32u7d7g1yNoOJ1/znFV1DdS/2U7da66EoSb25VpI5vj1VX9J?=
 =?us-ascii?Q?oH1QcZDVbgtYannn/lHdIN7Obc7MDE8KPSTijDDNaittl/sCpQRnKYwRop1V?=
 =?us-ascii?Q?r/2Y+NVo0YPf20BDxIqbNcUxg8J56GexfIfoNCEUDnMCcMIsCiaPpLzkmmfH?=
 =?us-ascii?Q?GVaSBJQEihHYOMz/BrpvFVSFVCppw4+raj52oKwgSVWzrI/XZ8H4l/Hm7EHN?=
 =?us-ascii?Q?Ou8p/HDZu6TNqMPnFKRQYhCbAKMfUNsDR1taR8+v0o6LtmtAcghHsUz2Mgmj?=
 =?us-ascii?Q?PQb5O+aPSp9Tlxpav6swcy0u3kh6RP5l7q4+hQSEaaACZFURA6X7+P7ZK21D?=
 =?us-ascii?Q?/pWJs2WhYAKcgN8ppZ4X0408c4kabkt4zQQqJAWptSuS/iA/D/UR1MTg72wu?=
 =?us-ascii?Q?FG3YNJkeW0bOEIa4DNI0IlMbUAzQP0akwzDfj5t+96GD1D9Xse/WKqsynTu/?=
 =?us-ascii?Q?KLD1B1RENcVQPgh3BFHojlzbOitGOiFtAJAIMr0bv/8FLR+3rWXSmI9i+yaW?=
 =?us-ascii?Q?w+0aMhxy97EyklqK4d/z4mYdRxkeFO5g5NxKBHeOW1K3WG4CNXDcx2xqoJBw?=
 =?us-ascii?Q?Ui4odcNkVqLmQwK7CetGUtUiirITXRIrc85i43ncpCaRGCtUb607D3K+Rogq?=
 =?us-ascii?Q?NEkUlJMgBKxM9qRNb9Lv3Ajygsbh//ZuujDv1U4LgNxm2Oj0nPZvgwaweCUl?=
 =?us-ascii?Q?dVwnNKrK84ZUajgMeS4wMbtE44lPRPjHIFCpGu06+Ps2CYVlCZXE9/PeejQi?=
 =?us-ascii?Q?zUyjt71NFa+xn2oVeHQ3uEeqBHfzmPcuj+clMeBSTKEdGfnMSMKpHXv2Mzo6?=
 =?us-ascii?Q?m/eFfvBW3pUmre4j4k/Ne/dteo9EHxLG1SDs09JF+5SC8CDO6ZSKGAAvjEPN?=
 =?us-ascii?Q?+98niG08bK22P/LsMTIoyEsW1xG9YOcv8sAU3lp2cPGQdw4TL4UzOoeE9cpO?=
 =?us-ascii?Q?d9xf6DS/Z57C0RNUrxtfEFHV7hkCZV7shNPxuyaE4PKoN7wkOUmHiMOLW2tc?=
 =?us-ascii?Q?WGNugGtAb+Hu8VjK27SG5u9jlvr9BswG2kwHuUUbIMEWVsCRM8quKHOEnrSX?=
 =?us-ascii?Q?WiE3gzfT4/EBky53+SCnQCfc0YH3H+ZkKap3DQPu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1287d6b-5152-4ba1-a2c1-08db82d15fe4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:13:17.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXJCVzOX5WITeU7VF7C1kbJcBV2+/os8uxhb0MD+HEnL6t7kmnnufx6Hgbk+i0iXafPxgfFUlaE0wcRFux3+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x90000000 - 0xAFFFFFFF

ELE-FW driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index f1c6d933a17c..e11b56722348 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	clock_ext_rmii: clock-ext-rmii {
 		compatible = "fixed-clock";
@@ -53,6 +64,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_fw {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
-- 
2.34.1

