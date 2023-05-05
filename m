Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9109C6F89E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjEETwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjEETwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:52:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4410C;
        Fri,  5 May 2023 12:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCMxjodfGyRCk4H+VdjXUR7m2iM03q2FkSpIFudz3oGnE0P9WJUg5SDDsJHOPjCLP+p/kNuTfiP7e/QqcOpVfY7Xm1KcmZc2BofmXxUevmoKR/G8xTiqDEJVDLD62pLAY5IsWFqAJARQD0vCQiM4jpuwY+AX12AsJLZqIJ1PQCgi140ehv5IDYNWPFa6MVzXLhL4yt/ALTRICs5d2N/5Gus2+JIA7BM3hFDUjkLI+mdyHiWqNgG1vEULytMRrfxHIqYBXH3/q2dJLbEYp7Hq1gaJkMfliMv+7lrEniU3G4SVoPYyn9YF7HZWkDE6L0rZ11U97SPAx3mdC5ZK3S5a1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4fd8x/WhVIrrd3/gXm+Ni9fXq8/3YZkDIR++hh2lMA=;
 b=dqws/cG99UL6ct4fxjbfghzshuRluxwaf8n0SG8LgsIhJEqUTl2TJy2vSX2mou91nEDlrIgcUx/BdiT6E0+7FDAW/5IHL3Uyb8WIH1XCcZTnIdua8sKbW40WzUkplX04M2cyr7RzPom9isAoVMShJe+sWuVshET7P1iW4QGOkXkPBC0DNisLgc8Ej6zKbf3HlTnD6m3OBy6bkNUJWhn/+CmfZ5KIkEmeI98Y3UxhDRXRzRZ1KQPiPBqicT1eNnLu62XrSRX1Fa6Jyk8GtmLV0EdwkNJki2d6i/x5w5N5Sos8A2whZ8D06FYkAsoLXn0RsVPuUeu8so/jKykvPLW4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4fd8x/WhVIrrd3/gXm+Ni9fXq8/3YZkDIR++hh2lMA=;
 b=b2OC2xiCwwgdBzLzN8sddHiwPKAx0KTxuxd3AC8UJ97qbGytt4tWKRj+1k7/jazZOrX1ikZyTi7qILMc7nGKpcQurmfX2rRsCWQdB1JPHlgb5xbl9It+Qlms7NbUpASPVhh//wGQ0The4cIwpeafMITD7CImD1BTWRcYc5t515M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7548.eurprd04.prod.outlook.com (2603:10a6:10:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 19:52:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 19:52:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
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
Cc:     coresight@lists.linaro.org
Subject: [PATCH 1/1] arm64: dts: imx8mp: Add coresight trace components
Date:   Fri,  5 May 2023 15:51:51 -0400
Message-Id: <20230505195151.1874071-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: be6bad67-f454-45ba-8623-08db4da23858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zI3+DdY3hXXN5dcjsea0lMhewCkXNkAxp31n9Ep/l7DtQ6BiGbUdon9I0vKJaDaQfISG4YXaz99nlNvxpxsu52LZ59brsla9WIey/7zn2sCeJuaO9ydTOd1QFdhsdPZzjF7Ex49BPD+LQTJ1ejoXoEtbHmWDWrj/28alZJc6CQrFYZu8GWo93sVQAv0m2DMJysIA3AgOJv8f1Y8+RiQgA5HaY4BcBESC4XiHz8iTP5Tm7EhS/Phr33zBAJWdUkbvi72ufXMp8SvK/joMtyxEe/mqzpUSxy8xVtJbEQxWhm4bi9iizdFPQkXzG3/Wxf9BeRCM10DJuIrYHAbZbxFdWH4EqEqULDe4hdMijdpoZHxrqv9S8wDAsmGe8y8R9I9M3cM0J5+rUE2k9B4wTnICQmtqUqAIgZVNjyMc8GO+DIIgWvhipj0yniAnigaeL3bNqZrCgr0cS2TsDBoi7RXLCGi0cX4BFjvzwdGVaj/4M5smFP8DCPIUyt7SYXtTBqqHCSaKjE50NY2/9AT+8zLa8UWfvWlrLiq3WdcZjaiVMk2p4MqJhuNAjpRByyqj2N6OrVymoBztMpRMN9/HPucyeFO41oHui9ZFNXqvQ8pY91PyHsR+dBvQN58OafxSKCN8/+6VWQz4SpbQrmIT+gqKCr7ToVidlZdk8Jr50aULUUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(2616005)(83380400001)(4326008)(41300700001)(38100700002)(921005)(8936002)(316002)(38350700002)(6506007)(1076003)(66946007)(478600001)(52116002)(66476007)(66556008)(8676002)(6512007)(26005)(6486002)(7416002)(86362001)(110136005)(186003)(5660300002)(6666004)(36756003)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdDQUVUcSt6MVl2SnhjcGNJTVZsZnowWGVOcGY0KzYwdHdZejRwWEd3R0lw?=
 =?utf-8?B?NnZyU3lQWkZYdSsySnpBSlJJcG1FZ0lLQVN6a3JMVk1mZXVyUnR4Nk5IUEdm?=
 =?utf-8?B?QUJ3Qnc0MGlBd0tSM2ovZTVuM0tDT1A5RU1WdkYwOTIvb09WR3NlQjBLMERm?=
 =?utf-8?B?LzYxekZZaFJFa3A1aGdUNDlXZEhnbXFTRUdyT1JNZktvYmZiZlZCNkREQ2c4?=
 =?utf-8?B?ZndrWDVxcWlWemZoR1FnVVFaQVVmNjYvaUF5YW9Xc284bHB1Z1gvajNQRVpJ?=
 =?utf-8?B?NjNIVlVsSzZkMUVuTnJZNkVPRzRHNE44M1lnbk0zVWJvVThLZzB2L1IrU0NT?=
 =?utf-8?B?UjVZYTFiY1haeENtdDFkRTE4dUVSVXVMMXVkZU5aNXZiQjRoYUpoVjgwTUlB?=
 =?utf-8?B?a2I3Zis4M3lBUE1sdUhtTGdIbmRsSU5pRzY0bzFoU09jVWcrZFFLb2RxNFJM?=
 =?utf-8?B?eGV2UFNwRk9EQmpnd0FlaXI3aVVCcUV1OE1FdzBnbnoxK2hrY1hQK1AzMGZk?=
 =?utf-8?B?Z25hNzRvdDNwK2tZV2VtOTFtUEhDZnZwMXRhSzI2U0xhakpWY0EvLyt0MFc5?=
 =?utf-8?B?TDY0ODFROWE5OXM5T3dJUWlZY1YxSy9UWkFsOC84eE55dU1JMFNxNHlWVnRo?=
 =?utf-8?B?Zzk2UWZ6WkpHOFp6K2dla3gwYzhsNGNKQ0c3c3ZnakQzQitUMW4zRUtDbmN3?=
 =?utf-8?B?bDM4ejlYakdRZmpBN2M3OGpaV3VuallNd3U1b0ZCeEZBam9PTXVXYU5rcTNO?=
 =?utf-8?B?a1ZiZG90RWN2ZzM5WSt0Njl0cHlKNUhVSGFrcFozTHpxcDVNK25pdGNlUDZY?=
 =?utf-8?B?WVFteXQ3SUZvd0ljUEEyczRTV0pvbjB6K3NMdWhkeGZFenNtZ3ZTMHpiMHlo?=
 =?utf-8?B?RXBoYnh0dlYvRmxXa3FwUXlDWENXUXF6c05hWDd1c09HWk4xRTZjdmJmbkI0?=
 =?utf-8?B?dEJsay93ZUFhNjZRQlVRb1ZtUmlHQTh2Tm9qOWpjdmJua2RRM3IxaWJ5OVBU?=
 =?utf-8?B?SEpBYkN3Y0hBSlBlNWdUV3k1OUhyVXh1Q0xGMGp2T3h5djNhdVVYbU91KzVG?=
 =?utf-8?B?OWc0eXRsUGFndkVVcE5USDJMNm5jQXJFRlJrK0k0UkdJdmhZalk2YitxckNP?=
 =?utf-8?B?UDh2Z01hZEUrSGFicDN0SWMzVms1NVJBcnJqWFhkT2x0UGV5TE10TTExWFFn?=
 =?utf-8?B?VC9vcGN2Qkl5UU9BSXZKYUxnKzVBZ2tvanphN1NMTmpxbjZLdEVHYndQVmth?=
 =?utf-8?B?VjNnaUcwdzA1TWpGZC9ST1pwdmZhZU41UmUrNGtKSFc2RlJtM1dFRXQ5bnND?=
 =?utf-8?B?Q2RIL2hkaGw4a3kwV3FTZUt3aHh3d2paczhmanYwR1k4cjN5M2p3M2FaMmlG?=
 =?utf-8?B?Q1dYK0dqdFBXV3JzeHp0eHNUeHd3b2s5K3dRbGxrQkpVZWtJSzh3cHFDZVds?=
 =?utf-8?B?SEk0NlI3RFg1cUwyZnZqOXNQNlhlVVgzZU0weGpFSjcyVFR3b3BINDNIVVRi?=
 =?utf-8?B?Q3cxY1MxRVJ6UFNWemRLSWxiT2hxd1dCVGtNNzZRVW5RdXJTTUdsTE04SzNr?=
 =?utf-8?B?Z3FROVlaMXlPR2ExdThQUlVZRXlYMjVvWjdOWUlXemhqTmVjSURXUW1wNXhq?=
 =?utf-8?B?M3FuNTRpbDdCbWNXWnU3VGZSeDhRaU95MWtKcitZZk1uYWZxWUZYcWpRZlE0?=
 =?utf-8?B?UEpMK0xwa0RKSmJiRlBFY0tEMFJUSCtMbm1qMzlISlF0YUIxbHBUYUIxMkVu?=
 =?utf-8?B?QzN1YnBid094eFA5eHdaQysyTDJ1Rk1YVnI2N243a2t0cXl6SUU2bmoxUkNQ?=
 =?utf-8?B?bnVKaUxpdzdRZGtvWG1Fa21pTDRqaGM2cmRNYVhXaG1ZV0JsUDJmYXg0dHVi?=
 =?utf-8?B?VytYRDBaT2hpYnZJSTJQbTNRZVFVdGUzU000THFEdUFMREJ1QUFOYjMzUW93?=
 =?utf-8?B?ckdsNGZIY1AvR1VPMnhNVHhUSXU0MVU1V3VsamsxWGtXT0JjWnYrb0E1Tm5s?=
 =?utf-8?B?YVJDYllDcy80MGl2d1A0eWJvM280VmxkdXUzN0JGR25vSUdaSmFYVzFqZUFP?=
 =?utf-8?B?OEQvUUs4eVlyU0ZGUGx6TzV5QUdPR2lRU2s3WGh6OUIyblZOVE9FaTNOUDhp?=
 =?utf-8?Q?u5u4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6bad67-f454-45ba-8623-08db4da23858
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 19:52:13.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6vPiv/KwKObnYRyIuoCelwLDRFbTyEd9x00dD5FmNFd1tBBECjmLPUxTxrzb5dgdcom9n2hE/8kM3anu8aBzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7548
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
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 179 ++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index a19224fe1a6a..0fa74477b9e1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -304,6 +304,185 @@ soc: soc@0 {
 		nvmem-cells = <&imx8mp_uid>;
 		nvmem-cell-names = "soc_unique_id";
 
+		etm0: etm@28440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28440000 0x10000>;
+			arm,primecell-periphid = <0xbb95d>;
+			cpu = <&A53_0>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
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
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					ca_funnel_in_port0: endpoint {
+						remote-endpoint = <&etm0_out_port>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+					ca_funnel_in_port1: endpoint {
+						remote-endpoint = <&etm1_out_port>;
+					};
+				};
+				port@2 {
+					reg = <2>;
+					ca_funnel_in_port2: endpoint {
+						remote-endpoint = <&etm2_out_port>;
+					};
+				};
+				port@3 {
+					reg = <3>;
+					ca_funnel_in_port3: endpoint {
+						remote-endpoint = <&etm3_out_port>;
+					};
+				};
+			};
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
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					hugo_funnel_in_port0: endpoint {
+						remote-endpoint = <&ca_funnel_out_port0>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+					hugo_funnel_in_port1: endpoint {
+					/* M7 input */
+					};
+				};
+				port@2 {
+					reg = <2>;
+					hugo_funnel_in_port2: endpoint {
+					/* DSP input */
+					};
+				};
+				/* the other input ports are not connect to anything */
+			};
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
+			in-ports {
+				port {
+					etf_in_port: endpoint {
+						remote-endpoint = <&hugo_funnel_out_port0>;
+					};
+				};
+			};
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

