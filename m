Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09149625EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiKKPsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiKKPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:48:24 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A321CFDB;
        Fri, 11 Nov 2022 07:48:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNeYPeLDtqe4BX1zD9pk/7Js6ms6jkBOp7WfJ8Dus2Jqe16uwjdnZnZTDEsa5ZDfYc21HDFZ+lGFPzDASiEe8lIYeVILhKRdaCUfD1L08FfVQGILQfsL9Ksj7bNt99JUeywrMGYENu0LQcNAyf79adNT/0aXZi/qMnqkYYt26kX2p/FEeM5K1Jgdel4PDMzw8aG+rtDGL4wz0RZ2fN0KzymzM5nHl7/qLdy39Z/DaiGzpqqqbHR5b5lEvmeQh6lANi2pkR3TfWj2W5gYAt0PgRt954CE4v7EhlqCffzTeL7SVWwJqwQkzfOUlvBERvAHkenOGNhKjGba4yKhNRLrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvJOg0N11ku+bUGhN1o45zaJPEGkMfK6hm3W3PEVE0s=;
 b=T7zUDnHXQxzjcetvOZn20TW/dopq2cY3NecWxVipp66LHTdz3lI2FI+JMtSZdbRxgA9W+TY4mFuT5LxQryYgGgrnTFDSo22bTwSRUT1I3EjhIpR4xqUbt3jYDyJUXIB8hyj55C4h+C/uMrSLSZScOCkx5FB1VISLdp/rLxuvhnDkT3sogOOkPUonTsIvyTma7xbiusRhduaRcAfXFik1F29xrlkfCc6JHeyXkh44D11pyKDzwlz6FFX+707xxKKf5RRA6JXhZ1DNs5ZtKrN0yvPgp75dDVPiKhQbtJSA/wrIklWoiMtJKP0KjBREgisoF6YazYQpTgfvd+iG9Z9KnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvJOg0N11ku+bUGhN1o45zaJPEGkMfK6hm3W3PEVE0s=;
 b=nsPevsR/ot7W2pTsiU6vflNye14n0ucUlwweytP/sY1IQ9TDFB7boO3t6q2J+JI+0751arpYP+1VNSiTQrHexmqBAH6GcsqCO2IVzdNoz+8+YGOTL5OrpyhTt0JbEdjC7dBDGvWBDkLFLuv/ELXU7PZz2tcdZsyEQkDFLZnYc44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 15:48:20 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5813.013; Fri, 11 Nov
 2022 15:48:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shenwei.wang@nxp.com
Subject: [PATCH v2 3/6] arm64: dts: imx8dxl: add flexspi0 support
Date:   Fri, 11 Nov 2022 10:47:39 -0500
Message-Id: <20221111154742.2753318-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111154742.2753318-1-Frank.Li@nxp.com>
References: <20221111154742.2753318-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b756558-edbb-4393-eb88-08dac3fc27de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLZqBBSQEVX84tLLQphkkALaEQefyGRiF/J17osIHOHSQ7jBnJjiPqVOgIBmoQPoGpRYI05AQWCrIEaGEEs5Qrtjq+Ql+oLRNnh2AiHMq0ER1RZP8tSZYaT958a8XqXg92j3eGI8wmvroTaVX2jAxIfzjquGo1i/N2ImHRTluyGFw1QHm6TdfTclwq3lkhhe0vMLX1Ti31HGqvjbXC3eBZiwD44nRTfyVVInttXJt3KyFLHSp03YHlIzjIQp8bz7PboKSmtijQ4sr/3hLwnhbrqXgRYRQ9pMxtHyOZmZy029zovx9PF4A4YQ2Yom12t35lWpDVSP2pM8J/JEDBOId8+YcuP5QMcEE9aGPIlu8copb2OvewCKbsPwNLb3yCGQl3BTFnDoNKc14GHU1eNt6qvxH1mfMXXle0qe7HHa91vjuo/0uwLIBlstUmm3Dq8uHfXw+tq1uyYJsYGMsE3H7b/o7IdqRQeIqYn6Ek8yemv9hBC/gIqoXpsG1I1DZWOo6YvV4wNmIlZsfnPn8025MNNMxIIox1hlvlbnrZqmZKF+TkjNpq42YvbDGbxXTYXpTB45MLNlB4ZoxSAHUh0VsDlQv6q/Ihz4P5K+V5ne4pITeUKgHeTP6gLYfp3efsm42B+gddQCF7DwbO/IAYJfdK0u+WeJ5UcJ8S4j9GgCT+j+mKmJ4uAFbsWBaeZiVg3bVDqxyFkJcQpvsTp1T47nJa/ng4F/fESlPSfMcVb9+DrGLnoGXhaeD/JQIIvmYY/klw8CYUtJZQDkQSOgMlWaGoR2kY2tvgfH2GlJnR2WNSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(8936002)(86362001)(7416002)(5660300002)(36756003)(316002)(66556008)(66476007)(41300700001)(38350700002)(66946007)(38100700002)(4326008)(8676002)(83380400001)(1076003)(186003)(6916009)(6486002)(478600001)(26005)(2616005)(6506007)(6666004)(6512007)(52116002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kcbw+eYVt+yUkR/lf8wo6fQyS8WQ7t/Ff9XiqQwurN2ZTg1PQMtPObveed94?=
 =?us-ascii?Q?0kiUOq6ndhfL6LLsF6XHphXmwIif4rHW4LnevOHbLj6CPJzOIGhwTfsNBra2?=
 =?us-ascii?Q?KhoT6eO/NzydP4XaNV6DYLlZ13+1LYi8btCRrnaHDEdKP8UuCg1w8z+QMvxE?=
 =?us-ascii?Q?rb2QqKnE4O9Vrd3WAHd2rrc3vBq1BnpLM+2ncdPcnIGjejevYmYiffFNvhAm?=
 =?us-ascii?Q?rg//f2ahcjla8tHPT/NpWVP4HJprgi8r/oVy6xreLSI9mUJIZueVT2/lsy4W?=
 =?us-ascii?Q?AEhvO9AzhCGk2AIudLQv1/BYVDBOpWtKNDKQpQngXV+Emcg+7uAo6rD+72SI?=
 =?us-ascii?Q?aumhDuwp1zAiy7KvdjddowB8NorV8mGSGhNU01yTKiWcNVVDPK+lqUnY1NGx?=
 =?us-ascii?Q?hTxqpf4dSdH+eHSf3a00pMRU+OOQTRrwwz/1J+zRxCZMN+Us7YNYjekC0hPz?=
 =?us-ascii?Q?ponorf1ozp78NKr9ojA9UK9TOMKNTBQjcNKOUJAn3StacIBtLsoqx3E0kU6m?=
 =?us-ascii?Q?lcSVnZoME27+Z5G5qBNgpRY0AqOmevHCxGPLFSzX/C7pvGUPtmKo7gl2sC6v?=
 =?us-ascii?Q?iKSznvCGfX7v+KIkrIb7wLJgT6cRZgSFZ6QXq9ZQJjAeWGEaWRvkDqXwnN8L?=
 =?us-ascii?Q?wkJrYRrWQCEgxgHQCSzZxV+iZ06/049eR7xUqSz+aQvsX65ThBRFSi4EAliO?=
 =?us-ascii?Q?935oiw2L7AhbIhlagKpbu0gPkGBDccgBMNDMzB2ycAwS3d6m0h4W83T54i1N?=
 =?us-ascii?Q?NalPd+2lc+4H7K9SclAWsPYuM7eBzF5LHcPeM1JSmlBFMQPOmRFMgkYkugzk?=
 =?us-ascii?Q?qzA3ntyMhwJRru1PYL6PRnYCUVl6NnINcTFy0AUytSs/D7b5BAPL6VG037Dp?=
 =?us-ascii?Q?/+zhXeJB2tVlQbBem0CWDUkgLyFaZEB0PTBUt6tSg0pei+hr8otEP7DtQr4D?=
 =?us-ascii?Q?F9ovP7PwdoHVEBhwutbY8bBk36VW02SawOhQsHWM+IupDneTgyGt2C3Tm7EK?=
 =?us-ascii?Q?oeYzgDIcAJQiTjo5eL56j5H6C+n6SySedbkDirr+k6WKKln0gmnwOOcJxeSm?=
 =?us-ascii?Q?FV3kgIgAgqyIA2xyc+VGDSY3ZfumX4DlL6PIEwy0v7BVYd4YfAesDxpwBr2d?=
 =?us-ascii?Q?8HRS+VRkotQP3xF4rFrYQbXu9fGREZqnUZtmXS5Sq+hAVhaaDvLwehlAehnR?=
 =?us-ascii?Q?Q+2qMiyg4xT8E4EgZIFsfoWaGmGVWf3YSdQNN9GbfTuKzKrG0YWkT2ESXAWb?=
 =?us-ascii?Q?6zGFZcyMko9GOqXs71fJtidqLTvtsmsxXGckrJoayAGeqccTBoaGXmV5ZENo?=
 =?us-ascii?Q?qx3fpp9PzvI5Tenj/KVCeql2JTlijGBtltUtma/RqAjHbEU1qLzIYBOWZ5z0?=
 =?us-ascii?Q?rb8sPlKWMQxBFRGOXCWi2JESqPcdjiH/PGj1VEtPlzqrjqoamZO4TD887pAv?=
 =?us-ascii?Q?kXWA/OFNVlIkfpO0bN1UvxHYD7u19imgcBcWPi3oSkggGznpinL7L+DjvsSF?=
 =?us-ascii?Q?QBTBw9adq45C7fzrL9rR/okJoKvzqJHAZ4VIhDaI/41jruiPA9Uvpz+832Vn?=
 =?us-ascii?Q?tAy7qW1a47iqyKaygNk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b756558-edbb-4393-eb88-08dac3fc27de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 15:48:19.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUBV68jxxRQJS1KEKwaR18/BdEttwmCHn8C8fVFZuNInQXOewbYk7gk1NgRYmp3RNkqsyIQStClOKV+fmzPFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flexspi0 node at common lsio subsystem.
Change flexspi0 irq number for imx8dxl.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi | 17 ++++++++++++++++-
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi     |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 6446e6df7a9a..1f3d225e64ec 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -11,7 +11,8 @@ lsio_subsys: bus@5d000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
+	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>,
+		 <0x08000000 0x0 0x08000000 0x10000000>;
 
 	lsio_mem_clk: clock-lsio-mem {
 		compatible = "fixed-clock";
@@ -107,6 +108,20 @@ lsio_gpio7: gpio@5d0f0000 {
 		power-domains = <&pd IMX_SC_R_GPIO_7>;
 	};
 
+	flexspi0: spi@5d120000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,imx8qxp-fspi";
+		reg = <0x5d120000 0x10000>, <0x08000000 0x10000000>;
+		reg-names = "fspi_base", "fspi_mmap";
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX_SC_R_FSPI_0 IMX_SC_PM_CLK_PER>,
+			 <&clk IMX_SC_R_FSPI_0 IMX_SC_PM_CLK_PER>;
+		clock-names = "fspi", "fspi_en";
+		power-domains = <&pd IMX_SC_R_FSPI_0>;
+		status = "disabled";
+	};
+
 	lsio_mu0: mailbox@5d1b0000 {
 		reg = <0x5d1b0000 0x10000>;
 		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
index 815bd987b09b..85e6131ec406 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
@@ -3,6 +3,11 @@
  * Copyright 2019~2020, 2022 NXP
  */
 
+&flexspi0 {
+	compatible = "nxp,imx8dxl-fspi";
+	interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &lsio_gpio0 {
 	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
 	interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

