Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5557C6EE154
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjDYLvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjDYLva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:51:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F08D59DA;
        Tue, 25 Apr 2023 04:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTzCopn0tiBDgS63oNoUWpmK7g40aGGJi3q1qHutCTQLBz6ojcQ5qz+YRTpPKE8fYT1VW9dVUb0HWz0aolbATD/gtUE/BJL81KHTSNcrRFbv5IbfJPNwWupUxpz6Zyvny5ug2WQlI8qcUH1Fv09cFKQNep6EwqoDRylkBvRGpelN45YYNzotVDZnwuMvpyibVegO2nLndwHZmFhHkbqoL+jdovlKRRxE6NNiufdGvG04kX+wIU28DJJcUZ795AgKI7FZrjPZsDCjBcCmj+jScBlIrmH6n6a9G/RHuvtLdSZXc0ICbFIKNr1epnz2xFtalDe0Tp2IoduSjnXLdaeAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQ2XI9f7Pp5cnKI8cUXKPGJggcLoJi3xByEnGE/pBoY=;
 b=D4MWI7amLs1Au17vmxdWttfcPJMjofKGkzNFY/pkxql/VlIngURP7uwf+c9euh6OqgzNBWxIF312+89UpCmebBg/GuY+SzBHpu2WBssVoD+wZNiuVuKU61J/pEofx+P5DmN6BpZhneiYrAUD5NQQiuA0jhskrIoJYvOcaUj+EL6wO+BQtGLV6MT3OpumfwavBACCOv1dgebEo6d4NweiQkDq5dLGsnO80Jytjxg+g/EA1bBDFy7zmQ9CJT8/XZjHMYCtXxkLu9exiSR56S2ZeXAcWTxc/NYRjHDcnualxTPNs7zbWefuu93cFW6U1lZKKvNACXxpze3L6lJDtk8syQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQ2XI9f7Pp5cnKI8cUXKPGJggcLoJi3xByEnGE/pBoY=;
 b=b2FEuuMONyOhUhckv8Oo471U8TQGQHQa2OcGa5kfnMrdxOG0IO3GKaJ8qeyXoBCnQ0Op8/TFgw+e9GmzeQrC1q8hvTun1FrXx1iL/9MllrNoZMm0A+CUSFtHqf40aojX5pbNvOrSRNSJ2oNjD5UnQwwr649PfiM3cr+8SB/wU4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU2PR08MB10203.eurprd08.prod.outlook.com (2603:10a6:10:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 11:51:23 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 11:51:23 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [RFC v1 2/4] dt-bindings: touchscreen: add virtual-touchscreen and virtual-buttons properties
Date:   Tue, 25 Apr 2023 13:50:47 +0200
Message-Id: <20230425115049.870003-3-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU2PR08MB10203:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a5d37d-0025-4342-7666-08db4583645c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cmJXDjtZ/iqwLif0C3wbf09d8API5cG9Xp/n3ZmbgQ++obALdkNT0rkC2GdYYpakz4nDbbpJ7DIoIvXJDjlV0fqaU3BmYgxQ9D6rTw48azjxNocR6JC4wtThpGEcWTkwC7NwIf31JHaHNANjImWl/Ay4TzSS6fJOg6rOgBjayXorvVEL0xCXBcb00zCHnDakS5o9AkhLOAwe1AKMXwX3axh+5suZ30Xu9B5i1pwQefNV52siD+LTKPFO2LS80hi+0+pm2fg5F+zbz92XNFq+lAF7zNi24G9mKBkEjcy1DMNFq88rgpNKf6Y7YHa6Qu0YYrRKvIDLX0gcpTAuP+w8DbSr5ogfXypr597X7Us5IKL6guDg2X8qtaLqJKh88LQEU3a7NyNfdnpkeRFRNBS9t30tmxmoLQmIAdYWDKWxhm4eKwmZ99v5vaVW6Jt6gv/comY9DL4B52f8lb6Agi3pl+5SxNvwqGW5GDq/99wFM8a27A2Gr9aLabxvKQCGtM3ToZyqRB1Yp6eO4OjS/RTOCB2H2p9cdzDDMDnwRiwWtacY4nwFbEjnLipuYFlF/rMUSi3R/pZf1f5+UdMVkkYjCPmmH8cjFDqak1+6TahO81OIZ6og6v+7tuglTu/NyWB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(366004)(346002)(396003)(136003)(451199021)(38350700002)(36756003)(8676002)(8936002)(54906003)(478600001)(66476007)(66556008)(66946007)(4326008)(7416002)(44832011)(316002)(41300700001)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(26005)(6506007)(6512007)(1076003)(107886003)(52116002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eAJrVTIHNiL4dnb4q1aMMLvqMzv2C1KE/y3J0L/H3fzDrbwMUqXC2xUBlQJt?=
 =?us-ascii?Q?A76vLmJ9hh5yGh209JZa6vPXNbrLb0q88uMNOcX21bh+vwfpf6bDofDPtTqb?=
 =?us-ascii?Q?TUPTmwhCZm7lMj506ems6fgKdIVEI+ThxJ5jegLhgZttUMKl0nwH1a9QjcZ6?=
 =?us-ascii?Q?URAe11d4PMsWCacySP7ZB/Q4XGWiFVNdOY6U9KlXXKC8qVtlZncUVgF4SCRP?=
 =?us-ascii?Q?y9O6aanst7/yX6NY6ThR5233iMofLgr5t72aTImkB3mD8qn3mGz8SODDFVTc?=
 =?us-ascii?Q?mTF+Cna864mPGIS16crWlt27akr1jquhG+Zg5c1zzwW9vd1aYnQoMrJGP7rC?=
 =?us-ascii?Q?aB+I+Wu/PNCsEw4FnwofsFwlj1T61aeLMIF7E1zy4+Uay/D5i4o+P1mqtIoW?=
 =?us-ascii?Q?c1s+3UZJ2aWCyanhMXq3FrbJqGq1eDXqZOP7qeD3bdkbeAyXBt17bXdECGM3?=
 =?us-ascii?Q?zt/rENmZ5xbTKUClnmp3+i2ri+9boNzrcwy5RFAF55uEeRyPjp8Hf60zBamG?=
 =?us-ascii?Q?Dt9VZiqpMz2F8pm23VnGvQ2lKdhbhQ3BRsCgv79WmLss6VzTkDBbGNeVZprN?=
 =?us-ascii?Q?yVSTEH/LqfL0dKhKp7Fewv4JoDkhuLpeNsFQvNgJhqMQeF8nHrXNY3F4KV6C?=
 =?us-ascii?Q?585cmjzFTmm2H92bI+Bq9R6oPluWcLHSd+TshrVbCl5nLoTmrmpilIuchyhP?=
 =?us-ascii?Q?JyH1IxCaRjSEVYWdjQ6+lVHO1lcnAvmneNgD7zIMDHwdeMfCR0Yx8yG2oOyC?=
 =?us-ascii?Q?H8hO5aCY3oc/fry1uNu+WBsM/vwbrvWDERu8ev27Y5ZQPQYRFW1s0VgqoxRU?=
 =?us-ascii?Q?Y3C3+sr7kLUflaRxUeqsnsHCOU5aqFzfbhmjS3PZTezGYnfGERnumcYnEzwX?=
 =?us-ascii?Q?51FMJKezvD3LGzYjgkdmIlj1iptoQyJLF6HgCXldr4piaI4h6LTRpidzzyi9?=
 =?us-ascii?Q?fHvvFPstVQMY+y8WWK8mdnkq2XoC84AxnGkHJyJ4AtKGwNKBpyzQYv6wU7Z6?=
 =?us-ascii?Q?bNf+pdtogY5H22Exh8BMfhlIloz294QWJ8V9IGFPklEGN5jJdQDY9n2CuUO4?=
 =?us-ascii?Q?4R7ePev43JX+nvPCwPAZAiY6cswzM5c3aX6uMkZ9WAe65XtvORdA6ZlURjlK?=
 =?us-ascii?Q?WP6R5A4PWMqAI4700b3KbpassfrKpC8JPf8sG94Zb0QyYxb2e18N9td8yGO/?=
 =?us-ascii?Q?tOfYoggV/S59hwPuyB4nprtWFgm4H6zI/FXP9/KqlsK20OuJAeH25j2EoL86?=
 =?us-ascii?Q?8LU45Iycj01MX6YF77G5z/BtOY6erZTwDFcSsRCpbIF9UifiMYxB5ugxfkf0?=
 =?us-ascii?Q?D2KmlAyDjitJlbkic4EKU75mSAKRxLlxSyxQuHCzZ86a5AqI84daE8Sb1iAH?=
 =?us-ascii?Q?YJUkTq7R0Ff9lzs25uo9f1XbFXaHWEGOTj2tCyyhoSG/57JRsZezIlEuTaYz?=
 =?us-ascii?Q?SGJs/ReJEAShbqlf1YQ5IR+ovduH37l2jRDtBmdlIotlW8aTKjsit6dZzmxH?=
 =?us-ascii?Q?ZzMmBPUtzwGVph1cLwIwwmDuR40iUBUKI/jxPp3HDJNyt0ykMJr1YYxH2Cly?=
 =?us-ascii?Q?AbzF5Y3Z9Op847PJfBbx33WI8ge6TiRFNkpK0wJHDp4fTr/NMMf0vuI149dJ?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a5d37d-0025-4342-7666-08db4583645c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 11:51:23.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AObV77R7Ve/OcH4ofS0DvhIoIiI0bUAkC/B6HWI8B5ukuLour0QPS4wwju+OHrLkXocUE/ZJfbcwkInNyBYbrH4ObMU+/6sUoDOZuEokFx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtual-touchscreen object defines an area within the touchscreen
where touch events are reported and their coordinates get converted to
the virtual origin. This object avoids getting events from areas that
are physically hidden by overlay frames.

For touchscreens where overlay buttons on the touchscreen surface are
provided, the virtual-buttons object contains a node for every button
and the key event that should be reported when pressed.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/touchscreen.yaml        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 895592da9626..869be007eb6f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -80,6 +80,60 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  virtual-touchscreen:
+    description: Clipped touchscreen area
+    type: object
+
+    properties:
+      x-origin:
+        description: horizontal origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-origin:
+        description: vertical origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      x-size:
+        description: horizontal resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-size:
+        description: vertical resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+  virtual-buttons:
+    description: list of nodes defining the buttons on the touchscreen
+    type: object
+
+    patternProperties:
+      '^button-':
+        type: object
+        description:
+          Each button (key) is represented as a sub-node.
+
+        properties:
+          label:
+            $ref: /schemas/types.yaml#/definitions/string
+            description: descriptive name of the button
+
+          linux,code: true
+
+          x-origin:
+            description: horizontal origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-origin:
+            description: vertical origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          x-size:
+            description: horizontal resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-size:
+            description: vertical resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]
-- 
2.37.2

