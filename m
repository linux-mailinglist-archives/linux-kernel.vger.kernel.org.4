Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDCD6206A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiKHCTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiKHCST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:18:19 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43F82C12D;
        Mon,  7 Nov 2022 18:18:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da2XTECTK3xR4EBh1EkGhwX4tUS4Rrtxcim7zUgI5af5tX9bwW7Gfm2G8qJj/spjlRso9QXLQ/65XbuALXOpeyC2SsL62M5UdMC4BBXBtVGsfVCr0tPMshSgX5RC7xqnpHbXYFWjzOeEcGszKQBkghiOp9pBqMPdyqYdasfhZWbAU/Mx/tXR7gp7s8wcZpUFx07nTsBekDl/Ym/1vYUanoY8erpQmuTb3nMiUS1dGeWEWPOgBqZ8bDTBv42zsmd1mXA4v1FeB8VGx+MiAH/i7Mice3Utrb04L9TsmvcxV0rpoTMBxk7eGxMf+T7UJUcjQR+KyBrUmvd4Hq9vkTqt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45ZlfSnPATcVCkuW7OpkmI6SoUKfZvDq54LQHVB8cN4=;
 b=UAMlxTrDHn2UncxemCybZ25VUd1nwpeaZIjWM6N7kE66Hb5aoXSkDDUhsUEkFiOMqJsvBLzXOf2lXLhe5ovp7edbYUqRv1tgymP04WhbWWjzetS1lN/zVOUDNOgzYknlAmj105B6bMM2o+JrrRiJTBoxWlbM9Us/ndc0U0jete+TWZX2SN/gDfjuCyOE9yCJoVQq6ReyQ1W1Z4YQQJXmlVfkECLhXOlJN0IpMdxIZf74TlVaUIdRExaEMPxKhmqFLqxldDMJBEHGSrv9Lcfz1Npq2o64KyZi7VMMc4WNKCuNKUqydfsWz1zvZfqSI5Iw/bP5ULTOSlV2mPHv2nSexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45ZlfSnPATcVCkuW7OpkmI6SoUKfZvDq54LQHVB8cN4=;
 b=Z830wpnC2cpdUiLMqtstC7aNEqgt4KK9p2PEPo7NE9iXrVXLLAiNF1suM0aoMfMjhvVsaNIgV9hPbf4zwiSS70X8F3yuVromLR9H6XYooFeAOzftAVWUpVeOiossAJ1jDuRg0nFxTpbh9bG33bP//fhR0fmXLdXPnaWMycEdMlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:18:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:18:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrian Alonso <adrian.alonso@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 14/14] arm64: dts: imx8mm-evk: add vcc supply for pca6416
Date:   Tue,  8 Nov 2022 10:18:20 +0800
Message-Id: <20221108021820.1854971-15-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f0753c6-4cbe-41eb-98ce-08dac12f7e75
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCzDEwdtwyEwshtqE4sXn7FM84In7ff7l7faVPDYo/bTgRO+6SEAZ9C3JVVC+GNiDbYjv5S7tJ70hrr+oZfAOWY7i+lhFUxPSix8dAIYinMxWEwuIf2B2ieFM41ggweSEWXohf3JkzMFhh/9A0GRtGxK+kfo4F/TUupN9Bknn4uRBpm+PqStrxmEmlly6X67dVqwjfagd9wyEbwtflYdxyJzJDpF7JznY7z4e4Zo0fQyVCC08CGoC5HqGb93gKzcYTX4hn5c+c+AQujZHLfF8UljVVshZzm0WMrU5oSwfXO04V7krQlbrlbJMI/WZS6H3wtxYUdZyjBAMUF8i/b2vPpcxnaN15jroSi64aRHFgUHzNnYzOZgvLeDUUaaaHNPss+BMIGVupGzq36C0U/MCasi59eaM/S+sUKRQJJxTP0nrXfVxsSgqEs53ydb3C4EHauIBfhQUlOo5+JnOy55C43bKzzywYAbDuBsMV/ZYkL3bUpYIZcLWSDrIqYlAZnlpKNVd/+cjoRAFPh4pCqzQPWXKNUy+uXmgSzIXzPVHSAf/vUHtZzMSx68M7fHozHKRfh5tYoFxvkMc4PZjpybpa07yyQ87c1lTEBAluirKARfRuMrJzwH+dQr1Y1l8RSKGNKONXJq0CjhQj2bxhHparlPDHxJxtQVOYoNLPmrY7x+SbMzbpiyGW2URwRJVyh/AHoErHs6rb23RhVrdWooUGDTdzJenzlyyFoPAS6GjnG0L4W+YhlW7ulJT+J9bG9Tndr5BdHt7tFLn8QVHJcK/Zk8bw+rBrtF80B1RB2GwXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(38100700002)(478600001)(66556008)(4326008)(66946007)(8676002)(316002)(41300700001)(54906003)(8936002)(1076003)(5660300002)(6486002)(2906002)(4744005)(86362001)(6512007)(2616005)(52116002)(38350700002)(66476007)(6666004)(26005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Le1HaqAa633uas6kBOVZALp/97/3Nqd2hUuwq+EUbLw+JxkTc3Cbem4SCyZI?=
 =?us-ascii?Q?o8ftaAvOUBkQJT+T+d+7UiIRsKTWAWFc1Y8bzndXF+cFFTpzHx3cdeVr+7eC?=
 =?us-ascii?Q?PeUgHT/3I/UEy3N7z12Bs5U5Vzd0KQ/BHxzMJNcEysfEuuBRFvxIXAYhiADw?=
 =?us-ascii?Q?5VZHuUMlfhWcFNmzLUftny4XeJ4KHoODMoo34eFL27dvmXVNgV36iV0cZw8a?=
 =?us-ascii?Q?T8rSS7KPVhx9JSFTsi5BXtcL6Uxv/vR2C4/X98jWKjmIs8vYLaNHNCxWYcp1?=
 =?us-ascii?Q?PxF/4GGWJkfr5oxJs4AddYIqNLn0W21kgVQSXKoV4drTHR6/xNdjlnVe+P+G?=
 =?us-ascii?Q?4hXNEHF0EBS1AaQFnqnWBYiD/vSCc1Z09AvKEfMfT/IZUz/MWQnlorelzQ8d?=
 =?us-ascii?Q?0Cai+aX7C1Sgv+kUEIOIyqsk2y/OfpYBraBwScpJ6CseHJZYnz3yHxd1uI7j?=
 =?us-ascii?Q?HkFKX8dItJvjCyVc4faBfrHqN8MraGS/dpMsQF8FtRI26irdPKFTNa42D377?=
 =?us-ascii?Q?gfU17IWt9jkMOOUnrkQV7Ua5v8oubg6br2yIXKSpyhmHQtQx2OTC95F1BbtV?=
 =?us-ascii?Q?MCU2+TNLPjge3WL6Vmdoclg1z6eqA092u49aVlizSyGiIANTMAqWnwD4oU4d?=
 =?us-ascii?Q?qvrJ+rRmRsOxrdnRg8s4SOLsHQRinEvHn5/qEEBXip/uZVTcqxmLqdMLmnFw?=
 =?us-ascii?Q?v2XeSjyr3t2e8P/ASF0ZXv/O4Hgilup9wtdlppl4mtYshq8bnHm41vwG95BK?=
 =?us-ascii?Q?aKNGlgYaI9/rmnHNmloeEGwrfstn+Y7h38P3NqlfMR9jFw3yC7HxXvxpFWol?=
 =?us-ascii?Q?0kUHDstBJKuZHVpnQGhul8eRE167pDeT9eBHHHOjyOhGlKOwFTatcaP2Duk8?=
 =?us-ascii?Q?QeNuDv8oosY/NKGJWUe1xBKu9ZEyzIgduf55YKEkVFCO2xfTRsPtZmJN/zZk?=
 =?us-ascii?Q?zDMFVGN2DsRF12HcoGYZ+q3/bvkIxebHYx4hdPAmgubAtcxrgGwRgenjrqQe?=
 =?us-ascii?Q?Lg4mTkq18cw/9qf8KZ0jlWFrKo8OK2XmZjQsw+Q8td1vRKViNczy4JkP26QF?=
 =?us-ascii?Q?LLjbRm37AAefLA1dt6UXXwnkzksBTM4iB/7Bg7m4kF3e++c/pQ9iJyVrzVr6?=
 =?us-ascii?Q?PXqu6ZQ2CrSkNHYxrllIrFOnfq5iIyHnXd0DMcrRPFfRGB3wJT/hYq2GaH3h?=
 =?us-ascii?Q?7NXwZC7EkB+Hq3Cl4xob500Y4NgLs+c1zV5eswKaOF2+JM6uWA1SbbSjvW1V?=
 =?us-ascii?Q?EYa5GNCATG8tSM+xD+uLFYH7znmhhmCBmYpIsjK2CUUrUBdmCH9E8jHr9yan?=
 =?us-ascii?Q?v+RitQV6XAO7vy+4RSa508n7/4DxZ70kP3347hJbpJ3j5FPyGLda8bU5SEnc?=
 =?us-ascii?Q?vUO9B4hmIYffTM+WVHYl8Rw97EGeV21fry1+VR23+G1GEpyDa1aa1dFi8VrJ?=
 =?us-ascii?Q?LWtPV5iKHy0CWC1aoH3oS1be8ZJIu4psZJeqa1XFlXtaWBHXrXO4mXsH160f?=
 =?us-ascii?Q?fnMh4MXXSR6RwgS/YFizFvUxPPJkPR/uygd1NMphmCruTzP2HB3bHt5NBqyg?=
 =?us-ascii?Q?uWJ8T3j8WklW45W3wSSzTvIolzqkBBAyUHNFA0pE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0753c6-4cbe-41eb-98ce-08dac12f7e75
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:18:15.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dV3PiwbcwlQdIb1u7JSiNdrc8cyonnu/nVFNGB5fxODaDTyf+T/L7cF2eZMmyjm0P65gT1R/ODGw7JPSdNQL8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Alonso <adrian.alonso@nxp.com>

pca6146 requires vcc-supply to work on i.MX8MM-EVK board.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index fdbcd2483efc..31144aefe0ba 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -344,6 +344,7 @@ pca6416: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		vcc-supply = <&buck4_reg>;
 	};
 };
 
-- 
2.37.1

