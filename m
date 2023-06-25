Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20873D0FD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFYMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFYMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:38:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF5E47;
        Sun, 25 Jun 2023 05:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdiNf8DaxNbATOa17G99KXMm7IHn7uCbFFF1s0pcJc6d20EdwuRjhV5JKqXhzMXvWUhS4ZncY4DSPXszy8A0E2+EyUk+bIpl4MT7KH6PFtNjbyTcuNzUh8YayXuwWVOCbdI9IYEs8Z6v4K8ez31gsMGhLl/tArFRfDXb//f2MFyRUTwloP8/uxemSGx/0WIh1127/i1PPdGDa1hwhgHuoMPHypdFQy7JlHcjj+7hmQRWScnAEVHW8XPeOOBKi4NjAm6J3rTSO5NkA4L2fZHmt//4I9+gwjN+mojQjVqiHWRFSm8to0lxiEgPHyf0RAz0UxmY3YCOnkdxfqBX6KUtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyTZZ+HM782n8EE28NNxKaHkI0gZ0Z516f3IONacWFA=;
 b=J0BV+BYoI+5Ri9Akd5Ie0M+GWQjSHsXQczQVug3DWkWcCk/4IJ9XRLrSQkNLddTy8Z05ZjZIf1qeiNuRMiji89J+1ltmnmSssF7zGlU8ZtkYoeOpkk1zq5u2siJqQ4Hek+1dP56Wxz1RErq9luRHkLahNaOH7qqZlU2K9CjDtdBbY2VMFQq57nPVfZxwSDebv2mLOmFYhK5OqtOQzMjCU2mSrfutiiKUfTmpSBaWCY8IMDp6c82/8RN7ACtQucLZmlvB8KL5mV6OpzhHG/KkOegNxvHZShKVXamsuFlq5EhNdE6LKAZAu9BXviCmppXQlCPnuXmUpswS9alj1cgHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyTZZ+HM782n8EE28NNxKaHkI0gZ0Z516f3IONacWFA=;
 b=KMcz387Zn2nSvpdREPMMCvFkcyoY0/DtqqHMPzO430CsVKix7+mStgtv6I4IUIwKyAOgfEQtokdJqvjsdMiC+NRG7o8BXOHJM+JVoesCFv7ZIsrc2ncdrx1wvCd4R09t8qZ/sR2/7C2z+WszEfEqQkzuhEZOv5n2fcpHxfFuu1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:37:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:37:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 03/10] arm64: dts: imx8ulp: add thermal node
Date:   Sun, 25 Jun 2023 20:42:31 +0800
Message-Id: <20230625124238.4071717-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c88bfb9-b44e-4ca9-71bf-08db75790287
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBUvn4asQdpFMUwyhUVl07IhhFYHXAg6U5psxFdvst/hMQtGEE1wj8U5mLMKJJNXCGvRzudCxouILrtPDVaaqEn2ttzMFv/IWPnasJYpeYMwCCdhY5lpr+GLHoJgZMJK7arJKaEgxiLkvZ8P4Fjx1QikQ2it9xnj5WEB48Jbqjtb4rFJYqVpS0jZAgPfAG7GhGP2AP5LywrvH8TReZXEVMvwOQEEhhsjYpkpKXfnDLy2d82uFJOVzEUlfUZ6VR7PySraBjfSPqV6lR24sulBR/ueQyKU8QgITXjtEZ1SGHXTwxARnaPvwqH2QZJNBWTi8em7XSRf6eK5Ra+DuSq9SG4hUozPSdGzC+fsaefDzjTJc+vzjMuv9lbR/35PsEM1L5yNMrs35WrLQJVO37YJEsukCnHBX+0WcLD5LQyMrYSbdfVca12ZuURLfWvvqHJOK+w3dAT3yK6f2r7P0CUjwB1AsznKCj6YrSgRp4U1VIh4YZEEhUONvSyQvOxD4yyJenHkO2xZVNkK1gEUPWI2Yv1v8t/IZkE1nyatdvPcLJ/EL0i2PaOEgOli9TOYhw7W/h3jQr/OSxeFr3IncqZNSKPR2UaNvcXMS4bJ24ijZbRgq20Dwx+waXE4M005zLOeTgrwCZuTDHeWYnqPYgSVMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(54906003)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDXeUkXb1w5tg7NwqIRR+m1nSj0UylF7Xj/KAA8tUisjHLoGpng/BPrv7Mea?=
 =?us-ascii?Q?b6zs0hjMeorOfh5Sm2n+BHxX/ifBtqgAnsqG3TlbiMBZ2cpgo2SvIRhZ/1dZ?=
 =?us-ascii?Q?5PXHguOPX52l93QaNqw09YNqLYXaJdXl05XrJQAVogzrJbPwFd2gBX0plbem?=
 =?us-ascii?Q?NLm54YUtFarTk97M2pgxX+Z4Ct0zbcNryp1KlzlX3NtrU+n8YD0zwU/iCWWK?=
 =?us-ascii?Q?+xGUaLS5LqZO0COx1JJcKP1LgwIGqxYeS+ig7l5jJA4YVzySY6i4rW+3dWyP?=
 =?us-ascii?Q?A3LKzC56EpjDla/RxpQNdw7e1qxb3/JRp7wwJ/R84nvOmLVRhnfr5czwXneO?=
 =?us-ascii?Q?vWZpbnp8Tnm6QJp710gIOBgzM5eapMURSzuGBUUcQVM95bJHMZh1pMkPrNeG?=
 =?us-ascii?Q?M5kObtHt9Urz+i58An5qXlJ4ixEsFzryrsODc89inPohAN7D5glllVYzCczJ?=
 =?us-ascii?Q?x/Ci4EfgXMKsMprG1RFjwQENHwCmm5ABWSDtuuOjxO3Or6eK8qU11Vt1ym3v?=
 =?us-ascii?Q?BnRnibZHqM3w17vcqKbUIyE3+3WzW+VKjh3qFe7jskSW61WdqQdr4k6SQUlV?=
 =?us-ascii?Q?AMha+j/h0DS6oWbPVyTGzeX8WIQEZ35yW1a7NfHflCn8DsBF8WeAcvNh2hX6?=
 =?us-ascii?Q?aCEw2hQ8hUUPbIEfUANX6Kb+XS35MgAW0fThx1mjPZaQjn+x+Els0R4EhJ+V?=
 =?us-ascii?Q?M/UHGOD31IHxg80qFNuEion5KFdlm7Bi7NBI/ei4NapFpREWBWMAvIeBFQjf?=
 =?us-ascii?Q?N7S8MzaVqhlDIthMroB3wfHp5WtzI4w/3FznqV9bN5+iA3jldCjPsoNf3xnl?=
 =?us-ascii?Q?A3nUjPuFU5513EDIfkGdO1SrsLpd/rxpgaW+WsfzwIdOX8JPcwrIRmbhaIYy?=
 =?us-ascii?Q?EpXDcA0ORwbn1uDY4Q6s8+Du05z4Wvm52iLhRXHwIiN6Ofc6993XJv8V4Hfd?=
 =?us-ascii?Q?KKpH7VwM697D3nUhCWnuaIgizMte8t/ZjP2g+19OFWJtePkZ4Wzv+SvXg2cP?=
 =?us-ascii?Q?DmvMaQ8qTI6cNDgKaukfVg/WRflIH3T/lFG2RRqtkO4wokE57n6QdT84rRRd?=
 =?us-ascii?Q?J7svCg5i6C/5KiTSuICxi9cwbWiyqzyYq2VeR2wZr+5pfkvxSBwqXRUEUEoZ?=
 =?us-ascii?Q?SQW8fSNsQWshzAV9DS1aA5FJHBRWptPdHCnIy4QYqTu1PFcFMpCeFbewlDM+?=
 =?us-ascii?Q?R9QYgX7Vfi+/K4s5rDRSsNsPL2G7ltFvOaE++Ptcf6a1NLUJKwowsllmK99a?=
 =?us-ascii?Q?/l4I5anWTErEQWYElq1n3vfS3HbMii58qMfjUi7h9Cgzzlobvd5HgRRp5rUS?=
 =?us-ascii?Q?mI0EwENP7bZhv0S0X5KhlOLjB23s8NuC/P0PYRbcBsnLC6shDyyDTUIbgoSD?=
 =?us-ascii?Q?9MO+KGsQRwMjrMXvhQUozQ0gWt1fw1M5jGuiJbb9jM2ewAxsnBWBkgSkWHSQ?=
 =?us-ascii?Q?6K6nammkCaoBCSP3ZAg0MV89ySpOAOkB1DEP10l0Fae88xRXR8XRCQI8riyN?=
 =?us-ascii?Q?cvJNqbvOptqfbvHbtXpACDopZuUPQCC3SG76I8wndnRVP9D0YA3e6dmkqwdD?=
 =?us-ascii?Q?i4fA3Q2lHwBiJFsKQapiJ/kuKGJqu4AinlrIGs5u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c88bfb9-b44e-4ca9-71bf-08db75790287
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:37:59.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iqgBETlB741hNfxTuSzyLMZXrDXcHrRVieZtUPbCEZ4rjQAsOVx/mUnw+UaSzSVY1VDIhUImGLBnbUHusSj/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add thermal node. Cooling map is not added, because frequency runtime
changing not supported for now.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index ba0edb9a009b..fd30475a561d 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/imx8ulp-power.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "imx8ulp-pinfunc.h"
 
@@ -78,6 +79,27 @@ psci {
 		method = "smc";
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&scmi_sensor 0>;
+			trips {
+				cpu_alert0: trip0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit0: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
-- 
2.37.1

