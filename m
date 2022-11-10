Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C662459E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKJPZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiKJPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:14 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2682D32BB4;
        Thu, 10 Nov 2022 07:25:14 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id a7-20020a056830008700b0066c82848060so1293505oto.4;
        Thu, 10 Nov 2022 07:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ10nOb48x6GWqAJdDBvsYg0lrgcue29G6thFXet4SM=;
        b=n2DGCbHt+mR7onXVMjOXSsZgggtd7o3Re8HqCI0ocAutSYfuU2eFDDf8Jai77X/hxn
         teTHZFGKoRuKrAiSt0NUQembHFQBIwwvamDuu+cz/BmdGeJIckbnb8TA/6DingXhTTlM
         MhE2MDyqCdFrs4hDOkb28rceWfIbIvjrAkVUO8cVelv6jBI7IodWaYYai4AsD6DgTj6G
         a3uI5UmjlVdFNOTMf6evSEVYMzj/JVIUhqousDWQgSAyVNjVYH1+ULpMsgv+ypvDYUfs
         cO015nJazP/FFcsYojL8gECxMXlkrtvrf18vhySVJo08vqHvuLliF0dhS5Vb4M0H+9m3
         T9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQ10nOb48x6GWqAJdDBvsYg0lrgcue29G6thFXet4SM=;
        b=UBLqwP49ELiV7gOOrMmno05+OEFEfDEwdrw1m5BisgVAEuLoE/VcrhU9WX8oPjsW0a
         h7/JUeA+6yWHV4kaiLTjJdcBubfmMa2KI1VQ7pxzdw2cmdbhKkOJtcQO+kk2Ggt/2e/Y
         gtfWVfb07fxJvrptvUbeT+SsMAToPKxXDkPaj4EszgdqQmOwbqDXsqhcxNhcI/2mcomo
         Uqu7SnEdItvYEjdqXw2FZy16rbLgTwLIMtFzGWs0uXLIZ5PaTZZjYdZQiDDeso6whO9V
         Md9V+W9OclafYMi8A2UQOixP05fiXKlfu0ssYJhh48+6y5DGt8krpCQq5uDQ2FN6BYCs
         LxQA==
X-Gm-Message-State: ACrzQf1yJADJ0PS0pIIxKFTS6O/GcK312dhcSKGnpKSdNGtw5HzbyttW
        t7yBj6RFShK/AqGM1kNI24xAc2+hmM8=
X-Google-Smtp-Source: AMsMyM442yTxnWULQ5cboOlghbbZka7nh7aWZUlcO6geeTbFqr8HJBU/EsPbpHQylWpk+QrVCCIWNQ==
X-Received: by 2002:a9d:4b19:0:b0:66c:55d2:c58a with SMTP id q25-20020a9d4b19000000b0066c55d2c58amr26740262otf.273.1668093913460;
        Thu, 10 Nov 2022 07:25:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b20-20020a05687061d400b001324315bb6asm7626122oah.29.2022.11.10.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 6/9] thermal/core: Protect hwmon accesses to thermal operations with thermal zone mutex
Date:   Thu, 10 Nov 2022 07:24:57 -0800
Message-Id: <20221110152500.3032655-7-linux@roeck-us.net>
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

In preparation to protecting access to thermal operations against thermal
zone device removal, protect hwmon accesses to thermal zone operations
with the thermal zone mutex. After acquiring the mutex, ensure that the
thermal zone device is registered before proceeding.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Simplify error handling to avoid additional goto.
    Do not use ternary operator in modified code.

 drivers/thermal/thermal_hwmon.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index f53f4ceb6a5d..c594c42bea6d 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -77,7 +77,15 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int temperature;
 	int ret;
 
-	ret = tz->ops->get_crit_temp(tz, &temperature);
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(&tz->device))
+		ret = tz->ops->get_crit_temp(tz, &temperature);
+	else
+		ret = -ENODEV;
+
+	mutex_unlock(&tz->lock);
+
 	if (ret)
 		return ret;
 
-- 
2.36.2

