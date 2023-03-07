Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB96AE0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCGNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCGNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:38:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F73392A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:38:05 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l1so12102861wry.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8j4bJo1oZVc8oVRbgCLsTpymyaRowPacMWUlyxZyaA=;
        b=M+pDCn8yf+ZYz0M24b8vuev3cxkgCkT7t7+FWsP48E+EBPLbO5oHJz69sm7CpRRzI5
         AbnzlqXMTSAOfze4yP5pEmF32IuLZlR6+gD7hlbfmmUnyv0leh8ayItqNRRnlP+53C2G
         8QTKBOXoL58ihGEEdQ6Bsf3u6rw7kdWeRLBIXjWmRTsvYK8o/eq9yjjN7h5ekGP683EC
         CeHNoPRdbqxR9ILWERajpgbyg00Ks/UIKBwyX1KBbhWa+XC46HIKevd/tajORB43bXNC
         h3hGnrEI0h1kpKk9FhviJyB5pULyEUQu+AQRZyCDbsV+w7Grvv71nwL8I8ZX1XVYCnvs
         YLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8j4bJo1oZVc8oVRbgCLsTpymyaRowPacMWUlyxZyaA=;
        b=oCdOHmY69G31pdkYC/MXE1YEyYk+HP/1yQzZ236hIpgrIHvUwDvrQ3M8ja2dcduk2k
         37+EXNmZ6C6q24JmyErkaXtat9NJpLg2d7V2nLwyEUDkPukptioIf7EMlIcF2S4eFMEl
         XWuxoJ4ABOZYFPWRFcxZPO8ZzKEu+jLky2MWMsoHcjiosZIV1JWAUACd/GvzIyAP01Wo
         dMFSlk85nV735Ni3ZXl78ZdAenYsT5mVH4QRU/BdAL8hDGukCHfSi1FXhniX0HplVRkE
         zKyfN/wz6KogyZU27l8iwn/fKiatcSxW236UJHtitftPMvZjH10C7djRqqkiUL6bXARn
         TCAw==
X-Gm-Message-State: AO0yUKW0wIuibZTE7typwtwOmLClbOS8oPY9kSPVbQnI+nhCtVYMbKW+
        NJsnrCWPIyJ1MNY3M8klKJUfAAphMwz/fGHFsRs=
X-Google-Smtp-Source: AK7set+uCREgdZyDrbl/tbTOC9EGTEAhWUZhLQ2zomC+C7qdM8BhdSDTWRbvqdAJqphUshGOdOlnBg==
X-Received: by 2002:adf:df04:0:b0:2c7:1dc4:5c4e with SMTP id y4-20020adfdf04000000b002c71dc45c4emr10251708wrl.32.1678196283559;
        Tue, 07 Mar 2023 05:38:03 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:38:03 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 09/11] thermal/core: Add a linked device parameter
Date:   Tue,  7 Mar 2023 14:37:33 +0100
Message-Id: <20230307133735.90772-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers want to create a link from the thermal zone to the device
sysfs entry and vice versa. That is the case of the APCI driver.

Having a backpointer from the device to the thermal zone sounds akward
as we can have the same device instantiating multiple thermal zones so
there will be a conflict while creating the second link with the same
name. Moreover, the userspace has enough information to build the
dependency from the thermal zone device link without having this cyclic
link from the device to thermal zone.

Anyway, everything in its time.

This change allows to create a these cyclic links tz <-> device as
ACPI does and will allow to remove the code in the ACPI driver.

The limitation of this change is there can be only a 1:1 relationship
between the device and the thermal zone, otherwise the 'thermal_zone'
link name will conflict with the previous link with the same name.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 16 ++++++++++++++++
 include/linux/thermal.h        |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cec72c6673a5..ca91189bc441 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1340,6 +1340,18 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	list_add_tail(&tz->node, &thermal_tz_list);
 	mutex_unlock(&thermal_list_lock);
 
+	if (tzp && tzp->linked_dev) {
+		result = sysfs_create_link(&tzp->linked_dev->kobj,
+					   &tz->device.kobj, "thermal_zone");
+		if (result)
+			goto out_list_del;
+
+		result = sysfs_create_link(&tz->device.kobj,
+					   &tzp->linked_dev->kobj, "device");
+		if (result)
+			goto out_del_link;
+	}
+
 	/* Bind cooling devices for this zone */
 	bind_tz(tz);
 
@@ -1354,6 +1366,10 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	return tz;
 
+out_del_link:
+	sysfs_remove_link(&tz->device.kobj, "thermal_zone");
+out_list_del:
+	list_del(&tz->node);
 unregister:
 	device_del(&tz->device);
 release_device:
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8cdf94cdc5ff..f60d7edf1e5d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -256,6 +256,13 @@ struct thermal_zone_params {
 	int num_tbps;	/* Number of tbp entries */
 	struct thermal_bind_params *tbp;
 
+	/*
+	 * @linked_dev: Add a cross link from the device to the
+	 * thermal zone and vice versa. They will be named
+	 * respectively 'device' and 'thermal_zone'
+	 */
+	struct device *linked_dev;
+
 	/*
 	 * Sustainable power (heat) that this thermal zone can dissipate in
 	 * mW
-- 
2.34.1

