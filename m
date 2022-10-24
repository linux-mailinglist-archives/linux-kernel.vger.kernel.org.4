Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC560988C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJXDOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJXDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:13:32 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F477EAA;
        Sun, 23 Oct 2022 20:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeMZEe0qaT6Dca5Onnudz8KJK3tfxvEH6SVQUyprqlRkSFN/R+o8b2OytY6v7y6DdRAE1UQjceSADkE9hzx6jKbsdbv2oVL5VkACulYl4yJ1V/ShyoFBQHMLuPfLxZkm5A/1QgUzl68Dy9Ez/0pe5wA/dOFSDsNrBsmFf4nkhCtunYr6z2BAxNr8qrkYwRVZ/BYtP9UAaCnaLW1+ECo8B7WYqLRurnGKWdrbZODqVObysrVE7BEJoLH9lPUUW+1IsPj/FNeJ2LQbl3uJxwzksu4KCQEZPCv3hRbHGYnTa43AFV8Ae7OaRGZJgSo1ePCxW8kVqf1MBDHhxGRJs2V6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li3UaHT4yTsL+yb6BzDenMRSSdhbqZl5Bf8jyKKV+uI=;
 b=npcrMbXQmfEgYOIdVKgfIYoXKDJQcnM9E4NGltSilITiTlMowdLpogmAvwQibjVz4Z0gdavu5RJiJcDTRpnCkp0DPSA2R3xvmkdNejlKlaLq1Q2VJ7Q8OLZpSImxCqAv+8I04rD0x3EIEs0GvY5eTldRcKpNgJCc23F5curlrbrwIZUetsHIT/2Ke+mCV87bSzSkbEjWjeWcsVaJ4a5u8tmKfzmR37WO4rNSTZ6+o7e3nSaG5edUGo7p1Vh8xdYlC+BJ30+Dk4wR7mDKjoJ3J0/IbGldfum6FeNpR1J1OyD90j3ZJ5Hd2kogKFGsZTXI/8VpALWSFXKJZgxyaL6lGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li3UaHT4yTsL+yb6BzDenMRSSdhbqZl5Bf8jyKKV+uI=;
 b=IyyNqmK++nfCVidRaMizComj7aLuiiYIyJTeNTT4jkd6cJXWb3jMgcT9avQKV7n+XSv4yIgNps5sjJWk704TKOFGDdXHMCfsgYTm4ABKM6IBKBj+58Hu7TwYfbVPUiJdxhkB+wX3mZ5W0PhuZEhfzTdRQILTHjddrv4nKW8Vup8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:47 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 07/15] arm64: dts: imx8mp-evk: enable I2C2 node
Date:   Mon, 24 Oct 2022 11:13:43 +0800
Message-Id: <20221024031351.4135651-8-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: b365b1be-d00f-4d79-7026-08dab56da00c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIlj/BRyDntuIjLtqjERHXhSdV9tCaJiq9KwDdB7xOanWQeM5V8wEdRy43+DRR/EntazvDOuk5zuPiKfMIKhW+DrUMkwLSsQKwT2C2LhscRAQJ3Xv9Ih4Ecnj+XFjmapjS/81KjDf2hSgfBW3rtnPUDJi6FOPPPWC2Qx0we0UuDv0IMt8T+zmYTZHqMLjrnYFeHmm8iyQBVL0nvUPdnaFnS6klx4O1/NQ+Fxzl2sm4DFeTrnBMXEUcvrj2+I2bKV5VM3BpUoyF6d4xx9kSOoBl0KWewQHjVBOz/vksnzMs3kLsFOO0XcZWgZxMzCDRjfwV58noF6Ia/1Ts/m+LWoWxmOnQdv7l9Hv3lsx6pfe6QD4hnmae1YIq7siP9pS7fiG5UWUcv7Tam47aRyjnCNdy4S4m3aPxe3wEpaFnTnng8h1bGROWpRVZdeFrGyzBkndpNhMkk6VBzgzu2QS5fkwlBQ5fc1Op6GTvQaMlPpSi4I8d1CUiTpWjWoP0o6HHWXzzuSUf0ADTHtEF0A7GaH+1unJKmJ5b2V2M2H4p9PTVk/tL7hVndfZ2zTIemxVLGIBqj/dPGA1UJY/F78Wrmr/toL8O+HtEpT944VKhnDbFpVfHY/sKjsW1oFSM7c6SdP0b3V7WvcYeRfWiC3VWKp1V5kzpnZy48zsfDjZKmNRaNMrs36f1KQpeksQJF0rqL4Jdm/xsEWS5cdQg9p2y9bkp/9c1DChP+5apxp6058FT8GUh97Rczs89y/YYPU9DMxi3fMdPzVEFsJi6vqIMcy+6dD+sNlPd+r+Vu/cEgzpyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(4744005)(41300700001)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yNPXOhHQ67lxgHmpgA4OzXBcoULfE4k3eOuyPk25xn7soLHFJzusMZELvmgD?=
 =?us-ascii?Q?tzT4eOXvSS1gw5Z9kLKDI0YRpxPeniVaqAf+WJEwq9CIlZxVC9FIzCJvxiur?=
 =?us-ascii?Q?eErRRBaUWjUHGGF2AVX04WJDpuNTvxAwM+j88+Au/KBOfXWk8jPu3D4cFxt8?=
 =?us-ascii?Q?JECt9BZQtBIFzR9kcKfV5x+qdLnlzya5EEZYGiNQzufXGIo81KtTTfALv+Ms?=
 =?us-ascii?Q?5uqdSv3Lprw7nOYK48t3pOd3WdQyESZyJ7awtNpf9OCeMDkIg6OBu//FC5BW?=
 =?us-ascii?Q?thD3UJ/OE+9cNNCsh4Rzl5MVbxts2HQ01vbquOvlKGLjSi6uLv/TQsuhHX2A?=
 =?us-ascii?Q?9RSRXKzv5DqcfmhGaJBQ2QCbYmxNptXI5udJ26Hm7F9H+INvx+5SIclK6QRl?=
 =?us-ascii?Q?HAA6QaruQ3SbMQeWBQCA4SkoeM+SGbjH2NhGan/aiHDY7pEgYugZxAf8HMR9?=
 =?us-ascii?Q?xLnqB89/E0+CgpFu8JTVumMuuR/0FoyqhMrDGcjxnqKC/sf+2rGEqcYLnBGx?=
 =?us-ascii?Q?gwan0u1ppi9Zqc2FMO0EbRG4/Y6Ieppf1391vDEWsdv+2hq87+rIeTxSYQot?=
 =?us-ascii?Q?lavLb9TYWDjO3vZFy6M4v8bvc5W1sWqCB4mGrSECs9vwpGNEKG8J4wl3y+sU?=
 =?us-ascii?Q?+IAZF5jcuk3rMCMyV3XIqVS9GIdBk8exTLuwjogMc+eRIlXcqD62WLjZ36DU?=
 =?us-ascii?Q?NJiTF7Su/4nBaSXx95xswabDAoS/pXSesmXvdU6QH7gyFEQygcLe2uxrCPvb?=
 =?us-ascii?Q?1dnY7oR6AbmiIa7wGs89yAylhzUqyHdZ5cFnLR+7T4LWH1iTOSlvpBZ66L4p?=
 =?us-ascii?Q?l67bfZVTviJeTKGqO1BxsDm9ECjK1f42moPnrarhT13rtvIR97KbvhCx7L0I?=
 =?us-ascii?Q?p+Z9+NbOImQ25TJJdhNwgqKPsTvveRisaEwwT3mgFKRkXeLCzA0t9bjb7Mj0?=
 =?us-ascii?Q?GuOvS5Z5cyBSAuhAC4E1f5mhhd4dkAUz/5tk/Ufn9at21wdDu/Ixv3P7iO2H?=
 =?us-ascii?Q?in5eQxrCWw5Um0H5Dh53bJwgYYmlIfhsjIl4kdSSXKrGGmTSvK6Y3wZKEFb1?=
 =?us-ascii?Q?/M7Em4lxTrIVZs4038+tK0zJbkUvi+JazsFtaUGlZAWm4nOuIrdD/Sc9JUgs?=
 =?us-ascii?Q?TaUCFFOEgj8qqLiI4O/kyGSXlGd2NE5f3eKzr4lN8qjXqokBzJ1Aoq1q1VCC?=
 =?us-ascii?Q?CmTroEm6S1uxqvOFkOGFD7dbjh32UTgECz93fr5H2sQoZxhTqIZoHSJEpVZO?=
 =?us-ascii?Q?I4W1noxDRN6LR+SkhvAj70QvCsGIGfDSwanysC//rZApI8fVpF8Hz0U+zWaD?=
 =?us-ascii?Q?OAgiPhs0L8sCT55NScDy8N/Mdv8Tz1lj+MEmxFeiVnRML5PUG66vNl/6OaDz?=
 =?us-ascii?Q?b8KfXiM0IQ0FSvzV1Gs0S97KaTELXJALjoaXuibQX6RZPj3XchpMS3i3vg53?=
 =?us-ascii?Q?h6LU181w/lZXhxcq4bEo3e8xzejvN5GB8vh4DVkhOV+FixqAs1VO9x9rI/cf?=
 =?us-ascii?Q?YS0xGJtniA8HnBeikzWFrMUkx5Ij81Yy1nY5h7tW/eYt436vVM1VbAHqGd3r?=
 =?us-ascii?Q?HB3Zbyl6mpZiKfydeg/CpRUIrZsIhbMCXjo552g7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b365b1be-d00f-4d79-7026-08dab56da00c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:47.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3ha6pAoLADqMeMupYXsdZrQIxSY8b7Cgrusqnf1uUlQjDrJM/nWXvjqxHrqsmKwdCpxr+Ppmq6Mb9Gyab2A/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable I2C node for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 54dfac4ac63b..ccd69f26a0cb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -347,6 +347,13 @@ LDO5 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -605,6 +612,13 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
-- 
2.37.1

