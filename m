Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3946553CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiLWTNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLWTNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:13:39 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FC61D31C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671822815; bh=P9f871po8Uo8UcGE1zsHMZs+AHZmF24K1+rDfxehJFg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=XYi4v4kjIJPxH5cMqOqux+jnljqI4aGLjBVynUZX7MqoP0XwfSblwKXX/K47nslBh
         JteUa7VIZINGpeGYS9z/nsIjO/HAChIW2URxlosO70GpL20lNM9PLVls+BImZR2Te3
         A+c0S5liHmaN6JE4za868OVSWkYk19QCem1cFyI4=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 20:13:35 +0100 (CET)
X-EA-Auth: CMqPvAe+WFpNOZSsoaT9NF8Tn+9lylTO4aSUXsNYPCJGfjNIJGotu0X7tsZnjdIXiEZvpsqJUdLq/TDoTmJfrf1JinuelhvK
Date:   Sat, 24 Dec 2022 00:43:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] most: core: Use sysfs_emit in show function callsbacks
Message-ID: <Y6X92vLgEu7DKxLl@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/filesystems/sysfs.rst, the show() callback
function of kobject attributes should strictly use sysfs_emit instead
of sprintf family functions.

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/most/core.c | 61 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index e4412c7d25b0..f9ca6a7d885c 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -208,8 +208,8 @@ static ssize_t number_of_packet_buffers_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;

-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			c->iface->channel_vector[i].num_buffers_packet);
+	return sysfs_emit(buf, "%d\n",
+			  c->iface->channel_vector[i].num_buffers_packet);
 }

 static ssize_t number_of_stream_buffers_show(struct device *dev,
@@ -219,8 +219,8 @@ static ssize_t number_of_stream_buffers_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;

-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			c->iface->channel_vector[i].num_buffers_streaming);
+	return sysfs_emit(buf, "%d\n",
+			  c->iface->channel_vector[i].num_buffers_streaming);
 }

 static ssize_t size_of_packet_buffer_show(struct device *dev,
@@ -230,8 +230,8 @@ static ssize_t size_of_packet_buffer_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;

-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			c->iface->channel_vector[i].buffer_size_packet);
+	return sysfs_emit(buf, "%d\n",
+			  c->iface->channel_vector[i].buffer_size_packet);
 }

 static ssize_t size_of_stream_buffer_show(struct device *dev,
@@ -241,8 +241,8 @@ static ssize_t size_of_stream_buffer_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;

-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			c->iface->channel_vector[i].buffer_size_streaming);
+	return sysfs_emit(buf, "%d\n",
+			  c->iface->channel_vector[i].buffer_size_streaming);
 }

 static ssize_t channel_starving_show(struct device *dev,
@@ -251,7 +251,7 @@ static ssize_t channel_starving_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);

-	return snprintf(buf, PAGE_SIZE, "%d\n", c->is_starving);
+	return sysfs_emit(buf, "%d\n", c->is_starving);
 }

 static ssize_t set_number_of_buffers_show(struct device *dev,
@@ -260,7 +260,7 @@ static ssize_t set_number_of_buffers_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);

-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.num_buffers);
+	return sysfs_emit(buf, "%d\n", c->cfg.num_buffers);
 }

 static ssize_t set_buffer_size_show(struct device *dev,
@@ -269,7 +269,7 @@ static ssize_t set_buffer_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);

-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.buffer_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.buffer_size);
 }

 static ssize_t set_direction_show(struct device *dev,
@@ -279,10 +279,10 @@ static ssize_t set_direction_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);

 	if (c->cfg.direction & MOST_CH_TX)
-		return snprintf(buf, PAGE_SIZE, "tx\n");
+		return sysfs_emit(buf, "tx\n");
 	else if (c->cfg.direction & MOST_CH_RX)
-		return snprintf(buf, PAGE_SIZE, "rx\n");
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+		return sysfs_emit(buf, "rx\n");
+	return sysfs_emit(buf, "unconfigured\n");
 }

 static ssize_t set_datatype_show(struct device *dev,
@@ -294,10 +294,9 @@ static ssize_t set_datatype_show(struct device *dev,

 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
 		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, "%s",
-					ch_data_type[i].name);
+			return sysfs_emit(buf, "%s", ch_data_type[i].name);
 	}
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+	return sysfs_emit(buf, "unconfigured\n");
 }

 static ssize_t set_subbuffer_size_show(struct device *dev,
@@ -306,7 +305,7 @@ static ssize_t set_subbuffer_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);

-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.subbuffer_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.subbuffer_size);
 }

 static ssize_t set_packets_per_xact_show(struct device *dev,
@@ -315,7 +314,7 @@ static ssize_t set_packets_per_xact_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);

-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.packets_per_xact);
+	return sysfs_emit(buf, "%d\n", c->cfg.packets_per_xact);
 }

 static ssize_t set_dbr_size_show(struct device *dev,
@@ -323,7 +322,7 @@ static ssize_t set_dbr_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);

-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.dbr_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.dbr_size);
 }

 #define to_dev_attr(a) container_of(a, struct device_attribute, attr)
@@ -395,7 +394,7 @@ static ssize_t description_show(struct device *dev,
 {
 	struct most_interface *iface = dev_get_drvdata(dev);

-	return snprintf(buf, PAGE_SIZE, "%s\n", iface->description);
+	return sysfs_emit(buf, "%s\n", iface->description);
 }

 static ssize_t interface_show(struct device *dev,
@@ -406,25 +405,25 @@ static ssize_t interface_show(struct device *dev,

 	switch (iface->interface) {
 	case ITYPE_LOOPBACK:
-		return snprintf(buf, PAGE_SIZE, "loopback\n");
+		return sysfs_emit(buf, "loopback\n");
 	case ITYPE_I2C:
-		return snprintf(buf, PAGE_SIZE, "i2c\n");
+		return sysfs_emit(buf, "i2c\n");
 	case ITYPE_I2S:
-		return snprintf(buf, PAGE_SIZE, "i2s\n");
+		return sysfs_emit(buf, "i2s\n");
 	case ITYPE_TSI:
-		return snprintf(buf, PAGE_SIZE, "tsi\n");
+		return sysfs_emit(buf, "tsi\n");
 	case ITYPE_HBI:
-		return snprintf(buf, PAGE_SIZE, "hbi\n");
+		return sysfs_emit(buf, "hbi\n");
 	case ITYPE_MEDIALB_DIM:
-		return snprintf(buf, PAGE_SIZE, "mlb_dim\n");
+		return sysfs_emit(buf, "mlb_dim\n");
 	case ITYPE_MEDIALB_DIM2:
-		return snprintf(buf, PAGE_SIZE, "mlb_dim2\n");
+		return sysfs_emit(buf, "mlb_dim2\n");
 	case ITYPE_USB:
-		return snprintf(buf, PAGE_SIZE, "usb\n");
+		return sysfs_emit(buf, "usb\n");
 	case ITYPE_PCIE:
-		return snprintf(buf, PAGE_SIZE, "pcie\n");
+		return sysfs_emit(buf, "pcie\n");
 	}
-	return snprintf(buf, PAGE_SIZE, "unknown\n");
+	return sysfs_emit(buf, "unknown\n");
 }

 static DEVICE_ATTR_RO(description);
--
2.34.1



