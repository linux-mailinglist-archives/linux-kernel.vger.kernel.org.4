Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17E67030DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbjEOPDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbjEOPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:02:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18B12701;
        Mon, 15 May 2023 08:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dma6LYDVHYGJ2OPpk+vQ8kr+BH83axBXUhJtScDFgnZf3zzgmIslYDYO3jZPG8jxFU+8SM8k4mXGKvIZqUJMRIDgfdrdKhg34pBZCXHzBeLfGik8uMlNiliePulWw2GKuTl4xWoM/YZGJBx/N0JD1KrXGxJHTyniPnPnWb+6nHJgpGBLrFj8clEtdzXYiu6ROV3pOzSJXmzC8Z0ohYh0+TNXlGH+4ccnq50kFiQyzEDAF7wwJpDgV0vIEh8NOpYc6gVsI2ho2sp+29L+WHJX63TAqIplsjKFbLH1DPFfYHhIFyrI6tuTnoXKOWsvwfPplzD5JOnbmRB9iC10g5CDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxkVKHgf85H/BN3wEbmJPmZ872HDJ6SOkj1qjYztVe8=;
 b=TIlHkBOIXrXK1d/uBS9RitgsYI4xEgUT1cLwsQzYtTSQfUwKnRZ6bmtcU6v9LHI8I0V9Q1+iER15XN6Wo3v6P6N2he8s/KvyP+v/S99fHbfE7tZFdh/Y/Y22yn/wu7UslRyN2kCGaE/iaLPsMHTQhj43M6yU8NbQd1pcHRmslyPNGYJNXG3VrTw2xHkwxQWuUXqvfxNucUCqR0pva91kkGiAbDyU4H2cMST7WB1IYYHqoxFc10F9dHHDTrZi0EtUMNREZrKe7y2JoIEg02mBmVCMUEfdTpoLU+Cmeu3MX0Ofwf0d2QV1bAfoEpMPxCvI1g1kxUIHSgskZuJnh61Wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxkVKHgf85H/BN3wEbmJPmZ872HDJ6SOkj1qjYztVe8=;
 b=Vva+hp+EkBU/c63LXwjw6X9cuYDXRmN4lfjAt4FkRKKbkRLXsm7nwO7HilUXL4A4hMMKNX2xfWB9131HPAwDf69eeQc8aMgHRXzllsl6Dh94nYKyoHA/P+oD/bRyCYoq/CH3kVWtV+0iFqsYDp2gca5i6SPtD3aP2j+2iNcod/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB7011.eurprd04.prod.outlook.com (2603:10a6:208:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:02:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:02:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v2 1/1] arm64: dts: imx8mp: Add coresight trace components
Date:   Mon, 15 May 2023 11:01:49 -0400
Message-Id: <20230515150149.2790189-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM0PR04MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bb8369-55b5-4d4c-6ef2-08db555559d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5l6wheQHzEzSN/j0t8Sq4YXWe+CIXRZ73ySWEB+bxKdDnxF+0xL8XuUfEV4ZLKIrLBtwLMr1x5/NTswS4xLCS7hKFdT6fTy2fvYWpyzeNFFQHmkxghnmTfTC/i0CtyhR0+y/FAHbeZAl7Gcz0bAYFqnxuWj7BSSo3Szo81Jl9DqcP4nY2cy4sfS5JxgokY0ovSBsLaEP3QZwzWySB/oRmiS8aWcrtX3iANxpVGrEbasCAV8gVTMn5S4HenafDG9q+2TJdPoCGi7CMNkH0SvUs5mj0jmQhPt0xWUPOnA7W1fuHTNEmCPD33skXcaJgibYvQc9DdHeB6Z3szeRAkTD9PktxNo/qvg0V9PBLrFCjVCCF6F+13GZymr8lpl02nYP19vCsSGhwPNNna/z7fnHo6mEZUvazC4hHI1lfJF+V17UujAN0Puw4R3QACLnuGroGu+tHFzwjHNjbJtVL963d4fJUrty1aLPvL00t3wZiG1HXhmD4XI8NSoHEM+2HOXwm/mSFUPN4jVdmSpjFipj9GaFagge3yYNG9N2yoJIaD+nHsq7gwvB4Jq/WpnQgvVLM2tO4yRNDaC4Oj2DKwpX8IA+DVo42j+onjBLhbucSnT6BQYv8B4euSC/nc/sEOFEChIxTFRm+zjDSx29u4r/TbH1LIdKFwOcqiPOkmDL1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(66556008)(110136005)(478600001)(4326008)(66476007)(66946007)(6666004)(52116002)(316002)(6486002)(8936002)(2906002)(8676002)(41300700001)(7416002)(5660300002)(26005)(1076003)(921005)(86362001)(38100700002)(38350700002)(2616005)(83380400001)(6512007)(186003)(6506007)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2tqbnkxZ3Nua2w3YVZ1VXBJYk04M0RiakViQzJUS3p5SlNhYi9OMUFJSmo1?=
 =?utf-8?B?TVBFOStZZi9OOFBNWnp1d1lSWks3RWpMdGQwT2ZMckJoa1J0NG0vNFVvaXJq?=
 =?utf-8?B?YjZzc0xCdFV6dVdrbUdyRTNMU2ptOURoWGcrU1dJV2piVkZqVnJIRmY0OHhB?=
 =?utf-8?B?S0FOTVRDTzQyMFR2cHpLdG9BUjNENW92azBZMkoyTVZFMWhoQUF1N0dZOUNT?=
 =?utf-8?B?WjdsaWpRVGNLSnRUUzIwVkdDRUQ2WkMzRkVpRzk1dGpCWFdoOTA5WXNlUUdq?=
 =?utf-8?B?WDFwV2Q2NFE1ZnVmaURXTEJ1ZVpXSUhaY3VmdmY1NndZdUtYYVR6NmhvUjZR?=
 =?utf-8?B?L1BHaGpmRWQvdStSVWJsOUVWYm5tMVA0QkVrWVJYVGNtSlo4emk2OWE2MWJq?=
 =?utf-8?B?alFDSzdwTGUvTnBEd3Vic0xYZUlPTGdOc1VQT3FMK2FGWkpFS2xFa3JGejl4?=
 =?utf-8?B?ZVRUZ0Evb0xKWUdzeEhJWDVVRW1zMFZWOHBhNndWakN0UlJseGJteDV5WUF6?=
 =?utf-8?B?bWJyM3pZQTZFMVR1R1pOSGFxSXVYSWlmWmo0ejlNdzJrWks2SjlWMmtjRDJD?=
 =?utf-8?B?czB6bzZ0NnQxdWFNeEd2YnJvSHNlZHE0b3NYMC9YNFNZU0Qwb0pzRmJzOWdW?=
 =?utf-8?B?aUk0amVyd0tZT2daNEpMSWVhWHVjMTdmcDR3L1paUVE2dXdtNmgzMHVzeTZV?=
 =?utf-8?B?ZTNmRE9NZ0hXSlRUdTl4aUtYUDFSOG5oYWliZjFYamFIS3ZqU2c2eUdSSFFr?=
 =?utf-8?B?SjVQQ1NOQWpvdjM0aTQ4eGVhUktZd3pYcnBtTlRUU3pLTEFLQ3doVnB3Mnhr?=
 =?utf-8?B?RWxXdVU4bzR3eElZdzNhL2hkRm0vbTVQRXhBL3l4OUNnaWV0TmM3eWFNdFB0?=
 =?utf-8?B?OGNmdjJBOFB5WUdFdDFrZnE4Tml6aFpnR2VjOHhCemwzVVlPNktiNHYzcXhJ?=
 =?utf-8?B?WEgwVWpmaGNBMGJOSUlSeEE5VlFkREIvSjRFVS9ZUDZGenNENHpKUkllTzZh?=
 =?utf-8?B?TFovMmNCRnllQU4zRkhtQ1BLL1NuR3ZwUnVPd2NJaDJmU0xuOVNZaUdhMGhU?=
 =?utf-8?B?TzNZU0djcFRGc0kwVHkyLzNtcUN3dHdVWFExR2YzZnVYWUF1ZmhMU2ZhTTkx?=
 =?utf-8?B?RFFwVWhWVGxhYkt6WE5CSDFvVGM4QTV1M1VuT2IyNGdSbm5ERHYwYVArSHBa?=
 =?utf-8?B?eCt2TzhLODNhU3orb1RjV0NUM3pDeW9NT08xbEp5UkFISVN1V3RHRVo5QVBR?=
 =?utf-8?B?YU9Wc0NzSXh1YnBKWTNkVWdNVlV0dGI4c3RLYWx4bXpwdTZ3U0xHeHZ1RGJx?=
 =?utf-8?B?cmM3cHZReURpRXl0N21wTW5obTMrNzdqRFVSejNuSE5LdXIwVlBwYmtHMjdJ?=
 =?utf-8?B?RUNXbUV2SThzU0RnSUhrR2tlNUxIYjhNU2s3Rks4c1dZNEpldEc4cWxzaVhR?=
 =?utf-8?B?ZjlzU3RmMXpXVFhzcDI1QmE4UUcwYzYyUnp1amJkNXBXWm56VU5RWVJ6RHZU?=
 =?utf-8?B?UmloRDE3R1hXK3grQ1orQjBac3krUEc4cGN5YmFmUElMaXVBaEhzT2s3NVZH?=
 =?utf-8?B?Z0JnRFZra2xaZDFEc1diMHF0TWx5YThDZUxlWCtxUnFUNFpzWFNoOUdOcmJM?=
 =?utf-8?B?TGxWT2lLWUZzS1d5YlFCUWFGR2QwOGppekVXTmtveUVsZkdsN29TS3NQRUMz?=
 =?utf-8?B?QW5wQ1pZT01ETGI4cUZCRzUvRExPZTJLR3dXWjR3YUhQMHJKT1FISDBMOXhH?=
 =?utf-8?B?bDFlUVpTNUtUZ3dYZFBIL3hIZ3IzK2lab0ZSTkQvVHNnNXBld1ZCeHZVY2V3?=
 =?utf-8?B?c0h2RkgrOXRaOFJFOUxLc25MRDJZQ21PYUhPUEVreDZ3ZXE3Z2JzWWl5MElj?=
 =?utf-8?B?dWVyZXNVMXBtMEdVbVJUMk5XVHMwTGdVV1BLT2dWOU4yeVVJaGgvbjR1YW1s?=
 =?utf-8?B?OVlDK3JVMk9zanZNL3d6aHc2N3RIbk1yZm1EdnptVGlnY1ZWTTlWamNhejVo?=
 =?utf-8?B?WFdITTJpSnZFQm1BRWE0dVRlY2lweEUzcFN3RlY3ZHlDT1FNZ2ZOQTBSYzNm?=
 =?utf-8?B?TUV2a2o3eDVMOUhLVkZ5S29jazZBaGM2a3hiQm1EYXpLZDJrWlMzVUN4eW4v?=
 =?utf-8?Q?nijwSYiQ8IN9iT1Wbs+1Y2jud?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bb8369-55b5-4d4c-6ef2-08db555559d5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:02:07.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cULbR/ewSfr+aHrPkjqRegqTZywo3ud9i6vpp1VAJTVeX4mLAJkxpQ8oren/7rBuCpPYHHsjinSbmJgXu/9W2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coresight trace components (ETM, ETF, ETB and Funnel).

┌───────┐  ┌───────┐  ┌───────┐
│ CPU0  ├─►│ ETM0  ├─►│       │
└───────┘  └───────┘  │       │
                      │       │
┌───────┐  ┌───────┐  │  ATP  │
│ CPU1  ├─►│ ETM1  ├─►│       │
└───────┘  └───────┘  │       │
                      │ FUNNEL│
┌───────┐  ┌───────┐  │       │
│ CPU2  ├─►│ ETM2  ├─►│       │
└───────┘  └───────┘  │       │   ┌─────┐  ┌─────┐
                      │       │   │     │  │     │
┌───────┐  ┌───────┐  │       │   │ M7  │  │ DSP │
│ CPU3  ├─►│ ETM3  ├─►│       │   │     │  │     │
└───────┘  └───────┘  └───┬───┘   └──┬──┘  └──┬──┘               AXI
                          │          │        │                   ▲
                          ▼          ▼        ▼                   │
                      ┌───────────────────────────┐   ┌─────┐   ┌─┴──┐
                      │          ATP FUNNEL       ├──►│ETF  ├─► │ETR │
                      └───────────────────────────┘   └─────┘   └────┘

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- add new line between nodes
- add new line between properties and child node

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 204 ++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index a19224fe1a6a..1a25710c3a90 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -304,6 +304,210 @@ soc: soc@0 {
 		nvmem-cells = <&imx8mp_uid>;
 		nvmem-cell-names = "soc_unique_id";
 
+		etm0: etm@28440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28440000 0x10000>;
+			arm,primecell-periphid = <0xbb95d>;
+			cpu = <&A53_0>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm0_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port0>;
+					};
+				};
+			};
+		};
+
+		etm1: etm@28540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28540000 0x10000>;
+			arm,primecell-periphid = <0xbb95d>;
+			cpu = <&A53_1>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm1_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port1>;
+					};
+				};
+			};
+		};
+
+		etm2: etm@28640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28640000 0x10000>;
+			arm,primecell-periphid = <0xbb95d>;
+			cpu = <&A53_2>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm2_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port2>;
+					};
+				};
+			};
+		};
+
+		etm3: etm@28740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28740000 0x10000>;
+			arm,primecell-periphid = <0xbb95d>;
+			cpu = <&A53_3>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm3_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port3>;
+					};
+				};
+			};
+		};
+
+		funnel {
+			/*
+			 * non-configurable funnel don't show up on the AMBA
+			 * bus.  As such no need to add "arm,primecell".
+			 */
+			compatible = "arm,coresight-static-funnel";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ca_funnel_in_port0: endpoint {
+						remote-endpoint = <&etm0_out_port>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ca_funnel_in_port1: endpoint {
+						remote-endpoint = <&etm1_out_port>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					ca_funnel_in_port2: endpoint {
+						remote-endpoint = <&etm2_out_port>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+
+					ca_funnel_in_port3: endpoint {
+						remote-endpoint = <&etm3_out_port>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ca_funnel_out_port0: endpoint {
+						remote-endpoint = <&hugo_funnel_in_port0>;
+					};
+				};
+			};
+		};
+
+		funnel@28c03000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x28c03000 0x1000>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					hugo_funnel_in_port0: endpoint {
+						remote-endpoint = <&ca_funnel_out_port0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					hugo_funnel_in_port1: endpoint {
+					/* M7 input */
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					hugo_funnel_in_port2: endpoint {
+					/* DSP input */
+					};
+				};
+				/* the other input ports are not connect to anything */
+			};
+
+			out-ports {
+				port {
+					hugo_funnel_out_port0: endpoint {
+						remote-endpoint = <&etf_in_port>;
+					};
+				};
+			};
+		};
+
+		etf@28c04000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x28c04000 0x1000>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etf_in_port: endpoint {
+						remote-endpoint = <&hugo_funnel_out_port0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out_port: endpoint {
+						remote-endpoint = <&etr_in_port>;
+					};
+				};
+			};
+		};
+
+		etr@28c06000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x28c06000 0x1000>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etr_in_port: endpoint {
+						remote-endpoint = <&etf_out_port>;
+					};
+				};
+			};
+		};
+
 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x30000000 0x400000>;
-- 
2.34.1

