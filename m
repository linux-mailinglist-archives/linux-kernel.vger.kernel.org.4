Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1773573D0DD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjFYMVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjFYMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:21:12 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED45E4C;
        Sun, 25 Jun 2023 05:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4JyxT4MLgL6umRrmFLFCPBSTrDI+jBjEzd99rVn9hS4p/4luHyg8QmArStKEKx0iYTffsUn96FarLhm76nPcC9v6igrEqyjnRRKRmzxzHFZQuNM03C7VSKZSADaoMUJzMn1Aao6QucvQczJ9Xz3MLodNOBEcQG3kPXQLJjOkkEn2s4RMI7T1tDHCa/PyyuqInK9jkEZs1NG/2JjO/oIJfnwPYDQltMtDRZBFIxh0GiEFXydRRomDM9SZvTJ05pkp10IEFjwD+QZzeYzZvp27+osa7dley6OxdjWBEQSTXd6IwcX0mzGn4s93fc/Topkq9Q3HkKE7z05qjxuqJVMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvEgrjjQT355va/UXHxKncJ/L00GeIvJPK7HozdLdeM=;
 b=kw14yeHYp6LmK19/3evjIkeksFydvUmwEWIG5jzCG5iQ1Dzi5nBTi6BpDUQm+VhPAS+KZNIw52EiT9FwajMWnBcxxkWK5vO5EhmFxxt6+MW8F8u6tsDh0K+rzVLp8mjlGG5Hzjs4iiJhpBdbmdNCCGbrU3hnZx/i0URkA0IGMQlnn6JPh4XPaZyrt53nRPn0IM26queHLAjNPq8BJj/932j86PufyMQEDSdJ/TOMojnbGIVhVWsf1yFQvngIZ9eVLgEbodiCWIlvF9ETVd0KP63csr+KMSSuVcoilUZA48FrtKflvWv3Es8umFWj0iDYMWHy6cOR2qC92/mS/vVRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvEgrjjQT355va/UXHxKncJ/L00GeIvJPK7HozdLdeM=;
 b=UCuRg74mosAMjqlsWhQMnAoCRkI65gXmpS8J/uhrktmNPweA2bFeWMbwrLQnQ4eqyv01gbLaHS36YPm6JbxfE3FobURb+TphB7Q5j8/8xik9QmzukJ+3uE9Zn8PiawFLK/EcBlJpgheCV/yxYI31PTiXRxQwKI9VaEtUQarENF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 12:21:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:21:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] arm64: dts: imx93: add thermal support
Date:   Sun, 25 Jun 2023 20:25:46 +0800
Message-Id: <20230625122549.4066027-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
References: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a0b01d-251f-4ee1-4224-08db7576a3d1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+Y05zC50T2A8BcF0kR5AzrBRJsznrGDXo+lsePBYP0NSec4G3Qmucu9OHArBSNSuQBWNTiCxRJaUeoS10kDf4eR3vqRo9oMIGOsWlZZT5036euqGu7/684qVlizGF9WQ3FSToxhNYqndloSgLZONEAlWBTEP+XMRDEr3w/Qd11OfdesKwxHw6oJcMhp83KdZGh43RvKl2Ue70ztR8ckixDWDAOborqE492+4UINMIxumLzPnDs64dpHmpsej/ZOm6OMmLECelfRrxVzLNk6+pLJN2ZKkl3LAn5ur8NI+jZv8XjWwqJMTAuma9PCzIRB0pg22DtvcFDGKszkhZQyFnA+P8uIXtsMBI3c6Sgw+TkfhG9NXZaT7m2cJAV//zqAVfQtsTK02ZjRChwZ1Xnvf3p+G2K7w594koUH8yF+m9knKUsVFjDwABg8RSKHDlINHmtyDl+Lz9oG9+OkUWyN7WCeOUi4GrdzXKUlmJcl8Ztw/r0r5xk8HdTuA0wgoIGdUWJHxA1E1S88fWF4oO4qiwgPab2vE233eXyjAx0OlcfA2zy1s2NrEXsi94W/RWiy2fqEGexs9TvpRsvlNJR0iT2YImv4ZNe5K9BSPM1iyin34NJTbtabgCs3BqSJZ1Kq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39850400004)(136003)(451199021)(38100700002)(38350700002)(83380400001)(86362001)(478600001)(2616005)(6486002)(52116002)(6666004)(66946007)(316002)(41300700001)(8936002)(8676002)(66476007)(66556008)(4326008)(1076003)(6506007)(26005)(186003)(6512007)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jxtGf0rxtN7EC5VeYUtZMIMfjfAQKDUSSEjQ/vMSIvS66mWfo6bPmOBCJjwF?=
 =?us-ascii?Q?rbNKzNmzXA2g5KmLxw7vaa7GcTDdtqzZDF+PMPnRJeFoXAkvivtLrot1JuiJ?=
 =?us-ascii?Q?4ShvTV/SxekOsmitAq3mug9qCqyRahx7DwF5pBs97zMplV2/EQqt1DzE1CtF?=
 =?us-ascii?Q?UqyEALvN+0qxmL4osycHjR/0acFbfAyx3bEH2AVIAazFs2CEHBCcZNNZgQCo?=
 =?us-ascii?Q?2XtLZ4fQfRmNPcAo6UuN08U2wN61GgWVwPui7aOmrZUxNqzOZzwhAvYcmX3D?=
 =?us-ascii?Q?jRL4LFAu2vx02Eu0VwBg/0JEWpzpUHm+aL2eSnZTNpaw4kufUKrUOwgffb2M?=
 =?us-ascii?Q?t5pBf90OnqN/NQoFy0HoIthq5/QIN6NKX9Ah6cg+2PnrpLxqGdPg+2/lUg5x?=
 =?us-ascii?Q?fFHrLPzLmCJBDQ5HePfLoH1kpJONql3/SZj/i1rlwC1g/MQm82DlFCnN39GX?=
 =?us-ascii?Q?yJC2xzjhgwttzGYPaD0hK6YgKlfWFL/j+NnQsdYrGxdsdZ9kY1yJLX4nK/+u?=
 =?us-ascii?Q?BSxIG/AnGGdpzdkhh9tZJiElgpODFVrSlKZ8INo9SSuzWhkqdpkCINxbAYEV?=
 =?us-ascii?Q?kaExYvwZxs4S8PgSm3KDYS+VZ2N+rlCBQrm8FKOGRE8gzA4EEDRn+f8etS7e?=
 =?us-ascii?Q?hEauahhBHFgrTKcwZMCJg4hk4a2RsjHBkifrYJbfPSxzgPNzWkAOYYauKLnH?=
 =?us-ascii?Q?AzONjvKXMu81jMbFyZDasCQQHJD5sjnTLk1yH2mA5jglUg8rGYTEwBVBk+lB?=
 =?us-ascii?Q?3wgLTuXgCYHmqQexSFAfYOJy2V6b1LFEBr4X2S7ww4NIYov613IKzyR90TWW?=
 =?us-ascii?Q?hqliUEedo7ZZ4wocw1bauAyzMnxRE/Catu3lT+kD7kMinemo6YHNnI2tKujo?=
 =?us-ascii?Q?wwJ7etHqGLk3oTYQl6L5O0Yi5+/9CbbkiOHNjeU4Qt18kzEtrVpFVlM4E4hi?=
 =?us-ascii?Q?Etn2c/rlQb/I6qE9NFfTSgIAX/u/q+gXZ8z+ncXBDp6xRzflelmO42/Otmp6?=
 =?us-ascii?Q?TVzWpKRgj6M5pgLj/xh0pDYDDpupAm20mprZvWAuK8xFSSAA5cAXCizyDv0H?=
 =?us-ascii?Q?R5sutPxnP5POmb7lLfWPjDNLaL3MEjv6EIT5VTZThUQNIYtH8Ini4qeSDa+x?=
 =?us-ascii?Q?aHjaVq1Qyxt+7l+FRXG63txBIPvaqoGHrzkJOFXZ1DsUyM2/78TkKoyLhYCA?=
 =?us-ascii?Q?PSo/sNSDuQ/2l27zvTf8dklg2dm2cv5KB/U7+Xsaaj9xoLjOgFnJSGf9HUzI?=
 =?us-ascii?Q?Cr3EKJuauVYQhVr2vfPpz8cdNyY/vE9Q0mB3uf7QgIxhQIcBL1cOIhSNSlEp?=
 =?us-ascii?Q?4nIMtIE3FOBtXu882dZeYKGCTI24A3Sg1H5aqD/8/7hiNyUz99OJlJ0VCPLK?=
 =?us-ascii?Q?J3uUNkRwiSRElLvXQ5YRylhR1m9XKIfHtxX9IiOVGIaYi9O6GP3H3HiLcAdP?=
 =?us-ascii?Q?KqyhvbUX9V/lB/JPTocV2ZpHKd1P722XgLSl1KTfM5GUrOnNYn1GjBmxVpk5?=
 =?us-ascii?Q?OVQYNA0OsgndoJb8A/LPIz9P8GlGWB6yicwLzTD66QUIdLmQLDu2P8DA8+oE?=
 =?us-ascii?Q?U+uOs+CEsgutv4hcryreV39IZvux5sinGDI5K+Rv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a0b01d-251f-4ee1-4224-08db7576a3d1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:21:02.0742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKi3AQ9HSJdLZEGX6jg8OfqmETXEjj02Np95thkXa7VSQtw7Lb8WevEigX32JpEHsZt+uLSNQ+5BEu8YZwiY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add tmu node and thermal-zones

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 53 ++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8643612ace8c..9aad073b491e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/fsl,imx93-power.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "imx93-pinfunc.h"
 
@@ -132,6 +133,38 @@ gic: interrupt-controller@48000000 {
 		interrupt-parent = <&gic>;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+
+			thermal-sensors = <&tmu 0>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu-crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -343,6 +376,26 @@ anatop: anatop@44480000 {
 				reg = <0x44480000 0x10000>;
 			};
 
+			tmu: tmu@44482000 {
+				compatible = "fsl,qoriq-tmu";
+				reg = <0x44482000 0x1000>;
+				clocks = <&clk IMX93_CLK_TMC_GATE>;
+				little-endian;
+				fsl,tmu-range = <0x800000da 0x800000e9
+						 0x80000102 0x8000012a
+						 0x80000166 0x800001a7
+						 0x800001b6>;
+				fsl,tmu-calibration = <0x00000000 0x0000000e
+						       0x00000001 0x00000029
+						       0x00000002 0x00000056
+						       0x00000003 0x000000a2
+						       0x00000004 0x00000116
+						       0x00000005 0x00000195
+						       0x00000006 0x000001b2>;
+				#thermal-sensor-cells = <1>;
+			};
+
+
 			adc1: adc@44530000 {
 				compatible = "nxp,imx93-adc";
 				reg = <0x44530000 0x10000>;
-- 
2.37.1

