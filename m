Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A86697803
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjBOIS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjBOISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:18:53 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CE736445;
        Wed, 15 Feb 2023 00:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHr10JQiBXHqf89jV4v612s+YlAseWKc6ph0F4qQEBi1H2VRC2/gJxwEAJdpec/3Huz/YW86LUeLYCBoPQX4CCzZQDJ0rOz2Q6G55n1tEsU2gkgnnfo274nP65ugcyR9VoYzVOEobne+IvJ81QdQ4aGK0qGk7Ue6nAgCRls1FK8LWv2mqvOTUqsmG5Cbb6oBMy7uzh8G+vcA3sZ0NEDKztoVgLs7tZPDArauzMdsf/PH06cpvGSx7tKVp/SkvSYjDhZwjmccN6HxB83AnsGikearNeH5Pf+DSjF59BrK7XZQv7jjtPYisgFyUk3rdO2rGjBr1LBzBSLL7VbvJCOcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU2q3XoQC7F+GGI5r7fklIDMQSxB+nIOpruwJfY+o3w=;
 b=iF5S2kEI9aWfaC8xiXjtIbvdDDEgvt3DLR67HQ27H9evAg0yCnLf5iGNiQMqcdmNIhuMJ3CIOG/CZSlVCYNZ0tkHiRG0Gt8ps1P3jR4meF0MbC6IQL82PHCO/aznc5R6+qd/5EfjSKOPSxUCIP5g6EIcr5LlvGf+lUznVNslj+ofmOQxGIWbQB2R5E8dgww2XqmvgKTwCqrbuFkmSAslUy/0qZnm29BM8VvWt9C0qrFqRFITR/knxHcA7Xkj4PELwq6bl2tVmSx3F/nbEGZe9+O9o1TM96qNyl7t5j6GuN2SwwSE5FYKXDYvWdmv9KLAYE9CyPR5mSLr4uvqYGKuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU2q3XoQC7F+GGI5r7fklIDMQSxB+nIOpruwJfY+o3w=;
 b=sT9XRCxtINTcIBl/6UGiVj0yZDQskyX4VdlIhSjFIsXynsR28nEf7DYJj4dpNV8/3C+nySs3X6WVb1PzY+Zkvkugo8AXgcN3fqz29+CpOLybZ7KoSI4vHsUIZJPUcHzAZNeygPJ79q7/Dbj45uy9YHrHzk8spDCjjW6l/rBeo2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PR3PR08MB5706.eurprd08.prod.outlook.com (2603:10a6:102:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 08:18:49 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1%5]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 08:18:49 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v2 1/2] dt-bindings: rtc: nxp,pcf8563: move pcf85263/pcf85363 to a dedicated binding
Date:   Wed, 15 Feb 2023 09:18:14 +0100
Message-Id: <20230215081815.3141776-2-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215081815.3141776-1-javier.carrasco@wolfvision.net>
References: <20230215081815.3141776-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::18) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PR3PR08MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af7fffe-12e3-42f5-0f5d-08db0f2d43ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3IYy2Oskv1e9Ksx5aLFXz0ZCBOBAQaGLORrqn3q56FEv0/nwwmc+rn2o/OCAfRgZHue36ADx6YVxE+UzFXHkNtCRfqYjfZNH/zdhhX+6sx0O16wCUlfZWzlNboAtQts4cflawcK2X+rOi7P4FOtiUr5eJn8NRnSo1uzcwBmNr9t7Qu9WHBoZsFU83cZX78xtvvvHbO6nvd8ryPZoyR9qWoiwaRaQet8H/tigu81+AjwriWnAX7dV4NxgeRM2SfxWTqGgOb+W6ADyCqOgNFqpy245X0hYV8bHyENnvlC+M/DuW1FlfYDUVuUwTbrihsI8GEL4TTPvMNgWr1DJlnOc/NABE0vqMHmFqPtby+fRmMJJpLpuXAMhjdL1oycVTuNZPK9Hd1s5VFHcMQW0mKZJaZTitVOiYXYPshZ/QmPUMJJqjvv0fbmjWx2KfPUpD/rpSl06Ikv1QJQmfsbEcRS0hUPNtVo0yXDurat4Zo+cnjsVqrYglrwLC4uFuuRSsysRhTpghV6ekXSOwowY4kkny9SkfF4Ddkg4WbWm6Be+neC8sqU9v6KIOsMZ9MIg4Ba+WaO4wbU9F8jkGprAc5KjI3C3RWxUCL4kkT/Yye3SC81emsPx7K3tM1jaWpgTG0V7M8VefLYKrL5DcjRqIEhSVa2OH3F7rSYzL9C7PCMnv3SuU7J67ABJGdu4Ve99cYAr1fa7vIrXEXxAbvNleYug+G9GizaM/w5togZzCfmDOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(451199018)(83380400001)(316002)(54906003)(38100700002)(38350700002)(2906002)(5660300002)(36756003)(44832011)(86362001)(4326008)(8676002)(66946007)(66476007)(66556008)(8936002)(6666004)(107886003)(1076003)(966005)(2616005)(478600001)(6486002)(26005)(186003)(6512007)(6506007)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fo2xJGtCkJ2fV6/oTsOSNx5oSTMGdfkEeygLPzR8NH441bn7eEOQPjjFKe2g?=
 =?us-ascii?Q?qPNld8W01ky/cfGyjDMoQ9BuArw5wrk9Ief/Lo9ZNYrdHbG//tT3hVhul3F2?=
 =?us-ascii?Q?i94Mn9TFdYUIz30g06U7JC0iap2tc1nbzmTHX+/822MvBt6rUjnV5k5jIoy6?=
 =?us-ascii?Q?bqxUZr6D7V2YDTGplLSxaPO3DA7wc7Ji9Wgc+OAI5XdlvzVHJP+VAd4lFJq0?=
 =?us-ascii?Q?ZHq06HYsdnQcWRIJ6AnZd6ljZV8zWjJ3qMJGJmUG4w7Zwme4Arv4CmKpFRDt?=
 =?us-ascii?Q?FWZMPkWBD1h554ZoNfivIvf92roMNvwnj2O5j8+Z70sRXqGnCTw+5ebdbmCF?=
 =?us-ascii?Q?d+S1gf6cfbNlxWuptWcyR2BrpEXDHXBrrs6uiGG3wpu7RE55WWn0DNPWoy5F?=
 =?us-ascii?Q?9sVgd//EfXQEb9MuVGD4Q4tigY6CeG8AqgnVBVvchRkL3Sy8FcAMFWLTwDh8?=
 =?us-ascii?Q?hbyHx25933T6O1U39oQoScx7SuGjREZDK0gccE/j/wCx66nlhpIqp1+YNVE3?=
 =?us-ascii?Q?Sw+Syf7ssy58ypBIP6z7z4gE1HzvQq6n3lvXTiAXQpEOeMqFGvk75NWKRwHA?=
 =?us-ascii?Q?HOxsIQGmQZ/rraa9EFNhHr28vdAdG+VSccRddalcShKHP7KfruenVfE9emJq?=
 =?us-ascii?Q?RPYq5dWIK3mV/zVIhLu7pVGDG8/mqxTUOuFP7W+PEKOXu/3TqmqmbgyWq1xM?=
 =?us-ascii?Q?ZD8YI1qXG2fRhq55YZsQDPElsDE5oh8pOuiy+CkL71KlsRrWljyOXmq+FbOX?=
 =?us-ascii?Q?UlCWstLdS5TDSXNjnpVzsvTplc48AmdLxRD9hiF53xnuEF4bCr7hQsf/PTU+?=
 =?us-ascii?Q?8eRPIWrvGKl3ESoKpQ1N3BB7TD9h1P5wv9DLfhYpWMgR85wI2L//SxF0jF4T?=
 =?us-ascii?Q?zDPSGysKu0q372Im3xJGTeoqBErZZdczhHGZz+eWxFFY4V1n3jE9fufk2XC1?=
 =?us-ascii?Q?hUPzyfiphEyfYngxc0sp34aEOOvY5litN0LpKRFF0XEN3kX8xz8IcmIMD6l/?=
 =?us-ascii?Q?JlJiD5TwJ7ekNQtXbor46pLb81wgnUYyClBvDA5ByUEcL0ZU4FMiOob2b+5J?=
 =?us-ascii?Q?ntjsQG69ZsTncFr8otij9f2MMhOicy0ygjtA2OFt9TSV//7UQ7b6jPJnheeR?=
 =?us-ascii?Q?wjwX7ZglRkr8uRDGUySuVXlRFbL5PgUirzx8CTWepojTEkBScJJRpEQw5fPI?=
 =?us-ascii?Q?mjtUE7qk0lSKWFFFtF0ntrjUez/5dosIomh8pXoV0h30S/gQYbH2GhQa6FO4?=
 =?us-ascii?Q?BmMlbHY9FgbgZx/Zx1YyIOGNS2QDFln1dIFw0LUPLZa8xFkymk8L/Lr7i4EF?=
 =?us-ascii?Q?Im+795yCsudVodRxQ+lpwDvrs3AM/WZSvJttgbtNVeKGSs6yBAOG+LzDPeUq?=
 =?us-ascii?Q?eEe41/B43/9yTbARpo45SyphvSTgYhxAh9Yb6y1KRQ+OymPL8xpNxA34waMO?=
 =?us-ascii?Q?v46zLmqHcDbdrQFCSCFsOdzy+dazrfc8kvLTy3Vz7zwmAGIKV6RDTjkrYCTm?=
 =?us-ascii?Q?ATLK41z9kAuYpJwnaxrK8FBYir1LKzRFLxl4zGMlk+YKV2UZ3SucrqBtjaYn?=
 =?us-ascii?Q?Mx6QFmM5xfvYPlKblt4wHhMPtfmBo820KyeYc01Vr4EPmPXq1FzLV2/C5NwY?=
 =?us-ascii?Q?8MT5wcpM6109RUX29zbblA8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af7fffe-12e3-42f5-0f5d-08db0f2d43ad
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 08:18:48.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0z0rO48bkSb9ryaMp1bMdbvqG4UaBTHBjIdMokM/aejkgw0eI21r3QtF8+7P1yrr3wwwUxe5BkkGcGm94FZonNkmxhMwfWvOY0XbOMs4R8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These Real Time Clocks are managed by the rtc-pcf85363 device driver,
which now supports the quartz-load-femtofarads property.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
v2:
  - create new bindings instead of adding conditional properties to an
    existing one.

 .../devicetree/bindings/rtc/nxp,pcf85363.yaml | 60 +++++++++++++++++++
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml  |  2 -
 2 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
new file mode 100644
index 000000000000..52aa3e2091e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf85363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Philips PCF85263/PCF85363 Real Time Clock
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nxp,pcf85263
+      - nxp,pcf85363
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  quartz-load-femtofarads:
+    description:
+      The capacitive load of the quartz(x-tal).
+    enum: [6000, 7000, 12500]
+    default: 7000
+
+  start-year: true
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@51 {
+            compatible = "nxp,pcf85363";
+            reg = <0x51>;
+            #clock-cells = <0>;
+            quartz-load-femtofarads = <12500>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
index a98b72752349..22909a96123e 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
@@ -19,8 +19,6 @@ properties:
       - microcrystal,rv8564
       - nxp,pca8565
       - nxp,pcf8563
-      - nxp,pcf85263
-      - nxp,pcf85363
 
   reg:
     maxItems: 1
-- 
2.37.2

