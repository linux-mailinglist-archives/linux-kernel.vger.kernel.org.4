Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362F570E1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjEWQTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbjEWQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:18:59 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F3E5;
        Tue, 23 May 2023 09:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU3/o/JJ57eCYxeOBPBse3lqx5lBhK6vGJIMc8rPyTWTStiPkt5N6lzjGZkVt/lQXjvprsLHIL2qOJyAFpyOVWqwnEb3UO2HxINxnz2DXXOz2PlqbADylqtQFuG5jrn3Qgw1cGtQFe+AAzIj/axYxk217FLhx8hCi5Ve2GcT0uHFWwxWXic9Of1H/RU0vPSzqnrwm6OOOVjJ0PPeiQso0LhowcLBp3bItYpz7JZKGsmzUCsE0X48CeigEz6+ylMgJ7uVJXtg0odVE8z9Xnl3JmBd4MQibVw7qJh07ke/6QeUk/3pWCtAK92CC19FVIjhnFnYFyuJ/mkZ7i8vB69fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2tC1skomVw6R7pr+O2yYDxhqGxtD1WeQwOsrr96SlU=;
 b=S/ZjMocZrlfBBtSJElbCZl3z5s9B5+pjEmDwhlq1TW+NqZFvonnZC9hrfDDYpoOd243mDv8OXMp0T+qDCRoGz8aymnPX9HVx8BzDDNkul/GcQ2AVZpXnhGt8OzzaFT+6wepWJPNL2AKvoFDeTLV47q4U2WuG/aMcMtyx4JxzgtbqBuyzyyPRslAR0wezvcm+uhRX/qtbEdkFh4qRG9ILP50vIoiGjrPj7HMxIOz+WAJfJ+ogV18D8Ap+lWc3D8kVXVomgVZQ0WFe9XK2QtUWCxIrdGOGNMSDcgyQudQAs/D5FIVrQNqV+chxeirPth4qribUWYtz5oeO4rMXMiOj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2tC1skomVw6R7pr+O2yYDxhqGxtD1WeQwOsrr96SlU=;
 b=RsL4VXUBr65IExo9xcqMRh0nnOfDTpm+W1LuiH+duyT58FoNKXnLzccfo3Z943ijIYZmJrO3oJDUgRGfZ/C8At1QgBiZss6Hm1wYnc3YQ8cDZoGilXFsOp5lXIbhejZ51NTwPmWyxfMfyjo+qbDt6Zw0J6O+aXT3WplLx4IHgPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by OS3PR01MB6040.jpnprd01.prod.outlook.com (2603:1096:604:d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 16:18:51 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 16:18:51 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     conor+dt@kernel.org, broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH 1/3] ASoC: dt-bindings: dialog,da7219: convert to dtschema
Date:   Tue, 23 May 2023 16:18:19 +0000
Message-Id: <20230523161821.4260-2-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
References: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|OS3PR01MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a9b69f-57ae-40b7-a629-08db5ba965b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMbqM1iGqsVgz7kig9N2hq49LHh0kSPezy+Y97ria3t6aTIU2jL7Z6nHIdEfKN/ZsMi9/1HMyYIW2GYkSdNR/AEgcb4O11sVDC4utKx4vldFPDugDSiw/fdSYdohZUx0h4p25WExxC3j/vLc7xIWbC1j0XSUShQc259d1fTPHxcSCFDquBcjI1o8+PkTtAf+VxZqZYL9EiSP2LOv8XcrWE0WTmZ20TQlbVcRtALJ+HOpYPN8xMZDiA0ERhDcjRZ/ongjmM16pDXQIH+F6KaYGA//sjsJUNVlAlI0rFsY6jPZint57AUg6i+KzJL+9H5fGaBrvtJ/4+T0AWTFEFe56xtIDMjkNslILVFaGhuBUGSobhjov5OGvtbjfwI4w+8RzmoWofnJSjGulOz85qPoGEKXZAKS66/H864jOois4LJf6zVVDFzdVVe9NV5nNwA220TkPK/HY87riJuE+Bzt8WVaW0k7RI1ZZ/S/8R4xYdzZzmm5CvYzgQs5ical+/NtEBfFPPVKJAxvNhKTxgBP8ox+jerkd9KT12OpoA+R8b9siRNkTKcgD/kRDXiFGIz40/0M+/4pCfZ54X3LexAaiwQv4AgWXANWvfQgOFhqWNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(107886003)(6512007)(8676002)(7416002)(8936002)(83380400001)(103116003)(38100700002)(38350700002)(86362001)(40140700001)(6506007)(2616005)(2906002)(52116002)(41300700001)(66476007)(66946007)(66556008)(4326008)(316002)(6666004)(6486002)(966005)(5660300002)(186003)(1076003)(26005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDwdwew16hpY/igN4xyKsEKo3hePpsyso42bA7TIbyZ9gLRvLWFGlV87xCTU?=
 =?us-ascii?Q?g2AT8FDQuJyc7vYl0VbTlp6v0e7mHJRQY0pg14fPoN3RviBGsMEIi98o4MO6?=
 =?us-ascii?Q?yM9AzdxvU6NHKwicPa5tgJLKURHU1HLCuaUEa/vNSofPmjqqYZZJkWsBqJK+?=
 =?us-ascii?Q?suCuLdjysRtiKDcI3vPtDCY36XkLZVz5wHcBftbkNraqE1NYirba+XEEY+WN?=
 =?us-ascii?Q?hxKAMu+u1R23PeXyf5OIi1r354NADpABbXMgjYKk0BNeSh5/XrDY0niAEA4s?=
 =?us-ascii?Q?sI1M2AmiSgpOljOziyGsXHR7cE4PjtxJ52YXMxyFUIsUdpBxg77nBdimWeSV?=
 =?us-ascii?Q?YY7pOvet5ShX2a9IipPfACL/ds0iAwdbVEjpeYpklmDcOo5M6dlbC9TPeGSJ?=
 =?us-ascii?Q?LkiieVHddjF+O4zsJogw34//+iglcF0NYD+RfT71IcbW58GomR7QR0DhTMQl?=
 =?us-ascii?Q?Y2egujWpVE3aAE7+279s5y8wwgYFGQuDLvMxTz3fvEpeDlXsJCJdgTa0cAPY?=
 =?us-ascii?Q?T1T7JIUGo2BSXBtS3p54tH/9eHWM2EJ7/34OXBf/coxfqACuLeOnNSXRnI6s?=
 =?us-ascii?Q?boqNFMLopOE9GI2vy2DUS7KEL/4fV/DkQZjhPprEV30jaxJ4wnCDttCkbxqP?=
 =?us-ascii?Q?UJmibwq3pSFarjs5ha/gZ/4EQfZvpTTKFlwDPYYh5eLV0nXA4+RvHSqSsX90?=
 =?us-ascii?Q?8F1dvGbeG99JWwdJMKdd4OqOKurbOihfiIcljP4D3FW6avySo1sCg5vr1OfO?=
 =?us-ascii?Q?w2pndtDHY8+1YN+9sgv4TAh9jMXiCPeNn+rFUaEMBGkmgdBmM/ty8Y7dpUrF?=
 =?us-ascii?Q?yAOvQahvsCzsZ+iTzDCtjoNU5jq0Zu0+pjuyOoqafi7AqnQsnpFIDsrTmnt/?=
 =?us-ascii?Q?hLVXtIieWaX//9jZYnFHZEa6C5/Y4C7TrKolqM/kOAnv8pAevGLBGaxzlZ3W?=
 =?us-ascii?Q?kEe5AhKgZXNEjNqz+ClD8q6u7B0WtVNZBroH2zu+A8t8f+1gCrrS1iuZVL5c?=
 =?us-ascii?Q?IBpaUgvejzPl3Yx5PjJkEZOa6GbmQJmeP0TmBnxRcsDNl7OrVEVRIDA0PLq2?=
 =?us-ascii?Q?6wHo5uBcOWn7T6UlsrGhY92OWljnDMuKzw8vlcQ1ASBwl+5Uc7wjhqOj6ZZr?=
 =?us-ascii?Q?ej2dXCMyLYHEgZn5nN08onsMh3u/SaaTCVQ1a786VeHMa1K61j6OewsugWDN?=
 =?us-ascii?Q?v94ZYPczBAoqMVLxAtorxTQI0VF9TSylzJI3MHqvIoY0a95GkhC7104Y7sba?=
 =?us-ascii?Q?V8/Zby2BayldepmG4feVIsfRWkdYBnwlyNOWeFkxrIoSy04mwwzEIC+RaoE/?=
 =?us-ascii?Q?oNazjqx1sgStz5A4MWH0TMxjGPE0+3EupC8I6ARkVieZ2IT1Kvlmo0jIARav?=
 =?us-ascii?Q?inwv9J0aMy6bxONNY6y1bWeaJsIv2wjQ/MjKzm0J/FC9Lq4hGmksxf5VqTPr?=
 =?us-ascii?Q?SLyEz68JgKN1GHIqoKst7lId2KnwLun/mzdPjEcpIN1aYE8Mv/5tJDXn3sI2?=
 =?us-ascii?Q?JWUUGDpWG2R+nhw6xVoltUfYqxr2UcsVeuOjFM/2InIMOjURQ25isI+BuMiP?=
 =?us-ascii?Q?H12klnAkE1d/dNOTIJ6LUjFQzJOaRznK8hUEn+VidjE8W9nF/3TFRjdErpwD?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a9b69f-57ae-40b7-a629-08db5ba965b6
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:18:51.7918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCc1NcprFj8ZsuVFp0y/tv4ENx2PR1lJoAzSWYkrOGA/uwZI7uelIgvkRPs/Ii+R8KVH5XcdtRfmqq7vd/YFNlEpDuPlsfJpaCviYqYypVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

