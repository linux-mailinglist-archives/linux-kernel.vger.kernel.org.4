Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60417092ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjESJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjESJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:23:48 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514F10C9;
        Fri, 19 May 2023 02:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpdWEEdxU1n9Aa2fxQbf8mC7OUGWYkeJF7YkmYrFNsm2xCjfaCG7W84ZytPXeDfbqZMSNr62tAS97D+DQUXSfHR3ElIqXX68n8YSIbGDdUvWoMfaMDTSt+Kn4S3UtTyhnssbNIUrro0UigbbrCeDutizVfDnw2PmN0zi4ZveI6/iCIXcS8TNAegFERvVUBF3ziiGSX82jdod0mBWFEkSsJw77HDZAW+t4NdQtd8Ai7u9B4rbXUpG0K2BBynBqtDuZMjpnJtAJclqVY76N8SUWG0aWteuQ9gwhD/Rctp7jn0AI28IDNUfJSiah55fikHvvY7pq16sb5/tQ6e9iF3ZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzruTiaQfF0ex3TpJf9CoMDDD4kEJEux1TrjjbURVC0=;
 b=Og/ejx2QRAJ+6+PtpXuPiRaMY0gziyp7vU1HyrAir6O9Q1EUHgFo7Yz5Nh+OzsEqU5LbdbHwYl78zmP+R2Q+NxfwMuNnjXbLzDkd67Igo2gx+mRAjyeaQbLJpfF/tDiHgq47V7GF2miM30GSN+sovEV6OW/VMkGqBfVOAwnbEJCWvzZED/llS6RceyzTi5iaZYqcOYUXrrB2Su9rkTWex01PPn1bDfXq2ix59UCa1kWktPz2xkGzK8xf/UQJFIfokK1yOK20g75yQvLNfjAhFNxXlSoEfTbL2VfngQ9CUGFWAVCD5TfD0WZy9JdPAeyjiVf3MnX+4RXYUN+571jBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzruTiaQfF0ex3TpJf9CoMDDD4kEJEux1TrjjbURVC0=;
 b=IuZlDhMizGesgPbTCXDZj2uGMstpUL/okGYHYN4kIUUAqHHmJ57/xp96aPjuZNNrDqJzCH8yURN7tFT7UCqJsLGNK8ODJsnxgc9xM3IEdwCO0Z+kKHBgZGYWfdBas4oPg/ROievDCbRDzpn4v3JvWIc7bDAmEF/eUeCjAcnoIBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYCPR01MB11070.jpnprd01.prod.outlook.com (2603:1096:400:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:23:37 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 09:23:37 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     conor+dt@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH] ASoC: dt-bindings: dialog,da7219: convert to dtschema
Date:   Fri, 19 May 2023 09:23:21 +0000
Message-Id: <20230519092321.26915-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::17) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TYCPR01MB11070:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ce58dd-a46c-444c-2068-08db584ab9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUw1daIDUHmv9fyi0DShg2X6duwBXdJ783cmB4rUJyNYu8x2XXm4Re6nSrk4ouhbSPux3wtxR/K7+YrKzIdkQljV7d2lHyq4t8IIzRS6vU5MyEbKTrtKRS1Jvy4i2SgSpavP2Gi5nr06GERw6+RfcnThnOgZoeRy/rKHRqkZGkAqsnHvaQSgHdk6XOXCieSC2jl0cLCCS2WzUfsTMYHM+UbqAjq8+maLppAY3WdwOdhbKNbF09WQRjUNzv2b6ZDWQt0d1XKbrYtjbLx/2470JxfXq1t7XBeoqj0s/0ZY1TQnMcs9EkzJ75dCvZbeBVHvLjn+Mv/oSkIUn1lASOxkj2vwsCQlW7SAp0tTAc/NouJyNOAjQm2LO73Ijp9iEK3VjiGxIk6wtgr4P/Osdy6ZpJNMmjuoT6u6FVj+1XUBTtPivIukVYTLHJmqBwrvuJ+pqubOJXVz9wfH4MKekYA4YFtlsVma+wLO7bE/eqXATTzLpauhyifBcRt5IhLdTTc3zTlovyVYDhOT0YGHFcUJhqUfF8RhP7FzHXcL42/chRIAdMiZ9kOcVPljbT0FTXig9GryWw+4wu6sZZ2Ht67z5SFeCz51jap98jiX4EN5mWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(86362001)(103116003)(40140700001)(8936002)(26005)(1076003)(8676002)(5660300002)(6506007)(6512007)(107886003)(2616005)(186003)(316002)(66946007)(6486002)(66556008)(966005)(52116002)(41300700001)(66476007)(4326008)(478600001)(6666004)(38100700002)(38350700002)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0LVH3kLynJRTrGe2zTxsN40vcGaTP42Q5JgqEq0eDY9YOFwNineXjjsd4V2x?=
 =?us-ascii?Q?1ekBCn0y09zBJdkCguVAqMC9ObPeJageuIgBjXFKFurLtru+8xJH0EuMK2iF?=
 =?us-ascii?Q?FYLHZXp9DQk0tfNSaJqH/40g2urBTp7Jl6ZT4gGo1zLyKoMc3gVPz8bHDLMA?=
 =?us-ascii?Q?4jiLQaln6IX0Vb8Nmt/9S6z7/bysBBPwrN+FeZJg8WMd/ZFHubRFfE/c8l2C?=
 =?us-ascii?Q?kCW9+vZQQRfQq+WzRVC2hHRnGs/tlDGq7dtyJqptRZmT4r6Q1/40XSC7BN2E?=
 =?us-ascii?Q?neNGcCp15s+FzYpsceChTlrj6etyfmuYcf3yOpU2XUJHwb75o0eYLbjQjy/V?=
 =?us-ascii?Q?IggVVc0zOG5OrUGRr3bB5EsOoSMzfOqfqdFkv6NkSz+8fiuX9fTQufyoV+j/?=
 =?us-ascii?Q?NiEFZn5rPpOvCWKNovUamAocEcFyE57L195n9DSlR80ctwramstNBMTv91qt?=
 =?us-ascii?Q?4xMPsBDnG3u469L+S6PqCEkVQaoGGHUeonCStiAg6dNQluQpikzazYcJTSAf?=
 =?us-ascii?Q?qk3mhRs2EW56cyfufYts4PYOwHnyaUw8lPTXDISD6ZFPdDOCAhRL+osyK2t2?=
 =?us-ascii?Q?TO04jv7MtENHYNrOsWATpJoMLsbPyfMWuBkothXjoAYxBMNnMtwKJy2wLkRk?=
 =?us-ascii?Q?YHVgX8LlZlQ1U2YeI5UAWwY+ZmE0U7yOTjlVYbu0qavZ8p5LuxGD3xVdBk1m?=
 =?us-ascii?Q?UjyHLOFZt2PNCWX7BdI3A8JKrA/UcKKojEkB7I/igLv/pVzXQAJazmogJc4Q?=
 =?us-ascii?Q?mXNIk4HLfJUglmdKn0kb3efjh2JzpeV1r28r6UspHdMx4JcOAIwoR4dh13t2?=
 =?us-ascii?Q?l/V5OrCCVmG3BKJ/AvI4p1tFcNkucYHq868px7WiqEaYl0DC7EXTi8fNNkxD?=
 =?us-ascii?Q?Wz6nLsglcrJHX/roQE5JgMlmjJS8qW7aziAVCpEI3hkzpA6KhBelMkHY+CEr?=
 =?us-ascii?Q?uNBazSxkQ15VNd7s7gRSGM05Nw1GdlbycW4eH0s03TOsalMqQJjfPfhlxBoX?=
 =?us-ascii?Q?NWueKB4b0d59NLnGznRrKWG36Tpxfu1o9kG0Q4ulF4awdYklJP9O+T+4kVM8?=
 =?us-ascii?Q?kTr6wUGt5n28A9kddrysnEe8Rz19WSjCQKtai+hLxr7rjI3U0/QR7s3es+yw?=
 =?us-ascii?Q?unYDlmJxwChtgInIX8MaXvq+mUQYm5dDO5tgp/U36oAYwFqTUv1BSRw1K3ks?=
 =?us-ascii?Q?WJW/Y20oLNdtoaHdFoKcqjli5eavuDpcaKGCBqLVTOn9S5yndKw+ZDvxV9Ar?=
 =?us-ascii?Q?XIFVHEMISfdv7BMEH2nI2ctosC3AndBKxuH+Yh0Xx+WNfF1CLrlY0ssMYeOk?=
 =?us-ascii?Q?xHQ8QIr22ilFmS7LZGDI7NDtwdaVO311S5b7vtwWYci0EpKWDO24DZBzQq4s?=
 =?us-ascii?Q?ORj6RX3l3T7xS51IST1GRtEpbVL+NtM0gNWadsNDGuDjRrxIyNfwJSnqLino?=
 =?us-ascii?Q?nl2n+TGaQBzPfJIqFzKhei7xQjN922UxKoyl2F1SEuY8VUHG0LVTv+TgrKiw?=
 =?us-ascii?Q?0uv/GMLzNwTBNWx4kkFTVjyR2cwFw9qewZkd39yInp3CdgOiuhVY/b85vicn?=
 =?us-ascii?Q?zHGOxiR0oMTj8cCfWrvSqdxt0dKdjn4gkauB/ewlNz2TO5OOWv1lOi851mCM?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ce58dd-a46c-444c-2068-08db584ab9dd
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:23:37.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9hVHP7DWmGeALK4/XQ9LL4SPJ/diwhY2HPJerRZBT9oGfJTDEkCjJ2zA7qeXY7z7RyVhXZ+OMdqwqf5rjsV7425Q4rHdG8Polo96/dlRHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11070
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Dialog DA7219 bindings to DT schema format.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 .../devicetree/bindings/sound/da7219.txt      | 112 ---------
 .../bindings/sound/dialog,da7219.yaml         | 232 ++++++++++++++++++
 2 files changed, 232 insertions(+), 112 deletions(-)
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
index 000000000000..5015f5797901
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
@@ -0,0 +1,232 @@
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
+    oneOf:
+      - items:
+          - const: wakeup
+      - items:
+          - const: irq
+    description:
+      Name associated with interrupt line.
+      Should be "wakeup" if interrupt is to be used to wake system,
+      otherwise "irq" should be used.
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
+      Name given for DAI word clock and bit clock outputs.
+
+  clocks:
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

