Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657866161AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKBLXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKBLXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:23:30 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C33F248D3;
        Wed,  2 Nov 2022 04:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwnDhxvBZheHW3zVR/NzxQlPq1RVxqU3KSjTTj+ee+MMBn1eH6RJ9+1v5l21GhpH5ybL483/XZ0KFtKYk03hEaHmh6j9h2uaFUUE1Ld7SbSNf9Ifv3n7LoFEDq+t3WYhOSzNKaCPe7on4vsPDrxJGU96/iBCCOT5bvAP2tX0VeTgDpOqgyOV69twgnMM22QkMmspvTT5bznei86kQWXdrviPf9lrkjnATriMZLcRwr/wAdY2S2MmnYzKR4UL8v7Av9aaLSuyoWmP3Dj3pgI6rxcwqb2uK+So6RLFemmlACH+9VYt7FRZm+fp0JfeKx0gfoBrY8u1r8JTXzanyFBb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSbd3wHqsIyDJZXdLg/IS7qljdiv3wDv6wV4cU4z26Y=;
 b=ntzv4Z0dF3Gehq09UaQxjNhHk3dhkBqtyBqxeCw8un/GwHtVuTjgL5gK8gHrvYyQm5QnWuvcQoD8vNS9yV08QJqBZ0SzDsXNd/VaONFAH8Om7mB8S2sqXyR3g14iHC8ZYD/Y4wXwL62mqOJUlLtKC95AMWwZjBI0+b0T4riFT41jsF08Icpf5WFX6yizI6hKVTNUd5HU75TLL1n8wma4KVaWU6wDommA4+zp405DVm+5zQXA+xybHfdS6N3fnJucRiGP+RQlnEdS+agem1ycPVJI1ZX/fiGvjP8MvJ0bX2u/ChbG/Ma8zezDHQJJ1ex2DflFbpYEcB/zJv9X/mTxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSbd3wHqsIyDJZXdLg/IS7qljdiv3wDv6wV4cU4z26Y=;
 b=hFRDfwZx/bzlXepki4aV64Xjb9trJYIsxrBHDSvv4DLkjHCJsEIP+SNxkn9Y3KBjaswKOWpQ2prUlLR3hFP2vAhHkFNR6OPGZeOaooPl3Ei08e5IeicLR2nvIQDJWmqqB7MUGpeda1yWe/uXRtKSsmuarlSY4TcQjPaX/tgih6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Wed, 2 Nov
 2022 11:23:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 11:23:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings: remoteproc: imx_rproc: add fsl,startup-delay-ms
Date:   Wed,  2 Nov 2022 19:24:50 +0800
Message-Id: <20221102112451.128110-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221102112451.128110-1-peng.fan@oss.nxp.com>
References: <20221102112451.128110-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: b24cbe91-6c25-4308-e0b1-08dabcc4a96a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mC1HRkKZMSkGpMq7PkIc75YKhIztIVsxZvOKauEVWIzsDXWgk0yxTG/UBb7hVyirqGLfDUOq4cFoZ3JdylmSL7934dbGQaVM/ux26imwU3dQYtqtSFHlAheC+UiXBoV5/4gpwxu7l/ormxEWNkUFwgJ3oi0nBJc5sMhmZPX7cXXA0g+YaibZgS1SJCE6qbllndx7K2Si4uyZtSGisiI9bkpDHtVQkYrqZYzPYn4DlQcRmUfloT9/DkDe0zbgPvt/WMTVUNpEbrLsSYlnABc8dLPdYWG2dbyiOFkwlMPNOILmCQkIMYlq/hKPrYpuTCtWRxwC8P7S5cppVtKI0MMppOP/CRjUuIT22Bja7e7SEbS5vuKAYQS/y+5xohVBsbGiNEWhrgnro+tLGu937gZ+AtQ7YZlvHBHnRW8v13JTX1yPSM9wIxtYm6GTmOAZ1RCSlhCCp+tBVia2s1WFbe45w/rOlFMbD+yJwQtUl3hTOMchawWU6zu/E1S2/0/obNYMKHQOLMP5zz5UEI4pYrYpDv6RW1+G9upDqcj2Rn6mOnFD/84DXkJ61Bdlua3r3lSa6EQ2TUX0mLp9Rn1Q5a/fDsBdXhSIASdt9oPBSh9VXbXnMHshwVZ1bCtMGD8GOXa/jzyGmr7Th7CVd8iIjRpoJ2JNfSqJY/44B/GNLuXYmxTl8FGrVsW7PAi4aiOhtmTSrlnd7zuiVIpvLAwuRQ4weExj4mTmTnMMxuMTPODIsqDpiG378CIJhU3SbUapG9ZKVKyf+jYABQUkJD4Euly0IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6666004)(5660300002)(316002)(2616005)(6512007)(86362001)(66946007)(4744005)(1076003)(66556008)(2906002)(7416002)(8676002)(66476007)(6506007)(4326008)(26005)(41300700001)(8936002)(186003)(6486002)(478600001)(38350700002)(38100700002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wAVgqACMbpeU6v1MlzCktcNZhdXWNDnTDOYHm61F9n0rwLXT4TmFN8z1enlj?=
 =?us-ascii?Q?EcWQ6f5q+TqVczkZq6zYGJSeifPUEy/HPtHUF98aJg2R3tuGh4zHihV1XOmC?=
 =?us-ascii?Q?wk05wNGOEVkenib7sJM7U10Es0pgtJgRyyxf5Oc6Yj0zgiHdbDhPV/izIJ7s?=
 =?us-ascii?Q?kpYNf+2L/6wyfEKPYB40hqTbFXBhKFVgePOgkgyDdtl7t9u7W+XYyLlFmJo9?=
 =?us-ascii?Q?TN94gwXmb5WgCZqOsnpuFChyjjlNJ85ugyifiuLYf8yzhLDhyrOs9DCflRhh?=
 =?us-ascii?Q?9rMq09hrWo1f79gkTzUW/ggP2sW2gRcxY+VgsCd4zQ2TnRuM3kdwDN7hGMZW?=
 =?us-ascii?Q?Px5Rp5aRAacac0IWH3DEHfvee/BOGwuyD7ELsTfCkRKRGYMBbBTKiAVHED2i?=
 =?us-ascii?Q?hBVjqUTni+jcGADh9OivWNNHSRsrjxN1nSpzlshOwlmyrQxHacrVktDfXecZ?=
 =?us-ascii?Q?opggoOjPy9WMKDM2OWpIrdgqQj1L91yLAlUa5T6k8u9W8kSySFAoLPiD9Vga?=
 =?us-ascii?Q?ShegaX0oyGfA4acwObgdJ2QkGYXey2NmUzVhrtJmEezCNx7KULXgcjsde81j?=
 =?us-ascii?Q?Jq9vKyQzvUu/n2O3LFMwK5Poig6W60lrORwsEKw8opygsldfrwdB3eJyYuve?=
 =?us-ascii?Q?0XcFo+tDJ7WsOxnPPRc8+So9O6Mp6FVyeSEDhTXvZNMvUYTFZIwS0TkZM/FU?=
 =?us-ascii?Q?tx2Eh2eOg3M0tGAIPEXy0epyB58rz83hIdmTr/skbua1KSuWAxLYGsTPMQkV?=
 =?us-ascii?Q?rG4mnwd6cp5S/NzlFZTpGeNvebFhmzRehra/xO/BXfdTG83kBcKpQAdurJXY?=
 =?us-ascii?Q?e92RnbacaK8MlaGjDXFvhzn24oGob2VH9GHzlDHj1rNCNbkPKEHQDx3ZwnFX?=
 =?us-ascii?Q?Xdr2cGJ0vPlXfWp7pCFp7I3gS3uV2j7k92F65W+zwLdHMli35wuXaJfMLzS+?=
 =?us-ascii?Q?StUt1oEN2piO1glUDISVVnjrw2U80uyLCs/tryHvQhhr0RJZUgW8MXrhSf/S?=
 =?us-ascii?Q?GYqnsH9OGQaLF6OpxBQbiktv26SORHeheoNsc04Od9nIYgvcPhsN+SSbgGPS?=
 =?us-ascii?Q?w2GN1yCoxdvgOWa3T8brJCMEiwyToOE+f9c6HnDX6Fr/q6Qhx8ftAo/l16Gs?=
 =?us-ascii?Q?yD2lu6XTA1MMv0uPKPpRbS0oORWUjV9gubvW8z85lZYyuImvhoL8DlQdkT63?=
 =?us-ascii?Q?AfXOkpOme3QlNnREHTOdWxNOeO3+i4Gj6U9K8h+tGd8hg2uPMN+TyTekyB9y?=
 =?us-ascii?Q?jL+dQ04/2b6tWokQUqk/tgtfoKUNsZSW4qUopFRDQJGjaEL/7X00poafSSSi?=
 =?us-ascii?Q?SGZyeTz6T8l3Rtbm5QqFaUAYKc5CDLTx036O0Pkldn/xxU3EGFYiQN/tZfbN?=
 =?us-ascii?Q?SOauEATRW1Y2tlx3pg8JDVfTOFrh2SNvmM/DR4Oi+sTrENJlaLi516q3fYE6?=
 =?us-ascii?Q?2lAkY+K5ZPkIBGtf6IM7kYgXWCFNNgwa7POVeaHsKgbw2iP9oGwrDyMbL2xf?=
 =?us-ascii?Q?K//0hh0oeK2H6knIbNtq3JTufXF8j/4tGrQ9CjWyVR5bdl9y4s2wvCR+4JBZ?=
 =?us-ascii?Q?rYAyL3W4ynAntbfsV+oW+5h0s+rVSZaVlOCZWLoZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24cbe91-6c25-4308-e0b1-08dabcc4a96a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 11:23:27.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZOomvSyJsVXRsZOSgpoXzZhZkn5CieOu/IB6vm7BU4oZgBhAFxRSqT8SuBUlBrTqDWS/1DLSlAcQcH8Ijb2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

add fsl,startup-delay-ms property indicating delay some time after just
kicks remote processor.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index ad3b8d4ccd91..d99d3342ad52 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -76,6 +76,10 @@ properties:
       This property is to specify the resource id of the remote processor in SoC
       which supports SCFW
 
+  fsl,startup-delay-ms:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Startup time that remote processor ready for communication
+
 required:
   - compatible
 
-- 
2.37.1

