Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6D690E67
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBIQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:36:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27D35D1CD;
        Thu,  9 Feb 2023 08:36:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jg8so8089455ejc.6;
        Thu, 09 Feb 2023 08:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSMHddABkQrSZWKXpcNqaIw0Zi5wgSezoqZrfdPoFS4=;
        b=dQKC05DNRQQNdOpQUw+3c5rMOAUX4Mo+Jh82gM3mIG1vPs8HWsnnd8YY4HjIalA6n0
         z91cj8Iuq0MfFAAq+flknH6vuHuGUQh58V/idFI9GfgqdTLJDNyiBGyW8lXSFpcWcAAH
         jqKXsuybEXM8AEe/gCkTJowqfByrXS27kiPYjkqnxd+01Bg5Pd01FhR8UfEAP3nCHbvu
         quwSzBtWESoBwPtvmgIm/mQr7cfYbHYkd4lFdItmfAeGbFSw4ghaGuY5HB+bL8SdQbuL
         0QfuPU+TjuCeEwaTTHPAssI6FXykLevzh0SNfyBKgEHUUP/ww4iwixK1Dh0X/XCE8Kl8
         Y9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSMHddABkQrSZWKXpcNqaIw0Zi5wgSezoqZrfdPoFS4=;
        b=5FWzgmN/QqlMfvhB1qGAOhY+XKtCr834nx/gj0PGs5oY72aPUxw0PA3qBdbxkGZDud
         XuLUVKzzz9KjhVVLdoqPwbJMMgJxe7zG591JgfewADo+Y2L6V0aMgopgIl4L2yQH1/qU
         jswCVrn2ysrL74dQhJdfSKM6IHOmAezWus0A2JG8dqVjsulWflu9F9IWLGZE2WWvzV1a
         VYhvfXO0AYYZ1D+tMSmfdI+wyeO464vHQVEMFtX0os1yujNkOB4jC+Cm1vENKlqmmerK
         p6C3+oi+6c6rb8wzGYEo/nEqsd9p7p4FwA6JJ/2fwGyEOjVdsf7Qsw8eh7VBc9Tq4ANk
         HRYA==
X-Gm-Message-State: AO0yUKWGCjkQPaJ8AdSre06t5J4krO8GEkCzlreKU8RO/hnsFXvLbaxR
        qrW7h2nDIqMMLkJ9bqMYSbE=
X-Google-Smtp-Source: AK7set+oKuYllmX96ewy+fm4I2U28/GcuB3wo8J+X44BcI7GRbtlqzC+GMcWeq3ZAHV2Gas3m5bolg==
X-Received: by 2002:a17:906:86d6:b0:885:9ce9:dc79 with SMTP id j22-20020a17090686d600b008859ce9dc79mr12978483ejy.77.1675960560310;
        Thu, 09 Feb 2023 08:36:00 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b0088f8ae18b6bsm1059203ejc.189.2023.02.09.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:36:00 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: Add support for cooling device bind/unbind operations
Date:   Thu,  9 Feb 2023 17:35:54 +0100
Message-Id: <20230209163555.1993557-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Drivers for cooling devices can implement these operations when they
need to perform extra work at the time when a cooling device is bound to
a given thermal zone.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/thermal_core.c | 11 +++++++++++
 include/linux/thermal.h        |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0675df54c8e6..627fccd100ef 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -694,6 +694,14 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
 
+	if (cdev->ops->bind) {
+		result = cdev->ops->bind(cdev, tz, trip, upper, lower, weight);
+		if (result < 0) {
+			pr_err("failed to bind %s to %s: %d\n", cdev->type,
+			       tz->type, result);
+		}
+	}
+
 	if (!result)
 		return 0;
 
@@ -730,6 +738,9 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 {
 	struct thermal_instance *pos, *next;
 
+	if (cdev->ops->unbind)
+		cdev->ops->unbind(cdev, tz, trip);
+
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2bb4bf33f4f3..95ed8a0cbba8 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -89,6 +89,12 @@ struct thermal_trip {
 };
 
 struct thermal_cooling_device_ops {
+	int (*bind)(struct thermal_cooling_device *cdev,
+		    struct thermal_zone_device *tz, int trip_id,
+		    unsigned long upper, unsigned long lower,
+		    unsigned int weight);
+	void (*unbind)(struct thermal_cooling_device *cdev,
+		       struct thermal_zone_device *tz, int trip_id);
 	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
-- 
2.39.1

