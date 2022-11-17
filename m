Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5862D77B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiKQJxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiKQJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:13 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA60716C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:53:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGKz2z3BI+qC18RB5ASLxhgfVANN9Z0RKBOTPkiy4lXdDqnfLHbw0pN/PCuI7YYzAxUGTddKqDTuyeJxRoUziGt3JL83tIHxlKAFq5UixglFjnoeoqXWzX7Sm6qpklfeoQFof1m37F8jAoHCyiMuUl2jWuWDqR7cj3aSTnFrZEf8ev4K/B314wOr3qu+/1TJblhXlwOb3w1xpvfgEK7buumP45wersX2tlQ/ASkFOHw96/GsJ0IDl4juUkZT6DsaIuKA7oJk/UflLkyAxV3X+nkWWLgiA+36tf5h8xup3rzrgtNbPFJ6plPOq+JphteQXzTSLrKkbe2GAk0fz2QWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooICO2bcvN8ZxEm3I+1oCqyVOu3YHmUmgXvKVeCCiTk=;
 b=Mrrbd7F8rpk4CU07RlIPlzoUldhuMHnU4dFQbE6Oeqic64BcXjki2jwJIjgsPXLWQmnzYB+OEDVUKp54QeGZ7NdhMxWbpOqz6heGc0pKKvVHBrPveTWQNDw2SmVyVs7YsPba3jZSsv3a/hXXQ38DbH0vmZTbngxBEL2ad4vb9eYvqOvkcAnwQO8QvpnAZnFBDQUqy2DYHNZkEUFljBpQrCGAsh9BHK5abBMeJvmJZKftac9m1DuKZ2iI/pMUouLsDRxZ3kGF44yjpDqgG4mZw5IOXuatMH6W7ibmHe3O+x1kZ/xFiu+FDfS6zK1PtmMRygvNXq8tnRdy2iMvAeNC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooICO2bcvN8ZxEm3I+1oCqyVOu3YHmUmgXvKVeCCiTk=;
 b=KtzL9Dhl0J91HLNsv0wnL+3toIDASAKCOSmfdoBzT1T6R3GwvBDvABcaFexzkmg60UFwChwpSC9s3lHLiOwkLCx07efsTmo3vFnHrHZGuvTYOAhzlXzD4Jb1aJ6PZD0zYEm2W1C6NqgxcGOjPZUSS/MQI4D1AReCx/6wu6kLkkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8469.eurprd04.prod.outlook.com (2603:10a6:20b:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:52:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:52:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 06/12] arm64: dts: imx8mp-evk: enable I2C2 node
Date:   Thu, 17 Nov 2022 17:53:57 +0800
Message-Id: <20221117095403.1876071-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 470fe2b1-787a-4e1a-866b-08dac8818172
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuSJ6ph2gbWTNxk9rp6fsnCmAjoUd+cIDEyI2rd3Y4LT1yioITGnd+pOfkGEmtV4OyeQOURxIpNjotm9uzJc4mwPALriqwDO0FZyhKbkkxQXmdvxub7m9meoOTH00s/gVnKGaO/MUjuMDxM+6A0dYEiJSOpQAuvMf3GFmOJEcBHGLh7pfcMidS4blLNY0buokE6/MnOIf9P7JZqPHJG/vnsKmwhs/dR+0+R7lxs/RAJwqoDWTYvePLPh2eX/O2k4jYOyK+uhpLvxLNPPDG7upc0fEsu0N7Yj0N1LSEcrPo5qTbC3YCta7hqCIwqvy0a51WKfX9M9gVxtt6+kCAZGKaFVybdUSzSR/+CcAOPvsf/vIjX0KcCICzfSnyMoqbJ4wKVWvVB9vEBp/auUE+N25AFDhq4t1y3b7JAz+sFQqnS6aeCNVZfPdP29Te8nw4pnRziFIWY7i8sxvcVs/58Mndn7GJ+UsNJKEVXL76HqwAYxBlgKhJPkIWQ25BaJQALYGNAC0cJHUI1tTGFTBKORLFOQcjgCo7oc99IGLt2IJL40qpqXIeqpkZ7LCVmStkYhE5MBYYFZ/oALXuGdk1Eas0gs0yVhGlDj/6ZKrwPWdT2RsuTmsVHqPSr15XkuWWzWBE+FYYiA1vuoApF5im8sHv+M7QdTRqqTqNVAXvVrJSlb3NHldA/z7YJs9U853CPDaRgReMpdAXKNUvEPGRyZP3JoHXlwXwBTCxlD4WjNsW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(66556008)(4326008)(66946007)(8676002)(316002)(66476007)(8936002)(86362001)(41300700001)(5660300002)(478600001)(2616005)(186003)(1076003)(6512007)(52116002)(26005)(6506007)(54906003)(38100700002)(38350700002)(6486002)(83380400001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Bo87dsJ7P3EcTMWV1ol55jrmh/yLfKeE2oFZlueLngU3JnHXVHny2iFSR1S?=
 =?us-ascii?Q?cDDXEyr/eVOatCve4H2fVGdsdnIANFaPDDXYtqolxodF5XOTzZLN8OMA4rUM?=
 =?us-ascii?Q?6VCtpsekR9K/M8gyGeyL2uJEuRmjdqmt0SEq2reGBkmuNhpNm8J9UBTQz78Y?=
 =?us-ascii?Q?GMGKJnkkKrBadX4R7KPWaShyeHLApEXv7M1fwvo7aHSUA9FeH1WM7vGaVpqo?=
 =?us-ascii?Q?T7OB8z21I9qr2rUUcFYRQX5EdxGf5UlTFbgt9ZOifqeKrrWQBbzUsSbBXVsj?=
 =?us-ascii?Q?5JQ0pRtf31Pyn+vL+UfeXD+d/C1DoE+EZEcmrSM0jtMZo45zB+jjBmVnLG9s?=
 =?us-ascii?Q?IRPb+2+bjLBWxKpOwhfSLlsu2dM0+OyojMYcZydEejwV98slSeJhFYDFRt4e?=
 =?us-ascii?Q?mIFB59VDBckmarqxzKb1ZhPRK0xXXNCUaXTlIxQPKWkh5xxu16A31+tkto4F?=
 =?us-ascii?Q?93JtFEZUi6SupKljXEBqo2IlJzkq8ZZXGvQnR/QWpQTiK+N7JX0v7tW+9k4S?=
 =?us-ascii?Q?/8w7lZHjW00zuRZBc+ueNx0elAHXQhaJk29tRaDlmMfXlm/Pf6XhPiyEqJKu?=
 =?us-ascii?Q?2abghV5t3EgTT+nH7pH7lQEZlw1KWf2lW5a0UZan0jj3uf9q9OaegR8/Ze9t?=
 =?us-ascii?Q?E99zYFus0JMbgodFdxmN2UI2oh6h5GD5zEkMTe/f6gCjGmppWKD0OcqB6PCW?=
 =?us-ascii?Q?eZtkJGlWW6GjD2mI6Etzt3TBxtF5qWRPT0DTuJvNYkJYY4belDoqz3xVnblP?=
 =?us-ascii?Q?HZMwjXGjVK+0saOya8nvvpve6dwX0XdjfwdplCjGcSDRuSGJVcdqGz30k3Dn?=
 =?us-ascii?Q?PB8JmIWrhLDeJvBdBLGw2ve/A2ur1tAFRs9fCHu4+WeUsJ22DTBuOaW7jPQi?=
 =?us-ascii?Q?XfOA2iY3c7VvBcDIBVlkmm9lfc7eaw3C+StWZurk/XD5QTsX8E0yoWfnc9Xc?=
 =?us-ascii?Q?rBVL8OAUFXngwjBOKZhH9n77BX/o4xGz7ZCjeuNGhghg6Y/x1qExI5wubPZm?=
 =?us-ascii?Q?p39JcP0VVvNPn5D4daIQvbqfLxDac05OKT91ZwBAoQnsfbYd5/hu4o11b4Q+?=
 =?us-ascii?Q?ybp54GliS1CXIOQ0M3vdBMpMK84PgYpPag4ZxpI2mWRJnok3KKeJk+Lb6e0a?=
 =?us-ascii?Q?LEdy6+BIUb1nU3F8gA4L8y/FpxdYYMeKQMPaKHf+XRD/s/eeTVqPa3IXjPXQ?=
 =?us-ascii?Q?Wi15sank0NdEjCl6xHFXlB8E4Ng2hgLSqGfm5BPIfaHunH+aZs4Ax6qIVrs/?=
 =?us-ascii?Q?dXyqokSVGvHTGPMvkBBElA5as17QKtqcf+8eOd/VskX3cvgBq48rQCUnWpfp?=
 =?us-ascii?Q?J4UBHEV2QEca1ULM/mvwwNIqoSZSWgC0bwzrwQetC47X3waPM+KLIlMkWeWM?=
 =?us-ascii?Q?DluTnsbMDKCVMVDWqFNLYyK7+CQaavda+y9K66wD9QhzGWIEDlDd86qhq4YL?=
 =?us-ascii?Q?w/DVR2M8+zGF2K3auwKKcZZNuOYpo8N2aWjBa9wbaLl+ihqavpnLm76HE4ia?=
 =?us-ascii?Q?2e8oGorzQP4vr9OTUI+Vz33ddL64fB0qTfUZ8W0Xp10qb9nCiquucmp1KhIQ?=
 =?us-ascii?Q?b80BfmdnLdl1Exkb9jzKpqR8T2o1Y3q1CM0pzv3H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470fe2b1-787a-4e1a-866b-08dac8818172
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:52:57.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru9T9nZkf8sJcuP/INg7Yf5Maptin1IXYHFNIkuDV3FDhscmCsPCEyWMFRQ+oip/J1NadlvfiEP8iQ0/JELC0g==
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

Enable I2C node for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 4164f69a89a6..878d4a752090 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -331,6 +331,13 @@ LDO5 {
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
@@ -589,6 +596,13 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
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

