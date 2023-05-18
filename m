Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4499F707C90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjERJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjERJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:15:27 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2E1FE6;
        Thu, 18 May 2023 02:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYuiDhqNC/Q6Mf8TBMfWL9vuLdA4ZtFtDZXHpMs4tvVD3jkYpvni+9PAZhAByVqWw7noiR8/NtR+MzPguCBI/HIa3bSCwUqe8YCSzPOy+1y3Dj40B1ygkDOryF7guMVg1y7Hj9NDkptmfqNqLMD/loaoaArwKoYYddhuuYJQBP4N9X4FGcocbcl/dAwnyY4JZRqOJKd2Q6AEPtCEfEMmlyyY20vu+dRSvMCeylLoYg1b5t2Zg2b3lNmWn+tl4Y9nnAErz1mvi8kXlSs/ZuhduWcnRmOvRpxxP0/q70RsiLeaNSs5EVc3m1vKZeSNrLFu/Qs46AgPl1lF7lXVZd5uQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvZk4Q8qSmIhW169OxPOfHQGwq1Ba70JWyp8FJeaOF8=;
 b=By5x23DoMQ/Q9twGo192IqvWsEr5py1LmqlrN2aCzCmPOLEzu05L+e4/IkCAqIJ/fcYAottkuq5tn+bDFOPSEdGreG71pe0JnVCDOiP3aBYKc+iJyTPdYZpWifv2/vrykPd4dS1QK42wOTf1MReVmPmheQf/pohrO1cbgxI4HO4hSvGXlWFZrnHFHAQVMjH0deUBrb4qRDt00q64PN0P9A2WyTrS4vq2P7FdEZmjFHyGNH+9bCMVxCpW/Dl/tXx8bLA6+fqxqm0azCenZoxbP7iNPWuI1EZDa9YF71aBAZolS7jRx2Wjq9OirGMC/1sPBzHO1oiziJ9I1eUb5dIpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvZk4Q8qSmIhW169OxPOfHQGwq1Ba70JWyp8FJeaOF8=;
 b=iZh8oRS7Dd9p8MNM1iy9Ys3uE50W4Sj3ivunVhS+5jg4U8mDHwE9sn6yM5e/A3Wfcz8uzEdVIoqSqb1qKjm+rYZk8l2zm4mB+COjglo3EYCl8ic+vlI1doem1/754nZKgKJNdNc3FiWroln36gJwupNPmlukvL1KmujvueS5wdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by OSZPR01MB8082.jpnprd01.prod.outlook.com (2603:1096:604:167::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 09:15:22 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 09:15:22 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     krzysztof.kozlowski+dt@linaro.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH] ASoC: dt-bindings: dialog,da7219: convert to dtschema
Date:   Thu, 18 May 2023 09:14:49 +0000
Message-Id: <20230518091449.17984-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:1::19) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|OSZPR01MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd08dc1-72c5-4084-4338-08db578067ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLBjlb+rM9PGMdQQdMb28U2l+78DLR8FU3GCluYooG9BB+e7+R9GfjLDbX8qtPWuUKLVCqpS/PAUl5Ewk3ACHtYfoB0AaaVSu+IEVAKWPcYRHFPvxBIPpvogVGImeJealAe6wP5Vz2BxJTKt99ZwooVabmDWHfuM5Pri2jhrZV7K8oBqDbMfo0Te0+4L5E9g1sIDl1DdxqcUVs++NDjfEmzoF2596z0X9W5rRfLoc8AvuwwWNOLgwLOr+JMC1kx1EpQFixebzfj83Ir/ezolUbOAKpoTa3iDit9FiWbK4LV1ojzX3P1QNntuQ8yBY0lv2RP9fEjxW9eNtDOUDuygW4OPgRLaiTtm9vTfYgbVad/ZBevAhxKoqtjLAgFK0g17klZGMnq+ULIW+lNZZpTKmHtAFHzi1IJAPE/KUcWMDao+7Z93KZix8qDtT64Zk+Qy61gnvMJ0Gnd2TZzuXTc3U3/elsUii56TV9EAtT+NJV10fWZlQXZP72nTxmPgfd0JdM4ROpbMkUM9rvr9MT/I8PcizuIhzCx1VB9+CkJhp5kw3XzjsnkdONt5h9TXsWDYAjjgQJw77xqJE061bF4BQbLfSiEQNKXdKUjAKdWxPlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(186003)(26005)(6506007)(6512007)(1076003)(966005)(6486002)(52116002)(6666004)(2616005)(83380400001)(86362001)(40140700001)(38350700002)(38100700002)(103116003)(107886003)(478600001)(30864003)(316002)(5660300002)(4326008)(41300700001)(66556008)(66476007)(66946007)(8936002)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y4q4LHB5jHmqdIJZVryrGrkp87eLIBgDHc7mcqnyrSf1b2nXRqDOPTLizM5h?=
 =?us-ascii?Q?YBeTECggaIjlEs50pnXm9+UYW+pHLgaUoxubTmcvHs98VQxwTDMNvMdZxnqR?=
 =?us-ascii?Q?nKTLyu7emIVzVEW3cCqeEQHVb2GvQpnwzoLdmUHLA37jNlSda93BEN2p5nZR?=
 =?us-ascii?Q?P3w7yoW8pXlPdEAF+IKCWgRmCvnlxLrC/hFfFFDfDbaupl96sUme7u+n/IFo?=
 =?us-ascii?Q?XMyqOIBKzFeCOquskLTklaBT12Q/7jOnnFrG16WP6PzrcUYnDuxxYal9YlU/?=
 =?us-ascii?Q?DOoSQhXs4tcEZn9PTLzxIQTIqafwiuMGyPSYDHlmq0A0q4VlP1zYmJr/jzX7?=
 =?us-ascii?Q?jkdKEIlIDUblzYLSzyj/En4upjJp5x/jO47jGhobWZ0L6BWmbXuHNoN06Rpo?=
 =?us-ascii?Q?cMn8bneLpP+k98oCXiakPRWW/kX+DNtX4Hf4DzjFyLcQtNmFqwASDGBiSPzl?=
 =?us-ascii?Q?ECMvcTSuvDrA0fBcGLnl+ti3F8WwZGnEhLdkb4CdBa+pxlM8IExRn1Dy6fOX?=
 =?us-ascii?Q?5lSrBvHwNC5p4v94hUPSa+gkUYiw0fGVGncfLS7aQUPqqHYT7XkJETnG3Qqz?=
 =?us-ascii?Q?yg+n4T5xH0z/dkZGz/tkKLz2VjPY3edit7TYMGATfpA46uhiS2TklJkkaQ5j?=
 =?us-ascii?Q?96VF+g0jqdB1tEBMehGO5+c1A77hbL91Sg7FoP3u/YNt8FszIRCxOHKXUb9H?=
 =?us-ascii?Q?Spy/2FpTdoTVFZhQVUs31VreKyWMq9trSlDuqn5seDw1r2vb963WL6WYt/Cw?=
 =?us-ascii?Q?KKL3SwPpmLZ9FBTdgz1gC/L23Ngx5bHwX2dkVdjwzfYjGwQCyqmpAHksf7yp?=
 =?us-ascii?Q?74P1R8RfqAyIgORnIKUf8/EMruVEzZsQNZu23hoZfsHsSuuH56ohUEKt3og3?=
 =?us-ascii?Q?nm/PF8isYQBi0gdFr3I4B0GMCGDlfmWhgon4GxG4UaaeGz5CJCwm8MneF0Po?=
 =?us-ascii?Q?Xg34G01f4OWDzwUVMBBykK63aSU5zs5LR4Agf2+AmHQszdBXiSM9E4yGjYkW?=
 =?us-ascii?Q?4T/oJ+T3oD5LULXbd6/j4qIsxZ57SwSTrayCnJmF6p6XpRb4MAgMDGnoQv3q?=
 =?us-ascii?Q?7+Kt4nBrS2xLJfqUQI60s5OUZBjUMtAYa2Ax5g/DfVq3KhMTh4ysnaILDo85?=
 =?us-ascii?Q?kW9E1chqFzBmDc7zFjz9jXqJjZl/JM7wXQdppU2KA3EJeLVs1CCO1dMrDZ/2?=
 =?us-ascii?Q?Y0fLPVOu/DnB1I3AULcJJOB+NqsNy0ZXp79svc+MeYg89PWY9UR6uskakKqy?=
 =?us-ascii?Q?sr9udjdS5Z7fGd7o08mUvhbSic4wUUE57GflrkrIqckDVPPanc+7sWFPL38u?=
 =?us-ascii?Q?ZOnL+yNkd5IReLnKYSl5R2fin+Ks1moR0dhADkqbsc8jQZmuP2fmlkLeN7iC?=
 =?us-ascii?Q?jAIBVBep2IWnz/HhQzhDwjckPfpAXXqpZ9Tb7ycfcVTyKwAExMX+Lqsiv/25?=
 =?us-ascii?Q?uyIuAoW8OwSOuEelV7HIYe9XF0eExl16lLdIDEMAGtAo1tHjnP3JyAIS5Pd3?=
 =?us-ascii?Q?n3pxv9/QFJhxI8meLmrLa3BtSQ57w1io/I04jIqjSrAptW+/l7KwMFlR78RX?=
 =?us-ascii?Q?y1D9v9hlgD8rBTvQcYKDt83WFnb2CbNAYZ6mh31zB41FL92NvDzwmQ5JSds/?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd08dc1-72c5-4084-4338-08db578067ed
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 09:15:22.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOypftA8iJpN0knLqJL8JLOaW/4v6XsfRMLdKGto5uhu2sHCKK2mUgevsmW3okvamRS8a9NYkqafMLlza9FegYtoTBuOTKDO3roa6BdTMNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8082
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Convert Dialog DA7219 bindings to DT schema format.
- Add Jack insertion detection polarity selection.
- Remove unused `dlg,ldo-lvl` parameter.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 .../devicetree/bindings/sound/da7219.txt      | 112 --------
 .../bindings/sound/dialog,da7219.yaml         | 240 ++++++++++++++++++
 2 files changed, 240 insertions(+), 112 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/da7219.txt
 create mode 100644 Documentation/devicetree/bindings/sound/dialog,da7219.yaml

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
deleted file mode 100644
index add1caf26ac2..000000000000
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ /dev/null
@@ -1,112 +0,0 @@
-Dialog Semiconductor DA7219 Audio Codec bindings
-
-DA7219 is an audio codec with advanced accessory detect features.
-
-======
-
-Required properties:
-- compatible : Should be "dlg,da7219"
-- reg: Specifies the I2C slave address
-
-- interrupts : IRQ line info for DA7219.
-  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
-   further information relating to interrupt properties)
-
-- VDD-supply: VDD power supply for the device
-- VDDMIC-supply: VDDMIC power supply for the device
-- VDDIO-supply: VDDIO power supply for the device
-  (See Documentation/devicetree/bindings/regulator/regulator.txt for further
-   information relating to regulators)
-
-Optional properties:
-- interrupt-names : Name associated with interrupt line. Should be "wakeup" if
-  interrupt is to be used to wake system, otherwise "irq" should be used.
-- wakeup-source: Flag to indicate this device can wake system (suspend/resume).
-
-- #clock-cells :  Should be set to '<1>', two clock sources provided;
-- clock-output-names : Names given for DAI clock outputs (WCLK & BCLK);
-
-- clocks : phandle and clock specifier for codec MCLK.
-- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
-
-- dlg,micbias-lvl : Voltage (mV) for Mic Bias
-	[<1600>, <1800>, <2000>, <2200>, <2400>, <2600>]
-- dlg,mic-amp-in-sel : Mic input source type
-	["diff", "se_p", "se_n"]
-
-Deprecated properties:
-- dlg,ldo-lvl : Required internal LDO voltage (mV) level for digital engine
-  (LDO unavailable in production HW so property no longer required).
-
-======
-
-Child node - 'da7219_aad':
-
-Optional properties:
-- dlg,micbias-pulse-lvl : Mic bias higher voltage pulse level (mV).
-	[<2800>, <2900>]
-- dlg,micbias-pulse-time : Mic bias higher voltage pulse duration (ms)
-- dlg,btn-cfg : Periodic button press measurements for 4-pole jack (ms)
-	[<2>, <5>, <10>, <50>, <100>, <200>, <500>]
-- dlg,mic-det-thr : Impedance threshold for mic detection measurement (Ohms)
-	[<200>, <500>, <750>, <1000>]
-- dlg,jack-ins-deb : Debounce time for jack insertion (ms)
-	[<5>, <10>, <20>, <50>, <100>, <200>, <500>, <1000>]
-- dlg,jack-det-rate: Jack type detection latency (3/4 pole)
-	["32ms_64ms", "64ms_128ms", "128ms_256ms", "256ms_512ms"]
-- dlg,jack-rem-deb : Debounce time for jack removal (ms)
-	[<1>, <5>, <10>, <20>]
-- dlg,a-d-btn-thr : Impedance threshold between buttons A and D
-	[0x0 - 0xFF]
-- dlg,d-b-btn-thr : Impedance threshold between buttons D and B
-	[0x0 - 0xFF]
-- dlg,b-c-btn-thr : Impedance threshold between buttons B and C
-	[0x0 - 0xFF]
-- dlg,c-mic-btn-thr : Impedance threshold between button C and Mic
-	[0x0 - 0xFF]
-- dlg,btn-avg : Number of 8-bit readings for averaged button measurement
-	[<1>, <2>, <4>, <8>]
-- dlg,adc-1bit-rpt : Repeat count for 1-bit button measurement
-	[<1>, <2>, <4>, <8>]
-
-======
-
-Example:
-
-	codec: da7219@1a {
-		compatible = "dlg,da7219";
-		reg = <0x1a>;
-
-		interrupt-parent = <&gpio6>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
-		VDD-supply = <&reg_audio>;
-		VDDMIC-supply = <&reg_audio>;
-		VDDIO-supply = <&reg_audio>;
-
-		#clock-cells = <1>;
-		clock-output-names = "dai-wclk", "dai-bclk";
-
-		clocks = <&clks 201>;
-		clock-names = "mclk";
-
-		dlg,ldo-lvl = <1200>;
-		dlg,micbias-lvl = <2600>;
-		dlg,mic-amp-in-sel = "diff";
-
-		da7219_aad {
-			dlg,btn-cfg = <50>;
-			dlg,mic-det-thr = <500>;
-			dlg,jack-ins-deb = <20>;
-			dlg,jack-det-rate = "32ms_64ms";
-			dlg,jack-rem-deb = <1>;
-
-			dlg,a-d-btn-thr = <0xa>;
-			dlg,d-b-btn-thr = <0x16>;
-			dlg,b-c-btn-thr = <0x21>;
-			dlg,c-mic-btn-thr = <0x3E>;
-
-			dlg,btn-avg = <4>;
-			dlg,adc-1bit-rpt = <1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sound/dialog,da7219.yaml b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
new file mode 100644
index 000000000000..32dfc4559052
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
@@ -0,0 +1,240 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA7219 Audio Codec
+
+maintainers:
+  - David Rau <David.Rau.opensource@dm.renesas.com>
+
+description:
+  The DA7219 is an ultra low-power audio codec with
+  in-built advanced accessory detection (AAD) for mobile
+  computing and accessory applications, which supports
+  sample rates up to 96 kHz at 24-bit resolution.
+
+properties:
+  compatible:
+    enum:
+      - dlg,da7219
+
+  reg:
+    description:
+      The I2C slave address of the DA7219.
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt for DA7219 IRQ line.
+    maxItems: 1
+
+  VDD-supply:
+    description:
+      VDD power supply for the device.
+
+  VDDMIC-supply:
+    description:
+      VDDMIC power supply for the device.
+
+  VDDIO-supply:
+    description:
+      VDDIO power supply for the device.
+
+  interrupt-names:
+    description:
+      Name associated with interrupt line.
+      Should be "wakeup" if interrupt is to be used to wake system,
+      otherwise "irq" should be used.
+
+  wakeup-source:
+    description:
+      Flag to indicate this device can wake system (suspend/resume).
+
+  "#clock-cells":
+    description:
+      Two clock sources provided.
+    const: 1
+
+  clock-output-names:
+    description:
+      Names given for DAI clock outputs (WCLK & BCLK).
+
+  clocks:
+    description:
+      phandle and clock specifier for codec MCLK.
+
+  clock-names:
+    description:
+      Clock name string for "clocks" attribute.
+    const: mclk
+
+  dlg,micbias-lvl:
+    enum: [1600, 1800, 2000, 2200, 2400, 2600]
+    description:
+      Voltage (mV) for Mic Bias.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  dlg,mic-amp-in-sel:
+    enum: ["diff", "se_p", "se_n"]
+    description:
+      Mic input source type.
+
+      diff - Differential.
+
+      se_p - MIC_P.
+      Positive differential analog microphone input.
+
+      se_n - MIC_N.
+      Negative differential analog microphone input.
+    $ref: /schemas/types.yaml#/definitions/string
+
+  "da7219_aad":
+    type: object
+    description:
+      Configuration of advanced accessory detection.
+    properties:
+      dlg,micbias-pulse-lvl:
+        enum: [2800, 2900]
+        description:
+          Mic bias higher voltage pulse level (mV).
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      dlg,micbias-pulse-time:
+        description:
+          Mic bias higher voltage pulse duration (ms).
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+
+      dlg,btn-cfg:
+        enum: [2, 5, 10, 50, 100, 200, 500]
+        description:
+          Periodic button press measurements for 4-pole jack (ms).
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      dlg,mic-det-thr:
+        enum: [200, 500, 750, 1000]
+        description:
+          Impedance threshold for mic detection measurement (Ohms).
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      dlg,jack-ins-deb:
+        enum: [5, 10, 20, 50, 100, 200, 500, 1000]
+        description:
+          Debounce time for jack insertion (ms).
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      dlg,jack-ins-det-pty:
+        enum: ["low", "high"]
+        description:
+          Polarity for jack insertion detection.
+        $ref: /schemas/types.yaml#/definitions/string
+
+      dlg,jack-det-rate:
+        enum: ["32ms_64ms", "64ms_128ms", "128ms_256ms", "256ms_512ms"]
+        description:
+          Jack type detection latency (3/4 pole).
+        $ref: /schemas/types.yaml#/definitions/string
+
+      dlg,jack-rem-deb:
+        enum: [1, 5, 10, 20]
+        description:
+          Debounce time for jack removal (ms).
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      dlg,a-d-btn-thr:
+        description:
+          Impedance threshold between buttons A and D.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 255
+
+      dlg,d-b-btn-thr:
+        description:
+          Impedance threshold between buttons D and B.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 255
+
+      dlg,b-c-btn-thr:
+        description:
+          Impedance threshold between buttons B and C.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 255
+
+      dlg,c-mic-btn-thr:
+        description:
+          Impedance threshold between button C and Mic.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 255
+
+      dlg,btn-avg:
+        enum: [1, 2, 4, 8]
+        description:
+          Number of 8-bit readings for averaged button measurement.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      dlg,adc-1bit-rpt:
+        enum: [1, 2, 4, 8]
+        description:
+          Repeat count for 1-bit button measurement.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - VDD-supply
+  - VDDMIC-supply
+  - VDDIO-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      codec: da7219@1a {
+          compatible = "dlg,da7219";
+          reg = <0x1a>;
+
+          interrupt-parent = <&gpio6>;
+          interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+
+          VDD-supply = <&vdd_reg>;
+          VDDMIC-supply = <&vddmic_reg>;
+          VDDIO-supply = <&vddio_reg>;
+
+          #clock-cells = <1>;
+          clock-output-names = "dai-wclk", "dai-bclk";
+
+          clocks = <&clks 201>;
+          clock-names = "mclk";
+
+          dlg,micbias-lvl = <2600>;
+          dlg,mic-amp-in-sel = "diff";
+
+          da7219_aad {
+              dlg,btn-cfg = <50>;
+              dlg,mic-det-thr = <500>;
+              dlg,jack-ins-deb = <20>;
+              dlg,jack-ins-det-pty = "low";
+              dlg,jack-det-rate = "32ms_64ms";
+              dlg,jack-rem-deb = <1>;
+
+              dlg,a-d-btn-thr = <0xa>;
+              dlg,d-b-btn-thr = <0x16>;
+              dlg,b-c-btn-thr = <0x21>;
+              dlg,c-mic-btn-thr = <0x3E>;
+
+              dlg,btn-avg = <4>;
+              dlg,adc-1bit-rpt = <1>;
+          };
+      };
+    };
-- 
2.17.1

