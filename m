Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4162969FD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjBVUjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjBVUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:39:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2091.outbound.protection.outlook.com [40.107.237.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B282BF1D;
        Wed, 22 Feb 2023 12:39:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERuzQjFwLlmiEEpZkxiNBXotE2mFPqroSo8rCYzCModgK76FA05z6UBO0MMqQSFFh223GWNHS/AlnlW19guPYFtj8GtrwKD7tdJmch5KCYRTQA0o0GkzREmxe9I1xanL9Wq0BuUI2banBtSf+gafb6h51BsdPtsMdRWZ0aUQlbKM5vd2nVQsh0nxiGf6HAIZiGO4fy1nKFNJ3+pNXZBclNvfqC4d5lr28KRwFtir9FwoMg3qFGncBaf6E3DQ4EGnB0LLIAvAEOvdJetgWPUUYvoUU6t7G+8UgkZw+Q+03b8i4gj1mXeXJTgSRMbUNWc3WxR2yNvZhoPGWnJF3uJmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN4uI41p9UF5lByQCUW4ee/3X4Nf0F578VHCBudbQrw=;
 b=RBRPjf7dsLxm2Bl9zB+y2F+MOsT3acnfjEKxPv7LHRq2xk3aYImhQ92QSBO4tKKESZelKqU0yDL0g6ddp6xEOq5XjFfyMoFMs55vOrjUQPBmvio1YWRWK7EDCunMq4xgyr1xTGZO1sZSqU4KuF0RS/mSXTzu0seCwmS9jhORjZvzsvQSDB/SG9Q6lkYhHGfbFQJH096jPWuxyo/VnkaNQ/ErfS93nmVgIWCC5YJdJuXKcLGwCQ+V6j60MuSBpBqhBVAkeItFDr71PLgBFoGmaBAdCAshZ4edZmI8Eaj3q3wv8v0r2B1Tp+ZGH8dmfpZHXaeGTFfNt/TnJnJc4VW8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN4uI41p9UF5lByQCUW4ee/3X4Nf0F578VHCBudbQrw=;
 b=hounDmYVH9ddt6byErpOBU/rXbkjnh8eIYXCyQR+QSGqXjAr4CykqBcGz46lLSyTppYCTTXreoV2H1MT50Qh+Hy6wrPvr5YRsgoDpb90Hr/UU6t7IRw9krEDBjO2rC/R3T4L+5Oz3McjW2cbX3vMG+g3tDGYz9UC1OlQd7Ad2yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by PH7PR10MB6033.namprd10.prod.outlook.com
 (2603:10b6:510:1ff::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 20:39:08 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6111.010; Wed, 22 Feb 2023
 20:39:07 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: omap: add phytec pcm-049 som and pcm-959 dev board
Date:   Wed, 22 Feb 2023 12:38:46 -0800
Message-Id: <20230222203847.2664903-2-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222203847.2664903-1-colin.foster@in-advantage.com>
References: <20230222203847.2664903-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|PH7PR10MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 6039e84c-eb57-4141-aa06-08db1514d85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2pYQcD9D/41KYAQKXgnwvNM8k9bOpYHJDwprWzkyW6ZPEzMfi+RdOpftTYIQFQfxW4T3gnTONEW1Fak1MC2dCqOAn7oVKS8HzlVLNKTb+BkU7HKjiJ7SyStxBJXOByCuiD4BN30bA7fkImy4jsmwYKHOj9FY8kwvm5dB0hXJA4E00JmJmp5na71mDknXE1DbKVOb6Bx1QeRqq03a/nRsjh2USm6WV2URgVseEU+TdG86UuEh6ARSzPJJoqd7w/RZ+lWgsWq3d+V7QAxrcxeKkIplYKWG64TEtOeXrrOfEadxC9jN981/uE0f9A2BF1Rduw74zxmsEsh2TzVWuByFP4FrDjcOSWqqmX7peTNEERyC3tNpx1nokSGTACzqweSCm259nr4qqvteetsCDvqfceWcODkXM6ahuTkmnGabsR2NT6aq37e1D/xJDmp9wTIS+/tB3adnXXe8PL0FmW94ZnM90IQPOiyWJAWRLY5dKQwC4XcKADIlRCYZISFASYd1ArWvfsNX8q3RDVHi7Ia5p50TVsG1c40b0OcBMSCNlogydmlmH0u74tkspQGEdSXAqJeYSsAQHYfrlRZFjbw2LDn+Q1bjBRaZ9u43X7lWjDX/vbro/oSXRqN9LmGC2ZOGen03Rih2j8/7oaZlZNOaxXdw2JRnEYwc0IyNqhVktmK213jflfOeUCLemvSQzvD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39830400003)(366004)(376002)(136003)(451199018)(478600001)(38100700002)(38350700002)(86362001)(2906002)(44832011)(316002)(54906003)(41300700001)(36756003)(8936002)(7416002)(4326008)(66556008)(8676002)(66946007)(66476007)(5660300002)(966005)(26005)(6486002)(186003)(1076003)(6506007)(6666004)(2616005)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n0ay9sFVJNJqRWuSaxTxfIlrXGPNpDcmljyZv/0ls4LiAIMixX0USV6doOqK?=
 =?us-ascii?Q?NQL77uFUI/hCNA8czkYOAaWPGnFO9WH9NYbRZ8Rh1WHeU/+iJgOQmEf9oq2g?=
 =?us-ascii?Q?v+dGrn+ajSj2T4dr58OXFIX1lLS2F4c56Pim6JTKljhFgH35mvuq42YNVkHD?=
 =?us-ascii?Q?fDkk0bdBTeySwlC5/1iQjwt7oJlylFzkNLN9JfsBlmFdALJOLumkxiqRTPJe?=
 =?us-ascii?Q?715R+eEuvYqo7LWQiN0Cv9k6xve/QH7o7U6o7x1qHynayAA71JClSeZAnG04?=
 =?us-ascii?Q?9jYVOdeOcMWYYv2lXj689DsCKjVnxhHZOgrwkgznkWlHnxV2vpFvdI5M2n6U?=
 =?us-ascii?Q?VIkx8ZOzpRNZRtMMW92vpOf/lnaq5cI/Ul/1oE+PfmAEcFHhNLotCrCX+brh?=
 =?us-ascii?Q?6fLRcOWoBc4jcjfIPRwrA2mo3a9Un52IwFj+Bv78GYZGnSMCg2lH4TZeHky+?=
 =?us-ascii?Q?V9w/cXA9QM1QRKvBuISkj6Hno67w001315dnKabIqircKw1PNEEiE7E0I/EE?=
 =?us-ascii?Q?NPVj88Rzh+ObFhtoe639KnOeTE1x3nX0jcCMGwaaZl4RLHELmnxbtAIvNko/?=
 =?us-ascii?Q?P8eHCgkE3kIF0Wuxo8Q+g1o2TmRffKSO0SbuOxYWgtmvgftb9chlwmFcHmSJ?=
 =?us-ascii?Q?9qWjOLQRGWCV1D2DbhfFGVX877BY/6YeimEcpzUQu+VtxxcP2pmBK9ek9hJF?=
 =?us-ascii?Q?Sap1rkpylenUXjwx6/ept00W+kFYQDuqGUPcKdFIhhc01Q4Lvx8cYHcZxc+k?=
 =?us-ascii?Q?w1IHIdtYVMZ1hYFtuWucTnEgAxXysWpXmlIAay86YHSwaKggFlzifw/MVv/G?=
 =?us-ascii?Q?KYesJA/EDI4AjCk8kY+jY2l7reaMegIzEP70Nq/EHIFzePWxCGt8bFiyxLwt?=
 =?us-ascii?Q?V7u7f+ENVSBKfYMzxb5WbpV6dQ9lUs7jIXCE/AYVZhGYrVmNx3Trv4i0fdBp?=
 =?us-ascii?Q?r8l7hKZdI1wPXqrx9apfM4BYMne/Z41JHKX8WfCtCMlLUJlpp7vuC/tiFGRb?=
 =?us-ascii?Q?PPJAjsTCsvtIov2LUhNGkGIPUZKu/hVacY9Vw4rrrBXxBVuMER3gJALMb2+B?=
 =?us-ascii?Q?9DrfIjlHq1I0RpHJBwJfDdkHzR1YNs1o88dMF1rYJIs4kEqpnRrwY+k3OXZK?=
 =?us-ascii?Q?ZsBKY89yAG0JcnEvdO+YCqimdEwloF7mmfKR0JRFnlQW3y/jgNyCPw/LAQC3?=
 =?us-ascii?Q?+55ugKn92MiHniSW/aesf1Xi+ZuH31D3dlJOCb1thY/EvU7n08QsYiH6jjmQ?=
 =?us-ascii?Q?LnnDDj6ed0JwteUB/Pj/RKXr9EHvz1paRa3ufRAhdKc31KNbKN7UiN3im9A5?=
 =?us-ascii?Q?TLTQP6HkH8TfVe2BWe/BM7TBZLG6gDY0VoibnX/P43jHQvkahnX9ILG696+B?=
 =?us-ascii?Q?7/347d/OrF9jeg1xEEjXOiwn2ckzqE9c+ie25RDxIRzAPmU7UGaYz3PhfUzu?=
 =?us-ascii?Q?JiOPfzdHo4Y8RIiAWnCkrCrDdMXkvLhBoKYITyhWV1fAwFzsz/npC110rS/h?=
 =?us-ascii?Q?7J+wkgl2mgiXtthLpjKEprknrH5xNnCmmcHZrHl/6qF+DSxbiWL7SlFb8Qud?=
 =?us-ascii?Q?Afy1rvyWNjY938roB7TZ093/jfKddwgRSdazfr95MRTM+hZ76aVCWxkZVell?=
 =?us-ascii?Q?0/RXf6rqawlnNErlTjoUP3k=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6039e84c-eb57-4141-aa06-08db1514d85c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 20:39:07.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8F13CVsmeNeriyLBxfNVvOSLeq8wAUtuBuoml69ooppCDz1rHfOs3DNm09Ab60qXDaghIwwSIdyuzWpF7WQL5BUBJt7OtCzxqU0Qoc/waQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6033
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add yaml documentation for TI OMAP devices for the Phytec PCM-049 SoM and
the Phytec PCM-959 development kit.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---

v4
    * New patch, based on a WIP from Andrew Davis <afd@ti.com>

---
 .../devicetree/bindings/arm/ti,omap.yaml      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ti,omap.yaml

diff --git a/Documentation/devicetree/bindings/arm/ti,omap.yaml b/Documentation/devicetree/bindings/arm/ti,omap.yaml
new file mode 100644
index 000000000000..9c0e08f74fee
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti,omap.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti,omap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OMAP SoC architecture
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+description:
+  Platforms based on Texas Instruments OMAP SoC architecture.
+
+properties:
+  $nodename:
+    const: '/'
+  compatibnle:
+    oneOf:
+
+      - description: TI OMAP 4460 SoC based platforms
+        items:
+          - enum:
+              - phytec,pcm049   # Phytec OMAP 4460 SoM
+              - phytec,pcm959   # Phytec development board for the pcm049
+          - const: ti,omap4460
+          - const: ti,omap4
+
+additionalProperties: true
-- 
2.25.1

