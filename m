Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D256A62068E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiKHCRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiKHCRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:32 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EEB27FC5;
        Mon,  7 Nov 2022 18:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLUV6x/Ja8juqfhvN1dTKVP8F/+7/1ShkPMeiRmXp4ldPE9RlC3xOMyxtdX5mVhUn0XDbpbw3BGLUgdotZWRMuxSck6R2u+yiiitTLd2KIJiUddxF5jWO+q+khrMbhhXRrulJ9EfG8XyG5Pn7B0loNpoqXJilt6PhqZ415+chtxinEfAY22gPcHtVW9LLjp0A2MwFASj/a9LO5sa3tezsk5/aZSJXtA7k7K2WNbSDoYYbRnCnp+Q1FWgjiBPjSiP7LRUuyngMigG/w2bNGKp1oPPhzeeDbG/X/FayTl8WUSZgdsK7KSZ/0wxc7pvVychABGwInt5hRNcEKip1EtpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqQhrYUqrPGsX58WHIHx+VjV6/HB8iZfsuonkjP5t9I=;
 b=YC7fnhpbHsAsVCEip8wGa+Hp58J0b9oP/UOdtm4hvigNucPsLaO4jyXP4JA1GsjVcmzemEnJumT8WkmOhS6b0wj8v/i4yoxgw2m54nC4oy6DX1wYTUS6Eh8TrGckYhYluGUPcKZuz1MYe5irPpgL0Gkeca95ArZcAixt0JwseraQfSZchNLI1W3PRXJMazxa4Ck1ozmI1JAILW3Sv76pUsIGkJoHffCA57YNz84nDutVwDfU9Zjnck7C4h9XXdnd/enNyAKkK0kAYyUxOKhkynKGNsCqGVNxt6OieZjcElzYpTCp7zFJ7NSpBvQMQICP95wFkbqaxM7+MAFn7MVfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqQhrYUqrPGsX58WHIHx+VjV6/HB8iZfsuonkjP5t9I=;
 b=l+vvG6FcZ3+gWgaiTx/PLHz2Fj0BcX/Ca3msGjUygTlfkApOMoSZ+cgsfIFh+EumiRcTh39TNjzeTaBqlIK1CziK++kP9/LTFWTPVv+Oalrdj6a+kdlJWCRjJTcljUejRr2gkbdD1UqSqkZwL3+zcZ1/SSB9O2WSEeTSFNHDSoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V3 05/14] arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk
Date:   Tue,  8 Nov 2022 10:18:11 +0800
Message-Id: <20221108021820.1854971-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: c12a7fe8-11f5-44cd-8002-08dac12f614c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zln/7IwRzJCdYooXZqmEXj7xZJnXqk9cJbynQg0t2FQ1B0uRURaNd62T6KYtPyfryVEQ6afqJfr0EmyENl1IUplQ7/vrJrcrY800zupfFoU0rCx8kdNAUgC7r4/IfNzkYU42IDrKWyzqFurdA2iM4Pay4oGKfrPX4J5yWwREowrKdjOALBNwke3PutlF1VtASJEAk8Q4OjhnSiVxABToBLDUKHnd5k/gD7geg0Gn6LxuXrej2cIgZVLhGYQ4HCGEJrmhWEmMG6Vi54h3sq8DhdQkGimh+mLWyQpLjzfUB+CJ+TnrB33JP5TvW5JzhR52nDA1qr5Mex4vmdGHALEjoIt7TUYfuN+6P+W5kosvkXKemd+9mW6HtlCkvdyWF5AJAphOZFqJ9Qj7QJhmSJdeZ1I8h7zNvclLIFy08PaWYHJK6mjYZjZTRFzEvB00b2bM4yfHzkE/kWmgLJde8Bc3HZJOcLExYxau8Z5z8PW0riZvgIXMsF4Cw1dfjghGzKNt9PmgoKSKlxnvi7qkr+RMt9aUkyaljAjrvhPCbJYNbnF9Mf/zHNWdsFMWbqmpPZkH7rEkIFoGVfKtKv6wTc1MwAxyc7Tq6pJWRZUw2kRKt66eJP03yNwMJnagpGDjoQrH6hmMwW3a363FiD9l6NNdPnf/xMRu/Gl20RpKm3Q5OFmLtOhwyC99zgnK9KBs6oqGJNCTMy06zl47nLVIS/U19lQ1TigBLQECu6dhCr4c9EMS5YcgCT+uV0vaWMIAnzyyrf7ElXVXMlbSQqHfZJSEwoBoKU2ZXSApMLGPCU5FleY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(1076003)(5660300002)(8936002)(7416002)(54906003)(41300700001)(6486002)(2906002)(86362001)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(26005)(186003)(52116002)(2616005)(6512007)(38350700002)(66476007)(6666004)(38100700002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgQC53JnvbISGFGEBVpxe7tsLLZTJ57920Y8nJdMHMlNOZ8kRNJuQ49RC5UO?=
 =?us-ascii?Q?5fhkDrTU9DKODpVDK/hPZIW9qJANPJ5hyjDJRYt6owUKz6cIbzYKq0DkRE/U?=
 =?us-ascii?Q?KIRYJbUUuvfVZzOvT3AXusz/DFSBMWwz0LMZaH3EZoP7H9WswXzIxPUXB8cU?=
 =?us-ascii?Q?9DCAEZfMeh+SIHXeBtGxEj0h1igtp7A3Y3zgxqrAPsS+HxqavgFIvthLla42?=
 =?us-ascii?Q?2aFcplFFtJsMgT/l0O+L8ydeujd0E2B6l1p1ofOFOf4lnDXPBh0MnAR0/uII?=
 =?us-ascii?Q?BDARbXQI7b59q1N+VLdbgJXoo1jHb6yb+MC6CQ0JsJadJ4DrfPR3KKO4XXIE?=
 =?us-ascii?Q?wbgl20b5AsGp1VKrvETEfl84bjis6MN5369ReELMEHX9yHW9gxFSX/heEw4A?=
 =?us-ascii?Q?qgM8lRRyzm4G1khqxvk7KWRiGKC/23BQaU+CQO/HkYciDkyVugS2AfJbcyLX?=
 =?us-ascii?Q?mIL5LsJ56sl2DpSOT4JPWeCY5KIGtbRM2UT6jNTndmx1DMJQGoholG2b3x7U?=
 =?us-ascii?Q?Qwkae+lFHbfoeonNN1aSy3b/Svwl9FIs73vAtOW0vlm79DvT0jspWB4fNc/7?=
 =?us-ascii?Q?1U9dKeJ9NX+pXg5cBPZjxlMKeyVFZBJTnSZK/nHHxG0Txwx37H99EbjIUd0v?=
 =?us-ascii?Q?XWyITCc8rUZqzGNhiZVoD3BtGIPEJesrzd/Y1Eaof7gV4iygbuKl15rXHhBB?=
 =?us-ascii?Q?1deaU5Rn2k9StcJW2Wh0b4LZUrd1M3/kSk3sjFNbKj6RB+SBbODmUE9DpQ6f?=
 =?us-ascii?Q?xshq1RjlX41ts6A2GPH/TsEzwvkXENQTtRkPqtp0zK4hyuCw129EKsPDJ50l?=
 =?us-ascii?Q?KX8K/uCNKkEc/1AoSyzL8ToxK1vA2kAf8weLd/C+uJjHUYav5JTzcNBy8XzB?=
 =?us-ascii?Q?zQsaU3RJD7NNlEnHNkE/QoYROxenDD8U2IKBoeFLSaIic3wAS2qMwV5AP8lW?=
 =?us-ascii?Q?esRXZcivFUH6VN/6n0NRiDPswzd936bzFKuAOth7vU4BIigPmlEMay+tcZy3?=
 =?us-ascii?Q?aPQTytToXNuEydNJd71mKr2ZWHxMBlGjIC8Lq8QOeJ+bGSAJb5rVCqoIhyKx?=
 =?us-ascii?Q?RVaXtOd9otMjlg1H1+8SlGLJYwEzx/67QfFYO7gNwr+wgvB5QprRB6c/6b1l?=
 =?us-ascii?Q?+JDE45efJiY2blqCcKc+vW1J0P5HOac11qgbMfM9hNA2S4XN54a9OSW07l1J?=
 =?us-ascii?Q?+0/Qlr38Rua2sDnBTmDPuRYXntjmbPUNz2a5QJNMw2zOBdfXpbrKyBVyn1z5?=
 =?us-ascii?Q?ZZwjkqgW+Wr1ywvfV4gqqOz1tTVFYaNeVOfeh9Ehu/+acT6f34In+b2DjDI3?=
 =?us-ascii?Q?ski+0mfMufG4riEiGXeAzwGvbG6aE5Jn4AmVTM5UmMQF3IQyxrEBO3MXHPiK?=
 =?us-ascii?Q?0k21B/vDfb4y5Fvd1jaUfYcPe9BAiWwPflW+Tc+JOqhzZPaNRbpCg8iGrhNQ?=
 =?us-ascii?Q?U7ile31JQE3dVNLVAbNJ/HfwMoxNlrjhW4cC8V0ZdFPjit1GIcdgwGXo9sBj?=
 =?us-ascii?Q?ttDGWDxQ7sLF6rHIt/KChuil23mAn4PZTrUFkif6qxfvF8bBtSJwHg/12T3G?=
 =?us-ascii?Q?rjbEjdkGeQGHBeb5e+GPXFhrUuJvNDZtWx43r/4S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12a7fe8-11f5-44cd-8002-08dac12f614c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:26.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4AyrL6ollMFH8p/Nw1F3RvTByq5k6lUDSEVUlkkHneXYVRm9kLHLN6y/XYqaoiuIgzv0G/y5NbhL7ESOa9e8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

enable fspi nor on imx8mp evk dts

Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 29472502d547..4164f69a89a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -85,6 +85,20 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &A53_0 {
 	cpu-supply = <&reg_arm>;
 };
@@ -551,6 +565,17 @@ MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK           0x1c2
+			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B        0x82
+			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00      0x82
+			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01      0x82
+			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02      0x82
+			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03      0x82
+		>;
+	};
+
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
-- 
2.37.1

