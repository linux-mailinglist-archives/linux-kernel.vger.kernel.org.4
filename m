Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA85B9005
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiINVSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiINVSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:18:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57F8307F;
        Wed, 14 Sep 2022 14:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jjpt9iMQZAAR1TcBpwQVqmf+ZCwsckH8PWKJMv7uMPpfjslL6vBtmOJHs9sose6wlHjetz0Kx6KTGJlE6BMJda2a0q/R7TShh6BENw1i/wBRUS3LM1JzJXlCyJGhwd51GIF6pSzxKbSyySf0UiE8K8q0ndTtoMqKxahoYa5NZm82PlTPXFqB8QiFiBy4QtvcTkYQUGUgjSO+yv3pWJBLnjZTPT7pnd6BECntEDYhQ21Utl4h1Ouau+X/HR4E8jzCJb1FnLuiVj0oobW4bN7hT1bDQ/7ZMXUYFUDr2PgwM1ZCsQy/CCTV61mTcD2hdqKGZcdSSFAKLJO+6RvWfTxfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN7+H1v22VxSn5OQBLCJST8pg5Fvbflaw2LyD4G8iBw=;
 b=iRR5UfSCQbJ0t9UH7uJaiDNLpLyBH+Ey7KpvaX67tsgQnSqXgwnr5gLpukc37u6wR2j4jgncSe3wjxOSMGjLU4sGyQ1cv6Jy4I79FoOkyxwIhohHika2BPXrke3xPxOck/i/mARDc2x5YbZlViMzwDIq4ZZKKgeNicLrvVqwx3vwFtMmjKaazz4Nx0Ys/nKpRkbpb7cNiMrkKvMsbySArc5enHGjW0r6mr3fegNAXBGTWv5iHQSyhMq+pWOeO8QDb0hiWXvdEe6b+dFuQiM67dqqyW6eK4vuLNQu1m63OGuVqQfJxcDdd9MLYAomWC7qzf5K9A1+d0qVd4AJNVuGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN7+H1v22VxSn5OQBLCJST8pg5Fvbflaw2LyD4G8iBw=;
 b=l27ma+uL8voDdadukzlDKJgwjGZdtG/d7k+uqEXUUy/afhF6VJ7m2/JSAgfuAJL7NoCx5X0luB8/rqIMrtUb4NMVEM1Nf86IpLdNCzH6GwuJO/pPOZxxtQQhyI1oUQuxOgE2SHP2bPHterICELUs/xunoduKvb/Ksvwul+Xn5XQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYCPR01MB10511.jpnprd01.prod.outlook.com (2603:1096:400:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 21:18:29 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc%3]) with mapi id 15.20.5632.014; Wed, 14 Sep 2022
 21:18:29 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be, alexander.helms.jy@renesas.com
Subject: [PATCH 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Date:   Wed, 14 Sep 2022 14:18:08 -0700
Message-Id: <20220914211809.22500-2-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914211809.22500-1-alexander.helms.jy@renesas.com>
References: <20220914211809.22500-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYCPR01MB10511:EE_
X-MS-Office365-Filtering-Correlation-Id: 958dd3ad-c8dd-406e-9528-08da9696ab9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RILbjuEW6wfcF57+dYYIh6Jo6k2NfxqEgNjIYwUNf8IR5oYt8MNl43U2s0k2hBPJaSWWxD2KOURMdv4Z5luzxh4B/SxqnW7BNac2BFRg/9W0KuHgKou8dIOlG/r4B81Kafk6aPr0IajVMJcpyaN6b2NvWAbO48aEivfAO1CHZ9SxfziC4GJez7t41LGO6eAIro7dm7QU/P+81Ah8lpceXnKnFeJf7mConV/m1QwG7LAWr8YEE2ScApjri1Erfo/lcJN9QFX2ylPeVvIGwSEZzFbw+oU1cfU1uPI1uDjTcNGxcO3RgTlTClzC/17Qn+s1bo8yKL5sNZ1T1PCKDXX06CnBYx12LiGPz/T6IsM+a4gah/UIxGyjXbyjswZu/EU0lBZtc2FOe4y2+z/X+cUk/GqAgnLx1klBGfwhorY0BArja5J1gdaBTH2YTozuI8NrMQnFzHqt8lqEXzAQxrM082h9VmOEneS7UPEvP/o0h8maoYkYLuKej6VxI7o1n4PG8pM4donfW69J6hOEV2zs85dLAWPlZoEIUUqBFDeZomupzF7yBCquPPGdFlcSbtZyVrn/dSbqEXCqLt6VK9glkhwolJPkzmCCDooG/17cOjMmFN4U8xttoGirFxEUxkmJr+wd2HZk9SnhGDJtzArVf85YPn0rwGNdv7JbC25hhk8fDxsIXhZO0d60q6H+cnsm2sy6dzEq73Apu6ByNU5SKry4BN6toj39ctmzjlyt6DqUMyjiv48zZ2tvZY/IW9N9BPbD9tVbiJisFPBFy1bPIkAhGr3jfGCy2HfvGVuIs2PR8v/hyzizQe5VeJvZblcSc4PzI+v0HjdBxIPzPMhVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(1076003)(4326008)(86362001)(6512007)(478600001)(2616005)(66556008)(8676002)(38100700002)(26005)(6506007)(38350700002)(966005)(6486002)(107886003)(5660300002)(52116002)(41300700001)(316002)(103116003)(2906002)(6666004)(66946007)(83380400001)(66476007)(36756003)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/+7MNvif9VbqgJL9k/rsyjl3fn3twsw5HK4mgpywF9leAvpRA6JMmsROlOJ?=
 =?us-ascii?Q?Evv01O9/Jb/+G0MDw+WJyTeQdOlT206D2Ji7KUCsdVHge5Nn/kv1JBQ1IUIL?=
 =?us-ascii?Q?IyRz8FZ1PLHamZV9Wf1FZa6Gd9+X2szdO9a7V/hFNYl68NGGkjdgBBPdPfLz?=
 =?us-ascii?Q?0aTq01kC9rMP8TUnsmr4riVSyxO6ONpDgiTurEBp2smusOAh9nGqaVljbTl0?=
 =?us-ascii?Q?p2A6cOO5+VDweOFwLjA2QWVkeTifNWdVefUfrBvAvy7SstzgTQDmYi4oVaxb?=
 =?us-ascii?Q?IaAUejvg+GS11FX1AKPUnLFBYe2NDbWD1YnmZDrT6EJnLN1E7r5i8wTVkiTy?=
 =?us-ascii?Q?rVm/qEa4Uep7U9M+ksXVfr4rsc1U2jbY2YrAMzf0kRg8TPTJFFYX1kzTwFIb?=
 =?us-ascii?Q?ClwycAqdgtlWC5nJuO8YBiP/KynYq9q9SkdGoO2sR94HTXJzmR/p55XO1C+V?=
 =?us-ascii?Q?M/UKfAfMCDl14BDiWdAFfZcpPOVsUCJNoZNyvz8bcT+48Slq3LiUT6C9eN0L?=
 =?us-ascii?Q?jvNIRzFGXJ5jRG2znlDWVU4Q7POz9qO/CFCIPyzNqw3c8Y+P0hTgMCt51ZR5?=
 =?us-ascii?Q?KmRmn9nAlc60P0hU/bLfdwRXZCaqkXhUgleXEZ1/PxFqF9mXQa2MGwX3kghT?=
 =?us-ascii?Q?aNhhoqw4l7R0+qACwhKNWqGo49k+wUfUJ0zxm+iASoQq/ZZWkajo0zCW093E?=
 =?us-ascii?Q?Na8qKukSa4nO4nGo004y5ZMIPdI+Co/pkDyKpivNP0spNqfHPtYvBLx3UWg5?=
 =?us-ascii?Q?XrNVeI6TtdOooXt1LoS16A8bsUH30hN7bnsO8HKaQGWsjWvZDo1piXVOxEfg?=
 =?us-ascii?Q?owPn4ofdpDt+7KttA9By+e8i124rvUFNgqoBvCKB8rbgIe+cuEMchkvumwAY?=
 =?us-ascii?Q?w5achc9fRAt9nPLkvbtgQzVaA8/Jxj0/iEKz0gQQaBjiuK501Kn4PN8ciqKc?=
 =?us-ascii?Q?z4guplOkX0MJRzEcJT1NM8iCXPqjIcNssCCBnEznO4SNnqNUGHIeR8i72D+o?=
 =?us-ascii?Q?hrV67Z58YdrLR7HlBY9dcDp83QYKa1TDIERVimReqV6ce7O9LCVZa67MUZaq?=
 =?us-ascii?Q?+IDuCtAyIsCcpVkhehA2T4bm5P1ZbRsOxZWhsVm/7BDbelCRIZz1ibV/8EWg?=
 =?us-ascii?Q?1D4HJCDtIUYM7/tJZDRLqyjYyvw5b2QoG0GOQBha2EC8OednEFnp6yE5hCBJ?=
 =?us-ascii?Q?7YMqpXw+zRUJo/nAfHc2TCt7ho+DO3UfVZ9/N/f6ovk6bjs0eD9TVDqSGgOs?=
 =?us-ascii?Q?ArhbCxuom6CI5OgL9G1aazq9fFoXL8BJlucxlGqvK3geZTXN1E5VLr4QtuiU?=
 =?us-ascii?Q?Q1jaCRz7zfYBenUhYv3QrS99D4VdRNVBJ2FmYmaTBFVlg7LPxGeTFLI471uT?=
 =?us-ascii?Q?HmaOhsz1rT0eAyNHiQAJGPrnplCCqPIYlrebs2yBkKGORwP9AGD00Q6VCvwt?=
 =?us-ascii?Q?lrI1iP3uDw0mzp9gdwpuPIJiOdRTjX3kKQUGjwIgLD4hccjPiuA6Z8rM7i7G?=
 =?us-ascii?Q?ULOHIIPyUOk2G1bGMpe5l4kDiSVA4IuXBh3vLxNOhpy+dtygKVD3Lf3A+OUw?=
 =?us-ascii?Q?RubH2hA93ZeIjf48aVi4SQq03YMqt36rZTEfmWaBvHrEMyGRS0XTg6Wuh1k7?=
 =?us-ascii?Q?mlEOQT9Vw7RjirWpgYbQzQc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958dd3ad-c8dd-406e-9528-08da9696ab9b
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 21:18:29.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSH6IH0c3TA5H2zDREEkdLRKDUrTc2sYbGdnpSqnYSGUmM45hRmkLIpmudtEzeLG/mysJpTRQkWwLRfnXDG2HBJowmIkehiWl8GA2mSMvPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for the Renesas ProXO oscillator.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
---
 .../bindings/clock/renesas,proxo.yaml         | 50 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
new file mode 100644
index 000000000..2ae131431
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,versaclock7.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas ProXO Oscillator Device Tree Bindings
+
+maintainers:
+  - Alex Helms <alexander.helms.jy@renesas.com>
+
+description: |
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
+  renesas,xtal:
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
+    i2c@0 {
+      reg = <0x0 0x100>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      proxo: proxo@55 {
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

