Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986E667C6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjAZJTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjAZJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:19:11 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2123.outbound.protection.outlook.com [40.107.247.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4141D924;
        Thu, 26 Jan 2023 01:19:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iooiU9DScfZ0t2AAL65XOiXF3gs99kN/f3KQcid6z5jYBQbKC0c89gyfTgCCx9A0hZasVpTVaXEsy5a7OgWlM1BrizWcjxer4pQ3VAUmWZptgjscrwlkd13uYGvbUFlPA340AR1QMaqhsAXLRZKM1zfXYYjoq4zL8eMxFcbsDl1edeK7byDEEfMSLhfzw5iaaCk6M+wJ8Gx3e9AhQyg3o1/wR+bdpYobXmFcIPI8zaIAvTdpzvFszQyvZAOWeQmL+V148bKkQnnFpT27JYk3E38G6z+b3Wu+bGwGP9Z1U672/YkqH3tgct1SHs/I52sWUj+h6Cg3/muZjx+cwixbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIB5zj7E27IDWEDHyY0jFQ3/Le3f/bBRm/eOqWzpGbQ=;
 b=A1l5n1RV3VD2aJWzda0f+DNbFf7QbacNXbGMrwmWmKL6B7wM+xmVS3mkQ7kLKLyBcWcrUlCExx5O9WZQZJ27pkiD132JtxrGD4lGRfnxA+HDfHViko+KyoCmPZHy2cz1GZNQW9B+rCGDMN4EcuwTcjr89R7wYm+NgjzpBgW1907I8hQnTGJ/RVOX/cPJZW/oRfl0e6m/5vPfciOYQV6M94J74/+rmsuqxxI1bRGVpNvMOKoNN7dfNytZ6x4ITI/8oh7DzolUX9VSfLSYv74MJ32sqFYUfDFb1izhDHg6Azlq9EIWIx+XZbxmd22baiKmNcs2YI+wtK11UfZDZ3gCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIB5zj7E27IDWEDHyY0jFQ3/Le3f/bBRm/eOqWzpGbQ=;
 b=wGPSQ7PV2O3E0sJICJ4j8sIZXFT40P0x8rZLZ8jB3lOLMrO/+xkzqfq5g9xNvqfC+ukivDc3G5Kd08OTa8lGLRWo8Y8QCFGViGOHYN4FfnMMjyGEbuoasg/3bweezrQbpgC155eztCphX37i1xTsPRzovU+zOUsw45tNVluqy/YRaYboAqcOzLIUc7gZ9wcarGWDxhmhOmYTc5Oz+XLM6KRsSwwaNTq96q3j946isTknGNGCPXZUrjDOmJnPGkQJcKoU9vvkDK91juMHA49SzOFBKBD6R0SIMM1Hoppx6BsYPCGEUrb+u790gjtLaQklYSgKrLjHYQV7WDEsoLWwrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS2PR03MB9516.eurprd03.prod.outlook.com (2603:10a6:20b:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 09:18:52 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 09:18:52 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 4/5] dt-bindings: input: pwm-beeper: add volume
Date:   Thu, 26 Jan 2023 10:18:24 +0100
Message-Id: <20230126091825.220646-5-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126091825.220646-1-manuel.traut@mt.com>
References: <20230126091825.220646-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS2PR03MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 560d7c50-2e23-4b7d-98d6-08daff7e571f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1w/J4O4CN9jtS4XenrH6ylfLdWnOwiUzzF0kUY1lRLHvkrzpV8J/63HG70GvDjCFqrK3G/cfRXE8L7Hvn+vzRg0wYA6x6+22y+WC8Zz3Awun7/UeJWajULh9DD/sCcoH8WxZr/XJ8tABSxPIgUWTIMNQfRfi3WZOeQJsHiKPxkeO4cQSCv+f8J387ujuH3kS1JVxjmV0P8bh2UKV8pKCA9668FEBVvFpXXvL8dQ3hzpeZ4nyb+fQ970XLbBZ9VhwSBi35+taaGPzabXP3Tsz2p8e5OTxubcbI6kO/MDDd/th/J5AtWI7WSCouYj6swEdPQNjtuFAffjvjEnIYGXenMHgNS9Nhrq6qVTnQnpzk7FSTkzFrNfMUDMGlqrxDp58ATr6cZNUWw/mEjNfoEcdtdp75EgcEG/MJ2boQKNny2ncy7tIxDuagVCtm6JUoCuVfVBMyjheVDv2gENWueG08ElylQpw7wLkZK2T7aRUm57qN51FXURecgMDcN/1/ilwliVU+VlYzsAXT05/hSOqUruooQQASyPqdqHsluOtdwhM2Drsy1fsDu87atokxvL87mdLjiyYafmD5b84amKdZr2oZNGYQ5E5Mdbxm+CE8ykupPY2MBxHYRlS/4BmaxV0l6YBIGcbL3ym4ROUhYgefSvyubbKXHIL5D/fgsP456fier8iYddckDtckPJ3T9G2cHmewJwQXcPRy+w8xXz2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(44832011)(2906002)(38350700002)(38100700002)(2616005)(1076003)(6666004)(6506007)(6512007)(186003)(26005)(86362001)(66556008)(66476007)(6916009)(66946007)(8676002)(4326008)(5660300002)(36756003)(41300700001)(8936002)(52116002)(6486002)(478600001)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUCEZXaBy7h06WakU3QcNysNo5rYkKzoirgxKs8wUCE8pERkY++dLuEfNNvT?=
 =?us-ascii?Q?SX4tSMcbgZbeRZFYGBrY6XlA0I/EaH5/6MG/Fm21b/s23favnb6XBzv93vzg?=
 =?us-ascii?Q?eWBVePjxXNbeHfFmbWo8vhXXeSJTx4TwO0xn21mc3Q07T3cc+IIGSCQP2hnt?=
 =?us-ascii?Q?MI4pxtT43f0eP560xSk9vdqUQTU3OHiah0QwfMoH4gCCmbf2znpKriXpXNC9?=
 =?us-ascii?Q?vgaSjUrbEno0RSMy1Q4MeRoWyYGoB6ANXMjYGNBmYCyzF7WEmseZW9G6bFGN?=
 =?us-ascii?Q?O2TFm908/hBnVw/bcTPCV4wlCil8FJD5p/q9PTPAGHb4TXtrOPlKSou3Y5mA?=
 =?us-ascii?Q?SrKAdUia9MbFri4yG3HxOX5vg9CDPucNPOdZOIp9znueHjjXA6pY/o/dR/4y?=
 =?us-ascii?Q?ycXhOC9nNzGAeVsSNIG1qoYLsVRYauonYdGZBEECgOgnxSODW0lnlS2wxBtj?=
 =?us-ascii?Q?COFpEUjIu4AT4QByrSTSu7MXnVl0qeMIXx8y/CbkgPJD51hzOkBdMlLG/sjo?=
 =?us-ascii?Q?G1BQA8Vd1lO2wvzCmVmfouz05wRHdCraKms+rb+L8sVkDL9g6mKd5hQGxq0X?=
 =?us-ascii?Q?VKhXM9MA2wvMtbZdhZhUNdHAc/fQjZDY4+BrJ3A8BvOMKcIZMCJEGQ11oblj?=
 =?us-ascii?Q?u2lZ88lGnkEoZ9LeRaNm5Do/137eYzK+lKjqoHICtGCJFPQW8H2PKvFcx8ou?=
 =?us-ascii?Q?VmqIxoKXQlIZBLXOUmpq0A1UT5B9I4GOqwtBFlLnhu+GXg/SG505u+jQCidO?=
 =?us-ascii?Q?gVc/eKfXWwgWusGlj7Ejmgx05Xe2pNjSCjdW+lhUZ14V+kqjGhzgXyF+uMLH?=
 =?us-ascii?Q?PdyAKO6c4RZ7BWazDsC+g50BEqUYg/O0/6SoN3PdBJKKYPHk4F2Ixl1z7C28?=
 =?us-ascii?Q?yhUOFtPSDbWAqyzlp5GCayFEruhZk30k892V/Mt6y8d390FonoDQfJCIRW4c?=
 =?us-ascii?Q?vBXVa3CtKTxZp8rGnN9+/4sjRLtApCWqGXIsLl/iBhQUTdb5qurCMRxhjkef?=
 =?us-ascii?Q?HMqQMe5e1EG3qAk4pvPkMBHGtpV7cpSiyZNpMHe5115g5KNEhO9E4iQyaSFn?=
 =?us-ascii?Q?d/ucupe2lFdrdmNBIU91yy2gdsenVnKK8660lv3qnsDoMytrUtsk+VriuVEQ?=
 =?us-ascii?Q?DarodQKUbnpJmUEW/V18bjBytX6QWpuT1OJFXe2/F8IwtkzVJmodKkJ7AlAc?=
 =?us-ascii?Q?k0L4zTmCTv+eO9YADcKrymlue3XS3oXKH9iF29f1g4nOPDrOb8WPzCmE0rLi?=
 =?us-ascii?Q?Wdm7O1UNsQqy1DFciakwRdLDqoLU483FqKGSRyxLpbFhmeSYrCyjleVE2dRT?=
 =?us-ascii?Q?yCJfD2fjFNBbbSMVxyZqJsyqtAmboupbgYHXws8V6MqJ8f9cstXmznpsK3B1?=
 =?us-ascii?Q?DrpOX9QbZVNyVcx8CJABVpxEVDeyoxhSXZOKP7fHsCGkapjKRP8v5S2sj0ej?=
 =?us-ascii?Q?tUwGnd1E09QA92A+ewlAp/rq+gOi9v4rRxYOKP+GIQl85jdwfZlnxzRnh7xG?=
 =?us-ascii?Q?ePPWIi+Xe1r9O8g/madLdx1/TipHkz0KMjWCxHRzKZobdv0PTjdouce/PkhG?=
 =?us-ascii?Q?YNiHid4xX/stCEEf+1OhnMwpFvfFc4RELGBrijsx?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560d7c50-2e23-4b7d-98d6-08daff7e571f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 09:18:52.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omsdnCZQRUnWxhVWRA9vl23w5Uj60eBk4+IFuR5jt63GTA3Pp6NIBLhOpvTqhHvbU+T5TGPGwFDSjWdp6JKZJA==
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

Adds an array of supported volume levels and a default volume level.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 .../devicetree/bindings/input/pwm-beeper.yaml | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
index 351df83d5cbe..f1f9283ca855 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -26,6 +26,24 @@ properties:
   beeper-hz:
     description: bell frequency in Hz
 
+  volume-levels:
+    description: >
+      Array of PWM duty cycle values that correspond to
+      linear volume levels. These need to be in the range of
+      0 to 500, while 0 means 0% duty cycle (mute) and 500
+      means 50% duty cycle (max volume).
+      Please note that the actual volume of most beepers is
+      highly non-linear, which means that low volume levels
+      are probably somewhere in the range of 1 to 30 (0.1-3%
+      duty cycle).
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  default-volume-level:
+    description: >
+      The default volume level (index into the array defined
+      by the "volume-levels" property).
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
   - pwms
@@ -45,4 +63,6 @@ examples:
       compatible = "pwm-beeper";
       pwms = <&pwm0>;
       amp-supply = <&beeper_amp>;
+      volume-levels = <0 8 20 40 500>;
+      default-volume-level = <4>;
     };
-- 
2.39.0

