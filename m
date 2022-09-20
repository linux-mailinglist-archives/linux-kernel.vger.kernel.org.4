Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6329D5BEE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiITUCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiITUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:01:54 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A65B79E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:01:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eab59db71so5862009fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yGF5JgvQ8ZJIL1SqTUp8L/aOCQ0AR2H4mstGI+qgJdg=;
        b=ufbQ1reW8kF15zWCoCf+ICEIez9O3Bt9iktBZxoxwGrSxVdbkNz6yTH9zAbYft+W8D
         4Ajd6IfNZ7H3pVUEmtvl8Er6hmyPZZPbpGQaXOdnKnh+CsA11vOD5IgzjTI9qLAGbsZp
         uOcTygKI+14t8ykjKNYBlfaqb+ddhPMo5Tf8XMEaIfM470JpyY9Mlmw5vj0YhIdPS2qR
         iYzw6KgU5Tfw+cp75szxD5tU5HLECupPmvQyYFNRJPubsraqO++63vMjsDuXnefCnAn7
         3vZzxB2at7gSLdm8MyKq8PsqfNWQHa5kgBCvsbTPbIXpMTsw2k7B6AWG29WeikqzjjqH
         wKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yGF5JgvQ8ZJIL1SqTUp8L/aOCQ0AR2H4mstGI+qgJdg=;
        b=jwILSwb4c9guPuSVxl1A7F9HjYfSXUj+Atw9PaKloQyuW6KcwkzjRFMhzLms48CJLZ
         kj94geDc4/7i8xqzVE9NGaOIIbwdO3IBRCuwYqB67r+YeEZ/Z7822worRq7mIBgRWzwf
         098m7dHr502frPCG2d8glbGwcE4nWMWURy2H30nYLxkS3yQDQKJDpIiyD82qn+tRnMfC
         TDuGgdzb0630LnINLQ7eFdjU7LmWwaUVz0Dvk//FF3Vb6x3i9uYnSb7ZKd4fS5T9NsvY
         Tj1I6N3MVoJf7dJ2UY3PJLmBebVJ5W8SajCfjRuzWzS3LNrj3Brl9MHHLvjsOPRsgrTV
         jgJA==
X-Gm-Message-State: ACrzQf3D7O3rqGFmLkdUGQ5GZf696EsCGJX/AWnjUO2m9MNULOLyWuaK
        IuWA3o1FpN2l3vBb0NDFvGsPgg==
X-Google-Smtp-Source: AMsMyM6/SNdxyfeG/XlixPUOfRZww2U2RWAKpG74JXSJTDsciTHuIBedK6AurYyvJe4GLuZi8K8dww==
X-Received: by 2002:a05:6871:725:b0:127:96e8:21c with SMTP id f37-20020a056871072500b0012796e8021cmr3118973oap.104.1663704106079;
        Tue, 20 Sep 2022 13:01:46 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bm43-20020a0568081aab00b0034d14c6ce3dsm325634oib.16.2022.09.20.13.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:01:45 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 5/5] counter: Introduce the COUNTER_COMP_ARRAY component type
Date:   Tue, 20 Sep 2022 13:21:29 -0400
Message-Id: <8a1490580658cbd9c9f0f65ba075c518fb60ba2b.1663693757.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663693757.git.william.gray@linaro.org>
References: <cover.1663693757.git.william.gray@linaro.org>
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

Eight Counter array component macros are introduced::

        DEFINE_COUNTER_ARRAY_U64(_name, _length)
        DEFINE_COUNTER_ARRAY_CAPTURE(_name, _length)
        DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length)
        COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_ARRAY_CAPTURE(_read, _write, _array)
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

        DEFINE_COUNTER_ARRAY_CAPTURE(foobar_capture_array, 4);
        COUNTER_COMP_ARRAY_CAPTURE(foobar_capture_read, NULL,
                                   foobar_capture_array)

Respective sysfs attributes for each array element would appear for the
respective Count:

* /sys/bus/counter/devices/counterX/countY/capture0
* /sys/bus/counter/devices/counterX/countY/capture1
* /sys/bus/counter/devices/counterX/countY/capture2
* /sys/bus/counter/devices/counterX/countY/capture3

If a user tries to read _capture2_ for example, `idx` will be `2` when
passed to the `foobar_capture_read()` callback, and thus the driver
knows which array element to handle.

Counter arrays for polarity elements can be defined in a similar
manner::

        const enum counter_signal_polarity foobar_polarity_states[] = {
                COUNTER_SIGNAL_POLARITY_POSITIVE,
                COUNTER_SIGNAL_POLARITY_NEGATIVE,
        };
        DEFINE_COUNTER_ARRAY_POLARITY(foobar_polarity_array,
                                      foobar_polarity_states, 4);
        COUNTER_COMP_ARRAY_POLARITY(foobar_polarity_read,
                                    foobar_polarity_write,
                                    foobar_polarity_array)

Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/counter-chrdev.c | 134 ++++++++++++++++++---
 drivers/counter/counter-sysfs.c  | 198 ++++++++++++++++++++++++++++++-
 include/linux/counter.h          | 134 +++++++++++++++++++++
 3 files changed, 446 insertions(+), 20 deletions(-)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 120879ee2e87..80acdf62794a 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -40,7 +40,11 @@ struct counter_comp_node {
 	a.signal_u32_read == b.signal_u32_read || \
 	a.device_u64_read == b.device_u64_read || \
 	a.count_u64_read == b.count_u64_read || \
-	a.signal_u64_read == b.signal_u64_read)
+	a.signal_u64_read == b.signal_u64_read || \
+	a.signal_array_u32_read == b.signal_array_u32_read || \
+	a.device_array_u64_read == b.device_array_u64_read || \
+	a.count_array_u64_read == b.count_array_u64_read || \
+	a.signal_array_u64_read == b.signal_array_u64_read)
 
 #define counter_comp_read_is_set(comp) \
 	(comp.action_read || \
@@ -52,7 +56,11 @@ struct counter_comp_node {
 	comp.signal_u32_read || \
 	comp.device_u64_read || \
 	comp.count_u64_read || \
-	comp.signal_u64_read)
+	comp.signal_u64_read || \
+	comp.signal_array_u32_read || \
+	comp.device_array_u64_read || \
+	comp.count_array_u64_read || \
+	comp.signal_array_u64_read)
 
 static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
 				   size_t len, loff_t *f_ps)
@@ -228,6 +236,31 @@ static int counter_disable_events(struct counter_device *const counter)
 	return err;
 }
 
+static int counter_get_ext(const struct counter_comp *const ext,
+			   const size_t num_ext, const size_t component_id,
+			   size_t *const ext_idx, size_t *const id)
+{
+	struct counter_array *element;
+
+	*id = 0;
+	for (*ext_idx = 0; *ext_idx < num_ext; (*ext_idx)++) {
+		if (*id == component_id)
+			return 0;
+
+		if (ext->type == COUNTER_COMP_ARRAY) {
+			element = ext->priv;
+
+			if (component_id - *id < element->length)
+				return 0;
+
+			*id += element->length;
+		} else
+			(*id)++;
+	}
+
+	return -EINVAL;
+}
+
 static int counter_add_watch(struct counter_device *const counter,
 			     const unsigned long arg)
 {
@@ -237,6 +270,7 @@ static int counter_add_watch(struct counter_device *const counter,
 	size_t parent, id;
 	struct counter_comp *ext;
 	size_t num_ext;
+	size_t ext_idx, ext_id;
 	int err = 0;
 
 	if (copy_from_user(&watch, uwatch, sizeof(watch)))
@@ -314,11 +348,11 @@ static int counter_add_watch(struct counter_device *const counter,
 		comp_node.comp.priv = counter->counts[parent].synapses + id;
 		break;
 	case COUNTER_COMPONENT_EXTENSION:
-		if (id >= num_ext)
-			return -EINVAL;
-		id = array_index_nospec(id, num_ext);
+		err = counter_get_ext(ext, num_ext, id, &ext_idx, &ext_id);
+		if (err < 0)
+			return err;
 
-		comp_node.comp = ext[id];
+		comp_node.comp = ext[ext_idx];
 		break;
 	default:
 		return -EINVAL;
@@ -451,14 +485,56 @@ void counter_chrdev_remove(struct counter_device *const counter)
 	kfifo_free(&counter->events);
 }
 
+static int counter_get_array_data(struct counter_device *const counter,
+				  const enum counter_scope scope,
+				  void *const parent,
+				  const struct counter_comp *const comp,
+				  const size_t idx, u64 *const value)
+{
+	const struct counter_array *const element = comp->priv;
+	u32 value_u32 = 0;
+	int ret;
+
+	switch (element->type) {
+	case COUNTER_COMP_SIGNAL_POLARITY:
+		if (scope != COUNTER_SCOPE_SIGNAL)
+			return -EINVAL;
+		ret = comp->signal_array_u32_read(counter, parent, idx,
+						  &value_u32);
+		*value = value_u32;
+		return ret;
+	case COUNTER_COMP_U64:
+		switch (scope) {
+		case COUNTER_SCOPE_DEVICE:
+			return comp->device_array_u64_read(counter, idx, value);
+		case COUNTER_SCOPE_SIGNAL:
+			return comp->signal_array_u64_read(counter, parent, idx,
+							   value);
+		case COUNTER_SCOPE_COUNT:
+			return comp->count_array_u64_read(counter, parent, idx,
+							  value);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static int counter_get_data(struct counter_device *const counter,
 			    const struct counter_comp_node *const comp_node,
 			    u64 *const value)
 {
 	const struct counter_comp *const comp = &comp_node->comp;
-	void *const parent = comp_node->parent;
+	const enum counter_scope scope = comp_node->component.scope;
+	const size_t id = comp_node->component.id;
+	struct counter_signal *const signal = comp_node->parent;
+	struct counter_count *const count = comp_node->parent;
 	u8 value_u8 = 0;
 	u32 value_u32 = 0;
+	const struct counter_comp *ext;
+	size_t num_ext;
+	size_t ext_idx, ext_id;
 	int ret;
 
 	if (comp_node->component.type == COUNTER_COMPONENT_NONE)
@@ -467,15 +543,15 @@ static int counter_get_data(struct counter_device *const counter,
 	switch (comp->type) {
 	case COUNTER_COMP_U8:
 	case COUNTER_COMP_BOOL:
-		switch (comp_node->component.scope) {
+		switch (scope) {
 		case COUNTER_SCOPE_DEVICE:
 			ret = comp->device_u8_read(counter, &value_u8);
 			break;
 		case COUNTER_SCOPE_SIGNAL:
-			ret = comp->signal_u8_read(counter, parent, &value_u8);
+			ret = comp->signal_u8_read(counter, signal, &value_u8);
 			break;
 		case COUNTER_SCOPE_COUNT:
-			ret = comp->count_u8_read(counter, parent, &value_u8);
+			ret = comp->count_u8_read(counter, count, &value_u8);
 			break;
 		default:
 			return -EINVAL;
@@ -488,16 +564,16 @@ static int counter_get_data(struct counter_device *const counter,
 	case COUNTER_COMP_COUNT_DIRECTION:
 	case COUNTER_COMP_COUNT_MODE:
 	case COUNTER_COMP_SIGNAL_POLARITY:
-		switch (comp_node->component.scope) {
+		switch (scope) {
 		case COUNTER_SCOPE_DEVICE:
 			ret = comp->device_u32_read(counter, &value_u32);
 			break;
 		case COUNTER_SCOPE_SIGNAL:
-			ret = comp->signal_u32_read(counter, parent,
+			ret = comp->signal_u32_read(counter, signal,
 						    &value_u32);
 			break;
 		case COUNTER_SCOPE_COUNT:
-			ret = comp->count_u32_read(counter, parent, &value_u32);
+			ret = comp->count_u32_read(counter, count, &value_u32);
 			break;
 		default:
 			return -EINVAL;
@@ -505,21 +581,43 @@ static int counter_get_data(struct counter_device *const counter,
 		*value = value_u32;
 		return ret;
 	case COUNTER_COMP_U64:
-		switch (comp_node->component.scope) {
+		switch (scope) {
 		case COUNTER_SCOPE_DEVICE:
 			return comp->device_u64_read(counter, value);
 		case COUNTER_SCOPE_SIGNAL:
-			return comp->signal_u64_read(counter, parent, value);
+			return comp->signal_u64_read(counter, signal, value);
 		case COUNTER_SCOPE_COUNT:
-			return comp->count_u64_read(counter, parent, value);
+			return comp->count_u64_read(counter, count, value);
 		default:
 			return -EINVAL;
 		}
 	case COUNTER_COMP_SYNAPSE_ACTION:
-		ret = comp->action_read(counter, parent, comp->priv,
-					&value_u32);
+		ret = comp->action_read(counter, count, comp->priv, &value_u32);
 		*value = value_u32;
 		return ret;
+	case COUNTER_COMP_ARRAY:
+		switch (scope) {
+		case COUNTER_SCOPE_DEVICE:
+			ext = counter->ext;
+			num_ext = counter->num_ext;
+			break;
+		case COUNTER_SCOPE_SIGNAL:
+			ext = signal->ext;
+			num_ext = signal->num_ext;
+			break;
+		case COUNTER_SCOPE_COUNT:
+			ext = count->ext;
+			num_ext = count->num_ext;
+			break;
+		default:
+			return -EINVAL;
+		}
+		ret = counter_get_ext(ext, num_ext, id, &ext_idx, &ext_id);
+		if (ret < 0)
+			return ret;
+
+		return counter_get_array_data(counter, scope, comp_node->parent,
+					      comp, id - ext_id, value);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index b393da402e0b..b9efe66f9f8d 100644
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
 
@@ -500,6 +619,32 @@ static int counter_attr_create(struct device *const dev,
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
@@ -609,6 +754,45 @@ static int counter_ext_attrs_create(struct device *const dev,
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
+		/* Generate array element attribute name */
+		ext.name = devm_kasprintf(dev, GFP_KERNEL, "%s%zu", comp->name,
+					  idx);
+		if (!ext.name)
+			return -ENOMEM;
+
+		/* Allocate and configure array element */
+		element = devm_kzalloc(dev, sizeof(*element), GFP_KERNEL);
+		if (!element)
+			return -ENOMEM;
+		element->type = array->type;
+		element->avail = array->avail;
+		element->idx = idx;
+		ext.priv = element;
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
@@ -619,12 +803,22 @@ static int counter_sysfs_exts_add(struct device *const dev,
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
index 2c6594c240d4..6eb3ae7b4fcb 100644
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
 
@@ -453,6 +524,57 @@ struct counter_available {
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
+#define DEFINE_COUNTER_ARRAY_U64(_name, _length) \
+	struct counter_array _name = { \
+		.type = COUNTER_COMP_U64, \
+		.length = (_length), \
+	}
+
+#define DEFINE_COUNTER_ARRAY_CAPTURE(_name, _length) \
+	DEFINE_COUNTER_ARRAY_U64(_name, _length)
+
+#define DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length) \
+	DEFINE_COUNTER_AVAILABLE(_name##_available, _enums); \
+	struct counter_array _name = { \
+		.type = COUNTER_COMP_SIGNAL_POLARITY, \
+		.avail = &(_name##_available), \
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
 #define COUNTER_COMP_CAPTURE(_read, _write) \
 	COUNTER_COMP_COUNT_U64("capture", _read, _write)
 
@@ -496,4 +618,16 @@ struct counter_available {
 #define COUNTER_COMP_PRESET_ENABLE(_read, _write) \
 	COUNTER_COMP_COUNT_BOOL("preset_enable", _read, _write)
 
+#define COUNTER_COMP_ARRAY_CAPTURE(_read, _write, _array) \
+	COUNTER_COMP_COUNT_ARRAY_U64("capture", _read, _write, _array)
+
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

