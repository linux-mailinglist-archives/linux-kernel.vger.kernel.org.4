Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EFE6FDF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbjEJNxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjEJNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:52:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F92AD10;
        Wed, 10 May 2023 06:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwQQBROZv3j7ugdrMULOAM7tL1PRY40cTe22aWq9zwtXYK0FFtcampY33ZdJZh7ViN8RE6OkhUo5rg3urnyRmD+H8ew+O84ckhO+9JOdWdW2z+Dqjjt1oTwDS3NihwTdtIuoPFeUTAhaWiWuabsIMmGeG7r03aD5PcIDSQaiDRRQb1QNcB5l26YsOnTcjn4aY9LIvrxBGX4i62yo27mDSkA+SfbAuwwSiTZwyTGhMCymAArpvsgW/jQEHJ1j1PZ9cuD/oUBx10bzTVcWwQ4tCfZY91D0kxH6rkU8RemaVvrv35scNiMNGPB0Ep9yhRNI3z9KLqRwC4qLcshXMwJ+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFVRitJFlI6mxlQmNRx8FZPHBNUHRPAFfG+HfHhgBjY=;
 b=bkB3KChpVtb4Op0nn0aRvS4nU3tN74zg3+ITUVmrdH8ElwBVKW2wcUvQqER+VIPMql22f8GW9qz857oRqabMq0ifO8uNF6YErSPQqDsaRYb3lvTQfvLhfEZPnHCk9XVoyiFt97ORcCqTr7mjDMsjVXmVVbwv5IiZ1WIyf1llXdA2eIbIXDMQt8JWBOWgwZ8DVlht+Ib4RZ/Zl2ILrw1EqIckDSlrOa4o463gVs02SQ4XJNcPVRap7g7moOS0ju8SbQglqO92883wErxZ3MWD7ZtrksWnlUPAqLan8nswUY8ceSrQmH2wJMimyV0r9JkhNF7Srw+7eEXK7NuiJtjFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFVRitJFlI6mxlQmNRx8FZPHBNUHRPAFfG+HfHhgBjY=;
 b=VThCI4MSPH921HY9ZTo4k7pKXkZyWKtcvzNpg9mXnn2A6IeEsjKsgowDJZQ+lO4oq47WmHDJWdmldbngQ/IQ6yxdXj+TL6pk4ZkIz7mESCk+phiJz0XpYDJZIgvu+uljbmcXjpX1CQhPEh7QfJPE2FjK0HrcPdVvIhQJrEHq8GY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAWPR08MB10212.eurprd08.prod.outlook.com (2603:10a6:102:369::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 13:51:12 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 13:51:12 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Wed, 10 May 2023 15:50:46 +0200
Subject: [PATCH 1/4] Input: ts-virtobj - Add touchsreen virtual object
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v1-1-5ae5e81bc264@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683726670; l=14195;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=9hafbOgn/l1b7xRyuf2Eep+jcODbpHfdSt2LYOw75W0=;
 b=BRd7C1/IJJAmoc/hyGLE1XAGxzeBJaR62fc3FAXnpim3wtGYMXJxXYcZwh+HnUiySS2YD2v6a
 2xfvos7lz6bDjSQEdgKKVuZZYjN3jqpSkKURqgtuaiGM7MrGwLCu547
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::34) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAWPR08MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: 11566b4a-2bc9-4a07-a6cd-08db515d9d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Arf0hmoMSwoSdU2tnCT73QfLnU+2h35o/GZUcudmOZt+9uYIIEnrGDoa3vNkBueA4JSYLZMlijLODXu+pBXUc0xu+pZrFXDD4CAH5u1oDxADKZiChc3AMSErga75nwVK+fwQsywfb8kzhknXgZCCg7FtHhYed3WnZ0n1gjvM32JRarbyu6RSpd6o5bODNgx3Q/PlIZCK9xPdmV6hMIas7Pab0Hi8IavotYlanBNM4xdLB3xWytL7Yneo8AI+POTFyCufj8d6z1ahV/UUiT52vGkwIe5Ggs8fZPd4qc1MB3l55jHGBcL3OZqlSoZcXi9wj73tfGm/9/dHeRi7LzsZc1xSsa3gwOMcXDmRZaG9mlpC9RxiY3nAqAyMwjzRTLbwfx4xXAsLEwxyg4LoBhRpdOLhU+8EbEAtm/jsXgdFWssu7dmnEnRDm7WT0LrXohtma05Y0dPr87xzYVGTHooIj4mijOsUzT5YptYJWmCdcjP7Bd/75psQU8w+rDnATTlMgXCIl0iOpnzp4TyP3yIucvQIUHnZoeX3j0tjktdJT+ydmh5R/2UdGxDBgAHfQ5tyCdO97xwBPlaTuwISIU1UhMnBNiObxlWFw4QIML896LU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39850400004)(396003)(451199021)(86362001)(36756003)(6666004)(966005)(110136005)(316002)(6636002)(4326008)(66476007)(52116002)(478600001)(66946007)(66556008)(6486002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(2906002)(30864003)(38100700002)(38350700002)(186003)(2616005)(26005)(6512007)(107886003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1JVkpHNmp1cG0yb09nVjBEMnd5bjR0S0xISmFoeGJmckE5R2tVdVg1bEc4?=
 =?utf-8?B?bnRKUUphdzhSbVQ5M0dHb0hubWhlTXZUSGNhdkxWUGpRd3pRU290Z0dKeW5o?=
 =?utf-8?B?LzV1am9WdndCRWRwVSt2MVNUSzdvMEw0b2d6U3hrOGt4bllKVXBGVVZ5WE5H?=
 =?utf-8?B?eHIwUzFkUjgxVldvL2V1WjJVRkdMcndFNG9xUlVKUi9OUW5yMWJyY1hyNkl0?=
 =?utf-8?B?N1l2TGM3bi92dFVBSkNJK3dsMXNPODBHMDVTeUZvcHRnVmhHd1l2dU1KL1B2?=
 =?utf-8?B?SDhwMFhLdysvN2NGaDdwcWxZTHZtR05DbmtQeFNFdVhwSHNrQ3pTTHBTT1Qr?=
 =?utf-8?B?QkxGMEV1VGp1R1pUdE9MVXJjZmRzYUtqRThlbkJjaDFkMTBXbjM2dS81cUl4?=
 =?utf-8?B?eEVZRTZSL3ovNU9mT3BkclM1M3RMVzFFRys1elhZWVZVdGNSMXdQT3V1N2g0?=
 =?utf-8?B?Z2hwbXdwYWFLWFZib2d2dTJNUDh5U3lJaU1USnhNdWZ5SFJYRFd3V0JSMVpr?=
 =?utf-8?B?akx4cnFobmVoQWQ5NTJ0NmNLMy9WajQrNXJrTEFJUU41TTJmOTBRdFlzeFBE?=
 =?utf-8?B?LzMzRTU5U2tRQUx5bkozOXRpZUNnNjlTYzhPWFN0ZlRxSWFlUnJheUtocnN4?=
 =?utf-8?B?QXFEajBUSWl6bE9vaXBpQUlxK0VmWmI5MlprbXJuYlBCS1FoVURwTEJqdmhS?=
 =?utf-8?B?M2FmYVRkUlhOUEltNGFnQjhzQ0pPVVhoV0JuQTZGd0MraW5sTHBwazBBQm5z?=
 =?utf-8?B?czZ1S2RmRzhIQythY3NFWW1UNXUwOVlqSWpoMnp2dTJ6QWRGYkdrSHZwNXhK?=
 =?utf-8?B?ZXp2YW9LNWFXeG0ySU8rRjZ3cjFEOHRyOEIwdDlBb1lwWjVlNGNkKy8yZk5Z?=
 =?utf-8?B?RUdVRkNYVmk4VVNDMjEwbzdiVGFBdWZ5dFFlTVNhY1BFTVVyQkNSWU5SeG9l?=
 =?utf-8?B?QnBpbC8wMkhSMFVHQ1YzSTBZdVZpZFYvalBMUHlEd3ZBTVNJMkwyVnFqaVBu?=
 =?utf-8?B?NFVzK0RyOG81Uyt1ZytOZkRBSXk2cmxjZmwrbEZ3WCtJUkVIN1NBWWh3Qzhj?=
 =?utf-8?B?ejdrSk5CNGxpNVVDQ3orMUlsS1BPa0RrSys5TDdFd25RL3MxRXRVSDBHYkR6?=
 =?utf-8?B?ZUVmcjc3aWp1czQwZU1RUVU0ZE5nUFgxTzhaS1F5UzdWbWI0cWJkREwxcXJV?=
 =?utf-8?B?SzlXa25EK0Y5VGhuWE4vajdpZThIVE9vSkI3MWFHdUxiS3pUWGdNVVRTQlNM?=
 =?utf-8?B?V2ZYaWc1bUZFNnhBcWRFRXh5S3g5SkJXU0hPcUU4Q1VRaDRrMXN2TllTMmlU?=
 =?utf-8?B?cTI0UnhyY0RsNkFUeTJWdGdQRmxHNFY5c0cvMmxQS2RrZDJxYk0vMlBYdC94?=
 =?utf-8?B?bWVTdTFudXFOSGVRcW02VWRkSGFrM1VSODJnRlRRb0l1c0o1ejd4RnVEL0Ra?=
 =?utf-8?B?QWJpUDBLQ3JCQU05SWc4RVB1T3lIcDBVamdaUHNUMW5kZll0WHZsd1NsSDhU?=
 =?utf-8?B?N1ZpbGhqbzdqTEM3SWJrdHJNd25zeDNoUmZlcGtiTjVPQ3NkNkxzMHNmQlpk?=
 =?utf-8?B?OGhwUUhnQVVDMG9tSDVnK3RMSXp4a1o4RFZCVER0cEhrUmdmdmgvTFZISUdo?=
 =?utf-8?B?Vy92VGUzT0xJdHZhc3l3OTFYcE4xRTVmTVlhSVl3VWZ2S3BwZzhJVE9KWUxv?=
 =?utf-8?B?c05FOTh4dlNpZ0ZUbDk1bWRPemZqRnRJbHg4cy90eDhNRi8xbVlzZkVRbVBJ?=
 =?utf-8?B?Z0EvZzVZZTRXU2llZmxzbDVnb3lBZXQ4T0wwanJIdG91YjVISGV5TCtDNFFI?=
 =?utf-8?B?RmJCVkgzNENFOWk5NDJST3QzMTlmL3d2QXdHNENUd1daSWR4WDFoMWxhbGhY?=
 =?utf-8?B?SWdvN3B6YlhwcHNacVBnWHMvVVFNSTFqSG43UitweDVWQ3VMUkVBZGdTYkRX?=
 =?utf-8?B?a1lzT1BUdEg1OWM3RjRVbXg4VnlxZHNta2dHc0ZFTzhxejBWNHQ3dlF0cjJU?=
 =?utf-8?B?eS9MQWdnQmhCS2dkME1KV3g4WVhSTSt2QmhKT3hyTU84UENDU2xSS05tb0Zn?=
 =?utf-8?B?MnRkRDhBa1JEWk5JRkNkT1Zvd1UrUFc3bThaYWVQRy9uOHl2Q2Z0YXEwZFA1?=
 =?utf-8?B?U2doaEhPMlVVaG5ybTdaNFhzZUJtV1FjTWVpUys2TUpCS1ZtdS8wL3Avbzhn?=
 =?utf-8?Q?F+sndBSijuaeTN1KO/NU+2g=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 11566b4a-2bc9-4a07-a6cd-08db515d9d4e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:51:11.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQ3o/S5kMuqLC47esDe8AiuZy9CKh0LssFffWXOo+Xo7KwtkQj+GI9TkBHmC1+xs6a1x0q50zZbo8pUYI+dIJUqS8VomsaShQ79WicOj2wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touchscreens provide mechanical overlays with different objects
like buttons or clipped touchscreen surfaces.

In order to support these objects, add a series of helper functions
to the input subsystem to transform them into virtual objects via
device tree nodes.

These virtual objects consume the raw touch events and report the
expected input events depending on the object properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 MAINTAINERS                            |   7 +
 drivers/input/touchscreen/Kconfig      |   9 +
 drivers/input/touchscreen/Makefile     |   1 +
 drivers/input/touchscreen/ts-virtobj.c | 360 +++++++++++++++++++++++++++++++++
 include/linux/input/ts-virtobj.h       |  95 +++++++++
 5 files changed, 472 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..296f71bcfe92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21434,6 +21434,13 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TOUCHSCREEN VIRTUAL OBJECTS
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touchscreen/ts-virtobj.c
+F:	include/linux/input/ts-virtobj.h
+
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 143ff43c67ae..276f6e0b914b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1388,4 +1388,13 @@ config TOUCHSCREEN_HIMAX_HX83112B
 	  To compile this driver as a module, choose M here: the
 	  module will be called himax_hx83112b.
 
+config TOUCHSCREEN_TS_VIRTOBJ
+	tristate "Touchscreen Virtual Objects"
+	help
+	  Say Y here if you are using a touchscreen driver that supports
+	  printed overlays with keys or a clipped touchscreen area.
+
+	  To compile this feature as a module, choose M here: the
+	  module will be called ts-virtobj.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 159cd5136fdb..dc315d58a03b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -117,3 +117,4 @@ obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
 obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
 obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
+obj-$(CONFIG_TOUCHSCREEN_TS_VIRTOBJ)	+= ts-virtobj.o
diff --git a/drivers/input/touchscreen/ts-virtobj.c b/drivers/input/touchscreen/ts-virtobj.c
new file mode 100644
index 000000000000..56c137fc49a3
--- /dev/null
+++ b/drivers/input/touchscreen/ts-virtobj.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Helper functions for virtual objects on touchscreens
+ *
+ *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#include <linux/property.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/module.h>
+#include <linux/input/ts-virtobj.h>
+
+#if IS_ENABLED(CONFIG_TOUCHSCREEN_TS_VIRTOBJ)
+
+enum ts_virtobj_valid_objects {
+	TOUCHSCREEN,
+	BUTTON,
+};
+
+static const char *const ts_virtobj_names[] = {
+	[TOUCHSCREEN] = "virtual-touchscreen",
+	[BUTTON] = "virtual-buttons",
+};
+
+struct ts_virtobj_shape {
+	u32 x_origin;
+	u32 y_origin;
+	u32 x_size;
+	u32 y_size;
+};
+
+struct ts_virtobj_button {
+	struct ts_virtobj_shape shape;
+	u32 key;
+	bool pressed;
+	int slot;
+};
+
+static int ts_virtobj_get_shape_properties(struct fwnode_handle *child_node,
+					   struct ts_virtobj_shape *shape)
+{
+	int rc;
+
+	rc = fwnode_property_read_u32(child_node, "x-origin", &shape->x_origin);
+	if (rc < 0)
+		return rc;
+
+	rc = fwnode_property_read_u32(child_node, "y-origin", &shape->y_origin);
+	if (rc < 0)
+		return rc;
+
+	rc = fwnode_property_read_u32(child_node, "x-size", &shape->x_size);
+	if (rc < 0)
+		return rc;
+
+	rc = fwnode_property_read_u32(child_node, "y-size", &shape->y_size);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static int ts_virtobj_get_button_properties(struct device *dev,
+					    struct fwnode_handle *child_node,
+					    struct ts_virtobj_button *btn)
+{
+	struct fwnode_handle *child_btn;
+	int rc;
+	int j = 0;
+
+	fwnode_for_each_child_node(child_node, child_btn) {
+		rc = ts_virtobj_get_shape_properties(child_btn, &btn[j].shape);
+		if (rc < 0)
+			goto button_prop_cleanup;
+
+		rc = fwnode_property_read_u32(child_btn, "linux,code",
+					      &btn[j].key);
+		if (rc < 0)
+			goto button_prop_cleanup;
+
+		dev_info(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
+			 btn[j].shape.x_origin, btn[j].shape.y_origin,
+			 btn[j].shape.x_size, btn[j].shape.y_size, btn[j].key);
+		j++;
+	}
+
+	return 0;
+
+button_prop_cleanup:
+	fwnode_handle_put(child_btn);
+	return rc;
+}
+
+void ts_virtobj_set_button_caps(struct ts_virtobj_map *map,
+				struct input_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < map->button_count; i++)
+		input_set_capability(dev, EV_KEY, map->buttons[i].key);
+}
+EXPORT_SYMBOL(ts_virtobj_set_button_caps);
+
+static int ts_virtobj_count_buttons(struct device *dev)
+{
+	struct fwnode_handle *child_node;
+	struct fwnode_handle *child_button;
+	int count = 0;
+
+	child_node = device_get_named_child_node(dev, ts_virtobj_names[BUTTON]);
+	if (!child_node)
+		return 0;
+
+	fwnode_for_each_child_node(child_node, child_button)
+		count++;
+	fwnode_handle_put(child_node);
+
+	return count;
+}
+
+static int ts_virtobj_map_touchscreen(struct device *dev,
+				      struct ts_virtobj_map *map)
+{
+	struct fwnode_handle *child;
+	int rc = 0;
+
+	child = device_get_named_child_node(dev, ts_virtobj_names[TOUCHSCREEN]);
+	if (!child)
+		goto touchscreen_ret;
+
+	map->touchscreen =
+		devm_kzalloc(dev, sizeof(*map->touchscreen), GFP_KERNEL);
+	if (!map->touchscreen) {
+		rc = -ENOMEM;
+		goto touchscreen_handle;
+	}
+	rc = ts_virtobj_get_shape_properties(child, map->touchscreen);
+	if (rc < 0)
+		goto touchscreen_free;
+
+	map->virtual_touchscreen = true;
+	dev_info(dev, "Added virtual touchscreen at (%u, %u), size %u x %u\n",
+		 map->touchscreen->x_origin, map->touchscreen->y_origin,
+		 map->touchscreen->x_size, map->touchscreen->y_size);
+
+	rc = 0;
+	goto touchscreen_handle;
+
+touchscreen_free:
+	devm_kfree(dev, map->touchscreen);
+touchscreen_handle:
+	fwnode_handle_put(child);
+touchscreen_ret:
+	return rc;
+}
+
+static int ts_virtobj_map_buttons(struct device *dev,
+				  struct ts_virtobj_map *map,
+				  struct input_dev *input)
+{
+	struct fwnode_handle *child;
+	u32 button_count;
+	int rc = 0;
+
+	button_count = ts_virtobj_count_buttons(dev);
+	if (button_count) {
+		map->buttons = devm_kcalloc(dev, button_count,
+					    sizeof(*map->buttons), GFP_KERNEL);
+		if (!map->buttons) {
+			rc = -ENOMEM;
+			goto map_buttons_ret;
+		}
+		child = device_get_named_child_node(dev,
+						    ts_virtobj_names[BUTTON]);
+		if (unlikely(!child))
+			goto map_buttons_free;
+
+		rc = ts_virtobj_get_button_properties(dev, child, map->buttons);
+		if (rc < 0)
+			goto map_buttons_free;
+
+		map->button_count = button_count;
+	}
+
+	return 0;
+
+map_buttons_free:
+	devm_kfree(dev, map->buttons);
+map_buttons_ret:
+	return rc;
+}
+
+static bool ts_virtobj_defined_objects(struct device *dev)
+{
+	struct fwnode_handle *child;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ts_virtobj_names); i++) {
+		child = device_get_named_child_node(dev, ts_virtobj_names[i]);
+		if (child) {
+			fwnode_handle_put(child);
+			return true;
+		}
+		fwnode_handle_put(child);
+	}
+
+	return false;
+}
+
+struct ts_virtobj_map *ts_virtobj_map_objects(struct device *dev,
+					      struct input_dev *input)
+{
+	struct ts_virtobj_map *map = NULL;
+	int rc;
+
+	if (!ts_virtobj_defined_objects(dev))
+		return NULL;
+
+	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
+	if (!map) {
+		rc = -ENOMEM;
+		goto objects_err;
+	}
+	rc = ts_virtobj_map_touchscreen(dev, map);
+	if (rc < 0)
+		goto objects_free;
+
+	rc = ts_virtobj_map_buttons(dev, map, input);
+	if (rc < 0)
+		goto objects_free;
+
+	return map;
+
+objects_free:
+	devm_kfree(dev, map);
+objects_err:
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL(ts_virtobj_map_objects);
+
+void ts_virtobj_get_touchscreen_abs(struct ts_virtobj_map *map, u16 *x, u16 *y)
+{
+	*x = map->touchscreen->x_size - 1;
+	*y = map->touchscreen->y_size - 1;
+}
+EXPORT_SYMBOL(ts_virtobj_get_touchscreen_abs);
+
+static bool ts_virtobj_shape_event(struct ts_virtobj_shape *shape, u32 x, u32 y)
+{
+	if (!shape)
+		return false;
+
+	if (x >= shape->x_origin && x < (shape->x_origin + shape->x_size) &&
+	    y >= shape->y_origin && y < (shape->y_origin + shape->y_size))
+		return true;
+
+	return false;
+}
+
+static bool ts_virtobj_touchscreen_event(struct ts_virtobj_shape *touchscreen,
+					 u32 *x, u32 *y)
+{
+	if (ts_virtobj_shape_event(touchscreen, *x, *y)) {
+		*x -= touchscreen->x_origin;
+		*y -= touchscreen->y_origin;
+		return true;
+	}
+
+	return false;
+}
+
+bool ts_virtobj_mapped_touchscreen(struct ts_virtobj_map *map)
+{
+	if (!map || !map->virtual_touchscreen)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(ts_virtobj_mapped_touchscreen);
+
+bool ts_virtobj_mapped_buttons(struct ts_virtobj_map *map)
+{
+	if (!map || !map->button_count)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(ts_virtobj_mapped_buttons);
+
+bool ts_virtobj_mt_on_touchscreen(struct ts_virtobj_map *map, u32 *x, u32 *y)
+{
+	if (!ts_virtobj_mapped_touchscreen(map))
+		return true;
+
+	if (!ts_virtobj_touchscreen_event(map->touchscreen, x, y))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(ts_virtobj_mt_on_touchscreen);
+
+bool ts_virtobj_button_press(struct ts_virtobj_map *map,
+			     struct input_dev *input, u32 x, u32 y, u32 slot)
+{
+	int i;
+
+	if (!ts_virtobj_mapped_buttons(map))
+		return false;
+
+	for (i = 0; i < map->button_count; i++) {
+		if (ts_virtobj_shape_event(&map->buttons[i].shape, x, y)) {
+			input_report_key(input, map->buttons[i].key, 1);
+			map->buttons[i].pressed = true;
+			map->buttons[i].slot = slot;
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(ts_virtobj_button_press);
+
+bool ts_virtobj_is_button_slot(struct ts_virtobj_map *map, int slot)
+{
+	int i;
+
+	if (!map || !map->button_count)
+		return false;
+
+	for (i = 0; i < map->button_count; i++) {
+		if (map->buttons[i].pressed && map->buttons[i].slot == slot)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(ts_virtobj_is_button_slot);
+
+void ts_virtobj_button_release(struct ts_virtobj_map *map,
+			       struct input_dev *input, u32 slot)
+{
+	int i;
+
+	if (!map || !map->button_count)
+		return;
+
+	for (i = 0; i < map->button_count; i++) {
+		if (map->buttons[i].pressed && map->buttons[i].slot == slot) {
+			input_report_key(input, map->buttons[i].key, 0);
+			map->buttons[i].pressed = false;
+		}
+	}
+}
+EXPORT_SYMBOL(ts_virtobj_button_release);
+
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for virtual objects on touchscreens");
diff --git a/include/linux/input/ts-virtobj.h b/include/linux/input/ts-virtobj.h
new file mode 100644
index 000000000000..5f9d0059451e
--- /dev/null
+++ b/include/linux/input/ts-virtobj.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#ifndef _TS_VIRTOBJ
+#define _TS_VIRTOBJ
+
+#include <linux/types.h>
+
+struct input_dev;
+struct device;
+
+struct ts_virtobj_map {
+	struct ts_virtobj_shape *touchscreen;
+	bool virtual_touchscreen;
+	struct ts_virtobj_button *buttons;
+	u32 button_count;
+};
+
+#if IS_ENABLED(CONFIG_TOUCHSCREEN_TS_VIRTOBJ)
+struct ts_virtobj_map *ts_virtobj_map_objects(struct device *dev,
+					      struct input_dev *input);
+
+void ts_virtobj_get_touchscreen_abs(struct ts_virtobj_map *map, u16 *x, u16 *y);
+
+bool ts_virtobj_mapped_touchscreen(struct ts_virtobj_map *map);
+
+bool ts_virtobj_mapped_buttons(struct ts_virtobj_map *map);
+
+bool ts_virtobj_mt_on_touchscreen(struct ts_virtobj_map *map, u32 *x, u32 *y);
+
+bool ts_virtobj_button_press(struct ts_virtobj_map *map,
+			     struct input_dev *input, u32 x, u32 y, u32 slot);
+
+bool ts_virtobj_is_button_slot(struct ts_virtobj_map *map, int slot);
+
+void ts_virtobj_button_release(struct ts_virtobj_map *map,
+			       struct input_dev *input, u32 slot);
+
+void ts_virtobj_set_button_caps(struct ts_virtobj_map *map,
+				struct input_dev *dev);
+#else
+static inline struct ts_virtobj_map *
+ts_virtobj_map_objects(struct device *dev, struct input_dev *input)
+{
+	return NULL;
+}
+
+static inline void ts_virtobj_get_touchscreen_abs(struct ts_virtobj_map *map,
+						  u16 *x, u16 *y)
+{
+}
+
+static inline bool ts_virtobj_mapped_touchscreen(struct ts_virtobj_map *map)
+{
+	return false;
+}
+
+static inline bool ts_virtobj_mapped_buttons(struct ts_virtobj_map *map)
+{
+	return false;
+}
+
+static inline bool ts_virtobj_mt_on_touchscreen(struct ts_virtobj_map *map,
+						u32 *x, u32 *y)
+{
+	return true;
+}
+
+static inline bool ts_virtobj_button_press(struct ts_virtobj_map *map,
+					   struct input_dev *input, u32 x,
+					   u32 y, u32 slot)
+{
+	return false;
+}
+
+static inline bool ts_virtobj_is_button_slot(struct ts_virtobj_map *map,
+					     int slot)
+{
+	return false;
+}
+
+static inline void ts_virtobj_button_release(struct ts_virtobj_map *map,
+					     struct input_dev *input, u32 slot)
+{
+}
+
+static inline void ts_virtobj_set_button_caps(struct ts_virtobj_map *map,
+					      struct input_dev *dev)
+{
+}
+#endif
+
+#endif

-- 
2.39.2

