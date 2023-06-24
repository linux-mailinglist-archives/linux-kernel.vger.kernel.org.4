Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD11073CBD1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjFXQC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjFXQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:02:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2049.outbound.protection.outlook.com [40.92.89.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3581C1BD6;
        Sat, 24 Jun 2023 09:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZexbc2+HkrRTHDedhVgXfReX+n61Gn8w3Py6K7GsUuMT1Bj702rlPBp1ReEQvDgi5Xphz1RhnVxmlOckQUwKkT4GYzZT9v4E5pdjlnJzisAnQqLtkzjOCk/A90FPZcHPtGXVf9yqwUGsmbV7G2GkPVuBQg+C3/g3rZiczcjKSRtTcotw82WEuIWKVjSk2xIzIdCVSm34XFEmrPZLgb8mSg1Q/9Qqd7tnNMbYl8V8dzGa2rGGqKiN9FjEW90B0QaoU4IIEnJyFFL6c/sW50GlJmhNSJHGlG65X8xCRQTgXnob6/ltfU+f4QNgMr4zKEuZfuX59yTlIy8Do6e7MbX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e9HJZCoQUV7mmtKPw/q+Qk7W8Q2v2DjbJwMZYYEp3M=;
 b=ggj+2ualM48RuVOt3SR2yjN+81nMTg8+CEtXku9UivGFzNhv8CbnPPVBLqLpY2Ryh43TnYMpLFdsuNzVjAjgzMf/cTL8pyMpCbBCVLo9ItF6A8uvIGVNrglI4DBy7edzOUTfd8YePimWWnI+WQxXQDIcLWxzIj+701TqU3O7AVIa0TQ9AoccPWWLOAPU507PzDCdkCnPBpDfxPkUKkzBjYa5G43inz/5tRMvKC53JMeq0keqxS8dZ8j3VnYKtoDceukMCVcVIyFg/pYGQDcCH1ZH9pSvLAzl2iGyvEc+vtcBxB1qiDW36jgiNwnABjlv26yObboBky9ptH2fYz1hRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e9HJZCoQUV7mmtKPw/q+Qk7W8Q2v2DjbJwMZYYEp3M=;
 b=OZwcfegCzf+otEu2BnqaOhh/vn/FieVTeweDh3iONQOvsBphq9JRJXephhJXQ+bYKQ9THQMuxMF47rlBBta0HnCCmUD9LabUQ97NfPtrTnuLfocfwJU5LPjHRIRn+V+a/Mlt6fyHjp3RDXW3v0QOKA6vzYy5PU1FU5O/iRDbIlrSqGvlhzWkxCPU/fZhcxDPDekpar10pAz0P0Ip1gSXIgUxTb9DsWXyrd4mv8mCFM2O1TVA2TyYpz9edHXon6m0rRia/gyv45Qq5EqRxHCbOcXOzQ13vmaUbrOsQS2hZotNJunXHNQf/hGyFOrfTie0FHPCGSBhonzUURROBjWEUw==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS8PR10MB6102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 16:02:26 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 16:02:26 +0000
From:   JuenKit_Yip@hotmail.com
To:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowki+dt@linaro.org, conor+dt@kernel.org,
        broonie@kernel.org, vincent@vtremblay.dev, michal.simek@amd.com,
        geert+renesas@glider.be
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH 3/3] dt-bindings: <hwmon>: add sht3x devicetree binding
Date:   Sun, 25 Jun 2023 00:01:48 +0800
Message-ID: <DB4PR10MB626179DE1C511B10ECA74D209220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230624160148.218786-1-JuenKit_Yip@hotmail.com>
References: <20230624160148.218786-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [b0qT3Nkq/x3z1OTN1gB7Mg4hNGENkDoB]
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230624160148.218786-3-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS8PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d975e2d-e0d5-4bc0-cbb7-08db74cc676f
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnrMCE58nQssOil7WqC2+V8M62fc6FDVzwqWhMXtf6tbyWA5eGrzgcH+Uf20DsQudom6/mFa/wHsXdJklIpxj39VBdxSapuaeOF2WR35EG5hzfLsWDu2NR9L5hzgy7lzrDHwYWbbE9eRmBAT8Ky3NP9naEZGKcq0/vfOXwFvA/8eF5UCxdU6e1MNPWRuLgCzcA5ZfNsTdd13vfo1wRlxlQ2FNpyfvWfbtiaLI6e1OT8B0XciX4E0U3hsjzSQL5iwbMYkyIbyPHtwf2qTZDJWzw0la5n4cJfqIOl5ZkmwgpNPLueho7n0LGC+kG3XKT/BCbEm9S5E7yLzclWG/JkAGm+JEt0SZA0TvFtqnV6Rkk979Zi2i/8S/EkUM7D7hj4NWwkHSvYa2ucUmtMLJEPpKy+6mKPzZ/Nc1KejpoKaGARKJwLj9keDhDoECTdiARN1tTGvFXwjviSrZNVBrIQfZvZLJ8o8ScNtO4R+JA/9ABGEHdPua939WZMXC9C0613SlNxwg8jRNfBt+GIFZEW2A2hlW5Lcbx8JsT0IxjcJj8eOVG0yTHOi+VIJt020hGoeVAHKRgAkU0y5ajPB6AgGi8eKF265eKkwdbMNyk2mQlgy+2kdYDAAWbVGKCrdhrVz7ER4n/QZOP5yiTGOf+HSbb7bQfLCS3reQSYqeG37WcfB2N13n5XS5e+51ToMEi9BFJbwm9M++er9+U5leBdSt7gEQfxIVy62q88IGFeZtJTg+F75nplPP+fLPqhGkYAbnNM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSQLxcFQyvIVVp3ndxexXZc7ucF5EbIjDj6h1Q5zgMB5FreT32vf3DigGPZx7LFzSaVxAgKzMVLMFcskBALBmMjpatYG1w5nXn+6IzVsUAvt+FObl0AUFmtfcyzbSVRiTWEpEJJ1TIFLwifBlS8kkuLCEJ1tMnc4kRTroYc6LAsVQps6Z5Xw+S3PgQpUxTJXfsvOaAL8leMuskepS3+GmhjQCnyZIY5gT+loe7mNrfrSEREq68kQjvY8n4+RGL70o9yMtcv39JVf0JimxXHaCe5rj8hDEuOcvL3r9YcZe89aUXZZBSQBy7xvUBQop7V42nAcO0T4VJFXA2PZChutTNLApttQTq106s/DA47khPBer0Js+MLtqG8Qu1sS/+yphPGbIYWcoB2H4ow8o2LeveXJoNQS5Y20Cj01OJq3Ru5tAFYzIQTma35bovBXy8sUuQMDZec4QCf5box0PxgOZZI8lN+q14kNvlnhd2BOfx5ttRqfcLHgboLrbWZpAn7f4YbCYqXLAESj0RI+Qbg/pJLFHXStkrGceqBaWUpRcPf91S+LUwIphSJjQObUp2pBMFlEmKdYQF5y5W+wo4kwTYcMuMsutrEt63vEcRfZG8I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LB909VzRWCy0WmVPWbMyM5Hft557c/HGKnN81Qffa0nOWKQlyvvkk3rTPMMq?=
 =?us-ascii?Q?FDt9Ugl+7e49WC3QuDJiOdyynw24VkTy0wmjF271enGGGunpLc8ED4QY0Rj6?=
 =?us-ascii?Q?mV4cEEBMiEEcxd9VCzlZch6cwTco2M77LtiVI2oFQCC/pwdwqW8WKrXPfnse?=
 =?us-ascii?Q?gInH506beQdGu3WrZL8UnkDbiI0XFx3OS5DXpuPOy85Abdr3CpErP/Uxix3C?=
 =?us-ascii?Q?rCGGb5RFwmHrfUeSa16CKBOooeLDCQAS06WwRJGUchNIVFv8TGcrG/ohsiXy?=
 =?us-ascii?Q?RBsCQvtZY5xbvQgIHtWfdNTDBAJoE9ac2y9ciklbHpGzYrS3S4nC1TVwNmWO?=
 =?us-ascii?Q?dr3DElXXTrASxrA4Sc30Cl5VCQQHcw7c2lwRgws9AZ5WaDUfUwSa4KAt1mbE?=
 =?us-ascii?Q?z6StPn38qhUxNgaoM+hH6SvOKUsBL1IFEj9Fe6yam9v/kyAPZ7JqfN2lJHuO?=
 =?us-ascii?Q?uFGl/Z2B1HpEN6ROEL1IkHgY9/x/+qSqgSEonHtIIfqNKi78SxUuNQec0B2F?=
 =?us-ascii?Q?c4spp7VZVQoRGlXAoZyDzFjC9h2fdKtQI8gSrbl456iv/6UNZjnsb7ylvlSP?=
 =?us-ascii?Q?4VshbePX7f4mmKD1dYO+pQEhlYhptvVzPlM0jDjKaffoCqonc+RrXMtevrOF?=
 =?us-ascii?Q?axQkn3RmbcF7jM/fHokkPKsDkHBxoYS7YEaXLIC7/frY6706utG4LKRGFThW?=
 =?us-ascii?Q?7WB2i4uxJnzdb01Pdpw1mzhkHyfjPHmFBaitNuJDMRGetoDCfCRZRSNfeavw?=
 =?us-ascii?Q?NTMmGFHQEBoGqyzsLZju5tVQz2jlhEDBPlulfHoQBexunbGr9IJMMWIYAGoP?=
 =?us-ascii?Q?qEvbgC8KZJ/28/7QS5cb8Gu0rNqtg+cimP7v5Dge6JMosRdCGfpmll5wfnHx?=
 =?us-ascii?Q?XgG96oMR0L74PHI/ajwd9Y8JtKIe/4LcyPN6wm4i7lm8zBFRCP1PRQDAQIp5?=
 =?us-ascii?Q?DEiINnODcqTsP3yNzoRPMqm+GBvft/ffDOgAJXA4DdkZbi9LwfkzsJRytjZG?=
 =?us-ascii?Q?990ChUjQbLi3A8M5PhdzNxUMf+0t70x/JBGRHBC6AAuIbGttyRMZjf8/91vc?=
 =?us-ascii?Q?e+WM0aQNUz06SEa84wctakl3k/RSEq3Ch4gNPB0FAqR9nZMOh6Tw95l1SPu7?=
 =?us-ascii?Q?W1mhqGA5inrIh25mYLMUASSaIeHgJ/ZILUmaeh0cxnZwqcuOdewaWzXNwHBI?=
 =?us-ascii?Q?ziJ4lUNFUX4SXc6s6bLaidduBektMo3Ojb0MBknLZI3qw/Blbb+mgA1uiWo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d975e2d-e0d5-4bc0-cbb7-08db74cc676f
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 16:02:26.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JuenKit Yip <JuenKit_Yip@hotmail.com>

add sht3x devicetree binding files

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 .../devicetree/bindings/hwmon/sht3x.yaml      | 31 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 +++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sht3x.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sht3x.yaml b/Documentation/devicetree/bindings/hwmon/sht3x.yaml
new file mode 100644
index 000000000000..8ff0b8d41f91
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sht3x.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+% YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sensirion,sht3x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SHT3x-DIS humidity and temperature sensor
+
+maintainers:
+  - JuenKit Yip <JuenKit_Yip@hotmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sensirion,sht3x
+      - sensirion,sts3x
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+addtionalProperties: false
+
+examples:
+  - |
+    sensor@4a {
+      compatible = "sensirion,sht3x";
+      reg = <0x4a>;
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index ba2bfb547909..b2369d1fad68 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -331,6 +331,10 @@ properties:
           - sensirion,sgp30
             # Sensirion gas sensor with I2C interface
           - sensirion,sgp40
+            # Sensirion SHT3x-DIS humidity and temperature sensor
+          - sensirion,sht3x
+            # Sensirion STS3x humidity sensor
+          - sensirion,sts3x
             # Sensirion temperature & humidity sensor with I2C interface
           - sensirion,sht4x
             # Sensortek 3 axis accelerometer
-- 
2.30.2

