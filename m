Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681386A7517
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCAUQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCAUQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:16:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64874740C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p16so9366398wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS0guMTDp+HnyAw7+AQL4Z1IASYNHpKANmt65sLAMFo=;
        b=eKlbzTcQEFboy8VZXWl8pPk/FXRsZlMf6FKVXjp2UUBsWWWqzXQTW9pnCQ2Vqlmj7D
         8UjwL8Yw5YHQjMLfOexzhkOlPQk9c0cmI4IfOflMQcA/clY+jtznBFL3m1FYYEbGdiDS
         XKTaeiR2LXUdz6HcSz6bhszvAR4xTZ9HR6QbubfAgJklixqSnnulZB2Ol8IGCtRU+vDT
         hMZS3hHRHqesSwndxNEw7nD8ZU9MPL+Va/KpJKAk4Z5Ice7O3RmiQbGXra6a67mERp9j
         vc+5c7s/r9ombVX9U70Pkc0GWlD7EJ3rY0bJ9MluJ6TYbrXbO0CL4gXWc7VmTwldB0Wn
         ZQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS0guMTDp+HnyAw7+AQL4Z1IASYNHpKANmt65sLAMFo=;
        b=i6KdLMV9UGOhIFcpyOzjIPvJpAySW6Blq4sq6er7y/+Cruw5+5iHH+GPu1uHlcyBTe
         uU3FA1sv/3YMDHsReFqiDFZsIgOz5V89IjjWKW8QhEOvRMOw7sU5K+JzktHHSHX6KYA5
         wIDbbP2PVZEoYWY36LvM2LQ/YUtqSMhdqgGRg5Ut1Eog2tkpZx5nqkDvWQtuHiRARF6E
         kl9laMgbLQpPAqQ3iSUrbG2NujdLJGSClP4GOdZN/UvB9EjRzhbA+/uNVrNRCFGJm2be
         m7GOvqPiHZTA9u0Vo4yv4HnYxxI48oB1dRG9RJoSXlBx2EpcVWWaB9zSJ9LdLno5PlVa
         uLuQ==
X-Gm-Message-State: AO0yUKXB58Rzn6dZfruEz/TUzs8bVhA9bl9Y/ZINHzdyqEBmLmhUgcYa
        6s0NfFwogidknFyu69GiegBr9w==
X-Google-Smtp-Source: AK7set8XjOgbxSfKBNwtsRvagJljKV2UG0lSsXcgjMhQzhiTwMigOG6ujpgoQOSfvt1xvuQuKgAQJw==
X-Received: by 2002:a05:600c:3495:b0:3de:a525:1d05 with SMTP id a21-20020a05600c349500b003dea5251d05mr6246294wmq.8.1677701748312;
        Wed, 01 Mar 2023 12:15:48 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:47 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.de>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 15/18] thermal/hwmon: Use the thermal_core.h header
Date:   Wed,  1 Mar 2023 21:14:43 +0100
Message-Id: <20230301201446.3713334-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
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

The thermal_hwmon is playing with the thermal core code
internals. Changing the code would be too invasive for now.

We can consider the thermal_hwmon.c is part of the thermal core code
as it provides a glue to tie the hwmon and the thermal zones.

Let's include the thermal_core.h header.

No functional change intended.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/thermal/thermal_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index bc02095b314c..c59db17dddd6 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -17,6 +17,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_hwmon.h"
+#include "thermal_core.h"
 
 /* hwmon sys I/F */
 /* thermal zone devices with the same type share one hwmon device */
-- 
2.34.1

