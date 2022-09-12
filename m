Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A535B6124
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiILSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiILSip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:38:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47B51839B;
        Mon, 12 Sep 2022 11:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdBf7FSt9bHaPSOL+G9Yf6c5fD5PgSqMiOxqMAdgHHGQUuD19ZYTdPomr6GfnmjHlUoLm8T2OZQToWy52SVk7ZUhg7jjh5G2sJwwgymgEES1dcDsQPbI7eXQHeZCX3lawkipuiFLYYqpid5cOkBfvpI3FVKrsy3I10NXy8ZGbNRLeE+s68DVd2e4SCXF9CXiLLalnkMIHDKEdmEriaPSkWnTAB7cMGkkRwNO0FGanlF7WEgOHRYD5UpCe2NQwwcLgeIdCjtkEY0Hy1Ip8ZwmAOq1UXuw79vlAfxM+ZCJz1UvHSkPM3ZgexNTHFkm5poPNGlZfmhodFXk4znNORfc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXS6erLvOHPdQptitQMCJ/CEbPLT1I0LNqAJ4Gw4koM=;
 b=ksU5Iq0qkOmkcevVdN3G45jFABQoJumheroh7CfEg+mHXKfD3IUoF72C+ONQZZHHLJ12tXZ0nmkkhLJ0GXsS2Qg/gg/gqUTifMHiVYxLYnZECbisX+3ph8fbWy2CgtpObP8IFo7GMPzwRn/ku70rlPwHfXIlNZtKBoGpMIKREPGiUdIZe04NWenYWkVlBS4ZJ5ati8WACHpfJISs+kmGLpYhlsAcIsHhxtxl3bqnAX3Br9n4kkaHYjiDrgJrO0V/deTHcsm48AnjUPxaTdwdgCQOzo/oniCqd99h9Yf92hUCArrXv0jc/uir4bQPcY6iub1WpxBCgvZcIOoMp0rn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXS6erLvOHPdQptitQMCJ/CEbPLT1I0LNqAJ4Gw4koM=;
 b=JUTi/7jip9xcxoWkWKhG6Ys9HYLzlh9EPwyhiH5EC/sV7C1R6aeayyqmMcfYF2v7JWZnlQDL3FDYZ9ghcaBOtkgvBxce8rzIQYHcPwMzKxS9QGg+NxYjCtFJngOsZLY2qKYxLP+eFKo9ijbMomi4Xenn7jlhxG0vFScBk8UgffQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYWPR01MB8379.jpnprd01.prod.outlook.com (2603:1096:400:160::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 18:36:32 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::7097:ae11:b1c0:94a]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::7097:ae11:b1c0:94a%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 18:36:32 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        alexander.helms.jy@renesas.com, michal.simek@xilinx.com,
        saeed.nowshadi@amd.com, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: Renesas versaclock7 device tree bindings
Date:   Mon, 12 Sep 2022 11:36:12 -0700
Message-Id: <20220912183613.22213-2-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912183613.22213-1-alexander.helms.jy@renesas.com>
References: <20220912183613.22213-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYWPR01MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d00641c-416e-41a3-7a39-08da94edb698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRZe1Jr9gJUtl+A2gH50NbDot55Rz1+ICVdPxoj6Er+5JRiETWODmLvGmzXCKypaB6xiGyGwXYXa8u7xCyCw7IXTDfjNPo7jbV3bsPi8wbnVm3FdlYQfAwrXmItRv816dyWmM1fstkL+NDGPa92ntPRlA0SiGC/TWUKy8gDlw1abH990vanMxR9mFdoyICtS93laxAWU9eMaJG83uVVba3l7WbxWhT4xv0tGC9lUTbHv9l5jp6hggoqDGko11QaPsfODMG1J5A+3YzSrA/aU1QaLrjHyAj8t4SYwzvScUuZQduBMbNsCR9D+Zmy2DE8QKRnNVpmUOskPsf1w0Yl2I5+yRcqZswy86MMimNS7X3iiCigxQ5X+hVOVNbKMcqz0QnG+sjpHcE1jjMJOjEROq78ypO7eK2NvA7/yDi5j5itATWhqREexIJzZz7E4Vn8QobulWDOtSahYa00utNdIpkjQtw6/nB3ZTjnGcVNt5gxl77rw1RJBxxirNKhzhBFPqYxL/dey3P700jgYjv955liX1xrz9NnsrFAQ1ogl2omZ34KH0OZCaRklV3qDqeWJb0QuWWbDnx7HXu8kDuBKWN+tO7DNpAMOESqjPLMEmFXiN49WWMbaAdHUM+30DHm+6EuLAwckCWuIoBj0aBR4VWxDzqWIU5mdxem60XxK8ATh6fAOugxa4VbrNCKT0l5HEFxDVO/7jwtWHELfkIRfNSQPm0yQf7xmdkEeZ6uIkMw773H63fhnWqLalV99GkZqaweETx9leBSGgzPie0S5h1adWtf8UIuPvqdTAZJMZaEJ1id3+/imiaeGFyDeTbX+pskOoDr7prU5t5EyjZMbhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(1076003)(6512007)(36756003)(8676002)(38100700002)(52116002)(2906002)(83380400001)(38350700002)(186003)(66476007)(4326008)(66556008)(5660300002)(478600001)(316002)(966005)(8936002)(86362001)(103116003)(6486002)(6506007)(26005)(6666004)(66946007)(41300700001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Are2LsdJULAcvET8IQPCPP+5gt5Hcxix5VXCpLcMlMPdqPRFHtXdz6t6Y0pN?=
 =?us-ascii?Q?SOMkUHUH3WYhtUTTBDDX1FCKT8g5CsWZPS3spua66gtLwxxMbRXuVQ5Xre/E?=
 =?us-ascii?Q?HnPr5PgIev+UwBNcJnW0AqwwSvzAsDwvLBJuUzGyGoxhQYYfbGD4Z17wIMsM?=
 =?us-ascii?Q?r1oINPUiCol2GTN+kYlNRcaL0NgPiiuy1LI+sSAhprTYmMIJLRQ4Iz8omvzk?=
 =?us-ascii?Q?/1sQgIZzWREAbHNQmXxXYprcpvYR0i1QvtpXL4crAUPzLpKiBrltBgpjaS3x?=
 =?us-ascii?Q?+jUmqplwvc8v2x5vZ8bxtMcpdAEWCewMJJolAJC9rZAymxXLmM2WpaKO/fga?=
 =?us-ascii?Q?+U5TwTmJcCQu9Z5Wl/pFsCDmS2pLQR7dSIgNDYa865Ua3ivS0AsWyeTDIyOF?=
 =?us-ascii?Q?Z3TWoy4tQ4L3KU9JbCHMFk59bG/l3JNg3gOn3LXtbAZq2pYhqrzN9HbQb4Fb?=
 =?us-ascii?Q?epYVfnImNKkg+8WxaUm1VAxWzugQGvFkgjBWa0BRJQ4UBN0Ic8fqjsXdEicI?=
 =?us-ascii?Q?Ds3h+r5m2hufsm8uAln3T6pJJVDzU7S25JKxbM4fNYfgaAMdxi5/HoVcwt33?=
 =?us-ascii?Q?hNRW6c6D+zhZac5+65L0clzAlcMVYjKSaXAAnomjGGp0R4YpzOvFr7fNJuX1?=
 =?us-ascii?Q?6oK0QDektHG/pXftGUQUOvS5Jkr5Dv4leD2RJg7Zt6pIXuhD19M+hr0+o5La?=
 =?us-ascii?Q?dMnUYX+p1BApr67zskkOwbiCdIwsS70qRsmHfHDbBOhKrNw8UcGhBxZ+21Iw?=
 =?us-ascii?Q?hj9yn/3O8xfNb37sOPcYXP9gUbVYe8PHlRWiQXq30/yVEH2xFp9jCnNhaVhE?=
 =?us-ascii?Q?3zWJyUWmohxt6ROEC9qtdM+KDPOggLECcE11dIoilDML82lvHvtLAiEREDhI?=
 =?us-ascii?Q?jgXvy3LWNUSo4FVzfDZI+TXjvkdz8ZWYqijn0tklpV33/SO1r16SmwjMnlWz?=
 =?us-ascii?Q?JjFs5wOE7vZD6dmDwBTcLoxkzdC0hx6nnZYxmPPAr/6+rzIYkkahBlv86Yuv?=
 =?us-ascii?Q?MyI+4WxGNO34Yng7y6SpZofYZ9CRLZpKDkUpZi+WzNrIFBefH003+cwJIOCC?=
 =?us-ascii?Q?mVO65btQlg5Y9F7wewp58y/m+s7PFhbsMqP0LPEBJPUtzTxo7rP4cXu029PR?=
 =?us-ascii?Q?A1w0k+HNEVpTFY3lTYhcm7fTMCDznCbgZeqzDzUQCPkymFSm5sOfHsAO4d/T?=
 =?us-ascii?Q?AIYiimK7bUm67Kjcx51WVV7WxPsEPfr+JXFeXmP7mzqDuuZC6fV16INfaLFY?=
 =?us-ascii?Q?g2uPm4BgfVKpTp9lbRDHQ2v2HyE8x++4uS4nLTkGlZ6scDJMBR/cwkm45Nch?=
 =?us-ascii?Q?zDUl/NoFuhb5bEArLTnKhcwkmSTlkBC8CEflm/gnEuFg8eyo/Tut5gu32G5f?=
 =?us-ascii?Q?N1G1+HoWutOzqaVJj7c75kT2YnGKzIoTSmqbrQ+j6c/7pAIhZthPNvPkidMj?=
 =?us-ascii?Q?27doENMFgiQ9pYt1KtzQHwl00Ok0FMvkOMEygqxjhAnkzuhYtH41lVQgbgFL?=
 =?us-ascii?Q?fKL7HTkEh6ChgC4SZsaZRUBtvy5/L++vS7UqZnFaAUGpncGjC+fj0NkJJOd5?=
 =?us-ascii?Q?5kOExeVwRjJ970nPn5IMiYdRiCcR1HOCgJg5tVHHqDAKIR9xWni9KKn8S3Wj?=
 =?us-ascii?Q?RMc30Ue8KsnWEA1ALtYufTc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d00641c-416e-41a3-7a39-08da94edb698
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 18:36:32.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYziZTauKW9gUEsig+MEIqG2czgUOPtENzDrKe1wkOTgGBni3NdW4n7k07at9orYaYbCEfytxg8LyKvQypJbXJul29v83dpfmm+mjb6RUyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas Versaclock7 is a family of configurable clock generator ICs
with fractional and integer dividers. This driver has basic support
for the RC21008A device, a clock synthesizer with a crystal input and
8 outputs. The supports changing the FOD and IOD rates, and each
output can be gated.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/renesas,versaclock7.yaml   | 64 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml b/Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
new file mode 100644
index 000000000..cc099d9e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,versaclock7.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Versaclock7 Programmable Clock Device Tree Bindings
+
+maintainers:
+  - Alex Helms <alexander.helms.jy@renesas.com>
+
+description: |
+  Renesas Versaclock7 is a family of configurable clock generator and
+  jitter attenuator ICs with fractional and integer dividers.
+
+properties:
+  '#clock-cells':
+    const: 1
+
+  compatible:
+    enum:
+      - renesas,rc21008a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: External crystal or oscillator
+
+  clock-names:
+    items:
+      - const: xin
+
+required:
+  - '#clock-cells'
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    vc7_xin: vc7_xin {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <49152000>;
+    };
+
+    i2c@0 {
+        reg = <0x0 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vc7: vc7@9 {
+            compatible = "renesas,rc21008a";
+            reg = <0x9>;
+            #clock-cells = <1>;
+            clocks = <&vc7_xin>;
+            clock-names = "xin";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cd0f68d4a..8a23ea619 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16536,6 +16536,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/renesas-nandc.yaml
 F:	drivers/mtd/nand/raw/renesas-nand-controller.c
 
+RENESAS VERSACLOCK 7 CLOCK DRIVER
+M:	Alex Helms <alexander.helms.jy@renesas.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
-- 
2.30.2

