Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7A06AAB0A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCDQQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCDQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:16:13 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427D126C3;
        Sat,  4 Mar 2023 08:16:11 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id b12so175015ilf.9;
        Sat, 04 Mar 2023 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677946571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AfuZrdHqZEvtfiwJGWy0+dFa+kbUUQVxi3ebO5O4x6k=;
        b=Kc3ZffDGyCsoCiIDHePfMPyZpGJ86lBI+XD4VjcgIOTV705ZzftLr1tc3oSITMxUbo
         puDwSvZ9/dZP8VTBeF/dZwm9IU03/Ba58s9Wkvckl1TthRl9+eCrUTtvegJJhiNBjho5
         jsEw2+BR0WWjfoJkD3H1s+V+1owKm1VFHy+npfoaY4/fsTc2cP2TA85gyZrqmFsbGZ3I
         cf5EIRQnAFk1n10Xa0R/AeX7RrTQfXXKUpf5YMjyrQLOo+ipvl/zZbgl134qgAF4kCt9
         nXIf2ivE1P8QetaRFHDdV3PHgKZPmlMhq8Bv2ZZlxdkR03SBUb9VfrBMrXsH/nA+lojj
         87lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677946571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfuZrdHqZEvtfiwJGWy0+dFa+kbUUQVxi3ebO5O4x6k=;
        b=Sm0hofxoJ2m8CrOK68jjU5YuD25Pn2dpm+xEcVllcHVpQzHecsAyvo3lc3gRHB4530
         zFqFYSxOyB4FWK8bLhg7WT6a5XYT0mrMcPxJ4pXjWk6Vqky/jII9w2A76Qy7Op6+Sx6c
         F/iId7+0sHkGCE8jJcQZF41/UBOe0tzNyQ50KQpziTWAjBrvWlyb2vtKamqHDQSFyyRU
         FeLi1j/9hs5sQ1sa+u3va5sQibJqxzsVJXrQUehqlv6aEkf801gKX5/6sykbC5Q47WmY
         sHWSyfB9zXM2tCzalTQC/YtOWBTWmzYgF+jkOZnKckKLiVVyBc/dPCL84avJal9BVeYv
         vKow==
X-Gm-Message-State: AO0yUKVD48zqXvznwSdwXVXlRlnQcXuLAJ9uprQm1akdjv201NvBHnQM
        EKTGEKDgJA6hBzyEvXby1UEGuw1wcD8=
X-Google-Smtp-Source: AK7set8Rf/DBU0Mch7Qg116IR46kL1Tj5mEgGSRXzorlSNGgJnOpz0/FelRWmi9bqnMJ3yXYMMOFiw==
X-Received: by 2002:a05:6e02:811:b0:314:27c:a730 with SMTP id u17-20020a056e02081100b00314027ca730mr5891779ilm.0.1677946571225;
        Sat, 04 Mar 2023 08:16:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p18-20020a02b892000000b0039e98b2fe5dsm1638448jam.179.2023.03.04.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 08:16:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wang Wensheng <wangwensheng4@huawei.com>
Subject: [PATCH] watchdog: core: Always set WDOG_HW_RUNNING when starting watchdog
Date:   Sat,  4 Mar 2023 08:16:07 -0800
Message-Id: <20230304161607.1418952-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of WDOG_HW_RUNNING is currently inconsistent: If set by the
driver, it will remain set until the watchdog device is opened and then
closed. If set by the watchdog core, it is only set if the watchdog
can not be stopped when closed. Subsequenty it is always only set while
the watchdog is closed and the hardware watchdog is running.

This is both misleading and inconsistent: The API states that
watchdog_hw_running() indicates that the hardware watchdog is running.
This is currently not always the case. Set WDOG_HW_RUNNING whenever a
watchdog is successfully started for consistent behavior and to
accurately report its status.

This means that we no longer have to check for both watchdog_active()
and watchdog_hw_running() to check if the watchdog is running because
watchdog_hw_running() now implies watchdog_active(). Simplify the code
accordingly where warranted.

Cc: Wang Wensheng <wangwensheng4@huawei.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_core.c | 2 +-
 drivers/watchdog/watchdog_dev.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index c777a612d932..d4c5a736fdcb 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -162,7 +162,7 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
 
 	wdd = container_of(nb, struct watchdog_device, reboot_nb);
 	if (code == SYS_DOWN || code == SYS_HALT) {
-		if (watchdog_active(wdd) || watchdog_hw_running(wdd)) {
+		if (watchdog_hw_running(wdd)) {
 			int ret;
 
 			ret = wdd->ops->stop(wdd);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 0122e8796879..7102dc96573e 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -192,7 +192,7 @@ static int watchdog_ping(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
 
-	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
+	if (!watchdog_hw_running(wdd))
 		return 0;
 
 	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
@@ -268,6 +268,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 		trace_watchdog_start(wdd, err);
 		if (err == 0) {
 			set_bit(WDOG_ACTIVE, &wdd->status);
+			set_bit(WDOG_HW_RUNNING, &wdd->status);
 			wd_data->last_keepalive = started_at;
 			wd_data->last_hw_keepalive = started_at;
 			watchdog_update_worker(wdd);
-- 
2.39.1

