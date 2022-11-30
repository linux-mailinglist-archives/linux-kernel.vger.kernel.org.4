Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC06863D897
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiK3OyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiK3OyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:54:18 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3B7209B5;
        Wed, 30 Nov 2022 06:54:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWnV1h/+HPlL6K8jSUdt2BZvhcHO+BIZyGGyw7of4eymO6QZYAXLc8rmKsxvlSY9rx2tHyh3pFdfWwN6HCtmXUnvrDP/gYRo9TV6OrZzUaMcQYXXK4UdcllznySqlxvZX2nmaDeQNlPZU5N4gsD05TT0Dc8ZEp8XW/OoZl/wWgzjG0UCqPVXynzANgDAAnms6GLYoIes2TbiBC/tI7xacyESGXW4ohMpNb0ZRp1u1KJeXXb1B3EYleI//fwpXmFCmmRaUkzkj8XAFpNbgA6Gsol6gcOzY0Bnmof1fiLuuakyL15+A07BjkLAVvnge6A+ThGGt+6i13HkeaWS4fJ1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgJFone7l8oqZfqhQiTfHhuxlAO7drpTi8/2adeKPDA=;
 b=mnM62A1SaBrLvYxy2N5KC3AzqWyd2lCC17b+BLyhC/NXqQturHNpoKJB2sd9YeRoDouF1eps0u6XgvzM6zsereDa5BwrpSSykxnGoXv9ZcMioIB1mQgbbN9FBHfoDiXIEf1hRf+L2tOofZUUR1tq0OlFjpBMVsRHAdwcKe6BNo1KtNhAUHoJTi94MGJaX35Qf+7Bt8zIM2zgaFsI3tAVO7lsBOV4nsDMMEc2MUZAHqn8kKF2HUD9RlF68bTG8UeSeK466VaMhh/4j5rqL8fG30G+jvg5OZLdpPTKlE5GLJwkCERCpGeqEqxsCsBVEaNzdmK3njrDxHDiAZsBhKA6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgJFone7l8oqZfqhQiTfHhuxlAO7drpTi8/2adeKPDA=;
 b=2Dq+6nl/k5xJ6IlVIyFkDS/8eMLqWl9yUWtAG0y2TJsA6mGi7Y6KQM3kdY2kjCihPKjC6R5dKPIpzTdxyWKnjlqMSkZZPkEClRQCMEIxekColc8CoHKu3BgJMzM7y+DRfDVqaMvQVY+rQdxOzS7hPl51D9rgAC1TDuSjkRPBsQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by DBBPR08MB5977.eurprd08.prod.outlook.com (2603:10a6:10:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 30 Nov
 2022 14:54:14 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Wed, 30 Nov 2022
 14:54:14 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
Date:   Wed, 30 Nov 2022 15:53:55 +0100
Message-Id: <20221130145356.1129901-3-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
References: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::25) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|DBBPR08MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: fe167261-f51d-428f-90d6-08dad2e2bf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eMo8f0RJ2lZ/v0gSxOheu+dkmhmTIsjRcQdWipvIFYM6EzQH2sjZDYiL/GXtVgnI2cEr6hEADVEabi1L4sK+fuIOdST3hMGGdW0WLEkpwqOWO/j1NIHFQmL7OKconXgSDbd32i/9fkT5G7NMjZGOe/MPWqxLnigFaad/rXqa33Llb4ZjoBncdh5xITSU++VbixSft6y6ZtTj0qlV9dcE1lK0RWCB3tYKZ1h9UZYBsXb/JJn7ncQVV46Lgq79HugbyQPy4g2KdxQ4C0RJYL6SriBYBTJP9jg2YoACT5937himSLL96dDVjPQ35DENQ03ayCLF1GTbxSJdKG7r/ZsDlA4i7VYWhCIIkQcIEAbrJ1jzSsyRVvKGIML/iMQB0rrbcOIjD4b2XqfpMfhHSCbj6SwaXoJjo9NjD2hyt1KNs8/VL3In9ASkP+139shT1k8elvo2ISHhl44atdll+1biPjtEguHoA5/nXFEKrMYm5PlDkGWLUDMa2ZykwqcMpNOFcB0SY3rOR/wrBrePuGugppETDlvu8IjBLzw/IMjX/SSWmD4mXiCxLSHy69cgYWOUcNFGiNRYpgBN6Y5iRtIx6WhSnkaiZBqN3ock6ZBpyZVe8BZmvjJ94Ai2E6Eylg88GrpOcQzcaEvjswcAXDJnsqrLII5QPNExICuCX5PzXUWbW4mVbhHP535Cxhmkr4s9aIju4yY1bdUjfGOX1oKmG11Q33Fq+ZbF7TSrNkzjnx1z3d5P3vHrX2MWoxvSCkB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(346002)(136003)(396003)(376002)(366004)(451199015)(52116002)(478600001)(66556008)(36756003)(6486002)(26005)(38100700002)(38350700002)(6666004)(6506007)(66476007)(41300700001)(8676002)(66946007)(86362001)(4326008)(316002)(44832011)(54906003)(7416002)(5660300002)(8936002)(6512007)(2616005)(966005)(186003)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGFtNU90VTZqZXFlRk9XbXd5cW1oVklVcUZkSk5OaE9tNytUbDdMdlY1Q0dy?=
 =?utf-8?B?WnpuLzV4c2EwUjk0S3BQcy9ZNzBTb1NmNmRzei82aTVncWhWUlpTNDdaZ2xp?=
 =?utf-8?B?SzZhaDJWd1NOaVNqYnV2czZrRUNwNFVGTDFxUm1vRWtaUTNtTUpzZW9lS2pC?=
 =?utf-8?B?azlrY1RQMzREOTBOT2pKZzRJenB6WlE0dEw1OWtRRXErZllEVFlrVEFKZXRx?=
 =?utf-8?B?OVFNQmpxdWZFdkJHbnNyYUZoSkZma1RRTC8wbnhTL2JpM05KLzczNHJhMGZY?=
 =?utf-8?B?NDlFODlOOTA0M2J6cHExcnYva1hkeS9yT0NaUm5qcWl1YWxCUVE0ZU1GVjdY?=
 =?utf-8?B?QjFraW9NRG45YmN2VXY1dlBGbjVZTHdRSlR2UnBXVUxXdCtwc0tGekt1Y1F4?=
 =?utf-8?B?WThRR0c1dmdQL3FFVk42emQ3NUZvajRMaGpwKytsRUtLZk5sbXh4dW9SdXlM?=
 =?utf-8?B?Mmd4Tk5hUVBtY2hiTWF0U0R0L0ZUaUJuTHp1T05aV01TZ3BKcVBOL2NYN1NF?=
 =?utf-8?B?R2xqdDBHUXIzR1JkZTBNVkxkMWQxN1Nmemg1elR6cXh0czBCV3VFcjlFSTVI?=
 =?utf-8?B?a2hmUHEyUUx3bkxmNTdFSFNQWFB0Y0QzMHNjdW5HQzlJaFZPd3lqMk8rWndX?=
 =?utf-8?B?Q212ZDZOWnJBNktvNzRKRTZWQlgzd3R1amtUZkFuSE9zWkFaMGFVMi9BOFg3?=
 =?utf-8?B?VGdYYWpZUzJnbFpaOVBtYWx3MGVLUmlEbEFNVGQ1OW9RRVJjUzc0RzFENFRm?=
 =?utf-8?B?WXAxL2RqSkF3WDJlbTNHSnVSRHJMM2o4SjAxMkxnVGFuaWtrL09uY013UjUx?=
 =?utf-8?B?VUZBTjZ5UTlsaWo2NjJ3cGNPaHNFaDJJK3JzYWpSZnE0M3lEMlE0b0tIUUM3?=
 =?utf-8?B?OVQ3VjN2aUpPWittendLa0F5TzZTK0cwcUhza3BpOWpBdGtBU0UvWkM4UENX?=
 =?utf-8?B?b216ZTYzMmlxU0wyU2xLU01LMVNOZ0pEZzh1aHNCYXFubDNobVhxMEVMeWdj?=
 =?utf-8?B?SndkZUNFUmlkOUlKTjFLbFdqdEtJQVdjdEdPcWZkVWZyYnpuTjNLSWZ6aWE2?=
 =?utf-8?B?eXByODhrN3YvK2Q2MWd1Zkx3bVdURlZhVHRVNW5hZ0RwcU5QSERZNUNhZnN2?=
 =?utf-8?B?OHZVZkt6cWM2ZW4yVGpGOVFweFFPa3drYURkRURpdnIyNTFFdWMwMmszZWF2?=
 =?utf-8?B?c3hPTnE1dGs0WmtDMGNCR3NCTXBZM29LNmhieG5La1dyRXRlcFVSMFRlaWUy?=
 =?utf-8?B?bVRHMkdkck9HVGRVWmdxMVUvdWF1UCttd2NNVmlySEQrNXd2ZmI1NFE1dTBq?=
 =?utf-8?B?czNWR0djUkJlZEtkNEFwUGdZaGJTbnhrcUozUDcwb3ZSQTZmT04rSkU4dnVi?=
 =?utf-8?B?b1J3ajQ5QzlKaDd1cmJVTHJHdmFpR3VjbVhac0VQMFJqWGR3S2dlOU13UFln?=
 =?utf-8?B?VGdPUnpCbmg3bE4yVHorRHZSbUxIeVQrbWE2N3p5N0VKRGJMTzBwZm80VCs5?=
 =?utf-8?B?YTR2WnhqU3NDTit6LzkvLzVoZW1yVTVCZGpuUDRGRHpaTmRJWkM2YWZJT3RF?=
 =?utf-8?B?WTFCSzVvY1JBTjJtd2VhVTNjZkptakk3bDNpZXlSVkJhRUw0WlFGRDJWSDlh?=
 =?utf-8?B?ODhFMVVkMk1zNHFYbUx2ejJ6VWtFVnFEelJCb0R0UHVBUjVnRTRqeU04RjE5?=
 =?utf-8?B?MGg0TFpqaVVPQ2c2bGxZcDRLZGdFSjgyc0tYTnhIY1JQOHRFR1FiYW83SWVP?=
 =?utf-8?B?YUFMd2dhL0k0Mjd4TEd2NW93ZkpCVUFqOUdjUm9xM2hla2c5azA3a3gvdXQr?=
 =?utf-8?B?dVdMR1pGMTIveUFRN1hvbGY3cEFoV3NnTjNERGpWWUtWUno5cklRWS9SN0xj?=
 =?utf-8?B?SFNMVmdxcC82N2FLWGJEYURnU0paR3MrQjFDTkpqU2NUakozYmJ1MkM1ajVh?=
 =?utf-8?B?Zmxaa0lieC9rQmVtQ0hnbWdvR3BDK3h2V1lrRERsaFM2c3l3ZzU4MDNNZGZr?=
 =?utf-8?B?NXE3SWdCdmdKcUtvSHg0K253VndHYzBscDlmclFJZlUxT3RJOVBUaVI3QkFq?=
 =?utf-8?B?YXFqUms1Qm51YTRBeS9yUGsyOU5VcERaRC8vS0pZTGZ4bUJwbHVWNUVxNFdo?=
 =?utf-8?B?K09LZzNpdFNoMHRkMXJhQkRidlVTR01lQk9rNzZOZHp6NGdBOTZhUmIvM3F0?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fe167261-f51d-428f-90d6-08dad2e2bf62
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:54:14.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2IcgH9aByAKfbf1EcmcjLuFZRAq00mZzQaLecPi/SG7DRKBP5whPk3BDUVR1frttrmVAhBQn7gzL+U4qvTo3DObXPJ9lgIuk+RcMNZDrTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5977
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v5:
 - no changes
 
Changes in v4:
 - no changes
 
Changes in v3:
 - dropped quotes from strings
 
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
index 000000000000..121d540b7b6e
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
+      - off
+      - x-y
+      - y-z
+      - x-z
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

