Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B550A5BD80C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiISXRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiISXRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:17:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269CC4B0F8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:17:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s18so640168qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9WKeOSlzI7Zsjf+zNINEK5AdOxP+4fnSZYO519BCbN4=;
        b=CIX5k1WxrXEnxUQm47tvC3b8kZ3+leFl4wgIHgxyx9tx6wCdQacmHQcC/6afg6SAkN
         B2iJqWSu+DJyPBvSqkmkLzbulLL5Rrj6pp2SvzFeKQOLGOxZfFBSH79aYcTGCid77l3O
         qIMHlMDyWSDyQDYtLo5rWLoroZ8o2SFC0T1PiN+33lE7GhHdtO64xweMOUXEvnDtsYvW
         gjLDhmt3T+x1ylpkqiQ5ddCo24xA9DGPZnK3/ETmMhy5iHXLhehMkpUiqnxUoSZhIe2F
         ZeQJtDvIV8M2Idj0RMDutaGmJpCaPf+ErqGFzmomNfER/IUKSuerCCU/pPyOrowndH2r
         w7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9WKeOSlzI7Zsjf+zNINEK5AdOxP+4fnSZYO519BCbN4=;
        b=S18eiR6cwfhSG/rMT47+mgt6+UzGt3iXeEzj6FAl7kUuTswPAVJZgFBNGbLpflavtQ
         KJjl2HvsNI4QgLu1dc7r9YYvrKtDm+b/pJMAv76r7CtfGM6EQUdCWvxxCzGXZdITamcw
         9oV+zhTWwKm1Q7xM8zmuqh+p1RkPOLdIPpxfWuGdhbEg8uBvP8PRchvQB0HegweStzNy
         My3GhYI63hxHd9cUnkegCsM194KQ/icV96yuoQUbuJI4spTcyZfpQAPi/fIIK2zBSFWm
         scZQf3waXE5r3Y9U/4ISl4SermabaipNjxDxSkhAkkeBOtBOJOFG/lw69WyQuE8KcXll
         1qXQ==
X-Gm-Message-State: ACrzQf1EtA4cdMaLHG8Qwd/MQgYenCbQ9zBnTYO8vI8UxVq5iODGHpcZ
        emooDvOhbCHariCCVz9sZEk46A==
X-Google-Smtp-Source: AMsMyM5oieZY6swpFAfRM68vy7DCvQMmV77wAyLBSLjyDvF2mARTSiN6sWlRba/RREdxrZ9Aaqbptw==
X-Received: by 2002:a05:622a:138c:b0:35c:e9d2:8d76 with SMTP id o12-20020a05622a138c00b0035ce9d28d76mr5973209qtk.463.1663629457272;
        Mon, 19 Sep 2022 16:17:37 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d4-20020ac80604000000b0035cebb79aaesm2547005qth.18.2022.09.19.16.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 16:17:37 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 1/4] counter: Introduce the Signal polarity component
Date:   Sun, 18 Sep 2022 14:22:04 -0400
Message-Id: <434654aa23789d7a1dae69642e4e707200bcecea.1663524845.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663524845.git.william.gray@linaro.org>
References: <cover.1663524845.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Signal polarity component represents the active level of a
respective Signal. There are two possible states: positive (rising edge)
and negative (falling edge); enum counter_signal_polarity represents
these states. A convenience macro COUNTER_COMP_POLARITY() is provided
for driver authors to declare a Signal polarity component.

Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 13 +++++++++++++
 drivers/counter/counter-chrdev.c            |  1 +
 drivers/counter/counter-sysfs.c             | 12 ++++++++++++
 include/linux/counter.h                     | 10 ++++++++++
 include/uapi/linux/counter.h                |  6 ++++++
 5 files changed, 42 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 06c2b3e27e0b..a234022f9add 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -303,6 +303,19 @@ Description:
 		Discrete set of available values for the respective Signal Y
 		configuration are listed in this file.
 
+What:		/sys/bus/counter/devices/counterX/signalY/polarity
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Active level of Signal Y. The following polarity values are
+		available:
+
+		positive:
+			Signal high state considered active level (rising edge).
+
+		negative:
+			Signal low state considered active level (falling edge).
+
 What:		/sys/bus/counter/devices/counterX/signalY/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 4e71a19d7e6a..120879ee2e87 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -487,6 +487,7 @@ static int counter_get_data(struct counter_device *const counter,
 	case COUNTER_COMP_ENUM:
 	case COUNTER_COMP_COUNT_DIRECTION:
 	case COUNTER_COMP_COUNT_MODE:
+	case COUNTER_COMP_SIGNAL_POLARITY:
 		switch (comp_node->component.scope) {
 		case COUNTER_SCOPE_DEVICE:
 			ret = comp->device_u32_read(counter, &value_u32);
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 04eac41dad33..e5dd36e1a45f 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -91,6 +91,11 @@ static const char *const counter_count_mode_str[] = {
 	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
 };
 
+static const char *const counter_signal_polarity_str[] = {
+	[COUNTER_SIGNAL_POLARITY_POSITIVE] = "positive",
+	[COUNTER_SIGNAL_POLARITY_NEGATIVE] = "negative"
+};
+
 static ssize_t counter_comp_u8_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -201,6 +206,8 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 		return sysfs_emit(buf, "%s\n", counter_count_direction_str[data]);
 	case COUNTER_COMP_COUNT_MODE:
 		return sysfs_emit(buf, "%s\n", counter_count_mode_str[data]);
+	case COUNTER_COMP_SIGNAL_POLARITY:
+		return sysfs_emit(buf, "%s\n", counter_signal_polarity_str[data]);
 	default:
 		return sysfs_emit(buf, "%u\n", (unsigned int)data);
 	}
@@ -252,6 +259,10 @@ static ssize_t counter_comp_u32_store(struct device *dev,
 		err = counter_find_enum(&data, avail->enums, avail->num_items,
 					buf, counter_count_mode_str);
 		break;
+	case COUNTER_COMP_SIGNAL_POLARITY:
+		err = counter_find_enum(&data, avail->enums, avail->num_items,
+					buf, counter_signal_polarity_str);
+		break;
 	default:
 		err = kstrtou32(buf, 0, &data);
 		break;
@@ -469,6 +480,7 @@ static int counter_attr_create(struct device *const dev,
 	case COUNTER_COMP_ENUM:
 	case COUNTER_COMP_COUNT_DIRECTION:
 	case COUNTER_COMP_COUNT_MODE:
+	case COUNTER_COMP_SIGNAL_POLARITY:
 		if (comp->device_u32_read) {
 			dev_attr->attr.mode |= 0444;
 			dev_attr->show = counter_comp_u32_show;
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 1fe17f5adb09..d508b260aaca 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -31,6 +31,7 @@ enum counter_comp_type {
 	COUNTER_COMP_ENUM,
 	COUNTER_COMP_COUNT_DIRECTION,
 	COUNTER_COMP_COUNT_MODE,
+	COUNTER_COMP_SIGNAL_POLARITY,
 };
 
 /**
@@ -483,4 +484,13 @@ struct counter_available {
 #define COUNTER_COMP_PRESET_ENABLE(_read, _write) \
 	COUNTER_COMP_COUNT_BOOL("preset_enable", _read, _write)
 
+#define COUNTER_COMP_POLARITY(_read, _write, _available) \
+{ \
+	.type = COUNTER_COMP_SIGNAL_POLARITY, \
+	.name = "polarity", \
+	.signal_u32_read = (_read), \
+	.signal_u32_write = (_write), \
+	.priv = &(_available), \
+}
+
 #endif /* _COUNTER_H_ */
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 96c5ffd368ad..e9610e1944dc 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -153,4 +153,10 @@ enum counter_synapse_action {
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
 };
 
+/* Signal polarity values */
+enum counter_signal_polarity {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
 #endif /* _UAPI_COUNTER_H_ */
-- 
2.37.3

