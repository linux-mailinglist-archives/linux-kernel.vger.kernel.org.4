Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5566CB604
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC1FYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1FYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:24:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C90210E;
        Mon, 27 Mar 2023 22:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6CcqkFUnUqtjSCbBeh8Oo9cVhNiEZRUjCCHI0xFMvo84TiGznJfFrZxmhBVAMFMwwHeLZqDQqr2rv1K5wfa1PEtMD8TJwXrDXjYvv5AThIn9coyPwArRsADS5ofaZvB82fRnNSiB29dj2FrSiWKwgLrCMVgMVGERXWB9eQEOYofuW5M54VBvrqTzd8t4314Krt3Y84feIJ9Q8LIKKVJcRVIiZMf8Y3nMv0v6NvMb91QnZcZE3b+vCIo/wEnMZULaW2SsE8vrb+UD243LnwNE2Xcgw7w9Glng6Bn7fvrjqw46/wGNEUF7j3O8aOo4EkgSkfmfv2gzaAsPoOqSGp6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du6+B2ATtpMNPS+LlX0EPJieRy53sw4dQzyUZlx2Olw=;
 b=Mv3gSL9TptKpvWYg3WODhs+FCRXuXeo/rDHD8yuBReyHK8KSKa61SB7DBxeFt4ODAh7ZWcr03IYCUJ7cRZDg4KFxAEsKjmCYsR/zgd4pYFivgwTsTmvCHJgNsMs10AhhVym8LQs/vYKxORhhD9LqwnV4fP5PFumYbZuR2hRCkrElL/TZ8Ko/8DAXtPwMU19BBf+89AQFtWbkeAUKWrUlOpdmid/5bKHNdF0neWYnCTaC24wXWCYlbnEWkA7T4Vpir5L4R9Z1SsJZlqNSOST1XBUbRYrTfaeO6fIe9jY/7dgugDkMyO0iuOJ1CFp+k+DlQgSPdLJ5HIlY/S2onaStKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du6+B2ATtpMNPS+LlX0EPJieRy53sw4dQzyUZlx2Olw=;
 b=TxJVDHavsuo6BY8caLvkrndZtMcFsbTsf4I1dyT0E3Sn1RBj+JMXuv5fgAkxcfrJgTZ1CDx1ooBj9bc118aXT111vs8nKN1FrikmwK20vdYB46/EH/qBVQanYrr5o0hnYWQShF+/ZkXlAm6X4EctwG84uR4fJ6TFfV17O+qZXPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7016.eurprd04.prod.outlook.com (2603:10a6:20b:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 05:24:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 05:24:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] dt-bindings: gpio: vf610: update gpio-ranges
Date:   Tue, 28 Mar 2023 13:29:12 +0800
Message-Id: <20230328052912.1957000-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b88067f-4cda-4fcb-7cf7-08db2f4ca9ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzFDYPLp1/sOT7zfLXByTNOmgk4a5Q8f57JMg+kVN5p25t850rKgpXi8of+WrX5M/oXwJv/eMM+WkDblHVrRT/m5mCWLzAhF33sVMdtciNUrZWzc6VoUEJta9IEfixtdWVDTcWu6CIHCKNaPqBcTDiGcupmqBRS0KJjBKB5POwOlzD4RCxrB6tLv4pGL4KjSz5OMLTb2dF4wldBaAcdXg2GcG74fZTVX6aY10+KuEjfnTcgEG9kcGg3VeJBb2IdbPdbt7gY0pDYT7l29HWsLfD9/RDHSsdwujEkxZPtmc8c6XIaC7DD92h8+tggFYmEPhQf3/gdJbt/mumzPyA/vVWNr3/uvfnt+c5+7hnAu19v8grhLz0Sz/Ei4B3z+PSvokf6UPaJedQK9KfS1kdF8+BLap6QZm1sZXYn/8mUW2BHdT+klT8FLvKwdlr8WD6ARWoObhm4eYl5E6NB9nraZcXaEP6FphsNgb8DbtT/B+y+fAlAQVG8iZP0oyAqIQm9fBUIGl4YQ4BOWEidT1kmrR5ilFAvKi1/H08UuOJIZap6wtYeKTfLrMqjc/u3tH8MOEfpuy6yi1ZIT7hlmGgR4mLa1FgyCqpZVWFOlQv7rdH5aQM4AlgZlJ1dnnmIpJQXv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(2616005)(83380400001)(8676002)(66946007)(66556008)(2906002)(6512007)(4326008)(66476007)(478600001)(316002)(186003)(52116002)(1076003)(26005)(7416002)(4744005)(6506007)(86362001)(41300700001)(8936002)(6486002)(38100700002)(38350700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBUbvDdCzBRTQTMcwl+OwKURSu38Taurk6uCDbZudg70hGE0em0e8ckEkoD2?=
 =?us-ascii?Q?szmb+hLqlaSZTzg2/VwlJEQrqmBVt2zDSkPgpgDIZRdu/UlbayGiUNQuupTC?=
 =?us-ascii?Q?/JDdjH+LFVuJqhEuYSLpsVkxpxebS58c4iEJGO0qXNAHVJtwczE7efsmUrNM?=
 =?us-ascii?Q?5+WHE9o+ojt/cp2Snc7Ov47kHs/Mg/EOssziRXZMD787NcSkPfmxIGdVjqcJ?=
 =?us-ascii?Q?namtpeDMWVG+Zw0y/uapmWVNr1LuRyO1FGNrmzEdy070ZcAQrVKH8MbwD7kV?=
 =?us-ascii?Q?K+p6BU27eNpxkiXJdVqgu30IpvSscqacXz2/cjUMbGJEbnwIr6qSa3PrwFD/?=
 =?us-ascii?Q?7X+5Vggl8wf/7Agif0pXx5uUZGoqdXOxmhQs/x7BeMjGcqDYbBRJDMjmQjDh?=
 =?us-ascii?Q?6AiIlHf8ZZo/DooOrRfS1pey47hLhIvymp6ZNSCderkRewoUnmxlOvuDBr8N?=
 =?us-ascii?Q?FQSyySmScmsG3YneaVeyFCyOEgcc2MDYP5HNn113XSnPOeS6nMdBtggIwNUA?=
 =?us-ascii?Q?4gPeEOUNOZKgcHL1906qiVSovMDzBIDdGvPgs6rw0KyPEVTKIdZ/KvqjFlwB?=
 =?us-ascii?Q?IXPgr2yCpcf1NzxsnMDUlS2Xl4OWKtWQ2IdheTu3OjivblUlKZ37Y7OzRjfc?=
 =?us-ascii?Q?0f9MhFSTR4Z8bhTanI+YMbmGEwFu2UbYcewTQTF7n2PGTY7IqJovPieeO69H?=
 =?us-ascii?Q?6YoZg2+M6QBxUcrKXjm+3pZrr3bglE1SHde+3P2i4g7ls100qhvru6bTMCbJ?=
 =?us-ascii?Q?ym/4iwgm0jTpPZKgZUGcPHGiah1keYOoZ+ACkrmI64Lhk10iZyEjmvoz5RQD?=
 =?us-ascii?Q?JklwmLOSAgXPurWJNnTfRYo8a3cSHBVkhLv55zv0DbGRmcEmA+2RCUPWgn5d?=
 =?us-ascii?Q?OZyjsInWIDTM+XZ+x2+73QNRtRKOtDEXQlNN/9u4sQPrk/yX9lut4z3cmkl3?=
 =?us-ascii?Q?KPTqFb+QahH1EYYyOfMrvukpjmOC8s2kbp+yo4jEMfL/LvhvkU5KV2Tbt+6J?=
 =?us-ascii?Q?uAzZAhD90dKFfA2J5x+x7H12QtySCQQZ82ADadvI6MEJDJceISQHXncMx0D5?=
 =?us-ascii?Q?lVdV5e6zxUdfFnha0NUxb1HMHZpZ0doEdLNGQFkAQy4gVWQkX+MCCWG1eXGI?=
 =?us-ascii?Q?SCDV7sgIaslzUM481q9lFhcnoczwf2RowP94kPUnGpUgIRj6a3QSQuWZ5Bur?=
 =?us-ascii?Q?33zydB8ytYlMKYyEPRWQ1dFcyvLDOuv9t1Op79//WdYDI4QZpVrAPuowzQO3?=
 =?us-ascii?Q?LgAWbHOWHxAjVR228YkfAN3crqPgLbZHtWfklm7Hy5NXYduN4V+uongpDctX?=
 =?us-ascii?Q?7GM+IlzPYgVDmJdMF4UheqXavFtinAPI8fblyDhuQsOdoXEIET9TXszgRjSD?=
 =?us-ascii?Q?VEpvBF7SeLCIr+GlE+G0JeP4ZGKL7O7ijKbFGwrJCL7dhbskwGSoARnnsavP?=
 =?us-ascii?Q?4erHD5It0XQMyfNHayi+u4I7KcXFxYqhi6v7n0T2MzA6MndxUqilO0OtZZ8h?=
 =?us-ascii?Q?EGP4ud+svu7nuF+bSmIWo+pRoXvh+MCnFLVsW1V6/5emo7F/VzmlOG1ypnzq?=
 =?us-ascii?Q?GcuKp2g7gNP5KcpJDUIcn/LpGgyrUOBDVx1LAVjn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b88067f-4cda-4fcb-7cf7-08db2f4ca9ea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 05:24:12.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJ0LiShsAX2wCPQd/RhOTYOspB4m0ACsOiEeTN+oIhwDo1cUbMAoqm1TffILR09M1nuvvgVMRdtgGZOI3fevVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7016
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

1 is not enough for i.MX9, enlarge it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index d2c39dba56ad..7ba834e2a238 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -59,7 +59,8 @@ properties:
       - const: port
 
   gpio-ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 16
 
 required:
   - compatible
-- 
2.37.1

