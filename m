Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD00710DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbjEYOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbjEYOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:02:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5BE65
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so2100501f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023326; x=1687615326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wdkc7RVIiuUcIo6x94zTHppu2nSL2mGFfMHnbXI87Y=;
        b=j68NHVr1A3FrdpKdp18jpST9Sx6UadVozGKrTknOB3eBJ4WeHJSoaNWhCxAnQZHxcO
         OK+lkClFJqErAGSG1mMvT9dGU+HaTk1QBPscxFzumfxrz4FPkDJEmYKt42BlBk9Yk8r5
         Ig7mwdOQox1TXqzCJCSyywxNTjRyS8rnqbVUyhLzv9iCzmfqtVMXV/t//hAbIUD2jcAM
         6k5gkFmClpoOCIvH4k9xZy4DJq1MECkXNSIB60sXzV4WpdBNA8/+OW8+Zo7mySzgU/9m
         t0QRWL6rRBEaA6oqq7G2RsRZS7okaKvcE7VQ4x5AmMMVaKJo/zAfk3gcmKL+qSyYBf/M
         3Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023326; x=1687615326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wdkc7RVIiuUcIo6x94zTHppu2nSL2mGFfMHnbXI87Y=;
        b=kbAjG9v0nw2ID6w4DwamPEabve8cKTcNGAhIgs6ewIIYT18Waes0SlNZ7QCNskAtxo
         6Hwv6pg4e0gVjMaeGsUeQnTh/R54G0lXVdc7qG/udTaYlvLcwtTxKghUyzMDI4GvMMn3
         QbCZymYBR2kTZmFWjBNW6NAUVdETIJy5JN2ADQFSYf9V/bVvmUvedx0S9b02h5P1vHS1
         j7KMkyfM5XPWK+AesWTY73qsTi2/zaYI7nG0ukuedBsqN2Y17SHx766WYLnWR+phOkcR
         a/kRkdXKb02oImyGfOaOj0NYYddPCi5vNxCldOA8pu/NVcn7QYwGIDqY4d+3FuSUk7kQ
         wDtQ==
X-Gm-Message-State: AC+VfDz2mz+3FYOjEqPc+YwkPOSfecqpV5s7eJnnDeEWVa+e/kgld0zm
        +lui0GlYYKgV/TuJ0Nly/9SZ2g==
X-Google-Smtp-Source: ACHHUZ4HXcVqrErnKOD0gX1c0NtHgLr7aNYM4nVVOMMcdXEkN7kok08EYdZSFXbqboyZhUMV95dbKA==
X-Received: by 2002:adf:eec4:0:b0:2ef:eb54:4dc0 with SMTP id a4-20020adfeec4000000b002efeb544dc0mr2504739wrp.51.1685023326212;
        Thu, 25 May 2023 07:02:06 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:02:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/8] thermal/drivers/int3400: Use thermal zone device wrappers
Date:   Thu, 25 May 2023 16:01:32 +0200
Message-Id: <20230525140135.3589917-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
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

The driver is accessing the thermal zone device structure but the
accessors are already existing and we want to consolidate the thermal
core code by preventing accesses to the internals from the drivers.

Let's use these accessors.

On the other side, the code is getting directly the temperature from
tz->temperature, but the temperature is a faked on, so we can replace
this access by the fake temp and remove the thermal zone device
structure access.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../thermal/intel/int340x_thermal/int3400_thermal.c  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 810231b59dcd..66e34241b33a 100644
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

