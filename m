Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04D632247
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiKUMgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKUMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:36:02 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF8095AA;
        Mon, 21 Nov 2022 04:36:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt4H9jffESy9Lc7+wnNaGFd8tPc6aSbOuTWoov5D591nXeOLHmEbrksY2TAbOfhEc/D7dWPkUcQwEkcJ2J1myupPxdwjbFDawApT+H9kldo65FC0ie6ZhlF+UY0LWKD1lH3/wUvW2TIxEOpJqD8KpEbS3bRnnqYtpof7MW+xryWXmcyklToLEz8MXSVCrRib37rKJFjnl9TmmY4uaCa+f5M9pJvryW39NBYAOGuV7VrXQkckgQuB/lc8OdZFJJg1l42HGSQSjMxJzqW2bmA08Ol2yYWKy3uErD0OkkKHba2P/wT7t+lm5Mut2yVPlP1QquLUobzinfFbQVYDhXiZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZLY7Wu4SwN+S3kR8cKL9Oy0CtFIEqVQW8oJka7boXk=;
 b=bDAPBr+lCYL0tFVMLN16zVb6Jh6SQSqdF2JLFI7vFVDKAbvVLNf4hHNWjPbiYlpIC602Ll2/rRBw6RXl+/b34bf4G48BB9XhidINXuJ8zDjT3XuBPEdj0xVSfJ5jsLOEF8tQHjFKFEzSW97+Dk5qjfWS3j0o9EAGZLBQvTiUKJfk/wsH17XIterlAzdJEFqkjJ9/rWQK93ZRnys16Soo4y3Ljd6QRgZ0PEu7qFWk/vk1bRfMkDq5FnDOfjMOeCV1GKhxRJ78KtlSCzvBYydzYOaLPJc5bB6dlEh3dKmxjEvodL8jeTU6A94wBLIqWppZjXyOUdg+S2b/Wda0tV5iTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZLY7Wu4SwN+S3kR8cKL9Oy0CtFIEqVQW8oJka7boXk=;
 b=lXrhFZq3Acw9LawHkzoOv6rnsVrS06G9Hy+TBZ+TjP0HMyvA3s3v9Jvax/c2jNNPZOm5CyiXZOiicSSSUz8l8tnpYpQa9QKV4u1d3D4GhKrPqFrLLGGahvK7Hrm9hVzXFG+2JEyk+VW8+RnehRT3p/c/YXuc4zYvZkpAsuf3S6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS8PR08MB7718.eurprd08.prod.outlook.com (2603:10a6:20b:50a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.13; Mon, 21 Nov
 2022 12:35:59 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5857.016; Mon, 21 Nov 2022
 12:35:59 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
Date:   Mon, 21 Nov 2022 13:35:41 +0100
Message-Id: <20221121123542.1322367-2-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0113.eurprd09.prod.outlook.com
 (2603:10a6:803:78::36) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS8PR08MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa2794f-2d3e-4089-f6c3-08dacbbcf1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2XB5/HaLvWcQGVvXlEd5o4CjjGTy1VEtJd6jsyYRTBQ+B7YsPpJzPI5vQEcqbG9qL5zl8Va5w98j0RpugGN55ygi+5xM8ULVenB5x9wWUo0M0ei5Sr7LVQ9MB4XARU/aqi6fLljJjHhfZu60OpG0LQAcWP9xi2gjGXYgcHBzs+eP+6BDCYLtsafGpYdLSbhJpCzFdnWrB2aW+yuoiBwlpOL6MlARj7CP1jv1XHqaW5mfoHh2BCUn/jp+mJmYDr28al8hIA2CFBqOSzhNCKTO9G1ryzPT1p9qzkkRlVvgqUYqXy0Wcbb3u5QQo8aQ2aGjYQInoHbvFNfwXZ38k4/fAnM1AjgGIzQ1fcvmst0bC20nbjKgiB80vtI2C7vX+y8kleMa3gCctBrCT9DlqKgZO9TAnrFWcDoedBhicR7SKxqvK3EkfvL7bMP2n48pI5ADNgdo5+DAo//WgyvO3TQz7cFH0inUZRqy+ts8uYf9lki/BXH+CfKAA5ESFutXLqecUPqQYQVPQjvNOWLQHv7bh6nLzR8y7DNkyb2SU1Yk0rK9v5fJVnVxMYOaGjHdHCzWowSrN3c698ZynFia7ZB7GFsQVzuh9jONdN7Qdfnx5ZQ2Cl2N64Pa37vm0Oc5srLtoBptaYHd78+7WGxb1S0MSm+ZNvRr96Zo1D3ot34zKiHCH8Y2iVSpS6mOEnefgHZfA1A0fy11OcSkxm9QszsFo/ylDQiH2dF5NIEYqjvcWcfbmtX9OhV/zvRA6p/4SSJbpalfC4RBizAz2k5Bk50Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39840400004)(396003)(346002)(376002)(451199015)(966005)(6486002)(2906002)(478600001)(44832011)(86362001)(8936002)(1076003)(5660300002)(6666004)(36756003)(107886003)(186003)(6506007)(41300700001)(2616005)(38100700002)(54906003)(7416002)(8676002)(66946007)(316002)(66476007)(66556008)(4326008)(38350700002)(26005)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3piY0F5OEFMQ2tTQkt0NDVpNkEyNkJnYjdtNWJlSDQ0OWZNbHo3YTN1emc4?=
 =?utf-8?B?RTFvUElYbHlvT1JXR1phNENycXZmU3lOalpwcWdxRCtSOEZ5RGFNd2RYL01D?=
 =?utf-8?B?TWZ2YUYzTHNveHBRY2R3WVVwRWJuTW1iUUtUMFh2OHBCTkIyd2RtOFFWK3Jn?=
 =?utf-8?B?M3dLajZHU2NHNTczTFVtRDQraEgrclN2Y3NUeTV1RGtUakJLcitIbUFmNDlF?=
 =?utf-8?B?SWY2TTBqR1hVN2xocXptcFdkR1NDdUMwWjA5WGd1Zlh4K0V0cjBOYVlZblpV?=
 =?utf-8?B?YmpIdGhxYkJyVzBiUzZGbW5OMjNISDZRMkl2aDdKRmdXSFFNVUZ4SHJDdi9q?=
 =?utf-8?B?MGJoamQrL1JRdjNnQzRNbjhBTVlrQmVXN1JweUtNb0tQU2FEQ3BMZmNRQWZ5?=
 =?utf-8?B?b2U1emt1Q29JREdjNUZUalJkTVhYVWhERmt6Y2ovaHVlZWVBVHlJemQzK0hw?=
 =?utf-8?B?cGs3OXFPdW9NdWEvQ2dIWWZlSTZVZEpvdkFDSXByWEV3YW0rcytEWi8zaHJu?=
 =?utf-8?B?d1FMdGxGYmh3YjRmVG1qSVpTMGFiOE5XRjI3RGJxUmJ3T2JaUHl3UGRraE5v?=
 =?utf-8?B?aWRrZm12bEJjR0JuYlZRMGdXOTgzWmcrcW15b2piT2dXa1NRb2xTY0F3cVB4?=
 =?utf-8?B?bWhkSUdJdHRQNFo5TXlPcG44bVBndG1LcWpNSGxUYktQaDZCMFcyeGtWVG5N?=
 =?utf-8?B?RThQOTRFbnIzY1RvODQ5SFVrbWU1dXhBamt3elI3UHlQeXlZNmFzREtTNFNW?=
 =?utf-8?B?NTB2bkpzL3U1Y0xuY2RxdUxOWG5PY1g3MXU4dUhxNmozRC9HQ1lMcmVFaVMz?=
 =?utf-8?B?RnZxc3A3d2ZGblJCQS8rdWpDQUQ0VnppZHBLY2dZNnQ2eWw3T0xqRFdOcVhs?=
 =?utf-8?B?alJSY2c5WjAzdDNuNUxJd3lmL3FDMkZFK3JrTUtBSXVtcnp5dEJ6TnZXTVpr?=
 =?utf-8?B?SFBTYUVjQ1hGS1g4ZHlHek45d1Njc3VkUFRYSkMrK3hPNW9NcStaNkFoamZV?=
 =?utf-8?B?M2FFbU9QMHYxNHZseXo4OVdZb3NWWHlGYkI3VzQzQm1SdjhDT05UOSsyRi93?=
 =?utf-8?B?OHZUNUt2ditKNzcrZXEwVVFSRHlXeG45VE5CcjJRUlVyTWR2S0hNUXZDZGts?=
 =?utf-8?B?TUNUOE42bkZ6c1dJTkhaQ2JvVW9LejRxUFovNUFmVElFcHp0OHlrTmRTQkl6?=
 =?utf-8?B?bGM5V0hWd2d1S2RBME4weStyYmluU0lkOW5GQkxMcW9PTjJNdEQvUGdsL0xW?=
 =?utf-8?B?a2trM2htNmc5bEdaUDR4STNSSFcrZXB5Q1VTYXVZK1V2VGJjOGVmQzBHaWpC?=
 =?utf-8?B?Wm9heEpHSklFNy9WaC82TVhwSm1KOUVickZoRms0VTZ1MWtaOGF0cXpyY3ZC?=
 =?utf-8?B?UEN3MThJb2RMbmUyQm1DVHkwTFpwbVZSRElRbytRVVFGUjVCL3pXelZnVGZ5?=
 =?utf-8?B?dHBGbDRPdXFRam9saG1nT3RybUVYNkxNU2NsZUhybVhaTllkaUlFN1ZZemZF?=
 =?utf-8?B?eVZHWHI0SFlCQjB2SlJaaTZEaGpUOWl4UnczMDcxcjRvWjJNYTgzckc4MEhv?=
 =?utf-8?B?OWQ3akJVL1RZdEpYMS9hbzJnVitOQkllV2lpTEdpM09LRTNGWGlhK2t4MUMw?=
 =?utf-8?B?alFwRlZvNkY3NE4waURWYkZCUzI2RFlRLzRYUkxDVzJmaHpjZ1hpOExjYU56?=
 =?utf-8?B?V09IWUtQLzN6UkdJalg5THZxQUJ2TERCaVQ3WUw2cUFWaUNUOEx5MytmRDJh?=
 =?utf-8?B?alJqVTBhTFZDclcxVkZQM3VwTnFIOU1YN0cyeUtmR09xY1pGUmEyaTBEcnVh?=
 =?utf-8?B?UmplVFV5Nk9hK1Q0UnlFWXl2YXgvTU5uQUlxN2VKelk1UVBRNTdocmJaSFpr?=
 =?utf-8?B?bEN3Vi9GUHJQWWlJTmUxSEtTNHJqVEd2NjlOVytOVVg4dUlxVXlhNkpqTytr?=
 =?utf-8?B?OEwwckNsUlJMbXlGbVVmbkpvZ1ZpYU1tRWxrbGZZVHN4amJMWlZDNFVKc05o?=
 =?utf-8?B?ckJuWEk1T3dIOVZudjFOYytRWTZ3SzZuaDZ0bEpkZUZ0QVQvZC9JTFc4cE9n?=
 =?utf-8?B?bFpaTHdpMDNEZm5PZGFHeENaWDMxTmlRZ1hUYzhZMHJEdG9tSWtPUTVWS0lH?=
 =?utf-8?B?aHRUMmltKzlXNmlWNkNkWHpoV1k3RmZJWVBld1o3enpDZVBkN3pHUnlCdUpF?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa2794f-2d3e-4089-f6c3-08dacbbcf1b2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 12:35:59.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IJxr6CR8S4mbS84NM2SvHy7NlAylSS+8jOU/tAbddSdBsi/RUIu/cfzP17yPKqxdL3ziY8t3Am/D1DvCnrawA96f/ypNbRwoIqt2O7ypJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for TI TMAG5273.

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
---
Changes in v2:
 - Removed nodename
 - Changed angle-enable to angle-measurement and used strings
 - Added interrupts
 - Removed vcc-supply from required properties
 - Changed i2c-0 to i2c in examples
 .../iio/magnetometer/ti,tmag5273.yaml         | 75 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
new file mode 100644
index 000000000000..b2ecd7054a34
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/ti,tmag5273.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
+
+maintainers:
+  - Gerald Loacker <gerald.loacker@wolfvision.net>
+
+description:
+  The TI TMAG5273 is a low-power linear 3D Hall-effect sensor. This device
+  integrates three independent Hall-effect sensors in the X, Y, and Z axes.
+  The device has an integrated temperature sensor available. The TMAG5273
+  can be configured through the I2C interface to enable any combination of
+  magnetic axes and temperature measurements. An integrated angle calculation
+  engine (CORDIC) provides full 360° angular position information for both
+  on-axis and off-axis angle measurement topologies. The angle calculation is
+  performed using two user-selected magnetic axes.
+
+properties:
+  compatible:
+    const: ti,tmag5273
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  ti,angle-measurement:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Enables angle measurement in the selected plane.
+      If not specified, "x-y" will be anables as default.
+    enum:
+      - "off"
+      - "x-y"
+      - "y-z"
+      - "x-z"
+
+  vcc-supply:
+    description:
+      A regulator providing 1.7 V to 3.6 V supply voltage on the VCC pin,
+      typically 3.3 V.
+
+  interrupts:
+    description:
+      The low active interrupt can be configured to be fixed width or latched.
+      Interrupt events can be configured to be generated from magnetic
+      thresholds or when a conversion is completed.
+    maxItems: 1
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
+        magnetometer@35 {
+            compatible = "ti,tmag5273";
+            reg = <0x35>;
+            #io-channel-cells = <1>;
+            ti,angle-measurement = "x-z";
+            vcc-supply = <&vcc3v3>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..ea7acec52f8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20613,6 +20613,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Odd Fixes
 F:	sound/soc/codecs/tas571x*
 
+TI TMAG5273 MAGNETOMETER DRIVER
+M:	Gerald Loacker <gerald.loacker@wolfvision.net>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
+
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.37.2

