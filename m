Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638617030D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbjEOPBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbjEOPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:01:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97397212B;
        Mon, 15 May 2023 08:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLBPe8mkI5QvCX1plCNO2906o10akskIpg8w/a/rtimDvUs2cZK2ucJpunVqsIKXLKUkLmSynj7KsORp9gYhvg2AM3sROi+EzNgPvmfnEdW2tMbuf91QyJAl6pl+RUwl1MYeUhtZmQu87fjhT3lqvqSLdvqBnpdbbzMCew3Y3YPXdbmZ9sVfVTxP9DU3Eqx9OPtqotRLpf3r7PH/iuNeLcYrCEkaTVQuzsxETOrF9to3gKuHWf4EVugNgY999JW06nt9cmd00ztgjOst2SBeEMbj93IlQ/1geyXC+yZN/FPjV+MSe5Py22SNeZ/MIKEN1UpPj/IcWywm3zk5XVXGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYToyZ0+i3E3hnhG8uBYcbo72aC37etu9afp+sPnR1E=;
 b=RMZp57B9gb1l2YjVOaLJVwxUR/LbEJ180e488630LiNkT91dmbfCbqCcW2X3SHJz7FVXEB6qDD94FkoGPuzrME3pP7gZ4SphKAmnGyrdui8VnP92nchNe4VVZfI51lwh9lOQTKbBsSzs00i3mcPpK3DXptFn0qRlr4whNKLrayJ+mHiEeo/9+HjUzjcR1FBgh7Rn1Ta5fOb8gn0+UrAIJgXPXue11gDIpMc5kyZl8IMntyGoV6LrgzuOu61NuqV+jah2oNT09A3eDdrCoWi47elSbps6ycofjusI7+1GnF8ue1N5e9pDPzp//IVvx+ElupqpwHL6MgoefKLpOVZubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYToyZ0+i3E3hnhG8uBYcbo72aC37etu9afp+sPnR1E=;
 b=gcXTk27c/niFNUsCirr7VgQ7y4W9u7t8Lt+m5M8c6qYlyFVtBtabUmTlFkU1fDRW4oOkkGdaD66Dl3r2uZfc3zz5g1QbO9zNi4cCaFIjttnUZotQRMvMouRVIc+8peX+CbE1iwmDm9mvAGvL9U9Hq895HwnpjcpR7FwUD3smIh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB9982.eurprd08.prod.outlook.com (2603:10a6:800:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 15:01:06 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:01:06 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Mon, 15 May 2023 17:00:58 +0200
Subject: [PATCH v2 1/4] Input: ts-virtobj - Add touchscreen virtual object
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v2-1-f68a6bfe7a0f@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684162864; l=12903;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=jSKDHg8ewhTwMLA62fQ6dNqfEgjqCy3qsgeiLccQLgY=;
 b=PtWogpeXfR7xGbsSEs1/jMCAr6gDy0q/8ZB6fyJyKsx/kdbF2L5uhzBy+pKDibI9tiIjzyubL
 bcQQpcoxgoyDXRbG+uMBa/9iylRSo4XRTFg2++yTIet9Y/ane6Y8dXw
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::28) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: a10a2b8a-6443-4756-4865-08db55553501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYeigci8pr+v63tpcHlm+7RF+kbi/BSZRbcgy2aBpmZd4/YMklmA/VuvSFFbmpkoaHbrtN5dClV5LCZewu+3/VjP3nWVwZtQR6qmb1G0TK110SBko0EGBVu087qsnmSBUiB4Ip7DTIkSc/PBd+pGDHtMCViicwa9oYjbbauLX/gSFZpfCDqHUcBHRTrYCspwiITYg/LoPaXWQNg/D/M3iCjl9dNYAwje7BbLDAU5A0KCnzVs+6L+Ualmva9Hsw7zTkIrqnt5YwaZg81BmPwR4kBUPJSpJAf0yIbYMECDgrujjivzo8SQVhpN/w1epoDlj8wFdeGUIpm0keLVAk0gTDbXNvTAEJOuANKJgE2g8iF8P80eBw2RYAcYk8QI6AgzpeLpeyxr6Ayn/DwRhQUAiVPAyOrl70t9NtZsyjv+bIpEh37k7CVDXR6qcD+u5iNuePN2oKbVs4l18w4mJB7HzP/nQjnw+nH7muCSsiVQdae4C1RCN0zD6KBZAlLTN/t//uN4yJWJjV5vn+ODykpOjKnxZn8Hc4LWztuU0O2Dq9t/ZmZs3L1YSmMBkYMfEBBcCVxp3FR1F1qfnWznIl1FdRXqhbvPBpYRbTk8dOVySBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39840400004)(451199021)(478600001)(2616005)(86362001)(6486002)(83380400001)(6512007)(6506007)(26005)(186003)(38100700002)(38350700002)(107886003)(36756003)(52116002)(966005)(6666004)(110136005)(30864003)(2906002)(66946007)(66476007)(66556008)(5660300002)(316002)(6636002)(4326008)(44832011)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlptZHc1VWc4ZUF6Qk9WaCtybDc3Y2gvSzA4azZLNmZWU2g4Y3RtZmNwaXZM?=
 =?utf-8?B?ckNNbDJmS3hUSVlPcnJMVUl2MVhMWHhBVnZRQ2JzN2dQWmFvZmgzN3NOdWdQ?=
 =?utf-8?B?NkpUNkNhZk54aXlIQTlsdFk1TEJxa1dHRUNQU3JmNkJ5WXJ4V3pjTGVJK3hh?=
 =?utf-8?B?L3VFMmlwVUo4YlVDTi96S1pBVWZJb2ZpS1dWVmNqT3hBS0JaMEJubzM4a2dR?=
 =?utf-8?B?K3d5UWx4YVpjQXNsVHM0ZERjMnh5Q2dlbElEa3FuMWc4UENLdjBzOStGOFlx?=
 =?utf-8?B?SE5lNWZ2Z29XeXpIV2tpMUg3Z3VCQzY0MVh2WDlrYnBzazFaanJ2Mmgzb3pF?=
 =?utf-8?B?WU5CVEFtcW5uVTdvOEdQWENWQm9GaWRTbTVjRjNKejlSaWwxclcrN1hQMkFu?=
 =?utf-8?B?c29STE9iRzNUMTJVWTcyWXY3TWM0bERUYjNPQktkK2Nuekx2T3k5TTV1QkZa?=
 =?utf-8?B?UkF3V2d0cGtjV25nSFdKM25QZ3lDTjE5VXg4YlpRdzVZb3BpMjN5bHdFdWFR?=
 =?utf-8?B?RWlKTDJXb3poTVBoWGl4NWhjaUNReDNJOWdxWDY0c1cySU1aR2RPNEplMUpY?=
 =?utf-8?B?eWF5aFUwS3A4UHhjcGhsdUdPcnZUcldWWkZDaDQ3a3JUdnhkVmxxSTNPeWIw?=
 =?utf-8?B?MVZqdWw2Tll3aVl1SEZtWW1CUnpRemp4TVAvMXV4TzBMZVV0Tzg5cEh6RHox?=
 =?utf-8?B?YmNEQkRQUEd3cUdrTjRoVUx3MlBMNVZXdjFGMzFaZ3hHOThoQkRlSWpIUTk5?=
 =?utf-8?B?ZWVGMG5xekNpMWJ4aG9uWS9FRTNxRXZrVUVvL0JGZEd0N09rakpSM2o1T3dt?=
 =?utf-8?B?OVhJZTlsMEg0OXJMalhPY3JSajJDRmhQTFgxWnJ5Z1dYUUFvWFRrbVArTlVv?=
 =?utf-8?B?eXYrVFFNOC96cm1lSEpTRTMxbW1YQUJOVGRPWDd6UldUUlVhV0lUZFJmQzlV?=
 =?utf-8?B?WUg1UFYzdTUrUUxlRS9rRzFWVGM0ejlLcW9LcmxiZFFjZHU1c2NjSGhCcncz?=
 =?utf-8?B?NHA4NTBycTlvbG5mdFN6TUZkT0RydFlNeEJDTHVYckhkNjZzRlpxa0RCTUg1?=
 =?utf-8?B?cW9RMjZERWkyVHpjS3JzbmdpNGt3MGkvU3pxTjVhb0licXFYN0ZwMUdoVThk?=
 =?utf-8?B?eFJpeWpWUnp4WHQ3MG8xWFFkU1ZPdE1BbDhQTUtxLzNvU2E4VDMreTB6YlY3?=
 =?utf-8?B?aFZGbGtWZHpxSC9RNFNkdHE5TFpBa1RPN1dmZTFtY0JWeUEraHVSMnMwZ05N?=
 =?utf-8?B?UkJJR2lnM2FIQkN6Z1pMcGI2L1MySmRMbHN5ZXNGMXdmd05mRHR4VmNwekpw?=
 =?utf-8?B?eHNBcVcyeEUyUmRZdmxwc0pPaEZ6bndsSDlPbWd1ZGZBbjBCanI1d0Yza3J2?=
 =?utf-8?B?MlZxUU04SER1VGU1UEZGTFNmMFR3NkVmTVUzekJqQU9tWmtvT3Y0UmJMdy9E?=
 =?utf-8?B?RmJEeWUwdGdQa1B4OGluWldIV1ZnRDlJcHZ3YTRuU2VacmpXWFd5N3VQbXhE?=
 =?utf-8?B?WjJnd0RVYTY5c3RReHgrenEyVkY1NnZnRmxUckdicGZENTkxNjVzeEpRNE1Z?=
 =?utf-8?B?MVpSZklsS3NpT3VHNG8rRXBQUm4yeEFMa1VzU3QzTHNCSXNpWXlLQ3hGRHZ1?=
 =?utf-8?B?TjRHNFRzMllKTjAxdFRMbTVUdERuVVp0SXdneGxGbCtzK201Wm9yYkxXeDQ2?=
 =?utf-8?B?MjRaajdzQXRPQ2JFaVdKcTMyWm5Vc2U3a0Z6eHZiVkMwQ1ptWnZKZ05Ba1Bk?=
 =?utf-8?B?b2hWK2lxYnk5K2g5dHFDNFdkRlRsWjNxc0d5WWkwMjkrWWh5WkZRdHExam9T?=
 =?utf-8?B?dUJRSTBvNDk4UEhsQzczaGFOUzFocHVZZHhaWnVtbFJaeW1sMVR0Nk1rdzlL?=
 =?utf-8?B?WkVKaWVLaTg3WEFYeFlUV0Z4QU0wNWE4aXpsRG5nLzBWY0dNQktidjZuNVdq?=
 =?utf-8?B?K05KYkg4V0d5L05IanhlcDRUb21XV0Z0M0RXRDhlOUFCcTU2MnRib1BGVFJl?=
 =?utf-8?B?RUhiUGhxNHR3ZTZTZ2w2MTR1cG92cWRqeWVkYW4rWDRoUk9YTC91bWpGbDBS?=
 =?utf-8?B?cGJ2WEVIREhuUTNqNC84UnpscVF3ZlRCTEJuRmtUcEpJQjRWUFA1TkNwKy84?=
 =?utf-8?B?KzF5Q2dTdUVRZWVMYWhMajYzZGE4YWtWYTFvY1M2NkhaMnJrdGdFU2N5bVho?=
 =?utf-8?Q?9gnr18seMecUeO2lwuBDUso=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a10a2b8a-6443-4756-4865-08db55553501
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:01:05.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k08OnY3bDGb80PS6VCu/D6er0MfkTL4GFrTVQMhOR6osL1+JjvqaAVJ16zHzpA13NH627Bdzi4aRa5fr8I+x9d1acn9ssae9keZ6km2GKHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/input/touchscreen/ts-virtobj.c | 356 +++++++++++++++++++++++++++++++++
 include/linux/input/ts-virtobj.h       |  43 ++++
 5 files changed, 416 insertions(+)

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
index 143ff43c67ae..0bdbe0a77b34 100644
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
+	  Should be selected by the touchscren drivers that support
+	  this feature.
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
index 000000000000..07e5611b7b3d
--- /dev/null
+++ b/drivers/input/touchscreen/ts-virtobj.c
@@ -0,0 +1,356 @@
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
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for virtual objects on touchscreens");
diff --git a/include/linux/input/ts-virtobj.h b/include/linux/input/ts-virtobj.h
new file mode 100644
index 000000000000..f221b46c4d09
--- /dev/null
+++ b/include/linux/input/ts-virtobj.h
@@ -0,0 +1,43 @@
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
+
+#endif

-- 
2.39.2

