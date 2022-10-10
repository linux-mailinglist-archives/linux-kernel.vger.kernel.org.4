Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47CE5F9C93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJJKSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiJJKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:17:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD76AE87;
        Mon, 10 Oct 2022 03:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhXAxECk3j/PlxWUDubir0H+fXoopFjPpbNtXL9bnclFUniQ9+Kb4/5sFtEstGacSipfHC1isRWnLTSZV18Dve7oNpmKNsMtuvlQpA1hKPJNuDrIysHAkJFVJyfQCxJAYOAeGhf7qbpigHJ8aXXma5Ig1PNH9pJG4WxsUcwcZKe64RBn+HsF7wXsCmhKl8NJLDIx8Lyu2m0a6EN/9NnI1Eg3byoHWCvV5lUt68In5FEpPhSFk/mINbnjEeg+glR4e85tBP0rtbx3uS0YEMbyreycXaUjmMXQGa9eqK0gqRXjFxnxFxB/HTzl+Z37kkUkD695TzHXZ5F7E2QIYdboFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbi0fN2DjCKk4efaVYj8slLpKl7hDq5z8yywWWJcLFM=;
 b=g8KFu393BS6LeH+3myik5DsvESRcPQzjIzI6ay9JQyoUS3vsjScECBleHzhaUWWMoRhsPVj9DqYWq8VJxapoKM5cILAO5Sjwy7npz7vzbUzf9AhVtwz1A3yYxOk1597JsymxK6qnrlYaO0LZ1yx79n4Ar1Hog/jseaic+L+66Y9OsAR7xNSMZ3tJaGBg9Wd/Q9xWw/XtxZZ7+sFyEeSCfvuegPfaMbUbEDmfBIdCxYABI1PESxoWHRrwevQGHtyxLrPkylWzE6z0d02GwGjB4lItQgK/9Jw7UcGbOOgD4iJ9Opf4tRKIQq2vPUK2WEvZbX8MdBatNZdqbzyvAEyalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbi0fN2DjCKk4efaVYj8slLpKl7hDq5z8yywWWJcLFM=;
 b=ejNMA6U6SAhufg2yWbJ/SY5tisGuRM4GyQpyeghZ/ks1bQ/uHtbr8gzqSSDGIttoJ6kqRt01zv4LqIsuvc2+P4S3gqTtv0Evd6HvIbQ/gOhX1vxAw2d+HyyPSW/1U/9Wpv+g5QizmC5yD/Z2DAjf2OeWmYWMhjEEHS+4fZuZQcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:17:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:17:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/6] dt-bindings: usb: usbmisc-imx: add clocks property
Date:   Mon, 10 Oct 2022 18:18:15 +0800
Message-Id: <20221010101816.298334-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221010101816.298334-1-peng.fan@oss.nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b7e080-78c3-47ea-d838-08daaaa89701
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwrXqwcuVlVI1xrHDzOiFZLfLSKioTJNICkm70O72GS9p23AGtAUupeUSCpt8J03lKlz6GlopDQVeUG5ZduYcYtYAn0KIiWSVPItWnqdQi9SPLfNJFdZQgsDJ+EZrmqd+exqQg5qeUyOY3Y9Vydii+URyWH1ifqMoetp5H/vI3Kwg+cnXZEgAQRDIN8d4aTRnswlVU++wcoKbAHNpPiOO5tfrwGDGNA+9EBD7Jn7GEgAZuHjeQI/wb91gTtUUciq1Rm5C/qn00BBNEOdOalUbyvk9Y78cYBSJ3FmiKZSGuT+b9MAXJaOfWYmDIukjiiqYWSvFVEtQiamIm3VtJDgbakjAoATAzCU/pO1LwP4Ow8u9CF03u/C7z9Xs5FEac6YKemQ/Oa32ariwlWoSkEObwj6U7KFKQBafAgQFp1ySDfhrkZGDOLPUxS1B1FSbV2VnhLzEUp8QC8JXOTut8dW5+/PiyE4e2GXC2WzhStjhQUvXgwcx7102KuehuXJ3OCCu/GyXgwvxu5VFbf58//Nt4FUxianjVrKUxLn+SOalpoucqL7r2G5UYSBmjKXmocojDqV8MlkK8e+fjIPbYYmVehj+sZizbPeQl6YGd6B4kG3BCIna2hKiGI4D4xhM+NFDjYf8rHGWMwOyMTXyyXHOjWovk41jilJLMppfWZonkNVCDfzyNGCZpmXW/ebZVg9sodK8eFfo7HjmRUMMFiAo+jxcqzFCCbGqvlvW0RdI6sTcCCSoy29dfpAYQ7DWQjCweumZOwYo2qqPU4ytJzC9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(316002)(7416002)(2906002)(6486002)(4744005)(186003)(1076003)(2616005)(66476007)(41300700001)(6666004)(66946007)(83380400001)(66556008)(478600001)(8936002)(8676002)(4326008)(5660300002)(26005)(6506007)(52116002)(86362001)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FSvebNHej9pZeb8HVB3kWhtnAnmQQcGSqXhuUou+fascx+gOpmImX7LBk7X?=
 =?us-ascii?Q?riqDp2RhrxEcoVwGe0i9snFVTS6YZUdYeRUt6SbmpzuQN81HT4ObNqLWgING?=
 =?us-ascii?Q?8ZJK3c/1iDNcsMwDvxPFgTk3jg4vuwdHwY0RF9c55gftcKYS3FjO458yb6IC?=
 =?us-ascii?Q?E2X4wSExYAZUyr63xZZF3vjrZD83xQBFHvCKPv1GfNCnYyaYP6u6mlA0nprm?=
 =?us-ascii?Q?P/qiCRu9vTsEpbJhPS07CJkjZKHw9Dev4TSy0DTdsc+B9xWNE7To3iDmfdzV?=
 =?us-ascii?Q?0e5i6jZYIBuHlVYMl6czFCsZNw8TLsiwmlO4KRFbAYgRGkC7wPc4oOgODEwn?=
 =?us-ascii?Q?1IxeguWddapFXfIVuP2HN0NiZGZAHHVIeWTywr3HW92kGCekynjiTUiYejrp?=
 =?us-ascii?Q?OpNUPM1yGfrMO0J8J0L91cDsqlbRPGCiXVKiXW/OSJThczoem+ndnHrfhDa8?=
 =?us-ascii?Q?PHBrNoon6cpQ0Ei4F1NCP7NiVSIVT4u323Q1vY5IkWxelAzzmDnHUxTKymA7?=
 =?us-ascii?Q?Ze/y1eWaoOtqdXUKiXU8TlN/tm0pa4KL3wHMG9JBt/5LA5BKXbmgqYXyUZzJ?=
 =?us-ascii?Q?4KHsWboids+dWKxwN6tDZnTJJAU6CV37e2Sy0qUAiXrAiiAGeuU/HqqzEuJy?=
 =?us-ascii?Q?X94+9U/voYd34jpEQiJwh13QBMsGc0tqp7vZMR1PAnvqAObkzC82c0AvCMHF?=
 =?us-ascii?Q?dVMUddQ4OkXMvyUQGf24ANafH8FBzhle2+JTvkq6ZILI6oxR+T7j9BscHv9D?=
 =?us-ascii?Q?xoDfpBRDZVop7zwavUgfG3byBQuYv5P1o8w8fYDEk21RmTWZ3Ebk85wsA6HR?=
 =?us-ascii?Q?/5acVroonMiSJQhl8PgPd7qtE6B2Pn8eCzDh4uJTttEhrgNakQesce5Pxai1?=
 =?us-ascii?Q?h9qB+LYVZP9JRTJ16CftiE4xoDx5Ad+c+n68s6XGZeMPKD6XNTzBYFjYv28E?=
 =?us-ascii?Q?gbJgWpBmPfg/ObkDQ7a1FAH4LzmhWaQeofthq3PC2uZl7ORv4liXWftZpzSM?=
 =?us-ascii?Q?6L6IXO9Aje2zBgx0fBiAhZAFy6m15O0EvTYQtk+2G7jgUgL1xd2zpw+/HwGn?=
 =?us-ascii?Q?EdFdaGSi5Xp2d+qn0A+GjcWr6uPlh5SOc7RrLYEJ+vzWzAXe356ptOWDHM8I?=
 =?us-ascii?Q?nME80xqlnSCnhrRzV7bLNahm6UW6k5Vz0enF7oz3S1+you2tQGmVLJcx6hwP?=
 =?us-ascii?Q?MCmMGjkwUaY/u8KPjkZMbetW+7eh8L1I3SDqJriPSg9qzOYbOOVysBIBpFTX?=
 =?us-ascii?Q?yVpeWsA0Jd4X9zKDHwtplLacPFINOf0ikE7TUIcpGUfjQ3U3UQNBebE1CHSH?=
 =?us-ascii?Q?tWIfDsvrXeQR5CNFV37gjVJeOzxNNiCBWs/zl2/aXGj9W0+27hPC5ZBlL3OC?=
 =?us-ascii?Q?H7u8M2C6q4ZEhLYWqX3V80gAZK5GpsKcdP2zDYvWha2GfnqgrffXZGttOBvP?=
 =?us-ascii?Q?hC92VGGmaeedN+VErTZz2CyH4F0zBD2SbI37HNtnwe5UmSRIzjeWC2hkakzy?=
 =?us-ascii?Q?Hgf7SU/bNRY0RjkauEkS4GTayIRi5zd/F3Gg/0y6c6BsvX17I1Ay/QqTKM+7?=
 =?us-ascii?Q?F6d04/BqS0jTusTy6K26a12N9DAJ4WCc2eilWc92?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b7e080-78c3-47ea-d838-08daaaa89701
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:17:09.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdPaCOcaU6EbTTx4R1FIPYGQrlFFJJfHWRuCfLzUsKgOLRu166GdWPVrFXVKEqwXf/ZG1jdByyU9gVx7Ut2S+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add optional clocks property

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/usbmisc-imx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
index c0741ce9b523..bd2d3d95f5a6 100644
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
@@ -27,6 +27,9 @@ properties:
               - fsl,imx7ulp-usbmisc
           - const: fsl,imx7d-usbmisc
 
+  clocks:
+    maxItems: 1
+
   reg:
     maxItems: 1
 
-- 
2.37.1

