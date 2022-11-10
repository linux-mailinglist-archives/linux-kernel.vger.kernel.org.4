Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50889624593
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKJPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiKJPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:06 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE08A317ED;
        Thu, 10 Nov 2022 07:25:05 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so1297887otl.3;
        Thu, 10 Nov 2022 07:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOYNmW9OZFQBi/Rb1c2Zeo5a8y5kFjUwBvSI7SdtFFM=;
        b=Ktcssiuad0WVHvYrFj71Mdm/+gqzgFmLM+S5ZMFNAMhEbOq9DTTjbg92CJ//Bxb26/
         2dCVdDLNycfy49CWd31iL0SdbhaNfjJAx2pEZrH/MSl1pmMdmKwKFJiUkqGILDUdD1Np
         edPC66QEWnmbkoUddHs1No70gFjly1xGoqHUxrHcPAV0/tTJ4EGkIl+X32wGLsJ1hVwJ
         bHNfdQLA9j4Be/HXQKlAaFzL++qG/18lngDfzXkftfm+ACw3sWRGHjMsUhu9QOVrNSgp
         R3K1unpLHQFN/vmFI1japm86hVx5GtoX2TVg2SkCYnR2Xj6Km6iTvi41YKq750vsNGco
         yh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bOYNmW9OZFQBi/Rb1c2Zeo5a8y5kFjUwBvSI7SdtFFM=;
        b=cfrC79FpUIasQdTkyB/OKaQWbuvzbqdwm0G0vkLhHNjSGipUFsAVbRXkfX9IMBPbhf
         7n2CAkKJ+APnzOztemnZ1zZ1v2RBSUye4Po+GW2iY/2IOFhqo0jsYp8KDHiukG1Te5uK
         pzOzcWzOESvozwxRb7TnUFB590Qvnx1JLxF9d8Ra/tdpHBnJvE/IkkL5/qGgxsbC0YcF
         AxK4A6GMjBH2QCBudaZXTQZDIUPKU3d1ll599hkZmaHmFI5IDhJtRZ2BYVslzW63RZqX
         UL6COloDPZcTjIOgt0XQsqdWI81NRyTQDxFaliXd7b4vq2nlWXfBaSZbJEqFH5Qr6EbY
         s8bw==
X-Gm-Message-State: ACrzQf1udxPQGcVlh46VTVjCOP35I8/J4rwNQF665ketLwl+CjupZXUe
        C/VeYBabuFenSIqa0upGi/Q=
X-Google-Smtp-Source: AMsMyM6WyHBjYYGa9Bjkvurtyyqqh3EZNeooWreZveV1eZpmyuNbmbpZbI5QVNm2QBEfmW7PTzS+yg==
X-Received: by 2002:a05:6830:3982:b0:65c:46b7:bb63 with SMTP id bs2-20020a056830398200b0065c46b7bb63mr30738255otb.101.1668093905310;
        Thu, 10 Nov 2022 07:25:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j24-20020a056808057800b00342ded07a75sm5793038oig.18.2022.11.10.07.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/9] thermal/core: Destroy thermal zone device mutex in release function
Date:   Thu, 10 Nov 2022 07:24:52 -0800
Message-Id: <20221110152500.3032655-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221110152500.3032655-1-linux@roeck-us.net>
References: <20221110152500.3032655-1-linux@roeck-us.net>
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
v2: No change

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

