Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECF70D755
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjEWIZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbjEWIXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:23:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18931BEC;
        Tue, 23 May 2023 01:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1Rk8OxQObx7ABBrGhVnFMp06bsYqP+g8EKqi6SwAcIkJ0LjSwrdbei0248ftD9PWgvYjnSiPkh0esIp8BFCXhhMdgzC8memD9yvWZboEvkwrDLDw1J7m7W+G24szOijoQHaVwwraK33T1myHtgwM6Zb4mKjnTVs0tQ1ierImgJMq7n7V0R6EIfVfdEUW0a8hjmexBz7mRWHY7pUKl48q9FvbGth5NB3RtFyUDFW12XxO6Png4MwrmkckbdSl7ttWolAkgDXamdPLPuFEgwPGpu29JKUH9Y8asTZ/XYGDioXIevoCBL07idIPjSej2Zu9j6Oa8QVjbydyRqRArsNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2tC1skomVw6R7pr+O2yYDxhqGxtD1WeQwOsrr96SlU=;
 b=ZwIBYg3AZIEAHL0Lm5Ha3dJzG4VO91SPAlX/6kaR1ImqAkti0fmSk36/Xtv27di1AHc9rEpGZjsFGvFuoYFm2Gj5MCy2dyJDqRYjUQAi8ieBpBaedjx5qXvKCHN9DzM+y/lyDl9Upya6VYvvNe4ZZLYB4l7u4N1ImH5YuiLHtXxez0XJ6NIIuDZ8S/M/R1RjyGgGjuV4y4pzkBP2K8aKVi9zgVC4OZYZu1nA8lT5GRxLfdXXpkB1GRpDIvbrRWD5c26CzEfFsPHo9oDNegJ9o4CfM/sOeX3KdAYxC2sOveeWaSliGrGENqjoqYeSVjh42sGcBMiMd9nbwpmy6mOwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2tC1skomVw6R7pr+O2yYDxhqGxtD1WeQwOsrr96SlU=;
 b=D8mzwO0ngiPf9EiLFcPXzoJJUDTJBBog8esSRwXdiGUqDhR2EKj+vBPHC3eIOrobyjmtinIY1eGgN/3pCEyGHePWn5aT6FbA/8Rn4qOn/lUv0Q0t3rvSYAnvztlNc14H0lE6+N9TRkSGpEpo1z+xyeIfy8TVWL4xcDBivIN2imM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 08:21:32 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 08:21:31 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     conor+dt@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [ASoC: da7219: Add Jack insertion detection polarity selection 1/2]  ASoC: dt-bindings: dialog,da7219: convert to dtschema
Date:   Tue, 23 May 2023 08:21:00 +0000
Message-Id: <20230523082101.380-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: OS3P301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21d::14) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TY3PR01MB11797:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e95256-0b38-49d4-099e-08db5b66b4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYrA7hwS5TTV5IxNk1CgaRU99oDmMeBQA+qnMh5viSSs8tAarfegx7oKqW17aTpHvqag/781r0AI5340BEh7PCqgG94v9++YbDC+8DiC69gqE6sXA6Tbs2XmFPJ0B9V4HXpcZkkDiH99EuPjdgrtG7DgiwxpIgxU3i/cYhi+m0hpDhJXlo/+PO2lZW/LecL3PDCl/0w+yh2B2a+GfNS/Njo54221PVZNRIu8BNatplgDvaVYAPI0Wk3uB5ayGxMNsYZvJxHE1w0WTI1v7RgEF+bm9dRs91c308b8o1DYreoFEZvCVFdQIIjAJ3YXlCbRdmWgOSYFNkABF5qpR7XzLw/ERjCIyBJGy8tPG3w1iqjWqM4jkyCdpLySJecroer2BiI0ooS62cQqpOr4gsg/eFVTlA2MoFczEp9Q/RVhzEtTpfCacZRS6DPAcm8mGmh0Nt8IGqbnQhpDB3I2pcxN9BnFYTmlyN4dcmULxtZpoSn8W8T9RE+2NyYUHO6MUj3VgjRXKWlmh9jEX3GAbmB6KtlYNiHxFREBeMdZJ0ddd857ZM9O34b/ENYShg2GRuE6ra5SddrANFeTxJvPuYhoi4YZi0icFa4hMaJlBNSUNGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(107886003)(6512007)(8676002)(8936002)(83380400001)(103116003)(38350700002)(38100700002)(86362001)(40140700001)(6506007)(2616005)(2906002)(41300700001)(52116002)(66946007)(66556008)(66476007)(4326008)(316002)(6666004)(6486002)(966005)(5660300002)(26005)(186003)(1076003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYEyuf0rfYSp4Mggsy0gecyge37Fs2XATtFGpoIbDgvcGvCHAlUxHdtUStJv?=
 =?us-ascii?Q?myc9JtGoCAejiTngp/b5UewTLllSbfuYW35kpvhvYhnfMYmBwUQ3OzHiTHgA?=
 =?us-ascii?Q?O8phEJY4nJFFbpKgTNNSVaEFTdEWkcbvad1pUkdQ6ul97ah5vP+8kQrmUXpK?=
 =?us-ascii?Q?j4tbSWQXpaDxy4gzb9OLVYLVir/GLq/+hVujzCnP873DWPimS+NtPPi7dteN?=
 =?us-ascii?Q?Kj2sWU9L/Tx+HqMTGH7cih05U+0k0hBDj66MNCM7WmMnoPAgLymUkRLKTi37?=
 =?us-ascii?Q?WW6D0N7E7842WR7yTwI5GKOD+AMd48ECoak30nYvBNdQLm81ERZjtU+dmgcE?=
 =?us-ascii?Q?7br9O9HHeNsYoU4UT48LwGML+bUlCRPDp20wLlFQbi6NISg0FOGyrIlSSDhs?=
 =?us-ascii?Q?iwY/2TLr9U0lmtV6xGmujK6zJ2hPFkYlBuxUYlFuoi3mH6/BMCelgP9t1osQ?=
 =?us-ascii?Q?Pu8xV4a/KGat0A3x4bZIkDDIpDDJrNrvpqM/IEZlK8hmC2bhNZj+100uLS++?=
 =?us-ascii?Q?9zkWnmm/npB8xEnylu0NIDaC4qOqDbWm1GUYJACc2vnfcogEz/R0wJ+Hjekw?=
 =?us-ascii?Q?k9fXJoUswEyikqaNvCOy27TJ+P+ktLEMHT21JUfmrX+ypYxLMJvi6xXzS13q?=
 =?us-ascii?Q?3vNDPt/fvv/7jVHBfMZWE6QWr3daK0ro++3e6F1LAClMpHGcNAuxebcQHqXm?=
 =?us-ascii?Q?84x3GcSCkQVUlsYxv3ZNyW3vZ3RrF94woA8BPR0mZfec+2mMktqGpcNRUXSE?=
 =?us-ascii?Q?tUMBUNw6KlKrLbNWoQsW6HlZg/KrzYb+CVkdSwo+/8BaZipLjBveyDtc2UxV?=
 =?us-ascii?Q?BH+v/SPsDJT3yJzN0PI6d2A2b+JDCos0q/HP67FA9iV4955Vq3l9Dc/nPeBM?=
 =?us-ascii?Q?NEaq6qoPnVXltiUdsojkT92ciIKB4WgV2zr31jsenhKxtrPqZgqAZJRjWfH8?=
 =?us-ascii?Q?ALvUlnFcRJXOIod4qui6+mUv9Tl3xmN/L82tlaEXDxKvDr0b8IDXzrroQqfq?=
 =?us-ascii?Q?PX6hfIxDILuxisggM3UfZmgpohv/pmrfo8feb2Rik2T/nBP83es8Lgmnu3OO?=
 =?us-ascii?Q?Tm6xw8qQbK9F+FwDd1VBcKq+tZa8syqE9y/Uv69YXt7Y+z/xdJqXMWimjTgt?=
 =?us-ascii?Q?xFknuf80eDn9gh1ufFyzPRhQo4tbAsGY2Z2Q+8rquv9WQ8IfsEmzOP/1PEnJ?=
 =?us-ascii?Q?o1cozRaViWQ+rEwA8foApni0TG/iyBs0ZR+ZIKQ3EmZE9yWcK+LzqJqvn9Vx?=
 =?us-ascii?Q?r8FEYeIS00VvFA7k+yppwcsDkfm9ANpdKW3g4fwILkxmw6FERX2uzlsRBN17?=
 =?us-ascii?Q?Y2zEFUMD4wR6dCDx1sXCozqSxOb46DzA3tTPGSDRlk56164IjDwfXbwd46cK?=
 =?us-ascii?Q?Q/OM06aFt287Sqyr3OVh3Al3FwlnkDUQivMl9j6PyHWa24YmvaS7FTaONFrE?=
 =?us-ascii?Q?rhavpNassSnf6gU2inGIz9xyI6qtkrxLtwg8+MdpUG7WUhlNnuUK1Hshrc2Z?=
 =?us-ascii?Q?zEUR9cYqNf90tQCU8dFVQorSksuYy9J1maTt5kdMISIcou0IdiOpB3FsVe29?=
 =?us-ascii?Q?XVdgT8s4sbSePLe7HKAiZxYAilAxvw7ig6ptucAKXw8h+fjJ8gma4SRaq7JP?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e95256-0b38-49d4-099e-08db5b66b4e5
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 08:21:31.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8SWp2u1UxV2jtFK0mAJt1FlhKTA7e+PuyKT+BWmF9kqsrNgUNZkE0oRFNFL6ENufGMlHQhN0dwHczvdKHKkmA2FeD+m7ESDcmwjpRVwICk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11797
X-Spam-Status: No, score=-1.7 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Convert Dialog DA7219 bindings to DT schema format.
- Remove unused `dlg,ldo-lvl` property.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 .../devicetree/bindings/sound/da7219.txt      | 112 ---------
 .../bindings/sound/dialog,da7219.yaml         | 230 ++++++++++++++++++
 2 files changed, 230 insertions(+), 112 deletions(-)
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
index 000000000000..9160f68696dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
@@ -0,0 +1,230 @@
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
+    const: dlg,da7219
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+      Should be "wakeup" if interrupt is to be used to wake system,
+      otherwise "irq" should be used.
+    enum:
+      - wakeup
+      - irq
+
+  wakeup-source:
+    type: boolean
+    description:
+      Flag to indicate this device can wake system (suspend/resume).
+
+  "#clock-cells":
+    const: 1
+
+  clock-output-names:
+    minItems: 2
+    maxItems: 2
+    description:
+      Name given for DAI WCLK and BCLK outputs.
+
+  clocks:
+    maxItems: 1
+    description:
+      phandle and clock specifier for codec MCLK.
+
+  clock-names:
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
+  da7219_aad:
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
+      dlg,jack-det-rate:
+        enum: ["32_64", "64_128", "128_256", "256_512"]
+        description:
+          Jack type (3/4 pole) detection latency (ms).
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
+          clock-output-names = "da7219-dai-wclk", "da7219-dai-bclk";
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
+              dlg,jack-det-rate = "32_64";
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

