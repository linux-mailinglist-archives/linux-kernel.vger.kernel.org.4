Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97876C2CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjCUItu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjCUIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F051258F;
        Tue, 21 Mar 2023 01:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LghuMRC2/8d593XmNPER7FT6ULiA9TVWrIgDqBEEl91zsG5EEosldLfgn8irt7Vq0V2jF6U21SirXSBBCu1duUom7pZtOPqCdEo9Eq2c4so3sHMuF4L2178XPJiXNACiktGTcwm9n5TK+3K71F/y+kGvhii6yaflnXq/YatI3y2b854VctBFhUm8Mup8W8oGmiN8uszm1114ODS/H6WkapjQTeOCxMUI12Q+xBg1iXi1CsdlTU7/Lu4dC1Y4Y+FtthUxcnmdjrdR3wKcy8aKhnRFvTtzm36GoFWqFAN8BMeUDaFF8ieAoi16WsO6BKpzTNL9E4f3tGkUDwvrgWVcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hlEhotFhkg72FyYq068bth7cR3cLx6PJeLSFh4yT3g=;
 b=P4niTx9E1qPLkduY7UF4bfDADL7DGYlZb1ARXv5h/EgCclrfAoiN6SBW+eviXPGhGJkmmbXG/ovJoFFF5GasbKtSpe9tz8p0LDua81Vjs54nJRxJhR8lTle3PQXLB9u7tS7Z6cnz1csw4L2O2AO2dHrCgn1svqjSiYi1zHmFJXgLhiUKuT/2iFlgxL+rWg0fFcdIvV+LUBdS1vOBBZbKXJo1JCEFFLEj71nOglkirOEsMwF/nYQiWCk1X2ErNI+uwX9qmR8uVoq8KZp57LAmA9Ho/JFGrYCtA9ovGQp7qN23gnjd6m06/MtMNqe7PUEN/m0lTjvxaH+BN7A1qdS68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hlEhotFhkg72FyYq068bth7cR3cLx6PJeLSFh4yT3g=;
 b=k343HCSxFB6f3NWNclw/QkS1kIU28wPUpUiiZjuouFMQ3J/ADgLnMxZOUxR5gilIXMhSMgQs9xkuCDzDL1fBM42MJ25Ou+nbLypGNmNbgjcTj3kn03f7d0zbFhoQMvOcK721pkiNFUGx0EKXacgu25STiRGihbsMXDCCxX2nmOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 04/10] arm64: dts: imx8mn: update usb compatible
Date:   Tue, 21 Mar 2023 16:52:07 +0800
Message-Id: <20230321085213.1624216-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a7d89b-d620-4ea3-df86-08db29e8e7b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAkUuNU9M6qOp/SVbBf4eZE1XCGFj3RPV/wsAXe1gu5QvT6RDFbfU0SeucSGGTLZRWcEInfVneM7EhNEFAPzz3K3viuDTjy20cz3vBtASvvAhNsrcZAcVQEy+JxVkAPsfo0jm7QJ/ZeYdNePlN1p4gpeS451d/B4C4MllUgIYZWdx5ljJha3LR9qs1JEDKt0XZXrDzuEuGtCdYMGMhjMXOWyzECv2xMkmdAz5Ck64lKmLrkHqzWNQyB/5DM56oYsfvr5bhenMov099fsKxxqB0tHSeSnDk90sKsLZUw5FyqAzzbFpT5d6vauqfqJ62S4r50pIUraOeeBhjG7WBkV1hjIzjAPv2o2OSedlugPpCPqcfDD+/BGbD723YjYLdAziSPoBFSAd/nVQpjt2ZKyIqN4MOt/lesi5qdCH5mesmYUlPZD+ySeAczbm2PruqccfBX14Z7p06QKNiSbiEthlyXqsBuwNIlRWLfOFwnqk20VL0Zje7n6tCbZ3PgQRW2oRvS4x59Hm2LVGbf+peXBgn3rfnFhlf10NN9IBAULhFmf2+C4e7bup3gYvfGBO9vM/peqiuYOu5vt8uvv5gliK5GGzA5RfFci8o68ROKNHmhnftWucXcWa966JJUQhoMy2upBJDG0sWCHAMFvZvxv5QgtnEef6q40mkHXaIqaj4cvccu+gBujgclDx3sBLzGFADZDHGKgMHLqwi9MUs3HxJTm6km9EeULczGQZm3fQ2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(2616005)(6666004)(6486002)(6512007)(186003)(26005)(6506007)(1076003)(52116002)(38350700002)(38100700002)(478600001)(2906002)(83380400001)(86362001)(15650500001)(66946007)(316002)(7416002)(8676002)(4326008)(5660300002)(8936002)(41300700001)(66476007)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UumrGH0Ubkk50WQJU81EG3ZxEX0rb/du5N/fYY3aioclTGUMH+ddKpRBK2O4?=
 =?us-ascii?Q?BJo1dms+OkBKEUx6olZbWhTGsrBFoYTkEZCHY2oz7iZPZGG90M18H6vTHoY8?=
 =?us-ascii?Q?TpmTmFIBpUmHBohIQ0vvOxIqust1vrn+CzskK40kKwFGcLvf2R2F4HHoznMP?=
 =?us-ascii?Q?8WdtNoHYTXPL7mBiH/Lv5MswWYv5u2iFx1aVyKH2YI0Z2PYZO90vuJolaCmk?=
 =?us-ascii?Q?KII8D21Q2/iMSMuK81C8Wjul68Tyu9Bn/lhCWurR4cTczpWfCkKbZj6jg5rl?=
 =?us-ascii?Q?Gi9aTdYuJLcoQ6ijUQk6qs4nf+adZ/t5pA7C5BfSAL4GbUuamgGtGTlw1x6J?=
 =?us-ascii?Q?GKOUM3UyiSTRKmF4qBEucwPLTKgSEi6/115KCpa6tZ7pmPNtbQjKhHIge2P5?=
 =?us-ascii?Q?5uUTiDXj/f2hmqnwo9dN/jU0U6gZbwqk5Yq9gRyyf6+kNNh2kXaivOJIzP8i?=
 =?us-ascii?Q?Qulh2snHioSAutElsuExIGAFYfuTSH22q4Xx6vC4kX5zK+5NficOkaT3lo1g?=
 =?us-ascii?Q?HEVyM4tzl4OXJuN8qRzf9GnjWDhWg6zc50P+VaizFON0QREpk4ch3ZXrj6sw?=
 =?us-ascii?Q?qckfQQlktsRHsjj4dTqVjjg+dLqXFqIcDvHxkXquNKuY94U9jUQjUhJscPMF?=
 =?us-ascii?Q?IWWc0gzRR4zsLh29DkdL/MqUnc9HRDhMWnCpVKw3ml2+AqgCaiNxNrNOdGoj?=
 =?us-ascii?Q?3feeRZgmXt+x1E1uNnc/yPL9VWvLPTvrZiv4oh9C0b08Mvf4fCa9Wn/1hUsr?=
 =?us-ascii?Q?+SKAPcFcc3/UosViihH//yY4sDVAjZzI0HfBlQob1keB0m1+8MEOS7mBH4mr?=
 =?us-ascii?Q?n2AO0/5/yzWkPAd62RO4Orqx68iIiDop8ZiJTRD1xXhnjJhmq8bHcTLTEYZb?=
 =?us-ascii?Q?+axNSd1hXLtgYAyupyBzz9vBp174tFE9IjntSDo3M0scPtTnI9OHitZJMsCK?=
 =?us-ascii?Q?VZJtlRHwwWLWSFyep/V86WQ20orJ9/mKe8v3aHGEbIy3cTLL+M+tMB8+TZdY?=
 =?us-ascii?Q?oFkMun0O8MEfmLH6g+gPjuDCvaVPVd58/IWpvLdbnFj9WAReNA7y1dDbWmiq?=
 =?us-ascii?Q?iiFBgnQHby89FmtphIO0K1/b2c4ZWzE6vQNRJyRCHoScMe7IRlxNfnOcoOMs?=
 =?us-ascii?Q?pILEBSddG83CpIvhnkcqGjk0EFxmwhiTFTgS5gCJ7YGiL66+cgBZIFm1Ilze?=
 =?us-ascii?Q?SAvz/Z9fiC72PXrl77eZqdltNUZfqvJxvAeWk5bSf7t5Oxjl+Rx+9ZVTcWnD?=
 =?us-ascii?Q?RNQoH7bQYsVrCgk8iyZbsSaNDXJfSV6MrKDHO/MgDNxkA+vRixd3uDcnp0VX?=
 =?us-ascii?Q?hjvjaC68d/VZu57OdAmZohO16nNyw2GM40GkPw3tAzgUZL+j2A4ZV/j8i+s+?=
 =?us-ascii?Q?aYKBG2rw7EdUKDcR3c8h2r5M0+OYVs04PYTW9vbKMkYwSkDub/7whgK/mhUd?=
 =?us-ascii?Q?PYODygj7+9IkIdglNX/2sza6IwcC3RQRg/3UFI9IkFz3irlbEnfAuFAWoPdA?=
 =?us-ascii?Q?g5+Et2+w/orBgU0oFMYzw2VxXrqNcY1SVJIqYSbSApkjMTsAIOn2j/zhbgM1?=
 =?us-ascii?Q?VvLxQOgtxR3I6aTZ1RyqKkry10Kpks81Ee82kwyE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a7d89b-d620-4ea3-df86-08db29e8e7b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:30.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMnfuScK1r4gdexCWBSlNE0p7pvH/FNCNZqmozuiTryh8KjjIQIkwkbSwXagl0L2XyaBLHg0s++L2FlZy6Psvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 9e0ddd6b7a32..7b58660d9ef4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1091,7 +1091,7 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 			};
 
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
@@ -1105,7 +1105,8 @@ usbotg1: usb@32e40000 {
 			};
 
 			usbmisc1: usbmisc@32e40200 {
-				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
-- 
2.37.1

