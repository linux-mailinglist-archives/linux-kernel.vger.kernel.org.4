Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BC3686A28
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBAPXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjBAPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:22:47 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A185728DB;
        Wed,  1 Feb 2023 07:22:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAMAVq8wkjY++rzWR2xaARPN9PiTXyZ3Bn49u6U4MToiovvnriIVF/UgUqOePurcXlcE5PFvdzp0+/fRwWUM4N/32YvYqfUOc0kbMUQiT0FSoEA5f4u1qrOpA2XSepXfPmpltQvHPpkSQRtAUK1+M7POvVfyggxzkyFbGvnx1S0eWRYZqXq9KW8nTFUDqs8EIIeAygmyFXGayv5hy9YPNQ3XZ0AQ8pGFIot6dzZh6E5j4IJiPwc4A2psAWQqeUSeexJ/1mJoycjiWvZgoIZwS5sYevmWdK8Aye7qsfRZ7ozJ/94poP4SN1Pvmo0rKHfVqZXqBP1TK03k2vVk0+LWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTdZ5C7RCOVyP/DTdWFPwfIV3CK1R6n0RqlQ8pzvLog=;
 b=j+efktiixUuc1uhLZHEF8J6ZDUxSRDY/eYIOZmayHDXtFdgtJBpcInYc1DvnC3r3SobooHTniRUECe8DoPfHMmmCaGBX+nL7xRmtZWjmrt8aMacsxYskQWaYHrDxExs517WyeIfyn60GnKAC5cw86ok1hKhunYOLFYsoYU7HQIrSwmlpOLYhq/4qc8NdxByfYnZvGzQPeE5pOMegtU/ZpGOtBotRuwrnFHXJ+sFBkQm5vqNoaF93fGroPfcaxi/B0q9a9qwbW2k5oQ89/KQSSUWQgELKSHRFB4e3zQ5a+ctsFbvOHYSwa/JzHcX59rYfc9gdPQ+ZDKkGRvRaPeKdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTdZ5C7RCOVyP/DTdWFPwfIV3CK1R6n0RqlQ8pzvLog=;
 b=WOlQJLYMI+0FALBNoqEzhzFg1hI4JZcEei0k2Y8XwGRmrqB/xXajrIkXYk81wD4fZRhBOKgCdo0PbHtHTHxTTfOr9igKT1EuTgMudhmGtc3d77WKohDnREpJ37LGZcA7QfyksU7yHAW5L/3G/M+cEwCdf6pIf+CSWakp7kdMdz84g9JQbh9ZIf1B+bCs6ifAd09tbbqUbPE5if8aGN9ihn1jdpv5j1J3lHVIqdtl5lblnDrNLMvvzhiXIoE9VC00U24rVsTfevN0ZZzXd0VRA84e+aX8JfVJ1gPL4FjC2Qvs5vPAFLmqmQ/OsfK6FtOk4ShXBJWgUAxzZnETTGyRYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AM9PR03MB7380.eurprd03.prod.outlook.com (2603:10a6:20b:26b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 15:21:34 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 15:21:34 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v10 3/4] dt-bindings: input: pwm-beeper: add volume
Date:   Wed,  1 Feb 2023 16:21:27 +0100
Message-Id: <20230201152128.614439-4-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201152128.614439-1-manuel.traut@mt.com>
References: <20230201152128.614439-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::8) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AM9PR03MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb83871-209d-4888-c9d5-08db04680116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsidGTpYwNdFrb1goZh4nDR3tBGTNl8f0Gu2Q+mnib8yzrEFXktRz6Sdsoc+V4KRdwdII/xFYpioVqqyx3pGf8WvoRiIGQg9NMu/Y8C2pQB7bFCUGheLzCVzSZydCLEBLi+cP/qkT0W7yeNeBAr+NisanC/1X10eXYWOsr61P9ztDJ/ylL4q6gAkvPfIYbAgT0ztMx8k8Eb456kHPKNLXx/ujLZ9OmWRksPY9N7myVS7HuYkmcQVrsOefZPWkckgIo2K268+9wH7DsFHba0kuPsF1inQGkSM3MdagiiQGcytCN+9JAAQrojRHZOjVAQyftOcS+3srgWHzFrtkOCKR5nrnU2Aw9ZW+LyoUf40VwbA2kEwrzHBLUE0+MrOZbiBFUzRKI5+S4uEaMJ+mK9dBk9vNxV/lA7yr6YBtiEoJvJ45lCQS8v4dgw9/X7lpKDGqPpNdDEDLpgSUvhDXZXqedTl+8QjUbUoHL0VESf5cWSui7hKH0fgBhlR9b6o669zfBCQUx5RR8/BCaTkpOgIF0GpFAGctAV1hztOhVtRU94m4thXKYPzGXm/WIHVCSD9TUu0fHRa9lFZLG2VHx5U/PUfHD2HcS+GT6MqKNYZnONdJcAjs13M4iXnbjgMK3tYRYBu5/NHx/g6GuKx/JiF05TkOobs1oxxBinpGJUnLeDZFewaHFVvhVCIfWMKgS1uxBlkJ0b3LBQolNKmsrXdjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(38350700002)(38100700002)(54906003)(36756003)(40140700001)(86362001)(5660300002)(4326008)(6916009)(8676002)(8936002)(316002)(66476007)(66946007)(41300700001)(66556008)(44832011)(2616005)(2906002)(6486002)(52116002)(478600001)(186003)(26005)(6512007)(1076003)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y5CJ74pRbRNoueSVIfZZCMcLdo13shVKKGc0Q+2zk8kPs6wUW7jRemoPtlWF?=
 =?us-ascii?Q?kSn0sGnmYuSlSVsOtlTg2KarbwFPCcWNovMnzfg3s5bFUzrLUB7a5qT1e7qC?=
 =?us-ascii?Q?Qr4T5mHsN/Po2NiM+ntkaqkAYnQHpnb1aWvk+OrezMJp4TV2n+ZhAH2xCR5x?=
 =?us-ascii?Q?s7ataLsj2EdZ/vofT7qkwJqS+eavPCaqTjtNlhTiuhyUngMmtYqK03BMCapG?=
 =?us-ascii?Q?JTDU7/pF7nnDGrGxs4xq6GYHcFMAIAViy3sn+dX5HcM7UiW8KAor2wZFulYe?=
 =?us-ascii?Q?8cROmDHZ0PAqZtSieYGdFogXF6dG22GXPwH8863SuRXFp71i0H+HFZfqRGCS?=
 =?us-ascii?Q?/vHbf/3QC0UDjWMsw5mtiqBXEdQDcyhnFgxe7pGakjIhzp66u6jdc6v1b+fv?=
 =?us-ascii?Q?Xodvum7UKZ9YyjtVVB2tNFT+gdiF+zOjX0QsMiNu8Mt5kSKoSuWrm5IIRdRE?=
 =?us-ascii?Q?7/qATixMIk2wrYbnk7RJxGMZlA51MHDIIFg+RuvzNpY9eN03pL6p9Yao2taj?=
 =?us-ascii?Q?Ot9i7WDDSpY/I+jpK+oSv/2a4Jxaf9caje4smUpSfslEXYHeFBG/PB2n2T9W?=
 =?us-ascii?Q?6fM+EgNIglhY9ltzH0abHFKBy+rJ2FjtRkaJAO2EfBbc+MsEf+6My0BuiP3g?=
 =?us-ascii?Q?pGtOEszATEoiJ1DjAk0Yv6ZynR2YDqS05LZ/Bg2jHhUyo5VLNuXK2ngYx/Im?=
 =?us-ascii?Q?/GeMHLL6PV1K6Gj7QyANkevq++665lw9UD8pIdCgBNZSSsaVfgOKa16XkL5A?=
 =?us-ascii?Q?5cAmB8BdQ1pJgxBkkLzeG3LSiL0PoMOLMLj1Jdh+ydRaTcXEcvWKfalkgK8e?=
 =?us-ascii?Q?MO2V63/4u6qim08Cj5rFLhv0/8yIbdJkGcsK0gsnEkIR/ih48viufHoMkFZu?=
 =?us-ascii?Q?bpn/N6z9tckw0oQ9bzN8dAubc5EJDjGvs331ZqHyl4zflvKKLvaLRtxP9bOW?=
 =?us-ascii?Q?PtrOJdAja84Hx8BPRe1aTgvWwO2USztj42DXOCGIWc0x623FJ9pSiQliA3rF?=
 =?us-ascii?Q?08XDG3+h2ztrAs1Ldg7TmuWEcBIOvVGA7mUsGln0HpiLPxtFbgME0l/Auac3?=
 =?us-ascii?Q?9+HKDy7b71AVpifq3XAYmuAqHiAVYjt2bdlxzCb4Yvu6sVhNnWe+CE4OZuXi?=
 =?us-ascii?Q?WMt0s8JbN8EPbcshAWzcVXm9D+5j9ojw7luQyYfBgBLbd0BLX0y4PR24lZZK?=
 =?us-ascii?Q?FxM93wpohEJGw0LOFIkepZBx3VIfHIxsJ90yVzMIb3JjAac6v57L5S92P7wJ?=
 =?us-ascii?Q?RYUgS3lb7TPVp34ehnd/KRVbeRvqW7csVolKJkNVQfiDsN4+tDPTcZg62MBK?=
 =?us-ascii?Q?1VDrNyPhWuZPT+NKD3yFlmQ7lRlezq/Y74z8AxRpiDQoF/jIxjUB00MClalE?=
 =?us-ascii?Q?yYBZN6evRNG/bwF4zEtVofST2ha22k3y5bf/GvxxKlbWQ4jyL399yb5PzCe9?=
 =?us-ascii?Q?3pI93pqQ1x+P8/skPCIgXie55UXqp7I56BcaxEmGJMkTt2B/ebjmDc71MEza?=
 =?us-ascii?Q?QADBTarKvVhBgNWgUpYnyc/t0o0f/3SDkUJxLpODIL0F6j4mfwzJfROQRp/c?=
 =?us-ascii?Q?C236KK61y4eAAsiAlRlX6HUX2k41KRKd1tfWXLmX?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb83871-209d-4888-c9d5-08db04680116
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:21:34.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMuKn+2Pa40GQeI8rNmtqEAsYMcFNfrSAaeh8FT0JRLaJ8B3zb69CzxemPtKbs9A7F1YS8WKmMUeqCblhwtJbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an array of supported volume levels and a default volume level.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 .../devicetree/bindings/input/pwm-beeper.yaml   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
index 1ebc3a46d934..6599e28ba5e6 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -25,6 +25,21 @@ properties:
   beeper-hz:
     description: bell frequency in Hz
 
+  volume-levels-bp:
+    description: >
+      Array of PWM duty cycle values that correspond to
+      linear volume levels. These need to be in the range of
+      0 to 5000, while 0 means 0% duty cycle (mute) and 5000
+      means 50% duty cycle (max volume).
+      Please note that the actual volume of most beepers is
+      highly non-linear, which means that low volume levels
+      are probably somewhere in the range of 10 to 300 (0.1-3%
+      duty cycle).
+
+  default-volume-level-bp:
+    description: >
+      The default volume level.
+
 required:
   - compatible
   - pwms
@@ -36,4 +51,6 @@ examples:
     beeper {
       compatible = "pwm-beeper";
       pwms = <&pwm0>;
+      volume-levels-bp = <0 80 200 400 5000>;
+      default-volume-level-bp = <80>;
     };
-- 
2.39.1

