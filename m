Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD4600FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJQNJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJQNJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:16 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213DC14D2A;
        Mon, 17 Oct 2022 06:09:16 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1324e7a1284so13146164fac.10;
        Mon, 17 Oct 2022 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oENftCtS6Re+rYEuXigvS3nBvzokSvAdm/CPq6AiHb0=;
        b=U8z35qvgBJtdcS83au5XocR3KoRYrE+LQwEvaGgG7fzPuPN/6UZPRzeBs6bBqR7AE7
         oNTfGTKNXmYQ0pbLX1Ttd5Bx5AHNEahqz/Dip1Jbw8TjzU9qgI9oP+xb73/F52KunOur
         c0pwE1+S7so0tE1aoJTSKFCqfGHGNv9nj6EJWXGRbDpKPNcjIBWk/VPiAJsByVUYJ1Is
         tVdV6Ap9hT6s9q96EE4KbJ1RTxQ4Vbadlu8CwEsEL9egZ3iVnfp2NO58f6tTmGQy32nZ
         cc+wGot9TTpvgfZ7Hj8AXVmxcPYUcn76JrjIe1p7CWT/U1LkVLuhk8aqtr2GGAADRzTz
         84ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oENftCtS6Re+rYEuXigvS3nBvzokSvAdm/CPq6AiHb0=;
        b=eT7AleaABMP53iI2058gGQwLCwT5mFlDkiFcOxkvtvZTYK8a2Aw/tctuGtKz263sjR
         Jn6iXKSPLvF22nexxZ48r5NBkwf4KbOKpJ8l/6IM9RLPm6+hvaq+BvYURQvnOSsAo9LW
         593Z1A3UmycK0V+pRoAeu6hAGX3K+YfzqX1uCS5lNNV/f3g4UNdowFRkFBEHW6vWfdJV
         gq6KH+/4YiRIlCbY6paEUd/Ioh5sCvofjbqfudLKY5STw6E0qod00YMy5qMLc8DLj/g2
         nlK7QoUDhaS6ObH2NPc1lGAoQmBBgcYBqWc7CtfY/e5koJzJWU+OBRjNhRS5v3uLH1IX
         DFmQ==
X-Gm-Message-State: ACrzQf3d+h/9fRY6Gj1zkl+XJV0eSF/o4M2XQv1BZpsjUcmLwv+lKOBD
        +QNRL3EIhlCOAviPSVUkbEc=
X-Google-Smtp-Source: AMsMyM5UDUC1yAc+ZtnvwlfJvY7jezo3WIrJ5Sz+Ah3ncZzrzFJDZmxeizc+AY5E7SzShYsmi2ds/w==
X-Received: by 2002:a05:6870:4729:b0:136:71ed:9989 with SMTP id b41-20020a056870472900b0013671ed9989mr15815928oaq.73.1666012155503;
        Mon, 17 Oct 2022 06:09:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 23-20020aca2117000000b00354efb5be11sm4264343oiz.15.2022.10.17.06.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/9] thermal/core: Destroy thermal zone device mutex in release function
Date:   Mon, 17 Oct 2022 06:09:02 -0700
Message-Id: <20221017130910.2307118-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221017130910.2307118-1-linux@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
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

Accesses to thermal zones, and with it the thermal zone device mutex,
are still possible after the thermal zone device has been unregistered.
For example, thermal_zone_get_temp() can be called from temp_show()
in thermal_sysfs.c if the sysfs attribute was opened before the thermal
device was unregistered.

Move the call to mutex_destroy from thermal_zone_device_unregister()
to thermal_release() to ensure that it is only destroyed after it is
guaranteed to be no longer accessed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 117eeaf7dd24..f548875a016d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -759,6 +759,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		mutex_destroy(&tz->lock);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1390,7 +1391,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
-- 
2.36.2

