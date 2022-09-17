Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57805BB546
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIQBQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiIQBQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:16:37 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D694EBBA7A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s18so14234988qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=L4mHg8tr2Z6q5CevpFCH/2CHmo2l4J76jvGEI+vTweI=;
        b=yMVe0PTWztYIvx5p8MUTDDWCCx1KMEkZFnr3IrDL6TUHR1uMNxDGHICnMKpQBTag4D
         Bkw4iXm836hso+OJwOoY86hBgKFUpYbuyaGzxVAgGk2GA1ydX/LY+4eZRVK2P/VBh6Oe
         W+pCsmcYHfrblBqR5DZsCfDcpzV80LrKRjAvu06F/bnrQ0h5e+dI3ctlYvovziOzlGfw
         Kj7gKg580DFar3f+6zMa3eXi/+hVbgBqUVMgNCpl7WrmTOhhKUJCFrtdHcF9J7iVs+gF
         m49ZO7GjZAuug/egoVcCzqBwfPVP2yWTXpOFX9zZzrw7v9m6dRgXgFyhYn5bWQaHt+G9
         PgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L4mHg8tr2Z6q5CevpFCH/2CHmo2l4J76jvGEI+vTweI=;
        b=e+HCtaTQgRecbmTz4PMw5ka9WoNGFz43vepOofgo43x+NGVnEMODJd03WXsV9bpKaT
         9KORNiE2X+c0rtTU2xbEmvxeWHzlKgBHGWV8MEdSlQG+SvpdUtQPEyTyHU2WLm5nIokP
         u9Og7E4d9y9xbg5cXjDIfLBnc5Qmk6dc6RpOqkwhxEnpyZz1J+vtc7NeuBTvDH3ihCzS
         L0EqnhcsdzEY6o5hWsCPZWJkhGcUY7Kp6UoziPOD8oNtMOJfC8BtvdLDU/7x8p099HfL
         FnHS/Ij4NfTv5MShIhmfBkv57vgQBGPWGIi4oC+ccVQDEjSbVIuGdQf+bkqz2N64o7HH
         hJ0g==
X-Gm-Message-State: ACrzQf37EcjZRYvODUwCCNnlsJrVA3wZeQrOWysHkLMrQPC8GK7R0AEo
        dcZGIxmB2NVBF57pclMWDRuiKg==
X-Google-Smtp-Source: AMsMyM6aKMgStFDDLbzmAns6KpAhsjq03DMLxZ6sN7vtPws3hRt1FQtEy7ckUuOY7jPSdqrMQp8d4Q==
X-Received: by 2002:ac8:5ac7:0:b0:35b:b658:4b6c with SMTP id d7-20020ac85ac7000000b0035bb6584b6cmr6686864qtd.207.1663377394452;
        Fri, 16 Sep 2022 18:16:34 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a440600b006bb87c4833asm8085434qkp.109.2022.09.16.18.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:16:34 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 4/4] counter: Introduce the COUNTER_COMP_ARRAY component type
Date:   Fri, 16 Sep 2022 20:39:28 -0400
Message-Id: <f35ffc511f78148a10eb73b7d8abbe6c5d676973.1663372750.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663372750.git.william.gray@linaro.org>
References: <cover.1663372750.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The COUNTER_COMP_ARRAY Counter component type is introduced to enable
support for Counter array components. With Counter array components,
exposure for buffers on counter devices can be defined via new Counter
array component macros. This should simplify code for driver authors who
would otherwise need to define individual Counter components for each
array element.

Five Counter array component macros are introduced::

        DEFINE_COUNTER_ARRAY(_name, _type, _available, _length)
        COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_ARRAY_POLARITY(_read, _write, _array)

Eight Counter array callbacks are introduced as well::

        int (*signal_array_u32_read)(struct counter_device *counter,
                                     struct counter_signal *signal,
                                     size_t idx, u32 *val);
        int (*signal_array_u32_write)(struct counter_device *counter,
                                      struct counter_signal *signal,
                                      size_t idx, u32 val);
        int (*device_array_u64_read)(struct counter_device *counter,
                                     size_t idx, u64 *val);
        int (*count_array_u64_read)(struct counter_device *counter,
                                    struct counter_count *count,
                                    size_t idx, u64 *val);
        int (*signal_array_u64_read)(struct counter_device *counter,
                                     struct counter_signal *signal,
                                     size_t idx, u64 *val);
        int (*device_array_u64_write)(struct counter_device *counter,
                                      size_t idx, u64 val);
        int (*count_array_u64_write)(struct counter_device *counter,
                                     struct counter_count *count,
                                     size_t idx, u64 val);
        int (*signal_array_u64_write)(struct counter_device *counter,
                                      struct counter_signal *signal,
                                      size_t idx, u64 val);

Driver authors can handle reads/writes for an array component by
receiving an element index via the `idx` parameter and processing the
respective value via the `val` parameter.

For example, suppose a driver wants to expose a Count's read-only
capture buffer of four elements using a callback
`foobar_capture_read()`::

        DEFINE_COUNTER_ARRAY(foobar_capture_array, COUNTER_COMP_U64,
                             NULL, 4)
        COUNTER_COMP_COUNT_ARRAY_U64("capture", foobar_capture_read,
                                     NULL, foobar_capture_array)

Respective sysfs attributes for each array element would appear for the
respective Count:

* /sys/bus/counter/devices/counterX/countY/capture0
* /sys/bus/counter/devices/counterX/countY/capture1
* /sys/bus/counter/devices/counterX/countY/capture2
* /sys/bus/counter/devices/counterX/countY/capture3

If a user tries to read _capture2_ for example, `idx` will be `2` when
passed to the `foobar_capture_read()` callback, and thus the driver
knows which array element to handle.

Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/counter-sysfs.c | 193 +++++++++++++++++++++++++++++++-
 include/linux/counter.h         | 121 ++++++++++++++++++++
 2 files changed, 312 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 7ce7c51395da..ea4401b4d578 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -352,6 +352,124 @@ static ssize_t counter_comp_u64_store(struct device *dev,
 	return len;
 }
 
+static ssize_t counter_comp_array_u32_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = counter_from_dev(dev);
+	const struct counter_array *const element = a->comp.priv;
+	int err;
+	u32 data = 0;
+
+	if (a->scope != COUNTER_SCOPE_SIGNAL ||
+	    element->type != COUNTER_COMP_SIGNAL_POLARITY)
+		return -EINVAL;
+
+	err = a->comp.signal_array_u32_read(counter, a->parent, element->idx,
+					    &data);
+	if (err < 0)
+		return err;
+
+	return sysfs_emit(buf, "%s\n", counter_signal_polarity_str[data]);
+}
+
+static ssize_t counter_comp_array_u32_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = counter_from_dev(dev);
+	const struct counter_array *const element = a->comp.priv;
+	int err;
+	u32 data = 0;
+
+	if (element->type != COUNTER_COMP_SIGNAL_POLARITY ||
+	    a->scope != COUNTER_SCOPE_SIGNAL)
+		return -EINVAL;
+
+	err = counter_find_enum(&data, element->avail->enums,
+				element->avail->num_items, buf,
+				counter_signal_polarity_str);
+	if (err < 0)
+		return err;
+
+	err = a->comp.signal_array_u32_write(counter, a->parent, element->idx,
+					     data);
+	if (err < 0)
+		return err;
+
+	return len;
+}
+
+static ssize_t counter_comp_array_u64_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = counter_from_dev(dev);
+	const struct counter_array *const element = a->comp.priv;
+	int err;
+	u64 data = 0;
+
+	switch (a->scope) {
+	case COUNTER_SCOPE_DEVICE:
+		err = a->comp.device_array_u64_read(counter, element->idx,
+						    &data);
+		break;
+	case COUNTER_SCOPE_SIGNAL:
+		err = a->comp.signal_array_u64_read(counter, a->parent,
+						    element->idx, &data);
+		break;
+	case COUNTER_SCOPE_COUNT:
+		err = a->comp.count_array_u64_read(counter, a->parent,
+						   element->idx, &data);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)data);
+}
+
+static ssize_t counter_comp_array_u64_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = counter_from_dev(dev);
+	const struct counter_array *const element = a->comp.priv;
+	int err;
+	u64 data = 0;
+
+	err = kstrtou64(buf, 0, &data);
+	if (err < 0)
+		return err;
+
+	switch (a->scope) {
+	case COUNTER_SCOPE_DEVICE:
+		err = a->comp.device_array_u64_write(counter, element->idx,
+						     data);
+		break;
+	case COUNTER_SCOPE_SIGNAL:
+		err = a->comp.signal_array_u64_write(counter, a->parent,
+						     element->idx, data);
+		break;
+	case COUNTER_SCOPE_COUNT:
+		err = a->comp.count_array_u64_write(counter, a->parent,
+						    element->idx, data);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	return len;
+}
+
 static ssize_t enums_available_show(const u32 *const enums,
 				    const size_t num_enums,
 				    const char *const strs[], char *buf)
@@ -446,6 +564,7 @@ static int counter_attr_create(struct device *const dev,
 			       const enum counter_scope scope,
 			       void *const parent)
 {
+	const struct counter_array *const array = comp->priv;
 	struct counter_attribute *counter_attr;
 	struct device_attribute *dev_attr;
 
@@ -499,6 +618,32 @@ static int counter_attr_create(struct device *const dev,
 			dev_attr->store = counter_comp_u64_store;
 		}
 		break;
+	case COUNTER_COMP_ARRAY:
+		switch (array->type) {
+		case COUNTER_COMP_SIGNAL_POLARITY:
+			if (comp->signal_array_u32_read) {
+				dev_attr->attr.mode |= 0444;
+				dev_attr->show = counter_comp_array_u32_show;
+			}
+			if (comp->signal_array_u32_write) {
+				dev_attr->attr.mode |= 0200;
+				dev_attr->store = counter_comp_array_u32_store;
+			}
+			break;
+		case COUNTER_COMP_U64:
+			if (comp->device_array_u64_read) {
+				dev_attr->attr.mode |= 0444;
+				dev_attr->show = counter_comp_array_u64_show;
+			}
+			if (comp->device_array_u64_write) {
+				dev_attr->attr.mode |= 0200;
+				dev_attr->store = counter_comp_array_u64_store;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -608,6 +753,40 @@ static int counter_ext_attrs_create(struct device *const dev,
 	return counter_comp_id_attr_create(dev, group, ext->name, id);
 }
 
+static int counter_array_attrs_create(struct device *const dev,
+				      struct counter_attribute_group *const group,
+				      const struct counter_comp *const comp,
+				      const enum counter_scope scope,
+				      void *const parent, const size_t id)
+{
+	const struct counter_array *const array = comp->priv;
+	struct counter_comp ext = *comp;
+	struct counter_array *element;
+	size_t idx;
+	int err;
+
+	/* Create an attribute for each array element */
+	for (idx = 0; idx < array->length; idx++) {
+		/* Set index for array element extension */
+		element = ext.priv;
+		element->idx = idx;
+
+		/* Generate array element attribute name */
+		ext.name = devm_kasprintf(dev, GFP_KERNEL, "%s%zu", comp->name,
+					  idx);
+		if (!ext.name)
+			return -ENOMEM;
+
+		/* Create all attributes associated with the array element */
+		err = counter_ext_attrs_create(dev, group, &ext, scope, parent,
+					       id + idx);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int counter_sysfs_exts_add(struct device *const dev,
 				  struct counter_attribute_group *const group,
 				  const struct counter_comp *const exts,
@@ -618,12 +797,22 @@ static int counter_sysfs_exts_add(struct device *const dev,
 	size_t i;
 	const struct counter_comp *ext;
 	int err;
+	size_t id = 0;
+	const struct counter_array *array;
 
 	/* Create attributes for each extension */
 	for (i = 0; i < num_ext; i++) {
 		ext = &exts[i];
-		err = counter_ext_attrs_create(dev, group, ext, scope, parent,
-					       i);
+		if (ext->type == COUNTER_COMP_ARRAY) {
+			err = counter_array_attrs_create(dev, group, ext, scope,
+							 parent, id);
+			array = ext->priv;
+			id += array->length;
+		} else {
+			err = counter_ext_attrs_create(dev, group, ext, scope,
+						       parent, id);
+			id++;
+		}
 		if (err < 0)
 			return err;
 	}
diff --git a/include/linux/counter.h b/include/linux/counter.h
index d508b260aaca..61fe38e30626 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -32,6 +32,7 @@ enum counter_comp_type {
 	COUNTER_COMP_COUNT_DIRECTION,
 	COUNTER_COMP_COUNT_MODE,
 	COUNTER_COMP_SIGNAL_POLARITY,
+	COUNTER_COMP_ARRAY,
 };
 
 /**
@@ -69,6 +70,30 @@ enum counter_comp_type {
  * @signal_u64_read:		Signal u64 component read callback. The read value of
  *			the respective Signal u64 component should be passed
  *			back via the val parameter.
+ * @signal_array_u32_read:	Signal u32 array component read callback. The
+ *				index of the respective Count u32 array
+ *				component element is passed via the idx
+ *				parameter. The read value of the respective
+ *				Count u32 array component element should be
+ *				passed back via the val parameter.
+ * @device_array_u64_read:	Device u64 array component read callback. The
+ *				index of the respective Device u64 array
+ *				component element is passed via the idx
+ *				parameter. The read value of the respective
+ *				Device u64 array component element should be
+ *				passed back via the val parameter.
+ * @count_array_u64_read:	Count u64 array component read callback. The
+ *				index of the respective Count u64 array
+ *				component element is passed via the idx
+ *				parameter. The read value of the respective
+ *				Count u64 array component element should be
+ *				passed back via the val parameter.
+ * @signal_array_u64_read:	Signal u64 array component read callback. The
+ *				index of the respective Count u64 array
+ *				component element is passed via the idx
+ *				parameter. The read value of the respective
+ *				Count u64 array component element should be
+ *				passed back via the val parameter.
  * @action_write:		Synapse action mode write callback. The write value of
  *			the respective Synapse action mode is passed via the
  *			action parameter.
@@ -99,6 +124,30 @@ enum counter_comp_type {
  * @signal_u64_write:		Signal u64 component write callback. The write value of
  *			the respective Signal u64 component is passed via the
  *			val parameter.
+ * @signal_array_u32_write:	Signal u32 array component write callback. The
+ *				index of the respective Signal u32 array
+ *				component element is passed via the idx
+ *				parameter. The write value of the respective
+ *				Signal u32 array component element is passed via
+ *				the val parameter.
+ * @device_array_u64_write:	Device u64 array component write callback. The
+ *				index of the respective Device u64 array
+ *				component element is passed via the idx
+ *				parameter. The write value of the respective
+ *				Device u64 array component element is passed via
+ *				the val parameter.
+ * @count_array_u64_write:	Count u64 array component write callback. The
+ *				index of the respective Count u64 array
+ *				component element is passed via the idx
+ *				parameter. The write value of the respective
+ *				Count u64 array component element is passed via
+ *				the val parameter.
+ * @signal_array_u64_write:	Signal u64 array component write callback. The
+ *				index of the respective Signal u64 array
+ *				component element is passed via the idx
+ *				parameter. The write value of the respective
+ *				Signal u64 array component element is passed via
+ *				the val parameter.
  */
 struct counter_comp {
 	enum counter_comp_type type;
@@ -126,6 +175,17 @@ struct counter_comp {
 				      struct counter_count *count, u64 *val);
 		int (*signal_u64_read)(struct counter_device *counter,
 				       struct counter_signal *signal, u64 *val);
+		int (*signal_array_u32_read)(struct counter_device *counter,
+					     struct counter_signal *signal,
+					     size_t idx, u32 *val);
+		int (*device_array_u64_read)(struct counter_device *counter,
+					     size_t idx, u64 *val);
+		int (*count_array_u64_read)(struct counter_device *counter,
+					    struct counter_count *count,
+					    size_t idx, u64 *val);
+		int (*signal_array_u64_read)(struct counter_device *counter,
+					     struct counter_signal *signal,
+					     size_t idx, u64 *val);
 	};
 	union {
 		int (*action_write)(struct counter_device *counter,
@@ -149,6 +209,17 @@ struct counter_comp {
 				       struct counter_count *count, u64 val);
 		int (*signal_u64_write)(struct counter_device *counter,
 					struct counter_signal *signal, u64 val);
+		int (*signal_array_u32_write)(struct counter_device *counter,
+					      struct counter_signal *signal,
+					      size_t idx, u32 val);
+		int (*device_array_u64_write)(struct counter_device *counter,
+					      size_t idx, u64 val);
+		int (*count_array_u64_write)(struct counter_device *counter,
+					     struct counter_count *count,
+					     size_t idx, u64 val);
+		int (*signal_array_u64_write)(struct counter_device *counter,
+					      struct counter_signal *signal,
+					      size_t idx, u64 val);
 	};
 };
 
@@ -453,6 +524,47 @@ struct counter_available {
 	.priv = &(_available), \
 }
 
+struct counter_array {
+	enum counter_comp_type type;
+	const struct counter_available *avail;
+	union {
+		size_t length;
+		size_t idx;
+	};
+};
+
+#define DEFINE_COUNTER_ARRAY(_name, _type, _available, _length) \
+	struct counter_array _name = { \
+		.type = (_type), \
+		.avail = &(_available), \
+		.length = (_length), \
+	}
+
+#define COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _array) \
+{ \
+	.type = COUNTER_COMP_ARRAY, \
+	.name = (_name), \
+	.device_array_u64_read = (_read), \
+	.device_array_u64_write = (_write), \
+	.priv = &(_array), \
+}
+#define COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _array) \
+{ \
+	.type = COUNTER_COMP_ARRAY, \
+	.name = (_name), \
+	.count_array_u64_read = (_read), \
+	.count_array_u64_write = (_write), \
+	.priv = &(_array), \
+}
+#define COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _array) \
+{ \
+	.type = COUNTER_COMP_ARRAY, \
+	.name = (_name), \
+	.signal_array_u64_read = (_read), \
+	.signal_array_u64_write = (_write), \
+	.priv = &(_array), \
+}
+
 #define COUNTER_COMP_CEILING(_read, _write) \
 	COUNTER_COMP_COUNT_U64("ceiling", _read, _write)
 
@@ -493,4 +605,13 @@ struct counter_available {
 	.priv = &(_available), \
 }
 
+#define COUNTER_COMP_ARRAY_POLARITY(_read, _write, _array) \
+{ \
+	.type = COUNTER_COMP_ARRAY, \
+	.name = "polarity", \
+	.signal_array_u32_read = (_read), \
+	.signal_array_u32_write = (_write), \
+	.priv = &(_array), \
+}
+
 #endif /* _COUNTER_H_ */
-- 
2.37.3

