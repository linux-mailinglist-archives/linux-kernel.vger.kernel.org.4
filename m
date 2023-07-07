Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D724D74B81D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGGUiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjGGUh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:37:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF111FF9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:37:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so25173055e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688762273; x=1691354273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NdrIPZwt9L1R1mzbxg8AqWIw5JoVMckhgJN4c8/wnI=;
        b=lS/hWwIUxlty3HHUhlAuObfrgH4Jvwy9c3m8808D+Sa1W04cmibz+dprPxGFLRJfD5
         W+wubkN7FxqE+wSeBI/DIswpWhMYf1en1KrYUdqAHKAYxrdLZyzQJT19ej4LZNwPM5y/
         ZrsJ3C5koE1MLodgKLTYDAy+79K0NZPeRyY1Rj1ldBio79paAud9ZWQ5MIT0TWBdyckH
         bbcedRSySKXS8FsEedvn01rjtFuLfP4gUzjCTaxW2l35Z9scX7UFu3TG1V5syVOd38CX
         IYOkVDx18SOY/L3Wgjswx8TNv0yh3ORCSyHK2iYewJd+w5fcnGpLYVAekQ0+fQ1+LzwR
         6uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762273; x=1691354273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NdrIPZwt9L1R1mzbxg8AqWIw5JoVMckhgJN4c8/wnI=;
        b=Qds8eN5Z228PCJG05h6EeItv4ZtTiF4HwYxUZDmlVCQVjmmiy8OFk7dUpq1y9negGr
         w8SxJ6IET10fA7YYulP3v/L+x578NCtkAQvWCeE0SB1wb/IGxiy2ZntOLzFM9zi3yMhj
         b6oTM8npJwjmMdBlbduieJAqKR8pg3f2/Uz0dprHUjx8bwdrhYz+y46kH0X9VJzbvE0f
         BFaYSBjWJPfMsWxP1eOuEw7yiBVdRs3ozm7uTQZJ2hcZGJcNQHRSM/JhqGlSAgFlYY6q
         RoW/aLfVXmhTbXCJ0D4NplNTT0qXp3d2f7hoRMsRHHFi9yaKeDZK4kPioGwVzEeWN34n
         Nvsg==
X-Gm-Message-State: ABy/qLbhOlfygfZ9IWS/I14cajxZuEksnyB/46Jl1W0X9LQ0qxAVG9Ay
        IWtFwgWZjmBLZa0KnkRIpnvrgA==
X-Google-Smtp-Source: APBJJlFKy90SQJfbzMCfQRUyEu++iSwKiRNqGMM+51YZXrEdLEoPbgj+mk7637fvbLt3uMXQa4kXQg==
X-Received: by 2002:a05:600c:2252:b0:3fb:c9f4:14f3 with SMTP id a18-20020a05600c225200b003fbc9f414f3mr4828743wmm.2.1688762273628;
        Fri, 07 Jul 2023 13:37:53 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b003143be36d99sm5260674wrp.58.2023.07.07.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 13:37:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH v2 3/4] thermal/drivers/int3400: Use thermal zone device wrappers
Date:   Fri,  7 Jul 2023 22:37:30 +0200
Message-Id: <20230707203731.848188-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707203731.848188-1-daniel.lezcano@linaro.org>
References: <20230707203731.848188-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the thermal core API to access the thermal zone "type" field
instead of directly using the structure field.  While here, remove
access to the temperature field, as this driver is reporting fake
temperature, which can be replaced with INT3400_FAKE_TEMP. Also
replace hardcoded 20C with INT3400_FAKE_TEMP

Acked-by: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../thermal/intel/int340x_thermal/int3400_thermal.c  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 5e1164226ada..72a6e28ded2e 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -15,6 +15,7 @@
 #define INT3400_THERMAL_TABLE_CHANGED 0x83
 #define INT3400_ODVP_CHANGED 0x88
 #define INT3400_KEEP_ALIVE 0xA0
+#define INT3400_FAKE_TEMP (20 * 1000) /* faked temp sensor with 20C */
 
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_ACTIVE = 0,
@@ -453,6 +454,7 @@ static void int3400_notify(acpi_handle handle,
 			void *data)
 {
 	struct int3400_thermal_priv *priv = data;
+	struct device *dev;
 	char *thermal_prop[5];
 	int therm_event;
 
@@ -475,12 +477,14 @@ static void int3400_notify(acpi_handle handle,
 		return;
 	}
 
-	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", priv->thermal->type);
-	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", priv->thermal->temperature);
+	dev = thermal_zone_device(priv->thermal);
+	
+	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", thermal_zone_device_type(priv->thermal));
+	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", INT3400_FAKE_TEMP);
 	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=");
 	thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", therm_event);
 	thermal_prop[4] = NULL;
-	kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE, thermal_prop);
+	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, thermal_prop);
 	kfree(thermal_prop[0]);
 	kfree(thermal_prop[1]);
 	kfree(thermal_prop[2]);
@@ -490,7 +494,7 @@ static void int3400_notify(acpi_handle handle,
 static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
 			int *temp)
 {
-	*temp = 20 * 1000; /* faked temp sensor with 20C */
+	*temp = INT3400_FAKE_TEMP;
 	return 0;
 }
 
-- 
2.34.1

