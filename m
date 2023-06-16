Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CF73317A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFPMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbjFPMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:43:17 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8EF3592;
        Fri, 16 Jun 2023 05:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU8wpk56nVb57VOwnN4U9BHiS/w2UJdy7MuZ881wfjDaVjc2RCWeFhekNWcngVH7TTTlrW9GQkJ0YT+fqlziZQ9jn++FiWnYtNjlWwfT8h/Mxr0oWa6keGoBwUB9oJllzypJs8K96H8pzWiQsJtNeHb+W9GrASFTRd+HBkYgB2l66FQtAX8LO+nJ9BnG7xPoca2Gj/WtURMLfZwjnEhc6iQQlO/8nmTSNw2amiveOKCzsbZUgkN2a/HeAkwJxFJJne22mAO4I0dBaNOnuqzCgIRiZCOHt8IXQ4ppLtCfIg69glsjbRdWgtL/9IoQ8SD13sMAWaaDOCinmeOTpxgaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFyzIxZnvOaPzlmylq1VEd/n8LVahEENfFCZeDmv1cM=;
 b=MdxFHS/fPFhlXA2ewB2foujE88n8C1Mrh0gvDH9wBtpww+kALlAi2u7XjDLC1Lskzhr8956zSt9RWFQmP4Q8V1qDebAHIEV/cEb0AJjh9u3Ex3sD14wmE0LpP1mmFcdm4jbrwvXJi+rwYP2FbFKM8IO8tk6eu2QlFuZehmy06RlzJ54Ds9zfauOjMofViGNZjUnhRw/qWUamRbxHVYojTOaA6t8OgwMCxDCIR10bf3FEv1wEACjqFEfmYO177E/YPzuR+jmceLEsHN9yDRcQMObLsmXCIoGdNBUD24SF7Cdz/4o0XJfHjiJDxrZsScH/66rUIKpH+Zwb0WzHOvBwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFyzIxZnvOaPzlmylq1VEd/n8LVahEENfFCZeDmv1cM=;
 b=UEem+tGx7FQYk/kcx7qpVL9kNM8GexGetCBY3geWBzD/ox74s9BoZheEQaGCcSNtaQcaNo9WZ8qronfp9fEM+ALTjhy99ZeNSQsfmDTDx8+/2QK5qbRkkyPm0VVj8QDzvN+LpxiyGRuy00ACJ/N2A/wC4Nt3KoYID/WFVYswm+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:43:12 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:43:12 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH v3 5/7] arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele-mu dma-range
Date:   Fri, 16 Jun 2023 23:41:42 +0530
Message-Id: <20230616181144.646500-6-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616181144.646500-1-pankaj.gupta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: ee48780f-a573-4fa1-ec64-08db6e673f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLXiGYD6NIhVz690ePOUEhG7G+9KSPnDujrVh9xo67bScRhKzwugPwiYmbdCfes0YPOxn4HnR63J51z0I+AaocggAtMTem7MWHHSV+cZN89SIenPYuG910K/myozbheiVam7gTEsNboro8ozK5OksDXvjkLyePQc04gFAYSMrnrAuGfvTgnCm38pnGh8pbwW74vNRsjxc/Wn25q4eJIIqBE5HRYu8bUAQF2UdCT8/8i33SAYH7+U283sgPZ7e26qcwKkYQO/KIdQt+ilv9F5CRKrsyWCxGOOm7WRoW9ZPMLfiU4MBLkVfkNNXY462fQK6afCxDhDMJe4sVJpuwGfS3FpKYNU8Sebh4VbVHs3CccStnxgMMorwzLxfpPw/ozUnlcjXqwNPCMZj6z7N6ZCe1K/dGJTUCnjmqzKvwXZTEiDAouGOPoeOqIQaLd1nbGPTy2EUqHmsXXEsttm36IWHNUPW4KcAu/+jzk8uUmpCN0sHY+2Q1seERdsLnBDPn38X6k75ecsnEOh8KaA2ojlQOsX6Zvqo4lYKfXA9cC1F3MDi2ZkqlEs1Ak/dcU8IYptGqGAsrk8A73dqVY6D6OjjUwqMlVUZtoInXJUIXGB2wOqvZnb4PncQ8Xvkd5yMBpi1ZnQNc94XBnwQsHDsZ/5r/PTPv+/VoOGJNtK9/Vgx+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(5660300002)(478600001)(54906003)(8936002)(41300700001)(8676002)(316002)(6486002)(52116002)(1076003)(6506007)(7416002)(44832011)(186003)(6666004)(4326008)(66476007)(66556008)(66946007)(26005)(6512007)(2616005)(2906002)(83380400001)(921005)(38100700002)(38350700002)(86362001)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sK72NMIOQutw7fx5GF6mjHUa2X7W5jNzMnyPzJHA0e2U2GQpvPqLeVWf1eF/?=
 =?us-ascii?Q?wL/ns/1fLgVxzOqRuqNqwYXwN7fQUdd8uc2gKMoWruYk2a+GJdMo/xhyE8z4?=
 =?us-ascii?Q?fA2rX6+VJzWX3Z0TI3Kuy/R0yoQCz5QLIHhnNV9vZ6aLi5I6bXim8dg/LZ4r?=
 =?us-ascii?Q?3O11mO0KQjiKmT+OVTlEX7JjFmiFlHCa2ZvkA2PSkUtsbYKNrRdcuk32JvxJ?=
 =?us-ascii?Q?yOAELrTpd1VpugWtUvpGXZHhKgTlL3ob6kj6B+KpGIp7vNt68zmfsBy5jv/l?=
 =?us-ascii?Q?leMVGPXOKbLxjVIxnhwmM4lCCDVh2BRXKyLWMx9oN4sutKMCkRNY+e+pRDKK?=
 =?us-ascii?Q?wZFydeCo/BpM7GZs0KTYeXAdzLyobA+g1Isq6iVoBUyWiIrN1ZrkVmoc59lM?=
 =?us-ascii?Q?bgz7KhGt+G/jvd+3EszzU8NesdHihSm9QdhZojgoDkq5l62JHjYUTzkIebqS?=
 =?us-ascii?Q?770q+zXKM36MgUe+9JBu2Ao9QPVtaS/qaTDVk5rvVJjtJIMXBOv2gw5K/tQS?=
 =?us-ascii?Q?j3vUIBqIeSO4jmJD07kAScvAvgKzBzqq5YUm0wykgod6s/z1pmXfuTjpVYrk?=
 =?us-ascii?Q?3GCXc1An69xgcE0Dd0PRr8rfb+/GI+Bcbz84cE1WMfKngIB2u+ZfBlFcmify?=
 =?us-ascii?Q?Zsr3beP/RvQ30ZQEyjwGykllVXSKn6yA/6GMt+3Yfo0Ajm8SqtfEvhBDsd7e?=
 =?us-ascii?Q?Qjj1rj7wMyM2tEFffhpPchvs4tOpuw5Ij8oBBJzdi9UMl9xNewvjJmDEt1uq?=
 =?us-ascii?Q?DLFj1n6UFX4J96WWenDrAJcuWdvyd1H1epcasLSrXsbWBVZUqwo1AldrkVQc?=
 =?us-ascii?Q?PiNIDrktYpnn1Nk1/SLuOEpGvy1GTWpw4mIrM4OQd+MOe7Ysh5mibtTtIOVJ?=
 =?us-ascii?Q?6CuB2cA7HhGZjumA1O+6MzxFALYCoGhikN4DxXYalfxaftsB6eX91gPoaeuC?=
 =?us-ascii?Q?7eq6SXlvvxDJ5Gw/1WuUj+ImfcsZKn7qJUAiiBUwkdXhrMGUSs9RxzWDUd3/?=
 =?us-ascii?Q?9CpTAh0j2orEIZK/dkVry9+wVdfLL5H4IOQMWrKuOIrQu19VEQJNbTo4Pz9/?=
 =?us-ascii?Q?pNw8tqMUpYY3YzUnmBzBq/fnD5SuFO4hUbnGaTKd76NvYw4mcRutq8ka/ufg?=
 =?us-ascii?Q?LgD5ttg5ohub4ssYCYqKSgriLPMLtETsPdd8poDWWYn/KFD9WKRV8p6ncgsa?=
 =?us-ascii?Q?v22EL9o5ZcIQ/Jf0eGTri86w6hFFSFNuN/8A+wgedLcAAurVZGla6Z+vKRHC?=
 =?us-ascii?Q?Y1fvurmGWrdgH+b2zifMO9rDFc/fQblGlGkGfDUER23E+eehPP/OtsM2bru8?=
 =?us-ascii?Q?tmS5CosK6AIm6sLbFOUbCqbHpz4BZitKC/fGWnxVlv58Sy79rlqt5KibuBNY?=
 =?us-ascii?Q?K1G9rzqnUVHArfy8NXpCxOSwMsHneVgnAJf/iTafHtiuOcSaacP6Gmryij5U?=
 =?us-ascii?Q?AOxq9cXrQbErKfUuGyP5bKS8Io56PFeztnOddwK+jwMj3YbbnEVGT/R+TW++?=
 =?us-ascii?Q?Qxu2vjfu9XKLMeBEdJUvyzaRH/bC8w0zepMd69C+f0apiYFMc4GJk9FXaG2S?=
 =?us-ascii?Q?m449rf8+Ve02mp/jbbRCbmnfBbPcYdZBNXuGAUqk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee48780f-a573-4fa1-ec64-08db6e673f01
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:43:12.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ft3tWsXJc3Whv3AGzA57C9LFNJa8az2z7Tr62wy+1KGGVx58SpdTtARto0YqrWmVQzlxYTPQeMuXx5eKF1GgBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x90000000 - 0xAFFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index f1c6d933a17c..d2a39e9aa951 100644
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
 
+&ele_mu {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
-- 
2.34.1

