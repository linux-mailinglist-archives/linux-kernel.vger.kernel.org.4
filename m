Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC86C08CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCTCCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCTCCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:02:21 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5872F618D;
        Sun, 19 Mar 2023 19:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z56H0P6NX6Bmx0LSkq5IC9AaARM0fCJuURguJlODov3gkb1v4YMvGgst92P+Jma++oOHyTS1F8naksOjoZuM7mRCeIeTjThnk6xPy9J+ZK8e2RqFz87HzDbbT1yY872Fa6FKpo9oSYNSLLcdflqJcZrFwKBc8rr36zAC0fw6HIxj1YaYhCdilFzWffptY4SIbCa8JaFm17YuSbu6HNFelYBn4Tj7F7J98Ph8A9QPDLOcglU/gbevHNHAZyz4x2AuseH4UQBE7PU4t+df7CAENn2cXK8GBccvC8ptoOelM3zkEOMYBZEr83MybGl5l5vX2r8IcA1guUwyRYrAfxbivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgZRNcGRIvypY14Lru6xKciFiaCbRWx+y5A3fo0h3UM=;
 b=hK2e5vyV4XiYYBV4QvgV9S2twdoq8IGmpOkc1tr9j88FBOWRb5ozKvMl9/cx2OwEx88nlrGDUDcOYH54JrU6zk5coGwHl1PByxqZOfP81znVwrypB6deuJn26olNFvlezUvUJ/zOxRJHRb+Z3aNyzAUVlntDcQTgPZGwEXtcvuUdk/6xMOaM9ycDvM7awZFdrwzqOhcUT2tjexCFsM9aogYzszEkcB2/tvKnt7qlR7hKrXMqccl2nPwBC6159oy9tk6ZmHZYK6G8Vw0WBjMdfAhL9gDh7xv96eUh/B5eFLeyyBQjLJWOgfPHEhewvS9DtOl++LRusKhLeAZe68iwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgZRNcGRIvypY14Lru6xKciFiaCbRWx+y5A3fo0h3UM=;
 b=Hsyi00ezQMOiVh/QM9LXtMky1vIiTY8/Q1K/ztID+rA81K55z0xUgLepCHEntujZWoC12dgehYj6Uw03jP+R+6AjMBdArY/4BPjOwxJgRJIv8WQ0bojVxe+TXpUTATth3xQFc2ySa8EtxAW+zJG7V0NXiHq6n02G23NO0BupKVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8543.eurprd04.prod.outlook.com (2603:10a6:102:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 02:02:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 02:02:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ support
Date:   Mon, 20 Mar 2023 10:07:14 +0800
Message-Id: <20230320020714.955800-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5d07a2-9a02-4e54-c9c2-08db28e71cf9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naHhvrQ1ZKcfDWE6N7uQMFZfuC/M/1CNiKEc6+DcEPMzL4P00agfRz6Y4axmZyFlVxrnrmyTCcT/D5hR27VaCeeCdiwU2oXo5enVhvqpmLpAmlYTbfaMD2kZu5lD3ASeuUAVBWp8jPF5FNYTQ4y2Jmj35wqK6tfVIc4dTyH1PYkd20b071FvazE1arySfQ/IL+OsMtGXPiv2xg+oYy1Zg3mUuYmD9+OlLXYESYI7gR6HG0JMEyg4d+w6cW1TpoVZkRJSR03P1LISYMSEG0v/+93+J6uyWegH7aLZA3XDZlBeqqUYftdfnSqQnpaXiBKxQlOTvBAftiXVCQ1Kgh2S3TEJiZx+IPFW+YG8rswplplPR+Enk2KCweOY+KaKOcMN9ghBTIR96v21JaVqe8MeKhzm418rZAwDMLqY40cG3pQ9K9UDyvfJk/IuDoX73wRRQ5GbzSfbYSqmzRddafv9+L9hWS4pdGnEDP/SK+5rsfA4pHjkxAxHyeImbuM+DIKM9tb2W5aHj3GlYARaEIT9jUXGbiUUZxaxxhXsc80YYP1hO11UjstObPUQzl8pQuQTzuhG5qxZQeEWh6OZGEeZyDKOZpOWEYzGGUMt1AJYTyHqYTKQByF8qlS0+6/YYhsVpHVKn5pQYkgOX+LhZHJjP1EQCcq/PYIoDfPgaOUznh47tD6Zs2rTv2XjgknLEodlvBlkMFqBjv/YX+Zbi7OWMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199018)(2616005)(83380400001)(52116002)(6512007)(6506007)(478600001)(6486002)(7416002)(6666004)(5660300002)(316002)(1076003)(26005)(186003)(38100700002)(86362001)(38350700002)(2906002)(66946007)(8936002)(4326008)(66476007)(41300700001)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvGTo6BRHGCxdmD8070GSgQohz4t/g7+JN9v6YINjwt/UzsygI2kRrkXxtTH?=
 =?us-ascii?Q?n464nLGUx5tHLRfRdYlot3ZinKGvK0O+pBCg6v+bwcTihqzs5NjC+EQvrV+J?=
 =?us-ascii?Q?vyhcugRRfN0saDvZOzqfVcbEstQPqzKC3L00TYX1FxyZCazetTykR1WD48aL?=
 =?us-ascii?Q?8KDHG9T+9/A/IPIp31g0bGDKJ2iNwcyEEHvCSHoFeD27JiViLHac9Mo7Ur9I?=
 =?us-ascii?Q?995qarPfRzOo54upQFaep66Wt6Wn8zfrQyMnigrSVN5MbzQSS4I7jLNPXwQl?=
 =?us-ascii?Q?3UTEHo7SgiYrpcvg7f998acGYpg+l4zpcjR2fFmPuGVSnoK4ak8GMHosWLDV?=
 =?us-ascii?Q?1OxRpJEkkEfmP72YVmJe/YkiGhGF9gWtYuAhdR+igOUvI6Yq3ZZkc6lcVKie?=
 =?us-ascii?Q?/K10a5XAyw3/esAiGSFRg4UM4xiDVu7kbIQX8EIedw4TKRZzATOKL+sxdw/X?=
 =?us-ascii?Q?q9nsFBz7wjO9h4bTSleSv/jcT6xziF3Ak8TR2ElB19TDMjP3ECVWJPyy434I?=
 =?us-ascii?Q?UCuIvK+eh9GXid2FuUQ6ZxGx4pre95ITlST86Qmd1PvsbCGYu4Qk+7pBTmcx?=
 =?us-ascii?Q?nwsIaRaV3ohnq0WwRdn4A+JegyGHM6DqyDJItVHBsaqPyMLknzCxR7yhw8wG?=
 =?us-ascii?Q?gzV+o7UoochAmQr+UNZpqJ79oWES6psbuKq1O1mT3GlV+iyEECkbd16sTNYu?=
 =?us-ascii?Q?RefYSzxpy6ehv7YacLBVNGlwtyj3otMswq/vy2fE2Ts10Ll4eUrOWnQsvMb3?=
 =?us-ascii?Q?SHKodIeKVKaQO0SD1WjHCXX7CNGxK/x3blcLLF9ZI/QMdKFypIR9C4uVGu8k?=
 =?us-ascii?Q?aePrIX+hXy4/0u4K5UBMW48IUkjMdg1aWI/IcM41IgCyiP7YLkUZx/56rA7G?=
 =?us-ascii?Q?Z9J2d/aZudUH2oBxmBFb5/Yvlup++gAG8Jh1qXayXIkdpWrRXVqekbLZRfAD?=
 =?us-ascii?Q?c/RM5mZEi0GiV5v69PM7R3APxeKgHqVNBhVNW5+wzXpQFi8s9F35hI0VnRzf?=
 =?us-ascii?Q?pbrMEnbTe6DM5oE9LL2Rr3uTbo1bgKL9VykJWI17kVEWYI6AX4bN16SZjqk0?=
 =?us-ascii?Q?r4hkI8CdHIxbuQZ+cCX0nXo7Y8dY2ml/jngKvzG/VgbR452V3rNRmtTktFhO?=
 =?us-ascii?Q?bL2MBCMGQYd2xE0+MilYNsMbHM0iqHT9Jl/Ow68jhod9ebLNrG/jxDYsxATb?=
 =?us-ascii?Q?HR2AYLb0LmC2wgLnelIqgxRy4dUCasB2+KOr+k+UfzrMu8+0jWsefj2Hur2Q?=
 =?us-ascii?Q?f7c9Fi9nDrexS++p8aeTe2nrE4x+forC7atGaHfEgBlxwBk3fXvx2Azy6t1Q?=
 =?us-ascii?Q?MaFtiFs7vfXXRFryTSycn+LxLLJToIUvG3VYkaPO4J0kUuwZ3BnEK6+lELhp?=
 =?us-ascii?Q?kpYGfkEHWbfzCrCgWKmyjaSU52At5q/s0VmSuhnTaVGtPq5hPtr2AaYVvkzK?=
 =?us-ascii?Q?B+XJ2u7iDJH6FAybWcY/QcqKI9XO2Mck2uSikUiuHHjC+L+ZGG2UPTkynUc0?=
 =?us-ascii?Q?UrfwDyghvVzI97sLlstW++AZFgKWvRO9go0jLjLyKGq+IMfxTZry5i4J+Cjd?=
 =?us-ascii?Q?eHAfN+7ZRZ8ilWgUVxX1rQv4zrBe8v9fp/qt25yH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5d07a2-9a02-4e54-c9c2-08db28e71cf9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 02:02:09.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ep51t7uOoxA702opw3TWrqDOjSWRp74f/RpO6qQx9fvG6A0dWLRyLPgi7bbNuu+ozThMVCNZGElcoTY4/z0z/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8543
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The previous i.MX8MQ support breaks rockchip,dwc3 support,
so use select to restrict i.MX8MQ support and avoid break others.

Fixes: 3754c41c7686 ("dt-bindings: usb: snps,dwc3: support i.MX8MQ")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 16c7d06c9172..6347a6769ee3 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -28,15 +28,22 @@ allOf:
     else:
       $ref: usb-xhci.yaml#
 
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx8mq-dwc3
+  required:
+    - compatible
+
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: fsl,imx8mq-dwc3
-          - const: snps,dwc3
-      - const: snps,dwc3
-      - const: synopsys,dwc3
-        deprecated: true
+    contains:
+      oneOf:
+        - const: snps,dwc3
+        - const: synopsys,dwc3
+          deprecated: true
 
   reg:
     maxItems: 1
-- 
2.37.1

