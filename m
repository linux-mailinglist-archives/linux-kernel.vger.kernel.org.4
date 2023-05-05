Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFA6F8911
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjEESx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjEESxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:53:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25491FFA;
        Fri,  5 May 2023 11:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVwuJs7YmyZZlX+2Cte8Y3zoQ3vSK7RVMegOTjih/Wb1H/b7OuNPuenAf8IxdrTL0XTppaqAX0Ud6Zy44KY6RJ1iXPn6JqY+AwDdpLzv7+UuMw3ExLbgspAvj0jiGg9Kgp8lBuz/LxGXXVTisWBRr5MTLo4NT6l1iTMi/HbSM1fTBOPcXGJ3yBsuBeOY4bFbyP/5BvFd41ZexrzcPJy+WQXcd5j0PCHsGMKRi2nlqQCOPZmlCFBSfJzFioYb2qUy04Rrz83mb/E3R+55XWpcbC1N5V50Y7TdVzKbOlZIw8d8g/h3j4fPEC2nTm8QIiNBr0Ybv7haoPs3mhhiO3uBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GHLZh3DdzcsfQ3aabNJU7ytOcAr9J5LQDbSGS7Vvmw=;
 b=Oxg+ddWZ3bkomRiwWYJ2uTWsLSNCwslQOxu6BSZHlC9yWbGaaD10cZsvZ7CXuqhsvO8VhG2tjqSra3Cd/uRuvcRYx338CcmHovMs/HdwLWfKWoCbC2K7m3HU/o+C8ay+OdrElNk6LFh/0xqwfurLoe0o5qMgGN+eOYCHbsMJmI/uVCIP6CYt032HcjOEx0tVXefkYS57wXn5oa/s/4/dq9fRVWt7dcJbRVaLflVXi0NjuEupZ4mtOMZx57gIvjES5w5nW3lLkC5PRrOPzKqAE0NjklEwe83ZVdS8badzxkK/ZQaiCR/o0piDJdHyvlO52wZXlOcv7hrSDNjAR1o6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GHLZh3DdzcsfQ3aabNJU7ytOcAr9J5LQDbSGS7Vvmw=;
 b=KAfCEPRlAEHrpaMFLpiaHEPyc+gzqbMsqRK6JSJcVXch5zk5Uie7hmpqOyBgBUxJHGdmxND3U4Tc+7hxRYWQ8WZlmFE/UuiNoVlG9gAfPBC1Hdd4WQIYFxoY3bzJjKUp7xsi14o1Up3tmPZSJG4uU+tNXj2gU1tm+IjE/TywB74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9894.eurprd04.prod.outlook.com (2603:10a6:20b:655::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 18:53:20 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 18:53:20 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, fushi.peng@nxp.com
Subject: [PATCH 2/2] doc: dt-binding: cdns-salvo-phy: add property usb2-disconnect-threshold-microvolt
Date:   Fri,  5 May 2023 14:52:47 -0400
Message-Id: <20230505185247.1854677-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505185247.1854677-1-Frank.Li@nxp.com>
References: <20230505185247.1854677-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9894:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c0f5ae-d2b2-4665-c23d-08db4d99fef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyzr7KLNChv6neh3x/KlEoD9M2y3eQ1BpeLLWVumAH10fWCCAZgmRcK3QLtUOhsyV6onvo54jJ9pXE6RIfFRUnIuo7LwoO0ccQNvNHOVcyh52R1FD17NjmCUK66znWWvycLfu2Y2e5iBiBh3Rtd+kdOJLRyxcmyMF6INhs31Ctz85x5r4nV+2IuCWMdVZ6xmIHP17ZAJi3UzbOPEwi4yAo3QZwweMRudLuT6KYSD0/cA5fCxDtx5TQd4m4NY9ap3DnQ1VMsh5QonOymwLBavf+KzMy0AYDpGeIQfAdg9anmBH7HDKcA89EI/vPAYSImtQklS37DjPE3nRPun37wimjgJ3MBHKZUwFBQ2SG/eSXBNnmp0x98aRqi/Y0kP9hMr6cFvFFL5fhEeo4XKIR6ehHi+KmwfFzjTGffm004X4nUi9uJBtIebYzUYY1PAXQnAxJLIO4m204F0I4EOjCpjOuGt1dxf/8ufNkHMsCVi3LulIO943J2FkAoMSP4mmnRL5yJaa243hZ5tA3ZoSABajy+OussIK0O79h2htAXgoWApUGD6gh9irCqih3jerKNAzexrtE2gSZ0OTyF8MQtaSYxNBH8LNG1fMJNw4SsQSSXqvuwC8xjU699D4n6RaPJSgNK7DnvqXMvf6O/oIwf1kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(7416002)(5660300002)(8936002)(2906002)(83380400001)(8676002)(4744005)(2616005)(36756003)(186003)(921005)(86362001)(38100700002)(38350700002)(1076003)(6506007)(26005)(6512007)(52116002)(316002)(41300700001)(478600001)(66476007)(66946007)(6636002)(66556008)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?og+frlSBe2l+P1sE8Z8kneH0IZd17TJuj/C1Jgi0F/WNRYvvb4xs2pyKA2In?=
 =?us-ascii?Q?oyLN8BGdWCUH+ZJyVHU7ybWThMw3PTZ8e0Qy62Nbgb564bt8Sjy2oxmQBD7N?=
 =?us-ascii?Q?eV2nYODBRq7PPHzEYVvCoBW7wQ2w+NnCKzfQ6QPbT/z2YpfCxA9arC5ACK4N?=
 =?us-ascii?Q?zeG7oK8gNVky6EPeLp/6q2i3Ln4lHMM7+RImaXtChTrYCI+h0s1+49Pk81UH?=
 =?us-ascii?Q?OoqyjBrg/wjh/73zryM2bTwO45t2Mbszr5MwafB5CqSgaGm2VMIEZsAZAftR?=
 =?us-ascii?Q?6NaZfadEJe4FhEoLDik8Q333doEq5BD1AbP4/n6Njti9JGe6wVcm99SMlnc5?=
 =?us-ascii?Q?1yUZYasV2nl2oXNZi7EekbZPfxJP2zAcZZoaNQYARab/ugHzUKt4S3yJIBh1?=
 =?us-ascii?Q?ZVrl+gNna9Htb84q3RJpqxdLMiMp4t4CpHZDHikQApehyaFyZZtH0r1E44mZ?=
 =?us-ascii?Q?XkX6DH94sJIWLYmzkK3ruQpdX6gFUlvsVOKZ8qZ3JqHtf+rHZd+ShMiGjXpD?=
 =?us-ascii?Q?IOV1E8BDpDAcR3bl1aP1iwyhbJ8ET9LrdIeonuiRB2spSsTKpD6dJBE3vqGh?=
 =?us-ascii?Q?hlEe5U1Xv586JO9Q9JW4+cDizLJYisiNqBfFl4YQ0sWIkjtKXaqxerIaK8AR?=
 =?us-ascii?Q?bmZbD2/jddhW5PY/sbaM1XHhR+0ZT1B89Zq8CbDALIPfX7X9QsvaFZi1YqpU?=
 =?us-ascii?Q?xYcXR3SwV0Cg8yb3/1hXH7ixPEZfMz+h/6zNuoPvRoMFAWO64ef+KxKPk+yp?=
 =?us-ascii?Q?kr+V0tmF9Jl1yXEklY5i8m4wzHTf7kxRUnU0n1sK60kP1qH25mCiUkZ7C0XM?=
 =?us-ascii?Q?tId3TsTfiS12ye6ZZlEL+NsdPU7nyg8mEpi6DW/6XxB9NAC5mnojkdguW+uo?=
 =?us-ascii?Q?kSUv+wolZiYKOYclB2nZ89XPuvgmfG1zAp/0xDHKPmW2NynJFNHP4iTAoMv3?=
 =?us-ascii?Q?IyF2F1ZdUINuQyBt9Lz4N++gweFkhOykHn6VIFvV3G2SSIbNNLAP7smJLLST?=
 =?us-ascii?Q?644+iOxFglvSpawPOXCO8dp6lWkPjJvo+0TQg2pZLe2dK6HdF1Ef8U4C3Ca+?=
 =?us-ascii?Q?0BzdKfiPfx/WMYOWj6FDfMyOjVYutC3VM8bkhgmY8ZnTCg1FFwTv0stXvcjL?=
 =?us-ascii?Q?w3Cw1yyREbegq7IDn6ekR3xS1rFur+IoynUIRxY+3boyXGq3VUj5Lg6+wjg3?=
 =?us-ascii?Q?V3zu+iwbEO7vovesXbD9nB/rRyCBS2u6x7dBz45nrdaXEY3o2IBVSsAOg67Q?=
 =?us-ascii?Q?0I/t8MdDpXDG70d+1Ru6nyO6rZwiY5OKeexWlP1hreDSFgSGNlBSzakOL4nh?=
 =?us-ascii?Q?+KsivD/nwJqY+XR8EP+klk8uMgMO7Xfzbr7pq6KSuIRF/xlZ3xcdsh6aMN+R?=
 =?us-ascii?Q?bJqT6sx0LXwvIOix/+fpGe/N9eSuC/OUPyGy6FildqF7OYVOeYUQQR7dmyn2?=
 =?us-ascii?Q?wJrAAWDxVWp64NVKPbB7dJVnR9/G9Ecg5n6WSfvgP0AmltyIYmVAAbwnnnQF?=
 =?us-ascii?Q?JlKQuA4bnVGuhmSakzwB4ZalKUvIfRmRpGT1M4676OFQfOAPu2PYY7E0GSJm?=
 =?us-ascii?Q?Em1F+T25nA1M+jz4ls2uZ+IC4CS4hSq/0AorJOuv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c0f5ae-d2b2-4665-c23d-08db4d99fef4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 18:53:20.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FKBOjAL0uKdcfA6ko1hzv/5L+/XXp2MP+0gwn+zU9gIKCPW2vJaT4zZWOrHnsY9ZYcmfJcrGzys/7O+OXQBxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb2-disconnect-threshold-microvolt property to address fake USB
disconnection issue during enumeration or suspend state for difference
platform.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
index 3a07285b5470..3c7f5b3f9211 100644
--- a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
@@ -31,6 +31,13 @@ properties:
   "#phy-cells":
     const: 0
 
+  usb2-disconnect-threshold-microvolt:
+    description: The microvolt threshold value utilized for detecting
+      USB disconnection event.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [575, 610, 645]
+    default: 575
+
 required:
   - compatible
   - reg
-- 
2.34.1

