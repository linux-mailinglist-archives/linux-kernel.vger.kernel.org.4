Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335CE652D56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiLUHdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiLUHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:33:13 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95416209BE;
        Tue, 20 Dec 2022 23:33:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss7d+6EpA+zQFkddXDyXMfqhd7i37uHhGbErFP/3Da6VrNfbv5GHDAMTZ7G6dnNAAmbB37AEjBN/KZH/tNfeAz/SSnpnOOw0VlfGRYRqP+5VnFnDEpCOpgk/eNI6shY7WxhXEFIzHBxh5W7M9JhLFsjM1GuWyQ94b8z1MbppeFOU2LIqal0cyj71b9qhsqeq00B0agEYzCpkumyz3OLlRGtKph5IWdNsh16p9hVR78ll1UIO8DvlssPMrjI2PGuxhjTLkHE1naqOIZx0BD5L4PJSMZv4zW9YYXl1QmIWPY1Gmp7C/TZVid55w7VEICicHABREO/yvuVaXMz3Sm6kWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isPi1BMHRl17B1oBch2CbSj+FAqbjEd3QPIrj/lL47A=;
 b=gxcvVBYHUaJZ+utsgg0ItiP2w74gnbAjiFHwr02zZccH+R3JRHc6q80SV30AbMMfbXVp/sQFqXWK96TFIvvYyCwvmLdYuc9MXD+c/uG32XWcfYdo3Xw7qocFY3S3oBzd4eOFzWikdO+YGjAP0IqWDm3/qLZmZLdTNsFsyUtW0HZhWUyVMYikT0eMbVn34YAPPiXXKCcp0G58G8J7P5fO+kX9vLulrV0z4XB8LLKz6oTRNqfT78ydfehOzTdtVdEhLDOGrFYl4kayYbx62r1K8+ahNzLtlChSIU0R7MdK+THJck2NCRHFxHrkAvX71xsRldwB2V5/P7GRh8L82psrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isPi1BMHRl17B1oBch2CbSj+FAqbjEd3QPIrj/lL47A=;
 b=qTZsrmiTCSK3jY77r3OC645//CVF8k++LOyk1UsrnD80gL9EcXkes58ajsMhnb7pMmIiHldoi/YIydY+HhmUNxNCh2qSWkgp+Kd3dEJ1NeC3BUPw2ogtcpBHD3Wv2Hz4oPNc6BU2ykY5iR1R/OK+w98RxvAp9WU3kzJnl0Vn9N5o3LKZ8fO7ymVl4oSGESqZeglVqilMjsgDgE+w2fBO0uHhr9Odfgd4RgCj3M7rgJWniFlNhpPi4ZYfuN8XQ4DtZNLAHOMoO4G00fT70YBKKXaF1i/Zw/+O9gHD/ddF8+2YzW6gBdEmF6OloHi4iBrMwlb9Y3c10Wm05oN9tevL/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 07:33:06 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::9028:2d9e:dbd:b5c]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::9028:2d9e:dbd:b5c%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 07:33:06 +0000
From:   Chester Lin <clin@suse.com>
To:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH v3 2/2] pinctrl: add NXP S32 SoC family support
Date:   Wed, 21 Dec 2022 15:32:32 +0800
Message-Id: <20221221073232.21888-3-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221221073232.21888-1-clin@suse.com>
References: <20221221073232.21888-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0189.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::14) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 83029a01-4fd7-4d51-cc01-08dae32599a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yu57AqLzBKF7dar2nOi9cHJfI66tke1BhFDXiZeqrjihvufE0NxNjmQz2VfyAw+tHqF8nOwEr+kO7ewecqVPZ8TnET0/STC7w4xaAmvLnx98AQIw8I3wKAVR9neQNvGgpnY6gqEjLdfJTL+IKBlximeDKx+EmoC7R1LWtnF5FUhYqnLciP3q6zQ6Dxifp0dlW3VpnvhWw5lncJoGU2hIEHsFfGY/EJw5VMPrpBTsYwWaBkBBSFQA9aX05cbyJ89EY7OU0SNXNtd166Q2NG2PCk5rDt3zcKGJ5WvWqOFBRqgnqBkI4bcnskp75Hj4AIk0hp3xAJPMBR67nQlYcRSgWO2Zeho4npxQIxwZl2yvBGWj+70xvq0UAz9qsza59pknXo444w++KPEwseyE5XHiqWl33JS3FYHFVEsjTe85hOEs9nkdswzMbzvbWUuoY2719hjqrVC4dExSd92TOlOVnzCb6CWYlyd2F1s2SMjwGHM2xBh5dsEawAwkGwQ6NwVAoMilnKLAnuqXQylPqkAbpKj7de601h2tNeOCugECNZj0s7Mch4k+sEZS0+lA0Eob9zQGkrm9N6mKYGHajhYLDNSs8m8kBo6fiFf2WUXdVcogahuCBKI3zSF9hMAAJlHukxQ0xKEQF13gXphk6p4lm75RfshEF1Ph3jR5wMtWypQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(38100700002)(36756003)(6666004)(86362001)(316002)(6512007)(54906003)(478600001)(6486002)(26005)(966005)(5660300002)(6506007)(19627235002)(110136005)(30864003)(83380400001)(8676002)(8936002)(7416002)(186003)(2906002)(66556008)(66946007)(1076003)(41300700001)(66476007)(4326008)(2616005)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bd/4TPbRzktrQWfQmvkEDeDQIyXsptU9ZKxqTyFWXLG8Ar7N+kMUKfY5I0WQ?=
 =?us-ascii?Q?cKbc7FCTYQaQ4q4qz0PoTjLDi83gLq+SZzzz+wTY4fxvLPsGq9kFWpKMOXiT?=
 =?us-ascii?Q?+onQDXD3Yw4wyvNuxnf8u8F5cp3cxwmXjl2XJiOLTu1ZqDnkH203lRdwi63j?=
 =?us-ascii?Q?iI9VpCffDeEKvcObaj9Gmy/mvErayBWivVjyI+Df/BInorq2At737tzhYt44?=
 =?us-ascii?Q?rmka9mjWnu/1hu0hcgYWd7rp8TJUefPterOdxuErW7/eeGBvLbExlv/ppwdf?=
 =?us-ascii?Q?OIxgYIeopZyy5v07Xzw59G5NcoxOVzRQe/yfpRKCgI18XJdFaETa+EfOxDeH?=
 =?us-ascii?Q?LjGJ3WUqSKKMiq1seT1YdiVKWswDLS3V+HylzlnKO0+N5THg1nfKAwno4Ccu?=
 =?us-ascii?Q?5UXOuHcQPg3DVGVZG/xhGuq1YXsLS6itG3XTUQMtqWuWvo28jwwtYp3iD/ap?=
 =?us-ascii?Q?3JOk+hmV4YlZurqMXcoWiaoDQPg5pZ4Ahn2ouCl+IMksXgiS70+Lw00ebocI?=
 =?us-ascii?Q?yR+sEwZ58YXf6BGSIoCnZjgaivIHVZPjOHQ4srJnmpqgJTlh4jwIkWOqN8Xr?=
 =?us-ascii?Q?J7/Cxmdczi4qfbmTx19J4ofl1dxYCiiWeH3nuaeyIe4PQXdASzCXcxZhz45J?=
 =?us-ascii?Q?6Aaw+uY37DHYQWeUG7d2e4GEG1K1h/RO+SdYxgEUMwN82Y/BYc7GhXxdhjDU?=
 =?us-ascii?Q?G+j9u1Ab3JAH/NZDsqE2hNBPggJL1+ZwjKDfdA0pVtx9XXpoJMstynRu3Q9F?=
 =?us-ascii?Q?S3yrkpxWkvq04YfzsKR7naQMuj0fRyicWXAXUk92SnMV+yl0x5+5Zx3ccE1D?=
 =?us-ascii?Q?aZD090Xr2jGeR7KXNvrOy0f3OiW2PR9VOQcFZqG6k+vaSqr+QGhFPYNXvpCO?=
 =?us-ascii?Q?X2lHnnpCd+cC4wHgpoush6VLKJQeWd/jBd72y9YFp8kjuqWmPAVNeb+udL2P?=
 =?us-ascii?Q?iRAZXCoI6STEWzFxVvFhWq65gOzyRo/mrawvevESiYh88Au+BOPcEEHujlXi?=
 =?us-ascii?Q?sjDjCUxP/76bWrjTYaXaBdIP8iGt7e9X++1mMG52PLUTx6K9/obi2Fxqco3P?=
 =?us-ascii?Q?MSoKlPLTXSdjzspaU3GWi7Wp5uJ6iAQuASejGJWqK2GgLjuA3f/8E++NuGSe?=
 =?us-ascii?Q?JxS0NS+8sDQNl5e3n5nRfz3MCJj80Fg4ldOXME9EIjYccyiufqsUH1hQxCDT?=
 =?us-ascii?Q?JlScYzWTDtoAF+rZZf6tvYzyRRPGpYznjMpBQc9ei40uYNy/ED6Nr0UmmaRv?=
 =?us-ascii?Q?tYZL9wkBSempRVhwIbJa6eSV85B1QThPrspLCEbSHAS1Re9jb4zsWEKkG3nT?=
 =?us-ascii?Q?cz2tjFTznQlMQQasbVqJC2m6RyvqQv/xTNh96yuQ5yazwA56j/vTCfGUxJhF?=
 =?us-ascii?Q?dYVTrhBjlK3fqpE09Qf5plk7dm+eeSxyjD4bhu9HqaAuDZM9S3h4IjjLZIMj?=
 =?us-ascii?Q?2LIBW7BCQ5wOiO1N65PP+oY6yiubzuIAcMQPPKiUr1n3NuwYT3cwy7MAFv90?=
 =?us-ascii?Q?Z36RXkHbQS7X6VOR83iEYeuODN/XdPl3GQ0F/nZdbnj3MNSA+cRyZ7isqbvt?=
 =?us-ascii?Q?yIpf8KFclowrnkffWQs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83029a01-4fd7-4d51-cc01-08dae32599a7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 07:33:06.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbJYezunQ7hqG5nUvT4FV1DsN+h90HxFyg06J0ixI6EKpvCKDUMkQG740oy1mL6v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pinctrl driver for NXP S32 SoC family. This driver is mainly based
on NXP's downstream implementation on CodeAurora[1].

[1] https://source.codeaurora.org/external/autobsps32/linux/tree/drivers/pinctrl/freescale?h=bsp34.0-5.10.120-rt

Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
Signed-off-by: Chester Lin <clin@suse.com>
---

Changes in v3:
- Rename pinctrl-s32g.c to pinctrl-s32g2.c
- Adjust Kconfig options [menu-invisible] and names [S32G -> S32G2].
- Add .suppress_bind_attrs
- Drop the .remove callback and replace the module_platform_driver() call
  with builtin_platform_driver()

Changes in v2:
- Create a s32_pin_range matrix in the driver for replacing the "nxp,pins"
  property in DT.
- Refine the compatible name to "nxp,s32g2-siul2-pinctrl".
- Fix the copyright requested by NXP.
- Remove a few recipients from the Cc list since these email addresses are no
  longer available.

 drivers/pinctrl/freescale/Kconfig         |  14 +
 drivers/pinctrl/freescale/Makefile        |   2 +
 drivers/pinctrl/freescale/pinctrl-s32.h   |  76 ++
 drivers/pinctrl/freescale/pinctrl-s32cc.c | 983 ++++++++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-s32g2.c | 773 +++++++++++++++++
 5 files changed, 1848 insertions(+)
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32.h
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32cc.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32g2.c

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 7a32f77792d9..111d1529d95c 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -217,3 +217,17 @@ config PINCTRL_IMXRT1170
 	select PINCTRL_IMX
 	help
 	  Say Y here to enable the imxrt1170 pinctrl driver
+
+config PINCTRL_S32CC
+	bool
+	depends on ARCH_S32 && OF
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GENERIC_PINCONF
+
+config PINCTRL_S32G2
+	depends on ARCH_S32 && OF
+	bool "NXP S32G2 pinctrl driver"
+	select PINCTRL_S32CC
+	help
+	  Say Y here to enable the pinctrl driver for NXP S32G2 family SoCs
diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
index 647dff060477..2b26f5af6fc2 100644
--- a/drivers/pinctrl/freescale/Makefile
+++ b/drivers/pinctrl/freescale/Makefile
@@ -33,3 +33,5 @@ obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
 obj-$(CONFIG_PINCTRL_IMX28)	+= pinctrl-imx28.o
 obj-$(CONFIG_PINCTRL_IMXRT1050)	+= pinctrl-imxrt1050.o
 obj-$(CONFIG_PINCTRL_IMXRT1170)	+= pinctrl-imxrt1170.o
+obj-$(CONFIG_PINCTRL_S32CC)	+= pinctrl-s32cc.o
+obj-$(CONFIG_PINCTRL_S32G2)	+= pinctrl-s32g2.o
diff --git a/drivers/pinctrl/freescale/pinctrl-s32.h b/drivers/pinctrl/freescale/pinctrl-s32.h
new file mode 100644
index 000000000000..5481d51686df
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-s32.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * S32 pinmux core definitions
+ *
+ * Copyright 2016-2020, 2022 NXP
+ * Copyright (C) 2022 SUSE LLC
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright (C) 2012 Linaro Ltd.
+ */
+
+#ifndef __DRIVERS_PINCTRL_S32_H
+#define __DRIVERS_PINCTRL_S32_H
+
+struct platform_device;
+
+/**
+ * struct s32_pin_group - describes an S32 pin group
+ * @name: the name of this specific pin group
+ * @npins: the number of pins in this group array, i.e. the number of
+ *         elements in pin_ids and pin_sss so we can iterate over that array
+ * @pin_ids: an array of pin IDs in this group
+ * @pin_sss: an array of source signal select configs paired with pin_ids
+ */
+struct s32_pin_group {
+	const char *name;
+	unsigned int npins;
+	unsigned int *pin_ids;
+	unsigned int *pin_sss;
+};
+
+/**
+ * struct s32_pmx_func - describes S32 pinmux functions
+ * @name: the name of this specific function
+ * @groups: corresponding pin groups
+ * @num_groups: the number of groups
+ */
+struct s32_pmx_func {
+	const char *name;
+	const char **groups;
+	unsigned int num_groups;
+};
+
+/**
+ * struct s32_pin_range - pin ID range for each memory region.
+ * @start: start pin ID
+ * @end: end pin ID
+ */
+struct s32_pin_range {
+	unsigned int start;
+	unsigned int end;
+};
+
+struct s32_pinctrl_soc_info {
+	struct device *dev;
+	const struct pinctrl_pin_desc *pins;
+	unsigned int npins;
+	struct s32_pin_group *groups;
+	unsigned int ngroups;
+	struct s32_pmx_func *functions;
+	unsigned int nfunctions;
+	unsigned int grp_index;
+	const struct s32_pin_range *mem_pin_ranges;
+	unsigned int mem_regions;
+};
+
+#define S32_PINCTRL_PIN(pin)	PINCTRL_PIN(pin, #pin)
+#define S32_PAD_CONFIG(idx)	((idx) * 4)
+#define S32_PIN_RANGE(_start, _end) { .start = _start, .end = _end }
+
+int s32_pinctrl_probe(struct platform_device *pdev,
+			struct s32_pinctrl_soc_info *info);
+#ifdef CONFIG_PM_SLEEP
+int s32_pinctrl_resume(struct device *dev);
+int s32_pinctrl_suspend(struct device *dev);
+#endif
+#endif /* __DRIVERS_PINCTRL_S32_H */
diff --git a/drivers/pinctrl/freescale/pinctrl-s32cc.c b/drivers/pinctrl/freescale/pinctrl-s32cc.c
new file mode 100644
index 000000000000..1ac1afa29993
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-s32cc.c
@@ -0,0 +1,983 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Core driver for the S32 CC (Common Chassis) pin controller
+ *
+ * Copyright 2017-2022 NXP
+ * Copyright (C) 2022 SUSE LLC
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/gpio/driver.h>
+#include <linux/slab.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinctrl-utils.h"
+#include "pinctrl-s32.h"
+
+#define S32CC_PIN_NO_SHIFT	4
+
+#define S32_MSCR_SSS_MASK	GENMASK(2, 0)
+#define S32_MSCR_PUS		BIT(12)
+#define S32_MSCR_PUE		BIT(13)
+#define S32_MSCR_SRE(X)		(((X) & GENMASK(3, 0)) << 14)
+#define S32_MSCR_IBE		BIT(19)
+#define S32_MSCR_ODE		BIT(20)
+#define S32_MSCR_OBE		BIT(21)
+
+static u32 get_pin_no(u32 pinmux)
+{
+	return pinmux >> S32CC_PIN_NO_SHIFT;
+}
+
+static u32 get_pin_func(u32 pinmux)
+{
+	return pinmux & GENMASK(3, 0);
+}
+
+struct s32_pinctrl_mem_region {
+	void __iomem *base;
+	const struct s32_pin_range *pin_range;
+};
+
+/*
+ * Holds pin configuration for GPIO's.
+ * @pin_id: Pin ID for this GPIO
+ * @config: Pin settings
+ * @list: Linked list entry for each gpio pin
+ */
+struct gpio_pin_config {
+	unsigned int pin_id;
+	unsigned int config;
+	struct list_head list;
+};
+
+/*
+ * Pad config save/restore for power suspend/resume.
+ */
+struct s32_pinctrl_context {
+	unsigned long *pads;
+};
+
+/*
+ * @dev: a pointer back to containing device
+ * @pctl: a pointer to the pinctrl device structure
+ * @regions: reserved memory regions with start/end pin
+ * @info: structure containing information about the pin
+ * @gpio_configs: Saved configurations for GPIO pins
+ * @gpiop_configs_lock: lock for the `gpio_configs` list
+ * @s32_pinctrl_context: Configuration saved over system sleep
+ * @reg_lock: lock for the `mscr/imcrs` registers
+ */
+struct s32_pinctrl {
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct s32_pinctrl_mem_region *regions;
+	struct s32_pinctrl_soc_info *info;
+	struct list_head gpio_configs;
+	spinlock_t gpio_configs_lock;
+#ifdef CONFIG_PM_SLEEP
+	struct s32_pinctrl_context saved_context;
+#endif
+	spinlock_t reg_lock;
+};
+
+static struct s32_pinctrl_mem_region *
+s32_get_region(struct pinctrl_dev *pctldev, unsigned int pin)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pin_range *pin_range;
+	unsigned int mem_regions = ipctl->info->mem_regions;
+	unsigned int i;
+
+	for (i = 0; i < mem_regions; ++i) {
+		pin_range = ipctl->regions[i].pin_range;
+		if (pin >= pin_range->start && pin <= pin_range->end)
+			return &ipctl->regions[i];
+	}
+
+	return NULL;
+}
+
+static inline int s32_check_pin(struct pinctrl_dev *pctldev,
+				unsigned int pin)
+{
+	return s32_get_region(pctldev, pin) ? 0 : -EINVAL;
+}
+
+static inline int s32_pinctrl_readl_nolock(struct pinctrl_dev *pctldev,
+					   unsigned int pin,
+					   unsigned long *config)
+{
+	struct s32_pinctrl_mem_region *region;
+	unsigned int offset;
+
+	region = s32_get_region(pctldev, pin);
+	if (!region)
+		return -EINVAL;
+
+	offset = pin - region->pin_range->start;
+
+	*config = readl(region->base + S32_PAD_CONFIG(offset));
+
+	return 0;
+}
+
+static inline int s32_pinctrl_readl(struct pinctrl_dev *pctldev,
+				    unsigned int pin,
+				    unsigned long *config)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&ipctl->reg_lock, flags);
+	ret = s32_pinctrl_readl_nolock(pctldev, pin, config);
+	spin_unlock_irqrestore(&ipctl->reg_lock, flags);
+
+	return ret;
+}
+
+static inline int s32_pinctrl_writel_nolock(struct pinctrl_dev *pctldev,
+					    unsigned int pin,
+					    unsigned long config)
+{
+	struct s32_pinctrl_mem_region *region;
+	unsigned int offset;
+
+	region = s32_get_region(pctldev, pin);
+	if (!region)
+		return -EINVAL;
+
+	offset = pin - region->pin_range->start;
+
+	writel(config, region->base + S32_PAD_CONFIG(offset));
+
+	return 0;
+
+}
+
+static inline int s32_pinctrl_writel(unsigned long config,
+				     struct pinctrl_dev *pctldev,
+				     unsigned int pin)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&ipctl->reg_lock, flags);
+	ret = s32_pinctrl_writel_nolock(pctldev, pin, config);
+	spin_unlock_irqrestore(&ipctl->reg_lock, flags);
+
+	return ret;
+}
+
+static int s32_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+
+	return info->ngroups;
+}
+
+static const char *s32_get_group_name(struct pinctrl_dev *pctldev,
+				      unsigned int selector)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+
+	return info->groups[selector].name;
+}
+
+static int s32_get_group_pins(struct pinctrl_dev *pctldev,
+			      unsigned int selector, const unsigned int **pins,
+			      unsigned int *npins)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+
+	*pins = info->groups[selector].pin_ids;
+	*npins = info->groups[selector].npins;
+
+	return 0;
+}
+
+static void s32_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+			     unsigned int offset)
+{
+	seq_printf(s, "%s", dev_name(pctldev->dev));
+}
+
+static int s32_dt_group_node_to_map(struct pinctrl_dev *pctldev,
+				    struct device_node *np,
+				    struct pinctrl_map **map,
+				    unsigned int *reserved_maps,
+				    unsigned int *num_maps,
+				    const char *func_name)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	struct device *dev = ipctl->dev;
+	unsigned long *cfgs = NULL;
+	unsigned int n_cfgs, reserve = 1;
+	int n_pins, ret;
+
+	n_pins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
+	if (n_pins < 0) {
+		dev_warn(dev, "Unable to find 'pinmux' property in node %s.\n",
+			np->name);
+	} else if (!n_pins) {
+		return -EINVAL;
+	}
+
+	ret = pinconf_generic_parse_dt_config(np, pctldev, &cfgs, &n_cfgs);
+	if (ret) {
+		dev_err(dev, "%pOF: could not parse node property\n", np);
+		return ret;
+	}
+
+	if (n_cfgs)
+		reserve++;
+
+	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps, num_maps,
+					reserve);
+	if (ret < 0)
+		goto free_cfgs;
+
+	ret = pinctrl_utils_add_map_mux(pctldev, map, reserved_maps, num_maps,
+					np->name, func_name);
+	if (ret < 0)
+		goto free_cfgs;
+
+	if (n_cfgs) {
+		ret = pinctrl_utils_add_map_configs(pctldev, map, reserved_maps,
+						    num_maps, np->name, cfgs, n_cfgs,
+						    PIN_MAP_TYPE_CONFIGS_GROUP);
+		if (ret < 0)
+			goto free_cfgs;
+	}
+
+free_cfgs:
+	kfree(cfgs);
+	return ret;
+}
+
+static int s32_dt_node_to_map(struct pinctrl_dev *pctldev,
+			      struct device_node *np_config,
+			      struct pinctrl_map **map,
+			      unsigned int *num_maps)
+{
+	unsigned int reserved_maps;
+	struct device_node *np;
+	int ret = 0;
+
+	reserved_maps = 0;
+	*map = NULL;
+	*num_maps = 0;
+
+	for_each_available_child_of_node(np_config, np) {
+		ret = s32_dt_group_node_to_map(pctldev, np, map,
+					       &reserved_maps, num_maps,
+					       np_config->name);
+		if (ret < 0)
+			break;
+	}
+
+	if (ret)
+		pinctrl_utils_free_map(pctldev, *map, *num_maps);
+
+	return ret;
+
+}
+
+static const struct pinctrl_ops s32_pctrl_ops = {
+	.get_groups_count = s32_get_groups_count,
+	.get_group_name = s32_get_group_name,
+	.get_group_pins = s32_get_group_pins,
+	.pin_dbg_show = s32_pin_dbg_show,
+	.dt_node_to_map = s32_dt_node_to_map,
+	.dt_free_map = pinctrl_utils_free_map,
+};
+
+static int s32_update_pin_mscr(struct pinctrl_dev *pctldev, unsigned int pin,
+			       unsigned long mask, unsigned long new_mask)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long config, flags;
+	int ret;
+
+	spin_lock_irqsave(&ipctl->reg_lock, flags);
+
+	ret = s32_pinctrl_readl_nolock(pctldev, pin, &config);
+	if (ret)
+		goto unlock;
+
+	config &= ~mask;
+	config |= new_mask;
+
+	ret = s32_pinctrl_writel_nolock(pctldev, pin, config);
+	if (ret)
+		goto unlock;
+
+unlock:
+	spin_unlock_irqrestore(&ipctl->reg_lock, flags);
+
+	return ret;
+}
+
+static int s32_pmx_set(struct pinctrl_dev *pctldev, unsigned int selector,
+		       unsigned int group)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+	int i, ret;
+	struct s32_pin_group *grp;
+
+	/*
+	 * Configure the mux mode for each pin in the group for a specific
+	 * function.
+	 */
+	grp = &info->groups[group];
+
+	dev_dbg(ipctl->dev, "set mux for function %s group %s\n",
+		info->functions[selector].name, grp->name);
+
+	/* Check beforehand so we don't have a partial config. */
+	for (i = 0; i < grp->npins; ++i) {
+		if (s32_check_pin(pctldev, grp->pin_ids[i]) != 0) {
+			dev_err(info->dev, "invalid pin: %d in group: %d\n",
+				grp->pin_ids[i], group);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0, ret = 0; i < grp->npins && !ret; ++i) {
+		ret = s32_update_pin_mscr(pctldev, grp->pin_ids[i],
+					  S32_MSCR_SSS_MASK, grp->pin_sss[i]);
+	}
+
+	return ret;
+}
+
+static int s32_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+
+	return info->nfunctions;
+}
+
+static const char *s32_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+
+	return info->functions[selector].name;
+}
+
+static int s32_pmx_get_groups(struct pinctrl_dev *pctldev,
+			      unsigned int selector,
+			      const char * const **groups,
+			      unsigned int * const num_groups)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+
+	*groups = info->functions[selector].groups;
+	*num_groups = info->functions[selector].num_groups;
+
+	return 0;
+}
+
+static int s32_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
+				       struct pinctrl_gpio_range *range,
+				       unsigned int offset)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long config;
+	struct gpio_pin_config *gpio_pin;
+	unsigned long flags;
+	int ret;
+
+	ret = s32_pinctrl_readl(pctldev, offset, &config);
+	if (ret != 0)
+		return -EINVAL;
+
+	/* Save current configuration */
+	gpio_pin = kmalloc(sizeof(*gpio_pin), GFP_KERNEL);
+	if (!gpio_pin)
+		return -ENOMEM;
+
+	gpio_pin->pin_id = offset;
+	gpio_pin->config = config;
+
+	spin_lock_irqsave(&ipctl->gpio_configs_lock, flags);
+	list_add(&(gpio_pin->list), &(ipctl->gpio_configs));
+	spin_unlock_irqrestore(&ipctl->gpio_configs_lock, flags);
+
+	/* GPIO pin means SSS = 0 */
+	config &= ~S32_MSCR_SSS_MASK;
+
+	return s32_pinctrl_writel(config, pctldev, offset);
+}
+
+static void s32_pmx_gpio_disable_free(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range,
+				      unsigned int offset)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	struct list_head *pos, *tmp;
+	struct gpio_pin_config *gpio_pin;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&ipctl->gpio_configs_lock, flags);
+
+	list_for_each_safe(pos, tmp, &ipctl->gpio_configs) {
+		gpio_pin = list_entry(pos, struct gpio_pin_config, list);
+
+		if (gpio_pin->pin_id == offset) {
+			ret = s32_pinctrl_writel(gpio_pin->config, pctldev,
+						 gpio_pin->pin_id);
+			if (ret != 0)
+				goto unlock;
+
+			list_del(pos);
+			kfree(gpio_pin);
+			break;
+		}
+	}
+
+unlock:
+	spin_unlock_irqrestore(&ipctl->gpio_configs_lock, flags);
+}
+
+static int s32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range,
+				      unsigned int offset,
+				      bool input)
+{
+	unsigned long config;
+	int ret;
+
+	ret = s32_pinctrl_readl(pctldev, offset, &config);
+	if (ret != 0)
+		return -EINVAL;
+
+	if (input) {
+		/* Disable output buffer and enable input buffer */
+		config &= ~S32_MSCR_OBE;
+		config |= S32_MSCR_IBE;
+	} else {
+		/* Disable input buffer and enable output buffer */
+		config &= ~S32_MSCR_IBE;
+		config |= S32_MSCR_OBE;
+	}
+
+	return s32_pinctrl_writel(config, pctldev, offset);
+}
+
+static const struct pinmux_ops s32_pmx_ops = {
+	.get_functions_count = s32_pmx_get_funcs_count,
+	.get_function_name = s32_pmx_get_func_name,
+	.get_function_groups = s32_pmx_get_groups,
+	.set_mux = s32_pmx_set,
+	.gpio_request_enable = s32_pmx_gpio_request_enable,
+	.gpio_disable_free = s32_pmx_gpio_disable_free,
+	.gpio_set_direction = s32_pmx_gpio_set_direction,
+};
+
+static int s32_pinconf_get(struct pinctrl_dev *pctldev,
+			   unsigned int pin_id,
+			   unsigned long *config)
+{
+	int ret = s32_pinctrl_readl(pctldev, pin_id, config);
+
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int s32_get_pin_conf(enum pin_config_param param, u32 arg,
+			    unsigned long *mask, unsigned long *config)
+{
+	switch (param) {
+	/* All pins are persistent over suspend */
+	case PIN_CONFIG_PERSIST_STATE:
+		return 0;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		*config |= S32_MSCR_ODE;
+		*mask |= S32_MSCR_ODE;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		if (arg)
+			*config |= S32_MSCR_OBE;
+		else
+			*config &= ~S32_MSCR_OBE;
+		*mask |= S32_MSCR_OBE;
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		if (arg)
+			*config |= S32_MSCR_IBE;
+		else
+			*config &= ~S32_MSCR_IBE;
+		*mask |= S32_MSCR_IBE;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		*config |= S32_MSCR_SRE(arg);
+		*mask |= S32_MSCR_SRE(~0);
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if (arg)
+			*config |= S32_MSCR_PUS;
+		else
+			*config &= ~S32_MSCR_PUS;
+		fallthrough;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (arg)
+			*config |= S32_MSCR_PUE;
+		else
+			*config &= ~S32_MSCR_PUE;
+		*mask |= S32_MSCR_PUE | S32_MSCR_PUS;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
+		*mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
+		fallthrough;
+	case PIN_CONFIG_BIAS_DISABLE:
+		*config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
+		*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int s32_pinconf_mscr_modify_write(struct pinctrl_dev *pctldev,
+				       unsigned int pin_id,
+				       unsigned long *configs,
+				       unsigned int num_configs, bool write)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long config = 0, mask = 0;
+	int i, ret;
+
+	if (s32_check_pin(pctldev, pin_id) != 0)
+		return -EINVAL;
+
+	dev_dbg(ipctl->dev, "pinconf set pin %s with %d configs\n",
+		pin_get_name(pctldev, pin_id), num_configs);
+
+	for (i = 0; i < num_configs; i++) {
+		ret = s32_get_pin_conf(pinconf_to_config_param(configs[i]),
+				       pinconf_to_config_argument(configs[i]),
+				       &mask, &config);
+		if (ret)
+			return ret;
+	}
+
+	/* If the MSCR configuration has to be written,
+	 * the SSS field should not be touched.
+	 */
+	if (write)
+		mask = ~S32_MSCR_SSS_MASK;
+
+	if (!config && !mask)
+		return 0;
+
+	ret = s32_update_pin_mscr(pctldev, pin_id, mask, config);
+
+	dev_dbg(ipctl->dev, "%s: pin %d cfg 0x%lx\n",
+		write ? "set" : "update", pin_id, config);
+
+	return ret;
+}
+
+static int s32_pinconf_mscr_write(struct pinctrl_dev *pctldev,
+			   unsigned int pin_id, unsigned long *configs,
+			   unsigned int num_configs)
+{
+	return s32_pinconf_mscr_modify_write(pctldev, pin_id, configs,
+					     num_configs, true);
+}
+
+static int s32_pinconf_mscr_modify(struct pinctrl_dev *pctldev,
+			   unsigned int pin_id, unsigned long *configs,
+			   unsigned int num_configs)
+{
+	return s32_pinconf_mscr_modify_write(pctldev, pin_id, configs,
+					     num_configs, false);
+}
+
+static int s32_pinconf_set(struct pinctrl_dev *pctldev,
+			   unsigned int pin_id, unsigned long *configs,
+			   unsigned int num_configs)
+{
+	return s32_pinconf_mscr_modify(pctldev, pin_id, configs, num_configs);
+}
+
+static int s32_pconf_group_set(struct pinctrl_dev *pctldev, unsigned int selector,
+			       unsigned long *configs, unsigned int num_configs)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+	struct s32_pin_group *grp;
+	int i, ret;
+
+	grp = &info->groups[selector];
+	for (i = 0; i < grp->npins; i++) {
+		ret = s32_pinconf_mscr_write(pctldev, grp->pin_ids[i],
+					     configs, num_configs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void s32_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+				 struct seq_file *s, unsigned int pin_id)
+{
+	unsigned long config;
+	int ret = s32_pinctrl_readl(pctldev, pin_id, &config);
+
+	if (!ret)
+		seq_printf(s, "0x%lx", config);
+}
+
+static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
+				       struct seq_file *s, unsigned int selector)
+{
+	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+	struct s32_pin_group *grp;
+	unsigned long config;
+	const char *name;
+	int i, ret;
+
+	seq_puts(s, "\n");
+	grp = &info->groups[selector];
+	for (i = 0; i < grp->npins; i++) {
+		name = pin_get_name(pctldev, grp->pin_ids[i]);
+		ret = s32_pinconf_get(pctldev, grp->pin_ids[i], &config);
+		if (ret)
+			return;
+		seq_printf(s, "%s: 0x%lx\n", name, config);
+	}
+}
+
+static const struct pinconf_ops s32_pinconf_ops = {
+	.pin_config_get = s32_pinconf_get,
+	.pin_config_set	= s32_pinconf_set,
+	.pin_config_group_set = s32_pconf_group_set,
+	.pin_config_dbg_show = s32_pinconf_dbg_show,
+	.pin_config_group_dbg_show = s32_pinconf_group_dbg_show,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static bool s32_pinctrl_should_save(struct s32_pinctrl *ipctl,
+				    unsigned int pin)
+{
+	const struct pin_desc *pd = pin_desc_get(ipctl->pctl, pin);
+
+	if (!pd)
+		return false;
+
+	/*
+	 * Only restore the pin if it is actually in use by the kernel (or
+	 * by userspace).
+	 */
+	if (pd->mux_owner || pd->gpio_owner)
+		return true;
+
+	return false;
+}
+
+int s32_pinctrl_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s32_pinctrl *ipctl = platform_get_drvdata(pdev);
+	const struct pinctrl_pin_desc *pin;
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+	struct s32_pinctrl_context *saved_context = &ipctl->saved_context;
+	int i;
+	int ret;
+	unsigned long config;
+
+	for (i = 0; i < info->npins; i++) {
+		pin = &info->pins[i];
+
+		if (!s32_pinctrl_should_save(ipctl, pin->number))
+			continue;
+
+		ret = s32_pinctrl_readl(ipctl->pctl, pin->number, &config);
+		if (ret)
+			return -EINVAL;
+
+		saved_context->pads[i] = config;
+	}
+
+	return 0;
+}
+
+int s32_pinctrl_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s32_pinctrl *ipctl = platform_get_drvdata(pdev);
+	const struct s32_pinctrl_soc_info *info = ipctl->info;
+	const struct pinctrl_pin_desc *pin;
+	struct s32_pinctrl_context *saved_context = &ipctl->saved_context;
+	int ret, i;
+
+	for (i = 0; i < info->npins; i++) {
+		pin = &info->pins[i];
+
+		if (!s32_pinctrl_should_save(ipctl, pin->number))
+			continue;
+
+		ret = s32_pinctrl_writel(saved_context->pads[i],
+					 ipctl->pctl, pin->number);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static void s32_pinctrl_parse_groups(struct device_node *np,
+				     struct s32_pin_group *grp,
+				     struct s32_pinctrl_soc_info *info)
+{
+	const __be32 *p;
+	struct device *dev;
+	struct property *prop;
+	int i, npins;
+	u32 pinmux;
+
+	dev = info->dev;
+
+	dev_dbg(dev, "group: %s\n", np->name);
+
+	/* Initialise group */
+	grp->name = np->name;
+
+	npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
+
+	if (npins < 0) {
+		dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
+			np->name);
+		return;
+	}
+	if (!npins) {
+		dev_err(dev, "The group %s has no pins.\n", np->name);
+		return;
+	}
+
+	grp->npins = npins;
+
+	grp->pin_ids = devm_kcalloc(info->dev, grp->npins,
+				    sizeof(unsigned int), GFP_KERNEL);
+	grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
+				    sizeof(unsigned int), GFP_KERNEL);
+
+	if (!grp->pin_ids || !grp->pin_sss) {
+		dev_err(dev, "Failed to allocate memory for the group %s.\n",
+			np->name);
+		return;
+	}
+
+	i = 0;
+	of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
+		grp->pin_ids[i] = get_pin_no(pinmux);
+		grp->pin_sss[i] = get_pin_func(pinmux);
+
+		dev_dbg(info->dev, "pin-id: 0x%x, sss: 0x%x",
+			grp->pin_ids[i], grp->pin_sss[i]);
+		i++;
+	}
+}
+
+static void s32_pinctrl_parse_functions(struct device_node *np,
+					struct s32_pinctrl_soc_info *info,
+					u32 index)
+{
+	struct device_node *child;
+	struct s32_pmx_func *func;
+	struct s32_pin_group *grp;
+	u32 i = 0;
+
+	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
+
+	func = &info->functions[index];
+
+	/* Initialise function */
+	func->name = np->name;
+	func->num_groups = of_get_child_count(np);
+	if (func->num_groups == 0) {
+		dev_err(info->dev, "no groups defined in %s\n", np->full_name);
+		return;
+	}
+	func->groups = devm_kzalloc(info->dev,
+			func->num_groups * sizeof(char *), GFP_KERNEL);
+
+	for_each_child_of_node(np, child) {
+		func->groups[i] = child->name;
+		grp = &info->groups[info->grp_index++];
+		s32_pinctrl_parse_groups(child, grp, info);
+		i++;
+	}
+}
+
+static int s32_pinctrl_probe_dt(struct platform_device *pdev,
+				struct s32_pinctrl *ipctl)
+{
+	struct s32_pinctrl_soc_info *info = ipctl->info;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	struct resource *res;
+	int mem_regions = info->mem_regions;
+	u32 nfuncs = 0;
+	u32 i = 0;
+
+	if (!np)
+		return -ENODEV;
+
+	if (mem_regions == 0) {
+		dev_err(&pdev->dev, "mem_regions is 0\n");
+		return -EINVAL;
+	}
+
+	ipctl->regions = devm_kzalloc(&pdev->dev,
+				      mem_regions * sizeof(*(ipctl->regions)),
+				      GFP_KERNEL);
+	if (!ipctl->regions)
+		return -ENOMEM;
+
+	for (i = 0; i < mem_regions; ++i) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res) {
+			dev_err(&pdev->dev, "reg index:%u not found\n", i);
+			return -EINVAL;
+		}
+
+		ipctl->regions[i].base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(ipctl->regions[i].base))
+			return PTR_ERR(ipctl->regions[i].base);
+
+		ipctl->regions[i].pin_range = &info->mem_pin_ranges[i];
+	}
+
+	nfuncs = of_get_child_count(np);
+	if (nfuncs <= 0) {
+		dev_err(&pdev->dev, "no functions defined\n");
+		return -EINVAL;
+	}
+
+	info->nfunctions = nfuncs;
+	info->functions = devm_kzalloc(&pdev->dev,
+				       nfuncs * sizeof(struct s32_pmx_func),
+				       GFP_KERNEL);
+	if (!info->functions)
+		return -ENOMEM;
+
+	info->ngroups = 0;
+	for_each_child_of_node(np, child)
+		info->ngroups += of_get_child_count(child);
+	info->groups = devm_kzalloc(&pdev->dev,
+				    info->ngroups * sizeof(struct s32_pin_group),
+				    GFP_KERNEL);
+	if (!info->groups)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_child_of_node(np, child)
+		s32_pinctrl_parse_functions(child, info, i++);
+
+	return 0;
+}
+
+int s32_pinctrl_probe(struct platform_device *pdev,
+		      struct s32_pinctrl_soc_info *info)
+{
+	struct s32_pinctrl *ipctl;
+	int ret;
+	struct pinctrl_desc *s32_pinctrl_desc;
+#ifdef CONFIG_PM_SLEEP
+	struct s32_pinctrl_context *saved_context;
+#endif
+
+	if (!info || !info->pins || !info->npins) {
+		dev_err(&pdev->dev, "wrong pinctrl info\n");
+		return -EINVAL;
+	}
+
+	info->dev = &pdev->dev;
+
+	/* Create state holders etc for this driver */
+	ipctl = devm_kzalloc(&pdev->dev, sizeof(*ipctl), GFP_KERNEL);
+	if (!ipctl)
+		return -ENOMEM;
+
+	ipctl->info = info;
+	ipctl->dev = info->dev;
+	platform_set_drvdata(pdev, ipctl);
+
+	INIT_LIST_HEAD(&ipctl->gpio_configs);
+	spin_lock_init(&ipctl->gpio_configs_lock);
+	spin_lock_init(&ipctl->reg_lock);
+
+	s32_pinctrl_desc =
+		devm_kmalloc(&pdev->dev, sizeof(*s32_pinctrl_desc), GFP_KERNEL);
+	if (!s32_pinctrl_desc)
+		return -ENOMEM;
+
+	s32_pinctrl_desc->name = dev_name(&pdev->dev);
+	s32_pinctrl_desc->pins = info->pins;
+	s32_pinctrl_desc->npins = info->npins;
+	s32_pinctrl_desc->pctlops = &s32_pctrl_ops;
+	s32_pinctrl_desc->pmxops = &s32_pmx_ops;
+	s32_pinctrl_desc->confops = &s32_pinconf_ops;
+	s32_pinctrl_desc->owner = THIS_MODULE;
+
+	ret = s32_pinctrl_probe_dt(pdev, ipctl);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to probe dt properties\n");
+		return ret;
+	}
+
+	ipctl->pctl = devm_pinctrl_register(&pdev->dev, s32_pinctrl_desc,
+					    ipctl);
+
+	if (IS_ERR(ipctl->pctl)) {
+		dev_err(&pdev->dev, "could not register s32 pinctrl driver\n");
+		return PTR_ERR(ipctl->pctl);
+	}
+
+#ifdef CONFIG_PM_SLEEP
+	saved_context = &ipctl->saved_context;
+	saved_context->pads =
+		devm_kcalloc(&pdev->dev, info->npins,
+			     sizeof(*saved_context->pads),
+			     GFP_KERNEL);
+	if (!saved_context->pads)
+		return -ENOMEM;
+#endif
+
+	dev_info(&pdev->dev, "initialized s32 pinctrl driver\n");
+
+	return 0;
+}
diff --git a/drivers/pinctrl/freescale/pinctrl-s32g2.c b/drivers/pinctrl/freescale/pinctrl-s32g2.c
new file mode 100644
index 000000000000..7dd0b4f8904d
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-s32g2.c
@@ -0,0 +1,773 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NXP S32G pinctrl driver
+ *
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018, 2020-2022 NXP
+ * Copyright (C) 2022 SUSE LLC
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-s32.h"
+
+enum s32_pins {
+	S32G_MSCR_PA_00 =  0,
+	S32G_MSCR_PA_01 =  1,
+	S32G_MSCR_PA_02 =  2,
+	S32G_MSCR_PA_03 =  3,
+	S32G_MSCR_PA_04 =  4,
+	S32G_MSCR_PA_05 =  5,
+	S32G_MSCR_PA_06 =  6,
+	S32G_MSCR_PA_07 =  7,
+	S32G_MSCR_PA_08 =  8,
+	S32G_MSCR_PA_09 =  9,
+	S32G_MSCR_PA_10 =  10,
+	S32G_MSCR_PA_11 =  11,
+	S32G_MSCR_PA_12 =  12,
+	S32G_MSCR_PA_13 =  13,
+	S32G_MSCR_PA_14 =  14,
+	S32G_MSCR_PA_15 =  15,
+	S32G_MSCR_PB_00 =  16,
+	S32G_MSCR_PB_01 =  17,
+	S32G_MSCR_PB_02 =  18,
+	S32G_MSCR_PB_03 =  19,
+	S32G_MSCR_PB_04 =  20,
+	S32G_MSCR_PB_05 =  21,
+	S32G_MSCR_PB_06 =  22,
+	S32G_MSCR_PB_07 =  23,
+	S32G_MSCR_PB_08 =  24,
+	S32G_MSCR_PB_09 =  25,
+	S32G_MSCR_PB_10 =  26,
+	S32G_MSCR_PB_11 =  27,
+	S32G_MSCR_PB_12 =  28,
+	S32G_MSCR_PB_13 =  29,
+	S32G_MSCR_PB_14 =  30,
+	S32G_MSCR_PB_15 =  31,
+	S32G_MSCR_PC_00 =  32,
+	S32G_MSCR_PC_01 =  33,
+	S32G_MSCR_PC_02 =  34,
+	S32G_MSCR_PC_03 =  35,
+	S32G_MSCR_PC_04 =  36,
+	S32G_MSCR_PC_05 =  37,
+	S32G_MSCR_PC_06 =  38,
+	S32G_MSCR_PC_07 =  39,
+	S32G_MSCR_PC_08 =  40,
+	S32G_MSCR_PC_09 =  41,
+	S32G_MSCR_PC_10 =  42,
+	S32G_MSCR_PC_11 =  43,
+	S32G_MSCR_PC_12 =  44,
+	S32G_MSCR_PC_13 =  45,
+	S32G_MSCR_PC_14 =  46,
+	S32G_MSCR_PC_15 =  47,
+	S32G_MSCR_PD_00 =  48,
+	S32G_MSCR_PD_01 =  49,
+	S32G_MSCR_PD_02 =  50,
+	S32G_MSCR_PD_03 =  51,
+	S32G_MSCR_PD_04 =  52,
+	S32G_MSCR_PD_05 =  53,
+	S32G_MSCR_PD_06 =  54,
+	S32G_MSCR_PD_07 =  55,
+	S32G_MSCR_PD_08 =  56,
+	S32G_MSCR_PD_09 =  57,
+	S32G_MSCR_PD_10 =  58,
+	S32G_MSCR_PD_11 =  59,
+	S32G_MSCR_PD_12 =  60,
+	S32G_MSCR_PD_13 =  61,
+	S32G_MSCR_PD_14 =  62,
+	S32G_MSCR_PD_15 =  63,
+	S32G_MSCR_PE_00 =  64,
+	S32G_MSCR_PE_01 =  65,
+	S32G_MSCR_PE_02 =  66,
+	S32G_MSCR_PE_03 =  67,
+	S32G_MSCR_PE_04 =  68,
+	S32G_MSCR_PE_05 =  69,
+	S32G_MSCR_PE_06 =  70,
+	S32G_MSCR_PE_07 =  71,
+	S32G_MSCR_PE_08 =  72,
+	S32G_MSCR_PE_09 =  73,
+	S32G_MSCR_PE_10 =  74,
+	S32G_MSCR_PE_11 =  75,
+	S32G_MSCR_PE_12 =  76,
+	S32G_MSCR_PE_13 =  77,
+	S32G_MSCR_PE_14 =  78,
+	S32G_MSCR_PE_15 =  79,
+	S32G_MSCR_PF_00 =  80,
+	S32G_MSCR_PF_01 =  81,
+	S32G_MSCR_PF_02 =  82,
+	S32G_MSCR_PF_03 =  83,
+	S32G_MSCR_PF_04 =  84,
+	S32G_MSCR_PF_05 =  85,
+	S32G_MSCR_PF_06 =  86,
+	S32G_MSCR_PF_07 =  87,
+	S32G_MSCR_PF_08 =  88,
+	S32G_MSCR_PF_09 =  89,
+	S32G_MSCR_PF_10 =  90,
+	S32G_MSCR_PF_11 =  91,
+	S32G_MSCR_PF_12 =  92,
+	S32G_MSCR_PF_13 =  93,
+	S32G_MSCR_PF_14 =  94,
+	S32G_MSCR_PF_15 =  95,
+	S32G_MSCR_PG_00 =  96,
+	S32G_MSCR_PG_01 =  97,
+	S32G_MSCR_PG_02 =  98,
+	S32G_MSCR_PG_03 =  99,
+	S32G_MSCR_PG_04 =  100,
+	S32G_MSCR_PG_05 =  101,
+	S32G_MSCR_PH_00 =  112,
+	S32G_MSCR_PH_01 =  113,
+	S32G_MSCR_PH_02 =  114,
+	S32G_MSCR_PH_03 =  115,
+	S32G_MSCR_PH_04 =  116,
+	S32G_MSCR_PH_05 =  117,
+	S32G_MSCR_PH_06 =  118,
+	S32G_MSCR_PH_07 =  119,
+	S32G_MSCR_PH_08 =  120,
+	S32G_MSCR_PH_09 =  121,
+	S32G_MSCR_PH_10 =  122,
+	S32G_MSCR_PJ_00 =  144,
+	S32G_MSCR_PJ_01 =  145,
+	S32G_MSCR_PJ_02 =  146,
+	S32G_MSCR_PJ_03 =  147,
+	S32G_MSCR_PJ_04 =  148,
+	S32G_MSCR_PJ_05 =  149,
+	S32G_MSCR_PJ_06 =  150,
+	S32G_MSCR_PJ_07 =  151,
+	S32G_MSCR_PJ_08 =  152,
+	S32G_MSCR_PJ_09 =  153,
+	S32G_MSCR_PJ_10 =  154,
+	S32G_MSCR_PJ_11 =  155,
+	S32G_MSCR_PJ_12 =  156,
+	S32G_MSCR_PJ_13 =  157,
+	S32G_MSCR_PJ_14 =  158,
+	S32G_MSCR_PJ_15 =  159,
+	S32G_MSCR_PK_00 =  160,
+	S32G_MSCR_PK_01 =  161,
+	S32G_MSCR_PK_02 =  162,
+	S32G_MSCR_PK_03 =  163,
+	S32G_MSCR_PK_04 =  164,
+	S32G_MSCR_PK_05 =  165,
+	S32G_MSCR_PK_06 =  166,
+	S32G_MSCR_PK_07 =  167,
+	S32G_MSCR_PK_08 =  168,
+	S32G_MSCR_PK_09 =  169,
+	S32G_MSCR_PK_10 =  170,
+	S32G_MSCR_PK_11 =  171,
+	S32G_MSCR_PK_12 =  172,
+	S32G_MSCR_PK_13 =  173,
+	S32G_MSCR_PK_14 =  174,
+	S32G_MSCR_PK_15 =  175,
+	S32G_MSCR_PL_00 =  176,
+	S32G_MSCR_PL_01 =  177,
+	S32G_MSCR_PL_02 =  178,
+	S32G_MSCR_PL_03 =  179,
+	S32G_MSCR_PL_04 =  180,
+	S32G_MSCR_PL_05 =  181,
+	S32G_MSCR_PL_06 =  182,
+	S32G_MSCR_PL_07 =  183,
+	S32G_MSCR_PL_08 =  184,
+	S32G_MSCR_PL_09 =  185,
+	S32G_MSCR_PL_10 =  186,
+	S32G_MSCR_PL_11 =  187,
+	S32G_MSCR_PL_12 =  188,
+	S32G_MSCR_PL_13 =  189,
+	S32G_MSCR_PL_14 =  190,
+
+	S32G_IMCR_QSPI_A_DATA0 = 540,
+	S32G_IMCR_QSPI_A_DATA1 = 541,
+	S32G_IMCR_QSPI_A_DATA2 = 542,
+	S32G_IMCR_QSPI_A_DATA3 = 543,
+	S32G_IMCR_QSPI_A_DATA4 = 544,
+	S32G_IMCR_QSPI_A_DATA5 = 545,
+	S32G_IMCR_QSPI_A_DATA6 = 546,
+	S32G_IMCR_QSPI_A_DATA7 = 547,
+	S32G_IMCR_QSPI_DQS_A = 548,
+	S32G_IMCR_QSPI_B_DATA0 = 552,
+	S32G_IMCR_QSPI_B_DATA1 = 554,
+	S32G_IMCR_QSPI_B_DATA2 = 551,
+	S32G_IMCR_QSPI_B_DATA3 = 553,
+	S32G_IMCR_QSPI_B_DATA4 = 557,
+	S32G_IMCR_QSPI_B_DATA5 = 550,
+	S32G_IMCR_QSPI_B_DATA6 = 556,
+	S32G_IMCR_QSPI_B_DATA7 = 555,
+	S32G_IMCR_QSPI_DQS_B = 558,
+	S32G_IMCR_BOOT_BOOTMOD0 = 560,
+	S32G_IMCR_BOOT_BOOTMOD1 = 561,
+	S32G_IMCR_I2C0_SCL = 566,
+	S32G_IMCR_I2C0_SDA = 565,
+	S32G_IMCR_LIN0_RX = 512,
+	S32G_IMCR_USDHC_CMD = 515,
+	S32G_IMCR_USDHC_DAT0 = 516,
+	S32G_IMCR_USDHC_DAT1 = 517,
+	S32G_IMCR_USDHC_DAT2 = 520,
+	S32G_IMCR_USDHC_DAT3 = 521,
+	S32G_IMCR_USDHC_DAT4 = 522,
+	S32G_IMCR_USDHC_DAT5 = 523,
+	S32G_IMCR_USDHC_DAT6 = 519,
+	S32G_IMCR_USDHC_DAT7 = 518,
+	S32G_IMCR_USDHC_DQS = 524,
+	S32G_IMCR_CAN0_RXD = 513,
+	S32G_IMCR_CAN1_RXD = 631,
+	S32G_IMCR_CAN2_RXD = 632,
+	S32G_IMCR_CAN3_RXD = 633,
+	/* GMAC0 */
+	S32G_IMCR_Ethernet_MDIO = 527,
+	S32G_IMCR_Ethernet_CRS = 526,
+	S32G_IMCR_Ethernet_COL = 525,
+	S32G_IMCR_Ethernet_RX_D0 = 531,
+	S32G_IMCR_Ethernet_RX_D1 = 532,
+	S32G_IMCR_Ethernet_RX_D2 = 533,
+	S32G_IMCR_Ethernet_RX_D3 = 534,
+	S32G_IMCR_Ethernet_RX_ER = 528,
+	S32G_IMCR_Ethernet_RX_CLK = 529,
+	S32G_IMCR_Ethernet_RX_DV = 530,
+	S32G_IMCR_Ethernet_TX_CLK = 538,
+	S32G_IMCR_Ethernet_REF_CLK = 535,
+	/* PFE EMAC 0 MII */
+	/* PFE EMAC 1 MII */
+	S32G_IMCR_PFE_EMAC_1_MDIO = 857,
+	S32G_IMCR_PFE_EMAC_1_CRS = 856,
+	S32G_IMCR_PFE_EMAC_1_COL = 855,
+	S32G_IMCR_PFE_EMAC_1_RX_D0 = 861,
+	S32G_IMCR_PFE_EMAC_1_RX_D1 = 862,
+	S32G_IMCR_PFE_EMAC_1_RX_D2 = 863,
+	S32G_IMCR_PFE_EMAC_1_RX_D3 = 864,
+	S32G_IMCR_PFE_EMAC_1_RX_ER = 860,
+	S32G_IMCR_PFE_EMAC_1_RX_CLK = 859,
+	S32G_IMCR_PFE_EMAC_1_RX_DV = 865,
+	S32G_IMCR_PFE_EMAC_1_TX_CLK = 866,
+	S32G_IMCR_PFE_EMAC_1_REF_CLK = 858,
+	/* PFE EMAC 2 MII */
+	S32G_IMCR_PFE_EMAC_2_MDIO = 877,
+	S32G_IMCR_PFE_EMAC_2_CRS = 876,
+	S32G_IMCR_PFE_EMAC_2_COL = 875,
+	S32G_IMCR_PFE_EMAC_2_RX_D0 = 881,
+	S32G_IMCR_PFE_EMAC_2_RX_D1 = 882,
+	S32G_IMCR_PFE_EMAC_2_RX_D2 = 883,
+	S32G_IMCR_PFE_EMAC_2_RX_D3 = 884,
+	S32G_IMCR_PFE_EMAC_2_RX_ER = 880,
+	S32G_IMCR_PFE_EMAC_2_RX_CLK = 879,
+	S32G_IMCR_PFE_EMAC_2_RX_DV = 885,
+	S32G_IMCR_PFE_EMAC_2_TX_CLK = 886,
+	S32G_IMCR_PFE_EMAC_2_REF_CLK = 878,
+
+	S32G_IMCR_FlexRay0_A_RX = 785,
+	S32G_IMCR_FlexRay0_B_RX = 786,
+	S32G_IMCR_FlexTimer0_CH0 = 655,
+	S32G_IMCR_FlexTimer1_CH0 = 665,
+	S32G_IMCR_FlexTimer0_CH1 = 656,
+	S32G_IMCR_FlexTimer1_CH1 = 666,
+	S32G_IMCR_FlexTimer0_CH2 = 657,
+	S32G_IMCR_FlexTimer1_CH2 = 667,
+	S32G_IMCR_FlexTimer0_CH3 = 658,
+	S32G_IMCR_FlexTimer1_CH3 = 668,
+	S32G_IMCR_FlexTimer0_CH4 = 659,
+	S32G_IMCR_FlexTimer1_CH4 = 669,
+	S32G_IMCR_FlexTimer0_CH5 = 660,
+	S32G_IMCR_FlexTimer1_CH5 = 670,
+	S32G_IMCR_FlexTimer0_EXTCLK = 661,
+	S32G_IMCR_FlexTimer1_EXTCLK = 671,
+	S32G_IMCR_I2C1_SCL = 717,
+	S32G_IMCR_I2C1_SDA = 718,
+	S32G_IMCR_I2C2_SCL = 719,
+	S32G_IMCR_I2C2_SDA = 720,
+	S32G_IMCR_I2C3_SCL = 721,
+	S32G_IMCR_I2C3_SDA = 722,
+	S32G_IMCR_I2C4_SCL = 723,
+	S32G_IMCR_I2C4_SDA = 724,
+	S32G_IMCR_LIN1_RX = 736,
+	S32G_IMCR_LIN2_RX = 737,
+	S32G_IMCR_DSPI0_PCS0 = 980,
+	S32G_IMCR_DSPI0_SCK = 981,
+	S32G_IMCR_DSPI0_SIN = 982,
+	S32G_IMCR_DSPI1_PCS0 = 985,
+	S32G_IMCR_DSPI1_SCK = 986,
+	S32G_IMCR_DSPI1_SIN = 987,
+	S32G_IMCR_DSPI2_PCS0 = 990,
+	S32G_IMCR_DSPI2_SCK = 991,
+	S32G_IMCR_DSPI2_SIN = 992,
+	S32G_IMCR_DSPI3_PCS0 = 995,
+	S32G_IMCR_DSPI3_SCK = 996,
+	S32G_IMCR_DSPI3_SIN = 997,
+	S32G_IMCR_DSPI4_PCS0 = 1000,
+	S32G_IMCR_DSPI4_SCK = 1001,
+	S32G_IMCR_DSPI4_SIN = 1002,
+	S32G_IMCR_DSPI5_PCS0 = 1005,
+	S32G_IMCR_DSPI5_SCK = 1006,
+	S32G_IMCR_DSPI5_SIN = 1007,
+	S32G_IMCR_LLCE_CAN0_RXD = 745,
+	S32G_IMCR_LLCE_CAN1_RXD = 746,
+	S32G_IMCR_LLCE_CAN2_RXD = 747,
+	S32G_IMCR_LLCE_CAN3_RXD = 748,
+	S32G_IMCR_LLCE_CAN4_RXD = 749,
+	S32G_IMCR_LLCE_CAN5_RXD = 750,
+	S32G_IMCR_LLCE_CAN6_RXD = 751,
+	S32G_IMCR_LLCE_CAN7_RXD = 752,
+	S32G_IMCR_LLCE_CAN8_RXD = 753,
+	S32G_IMCR_LLCE_CAN9_RXD = 754,
+	S32G_IMCR_LLCE_CAN10_RXD = 755,
+	S32G_IMCR_LLCE_CAN11_RXD = 756,
+	S32G_IMCR_LLCE_CAN12_RXD = 757,
+	S32G_IMCR_LLCE_CAN13_RXD = 758,
+	S32G_IMCR_LLCE_CAN14_RXD = 759,
+	S32G_IMCR_LLCE_CAN15_RXD = 760,
+	S32G_IMCR_USB_CLK = 895,
+	S32G_IMCR_USB_DATA0 = 896,
+	S32G_IMCR_USB_DATA1 = 897,
+	S32G_IMCR_USB_DATA2 = 898,
+	S32G_IMCR_USB_DATA3 = 899,
+	S32G_IMCR_USB_DATA4 = 900,
+	S32G_IMCR_USB_DATA5 = 901,
+	S32G_IMCR_USB_DATA6 = 902,
+	S32G_IMCR_USB_DATA7 = 903,
+	S32G_IMCR_USB_DIR = 904,
+	S32G_IMCR_USB_NXT = 905,
+
+	S32G_IMCR_SIUL_EIRQ0 =  910,
+	S32G_IMCR_SIUL_EIRQ1 =  911,
+	S32G_IMCR_SIUL_EIRQ2 =  912,
+	S32G_IMCR_SIUL_EIRQ3 =  913,
+	S32G_IMCR_SIUL_EIRQ4 =  914,
+	S32G_IMCR_SIUL_EIRQ5 =  915,
+	S32G_IMCR_SIUL_EIRQ6 =  916,
+	S32G_IMCR_SIUL_EIRQ7 =  917,
+	S32G_IMCR_SIUL_EIRQ8 =  918,
+	S32G_IMCR_SIUL_EIRQ9 =  919,
+	S32G_IMCR_SIUL_EIRQ10 =  920,
+	S32G_IMCR_SIUL_EIRQ11 =  921,
+	S32G_IMCR_SIUL_EIRQ12 =  922,
+	S32G_IMCR_SIUL_EIRQ13 =  923,
+	S32G_IMCR_SIUL_EIRQ14 =  924,
+	S32G_IMCR_SIUL_EIRQ15 =  925,
+	S32G_IMCR_SIUL_EIRQ16 =  926,
+	S32G_IMCR_SIUL_EIRQ17 =  927,
+	S32G_IMCR_SIUL_EIRQ18 =  928,
+	S32G_IMCR_SIUL_EIRQ19 =  929,
+	S32G_IMCR_SIUL_EIRQ20 =  930,
+	S32G_IMCR_SIUL_EIRQ21 =  931,
+	S32G_IMCR_SIUL_EIRQ22 =  932,
+	S32G_IMCR_SIUL_EIRQ23 =  933,
+	S32G_IMCR_SIUL_EIRQ24 =  934,
+	S32G_IMCR_SIUL_EIRQ25 =  935,
+	S32G_IMCR_SIUL_EIRQ26 =  936,
+	S32G_IMCR_SIUL_EIRQ27 =  937,
+	S32G_IMCR_SIUL_EIRQ28 =  938,
+	S32G_IMCR_SIUL_EIRQ29 =  939,
+	S32G_IMCR_SIUL_EIRQ30 =  940,
+	S32G_IMCR_SIUL_EIRQ31 =  941,
+};
+
+/* Pad names for the pinmux subsystem */
+static const struct pinctrl_pin_desc s32_pinctrl_pads_siul2[] = {
+
+	/* SIUL2_0 pins. */
+
+	S32_PINCTRL_PIN(S32G_MSCR_PA_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_14),
+	S32_PINCTRL_PIN(S32G_MSCR_PA_15),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_14),
+	S32_PINCTRL_PIN(S32G_MSCR_PB_15),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_14),
+	S32_PINCTRL_PIN(S32G_MSCR_PC_15),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_14),
+	S32_PINCTRL_PIN(S32G_MSCR_PD_15),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_14),
+	S32_PINCTRL_PIN(S32G_MSCR_PE_15),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_14),
+	S32_PINCTRL_PIN(S32G_MSCR_PF_15),
+	S32_PINCTRL_PIN(S32G_MSCR_PG_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PG_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PG_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PG_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PG_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PG_05),
+
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_A_DATA0),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_A_DATA1),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_A_DATA2),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_A_DATA3),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_A_DATA4),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_A_DATA5),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_A_DATA6),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_A_DATA7),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_DQS_A),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_B_DATA0),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_B_DATA1),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_B_DATA2),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_B_DATA3),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_B_DATA4),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_B_DATA5),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_B_DATA6),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_B_DATA7),
+	S32_PINCTRL_PIN(S32G_IMCR_QSPI_DQS_B),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C0_SCL),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C0_SDA),
+	S32_PINCTRL_PIN(S32G_IMCR_LIN0_RX),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_CMD),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DAT0),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DAT1),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DAT2),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DAT3),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DAT4),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DAT5),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DAT6),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DAT7),
+	S32_PINCTRL_PIN(S32G_IMCR_USDHC_DQS),
+	S32_PINCTRL_PIN(S32G_IMCR_CAN0_RXD),
+	/* GMAC0 */
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_MDIO),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_CRS),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_COL),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_RX_D0),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_RX_D1),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_RX_D2),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_RX_D3),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_RX_ER),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_RX_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_RX_DV),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_TX_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_Ethernet_REF_CLK),
+
+	/* SIUL2_1 pins. */
+
+	S32_PINCTRL_PIN(S32G_MSCR_PH_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PH_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_14),
+	S32_PINCTRL_PIN(S32G_MSCR_PJ_15),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_14),
+	S32_PINCTRL_PIN(S32G_MSCR_PK_15),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_00),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_01),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_02),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_03),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_04),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_05),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_06),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_07),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_08),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_09),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_10),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_11),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_12),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_13),
+	S32_PINCTRL_PIN(S32G_MSCR_PL_14),
+
+	S32_PINCTRL_PIN(S32G_IMCR_FlexRay0_A_RX),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexRay0_B_RX),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer0_CH0),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer1_CH0),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer0_CH1),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer1_CH1),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer0_CH2),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer1_CH2),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer0_CH3),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer1_CH3),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer0_CH4),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer1_CH4),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer0_CH5),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer1_CH5),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer0_EXTCLK),
+	S32_PINCTRL_PIN(S32G_IMCR_FlexTimer1_EXTCLK),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C1_SCL),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C1_SDA),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C2_SCL),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C2_SDA),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C3_SCL),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C3_SDA),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C4_SCL),
+	S32_PINCTRL_PIN(S32G_IMCR_I2C4_SDA),
+	S32_PINCTRL_PIN(S32G_IMCR_LIN1_RX),
+	S32_PINCTRL_PIN(S32G_IMCR_LIN2_RX),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI0_PCS0),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI0_SCK),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI0_SIN),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI1_PCS0),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI1_SCK),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI1_SIN),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI2_PCS0),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI2_SCK),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI2_SIN),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI3_PCS0),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI3_SCK),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI3_SIN),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI4_PCS0),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI4_SCK),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI4_SIN),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI5_PCS0),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI5_SCK),
+	S32_PINCTRL_PIN(S32G_IMCR_DSPI5_SIN),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN0_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN1_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN2_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN3_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN4_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN5_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN6_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN7_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN8_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN9_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN10_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN11_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN12_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN13_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN14_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_LLCE_CAN15_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_CAN1_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_CAN2_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_CAN3_RXD),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DATA0),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DATA1),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DATA2),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DATA3),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DATA4),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DATA5),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DATA6),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DATA7),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_DIR),
+	S32_PINCTRL_PIN(S32G_IMCR_USB_NXT),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_MDIO),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_CRS),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_COL),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_RX_D0),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_RX_D1),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_RX_D2),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_RX_D3),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_RX_ER),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_RX_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_RX_DV),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_TX_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_1_REF_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_MDIO),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_CRS),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_COL),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_RX_D0),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_RX_D1),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_RX_D2),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_RX_D3),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_RX_ER),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_RX_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_RX_DV),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_TX_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_PFE_EMAC_2_REF_CLK),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ0),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ1),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ2),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ3),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ4),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ5),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ6),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ7),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ8),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ9),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ10),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ11),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ12),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ13),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ14),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ15),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ16),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ17),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ18),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ19),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ20),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ21),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ22),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ23),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ24),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ25),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ26),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ27),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ28),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ29),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ30),
+	S32_PINCTRL_PIN(S32G_IMCR_SIUL_EIRQ31),
+};
+
+static const struct s32_pin_range s32_pin_ranges_siul2[] = {
+	/* MSCR pin ID ranges */
+	S32_PIN_RANGE(0, 101),
+	S32_PIN_RANGE(112, 122),
+	S32_PIN_RANGE(144, 190),
+	/* IMCR pin ID ranges */
+	S32_PIN_RANGE(512, 595),
+	S32_PIN_RANGE(631, 909),
+	S32_PIN_RANGE(942, 1007),
+};
+
+static struct s32_pinctrl_soc_info s32_pinctrl_info = {
+	.pins = s32_pinctrl_pads_siul2,
+	.npins = ARRAY_SIZE(s32_pinctrl_pads_siul2),
+	.mem_pin_ranges = s32_pin_ranges_siul2,
+	.mem_regions = ARRAY_SIZE(s32_pin_ranges_siul2),
+};
+
+static const struct of_device_id s32_pinctrl_of_match[] = {
+	{
+
+		.compatible = "nxp,s32g2-siul2-pinctrl",
+		.data = (void *) &s32_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
+
+static int s32g_pinctrl_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+		of_match_device(s32_pinctrl_of_match, &pdev->dev);
+
+	if (!of_id)
+		return -ENODEV;
+
+	return s32_pinctrl_probe
+			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);
+}
+
+static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend,
+				     s32_pinctrl_resume)
+};
+
+static struct platform_driver s32g_pinctrl_driver = {
+	.driver = {
+		.name = "s32g-siul2-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = s32_pinctrl_of_match,
+		.pm = &s32g_pinctrl_pm_ops,
+		.suppress_bind_attrs = true,
+	},
+	.probe = s32g_pinctrl_probe,
+};
+
+builtin_platform_driver(s32g_pinctrl_driver);
+
+MODULE_AUTHOR("Matthew Nunez <matthew.nunez@nxp.com>");
+MODULE_DESCRIPTION("NXP S32G pinctrl driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3

