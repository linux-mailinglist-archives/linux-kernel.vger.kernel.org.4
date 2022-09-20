Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCAC5BEE25
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiITUBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiITUBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:01:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E40148E81
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:01:41 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o64so5135339oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jb0x3oefFjLbH36GFSoVoseYWbwa162cAGUOYR/16hU=;
        b=vT/Z2M/J4YcUX+Lb4aBnpyaEhnKQ0UOr5GcJZqUt3OmRZa2nj1e/ayw/DfgfU7wBRA
         oElu2QCpwPSzxqPqF+yH1mWRRa/vdzkf7rfWeAYAZKkiehdgdhO7AfJ+g0N2TnSTaFbR
         f6dgKtAb5R/X0spDV+K/sKTJSmi0q8bjwcGQc87ZIgwFFL9o2nBBGHFtv1vgyMGwb8C9
         vnok/nsv6v0MABRQD2NI+cCzbOYAHxZvvG8//GHZ5NGVo6SHtlHrM52BZGYlh5oXO8M2
         dhhpaamwq3MmBAyI66onfB3Vd/z4Sqk93/HDCm+/zX7SJ7cJX4+oLTO/v7jupjqFu0Hl
         +AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jb0x3oefFjLbH36GFSoVoseYWbwa162cAGUOYR/16hU=;
        b=YhCRKoSjocu26Bvc8qE+q+N7kT1vQQ0FwPMKj8/UwkNk9URRSpVbKVKGX/lqyYHMoA
         ZQ+jLOty7mfmA0qBa/LbEbyyoAKUt3I8DovTJVz4YDL4FAK5m4uHocl7f9uauHqjBaDC
         UtGXqGXH6zRyV9xFHTdjegGt8oDVW14Lw3i9BvRToAqWvoiiBH3D2ystW6Dau5Te27D0
         AgD1+4qPmhdr/LUaNNstVilz4/fwqouoobyhL89o6Oc8Gi3Kl0IOtqezQ1Um1Fa7fdlh
         0VxBlp4VGwOmwi4CCvqWkQpk/TODPR2sp+UEJuVCfPtOeFe3wGdUKWBMZuRzmzlLw/i3
         CaLw==
X-Gm-Message-State: ACrzQf3G10BQ/cbopJSB0smvAEMaVjke8M433/di19FpRRfajZDPH7YM
        Sf+W0hCJeu0tnIHS/vsXpf0+jg==
X-Google-Smtp-Source: AMsMyM5SZFDBS973nB/mzz9zuuJcW08LqW85E2Y2POWkzACezKRTK0kiU0x8w6qMxFveGLz+s1oSPA==
X-Received: by 2002:a05:6808:181e:b0:350:7776:9059 with SMTP id bh30-20020a056808181e00b0035077769059mr2397390oib.83.1663704100687;
        Tue, 20 Sep 2022 13:01:40 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bm43-20020a0568081aab00b0034d14c6ce3dsm325634oib.16.2022.09.20.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:01:40 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 1/5] counter: Introduce the Signal polarity component
Date:   Tue, 20 Sep 2022 13:21:25 -0400
Message-Id: <e6957a16b73913bbf382e716eb9aa2a48986c69a.1663693757.git.william.gray@linaro.org>
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
index 1fe17f5adb09..60428d06915d 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -31,6 +31,7 @@ enum counter_comp_type {
 	COUNTER_COMP_ENUM,
 	COUNTER_COMP_COUNT_DIRECTION,
 	COUNTER_COMP_COUNT_MODE,
+	COUNTER_COMP_SIGNAL_POLARITY,
 };
 
 /**
@@ -477,6 +478,15 @@ struct counter_available {
 #define COUNTER_COMP_FLOOR(_read, _write) \
 	COUNTER_COMP_COUNT_U64("floor", _read, _write)
 
+#define COUNTER_COMP_POLARITY(_read, _write, _available) \
+{ \
+	.type = COUNTER_COMP_SIGNAL_POLARITY, \
+	.name = "polarity", \
+	.signal_u32_read = (_read), \
+	.signal_u32_write = (_write), \
+	.priv = &(_available), \
+}
+
 #define COUNTER_COMP_PRESET(_read, _write) \
 	COUNTER_COMP_COUNT_U64("preset", _read, _write)
 
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

