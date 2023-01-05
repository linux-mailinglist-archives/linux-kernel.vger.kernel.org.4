Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1394165E8C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjAEKTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjAEKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:07 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099BB5005B;
        Thu,  5 Jan 2023 02:18:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kadPkrs2jc94yc/RkJnkZXjldXeNev+Ynwzg9e4f/TNim6B+irXxblVRhE2Rsw6627U7T/LXMnPFggOabfEfgNu3qzYFDT4NGRRxXU2LXA9wRVGkKPEbCBQLn5CaFTUT7XMoEWxGPjgWGPCxsNEzvTo1Z/cmeJ/WaPE8D2cHI7qct204UfmrhOECd3sAprL6d7u1eJPSObiFyosS0QDLuw7mLmK+ZjAeqUE/XEd0mF1wmmIqKw6J49nEOkolIqpLBI/S+71lrtDmpS37uclRd3GdelEWs/PWcCsR5pamBfOP7ze3EMt3uHavX0XS02xzpddddDTrxsdejIhrrGCIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDD4GprmS+yHjZjuXjeyJi0vUb73DUTgY7ZaCawyKpU=;
 b=fkqKPkiqcPM8uSWGb39/2ug7pUv5uhuHO7DeGaiLzNHzC8I+/036alZZE50Z84jLnFhafUgLv9Ho8Zw1oaqz1fV4A+2ySBdYVptiJXi4WgymXZY5VvULMobcBs6yBT52cwhpxVWn5rws5S16dowmLCIjV5KkQ/Jzi8l+GSx0FZwOQU8aoJ7minDE9OkgYRu8bvpI9JYwrX5MymOhv5rTWfCvFalXDYWiv4a7fwF6hGIQLx3MXq711orGwcTyYZ59XSA+Ij3wxvk0rNSvREU+WeemYljennSthB+Qa094pK5o1hejrqea+ibPsZl5sjTCw8ydFMyX0vmle0XTkxGSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDD4GprmS+yHjZjuXjeyJi0vUb73DUTgY7ZaCawyKpU=;
 b=NA27xZtiad1TUxmP5n8nYrPyV34J9DhaIwytn14WwgdDuG8bYBQ+7WRUZKtHVwb1LfmhlAJN02ZybwA+oodJx3hUR22W+7/JFW8QfPmBO2N2NKBrziOyY8O5FAtHjirO/BBHXFT2Qi/QEhW6ct5LAnrYk4emEuT7iEp7VyJnZ0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DBBPR04MB7625.eurprd04.prod.outlook.com (2603:10a6:10:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:18:56 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:18:56 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 4/4] arm64: dts: imx93: Add CPU thermal zone
Date:   Thu,  5 Jan 2023 18:17:48 +0800
Message-Id: <20230105101748.6714-5-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230105101748.6714-1-alice.guo@oss.nxp.com>
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6053:EE_|DBBPR04MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: f017a1f1-6a98-411e-b8e7-08daef0640a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXGWI7ZGSp4FAXo63NMAqL7HElr7toulMtfFxR9uzeVnNyqUvcrMB9v0NjMuY0NyFB+P3H2JSY7n7cefnY74JBeFqOu6KJA4kgcWiOZ33giGjj99FH+oqfKHEDeWMQvlwNa70TutAkbrL80tyfj/3L/3yWYPviZ5iOMDtOKAYpGV91TTtN5mh0qEt8uyrzlt3/hLh1ziSE4zYmwJka+C6EE9KrQvMNzhED7pJjyJHcGFZt1Ha3b99vEy4nap8mofHYZ/4gxA+WglE+NQvXAGji3BiWV7Fw92kQd7nrt+nU2gDe+cxev5yKdf7zRfSCAd01vrrHDdu+xAWd8HH93Tt4thADvcqmC9PP1FzlU7HjithH2qx0j4wGcoXr50R7+4Ip+RitCZqIa9Bv4OLUAcLUaKmh/0rV2vUm3QqRDhadsIiKf/m0h0BqBObk/VcHyv4Xi4DBL9M0P02ykM9d5/1cGqLLf3RJXojxtRoRFc4y/J+x6W5LPqYYa9xenD67bLtoiRA07XJBSErVYQHX9HJLFuSCwiW4JiFIjACfK9pkD8zGEMpWmf1sB/zpf87TeercsMqlzbU7yvoiA+1UHSY1t9sHvGoIhdr0A7unRhVySS8JLC0NwdxvHXydx6o92ni1LV8dO24fw6PPnNQv9JvwO+YF8hP6CF7vQ4IfsfxAOwWQ4wWyRbV8nrojvJdLiF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(6666004)(2616005)(6506007)(52116002)(186003)(6512007)(86362001)(26005)(316002)(8676002)(1076003)(66946007)(4326008)(66556008)(66476007)(5660300002)(7416002)(41300700001)(478600001)(8936002)(38100700002)(38350700002)(83380400001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/oiH+aHcO07cjfeGgqIWFjoJB4Hf6dh/B0LscMUamPouFU6M25mZoOD7VxRy?=
 =?us-ascii?Q?drXkqBs9X6b4l1DQHwCQzS2lRIWjEWJ717YlL9n3d1KSA4TrUnaG7FEsvTvR?=
 =?us-ascii?Q?netKyeTNq+dltTGNbCoRD7XPdyN/qSBnA4MwPW1/+5UXlK13appAuuHiNcP0?=
 =?us-ascii?Q?HiWsKZbgyUxpqJz0pfFdYuN5NAAihJ5dSwwJ/DyP+zt1QWGo7Xjdx27FkkAo?=
 =?us-ascii?Q?K7RaExgz1SEbISz33Tccpuuh+xbo0mpxrk8Pu3zEapt47tt4tXQ0NEdph5JZ?=
 =?us-ascii?Q?fUCB5FNeGzJH0gBJlERir1siPgrLQpI7UfwTR6yXQryltPLvlnZgfuqxaIM6?=
 =?us-ascii?Q?XRCBlGCMoiG67NCbp2lma7NcwIL3dduOTA/XZX9xrJj0jNE1xOdRKHOSMP3q?=
 =?us-ascii?Q?Wj2m/y8pV98EKZChxw84+TqwyXBX+Uxr4J35XqedER6qwDSNSyjSBGRR8JrE?=
 =?us-ascii?Q?G4UQvp5bDj3/kV2xQDKzAEw3hJyt9eW0HEW2Wv4TQH2/anptCYgRGD9/VBMe?=
 =?us-ascii?Q?JTOympifnjV6ApKZKLazZ5JSkVmrY5tIPlkFJ28vJeVDIoUVATSeeQ7gdud0?=
 =?us-ascii?Q?9PR5cLOcjzI2BDkTk0daI6PuHU214Mkm6KKw+RrORC7vpCTbZdczBpJnxum4?=
 =?us-ascii?Q?sGxOBhEH+2Y/0L5mV/jWmMhtoHRCvPTGSTzkC3CdaE+2jVFahyUQYOVADmGk?=
 =?us-ascii?Q?Vihv+W4LcFaPxzwTPgwVvGIvdGosi7S9KWjVYcNxd3H+I9mfl0x1qNoUf+qj?=
 =?us-ascii?Q?WZZhlx/No4PjowXQDm+Uhk/yDYQPpouvjJJ5UMpu0zuv/HrtnsA+9rUFZV3N?=
 =?us-ascii?Q?mlZBCLS+HO0XQxL8XrBOdiTmN9XdZtj3iSEN4L2pUxYD283cOr1n+B/W1GA1?=
 =?us-ascii?Q?2SQzdxC0BSrQmQUhGhuJF4WMuRgouafYeiS822p0D63O8e5oid/itlF/xnR4?=
 =?us-ascii?Q?82LGUHLosJQigMRn5LJwalJJK7e/P8LZ4zI04RFlqqX3+AwTe+pFOW3UgXXM?=
 =?us-ascii?Q?CIwc8oenCjAi2Xsb1hPfs+1xgSmfV5AB2tCMazfCpv1HNeHKEkOs42HdOapq?=
 =?us-ascii?Q?H6lCLvuktBanEao/tuIzoiqSdAHkfmbIY05T53uZWCfLjBgZDz7HKRmLy/bX?=
 =?us-ascii?Q?ZjzhH5W9xYKwIAMvRFrppgXY+h0ck0DClQwxW7a/BlP8YbTdikllzM6e8oSV?=
 =?us-ascii?Q?1uuZ3p+mvEVoqLrqT0bNQZeIQSxv7F6K9KDRZJ3YphmAYoeqs46fVMdls1MV?=
 =?us-ascii?Q?62rJxRxyoQI8DjvcoD6NBhjFEK/prx690Om7+f3coGOkf1Zhij8vD+aTg9Ly?=
 =?us-ascii?Q?NZWJE8XbA+Aeiqq+uHDKwcVPwAGB2FlGrGkhWKypVKCWz34bsexl7L2kBPyU?=
 =?us-ascii?Q?OYcFVunM2eKqjpcgV3ftCUAhS+7RxugdvwqPXZpuThbAS/T678F2nxEoXDpt?=
 =?us-ascii?Q?BGqQeyaeHlXbuXAYyj0fXqUKVzK8hceMxLVei1+aJcyStIuA3NhQjBNpYcWg?=
 =?us-ascii?Q?PAsA+wf/XBCYFpNiJQC0imyirldqC3FSKvQz1bSOsnvYAvV3BD2PNcaXFnxO?=
 =?us-ascii?Q?u+rn4p0MJjBDUqlURw8Y4rMH+SlIlIyQMso+c907?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f017a1f1-6a98-411e-b8e7-08daef0640a1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:18:56.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/dVaYGpHpyzePPTM750rTohAIlNDfDGXgy187XbNzu+SaWDcp4B3cOBfjo1JNBXjSgA82y+SeJhxz7hva/Lzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7625
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add CPU thermal zone and attach it to the TMU which monitors the CPU
temperature.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6808321ed809..60306f3c5e7f 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/fsl,imx93-power.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "imx93-pinfunc.h"
 
@@ -116,6 +117,38 @@
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
+		};
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
@@ -280,6 +313,21 @@
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
 			};
+
+			tmu: tmu@44482000 {
+				compatible = "fsl,imx93-tmu";
+				reg = <0x44482000 0x1000>;
+				clocks = <&clk IMX93_CLK_TMC_GATE>;
+				little-endian;
+				fsl,tmu-calibration = <0x0000000e 0x800000da
+						       0x00000029 0x800000e9
+						       0x00000056 0x80000102
+						       0x000000a2 0x8000012a
+						       0x00000116 0x80000166
+						       0x00000195 0x800001a7
+						       0x000001b2 0x800001b6>;
+				#thermal-sensor-cells = <1>;
+			};
 		};
 
 		aips2: bus@42000000 {
-- 
2.17.1

