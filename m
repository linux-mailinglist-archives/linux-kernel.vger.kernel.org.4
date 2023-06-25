Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0F73D034
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjFYKxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjFYKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:53:21 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E77121;
        Sun, 25 Jun 2023 03:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGA2sWgYyxqYCvCM9SeQIXmnu9eUybeCc0cV5qFIenJlVUjwZ9h/ICRqPeGXq9s2LdYzdauTdfsYbTzwV9pzeM2xkAxHhGI30GxSmneGe0dQTNBFAFBn+w/B6zFJJnL+A0Opta/TMpY84/zo3svo029sStcFLWTcpv/R72/uPdckPO9+TPl+DvF68nWtupsJQ4K9Iv09/8qovT4NjEeQ17GhhJofBBmdBVYUyFdRf2dR7dJJ1R3vsHxD8UHpDzvV5fgDVSQYsRPqijfjRuzwn8AyzPc9mNiVuXGa4vx56hknU/yVtmHBmEZIh98Vpos/LWkx/XFY4cLuESpcZ02dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvEgrjjQT355va/UXHxKncJ/L00GeIvJPK7HozdLdeM=;
 b=KpqqBMfLcuL+YNIVWlJIJIH67bxh7RDN4TV3udwxOXWNcJ+CzYuEGKwdMVnYyfFFJ9a5i+KT1tsa/U9gfYp8CbVpeitPFHw9zEcOsVx7FoDn4FKg9oxXikVoNEn3fc7NIYL4SwVXG2FC/sqeYafvu+HBadkU4rm+lrn2rZQrkL4fjhLRWUZwNjjGP9ecjXUcCmNQuu1ivrZzXjjZXkmNVqpkkmniZQJfE8necCVKv6rPabYYayQBpX6/JP+tzBib8D7zgIbXNmhMp4auQBg4m3yp/tz9zvOVBgKJhOiWTIUjOfnFFudcNBHiuXxSnQcxbvCiIGYmCGnrYPB+xDFS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvEgrjjQT355va/UXHxKncJ/L00GeIvJPK7HozdLdeM=;
 b=EK/UEafBp8RCciwAEhR4/oa7y8+ZXUoKTOOXgJ7tJj44/SRykfuu89nouhkJGAI45x0UL2jdWbstmJKEM6yj2V1yIpFApQaLKHijTMNODddItArNgUZpRBNJNzjjSew8j7Et61zvVaC29gjomtwUnrLUBaqgbzTI8y2rzDcQ0nQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7928.eurprd04.prod.outlook.com (2603:10a6:20b:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 10:53:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 10:53:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] arm64: dts: imx93: add thermal support
Date:   Sun, 25 Jun 2023 18:55:25 +0800
Message-Id: <20230625105528.4057850-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
References: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: e78016fb-8a5d-4073-7e44-08db756a61bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pV8RT0KxPNBOqv4J5Wq04/G8V/b8IdZWTARQkIYy00s+ty+wI5NCHckM7J3OYQ7hSf8YDBI7JYpGL7Uth1RclfsauJtEUiTP1q7HOA7/FZl8YHTH39DEnCtexV8o5RZjWp/9rtU4QcyfWKO2TVAsio7HpMhuo9VT7LgxoKby8IO2emsIrQP1QHztQ30AvRPxgza+I5/7OSz914Lb34nXpK05i5sa/NnZwn8f2a5v2mkKw64XjQqWeUVvLK+Yw4JCYHftyYM9z2fb/iGRous4QuLrpvKYmD9OspQ8puGwazOlI+Oq08w91cJlvvDSBEWNuRJ/DjwMg3t+Mlr63543JfKngxxAVOgLJ8wxF+EDcqlIS6aRL4VExfai5NLdGHmVl8MIpaRYYwnxJbSOx8qDfR0DfitnXp798KrdIcUMYYIaWt7/0F3nSIM9Abgs6T6EAz3lNAflIJ7FeLDn4hJ8GvHP/Fnepbx1Lwyzmm7qOs2vFW65K3Tq6DpyzSwqBFgD+Or27hasBVpFELRTFv3o0xth4UzPdGd/nRObHl9xF/5scb4waGKcDeoOzzQlYo02HH5vU54AAu5Fb1ZSoCsxHKHb8hrTnwffAwWkJRiFaCIAb7PN5cEChhKWkmVwfZt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(316002)(66946007)(66556008)(66476007)(4326008)(478600001)(5660300002)(8936002)(8676002)(86362001)(41300700001)(52116002)(6486002)(2906002)(186003)(26005)(1076003)(6512007)(6506007)(38100700002)(38350700002)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vGlfDN83Nd2mI/Xe/4sSLANaKDdCC/G3d8wGe7NRtKQFGVqfoHw2/XwvF1l?=
 =?us-ascii?Q?7FHuFenEsiSaFAWaPE/OkQNfiqxQdFbrSM1UeMywDnjsaph6A7vqWGaX1Hwm?=
 =?us-ascii?Q?GgoZLzon6UtyfcI22OIV4bqSDNyIZDKR0SMf4YUUq4vhSUWDQKscuBOait4N?=
 =?us-ascii?Q?aDLJy2pc5KRif0PKUQcZ4AwvDsqAEap8ke8k5+n7u13YoRygiqYhMsXe2nXl?=
 =?us-ascii?Q?+9ZYp80zyorewERgowGPPOrgXQ+FAeBnNEadhEUb5snKJVNxsr4tkMDt0nkU?=
 =?us-ascii?Q?B117b/J005DYVAd49Rz5C2cFrrchDgUC87gCGQBpE1Gpa1ZaXYKClwV3ydzg?=
 =?us-ascii?Q?HXcGQsxLMyBCHXQeuIXLKmwF2jL7GTLFLKzFuPl4TVCSEOyDLsTZABu0k1Ly?=
 =?us-ascii?Q?Emd0GXthBWPo3yefkW+ujp+EM/PVxNWyvsvC7JbQ1FFtcTcLSmoiVkTuYbJJ?=
 =?us-ascii?Q?C2O/u3KCvUYHE32K1cEK03hcZqrHl50E1CRW+cLh55Zky8bIT/FAHuzSkFIM?=
 =?us-ascii?Q?32o1h6PKCwu3AeqyCmtT4HzjlGCa9p0AVDM+bAz+VD0CLPT6Fb4Y/5xXQi5E?=
 =?us-ascii?Q?jNvdrwVsgzwwBsc2gr4p7qOrvcScucs3TjpG3HhhtdoYi3/cnUOqa+vSYyzu?=
 =?us-ascii?Q?pEwtaHPXo7UNWOw9UVAYcGLCQjojP619RNGGhzrs29CnTfm38bYvVSzhdTjV?=
 =?us-ascii?Q?Y+s4RvBPkIDaUYwfxd7pG+pJL3/RP1ZGCpMJ+bMVWjghuxYDCLFc4JvTeiuJ?=
 =?us-ascii?Q?QmeaYfuFe/HxWhCNRXA2KNGQRRXR6HmlX0zx7hEfK5vhO9Oq0SAWgjslBG0+?=
 =?us-ascii?Q?+g30IS/24kL0kAj9ZyTdJNfd+KvkTZqTpVfKwXnch2wnkBJ1+0yxewnB3twm?=
 =?us-ascii?Q?e8oT9vyUY+ty6uAirzZEdmpasvptj/lkqbFc/6waYmOw2JW1WTQ8ZnCnBgbf?=
 =?us-ascii?Q?LR1fnzwtsM9wRqg1AJNd5JVFEjjyTFiPdPVTEFl5BGa1V2IHQYj2cqSehuWE?=
 =?us-ascii?Q?JPTuQoJqc2l8AOqSgd5E+TprAFEvI/pjMQdhhNaObQjWClkJUHB+YNGn+AFL?=
 =?us-ascii?Q?lsIcSJrQ9iXfM8UHVzmk24yqR4IiGaBPDvCu4FO1WdiiOoSDAPZ2lfyLNmZy?=
 =?us-ascii?Q?KY0THZQjMHfYdVISd/bP96Pd4zfUFFj60YV8FPgJG9AnypQNHbcIgUbAmP7g?=
 =?us-ascii?Q?El9wJATRofEFOSQ55konPmzg58sX0JNDbXh/jhk7hEBeAGwMNJhiPYOvxbYY?=
 =?us-ascii?Q?+GJzkiJtY7X8TZpidEJUuiAwYozL9hbb3fSqZsyTDsgUZw9Jb5KxeHiIeQRa?=
 =?us-ascii?Q?AygTXsKBEftz6bEosPhCLkHdSq6XlhrONANWPKQ1nNmwEFTGIPGsE8ZKUtTi?=
 =?us-ascii?Q?pa7NIOA7RspMCjQ8iT/oFXMjZT5XgCm73kORZR2XET1WVzirv63Hy6DyPhJl?=
 =?us-ascii?Q?CvdNneln+XOZ7vfLaCKGP5bn1FKR8Qt1gg9So/1Ip2fkKkiitEERVWjhYli4?=
 =?us-ascii?Q?uIfkuIZtkFmxkIE+MRLt0KxnKlDUF7LquKNGfiIEHnusBAp00HCmhGMSU3du?=
 =?us-ascii?Q?AHDW3Hfh0WOJUwYBdX8YLFUBSHL/Qvgv38qeWp6r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78016fb-8a5d-4073-7e44-08db756a61bb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:53:17.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+0JGc906WGuJ+6ur7YJTxKR42hNgSeXEJtlS0RKOgVra7gF+8zaywPp+6NTXkIjE4qKGCdYq7gSwYKbVPXKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7928
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

