Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBDF5BB542
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIQBQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIQBQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:16:32 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47822BF8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y2so14521497qkl.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZWmtlqwjalwbyKw/Fcj9jEMqxbpTWmVENNin+d9iBuc=;
        b=EKVdNJWZOaVxvLS8EvGyyXR82e46oPh7T3DOiRxI/kalrPlPv3Ed1IPGdbEdhBath+
         esjb7cKYxvG2GI9ICA1zupnSIc/bJIW8nMUDdtnliH+KprsWRGJPO+hjqsRX52i3ZyqL
         9QAi/UuELRmOlx3Do691nXqwp8xZddehJRwBBsa32KvTs/Dl5j5Bst0/OjoksxfkI5/Y
         YDgVFfbrrNUTb4MSfOsOF9KtbjCmWx3h9rsuoQu0SJOZkTMBH5MxNTc4q4LYDQ9d1UXQ
         upJUqjG7kPVr1GTmYRdZvrFxTbB1tbRuOFRkZaQtZn5JQN59qwWZRoyTs4dkrHgx9Us5
         rzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZWmtlqwjalwbyKw/Fcj9jEMqxbpTWmVENNin+d9iBuc=;
        b=722Lx6eHZdH4zbRpKxX1dK563efBk1Puie5vRvaxsa5E1TakJ61+oBw4kuc9/vGIPm
         jk5AvL0bGjSPdNEC0F4xE80qFdMU3R84m+YAUe1WT99Plmpf1S/0dv6Mnx+5BHhqbTRl
         OdQSRXRlMnC4poAJsp4ROUdpv0R8EmBHv1bY1gsqTSkVe7ik+sC+PNxu0188Fk1LJ7fA
         sGDcBVe4opoJ01DYT11prK6AvwhyRXatI8yDwR7HhuurVIXJ05Km1002M52CuLfR4Eui
         UwaSrIr3cfXcQB/Trnnsrmfm5ikWcqKKs3UctUFYFRREKy5T0ujXusoEk77MnIvjCGQI
         t7ww==
X-Gm-Message-State: ACrzQf1654BNESpDTPbs5VX9wXvwdf6jusTrRm55+WG5jybeL4szafAj
        GU1FWJ6OjTUL4dX/TiTYA7thTw==
X-Google-Smtp-Source: AMsMyM6bbDXxpSQ/PR+f+LUP/IpV/hQChv532e48wJf1oTx10TO//q3dz5joUxxjPbw52EKxi4jzWQ==
X-Received: by 2002:ae9:e114:0:b0:6ce:33c9:5cc2 with SMTP id g20-20020ae9e114000000b006ce33c95cc2mr5986453qkm.388.1663377391104;
        Fri, 16 Sep 2022 18:16:31 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a440600b006bb87c4833asm8085434qkp.109.2022.09.16.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:16:30 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 1/4] counter: Introduce the Signal polarity component
Date:   Fri, 16 Sep 2022 20:39:25 -0400
Message-Id: <fc85e9aa6537f8742dedaa77f8ecf87756c83d32.1663372750.git.william.gray@linaro.org>
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

The Signal polarity component represents the active level of a
respective Signal. There are two possible states: positive (rising edge)
and negative (falling edge); enum counter_signal_polarity represents
these states. A convenience macro COUNTER_COMP_POLARITY() is provided
for driver authors to declare a Signal polarity component.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 13 +++++++++++++
 drivers/counter/counter-sysfs.c             | 11 +++++++++++
 include/linux/counter.h                     | 10 ++++++++++
 include/uapi/linux/counter.h                |  6 ++++++
 4 files changed, 40 insertions(+)

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
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 04eac41dad33..92d3d4f549cb 100644
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

