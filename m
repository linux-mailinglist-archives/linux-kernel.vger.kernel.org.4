Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFE6680FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbjA3N5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbjA3N5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:57:06 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2098.outbound.protection.outlook.com [40.107.6.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E45739CC8;
        Mon, 30 Jan 2023 05:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6whfNWDWFrBv0v/HPGr3qxFFCcM9LzJuFe6LxGLSwx8yozb3BDe45zEMjsnrmnnOwQkuBXpp/biNpEHoCpJscG+cKpE7fM2cYJzn6dRIfdSazxSO/dv8g/MKJHi5fYgntWc9G+1tdy2faICbw6cMs2wn3LW45GrkINKez2kscvhcWQPV3PY+gsSOPCpIIFh5OlXEhOrvuejfOJ8NC1KhAFdEtPwbJ1/dKfCQ08XyokoEh+Hx8V2s3ecyRYfRY2k1rBiWinqMpZLxxmMkiGDheQEtYVjyWrZKyLSpD6d4LmvHg1ZYolIJTaSNZPKrDuAQliO0TYO+4Jp7AuR8Hqc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnMXXZbaRT5Boslq9/yO97/ciaZaatrX+ihEoh4DI1k=;
 b=MIJEiafJJBInEp6cnPp9GlnaCRJk4IuEEfotlTj9zsD2SFduj3D9LjzjpFyMJhsn1GeMOySFsiCfX63XEGUi9NXdt2pwh4Ld/WcgHk4kRzbbZ0nadjU9P3ZzobCu++5OFeObzakO/1en4zy3sTsZoPYP+idSnD/doLEa6Ox129WRLQ9r2hKbNgcfyB9D9QFolYtSpkJQnT0sq7HBoagl6muISLJq4cuQ//aTlxB1TFp0/eM23wj72o0h5D7JD0+V3MPgtJR4c6hzqLb+KUUh84nSxG13TrWs57NHMFQAZHLIUyYkyl5xcLOwxFoBCfHwIXEDyU5ZivrmYK1BDllXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnMXXZbaRT5Boslq9/yO97/ciaZaatrX+ihEoh4DI1k=;
 b=O3Xdaw+iJpUYxyPClvDay2Wlq0QsJYSeyp8Pg5hxV2nCW7IK24oSJZcpMsMwfm0XZJNccYpu2abwoA/GXGr0Y1JEL7OYYBf7ECWB/uSNo6IyKlVTcojxmLX5ABxMYPT1ccvi7etdcXHXFFslvJb7vkyRtAHqK7tjCZ+bfbRCu8wlBH0IRIS75pZTmt1U/rEAHFL2IiPq24l5fc2+FEOv5yEp88i2Q89gECw1eIzAfJcYX2N0EDoSwVi14cbpCga9akyVeSM/bMkq4KPokk1FQdRggYA/efKrASmPMHDWh28MUs+YToeQDqNxAzYQAzoD99Bv/qeiZH+GFhODt+zWbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAWPR03MB9081.eurprd03.prod.outlook.com (2603:10a6:102:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 13:57:02 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:57:02 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 1/4] dt-bindings: input: pwm-beeper: Convert txt bindings to yaml
Date:   Mon, 30 Jan 2023 14:56:47 +0100
Message-Id: <20230130135650.1407156-2-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130135650.1407156-1-manuel.traut@mt.com>
References: <20230130135650.1407156-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|PAWPR03MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d17eec-8258-4155-4efb-08db02c9dcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmoKjL1NLOfXZQ0/eNeGHB5/F70UlAhWRwmjs7npzIX7C0R4N9LSgZYIU5AyVDNx0Oiw5cgYhgwb7qRCb1y4fn0hHrGQ+JMB0n+dcRRidJeDEf9aJEgKxVb1dzkJYC/xWNSkxkwejykd3tXcQCwGZWwpDWUxBWoYtmteuR0/MDYbmc/KvaJhVI0wzKcElrDj4QKYPVozuNAuMKcFuYNoiHQDODldKIV9CJI3E4nqiJPaXZ8QWabw4VS/zl0Sqh9YuqKBWJa2ECxxe2eRhqV3VUs9ovx5WNih7PdjITk2zroOCrjglmzssjD8lV64eCeIY28NT4inrrpeyQZIg6wqRT/FetrLlZcLg6MKNPhSI8UM/OQ7HfWpIPd9a7OSWNMCeJIrYNeYjUOcYPYf6j0tDKlfDj5FQBwCNXjb45XmOXTABteUp5MuRheH82Z4YtPRRe9Kb/5pNavIP7mAXzPv6wULNcIBbzvtvJROy80oADjuNn2f1YSMKgsihNH/fVviZIBuU4rZPwRRuC53A+GF0Lho/VwZkyrrgDMrcIu+4mtn6uFSsKrrCbUz8p+MSb2lpjQla5i6PiLO2bvnmU0et2jljRHjMynvaTWdMcvYfBRwb/HAPc5PWZwBlajllbRfOFAp+EJLR49GZyJ6FBE0Gac143rRIcSKA+CHf7SWlCubdno/nRvKq1b17LyHHqCxE1s+kOel/tbARNMsHSiwAfmLGrIjGGpZLzqG4qCTbDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(5660300002)(36756003)(86362001)(44832011)(38100700002)(38350700002)(2906002)(2616005)(966005)(52116002)(6486002)(6512007)(186003)(478600001)(1076003)(26005)(6506007)(83380400001)(54906003)(4326008)(66556008)(66476007)(8676002)(66946007)(6666004)(6916009)(316002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERxnyjH76DIUyNgxc3KVXNzotiz+GwnrlsI4CC9kKHqnAB8wIWiyHwo6HNCy?=
 =?us-ascii?Q?PcYv7fjbPKcgQYQ3TP3BdrsxcnQZAB/T5GEM28jUyItImLeX2pUFj+Num6H7?=
 =?us-ascii?Q?/rwQxguLHim4xOff9uPigMlaod5nHEJstJNZChrJDnGetAVDsNmOjFGAz6sJ?=
 =?us-ascii?Q?gy5OJkPQpkREHLVoyH+3ZIeZXjaGYDhY0hkt9QqmrbtzgRJjbX9herzmNKa1?=
 =?us-ascii?Q?Zz76Bl0BgeC+MY6mNbMO0DAG1zkY3b+CL0CYhbSv7eVQoY7TMTNkls1BjdGv?=
 =?us-ascii?Q?VMcTrsdicmXB++/vvz2+q9VDrwqqDWwRVHhwQZ/ppBjQiUpGfx2wZE0rcEXd?=
 =?us-ascii?Q?cmsCab3iJ37K0/tSrGNB9XWkyO0ZeWnDa9qd3LXGJO4WnofrKruvjQ90+DK3?=
 =?us-ascii?Q?Wk/2dceZR300nJSv88VvaMS3p9GQXaHwWn1Qla/P+P8AG7AOoXd6LzSGlqXE?=
 =?us-ascii?Q?bDO9pABAYzV3nc/VOWKv6ugQTN/n1jZRFoA4bS1bWdquv/S+qIjWl/QaoIfX?=
 =?us-ascii?Q?E1Ri4qkJkrkKuv4qpqa7j5d/hPe6OsZm+ABLsQHQRWindeiHNOUuFKLOWA7v?=
 =?us-ascii?Q?hd81p6t0wLZOhHLYy+nrHoYZMzUI025TjwLkCWutVB6fNFYAnfpFnB2+xkEf?=
 =?us-ascii?Q?x2iJExWGaWfTPOKJXO8RDIiuJ66SPOXWH2ZXjLos7udtXlg4aYpwttaEsevG?=
 =?us-ascii?Q?l++cdIghOvIR49+KfBvSnNkKRfx84bh0hvzcgp3tuifjyArFJ8GIttqTyeUw?=
 =?us-ascii?Q?HLv25VY3RKI9IAMMcVIDaq9LruIS0TRGUKPC7YsqR/YU5pO4Cs7zBZayF6/B?=
 =?us-ascii?Q?IwZ95AOTxzFL1bg7BHgX5R/mP41nhinUh8lHDhMLhzfrn64QtcidOy7Qv36B?=
 =?us-ascii?Q?xsBvnlFARzHuQsQdg4m2Urc5o7qjx1Iro5xYh4yRPMA5VAhOdGMGfS+fHGoE?=
 =?us-ascii?Q?SV96UpGIAfYVpMwXmoCCveMFOzwTsV2pb9pE4GW8ZShXH25654Px578t4yfY?=
 =?us-ascii?Q?/MRydpf8OcMEMbFaojtI+rAJGEvztp1RusYgALM/CqgN+PL/ii/yFz4d+vtY?=
 =?us-ascii?Q?M8ZTzLNU03mJfIHGYJj2M9pk2ayqofz9qbEfJEygZO8nTa6coS6lDqb//ivL?=
 =?us-ascii?Q?vO2TI2ya+AdmevE1QiS+Dwr23rvV9EXWZetI71fb4gU86l9XWTY2z1h5GEbV?=
 =?us-ascii?Q?1Ci3gtoSFdF9r++5dSU2v2pek8uEdCNKu/aaONEd104Cnj/ihmzF4C5nY73l?=
 =?us-ascii?Q?I4W1DHVJMYYc1NWOIrn9mtlr8dpHW3uA9soSJBv50oFcr0+EhYbQD7pSaHsx?=
 =?us-ascii?Q?xpJ7rPPWWoL+WcySJK+sbuT/SNWOcuoi5dNt1X1ZIz4aAA6i7oxdhr4FugAJ?=
 =?us-ascii?Q?CiuRhRcFArIddXe7yD6pWxkWGhAPytd4yvB7Y+wQbEN178l96Pv/yLWu/TDB?=
 =?us-ascii?Q?pGj3R5rq1xLMZm+xLIH/0dCAoTFFpwVK4YietmqVrkNBi7i0jvvmYZCuI3N4?=
 =?us-ascii?Q?NHfZ5Ng4JXiNCbeuSyOOBDppTEFLiy/U1+PaboZGT5Ja9MqdP69Ka8/6oaAt?=
 =?us-ascii?Q?aBrrSmJEUmCdGFlQ0Yldg7DoUpHgKnW1VMfKTxQ9?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d17eec-8258-4155-4efb-08db02c9dcf8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:57:02.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZIEItxdz3s5R0WZielCuZim+dpnoUJV0ZuGbc3L0/NZEHR/8Y5SYWjhvqfC+009iKTV/brAkXYlN0mD+XmZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9081
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
 .../devicetree/bindings/input/pwm-beeper.txt  | 24 ------------
 .../devicetree/bindings/input/pwm-beeper.yaml | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 24 deletions(-)
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
index 000000000000..1ebc3a46d934
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/pwm-beeper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
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
+      regulator that acts as an amplifier for the beeper
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
+    beeper {
+      compatible = "pwm-beeper";
+      pwms = <&pwm0>;
+    };
-- 
2.39.0

