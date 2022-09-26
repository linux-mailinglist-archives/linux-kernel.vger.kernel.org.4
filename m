Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1826B5EADE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiIZRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiIZRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:16:25 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906659FAA9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:30:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id c6so4611956qvn.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UAsBC/ozSH12BZzJSDo1U0RNDp5xAtyPHfT7WW+rRMI=;
        b=xC+CrzneOFA1Fx1IssDbvIoXQCw4O9JoDHfO98vdIzDw7ITq6D6DZCuA62lsj1yTld
         5e3SLuLL7MszbIOKvJk8BQs/oXJWvXZT2KylPezf/P4JCh+mCL+7Ni0/yNwXBOiUi4Jb
         smzd8hvEXr9JpswfCKeh901agILzygwrm0rQJGPSdrLz1DI5uwlsLKuGBIUeuEC0rZZa
         U8jzHwHVbKwolcNcAxOTiFRa5eoyVCIpcasbwwVocO4h86NVMTHqFoYbL9Gfbv3Qguky
         Ssn0BNGojiw2yaAmeteqGjXx4dCkH92JF/mP/W/8GHZx7/bKc7R3j5x4z5tECXCEeFjZ
         A7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UAsBC/ozSH12BZzJSDo1U0RNDp5xAtyPHfT7WW+rRMI=;
        b=z9cyvIsCssMeevbKkU722BJ/vNwgvUYQlfjtDkddKPHG+Fe7Tmmg17/8u36v+Y3kUq
         zH/Uc35tuhf18jzgglK095K1ihfDh2igkYLADCvfkMwcDthsWL6ZNhFkyUq48txWaLIY
         59bQwWHkFfDimE4S00W0BFyTkZsrzuaDDmm/3oC5UmUm9rq+BIjQ5TH/9+l2xwoZcsCM
         MHPCuZIcFjVcZlO2Mw2wWe2yeP/p/iEIgBBfdfYUOPbM/eEyIXXcFtzt6plTiLO5lGoB
         vXbIrrT1Mf5rG4aVzOCl5deVwJXdHdm4nAg51JgJgsdsEKuvjRm8QqaCZ2e9rCWLFVxW
         Bq8g==
X-Gm-Message-State: ACrzQf2dFgrAGVWf5qQs6OXsif+zjmNeWDY+6OrGVq4JCvPW5GLA4M9z
        8RD4xKocVnOPQ2MyvWswlI/oZQ==
X-Google-Smtp-Source: AMsMyM7LDtMzeff4cP+t/avuIkciGqZrwKa4va+VAvJdqM9YbYGeeRH2dGPTtCiX6p+mOOLLDVDmxw==
X-Received: by 2002:a05:6214:e64:b0:4aa:906c:b540 with SMTP id jz4-20020a0562140e6400b004aa906cb540mr18080134qvb.46.1664209815804;
        Mon, 26 Sep 2022 09:30:15 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 139-20020a370a91000000b006ce60296f97sm11542146qkk.68.2022.09.26.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:30:15 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v6 3/5] counter: Introduce the Count capture component
Date:   Mon, 26 Sep 2022 11:16:36 -0400
Message-Id: <c239572ab4208d0d6728136e82a88ad464369a7a.1664204990.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664204990.git.william.gray@linaro.org>
References: <cover.1664204990.git.william.gray@linaro.org>
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

Some devices provide a latch function to save historic Count values.
This patch standardizes exposure of such functionality as Count capture
components. A COUNTER_COMP_CAPTURE macro is provided for driver authors
to define a capture component. A new event COUNTER_EVENT_CAPTURE is
introduced to represent Count value capture events.

Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 7 +++++++
 include/linux/counter.h                     | 3 +++
 include/uapi/linux/counter.h                | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 2a996deabe9e..3eb6b063970a 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -4,6 +4,12 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Count data of Count Y represented as a string.
 
+What:		/sys/bus/counter/devices/counterX/countY/capture
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Historical capture of the Count Y count data.
+
 What:		/sys/bus/counter/devices/counterX/countY/ceiling
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -203,6 +209,7 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b3fb6b68881a..e160197971dd 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -453,6 +453,9 @@ struct counter_available {
 	.priv = &(_available), \
 }
 
+#define COUNTER_COMP_CAPTURE(_read, _write) \
+	COUNTER_COMP_COUNT_U64("capture", _read, _write)
+
 #define COUNTER_COMP_CEILING(_read, _write) \
 	COUNTER_COMP_COUNT_U64("ceiling", _read, _write)
 
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index e9610e1944dc..8ab12d731e3b 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -63,6 +63,8 @@ enum counter_event_type {
 	COUNTER_EVENT_INDEX,
 	/* State of counter is changed */
 	COUNTER_EVENT_CHANGE_OF_STATE,
+	/* Count value captured */
+	COUNTER_EVENT_CAPTURE,
 };
 
 /**
-- 
2.37.3

