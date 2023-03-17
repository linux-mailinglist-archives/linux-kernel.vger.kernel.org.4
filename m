Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAF6BE942
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCQMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCQMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:32:24 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1776F48F;
        Fri, 17 Mar 2023 05:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHHaMPi6NWoDV1Yv6BNVMvfyMg1KmIdY7evLZShvAUjpN8XQDWQkRwq2xB0YkG7an5YsO88M2aKc+sF6P0s/260t5cL4WBdoyKhxX2a34K+GFaC/JdHjtVRXQGc6s+4T4wsBBLTvjs30+k39mvqIW+GCHE+XV8CKTqm9Mq7PWtciBhY1KbGQk+bwJf1S7dcs6PEMeI4UOpb0K6McAXs1FU7mVHWhIKzBzpckpQOmvfs0IdkkDh/CGcM2u67rvQZw/HS0+8/pWNY/7R/LuWd2gA56nJa5NRQbWRJ6iT0l7O+TyrBeP/a/Q9H2UCb5FJWJNn2u8nNCMQ4uOxumTOTUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AOiSVpHHsJl5vjiViXVJzHrkbnpOPMIcItM0GZM6/E=;
 b=WyIIhUOQuVGeooFtV3FDw+hdfue/CTVzqbe/IDAF8rqzr0GycrHfnP7sEG/HZmGszKqtSUQ7tHE5K7/qXUQ+DtASj+aV5WgymgdGKtgZgsLpt7EBgakgwc3jS/RcUWRQIG4TFrWw7OPAzMNhP3ucdco4jxjepdboiKSwK8a/urQcEz9sFiV3bAEDU7X62lW4RPTsCTmA1DUo2QfByuGmSPk0wmtEEPDLAKWdsOyohWlBhetlNd8xVEL7ALXgObJ0erjms+Mar5nV7CkoLUSCt5OhsDga3RfC7pONLeHGsbfn+3uguDHQHSAZ+96lVgjy06by30L8sCxQ1DIGpITEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AOiSVpHHsJl5vjiViXVJzHrkbnpOPMIcItM0GZM6/E=;
 b=F4oTSWVrAnFss8gCPyV+Jnx9ovKVCO6COW5APizkrghHSTgRPlBJnsDhF4zL+nFcFHWqAUldkc65XogKcq3GpaXNURwAhVsPFW2RsgexxAh6JlfIBQCCZNuUWMGuiQUvGjpOlW9X1939iTAer8+pnnGpR9iwoBEOUl95Tzk6B0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 12:32:17 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 12:32:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/6] ARM64: dts: imx8mn: update usb compatible
Date:   Fri, 17 Mar 2023 20:37:05 +0800
Message-Id: <20230317123708.337286-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230317123708.337286-1-peng.fan@oss.nxp.com>
References: <20230317123708.337286-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: ac459aa0-1c91-4927-6cec-08db26e3a513
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fv2gVx95QftD6Ri8YzlGE66t+eZJieD6KGP1jsVG7o2NkeUdLwOm0xr6j5aExBtD4YXfpVj8bpSY3VQiv/3AjHmdfi8D2DEaSjE+tlRxEnH4yBm5rnS1NgzOh4xh3BV7J4i5nMQOs8ZDZl43W8hEj3rCiQrdf5XUW8vUILR0QroEzNk9ZwWrIuZjGwViYmQqh/4C5HMwGb0tcUaW1pLIDiBak8cYNHkF74tymmv8Y/P0/7YCmesS5ibTer9HmbTxuQMXbsNW4KPAe/GVXcT4GOie/OnJUKwDqtCcZgF4T2TiwvbCjOFU1MfLCDL9AAM4E0I+TyHS7zrHU6uVQ+8DdwhFijeLu1KMQt58c9oB7ABmPxc8XiA2EwKuHYj/8YoSqS9mEYMSYfsZnCUnXOr0po5RY8hGT3HGh27Dw6dhUq+mDaQRguG5MzBZ0kLw2lm+HXAQWx8MKr1ywkXPAdNZQRE4D/FzSWHFkHF4/U0oAtjomzc7Lc1159PeK5LTBGLUJBYXlpJNYdEabn8D+UBqarJfY903rcjZtj2l4AtQemxA1Oz+snmfAysiXpYttba1JShUXf28SRGdcGOaEBaeRTjXW3GXn/IfqHU6bpk0UUPYCK7fWZwCBrGEUcobD2yS27mAnYvYV7T8D+pGvpixTdfLg+UCCtUpSmQH7AmUtDHyae+Z1B4YqqLAMVbSZhrxTjIpWJJ9s75QEmJ5UJ3nOpgObtiPZdzLsIxa5sopQxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(38350700002)(316002)(15650500001)(38100700002)(2906002)(478600001)(4326008)(8936002)(5660300002)(41300700001)(66556008)(66946007)(66476007)(8676002)(83380400001)(7416002)(86362001)(186003)(52116002)(26005)(6512007)(6506007)(2616005)(1076003)(6666004)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?if09HhpzERHkaKVJAqkw9bLW9W0zzPCnhU4MzTZkr7w5DZkXoQe6iD3gG94N?=
 =?us-ascii?Q?p/xpt22HOZ9nfzHjbraINjFouRjbUoYCdpek4MdDdAfHw7+YX3k7uoRGLHW2?=
 =?us-ascii?Q?YmSUvzhuj9+7NN6wyrDpQ/vzdvC5u8npTUWiOnMRDd/j8Ild30bPk3t0hODz?=
 =?us-ascii?Q?t2DgtcNPRVNA/9eNrnLLalyyBwY9si3KyjFYzpm4FjqsIU8476RyP8SxZhY+?=
 =?us-ascii?Q?ovoIq6AWvHZaD1NSz5jjnjUwJWprKSGuzbMEJYWA529Nxyd77DsUV8z6ljFm?=
 =?us-ascii?Q?Wb4ld2T5Uwl5eKtVOQBBYHklVR2fdf8vvGzzvdXSdxxn/H1nJNLc18FwcxHc?=
 =?us-ascii?Q?d6bg4IUoGWnWzWJP8Nc4BCXy/toU2cXjBG0aF6/gR+fIKfY+tfwL9sgtUIEC?=
 =?us-ascii?Q?cG9Pyoc0WRBp5v4jCYpDBMHfonUhcbY+OAL50PHOik3L9gPjkek/FqrR6DvC?=
 =?us-ascii?Q?GhgsgCK0G48EpPuqeS2se0J9jcQexzgS4eUPaFD1UtpLsEglLaSv2Xd+aYGt?=
 =?us-ascii?Q?g1zNcGcHK0McK06vxvTSncO6dqUNVXpwiR0gGKsywZIi6a1UGtir4A1eN9Ij?=
 =?us-ascii?Q?vnPeVm/ITYwHKDFmgjmvuVwUrCrwtBTFF3fLU9zGiBJXpsh7PeKSErSC7KKv?=
 =?us-ascii?Q?w3+BER/isyvypkNp+QyR6tMCnKYuFKP5vP2VuhhzBvrdVhylr2iVfzrQVoue?=
 =?us-ascii?Q?SgOETU6Hv63p/PSWWPKcfgmDpoccaDXjOtHUHansLK2zmEmxF3e1WP4uz5XU?=
 =?us-ascii?Q?vih/Lrp3H3/34Ydi6Z0aB8emSV9T3+x1LLTzxFr5rsDC5ew9lrCQtfhWIr4a?=
 =?us-ascii?Q?RZFkCazB4PcVqjFKhM1yDvI1tyf/zhMaYUdIPAD5dr2nkANXYCwPXuS3uAZf?=
 =?us-ascii?Q?n+N4qh1U9RqET8prCK9QEdrXIZUVnqMs2TDJjZ3Oeon/PW9Y2mPUYiWd9BZf?=
 =?us-ascii?Q?zvqyHDSmLqR7MHIb2fH0fOcn+OcBtqNiCJzK++KKrhzRgepIAEmKpX6tU6bR?=
 =?us-ascii?Q?Nhxw2UnjnzarQAj03kbDyRiYUWEuLLVGgEmfdDaEWdjHpwfNu3V08CmuCU+t?=
 =?us-ascii?Q?68vcMMUv6OTVEgxYe710q0PqNIFzBpz6VEishuLib63JBvXfg8KOw7H0qyZP?=
 =?us-ascii?Q?PNaI4VkxYfW2Mbbk6LtkRAnhtCr+s6ACUIW4E5XxWIUGGqCUwkvdb3i2iVj3?=
 =?us-ascii?Q?QQHZI24qmO7jAA8udV6UXzu5nSCPDp0GhTK8qJe07RbJg9X8Eil14NtoR0vv?=
 =?us-ascii?Q?5+XZb9UR6qapuWITXOwquss79qa96UzHmdkmDRJmCnz/WpMu8ask+3Y0UZtD?=
 =?us-ascii?Q?k99FvudCMQBrVnwjKdtndUr0Rw2vZbWHAJpzgYr9rOvT1pPuf15J1wnZ6/yJ?=
 =?us-ascii?Q?z4f/MrdLo20vy/Vr5ds5/+VC3RitKCiZW1J5pceagTYPJpeija3QeFcXJSb6?=
 =?us-ascii?Q?MsvL6uBB1pwyEhFW7/St63GUBCAw3moiIkxAIGA6FetuEO8Qg5d505QPyBn4?=
 =?us-ascii?Q?5H6VrCXrABJBz5ovuxgyh0hwwrFmKQJAzHeajkJPkNGq+phdrFb/fYm31OA9?=
 =?us-ascii?Q?RX56wJ340lLFDZkKbPzh+fsbAD0OLCVBiDOqzXxz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac459aa0-1c91-4927-6cec-08db26e3a513
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 12:32:17.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwNEhIRyK89ywrbUrj2SGYydxT3YwCndKdAmaDvGG0/T72FnrWSZsYyhnTLP2QcRtn5g20ZAhYPTrwJmG7y4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
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
index ed9ac6c5047c..5c3ace42fd4b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1086,7 +1086,7 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 			};
 
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
@@ -1100,7 +1100,8 @@ usbotg1: usb@32e40000 {
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

