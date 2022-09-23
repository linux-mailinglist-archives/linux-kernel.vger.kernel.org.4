Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9AA5E8466
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiIWUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiIWUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:53:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2106.outbound.protection.outlook.com [40.107.114.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE4F5967;
        Fri, 23 Sep 2022 13:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkbHZ5UWIeT+ZUa4kmaHrQLtTwnba7ChqVoq7rVRqC5Skv/vXEfSLnF2XtxLxPsdCzSnHD7QLMjk6DhPn5fj1OzRop+BoXdDQaXjEgripKU7z9Ty6q34ep5NMXC4MEukOC7eex8Y2J8fyI1wnA4asXSmOAC4u+3oK4k2lRySz2o2/gmkp2VgZAIGHlx6KGQzf63rPs9hX8swCfwaFyyTI1gnvNQdV6G+J3QAhy1ahrfZfLRz8d/tdVHJooStFWcxyVOLPZeG2TMk/9dcqiVB9V/qPcYFoFQT7MCkRTi91bLJnDK7GjlMfg55gG7lL7r1ximxSbddj+SYY8iYt0ABcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw6R7XGzrDeP1IsEZed0zjqbgd7OkNE1+J2TCBQPs1Q=;
 b=AMG4vMGgwCtUOzgkdNzI7tV74qwr1qixdE4QDkF/AO7QcJsCMKB3nGlr630rcYKhgcOG3/FEakf0gLVJV8ec4kXOgp5QZpg8qb3/RHLeXsxJ6xQrtI3cbebLeanfr9g44Ebt6OaeVVJNiaYW0L9feQqpLdGEQso6peFd83vExQIATbYOPwCvYuZdWCxux7Oprv6AsRpHpt2I6EW6oWr8gTQ2TQuC+h2iTyeyJwNNmU4wxUy6ubgzPMosHKFEuchBqbV9kMhTSRmOijStByOqFZMqsJQxhe0Hzx7OriQxYDHTMRK2OnsivwzxLaeSE9pWqEiKuNdQ/utlBbTMVySZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw6R7XGzrDeP1IsEZed0zjqbgd7OkNE1+J2TCBQPs1Q=;
 b=Z3pB0z9/2Ph6pz52Amaruo4x5yzPdWQ0NtEOFuf5NVN0GyXal1Dbhmkz9uhbvles9lSTtaAS31ndZD+GfQfsdVhiDe++kpmwB8YEtN8JtCH6TSLPC85ue47Waw8XaZFhaxFeaOPQnfoDzKvhkR6zTOS8DNpNkkz9Mv5d3qbsQo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by OSZPR01MB8499.jpnprd01.prod.outlook.com (2603:1096:604:16e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 20:53:09 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 20:53:09 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be, alexander.helms.jy@renesas.com
Subject: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Date:   Fri, 23 Sep 2022 13:52:50 -0700
Message-Id: <20220923205251.1387-2-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|OSZPR01MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e29c92-f4ff-4379-b33a-08da9da59f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlvkNogfYDiVUsYelC4lgWbqNVT1wWh92E8L0gJaqwTsbTSq/6IRwP/j5ez/1zkSXO8ND69dbM0Y6RS6oS6rUhojNGPaXguie9lw2X4PxaLhsyADli/y1uR/9ydCPCl5WcvVx2OT1Ox3DYQJFCYRwdtaa+isy/Vg+oHueqTXHJq4Pjmy3bwS1Bl4or16s6VFNCw/ag2iCw4F0agFtZ19Atghd7IJIMCyfCWiJ4HJq/vwf+P+IfLz+Z8lyYbH+ZI8UKteHPHNirS6/2y37C524VFghsU7VDFm0f39UFwBVal/lBYsqCk7RIxVWqpf7U0Pca5EhpwUxfLIqnvtxpjTIL9Nq6byeOf9sDqiDcb8c3oHN8xgl3NTlMki+Qy8ivPLqBrziUNVFPBarYBR2T2LXeI6U5fphRHZjS4BbgrQHua+2MKoRcyaqc98kOwnw6kEglHc5W2vNKchIBwKJqgkAB7Qfv0neNKw+1vOoSOFLWcu9ff29dTmc36qabjE62BCpS3Zx3QpHmLCiJUQ0Dq6mNJ96ZSFmWSrPjsYg7v0HykbP/0fWHRsYEClODmXSvDNYw+PcIXULnGbaW0MSph5jlF0lYg1Tcc3wCU74y0zsybpPAhSJGautEdRjp7uexMIZ012IRkY4jogVc9drnVB+NTjbRMkKnR0QuKFXLYGIjgB2iRPiUtSAc9D65YLhqc+HFgDd22Y7i92FTDyRiEKWGEgFfbWUjNGXn2ncRLDzg6u95+2v9VvS4TfUK2yVxuKOjQfylhqZuJJAgUSwi6KACxYUYDZD7y6elCkfF/aRuXz/mkhZUB2xWdO5Y6/P++xXztyCLvfvKELAOeJ2TJKGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(6486002)(966005)(6666004)(41300700001)(316002)(478600001)(6506007)(2616005)(8676002)(66556008)(4326008)(66476007)(66946007)(6512007)(107886003)(26005)(8936002)(83380400001)(2906002)(38100700002)(38350700002)(1076003)(5660300002)(186003)(52116002)(86362001)(36756003)(103116003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gP5mV5dpLxBJZamwiJdjlhohXn4eDo2WQkguiO+zfvMexl+Z0PtGOCqinPZZ?=
 =?us-ascii?Q?3mYIguk0cpOTUB/wbl7FubuoXxzgl/ok8q2olzNLyewi7nyL12PmMZYO9yNr?=
 =?us-ascii?Q?m2hMk6Vy1GLTjugT65hw6OQrK8lc6XWoL7rNf5G8NQsoT3wg6QHvMYECQVMR?=
 =?us-ascii?Q?lIbDdPHmV/+hYhtZCrYasr8A9DTBx2w2z3z1bKURTDVzShDGLv2seDOaqf/S?=
 =?us-ascii?Q?EC99KrL4dUCyf8cAyqwjgBod3+3SFTR9EoC1rIuaLOKZBtRblNXQMv6vGQLE?=
 =?us-ascii?Q?+El5SPePQiXEdoKpuK+EcOGdLg8+gYdDFBUmY3BBZH29ddds8GqUuSTQ1Pyd?=
 =?us-ascii?Q?BJ2B+QyNKfrsEtgkcha1we0q2WiAZNC4YO6GfT+uzA7jsAGTvmNT+5cQcWYM?=
 =?us-ascii?Q?da7jHsn0bGfsYgDT88Eixbd6VZZkrucTvDlW75Qr43iBSjlJuflVfRAlprMg?=
 =?us-ascii?Q?6e/tOW9qAZC/yXXzfzWcs9t7GLoXZaEJHLH89M+affa3Qj7vWJ7XOSLdBkv0?=
 =?us-ascii?Q?nR0cCi+yNyfDxS6W+knplAbODhBD/qGI8UcJLyUMCuPcLndYa8tfv1moCkKT?=
 =?us-ascii?Q?3CPZHEWMSbTqPfisr9sg0n9ezXyVRXHpX4seLOJc+NV181/7YMaSj/hPcvSI?=
 =?us-ascii?Q?4NSKqPfZkZ3k8TxxcKCxeWAghc5+mZlrXdrka8nvULbXf7QBUtW9s45A9EWb?=
 =?us-ascii?Q?eCoONUVktLR1CoRlKfDWHWkgGVxhAu3zMn6+Ez+LVJRJPd1d4fb0frHIQ4r0?=
 =?us-ascii?Q?mfowX3UlXy1yjQuKl9daumWCevgJqJf7qrme4/CGRwJidLQxP8OKiGyznWnp?=
 =?us-ascii?Q?kOh2KlpIbwuCkWfiaGIw0coR2tq+paNZk0tHxIdsB/wzZVviy4PU3Hpyu8dN?=
 =?us-ascii?Q?M4Dctmm8Xy+0gNSC1aZAgfNn+4G+Oky43gQu7nYcQor9tkEg+4JPB83wCe54?=
 =?us-ascii?Q?RodtjY5KUdd8WIxKw2htH0KMs9gl2L+GWRJU7HOpj8uM7lktBsR+fcwsAMud?=
 =?us-ascii?Q?tFUBrZk89DrAJDkErbPido6EdRd63DBAiREsOrXXLnUaz0dhpe0kq4J1o8mk?=
 =?us-ascii?Q?e/oE5TJPHS59nJMnLvi3WFiYhKfy+65z653kWihYLbXJt1Xv4SimND2Flyqf?=
 =?us-ascii?Q?yvrK7ydp9XKNb+j5ROwVjwN9hDEl5k9fHis0iIF8aBBSZ/eVpn7ZQjv/xW7x?=
 =?us-ascii?Q?hH0rSLJNJy4S+2hzxedtlaqrd9UlVN7P4GB5VECjplyeib112NxDS/iBJ1+q?=
 =?us-ascii?Q?4ovuc51W4E+fXyxtKte1UNhdgzbQ4/AFrSN4CJLr7V/F+/wWYC3ixLDVbu2+?=
 =?us-ascii?Q?9UZqUuwW3AF5A5hena1KeLWlm6/Y+a71tD57IXORG6/qH/w3QZON91UITUo/?=
 =?us-ascii?Q?B7s/pSH5u99zXAMXAeUFvYX7zfEPCCgSqldnnYeVYuHbTiqCFOlhcggaUdGZ?=
 =?us-ascii?Q?7rdlWJy1d0E36y4gmXsyhN8x/ZXI8A27ldPv4vgj5TWovdJ3/Iu1TUWn9Iq+?=
 =?us-ascii?Q?wdqggfdaniXNQYSuviN6TnWbqfG8OhwV/ADEDGf7LgXgmG5yvMOE435tkuQe?=
 =?us-ascii?Q?FlwzgHjWST9BFfv2sa5YYXM9PtM0BJOaM31A+nQsvLjAgOGlEE9T+PVJTjhX?=
 =?us-ascii?Q?6mPy9VXZd0bV3tdtzbXqXUU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e29c92-f4ff-4379-b33a-08da9da59f07
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 20:53:09.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k85O5jQYM44xR1iy3cIMQmp2ESd8v7uroKRKPFeQOlzYmz8TMetbVnn3Ucp2QAYubpppgxz4MGycJVVCzF9Y5os+HIaPM6A76kOrErMmZcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for the Renesas ProXO oscillator.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
---
 .../bindings/clock/renesas,proxo.yaml         | 49 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
new file mode 100644
index 000000000..79d62f399
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,proxo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas ProXO Oscillator Device Tree Bindings
+
+maintainers:
+  - Alex Helms <alexander.helms.jy@renesas.com>
+
+description:
+  Renesas ProXO is a family of programmable ultra-low phase noise
+  quartz-based oscillators.
+
+properties:
+  '#clock-cells':
+    const: 0
+
+  compatible:
+    enum:
+      - renesas,proxo-xp
+
+  reg:
+    maxItems: 1
+
+  renesas,crystal-frequency:
+    description: Internal crystal frequency, default is 50000000 (50MHz)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - '#clock-cells'
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      proxo: clock-controller@55 {
+        compatible = "renesas,proxo-xp";
+        reg = <0x55>;
+        #clock-cells = <0>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 350102355..d52a8a5d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16080,6 +16080,11 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 F:	drivers/iio/adc/rzg2l_adc.c
 
+RENESAS PROXO CLOCK DRIVER
+M:	Alex Helms <alexander.helms.jy@renesas.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/renesas,proxo.yaml
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
-- 
2.30.2

