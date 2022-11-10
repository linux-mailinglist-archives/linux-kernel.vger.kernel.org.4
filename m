Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0955624599
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiKJPZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiKJPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:08 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD010B56;
        Thu, 10 Nov 2022 07:25:07 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13bd19c3b68so2491077fac.7;
        Thu, 10 Nov 2022 07:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSO/JGqHw5m1/Y8PZVH1KMpl9TGQLAVgPtR2Ov1K83Q=;
        b=hL0xDKbdkurOTH+ZJ8RqK9mu/W5/Nn3jy/R5bg31F2r2Yv6izlO+yxjcypm//piNHi
         f9LkoIlq67C9YYVHzxzyr/HaRR6a4DAFefa4AWDzp45bhkB31ZtUQjDmWDxlwcF9/L5j
         +hq38MWZl3/KDsuIpW+z3Uqi+3iMM8NTdi29RWP6AqRlWBJU6J+mqKySjblFlRBPCcte
         ZTPT1mUYPk+eH1CQS/cQOgZtqPXUTC/gy/o5mjcixvzh3T/TkMB0rbaBILu6xyYw3tsn
         IRUHErAeG2vubG07+oReAXhnRjRj5ROgVSTuRYqTXfF+mLkOCx0m/vta5DPwN0KApJJP
         aVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSO/JGqHw5m1/Y8PZVH1KMpl9TGQLAVgPtR2Ov1K83Q=;
        b=pQDPhyx5jb+EsTbvcx7Mt9OkWtkMUsQgtGeOTLZxrXWJpIh5DuWo0mbGdbkBfMEzA5
         sORJscEDtHQQ6qmhptAiltd1OgabpmD4+rFTYwmJS3hc27X0AuK3qNA2Fpm92IEfDqCz
         7+9lNXQW8bjSLr+uhq/wf6nF51aCHLhaG2aY/FJ9BqbXAUERqr3KF5wKaYQ0opKdFS4V
         gjKYYP2mCwktgG1BbfApjyZavtnZSBl5VhGY6V4FtG4xw3YdRsAPhHhWPOYdUwJkKWg2
         TenM354OgVAqcApypy+OANNRPEPFxMXPaJbKSygmnLmoJ8HQ+eIHRGBUygBP6Evk5FHt
         WZtA==
X-Gm-Message-State: ACrzQf2bzJrCzNkARkjtwajoHnSTevTlxiN+sTpvM3W/heHbsA/UHyai
        2d6Oh7p2eTBB1vbohvYPGtU=
X-Google-Smtp-Source: AMsMyM4qRuoL9gOLv0mThbhHZMTEUzxEYiaHkQY9MCDHpNdAj7jMESvjOo5Xeyn2epCVZsHSmm12Lg==
X-Received: by 2002:a05:6870:aa0d:b0:13b:b765:4791 with SMTP id gv13-20020a056870aa0d00b0013bb7654791mr1528823oab.274.1668093906906;
        Thu, 10 Nov 2022 07:25:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z6-20020a4a2246000000b0049eb2793516sm5271977ooe.44.2022.11.10.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/9] thermal/core: Delete device under thermal device zone lock
Date:   Thu, 10 Nov 2022 07:24:53 -0800
Message-Id: <20221110152500.3032655-3-linux@roeck-us.net>
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

Thermal device attributes may still be opened after unregistering
the thermal zone and deleting the thermal device.

Currently there is no protection against accessing thermal device
operations after unregistering a thermal zone. To enable adding
such protection, protect the device delete operation with the
thermal zone device mutex. This requires splitting the call to
device_unregister() into its components, device_del() and put_device().
Only the first call can be executed under mutex protection, since
put_device() may result in releasing the thermal zone device memory.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 drivers/thermal/thermal_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f548875a016d..562ece8d16aa 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1391,7 +1391,12 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-	device_unregister(&tz->device);
+
+	mutex_lock(&tz->lock);
+	device_del(&tz->device);
+	mutex_unlock(&tz->lock);
+
+	put_device(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
 }
-- 
2.36.2

