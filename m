Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01747328E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245011AbjFPHaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbjFPH3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:29:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B782296C;
        Fri, 16 Jun 2023 00:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DImIAe7RxSnJgJA3HAKB9iMLe3G2IfTLAiL5KA8xUBX63HLPa2Hf8Y2rSjdgHeP3805mPRbFZrbUrMQECEFSm7ZT8jTz9Nc9pAROYxECNIQKbJbLW2nMJm2u6c0WFO1SEpEFEWbLLfbRVPvuBq/fHzEBLhmaeYXpfDXxiWqyzwguTHW2mioLOHYduQ5edJqqjUUjyylyuNSuA0kt1U8IedztVpL1nMdApqK0WAdCfDgjW7zHlo8kpQUhAK1pQNH4eCZ9/DK2IPf733/q9+eQ5AuXXvZfL+wmg83O8K9WykBf6NNEjWf/cPsXVXZK889mzU3kDsoex2A0A1nk3S/fdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZoO1BOL9DgnvOveaky/g3h+zoxmJJ/Fo2vXBEea9P0=;
 b=JUTsMOlrK/C3m8LOepcrFle9mBRY81T5d2CADbsTJetw/7L1GMTu/DZrd0UBv9wk6nABohUx7FmLSoT11cc6TLXvuwOqx9uJ+C/HnTbqrv+md1/yQiIPxFPDaJI0pjWjAtkAENZBXkJHUMugUHbD7dnMBZSealuPHbolquTRBVMGQS7RnJqaQ/iHDsL/far7GynxDcinwpUqSD2fJYEJnSAOSzrY6blGgTSXPy2pEzg2+YTfndxCi5IICYDplk89VtNXpE64HxHcxFMdcIDmAjtW3/JWn8SZA2Bd9tNMR5HDu66FNyivuYHlqnnmonzPL2yqPfFZjOf619pBclHNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZoO1BOL9DgnvOveaky/g3h+zoxmJJ/Fo2vXBEea9P0=;
 b=v24uhm8iJW+DThZy257H5mfbqwZTY2fdaYVgLqcBKu1FxrpsEbILkx+PS8QhyIqTboFsbQMo8INXbgZ/6VPFk43i8YWDg9i2qD598B0kO5W2BPPy9OsR0uuyVB7fJMyoXIH3dreHG7Mu+qJzEy3j5r4fez+h3CHpVBSZMVgAP2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV1PR08MB9916.eurprd08.prod.outlook.com (2603:10a6:150:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 07:29:10 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 07:29:10 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 16 Jun 2023 09:28:51 +0200
Subject: [PATCH v3 1/4] Input: ts-overlay - Add touchscreen overlay object
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686900549; l=12899;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=tlZJR0Nq53au4WcWFP/JGpj/86S4CM5u3uJYnsxte2M=;
 b=827nGfSzY4c4x/zjOH+BtHaeEq/+9Xh91NUVmtXyxbM2B2TPDp4wS+B7U6aW6pP9KnI+LFgaq
 RPvx1fKvUJSDIb3ZpYhh8JO+V6L/iq11DbcGZcLJ3F7pFJKzINj5OEB
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0197.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV1PR08MB9916:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d3bc74-163c-4cf4-f87b-08db6e3b6006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iH++QW1ZrApgWYOeRHDMjuUJP61Nn/Zpqm68IFVI+sqyhkqSQHuWL/3mZq3toJWT3UVCBDDwXVP8QP/YY06ODwxy4fMoXaMduNsurU+JampvASgCHscoCEHdGb39b38pfCoXSINUi1AzT6Tpkm2BmpREBQ6dmDM0EP7wLXkgt90p73QeigmLUIMIS1jNoSdWoO5gFNliugQYi8Th7N1GeQkT5F6fZjjQg+BU/XgKha58aRF7Mq8QuAivSbvyspTblhrKzN3xa0mf+CO6nY73IgqzuadoxwxqP/pREt7PNyuv27CU1TxnllAUF/9MM67FUqGu35Df7u5l6NA8+NKYElIF2nYufVIiBxIqJVJ01LadMTD3lZt4jwjgmifZUH0SjKxrqwk38ym7E9JJ/yPwPCV8NMjpDLsa3Um4VxBzQPkpb5MKE0wjxnte3KSB/rH3mv+mPz+j3PmmIpmfFEc7bXic3Cszs1LyGmxZYURRDfZn3h2KhywRTq7kBrVgtGC468JtutacsfUj/wTPApfGIz5JpmHJceA9NUuJ79QTgw3NYW/FmWZQKr7VyYS18PQwMseqqoB0ottp2Jqh7v4nVToOwpD5TuZDyouVgmOVV8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(36756003)(86362001)(30864003)(2906002)(44832011)(83380400001)(6486002)(6666004)(186003)(52116002)(107886003)(6512007)(6506007)(26005)(6636002)(66476007)(966005)(110136005)(316002)(41300700001)(38100700002)(4326008)(66556008)(2616005)(38350700002)(66946007)(5660300002)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVF3WFpncmdhci9XbWdJRElkR2Q3M3lWOUovRU4vMlBpd1FITTNFcGFvaDky?=
 =?utf-8?B?K2tydVVadTBmMElxY083Tk5ZM2N3VzBKUnNQeHhlbHdjWWRmbzZYa3BPTllH?=
 =?utf-8?B?UkoxT1Z6RzZqbkhRWDhtaWt6U3BxbGN3aXZNMWpMVDF1N09pS1VKbnJpRTE2?=
 =?utf-8?B?MnpuM1NJM1Ywak9iaEFmSi9McGNsYXV4VzJlVmRtRUNVWk00NnR2bDFEQ0Uz?=
 =?utf-8?B?cTlEWmJpQ0ZQd2lpSkpzcE9wTy9VWFNzc2xOVHErYWFRS1ljR0g3QXA2UjdB?=
 =?utf-8?B?RE5USFROSUdpejZab2pNU2tOMEN3Y0pCVVhsaERId1F0WjJHd3lVaFlUbDho?=
 =?utf-8?B?R3J1bmpSQlQvTHhGMHlSOVhaekpKcUVjT2NGUCtGSVF0aW84dFFWblZKYW9R?=
 =?utf-8?B?Y2Q5NlBmVTNiTVA3RFJqMThFeUF3MDRyMGR2RlhNcUhJNHZBUW1SQUR6bTZj?=
 =?utf-8?B?UWwxdXZJWnRER3FnWTVLNDVPRURVTW5CeDR3R1pJWkp2UC9MUVJQNWFCUTMx?=
 =?utf-8?B?bGxJUDlmWU1aYTdCbXptU2F6RzNqNHIrS3dpT0kyOEFjUEQ4eVc5Uy9NWjN3?=
 =?utf-8?B?anl5RXhTbFBleDcvMGY3OFFtbVJMZCtjZkZyZHNPTnNYenZWQWp0VGdBNG9k?=
 =?utf-8?B?TUgvTUxqSW1hdk1vRG8va25LbkFnellwc1AreHpxdXVOalR1QnhNcVQ0U3dl?=
 =?utf-8?B?dC9iMTluTm5tb1FEWGFKbDFnUWxHZlJETEdHRDU5eGpWTGRJa3VIYW5FUk5O?=
 =?utf-8?B?WHdjRE00WXoyZ1RUQ29MYno4UEtmc1BMZXdoLzIrL1Q2cGpHQk1CLzQydFNS?=
 =?utf-8?B?c2plbmhRNDhqa0ZJTFZJZUVkOEZDUXBxbkNhdWk5TDNNMm5oWmhqTTl3eGN6?=
 =?utf-8?B?bjBSTVZoMDlXWWdiS2REaXQ2SGY3YXJLSTByQVp4OGlWQ0lhY01mb1UvUHZ1?=
 =?utf-8?B?ejNlalV5YndyTlZqdWtsU3NERHMvbURSdDhEQTIzajJOUWVQU0ZkZGdydXNh?=
 =?utf-8?B?UXB5ZEs2a1VqWllTQzJqY3VYSmRJQklnVzMyL3JXNzFFYnN3SGFMN25FLytH?=
 =?utf-8?B?bmpnRXpDQWYzeVZCS3QxKzVqV3B5OHMwTXpmd2tCMnhPVUNtMkVzN3prTEky?=
 =?utf-8?B?S3ROU0hTSy96T3l1MjJzOWVKZE5Ld0JJeTl1QWhGZS8yeTZtR3VSc2ZQektH?=
 =?utf-8?B?UERxWFJwcmYvUHRBY1lJTUEzOFd0enlJMUtoQW5BOWJ1WEVYK2dCOTNzVTc3?=
 =?utf-8?B?ZzVTWUNTVVFEYVgrMjhnV0ViMjRCNmo2aTJ5ek1pY3cxZ2Zqam9xM0pmaEYz?=
 =?utf-8?B?REV2c1Nhck5SdG9yZXBwdmVHUDhxdEZIbUNMaTlCdThFQWlKVUl0bDhYMm9r?=
 =?utf-8?B?MGVxMnRPN05rb1ZXdDU0VmhyQ0FPNi9LZ3dNVFhwbzNaMHZxTzN5d0NXZzVW?=
 =?utf-8?B?MDVYelE5WmFqRnVseTh2KzJBaUo5a01peGQ0SndTY0RGaTFFZjFScDFCb1By?=
 =?utf-8?B?dUY2YUZOQVhjeXZINzljNTl1MWZGK1R6SzlWUHdJYzlnbVlFb2dNVFdSMXVC?=
 =?utf-8?B?UmlFZUU1eERKQTdUcjhpdnlXall6R24wZjBNQ1NMRURWSUpEZ0dXenc1dkpa?=
 =?utf-8?B?OGkzRUp2RFRLeXNwVlFZV1pYQVFsbG9RdFVzN2pTazQ1V0lVL0VhYXhBUUdK?=
 =?utf-8?B?RXZkOVY3cURKMkZJblRCcTJFVXhkUlpHMGlGTGlrMWc1TTRNeEtiRUtwdlVm?=
 =?utf-8?B?eXEreUpwZ2N2TllRRWNuUFJFYmtyTkVjdm83UGdwSHVFRlNhdm9pYnBWeHFq?=
 =?utf-8?B?ZFg1RlE1R1FTY1E4VUR1eVY4MmJPemxBNkU5WjNwQVdlRXJOQWhKekVBS2or?=
 =?utf-8?B?U3h4QmR0TEN1VGs0Z1F4K2o3clExYit6ZXJmODNtc0d6TU5CZ25nekRNSTRT?=
 =?utf-8?B?UDVXVlh1b2JYVS9CNE1zdzhrRG4wOVQ1K01RZUpqZkw5UXpwVHcxMDhURUlK?=
 =?utf-8?B?c3ZOaTJaYktqZHhBNU53TlpJWlB2QUtvdWgzUHYyWDVzTXNpblRtTE9VUU55?=
 =?utf-8?B?d1NsMzh6UkJTMEdzRDE4Z1RoeDV6VW9INHBNcnhlUnMyZndsbnVFYmV5ditW?=
 =?utf-8?B?SUhkU0xxVVFzK3N1QWVvR2dQZWZlaEpsT2RLNHB3eTdtU2orSXkvUDhWbGMv?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d3bc74-163c-4cf4-f87b-08db6e3b6006
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:29:09.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTgbeWmIYVjumNZQysVvbu4gyG9OYu5O7EGEOWThgQmQsGZOcYpwmxzKTQ1lMK2rHQw3/wgpr2y4GdnwxLDSKisEtk/Icg14dfRZ9mF8x9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB9916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touchscreens provide mechanical overlays with different objects
like buttons or clipped touchscreen surfaces.

In order to support these objects, add a series of helper functions
to the input subsystem to transform them into overlay objects via
device tree nodes.

These overlay objects consume the raw touch events and report the
expected input events depending on the object properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 MAINTAINERS                            |   7 +
 drivers/input/touchscreen/Kconfig      |   9 +
 drivers/input/touchscreen/Makefile     |   1 +
 drivers/input/touchscreen/ts-overlay.c | 356 +++++++++++++++++++++++++++++++++
 include/linux/input/ts-overlay.h       |  43 ++++
 5 files changed, 416 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..db9427926a4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21434,6 +21434,13 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TOUCHSCREEN OVERLAY OBJECTS
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touchscreen/ts-overlay.c
+F:	include/linux/input/ts-overlay.h
+
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 143ff43c67ae..8382a4d68326 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1388,4 +1388,13 @@ config TOUCHSCREEN_HIMAX_HX83112B
 	  To compile this driver as a module, choose M here: the
 	  module will be called himax_hx83112b.
 
+config TOUCHSCREEN_TS_OVERLAY
+	bool "Touchscreen Overlay Objects"
+	help
+	  Say Y here if you are using a touchscreen driver that supports
+	  printed overlays with keys or a clipped touchscreen area.
+
+	  Should be selected by the touchscren drivers that support
+	  this feature.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 159cd5136fdb..f554826706ff 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -117,3 +117,4 @@ obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
 obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
 obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
+obj-$(CONFIG_TOUCHSCREEN_TS_OVERLAY)	+= ts-overlay.o
diff --git a/drivers/input/touchscreen/ts-overlay.c b/drivers/input/touchscreen/ts-overlay.c
new file mode 100644
index 000000000000..7afa77d86c1f
--- /dev/null
+++ b/drivers/input/touchscreen/ts-overlay.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Helper functions for overlay objects on touchscreens
+ *
+ *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#include <linux/property.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/module.h>
+#include <linux/input/ts-overlay.h>
+
+enum ts_overlay_valid_objects {
+	TOUCHSCREEN,
+	BUTTON,
+};
+
+static const char *const ts_overlay_names[] = {
+	[TOUCHSCREEN] = "overlay-touchscreen",
+	[BUTTON] = "overlay-buttons",
+};
+
+struct ts_overlay_shape {
+	u32 x_origin;
+	u32 y_origin;
+	u32 x_size;
+	u32 y_size;
+};
+
+struct ts_overlay_button {
+	struct ts_overlay_shape shape;
+	u32 key;
+	bool pressed;
+	int slot;
+};
+
+static int ts_overlay_get_shape_properties(struct fwnode_handle *child_node,
+					   struct ts_overlay_shape *shape)
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
+static int ts_overlay_get_button_properties(struct device *dev,
+					    struct fwnode_handle *child_node,
+					    struct ts_overlay_button *btn)
+{
+	struct fwnode_handle *child_btn;
+	int rc;
+	int j = 0;
+
+	fwnode_for_each_child_node(child_node, child_btn) {
+		rc = ts_overlay_get_shape_properties(child_btn, &btn[j].shape);
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
+void ts_overlay_set_button_caps(struct ts_overlay_map *map,
+				struct input_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < map->button_count; i++)
+		input_set_capability(dev, EV_KEY, map->buttons[i].key);
+}
+EXPORT_SYMBOL(ts_overlay_set_button_caps);
+
+static int ts_overlay_count_buttons(struct device *dev)
+{
+	struct fwnode_handle *child_node;
+	struct fwnode_handle *child_button;
+	int count = 0;
+
+	child_node = device_get_named_child_node(dev, ts_overlay_names[BUTTON]);
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
+static int ts_overlay_map_touchscreen(struct device *dev,
+				      struct ts_overlay_map *map)
+{
+	struct fwnode_handle *child;
+	int rc = 0;
+
+	child = device_get_named_child_node(dev, ts_overlay_names[TOUCHSCREEN]);
+	if (!child)
+		goto touchscreen_ret;
+
+	map->touchscreen =
+		devm_kzalloc(dev, sizeof(*map->touchscreen), GFP_KERNEL);
+	if (!map->touchscreen) {
+		rc = -ENOMEM;
+		goto touchscreen_handle;
+	}
+	rc = ts_overlay_get_shape_properties(child, map->touchscreen);
+	if (rc < 0)
+		goto touchscreen_free;
+
+	map->overlay_touchscreen = true;
+	dev_info(dev, "Added overlay touchscreen at (%u, %u), size %u x %u\n",
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
+static int ts_overlay_map_buttons(struct device *dev,
+				  struct ts_overlay_map *map,
+				  struct input_dev *input)
+{
+	struct fwnode_handle *child;
+	u32 button_count;
+	int rc = 0;
+
+	button_count = ts_overlay_count_buttons(dev);
+	if (button_count) {
+		map->buttons = devm_kcalloc(dev, button_count,
+					    sizeof(*map->buttons), GFP_KERNEL);
+		if (!map->buttons) {
+			rc = -ENOMEM;
+			goto map_buttons_ret;
+		}
+		child = device_get_named_child_node(dev,
+						    ts_overlay_names[BUTTON]);
+		if (unlikely(!child))
+			goto map_buttons_free;
+
+		rc = ts_overlay_get_button_properties(dev, child, map->buttons);
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
+static bool ts_overlay_defined_objects(struct device *dev)
+{
+	struct fwnode_handle *child;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ts_overlay_names); i++) {
+		child = device_get_named_child_node(dev, ts_overlay_names[i]);
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
+struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
+					      struct input_dev *input)
+{
+	struct ts_overlay_map *map = NULL;
+	int rc;
+
+	if (!ts_overlay_defined_objects(dev))
+		return NULL;
+
+	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
+	if (!map) {
+		rc = -ENOMEM;
+		goto objects_err;
+	}
+	rc = ts_overlay_map_touchscreen(dev, map);
+	if (rc < 0)
+		goto objects_free;
+
+	rc = ts_overlay_map_buttons(dev, map, input);
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
+EXPORT_SYMBOL(ts_overlay_map_objects);
+
+void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y)
+{
+	*x = map->touchscreen->x_size - 1;
+	*y = map->touchscreen->y_size - 1;
+}
+EXPORT_SYMBOL(ts_overlay_get_touchscreen_abs);
+
+static bool ts_overlay_shape_event(struct ts_overlay_shape *shape, u32 x, u32 y)
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
+static bool ts_overlay_touchscreen_event(struct ts_overlay_shape *touchscreen,
+					 u32 *x, u32 *y)
+{
+	if (ts_overlay_shape_event(touchscreen, *x, *y)) {
+		*x -= touchscreen->x_origin;
+		*y -= touchscreen->y_origin;
+		return true;
+	}
+
+	return false;
+}
+
+bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map)
+{
+	if (!map || !map->overlay_touchscreen)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(ts_overlay_mapped_touchscreen);
+
+bool ts_overlay_mapped_buttons(struct ts_overlay_map *map)
+{
+	if (!map || !map->button_count)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(ts_overlay_mapped_buttons);
+
+bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y)
+{
+	if (!ts_overlay_mapped_touchscreen(map))
+		return true;
+
+	if (!ts_overlay_touchscreen_event(map->touchscreen, x, y))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(ts_overlay_mt_on_touchscreen);
+
+bool ts_overlay_button_press(struct ts_overlay_map *map,
+			     struct input_dev *input, u32 x, u32 y, u32 slot)
+{
+	int i;
+
+	if (!ts_overlay_mapped_buttons(map))
+		return false;
+
+	for (i = 0; i < map->button_count; i++) {
+		if (ts_overlay_shape_event(&map->buttons[i].shape, x, y)) {
+			input_report_key(input, map->buttons[i].key, 1);
+			map->buttons[i].pressed = true;
+			map->buttons[i].slot = slot;
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(ts_overlay_button_press);
+
+bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot)
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
+EXPORT_SYMBOL(ts_overlay_is_button_slot);
+
+void ts_overlay_button_release(struct ts_overlay_map *map,
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
+EXPORT_SYMBOL(ts_overlay_button_release);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for overlay objects on touchscreens");
diff --git a/include/linux/input/ts-overlay.h b/include/linux/input/ts-overlay.h
new file mode 100644
index 000000000000..b75df0dec3ab
--- /dev/null
+++ b/include/linux/input/ts-overlay.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#ifndef _TS_OVERLAY
+#define _TS_OVERLAY
+
+#include <linux/types.h>
+
+struct input_dev;
+struct device;
+
+struct ts_overlay_map {
+	struct ts_overlay_shape *touchscreen;
+	bool overlay_touchscreen;
+	struct ts_overlay_button *buttons;
+	u32 button_count;
+};
+
+struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
+					      struct input_dev *input);
+
+void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y);
+
+bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map);
+
+bool ts_overlay_mapped_buttons(struct ts_overlay_map *map);
+
+bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y);
+
+bool ts_overlay_button_press(struct ts_overlay_map *map,
+			     struct input_dev *input, u32 x, u32 y, u32 slot);
+
+bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot);
+
+void ts_overlay_button_release(struct ts_overlay_map *map,
+			       struct input_dev *input, u32 slot);
+
+void ts_overlay_set_button_caps(struct ts_overlay_map *map,
+				struct input_dev *dev);
+
+#endif

-- 
2.39.2

