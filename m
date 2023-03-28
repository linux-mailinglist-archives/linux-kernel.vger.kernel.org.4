Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7726CB690
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjC1GID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC1GIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:08:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59DB1B4;
        Mon, 27 Mar 2023 23:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J55ul41XLnmVeRBHctjG18tEW01a7YF//ET2cK+pru+gi60r9xZrYdoQK7xw8/Astev/Vi46DYjlV6qsVQK/aikRncyG5fzcjpehswIeAucShn/g4R3o4a0Xqf23iaY5mhL6IvEjP0tPEAZA0mS1EFW44Rw7yCPAueVljoVO5JRS1+H5rmJGjxrSavk0MXnzJz/NS6MKlI/LkUzPvDCKu5bC0p5BEBtIE/fkbaL2d8bZTDqGIm9fxn/8F5UvTd9Vj2VXXK+lD62u65JZVjS8yfcGSLSk0m5Rz8q97neIQsXSwJx5tHr7hh/2AjiYZbG+oe4DLPt/jaDcdTyvQlVZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ73sj3Kp8XV0+CFr7ECST9ptzIdwBpzi+7lTIMNyaE=;
 b=O9HndZRtdKu43kEwsJn49yqYBKP4zctepWvUrrWISyoau49YJo8eFwVYShIZF50RtBdDmirmCUU66rWpsoU7EJ97s+terI9RrHgvbDTOwqG9wtS27/5zrOhiMqcec1lCbYk8Ug4dXvEsUFVtZuuhZ9xvbo8Ojp2mkXUPE+Fgyw7JJyxCtJdt6r4RCOHSl329SmvPczVNPgTpdIdXTmsUZ7GE4QDkPlUHfb8OCvZZmjzH2YHEU7lEPprWT5gXbWjbK8P0EncHA7q+sM+WYWNKbmmWpEEN2DyE3NZDTA2SM4Kh1nzmnz2FVdHtqmACtd6oFazuxtn/bk4cY9SaAQS7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ73sj3Kp8XV0+CFr7ECST9ptzIdwBpzi+7lTIMNyaE=;
 b=lnG/d5CYswK0uopWS25YqeeM2WRmIdmaGG/8dZOsB6tzhZd4LNUHmcXwi1vzVuROJIB7ukICbINh6A3dVn7JJhQjT72MQgUyfUzO0zzTUXrPzRK3C07GnjECKmyhu5okx1VeSNcCc4AnF3OiPCRhjlNl0eJJVdfqdxeCDEMl8qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 06:07:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 06:07:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: gpio: fsl-imx-gpio: add i.MX8QM compatible
Date:   Tue, 28 Mar 2023 14:12:57 +0800
Message-Id: <20230328061257.1984972-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0138.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8fb06e-800e-4106-04ba-08db2f52c38d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fII5s8hGSxBEg/xDBRZZJV5X2rUR70Bb8S+YCwBWdmKi489g1TLpWA6tbuSfOZqJZFOytwd/POUoSeKw3ztOv3ufCHapNreo+57YSnbzN03pwyV67YyaYPY0/+zmMAIvinnurA9jfZVnC9fifmpTJcN9kH3XvgFiZjAcgacOPiHUkiVbSJgUwCRUBjnTFYudUWw2zQYTvMREuXS7XV9I29depptf7g7Dg5DuxMScM6bag5UMhw8V2dUdecpQ1OHbl3JZR8jSe4rDMb0Vt6LQa/Z3PYnBLkl5DsBkX8k1pUbB0VBMMwIn456zmvBKDFGEtIMaYoUorxKR+R05k3pYKdQK0hVPjIllJ22AMQEY6w2ZcP3e6p/5BiFX2flWeBA5+syaZrVrKyVLtN2KRa01+8POLsFygrhUfN7FPHvKbL6qhxPA4/QPXvzzVxT6N7pPEQGjnF+H9CtMDiLK8l41kFrhiyp9dRurhWU9n7Xw3MQpVY+XFv2z7819LUnmYnBiCLNvXgcQnI5ye7Z2ELPPrhO+YrR6vufnfkJPRB7rd7edeSkhtu7tCbxlz9IwzTLYaKjkcMeVj2UPsNB/8rCVgcTQzWAIobcLWutGQImttMuRUgREa9vNZsg5dSmhuDm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(6512007)(6506007)(26005)(1076003)(6486002)(52116002)(86362001)(186003)(316002)(478600001)(66556008)(66476007)(8676002)(66946007)(41300700001)(4326008)(8936002)(5660300002)(7416002)(4744005)(38350700002)(38100700002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvlX6hEYUBqyCjgKBvIYjGVV6Okqzkvw848zOlw5lQasZnHRq+k7RuF10DAa?=
 =?us-ascii?Q?4oN5g5b8e4CMwLl2DwnkwzpYSig+wpgNwQDrQbSwbJV0zHmMvcF2wGnH5vU6?=
 =?us-ascii?Q?pbJEaD581Lu/3V5EnA09vaDOXI5HcdwDkVAGcuij91x31IxQCPVZX5uMrobK?=
 =?us-ascii?Q?+kSivecFXpht7ZGWABWug6dBzn6LBPmU25KpL5tipbCV0FKAjKStw3TXA+PO?=
 =?us-ascii?Q?BEeHQ/CpzfG4QxN6Pg3+tGXlYE+GbMjP+cTt6bYn52lj1AAbDy2dpGzrgqTU?=
 =?us-ascii?Q?54zXCAN0dFaGVjGTDqM2eVqSA0XzVmtwd0yb5MW4EKguGh1bb4pXUX7sQ9/A?=
 =?us-ascii?Q?FP4kQqpe7VvFdAGQFcx85r8WuPLjF/jWrFOKclz8cfJl+eMMwRajI02+bHGO?=
 =?us-ascii?Q?SiH0Pp+G5kkuwZ+NPB+9INv7+vjVSaMMoefofojg8X5529+RPF0zXUsab6Ye?=
 =?us-ascii?Q?R8ECku5rfMv1ex8TRGyCKQ8l/3T1QDnCNEleGcGe5NpteIQkigp8pfFTc8ga?=
 =?us-ascii?Q?imnm3kV/d4GHRvZBZJ8wZJe5dPEMcgTTj5g80Bkjg3ohFASE83AUKHxB3rYR?=
 =?us-ascii?Q?LTMwUhfgEm1X3HXoAo8t+/nwL6lx1R+KeVqJeSsHhS+3dqKuf3tTexHITY31?=
 =?us-ascii?Q?v5ZGstkk4FrUMeLjMk6neAkvc55CBIK1c0rKf03edopVVEjFmBsIScwyvzYa?=
 =?us-ascii?Q?kPApWxb84aCAFzocZHSk8oUkBh2OPJIrIrBdNb3csOkTh/w183MPw0uGii/F?=
 =?us-ascii?Q?DRD8Ha8N9W366a2d+BBb2ma3bEkxX1yTbILclB0ONWbkMixbiWRuIMCH4Y1o?=
 =?us-ascii?Q?iOajpTSJTPm+tX7yReJzsoyKM/8Kuy5+QA0SRcFMpN4zIFjOXAp4oQrw2Bxm?=
 =?us-ascii?Q?3Pqhug0z72zRM80Gl6Dh1rC8CWmJMxqDMwfVzZFhtZq0+q61wIltHTme68BU?=
 =?us-ascii?Q?8OobQ63pcqcz67TbpYNRnxuPyZdvQ07bH5UgXD/a6sL7rAZzM55ZiHjvxiqV?=
 =?us-ascii?Q?ir2cZD3grOfodVWQt3umWHKBm39mFQiTlhxxkpFMrAQDAthZ98Duq9/D4nwL?=
 =?us-ascii?Q?npHb+8TLvDzZQN/CWEao6BXamntJk2mrt6PkDeJIAs39mca86od0V/bq6m7T?=
 =?us-ascii?Q?qW9AgzAuWnbPAQAP3HnerkuHLlmZl+qiISRE+oCD1mFd4gvdpKFhK3BHfB3c?=
 =?us-ascii?Q?aGWr3VEKkVUyQ8hUQfpGUY6svgi29ReCjkiUrzz8htNGB523qx2pJyalBbHl?=
 =?us-ascii?Q?R4OO0TFKOG5YBKlaXzrAB9oX7h2esVB2KmhxID/Mk8OZCX+9GxIg+cZGHNDp?=
 =?us-ascii?Q?ijHKV1ow4Lx2E4K84nny5oYEuIUGnawe0XaselO5DX08v8c6X8Mo3Lnxp7mx?=
 =?us-ascii?Q?9JYjexImM9Mp/pSWjlfS0IpoygLdRHAlKJbH6Gxe2KhqyAxb7Kv+4nsxlL86?=
 =?us-ascii?Q?t8jDEl2PXH44Y4XHxvrsbHo9t04OMG4HLG6nSlusTeacZrjOQepQT58yobjN?=
 =?us-ascii?Q?qULnkNOxzIS13aXCxaKlr5yrz56ffLt3oCOsMFyFUH7OaTZc9pKoIKBKT8NL?=
 =?us-ascii?Q?heTZeABe7W6zLBM9UjbE+vAZIjh5+n8uB9GSqv9N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8fb06e-800e-4106-04ba-08db2f52c38d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:07:52.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwDAwZpqsepuSVJp93KGZGkTJVd5ttPvLd6u1cOy6B52KK/XLIiSRf5xSQ0Lehq8WMfelEe94QRe0TZ5UdatfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QM compatible, same as i.MX8QXP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index ae18603697d7..be56c3faec0f 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -36,6 +36,7 @@ properties:
               - fsl,imx8mn-gpio
               - fsl,imx8mp-gpio
               - fsl,imx8mq-gpio
+              - fsl,imx8qm-gpio
               - fsl,imx8qxp-gpio
               - fsl,imxrt1050-gpio
               - fsl,imxrt1170-gpio
-- 
2.37.1

