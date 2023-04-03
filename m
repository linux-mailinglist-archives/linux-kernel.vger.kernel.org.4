Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41BF6D3FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjDCJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjDCJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:01:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32365B97;
        Mon,  3 Apr 2023 02:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiqvF3dn5QPAlavOSp0eKYAT/hWTB+dPOsWKTB1l/u+z+hGAqESm7mBgiVGzUD6x9VTazZuYahb+5AGPydTZukToF+cnSiklh12XGCek8vqsJpO9rEusfns6GE/tvL3/KnbRIueDsv81Fsv3NIK10nuFzpBPMgOxW41wSjwiEovN8BZ3N4NrIt9Fx6aa+a6WvSdq1iLEmqilXEde6TGGkx4g67cZTMS/QEGocvtLpPoIxnK92Ic6wprQXWQH3K7PPk5Cg6uzoG7lppcuZ6da97WHDp9AqUeOKLbRySLPR0+NPhZI2IQXjY/+U7p/7vx7nQsp9Y+F9AbceKf+bIne7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYZIwzom0gdNiW0n3GINkTHSfqGowqyJkmLfgM2q2vI=;
 b=CEZ/T6p14KAz65UXOwamCNBk2vn0y02KQG78SjhV9WbjHPx2LfpL20xUsATXb2jIdnk6q1YQkqHZWDfxePwKZsJ9ysSUJxCe7+17jsaKEKNNztntuXgWl2RpVWFmV3D2JPMFIDuYbrTEIJshqsGLJ/OlqrAoeTUpPZLS27bHWVza532y29GReudwPXkJeCHaUfCRIt05SUID2DO9xgLoFqFc7NCN3sFTY59Pf/ETCKVvT6yvL1rY/GJXKf2oXpefvY2WczbLk+DXiLKXuoA6lvvqrdL/sdr1KnvFYIQfEt8i0xHl6BeCh4fpn1uC5H5hDvCJ2r8d7fVn5+rSQnts1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYZIwzom0gdNiW0n3GINkTHSfqGowqyJkmLfgM2q2vI=;
 b=Jg1WftbA0+zBE7FOvhPH8Odrj9iAvrgTJE9QH6qMmDDD7QtQbSWrxpS5i4ESKqGSyVCu6gsUukkT8fAjZf1Z0H15Ai05ph0zQ2/rGRnYQW8OatRMrhoRiQlrzh/cyqKAKztXGMOkhDnowqi2nI4BCHjaN58pksT0NunOd4igHR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:01:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:01:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] dt-bindings: input: pwm-beeper: convert to dt schema
Date:   Mon,  3 Apr 2023 17:06:40 +0800
Message-Id: <20230403090640.3237060-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d978536-c7e5-4fb2-fdce-08db342206e3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naEe3l9amV3VKLWQgrVtx8P4ajirU65BBZ731fvSMUMT/jki6pC9gswX3TayGtpLNsZ+v1Xnv/0OriU4ShfzfK1XKOURJszZNxILp9DVVDOxWQ7yZNaVKHCrhIcM2yFR9p1IXW+jyO0jUL7OxXwcSbBmA2WXZKS0QCNf3uj8rss6mgUcmv8IZ+7lL4GJKgjEBqhAFj6KtUcZDeDU0kpOeYOlv3v1cg02NPnhwPpT6zOlI7qlTRYTOyBwBNFmmEW33iCaGqRQ9vBA1412g1cSncbl5ACYK4lt4YeXw2jRWNYux4y6kNA/708zyaBh7Hos12aP59rZ08++Fvss+0QWV28bpi+ulE8g0bjxG7+BUUKss3SWdvVOuQwJpG7DJz/+P5LBPGlqoDWsB2dU7mghVQ7kNFsOuGgwZyYK5eLg/zUhdP2Q7fpJ5r0p1zdNaKDNGbc/IeoqM3bRBLdSlMweCnZbRYZPOERxh2TqVGws3B85iwkFxMkkskZ6t/sP+Um17c3gZ2Sx8k0Yn5GTjLGhzSdpl71sOElfVx1mHhccHE11yEILFjYIGA3KtPKudadbp8RLVMwNKx3YiFHDNtOxBeQIZsLTNi8cs2NjXWggcfFUZPJZ8R2wbr9ByuahQFfrz85XcLiIJaWFhX1e/8KwbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(86362001)(2906002)(52116002)(2616005)(966005)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(6666004)(4326008)(8676002)(478600001)(66556008)(66946007)(66476007)(41300700001)(38100700002)(38350700002)(5660300002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3RJyi5LZzEGK56721HuTeVbOqtUYNe5BH0gx1YwRgnQhUEgY+nYm5RVOn+5i?=
 =?us-ascii?Q?aOKN9GGO9+TIJUTTKHiLH8M052Ys0M2EvN76asrfh8GW5jgZiYj9awxtxxYy?=
 =?us-ascii?Q?DKzl25bPF+tL+i2VoXt3jjMRJXSVbuV6SiKvI1+GpSyHKPE6nnu2G7jHOrs0?=
 =?us-ascii?Q?NvofDpdk3h5RIKd8e3GKYd4nUCnkoVoNbCh6odRG9xKreX+RsUNCcfqVewq1?=
 =?us-ascii?Q?bZmMiThYKf/YYo6veBeEU650y4cHAzHxWKyDgL8XK9Srt6LquHkN9OIuTCiP?=
 =?us-ascii?Q?DvJwPPE4l54nYf5uGH73mf2QErAfYuVqqq5fyZpg8Qn+5aelRuhM6UBVigeE?=
 =?us-ascii?Q?7YKBRB7q3f94fAJ6EOfthQJw7dxhfPVa1yhIhvTgSdOq7wl303tcoDxeJKSY?=
 =?us-ascii?Q?L1ZlnzofoeU2ic0fenTmYJ4l7WGDeSt/enWKkoG97L0/AWPF3VOrME20eoyE?=
 =?us-ascii?Q?H94pnmmphEVPWgLBIIA73u4C21XHAZ/R80DqDrv8FOVPDne/wAVkppffBMtm?=
 =?us-ascii?Q?Gp/+hkXeRapACliznwF3UqXHBNa8A8NtzdzBhIQmdIa4yARYOrOeyuqU1Zo1?=
 =?us-ascii?Q?CZXowxtDHpDYxcSTxxe8uwf6vb2olxrKxjmKlrleDyS5yup9C9OuFftCmucj?=
 =?us-ascii?Q?Ydvg330o0r2xeHaIs8t4afCRo/o5shTstsHCwju/67q8UH+gjeT/odESyv4T?=
 =?us-ascii?Q?6k+Y4HrUd8XfIO57CUKB4bzHc8qtEgAhcSnB6qwuE3WfvgiAkHEOPrc6XPoy?=
 =?us-ascii?Q?K+GMdIqHJACh0tCLp/2WOWB04PeWiD4Kvha4LKuj67iFd4sWjj89wDhUnaiy?=
 =?us-ascii?Q?kNJSMY3gbDcdzAe9L1Z6/z7h6jJ4pR4cMM337gkyUfKW87I6l21S6vlO/uZE?=
 =?us-ascii?Q?O7DXwlMbi5PVKmVA10wlA/4BMNSrkayBH5pQHakCTGGe2Nwq87tqKg7+YJcD?=
 =?us-ascii?Q?07/hPcMN1CHeHogln0yRXETi+SGKXLa1tHcYjnSOgdkpovKv9SuCM5k4lXHN?=
 =?us-ascii?Q?mPqwTYsnyFTt8+EkWyDueKRMqOG2JqdMhAeyFtTxZhdoHGQAsL35OgM1Z8Gc?=
 =?us-ascii?Q?rxt1mE2jOqGAB7Fqn0eXrs5c4QKfBG2FTd2NHlXnb+fbt5fN7T+ZjwaXwhoN?=
 =?us-ascii?Q?Tx1jk/KbnPz9Jk2ktOWF7T/2cFQpCFF6WoYc7RfqzYP1uahVeaV7kXPuHqSM?=
 =?us-ascii?Q?8RbddAjR+1+DJSyJQ6qmgeh7TUDqSamppXemNiESv3EY6EoDZb4V/zrFDEXl?=
 =?us-ascii?Q?rYwz/tyXnzhYfEw9YLRKKcUhqeivFxlczEriMFBQGIO2Xh/Zi9cD1SStZ9QJ?=
 =?us-ascii?Q?XK9YZyF7OjJQhbB2r4rA7wcy6a6i31Ksyzplp8IrKq5Hot9SIyDJgbeqaDD8?=
 =?us-ascii?Q?YgRsaM9pFaZMUTE7r8jJZ7B1reONBkOclpHPRxAvU4Bf2zFE7fvCUWR/DMPy?=
 =?us-ascii?Q?nITzphvqt1C0hX1Yzq4EJNKQEs7oM76m9FF1RX2DMqx5Na2rauTvgSauheoa?=
 =?us-ascii?Q?+K/du7Fod//Udu4FaAgsEEF33jCJlYSd0SU9O0q9r1yYmHTTJyDUy6mkIih3?=
 =?us-ascii?Q?HR0ARqcKcWMyV4mNUVjVoc8fFg7ejfGjgobG/NYG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d978536-c7e5-4fb2-fdce-08db342206e3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:01:35.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOMNJ4xQFjLzGeAj4eO4igcs7LL06sH6aguw8qeA1vypbWt8h79Bl2tLJfhZ25lTXGjwHwISVQjXinxk7lCL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert the binding doc to dt schema, and also fixed the
example from fixed-regulator to regulator-fixed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 License update
 Don't need to show providers
 Make example complete
 Decrease beeper hz
 Misc update

 .../devicetree/bindings/input/pwm-beeper.txt  | 24 -----------
 .../devicetree/bindings/input/pwm-beeper.yaml | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 24 deletions(-)
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
index 000000000000..a3797f338f46
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/pwm-beeper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM beeper
+
+maintainers:
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+properties:
+  compatible:
+    const: pwm-beeper
+
+  pwms:
+    description: Phandle to the physical PWM device
+    maxItems: 1
+
+  amp-supply:
+    description: Phandle to a regulator that acts as an amplifier for the beeper
+
+  beeper-hz:
+    description: bell frequency in Hz
+    minimum: 1
+    maximum: 4
+
+required:
+  - compatible
+  - pwms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    beeper {
+        compatible = "pwm-beeper";
+        pwms = <&pwm0>;
+        amp-supply = <&beeper_amp>;
+        beeper-hz = <1>;
+    };
-- 
2.37.1

