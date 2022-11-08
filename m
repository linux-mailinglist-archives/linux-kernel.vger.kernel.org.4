Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684EA62069B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiKHCS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiKHCR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:57 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2372D1C5;
        Mon,  7 Nov 2022 18:17:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrzC8TUY7fsqr/ZqtPU3Ld/aJhf3jrSRsPFslbqwcEkw7tm9uS7IpH3rbwpT4N9b2gKDEM9e9/3K1nbVoZ3aAZTv16iJDATX5cKtaxs5r4MoXtCCCkBS7NuZqMz+OD1gEifQ3c4ZBZah/mZMEet5+QebYC+NPIOqyLavLgT+HEMf6RuZvt25khs+qfrBgdT1OKa3mr0Vllp1GP1Z9/2sUzJbC8w0FFsHyXv0guoObEs6HwU4zGynxxguwvs4tkAmK8Ngj7+uzJcFbS0qH9OmZeRJYXccRvIQ1F3pa2cm1EnW4jtLk/xJ49GoSeB/UV2LtHDyIl0hftAaCJ3HMsWldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVZcr/S99xNnQtY1GSazp191cisvYVqNqs7IKEpic50=;
 b=V9DjAZCuxPg4LFwLFy9k2DbLvLyDrPPuWXFjo1s2u60kRNGWDKtHh3j6CgEQtF0a9rk5yEtTJz8IdyEA2ul50yfrIJ6fFd9GKmuveUeFvp51a2kVIrvk343SIzCl1iUnogwvhJBarIzxSS416cAxQi2ZtSevHmiRJLfRO9EPQOsdlcysHju1qs1pLWKz0v6V5jhw419LXFPmcV+4/qdO/sntqlAsX/jVzwKeKaQNELQeSSAeU1p5DzU1/SVDuTqpg12PVhBD9TAK/0FAefLD1HlDwkanc+zUn2IO//ji0X5UVcGXXX3J9AHTt9vMCxmyM6Q66YAjyOtFO+HA011/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVZcr/S99xNnQtY1GSazp191cisvYVqNqs7IKEpic50=;
 b=icJDS1R4/dwFxFodxpNTaQbJA9QvpSzg8YkZJAWOa5MXwx1c8HNg0IjJ7RYZy5FEIDwWhkoJ1fOOcyCrXi3KHnxGpgW3icGxMBBlZqqWr3XnWzT5eX30JZt/Sw2Nj3mQ2xmW26Uhs7ZbQh+adICgxCbr27dLr0yAGAAAKyyl6W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 10/14] arm64: dts: imx8mn-evk: enable uart1
Date:   Tue,  8 Nov 2022 10:18:16 +0800
Message-Id: <20221108021820.1854971-11-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9b93c47-bc36-4184-980f-08dac12f7099
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+C7+VXOsALmnIrEy+Asy8mytveIEMrMnLIOOls0fbuduI+AhRabL8KFEvzsBPmksPAO1K4bqDqmvjFDMtTpDsy6jWiGLqxOFlBv8xoV/JapqnB86d9/58/wo/T3EPqpRwyH1GZ5D5QMb0684m2mI+xDk7ReBh/IdZZIpCAm3xMtXi5pBi/GriWrS/L70ocGWSXISWPxtFKVCxpJYBeELAq+IHQ5vRf7jweOqOTHbd/V36mG3sZA8PG2mxEFT2nzE8epLA7OztZENy1QKxGhzUaBxFFeNxqc47u9Qb1ujfeC+UcKI/HG0JaZKuMMDIqTNWX6eoM5SXD1+WxB8sRt5LPBPUrz4KCb2QeP3Lcy0A7DSqzksyH/eDaR+8FgNVDsiC/ajzoxz1P/1zVmkUKtOcAb7gvhJsYHAvlMMkyO+2lYv8b5WNHFwibBGl/vN3dpHk0rLu9N1nU2LTcy03pKczTMjOhsf8l8fbFyKI0qrPg+mt4BEOah0ET2ad6FzvFMzWC/+5Qy5g1ihIRFCkbs2s50D1zfWLl1v/mVga6LhJ5x6DgNIwuRndtO3vNUUk+7vq+Y/oy+vtUrmGiLC+aIee+IT4suOmSHCdal8oQSquSL+QchvDD7dPCJ4WUUST4YdX1qAIq8fffKcDRiM2LZvrQliw/os58P+97W7XP8zYIOVyUNMWTPVerqFA/yODx1gi5fcKmIzmMx+P8XezGGAL/hq2Z8H+NhLyj6d62J8tekdLjYAX5gl+RbuUOu7z/JL+j4kL3X0IOnHTzVYhcyqbfvmgFWQQ68VbEf7lOe2IVEHHqdm65scAmNNy22ryJu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(38100700002)(478600001)(66556008)(4326008)(66946007)(8676002)(316002)(41300700001)(8936002)(1076003)(5660300002)(6486002)(2906002)(86362001)(6512007)(83380400001)(2616005)(52116002)(38350700002)(66476007)(6666004)(26005)(186003)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ney3yyDNqlUTzirzni+imx9kGaRqBn0vS/K6wOCQPN2RYY7VyZ8xagUrB5Mj?=
 =?us-ascii?Q?NkWw+nRUvn+WIOQ5cUbGwVKvKRdCmsMcFzqVaMEX5OifEcIB6jkfTlmafDez?=
 =?us-ascii?Q?qhejQ8PP/XrwZL8qU4XPlo49VBhzqKQknyBUkkvDREMolXTKGKsdQjn4uvOo?=
 =?us-ascii?Q?DDdpmPnF6QXmDl1TCKZ/DNI7ZN6mN5NuRO6BKrB6sprazoq/hrZF3+EtkjAE?=
 =?us-ascii?Q?8wJI+EOxDQ76w/6JfJbB+ed2TOaMpBedsf/jwfqNeSxq5Y+mDqNB6U4u7hSl?=
 =?us-ascii?Q?rLCO8HKIXiUqvwJPZ/8OuTx7EjrvakdEFCsI/c6WRH6WE+C27Aty66UQYS1R?=
 =?us-ascii?Q?MCHQKQBp2Kitnkl+82NIOW6n9Gob6OiLMyvG5QNdx0hzZGwMFsE12EXzY4Ln?=
 =?us-ascii?Q?jgSf7fPosDZDGNSoFbrD66aVBu/qbZfAnkUxtAWf59zvZV/vusx56pWYolJt?=
 =?us-ascii?Q?7RV3BJBdffZsvLYTd5RGiLSuTQJCxnT6NYX9+dbsl/9aZjIEQvH3jFqxS25+?=
 =?us-ascii?Q?TWrPdWwMHIpIgdQu4EiPRvoFYuixpOxAguOx1kgYMQJyeSVkkEk1c0cIDwms?=
 =?us-ascii?Q?AQRa+xm6lMW+APQM7khHIbjtD1piX0N06CUbyjeE5+vtf7YRnEW3FAs8aFrN?=
 =?us-ascii?Q?RspkK60CMrT8fYw+DdXeyKiJwKjbh5aKk/i32XG0qHUvpGhS4LkvBhNsZWnR?=
 =?us-ascii?Q?4yuc6I8wl2NMg1TTXfIaiUqh4XJY5RadUSL4JF1GlVKvSADYkKgcsRi7qMFf?=
 =?us-ascii?Q?JerO/d1agy1FRsMEw+gaOLWzJJlHe1vEiHiyD2yvDxj5o2A8ds7KQO1krFHf?=
 =?us-ascii?Q?rUMxg+EH8WvZJkXUUuHTg4kastGyrrKP5rT4caV5AcYdLQwMt4gjfap2BHuH?=
 =?us-ascii?Q?1vJimOb52q/ZQaQJt9ygp6I0hTj2ThSx9Jof8vF+//dZDFa9XTQWT67bfbrU?=
 =?us-ascii?Q?3WC0C+yHnQRPmBDmZJK3jXm+XnCWfpjTQaoXqW/zt2VqByqDzoS8Igs9zzTA?=
 =?us-ascii?Q?KnPzO/XM2lZ9pdRXBUBzmUwRrWj68s1jDMpX7ioQ4xz0oKpZ7nrUrXFB2+RZ?=
 =?us-ascii?Q?jkWQr5sWmvaBGLJ5b4mvGJEhxm2kzFxTRedfx0S0rAjedg2FFbP2IhITUvbN?=
 =?us-ascii?Q?NP4WldPFkQOVTj5gCS6xlS9MrTxWu3iXU583NC92RkyRUz0FeWHVR2c6huo0?=
 =?us-ascii?Q?/6/61W8SamJ6sPPLoL2/GKPiw7J0cyisWap3QjX0dHqRHrBFnfA41wZ1JSva?=
 =?us-ascii?Q?LSBAX1wo+hvVQKSTKu6aA54S3fD2pSRTolKN8r5l4N6sVFMR7Py11lqHSBvS?=
 =?us-ascii?Q?M3OY1C8h81jMUN4X+8BtSaS6XUszqljrC+R/TArBetCO9wUGbqAl08kxpp3O?=
 =?us-ascii?Q?7M1F1eCLG8dkn869X5MJvEIYVl5GPjZvKUpRl6U8Fg0q9R73Wvshj4GPdf54?=
 =?us-ascii?Q?KeeOX2vCZpuWpARGLBuSwKJlKe+ueX095JXv0ws/HR4rRLQDl0QEnxyeQkLT?=
 =?us-ascii?Q?H0nAW/xL++ofno41imxHqaec7KVt33KCaKCfs7rDP94AFdCll2iwkDcTb1K0?=
 =?us-ascii?Q?lVcg54gEVmhi7/t8LIANv/BxblJz0HQFBU7ZMcED?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b93c47-bc36-4184-980f-08dac12f7099
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:52.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoQ4BoMOcNmJ82B8NCd8rLIBx914ksLkDo1+qwwIyihUbEzPZPcMtspCBPcTs9KKrAMvJcylPWAgwt+G/UD7QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable uart1 for BT usage
Configure the clock to source from IMX8MN_SYS_PLL1_80M, because the uart
could only support max 1.5M buadrate if using OSC_24M as clock source.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 1971f095e4c2..12dc5d398a03 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -247,6 +247,15 @@ &spdif1 {
 	status = "okay";
 };
 
+&uart1 { /* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MN_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -440,6 +449,15 @@ MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
 		>;
 	};
 
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+			MX8MN_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
+			MX8MN_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.37.1

