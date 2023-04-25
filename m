Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA306EE151
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjDYLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjDYLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:51:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BD44200;
        Tue, 25 Apr 2023 04:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihR/0S5O8hX3Yppp7shwsyVQSSJynb/0PxoTCIoOtwyfvju3myZ3R55yrH5IMONYFHwk7X+4/K6QHZbhNELChVzi7atmRMv8PWSpNEtjAN+IhnPpbKys1tgTyIDhoQQkdc9gtUXqqOhxir3WR8Bp21WIga6dyLJwnAbGx2mshLAfw63REdOpxYUaJoxU0QVA87Ie3oaWjzQUPDU/3aYpFKyCu1FD2gePAMi5MopjQo54VZcr5RuFcPafSxNpnGv0y7a7gryHJBFohHtyaxE6A/QOaW03LFqXUnW1D0ptQGfokS2c4nfB3MKbDom9/WtUTbgST6lsb7EmO9kswq03gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mILccMTTzS/vZ9Zv1t3NwyGbE1X8hbGefC4Yna5xN8Y=;
 b=NHXtV0jUsG0RTW+KH5uDhIw71zskWxfsqVVptQYphR8/G3MHUqVORIJCM//SVHXVRUG0YLdZ1R5WkRtM+IgDQuUaRHM6WuZGJAzPEU9G+KS+rvfOc1vlQTkzsprdsObT7N9vbiYwSt9LOfipNdfYlDyukOcWwEIC0M43lFwYEDsB32jyMDpPx8yMy334pQDxY1gLKsREQtxL8N4iLw580pMMgmMZHbKPpGmdWAWLLg3yNw5t5ahn4QyoID1Qa3IpsIYVMzY4UsfPs0FoKEbibV7g8lTe4+3j28bt0ZeMlqasvONzYdnFxYYCrnmt5qpiiyCVY0phqhgcUASHQsdrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mILccMTTzS/vZ9Zv1t3NwyGbE1X8hbGefC4Yna5xN8Y=;
 b=UkTPFtlFZEr3g50rhunkjOBGl3a0pIRCFTrDUN7dN+DH7oGdxWX/qLp0HktES6OueQIrkB3iskG/JEGvkj8RK9fWXR0FtElHz9wLPKPmmX9n6sH2voB5drclIwtw683ZjLAXRPtEFBxF/oZ3UGIjNI/MHzq/ETPG66ptCN8kZQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU2PR08MB10203.eurprd08.prod.outlook.com (2603:10a6:10:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 11:51:23 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 11:51:23 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [RFC v1 1/4] Input: ts-virtobj - Add touchsreen virtual object handling to the core
Date:   Tue, 25 Apr 2023 13:50:46 +0200
Message-Id: <20230425115049.870003-2-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU2PR08MB10203:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f64fdec-d064-42c3-8ef7-08db45836412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2Pi0Q2QuCz9CWYEUr50hpDTx4juFJsV+RGdhqVtfTK8Y2kdMlObwWDLO3NKTVfg+2jua8XcxGzsmp5Jw9OWTGn+2lIrR4L3xplBq5bDd8Ll9DrqoSUzmeMd3Lg+HAwh/ar+EpIPHhewcfIvdX/YsW4tKakQrlsjZRyp17kCxUVnY9Er2GvlJANbAZ9UdhfKmbC2/Dm+fingukaI4JKzSFKDgVrrkErrAel8h0uV945qZTCz3OMTCwzIVZk19NfgAOATsbf8kTwKekW5BnR4QPqtiBaCh1eT9+4uR9RvTkOzvukIXBeJyqSpccBiQ1NP9YxY4rP0cEKfcqF8g1R8qo8FFnvlxAkFLqW6ty2fhCFDDg3FSy1rAy03o5Nr13LEIP8s3X2P3ZU5wcLN6WTuKnGbgN3eUfWie8CWi8P0LOp2E+Ku+tcgo4+W3FM553MFHOFl69O7LJXct4+uTz1praqSt7aa7oYXHby5z9h4eZhNXJlLtFveFjsXqIgUvjYjDXQPxERXzoCXRcPAhx2UnFVGjArUIcvlBmost5nVr1qApAdcP5UeVp7Ja4rDy9hOwNQGkAlvpmMW6Yg0I/O+/SmMXggijcdLXU5R+AhbEhZpvsKV1IOwE/0U0V+j8e6Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(366004)(346002)(396003)(136003)(451199021)(38350700002)(36756003)(8676002)(8936002)(54906003)(478600001)(66476007)(66556008)(66946007)(4326008)(7416002)(44832011)(316002)(41300700001)(30864003)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(26005)(6506007)(6512007)(1076003)(107886003)(52116002)(6486002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B32AjecXpPxk1YCmtfjFxiQA/h4ZzVqQqNhksDftwllKNhXmdSygYElubBOt?=
 =?us-ascii?Q?1XGGpE1oVKmlg00Jhzxm9MPPMQId+B82x6fYRqapzMBj55PLUsID8JaOIpR0?=
 =?us-ascii?Q?ulvSe0b3zmsoTfiq3rvloydpykUzluDU5vG8iZ2q/fzWLBWtzRSJ4YtejbkY?=
 =?us-ascii?Q?ts/wwU1QpxPH9zv54nntNYf6TF3B6MtgKZnk9wTGLWHnG5b0H/IozX5bEmLK?=
 =?us-ascii?Q?W/0Ts6YYaE47xjUum34Q3AU27Ea77PCAVptlRUJ7wC/w/6azYDNL+bqCAFaj?=
 =?us-ascii?Q?JNAgGeRnCZaz7QqIHCL5LCc5oaJyfKkye6Q4+XSr1vYGdV9tZPMc8kZdEN00?=
 =?us-ascii?Q?mUJWXh+Vo8/t7emXlhPV7kkEV/tywKO+BO9+BRRrjBut5Dq2bR6TGnRkyEa8?=
 =?us-ascii?Q?gld68+XnBpB8Yz7if03XQxCNiaLbrDOitIDslh3glVbBcOf/PlNQOpczia8v?=
 =?us-ascii?Q?+z3Y8VAtMmxcy4wB8hY6nyLWGe9tD6lLbNhRZiu+sgx0TA2HA4FcRz44TLnS?=
 =?us-ascii?Q?13XelILQwZ1nhosIl/0GwZpxQpFI/qVTSm8hU4B68bKryn7+8GkitmZpqBYT?=
 =?us-ascii?Q?mzlHv1fvh+esB0Glc0NH0AqjsQJHtaB+90l3Wcp+mt1s2srrEpVF3jWXGuM6?=
 =?us-ascii?Q?FMbWuFSLM7EWjWFRQCBmEZ+0Qsmcsmh4Z2E4F//379yNaUucxHHeeNhMsVd4?=
 =?us-ascii?Q?dpNByvUs6X5speftLa2HS9M9qkXnSDvlqOQ1Jzt74orCww6klm9Dx9ZMioBH?=
 =?us-ascii?Q?45aiiy6e6zuq3s9Bj4yeYnl44d03oAABsddGV5A5QOA2JYoxr1gYO5iFBwql?=
 =?us-ascii?Q?6spSjwoFdNtPMShMd2BDJhS5G0+23y2vMfUrFYcMUM5Myg4Jp2D+Xwr4+nY/?=
 =?us-ascii?Q?0KksN8oEu6aIUYATQjiIXOs4BfHU9bnw2Qb+4udbdOOK3RR9bN1deQVnKjzL?=
 =?us-ascii?Q?BhdfjvhZ1w1F75l5oy1ZQ7pHsva0WLOdOOC+o1Mmd6D5SW4gTFrcadb0Gs2V?=
 =?us-ascii?Q?8O7UPMYXvfOxZwMdCeYaSjUZUsqjthHdAfWERqEUy87v2Gs+Tqgx2uoBxd0h?=
 =?us-ascii?Q?F5FXO8ihPZQIq7jKEreU/P5dbMWqu4Jix52uoGQqde+s5xFzqb7vB97rjsP/?=
 =?us-ascii?Q?FWKxuUPnJEIikWtd3vDZLogr6VmY72GOWqICWB2rD8kzVoRJDdemUb9wgh1b?=
 =?us-ascii?Q?IwYbERMocyjcO8twSUn/ndg2QxiouKoTfAOgNdF32qwNZ4Gqnp1vgXQzSF1U?=
 =?us-ascii?Q?3eoLet1/Drchd/pPHXqNQmiy3t+/HO0io4LfXc05v+Qeq6EKrbkdaK4ImHUK?=
 =?us-ascii?Q?SVYpTWZ9kkr2psf/I3Sxsn6EVuwJAEjybE1hoc4HxF08KB2qHaRzEYxIIqzn?=
 =?us-ascii?Q?z8BaN7M2eI1gCrdrV6/QNJeN1PjctpywODhLXSKSekou34uSMPPuB9jLSDGJ?=
 =?us-ascii?Q?klwQTbE8UO4qgh3NY1EjbMhLAWFcJPmkWitJj71byT8/XRFHSo1mqlS4msRT?=
 =?us-ascii?Q?sCzgYegQBq9TZsMDh2wAq9xlnpQz0ciINksXYG4sBKUggvt/XVRg7fYVB44r?=
 =?us-ascii?Q?Y8LmA0IjGnwh8rIoXC1R409J0Ql/R1V3qJ5TrnB7cdp6xVrIwTZtQ79tsZj9?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f64fdec-d064-42c3-8ef7-08db45836412
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 11:51:22.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhibLOWiKkYgRDlWezJWEtG8Gjudd8fyfC9+xOgtWSnB4evnh1rqX9O9Xmsf1QKXcmsn1pPBOn9yEz2jT2HvDvQZfegJXzKDG+mG7TWBR30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10203
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
like buttons or downsized touchscreen surfaces.

In order to support these objects, add a series of helper functions
to the input core to transform them into virtual objects via device
tree nodes.

These virtual objects consume the raw touch events and report the
expected input events depending on the object properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/Makefile           |   1 +
 drivers/input/ts-virtobj.c       | 305 +++++++++++++++++++++++++++++++
 include/linux/input/ts-virtobj.h |  59 ++++++
 3 files changed, 365 insertions(+)
 create mode 100644 drivers/input/ts-virtobj.c
 create mode 100644 include/linux/input/ts-virtobj.h

diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 2266c7d010ef..9c717e28719e 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -8,6 +8,7 @@
 obj-$(CONFIG_INPUT)		+= input-core.o
 input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
 input-core-y += touchscreen.o
+input-core-y += ts-virtobj.o
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
diff --git a/drivers/input/ts-virtobj.c b/drivers/input/ts-virtobj.c
new file mode 100644
index 000000000000..4bddd8015af3
--- /dev/null
+++ b/drivers/input/ts-virtobj.c
@@ -0,0 +1,305 @@
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
+		if (rc < 0) {
+			fwnode_handle_put(child_btn);
+			return rc;
+		}
+
+		rc = fwnode_property_read_u32(child_btn, "linux,code",
+					      &btn[j].key);
+		if (rc < 0) {
+			fwnode_handle_put(child_btn);
+			return rc;
+		}
+
+		dev_info(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
+			 btn[j].shape.x_origin, btn[j].shape.y_origin,
+			 btn[j].shape.x_size, btn[j].shape.y_size, btn[j].key);
+		j++;
+	}
+
+	return 0;
+}
+
+static void ts_virtobj_set_button_caps(struct ts_virtobj_map *map,
+				       struct input_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < map->button_count; i++)
+		input_set_capability(dev, EV_KEY,
+				     map->buttons[i].key);
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
+		return 0;
+
+	map->touchscreen = devm_kzalloc(dev, sizeof(*map->touchscreen),
+					GFP_KERNEL);
+	if (!map->touchscreen) {
+		fwnode_handle_put(child);
+		return -ENOMEM;
+	}
+	rc = ts_virtobj_get_shape_properties(child, map->touchscreen);
+	if (rc < 0) {
+		devm_kfree(dev, map->touchscreen);
+		fwnode_handle_put(child);
+		return rc;
+	}
+	map->virtual_touchscreen = 1;
+	dev_info(dev, "Added virtual touchscreen at (%u, %u), size %u x %u\n",
+		 map->touchscreen->x_origin, map->touchscreen->y_origin,
+		 map->touchscreen->x_size, map->touchscreen->y_size);
+
+	fwnode_handle_put(child);
+	return 0;
+}
+
+static int ts_virtobj_map_buttons(struct device *dev,
+				  struct ts_virtobj_map *map,
+				  struct input_dev *input)
+{
+	struct fwnode_handle *child;
+	u32 button_count;
+	int rc;
+
+	button_count = ts_virtobj_count_buttons(dev);
+	if (button_count) {
+		map->buttons = devm_kcalloc(dev, button_count,
+					    sizeof(*map->buttons), GFP_KERNEL);
+		if (!map->buttons)
+			return -ENOMEM;
+
+		child = device_get_named_child_node(dev,
+						    ts_virtobj_names[BUTTON]);
+		if (unlikely(!child)) {
+			devm_kfree(dev, map->buttons);
+			return 0;
+		}
+		rc = ts_virtobj_get_button_properties(dev, child, map->buttons);
+		if (rc < 0) {
+			devm_kfree(dev, map->buttons);
+			return rc;
+		}
+		map->button_count = button_count;
+		ts_virtobj_set_button_caps(map, input);
+	}
+
+	return 0;
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
+	struct ts_virtobj_map *map;
+	int rc;
+
+	if (!ts_virtobj_defined_objects(dev))
+		return NULL;
+
+	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ts_virtobj_map_touchscreen(dev, map);
+	if (rc < 0) {
+		devm_kfree(dev, map);
+		return ERR_PTR(rc);
+	}
+	rc = ts_virtobj_map_buttons(dev, map, input);
+	if (rc < 0) {
+		devm_kfree(dev, map);
+		return ERR_PTR(rc);
+	}
+
+	return map;
+}
+EXPORT_SYMBOL(ts_virtobj_map_objects);
+
+void ts_virtobj_retrieve_abs(struct ts_virtobj_map *map, u16 *x, u16 *y)
+{
+	*x = map->touchscreen->x_size - 1;
+	*y = map->touchscreen->y_size - 1;
+}
+EXPORT_SYMBOL(ts_virtobj_retrieve_abs);
+
+static bool ts_virtobj_event_in_shape_range(struct ts_virtobj_shape *shape,
+					    u32 x, u32 y)
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
+bool ts_virtobj_touchscreen_event(struct ts_virtobj_shape *touchscreen,
+				  u32 *x, u32 *y)
+{
+	if (ts_virtobj_event_in_shape_range(touchscreen, *x, *y)) {
+		*x -= touchscreen->x_origin;
+		*y -= touchscreen->y_origin;
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(ts_virtobj_touchscreen_event);
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
+static bool ts_virtobj_mapped_button(struct ts_virtobj_map *map)
+{
+	if (!map || !map->button_count)
+		return false;
+
+	return true;
+}
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
+bool ts_virtobj_button_event(struct ts_virtobj_map *map,
+			     struct input_dev *input, u32 x, u32 y)
+{
+	int i;
+
+	if (!ts_virtobj_mapped_button(map))
+		return false;
+
+	for (i = 0; i < map->button_count; i++) {
+		if (ts_virtobj_event_in_shape_range(&map->buttons[i].shape, x, y)) {
+			input_report_key(input, map->buttons[i].key, 1);
+			map->buttons[i].pressed = true;
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(ts_virtobj_button_event);
+
+void ts_virtobj_button_release_pressed(struct ts_virtobj_map *map,
+				       struct input_dev *input)
+{
+	int i;
+
+	if (!map || !map->button_count)
+		return;
+
+	for (i = 0; i < map->button_count; i++) {
+		if (map->buttons[i].pressed) {
+			input_report_key(input, map->buttons[i].key, 0);
+			map->buttons[i].pressed = false;
+		}
+	}
+}
+EXPORT_SYMBOL(ts_virtobj_button_release_pressed);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for virtual objects on touchscreens");
diff --git a/include/linux/input/ts-virtobj.h b/include/linux/input/ts-virtobj.h
new file mode 100644
index 000000000000..4b61709a2680
--- /dev/null
+++ b/include/linux/input/ts-virtobj.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#ifndef _TS_VIRTOBJ
+#define _TS_VIRTOBJ
+
+struct input_dev;
+struct device;
+
+enum ts_virtobj_valid_objects {
+	TOUCHSCREEN,
+	BUTTON,
+};
+
+static const char * const ts_virtobj_names[] = {
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
+};
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
+void ts_virtobj_retrieve_abs(struct ts_virtobj_map *map, u16 *x, u16 *y);
+
+bool ts_virtobj_touchscreen_event(struct ts_virtobj_shape *touchscreen,
+				  u32 *x, u32 *y);
+
+bool ts_virtobj_mapped_touchscreen(struct ts_virtobj_map *map);
+
+bool ts_virtobj_mt_on_touchscreen(struct ts_virtobj_map *map, u32 *x, u32 *y);
+
+bool ts_virtobj_button_event(struct ts_virtobj_map *map,
+			     struct input_dev *input, u32 x, u32 y);
+
+void ts_virtobj_button_release_pressed(struct ts_virtobj_map *map,
+				       struct input_dev *input);
+#endif
-- 
2.37.2

