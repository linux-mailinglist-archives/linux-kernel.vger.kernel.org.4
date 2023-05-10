Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6126FE558
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjEJUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjEJUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:45:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A755FE7;
        Wed, 10 May 2023 13:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5ljG+92SEmLVobvlJCzP2Cw78C9GisS6a+j9efTNynvgOp++zkHcX+BgfjzAa3EPOQIZxp/p7yMqavbe/BqrzxAdZcqguCrWHq9KhZMOKxrUhGmqjlHBSHK/6g9LHF5QZPYGAVeZbAj2ihipd2LB80+uSCULIBmfzdYiOEEK94Y1OZib+DGfhaj7rXZBWcQTg9Z67hzxTd9skJg7LH4v3nrdfeXU25CJnZtcQ2QYnbgCN2diU8Z2E2E/xeyE0Z71u9rhhtQ1rRVjZJgfbvjPYjzyPBFdfyPrt1yUAUjumnYcLcmWQaLqHYskoF4cJHrXJja/x3s/Sd0L/j2irbJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2SlBv+ZS2kQ9A4sGjuXooFgp/rSAHT0FWImd8GrtxU=;
 b=lVF1AjtuLkPMcs6iNwXcaqP33M951Znkmtuvewb6rk8Se7wWQFHowka9uu+A3U4EbDtC1omy+CZ4Rr7DlFpA8hSWERK+1gyTP2QTvIyK7ideDW5UH6ydoW3gs4SUmsR/RZl2HgLo5t7RYHJ7gA5x/St+mH2kWr6+99gm9MvC115Y9KuUNxKYZRqVccdedCsYUxfh4bbyukqJ+nPRZouBL5UJ8J64LugLA6tdV45yslsOex/37ruWvr0Z6A4EGu287z9ivbww9lNlxTb++yWzb+VVonKBBdwBpyHdI3yHoaTlKXQrXyAKgAuekttUTSggAlmnFwHsxH5noUmAzku8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2SlBv+ZS2kQ9A4sGjuXooFgp/rSAHT0FWImd8GrtxU=;
 b=KOk/qpA7HgA24FqKxqi9YBURzjTVRvUFWI9Dj6gMXqPVR2Wug4yl4n5m83wxuqWtG9jtelQ/LHLGcSeQEW0ilBFLPSL/RC+0NNmmRN4haRjsTMfoTstMZu5tix5Hah8yVpd3wFviWQOyhK6iXoMbCiZ68mi+ix4LsCWQQtfWxeK/qB6AkhMHZsBDmUsaIp38dz/PEmAP+XWjCBZzyJeA6yKnt13drgS47nO67IFrMgAul0tRvoDUegbPPmir0slLMtlsFBdRYsxnsK6kkmPZAfsTFp2wflVnlpKCQnnoFdVR8jKU077yNIL5DJaoNh/FBW/3OOABf+9zhPGEXvQObg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6468.apcprd06.prod.outlook.com (2603:1096:400:459::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 20:45:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 20:45:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Wei Fu <wefu@redhat.com>,
        Yangtao Li <frank.li@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Icenowy Zheng <uwu@icenowy.me>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] riscv: dts: add initial T-HEAD light SoC device tree
Date:   Thu, 11 May 2023 04:44:53 +0800
Message-Id: <20230510204456.57202-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230510204456.57202-1-frank.li@vivo.com>
References: <20230510204456.57202-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 174ef5b2-f341-4b35-2baa-08db519772c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhGPLavaV3jC3xAPSofosZppsIqlZjyRrO36m/WSqMoZlSfPFxvyU4RCx23ZL9cp2IIQSM7Qudwk6lsyUV7EWDEdxOQ9g/XGVDLhq4xTckerls03ta3P5bXxgrYTXrgiHKn4pbv+wS+3IXF7J6AVhEHaNUOVWvdWB3HYunywQQZApEMraMDLORoGSjHytigNvkEiEgSp7qd5t4cyvAZyzFGGrV1UJmqOCIBlG1VmiZnLVXsEmt6gw8W0DsXWHB/o7a32MMLXSF+M9ur+STor6BNNsjIPN1+n/pRsrLs9AijB0YhZhNK8Gq/8lG1Iy+pUS8co+Fme8bBi/o28lYnesZrmIgRMixyq4TsqazfztQvG+jv9UzwDpMpCs7OS5gDQdd/KHVAusYKKfxdcRJ2Pbxlpk1ZQ0tPIxT5BdJZ9H28FdwviRgox9Jw+8Xb7g1wMFr+5QdueUDRRLBEURWsWkt1GVG2V20vo2aZdTtXL2lKcjLblRvrmO7/CjI1Td2HPur7IqmVBJEkON6rXAjNcQawnNMNWy/g80MjYfAR2VjH+38rY47E2iPjSCsxeLVeUh8ag9uG5t2i6fhV+Po8c5yUkzI3V0EKNWm6qxp3dkfEnlMWynctAMqn/+6Hvko0m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(6486002)(6666004)(316002)(83380400001)(66556008)(66946007)(478600001)(52116002)(4326008)(26005)(66476007)(6506007)(6512007)(110136005)(1076003)(186003)(2906002)(38350700002)(41300700001)(36756003)(86362001)(8936002)(8676002)(30864003)(7416002)(5660300002)(38100700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zk1hu51/Uzj2L+3iq0BAoWmKN27MVAUvD7duW1S97WNRJpPlUlV3B2lFzAic?=
 =?us-ascii?Q?Y4l+SG1/p1crJsaKmFz/iEKmZMklVu34bXQJKSRGH+pR7sWq9tX8b08lnFMP?=
 =?us-ascii?Q?bTLKzAkm3QGiR43ASF0sl0dhuvB3VvXA4dKQ0LdoZbDy5UiADF4M2A3Nsltd?=
 =?us-ascii?Q?J5IHtp8irE7Wt/tBTF6UCnkQAPjENAi6M5aJDtR55iY3Riz1jp0QzpU2u4hB?=
 =?us-ascii?Q?y8hQDHuF7GDhgkWRJniMxNFTHeY2rI9wPu2b8Et7qlsbNq1i+VoU8zRlmFjj?=
 =?us-ascii?Q?s7JAVB001DtIjfzgQwBulBgofModNsocZOezzwSeCNPZsiAQG6gioi4GYiP7?=
 =?us-ascii?Q?H5kzEVWMCPCOB3UlU0rzILBY9G12bkGWTs6NbXjz6k7JAFHGkeehK1UoO1I6?=
 =?us-ascii?Q?i6x/W45AINspjquVNsd1X3Iz4PGJpYsSJ3ladqoWkTYQrgXyVUBEPCGrADmK?=
 =?us-ascii?Q?E7uA56Nbvkzf5zojC6650ROOmP8dvhsf+jPUslZ3GbHy3z/HJe4v3BAenjpw?=
 =?us-ascii?Q?8vmp51vmRF9V+8oQWxuoFgccUFcDqjcaZK6BNgfcrG4CyCav08ZRnmWOm5C6?=
 =?us-ascii?Q?izCthPFxJyVavok1x5K9frxcUQcrySp3Cy7JUkUcDwIG0Agi/gC6QbTIU8Rg?=
 =?us-ascii?Q?bACswJVhsYyM5Kg66pAjIPKykU3vdiUcrM3XV9aN6JjNHz9A9ixaa71F/4bc?=
 =?us-ascii?Q?ymxR211o5g+9X+fBKg9B5p4MqsFn1vbE/ZDysQ4P31Wp61uPAMxx0YJEDdJ2?=
 =?us-ascii?Q?4AS61nXm2AcT84k2l1nJhvZBYdznNlSxP1uP3C1/l8rmBatwFlvBnRsvJF7b?=
 =?us-ascii?Q?D7piquIaffNZD4iAfa3rPDSScGiDQpR+bGv7VQ7YI1PbGG/8j1vGztetMHMw?=
 =?us-ascii?Q?5IZPj4B6NbnnS1HMHW87iFEFXkel1xrFxOAyrVHT3hsOwW2VGgb1uQ8kWIvj?=
 =?us-ascii?Q?T/k64JvNwR1PuqlnskZxZg1Nvykrp+geq8iB+qWbFkJRI5N2aBZHQ9zlWgrW?=
 =?us-ascii?Q?O0WLF83p/C1LzGCi+zmuG/uZUT6HtTybyNUhNeoenUJfedxfItrszvq8LRhS?=
 =?us-ascii?Q?2my4BXoedP8ODGhATi18Wafpqzf9Cyx4IcK7q6cK149WrEYPxfTen/njTfZ3?=
 =?us-ascii?Q?aFWedtGHUAmfR6GkIgkSdPtzrQ69yZf7NSHaiNO7LW7dWR/uI3YOoHk7oGvE?=
 =?us-ascii?Q?i29yvM6iPiA45/jYpPM0gN80H/E+fgGlkzqU6B7iAALL2bdp894xH1eWpCaq?=
 =?us-ascii?Q?t2Zb4TO/egRHyxnck6sPCmbLL/Pb0BpNpEncPWwaKGbdyC5oIv2WmxvOOawv?=
 =?us-ascii?Q?NvoSYaCazZScJv+UL1pJl/b8X7cRoLoqzo0YgRwiQjW+72SqutWDMn/Ela3g?=
 =?us-ascii?Q?gt6A92qFrpvds3BEckCegAOQEOOh3e5gCu30lRA+Gp7DiaO38NJ/oHJtaCpr?=
 =?us-ascii?Q?5jgVVWy4Rnw/OstU0pPeEaxw/eDOmoxrxN2ovKEm2hRsGefbXbMKRIGNSvHV?=
 =?us-ascii?Q?Q3LOjZ0KnvSb3KobN1S08t/Ht9m2dbJ3lQCT+CHBlzQLFWksr9UrTAzkdm7p?=
 =?us-ascii?Q?a2srp6/6vvvSJSDrQyeZ9BV+aNUa+dgpeJO+sFQC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174ef5b2-f341-4b35-2baa-08db519772c2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:45:11.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhbV2ucJouECzCp1UVLhSzBZRxsCBSpvn47x9C11DGwoQVuic6xB1pLsSqv+lOVwux2iZqLZWctjXHizu5c/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Add initial device tree for the TH1520 RISC-V SoC by
T-HEAD.

Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: Wei Fu <wefu@redhat.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-remove reset-sample
-convert to use thead,c900-plic
-add pvt node
-add thermal-zones
 arch/riscv/boot/dts/thead/th1520.dtsi | 491 ++++++++++++++++++++++++++
 1 file changed, 491 insertions(+)
 create mode 100644 arch/riscv/boot/dts/thead/th1520.dtsi

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
new file mode 100644
index 000000000000..d1d94098b6bf
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Yangtao Li <frank.li@vivo.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "thead,th1520";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <3000000>;
+
+		c910_0: cpu@0 {
+			compatible = "thead,c910", "riscv";
+			device_type = "cpu";
+			riscv,isa = "rv64imafdc";
+			reg = <0>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <512>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <512>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		c910_1: cpu@1 {
+			compatible = "thead,c910", "riscv";
+			device_type = "cpu";
+			riscv,isa = "rv64imafdc";
+			reg = <1>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <512>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <512>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		c910_2: cpu@2 {
+			compatible = "thead,c910", "riscv";
+			device_type = "cpu";
+			riscv,isa = "rv64imafdc";
+			reg = <2>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <512>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <512>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		c910_3: cpu@3 {
+			compatible = "thead,c910", "riscv";
+			device_type = "cpu";
+			riscv,isa = "rv64imafdc";
+			reg = <3>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <512>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <512>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&c910_0>;
+				};
+
+				core1 {
+					cpu = <&c910_1>;
+				};
+
+				core2 {
+					cpu = <&c910_2>;
+				};
+
+				core3 {
+					cpu = <&c910_3>;
+				};
+			};
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-size = <1048576>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
+	};
+
+	osc: oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "osc_24m";
+		#clock-cells = <0>;
+	};
+
+	osc_32k: 32k-oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "osc_32k";
+		#clock-cells = <0>;
+	};
+
+	apb_clk: apb-clk-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "apb_clk";
+		#clock-cells = <0>;
+	};
+
+	uart_sclk: uart-sclk-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "uart_sclk";
+		#clock-cells = <0>;
+	};
+
+	pvt_clk: pvt-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <73728000>;
+		clock-output-names = "pvt_clk";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		plic: interrupt-controller@ffd8000000 {
+			compatible = "thead,c900-plic";
+			reg = <0xff 0xd8000000 0x0 0x01000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu2_intc 9>,
+					      <&cpu3_intc 11>, <&cpu3_intc 9>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			riscv,ndev = <240>;
+
+		};
+
+		clint: timer@ffdc000000 {
+			compatible = "thead,c900-clint";
+			reg = <0xff 0xdc000000 0x0 0x00010000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>;
+		};
+
+		uart0: serial@ffe7014000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xe7014000 0x0 0x4000>;
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@ffe7f00000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xe7f00000 0x0 0x4000>;
+			interrupts = <37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@ffe7f04000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xe7f04000 0x0 0x4000>;
+			interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		gpio2: gpio@ffe7f34000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xe7f34000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio3: gpio@ffe7f38000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xe7f38000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portd: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <59 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio0: gpio@ffec005000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xec005000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <56 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio@ffec006000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xec006000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <57 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		uart2: serial@ffec010000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xec010000 0x0 0x4000>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		dmac0: dma-controller@ffefc00000 {
+			compatible = "snps,axi-dma-1.01a";
+			reg = <0xff 0xefc00000 0x0 0x1000>;
+			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb_clk>, <&apb_clk>;
+			clock-names = "core-clk", "cfgr-clk";
+			#dma-cells = <1>;
+			dma-channels = <4>;
+			snps,block-size = <65536 65536 65536 65536>;
+			snps,priority = <0 1 2 3>;
+			snps,dma-masters = <1>;
+			snps,data-width = <4>;
+			snps,axi-max-burst-len = <16>;
+			status = "disabled";
+		};
+
+		timer0: timer@ffefc32000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xefc32000 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer1: timer@ffefc32014 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xefc32014 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer2: timer@ffefc32028 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xefc32028 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer3: timer@ffefc3203c {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xefc3203c 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart4: serial@fff7f08000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xf7f08000 0x0 0x4000>;
+			interrupts = <40 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart5: serial@fff7f0c000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xf7f0c000 0x0 0x4000>;
+			interrupts = <41 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		timer4: timer@ffffc33000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xffc33000 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer5: timer@ffffc33014 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xffc33014 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer6: timer@ffffc33028 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xffc33028 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer7: timer@ffffc3303c {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xffc3303c 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		ao_gpio0: gpio@fffff41000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xfff41000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porte: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <76 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		pvt: pvt@fffff4e000 {
+			compatible = "moortec,mr75203";
+			reg = <0xff 0xfff4e000 0x0 0x80>,
+			      <0xff 0xfff4e080 0x0 0x100>,
+			      <0xff 0xfff4e180 0x0 0x680>,
+			      <0xff 0xfff4e800 0x0 0x600>;
+			reg-names = "common", "ts", "pd", "vm";
+			clocks = <&pvt_clk>;
+			/* TODO: add reset */
+			#thermal-sensor-cells = <1>;
+			status = "disabled";
+		};
+
+		ao_gpio1: gpio@fffff52000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xfff52000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portf: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&pvt 0>;
+
+			trips {
+				trip0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
-- 
2.34.1

