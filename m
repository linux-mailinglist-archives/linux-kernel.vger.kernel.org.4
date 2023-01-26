Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7F67C6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjAZJT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjAZJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:19:10 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2123.outbound.protection.outlook.com [40.107.247.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB3E6DB11;
        Thu, 26 Jan 2023 01:18:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsAmPtZwIYilyABwT/VcQ9M1D9A2r/zvPK9kEAJtkPLoD/QzklunXknMxC1qt89gmKOzKWYYuuoDpPjbeVA3umquj/+dSYrypmOsE1AZ86owuudqCcDv2mPU0ZBd0DSwXE26KMXTXxkMRnDdplGTCOvLe9ihWI65103LZg7/7E2cCL/fpMpEcS4Ip5AoJk8RPk3LYqo2NeqqXnYulGwcgpltGPGhbMsclxojoEu9WQ1ft9yGBEHe7r/fKxfRKof0OXa8O6pcMA7Q7AYZJ5Pmjro6fF9MQprKvzcRTOwmKr1Aj9VYFmnSSwjbhFZbmZLlE6AjVwdLH+OReLiUo4oS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b09xNOJk8UPM1c1cvNP2Dg32225UmVsv0xJZ3OX4H5o=;
 b=fYUWoZGw8fUu350QYAIo5HwHIZm7z751x6siQmHyIfjEcrB4FJqI+Yz2Z/G9+yQRffKaRrsuBXfTQc83joH77FMsqfKfnJYATQRIraLEQ5WyajGTn2uOKOQcseiI08F0vPWWeV6Vyv6mRg975yjMAQeTeCyIAJ2yEQ2m3EV8gwdii+l9dnD+3ET36tsuTFHTuHAxmgyJkv/rDB4rVmO80Fy6Gc7eTJrvcWIi5hI+ctyIPKJICk5bVPMFDdL09IjV23CSe8dFKVH+OGz8bJZoWi8QxsBPbmEKgwg6Go49bJ5s0U4iOTu5kESdO8Yhx0Fjx0u85YQeImfGXdt9siwZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b09xNOJk8UPM1c1cvNP2Dg32225UmVsv0xJZ3OX4H5o=;
 b=m7tWo6WKmBZl3qd54txkhQCMXoDZmOLaHw5B9XAnwug0mxjVR80cRJ8zh4hz9ZFZcmEbA/gBV9gGe5IqMmGfzt0qMLpv27AASbiqI/GecbdhpltBgn+XLyzLmGB71KQjrYRlemiRs9E0bjR+y5vUO/W2NdN7mmArZjJvikDlI170a6XnSviZ8xLdYTfVMK4MaAYrhp4uwYcO+t1075keWl8MvjSdwfpdnY2cZGWgAhfZ7qJBa2tMmDLxDmkXwa74fLgjmBtUmdhhNdomdqD3XgHr35wGlohBDfTv4l7/hPZ7j4byD4F3FC4p1o4XwcMBOMYxZHsU8DBI5fnZMU5bVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS2PR03MB9516.eurprd03.prod.outlook.com (2603:10a6:20b:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 09:18:48 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 09:18:48 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 1/5] dt-bindings: input: pwm-beeper: Convert txt bindings to yaml
Date:   Thu, 26 Jan 2023 10:18:21 +0100
Message-Id: <20230126091825.220646-2-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126091825.220646-1-manuel.traut@mt.com>
References: <20230126091825.220646-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS2PR03MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 170e5c76-ed1f-4805-e5cb-08daff7e551e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTsXuc5pMDXWiivY9vCWNOJrrrSvTaG44hEemy9VdXZ5QN/WSh49Lj3DmXsq005jiH+30PB6PqUYUOGhCV9KoNSlIUtdu+bH1n1Jp/SxRfs2m4dMh+d2EjoUsOA6QuksBSrIazr/ZaIE/MwWBLOQDEokVPUdAvqCe8CT2Ylu0rpplUcYIORkf5ziLMlgyYtUYO1q4zVTrgVrKm7JaNWtb0mB+3H19CllAKvtcfV3l6aU84ThUPmRkLwSM8Q+fIPC6pHmJVB8NkJrTGsX6sfw8CAd5VMeDQct0GZVjT6ULiPHN2Wgqe0axCtRu6yq93R1vSXsA7ylco6kBK9wHuCMpCXbCefxrD18jhzjugtcpsV6aWWGq3ANIvqBWid+vSpinz/U5q0foCrQU/8/nzT6FCgC12RqAbO/dCcNea6B/8B7oiGV/jKhL+ClF/bzJZ2b2tmiyoN9g5P1CfxuJxle1BaYoWMTut07jtnCO7E+jeuIqZgQgeF/gss3DC/wNNkkUXyE5O5CBhA99PFAT/tRoPs08bApJjtIvJBXGFNZ3HS95/307itzlpCAPvoUc7eNeq8REfHzniW5V0cPFoNlKh2kRFowAAL24+0+d0MtIZ38sPNkSYuNiOigHHpm7vrcPZ0xs6dNXyP2H9itgJctIeLJvAg2bWHTc+KIlIwAk8Y6Dr5eMjlwnKdKqAu4wGyheIBE7jOJRYNlrdirUCdjlImkrytiSD0jPbI++TwBTJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(44832011)(2906002)(38350700002)(38100700002)(2616005)(1076003)(6666004)(6506007)(6512007)(186003)(26005)(86362001)(83380400001)(66556008)(66476007)(6916009)(66946007)(8676002)(4326008)(5660300002)(36756003)(41300700001)(8936002)(52116002)(6486002)(478600001)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0iwx0g/Z+YWgwbqu2T5V6y1C8JVXQ8G0GKSoHcOTBSKcrvabESfZL1dkzDwU?=
 =?us-ascii?Q?rkc0lvnU4L8yVDHww05/eqNqcLhrb0f0c0eXOEWiaO0bViGh45BGKKBDKX69?=
 =?us-ascii?Q?N2n/E7bitjGYL0tY0ukWV8ihWr4m6vD253fgX8Wtx7jnOfbbbg0xI0rQLrVE?=
 =?us-ascii?Q?dF5v+LBxpVv57czModX0cakw0mM1+RTOFKRcGCEFmbAgtYOwzxhn/L48Bsul?=
 =?us-ascii?Q?VzdjUM5B6BghtkLrmk8My3W31PbUXKrH7OV5Y4qNkLnyES1BewwWlgR/8N3o?=
 =?us-ascii?Q?yLHj+HPiNMpvgHEYJhE2fpU8DC9ZvJfMVDF4sEdRJ6JcQBwSFRNCv+5BkBj5?=
 =?us-ascii?Q?rhotiaM2X2h+UmSf2/4Pne1lZokO+s3mg9Qt/EhpxwYz3yVx/387SlM2Z8We?=
 =?us-ascii?Q?ICFLBeO7idVLAFyQQwDeCiy7jFNSVW4M7dQG431ynl2KJaf9d+eFfTxhAX4/?=
 =?us-ascii?Q?11pqB4snk7EdBSpHO1r9tj/bO8Ldw53Q2OgaOu+r/CY17VVsZWrQG4gIHxTl?=
 =?us-ascii?Q?iXaWn4gnLCrxpZ72gc79OTKNYv01wwe2wtnY6pKriJ1OS0N5pYnOETL6MSHS?=
 =?us-ascii?Q?L41A4IaQm7tW/p+NAohgit452+rs8ECzi3IEQnM3Z7u7LBKThHrzYKTs91Ad?=
 =?us-ascii?Q?dEJkgJC9rAMCvrIwus9ZUiLIKyrsFH/6yBU/3x+nS+0gkSbZEFlUDxLWaXR0?=
 =?us-ascii?Q?j00m6XyVtzJ/98im7yUru6tGIoW5nuJwSJzPV7oHAhushw5SPrWH5VL2eLwa?=
 =?us-ascii?Q?JUk21QcehWs4HBQdWgoLchKV0nY6fmcC7cDgnOVktJ/Q7cegKeB4WnFyi/wp?=
 =?us-ascii?Q?ABBvFeqIc0d01VKW2WT2umshKmDU7yEk33G9HN3MH4YPdKEIfi1tW8mnnxXj?=
 =?us-ascii?Q?zS/LOwPhKJrHL7ghMVaeNWq75pxPQoF2uLw+RIaeU8jelvwArCXqSa/J9YtJ?=
 =?us-ascii?Q?DD5+FEfxtNWvN8QpnMSsmltPLdSG3are0s7SjBvucyYy3hBVNp5JjXVGcqX9?=
 =?us-ascii?Q?8xyAGlYIECyjwqHTypQDwgPxIErDb307KtcQ7gSGXPXtEvi4p73t8tlBngel?=
 =?us-ascii?Q?qGZPTVCLKyn1MeXmA3j8M+sYDaEw55JvByW1n5ffUgdp7V2IgurKAAyfuw8w?=
 =?us-ascii?Q?DsnalTK9uto4yrRmNpzJt44h6bg6OxrRnOUjLe6OhWC8IvcwGMQaDLR4llf0?=
 =?us-ascii?Q?/HXAoxlVZS/iyX4j+1NLWbffUo7Zlx7O+bag390kUSmuB+XEgyW6AATs62FQ?=
 =?us-ascii?Q?63URYnBBSg5gk5mHJp/hAtDwmGEOOhmWitVhLgiZsx3MRFhws2jgCDTdsWf0?=
 =?us-ascii?Q?ReCCpemqn6+UEsFXanj+5UohbkZFDn8qI6NiQ6J2TqODXCR9nN93bfUfByTw?=
 =?us-ascii?Q?fjwmBAwMp4nG2V3dUrFKLyVDniyLeQCk1FIIvJJjU6yZomh3dNdjRLLPGOg7?=
 =?us-ascii?Q?p0NqOUJ13F3+SJBNYjgkNvWgDu/e59CBwJTLLNZFq5AlduVo/jy15CaHGH8V?=
 =?us-ascii?Q?BZanuLXl3V8eRPo1A5dBlXLit4oaYT/oMR3oMad2K/OauCICNitjpSlcaIq/?=
 =?us-ascii?Q?nhT5Jk09QSsEMo0/nt2Sr0sgruXYgc5nGTmhq9QW?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170e5c76-ed1f-4805-e5cb-08daff7e551e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 09:18:48.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvo/T5yPlQy0Rk1cWSJlS5mjnBrtprWDji7XhNpRVV3mnNx1DeBlH9p0vZpWIx66IjdYAktvhHQn+onefUViog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9516
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts txt binding to new YAML format.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 .../devicetree/bindings/input/pwm-beeper.txt  | 24 ----------
 .../devicetree/bindings/input/pwm-beeper.yaml | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
deleted file mode 100644
index 8fc0e48c20db..000000000000
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* PWM beeper device tree bindings
-
-Registers a PWM device as beeper.
-
-Required properties:
-- compatible: should be "pwm-beeper"
-- pwms: phandle to the physical PWM device
-
-Optional properties:
-- amp-supply: phandle to a regulator that acts as an amplifier for the beeper
-- beeper-hz:  bell frequency in Hz
-
-Example:
-
-beeper_amp: amplifier {
-	compatible = "fixed-regulator";
-	gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
-};
-
-beeper {
-	compatible = "pwm-beeper";
-	pwms = <&pwm0>;
-	amp-supply = <&beeper_amp>;
-};
diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
new file mode 100644
index 000000000000..351df83d5cbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/input/pwm-beeper.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: PWM beeper
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description: Registers a PWM device as beeper.
+
+properties:
+  compatible:
+    const: pwm-beeper
+
+  pwms:
+    maxItems: 1
+
+  amp-supply:
+    description: >
+      phandle to a regulator that acts as an amplifier for
+      the beeper
+
+  beeper-hz:
+    description: bell frequency in Hz
+
+required:
+  - compatible
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    beeper_amp: amplifier {
+      compatible = "fixed-regulator";
+      gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+    };
+
+    beeper {
+      compatible = "pwm-beeper";
+      pwms = <&pwm0>;
+      amp-supply = <&beeper_amp>;
+    };
-- 
2.39.0

