Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC9A62A1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKOT0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiKOT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:26:48 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D42F387;
        Tue, 15 Nov 2022 11:26:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Isn/lxD2CiImJDT6VWV500NwqdfvzTkCVnYErxQP8LexC9NwJHX+qxyjmVKGlxT3eI/ZzRG7+ywXlGQvZQgsrvN2rP7YhUDo931lfgMSDsdZ/b7Ug6Bixo/r/4d0ww1KppRejvHw2Kr+rc4xdLqpI+cH8hxQm/uDOL8js+MlaSSinoMtnp+1x2CQ/J3lPI9iL0xwGc49kYayvDogqX42uJIS6CTOHH/hidedS/9WqLct6IGBPLXYndbhFYn1JEnB/0vlRQlk+MKQeIxHcsrkN0q7mjJ/NPVHLCJypZpDVertu5dXFbkIxsGr3PTOInqsVORZnucn6G8t6AOT9urqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7Amuk9wvF3fS/mRP6wyth+AfjBF8++xpUIk9D6cvVM=;
 b=XKLyv6JlVy9EUWuSodsCx9/ns5Zz9+Pu320auPL+lNxWDYL31MBHyfMC6ZpF7VrfXhWp12I2qmRngcQD+l3GvyFq3kOmjiAluP3FBdyJZnT4tsNWtZ0s2ZRa8pMla4DLfpKexOtExBdRNn3w9VIFkWKk7qBQllux3M80E417EQCWdywPzwgSpJJdXOrT1QoTvuu10c/yVJEW5qH/DsO/2Rh0LWk42hjsvxn8NLxdn+ck5aawQ+AmVOku5CIWTuCq/EwnRQmszRrRk9CeVavBAedWNHr4Ivk7Nzy7lup2ue4onP5Tb6G8Gp5PkHevFReNqLz4Atg+2ocPYRnSo0WtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7Amuk9wvF3fS/mRP6wyth+AfjBF8++xpUIk9D6cvVM=;
 b=Lui5LWfRn3h8isS47jzRXi/npHCpcDrdyR7I5zIccc42MQCOM+dWR66J6L6INj/HiHYFKFxbOXg0Tmw34vWzk/A4fVgbrAKKtoAQdHzbJgORL0hocI3nZLO7RX5du9OnfHZefTNXRb9A2ZQogrBoWLi/JKWZrUE96pAeYX0bzWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYWPR01MB10539.jpnprd01.prod.outlook.com (2603:1096:400:2fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 19:26:43 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289%6]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 19:26:43 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be,
        alexander.helms.jy@renesas.com
Subject: [PATCH 1/2] dtbindings: clock: Add bindings for Renesas PhiClock
Date:   Tue, 15 Nov 2022 12:26:24 -0700
Message-Id: <20221115192625.9410-2-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
References: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:a03:80::34) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYWPR01MB10539:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e01ab4-6478-49b4-409e-08dac73f544a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CynpzVHYwaYTcVOB+ApP68Dw5NL7h2nLtechfkBUS4SnhpJkE5boSmDX4w0ltE2uJpgJwq85g5+z83vQInNyI2LLO2FnFUOmSwhABh7avvEhmkgP0EXhySHdpgCiYykJn92LYT7F1yZq6pQKqds9AwzCg/tXSmp7ZDlBJGS7fNSOoIR0jJ92iXBURnUPJKOjEmmk+tCe+UE8iPWclPuU5FWJdWBobFepBQtCRfRCQ3Sy0d16MV9/CO24ibZbrcVyk/H4/pT+H+EC1TtB4BDhpPFec9s+lfxX32bU8rIimeSEySOji5fJnd8EEyr6KydMrdxr4LL3SGed3zQsvvHPrn1u/f5Jg6d2k8rf3vJaRDwbGEDrmr5whYptFn9dfaKydoeo9MsgpfsOMimCsAZBC7Bvl21wdyW2pEGvzrIJC63HL8pvOm37lgBh7pPS9UwoUul3ik8y0fflPO1my4Eb9FK9Z3MwXuIhVqtL3KVznjgTB+Ps9N42YKEUw1P1NOLCZKBqtWs4EzSI8le3jUgjssFgAC6VNmMSDzfhuuiaToFfFAZnhAJ/0mXUP6T4KhGM8uHHMuG+q6gk52wQMib76/h+UuGlZgFOGRJ4ev1etkY4aWQdKb7yH/DDC48WHVhd2v9zER1DAYHgzqiN5A2QAq1BFICYXxhHBihvy8fz0hzp5M4/dzPGgBI9crMCF9eXMtndxi/5d8LQlZD4C0T6SMwao8ZM4WIpYoAK/nj6U67cdqsUin8InzKoCYvtwQiMbKd3+RTPJZvFTfKS/fClBd0kMzd/vPlyuiaSdUw8OWPkOOXK/FyDaSrAj2uGuB/AUK5UIyeU52Jah6nGn5XgFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(2906002)(8936002)(8676002)(83380400001)(36756003)(2616005)(66946007)(66556008)(66476007)(41300700001)(86362001)(6506007)(38350700002)(38100700002)(52116002)(186003)(5660300002)(1076003)(4326008)(103116003)(966005)(316002)(26005)(6486002)(107886003)(6512007)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIUDOxf4+uQBVR36RZ/ios7YRzO8m+9ZnIpvWNFHXhz/lgwcpLUlu+R8d8xS?=
 =?us-ascii?Q?3moJl13QchVA8uJdAgOo5TJm0JOeuHGkYOd7V2PY/tN7WKqKXFHD317WNVuE?=
 =?us-ascii?Q?XYejos3j1oqq4axzqUiClAnyiaa2Hd7O03bSczHeOK7SSow/EKYg7ss9+Tn8?=
 =?us-ascii?Q?3AkJiR6G3QY/ZvUNLXHzfP7c5fH1lb375kmL9mkISuBT2LYQiGee03uzqyxw?=
 =?us-ascii?Q?YRXSivrC3frSvdsI4srCpARdPN3JjmmHqZ7PcFtO4kxduwJ5jNZ0fskmOpXz?=
 =?us-ascii?Q?MwFV8WL4le17FdjjfvI2GIQlNP5mcNMqkT1GqaVeRVIUFTTSBtQiJ83rB7aN?=
 =?us-ascii?Q?le5dtCTpmtnrkJrHS9IKN88WE4L7/UC+R9FyEa+ImsTDS3kPpdJ9lU0iJAI7?=
 =?us-ascii?Q?wM1I+0IORxH1JqftObeKUKyhcVxqmizUPaO4MrvKTFuh/wUeaT428K5oXLr9?=
 =?us-ascii?Q?os0dGVlSFNHtgsG3QfeJnGdCQYQXl8SAivq68gdgI26J53fC5exjPHHFDp+2?=
 =?us-ascii?Q?b58JuN3zIc/N/1tBp2c+dGiL4w8DKdGEI11Z/9cFHGpiU49cl+Z239qKI1TA?=
 =?us-ascii?Q?r3mnfc4tbQCSTQwRpmU8cleQMWlMw2v8qd/s4wCHiE3Ymrolcz4/vjJ14VEL?=
 =?us-ascii?Q?MDqAxLJ9kXq9lJ9hglsfjPeqFckBqCth1pPnh295vhfE7ZBjzlYCyGrR6kry?=
 =?us-ascii?Q?cSV5XNnMTAXuxHV3pkUYTGYljxzSXZ2EiGyf7NWEfc5VxQl8s72L4RrYY2Dn?=
 =?us-ascii?Q?dTHe9QF1uyWHkbT5znTmQvB0Bz4E6m4o1p+De9E0kHQbcutqFoiiDq/URkrK?=
 =?us-ascii?Q?C23FWWZBRj/cR3mrcqkkh0B8lsh+T7xN9Ux2pI+bSovX+Pt6ZYs16EMcu+Rt?=
 =?us-ascii?Q?4jB29i+uxiQHNaYSedZ20BvO2GrUQPO363fFqKGix9UVtm0ykfkGKkocYufY?=
 =?us-ascii?Q?8b1thZ1/7McpfiWg/Kh1nkvoMzPXw/y75oyUi7TOBIJGa/cAgUL7zmMQ9juj?=
 =?us-ascii?Q?MHAF3QvY6q0a37QCXxkiWqnsCa4wk2gK8879w3L0jq7umUe5cdWwxIpKk7LV?=
 =?us-ascii?Q?a5hB0C7i0U63t8VGGpS9WCydJxBuOeaysl8nnXzyu9xOvtDPMpUtWFxJCB5O?=
 =?us-ascii?Q?GaFAlArr06L+BAsdt/IXXU4eQ+l4X+cPCt5NAguwNsGV2zVd1Aj86nWxxFlq?=
 =?us-ascii?Q?lQ26aL+6Y61XfzhooslkP0G97fuHAZ9j0TqZlaO7CwndxJNjlik35WGJpzl7?=
 =?us-ascii?Q?yM+5+rFQxovOAUX3qJZKoIsWUmU0ii2CK/UaIJiXsNgJEbBYGF80oK77q2Y3?=
 =?us-ascii?Q?VX5mASm6WZ7BXJ1zagB9zDcedCSpH3SzvaTfi4oPicixVSnDoJSAFG0P7tfV?=
 =?us-ascii?Q?QpUkM3km2fAPzp4FjlsyfQUnUrAExLSD86eOuFw+d0SauKl2uyl74f1fsFHJ?=
 =?us-ascii?Q?GX8l58IhM4Gfpok7b/bND6zjPe/Lhp/iv+2PQWoHVXxXCwRv59hfikIzJokZ?=
 =?us-ascii?Q?2GzpTCKtOQcEUU6UaBVmBqdvHoaa5y/G+oich/gRB9+rvCT4AhUM/x5U9zhc?=
 =?us-ascii?Q?7Xk4uWEcQRlvwf0ngwnpaCeMWPmwtYlshDvoJ/aB3En8z2ZKEtgPVhx3JlmM?=
 =?us-ascii?Q?waRtMY/YzYJoV6Gi7mKXvHU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e01ab4-6478-49b4-409e-08dac73f544a
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:26:43.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ht9LNrhWLQzp72n/jgeAX27X5HhKPL+USQCPoEpTbaMeaJC0Kazzb/xg9F632fhbHNFMU4O/63devwc9K/EX4p0lNrLabfNEhvoq+OPWYM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for the Renesas PhiClock clock generator.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
---
 .../bindings/clock/renesas,phiclock.yaml      | 81 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,phiclock.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
new file mode 100644
index 000000000..2b36534d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,phiclock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas PhiClock Clock Generator Device Tree Bindings
+
+maintainers:
+  - Alex Helms <alexander.helms.jy@renesas.com>
+
+description: |
+  The Renesas PhiClock is a programmable I2C clock generator that provides
+  1 reference output and 2 clock outputs.
+
+  The driver supports spread spectrum but only if all configurations use the
+  same spread spectrum parameters. If your configuration uses spread spectrum,
+  you must include renesas,ss-amount-percent, renesas,ss-modulation-hz, and
+  renesas,ss-direction in the device tree.
+
+properties:
+  '#clock-cells':
+    const: 1
+
+  clock-names:
+    items:
+      - const: xin-clkin
+
+  clocks:
+    const: 1
+
+  compatible:
+    enum:
+      - renesas,9fgv1006
+
+  reg:
+    maxItems: 1
+
+  renesas,ss-amount-percent:
+    description: Spread spectrum absolute amount as hundredths of a percent, e.g. 150 is 1.50%.
+    minimum: 0
+    maximum: 500
+
+  renesas,ss-modulation-hz:
+    description: Spread spectrum modulation rate in Hz
+    minimum: 30000
+    maximum: 63000
+
+  renesas,ss-direction:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Spread spectrum direction
+    enum: [ down, center ]
+
+required:
+  - clock-names
+  - '#clock-cells'
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ref25: ref25m {
+      compatible = "fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <25000000>;
+    };
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      phiclock: clock-controller@68 {
+        compatible = "renesas,9fgv1006";
+        reg = <0x68>;
+        #clock-cells = <1>;
+        clocks = <&ref25>;
+        clock-names = "xin-clkin";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 256f03904..7eabe930b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17641,6 +17641,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
 F:	drivers/clk/clk-versaclock7.c
 
+RENESAS PHICLOCK CLOCK DRIVER
+M:	Alex Helms <alexander.helms.jy@renesas.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
-- 
2.25.1

