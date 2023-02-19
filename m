Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96569C0EF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBSOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjBSOih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:38:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3810A82
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e2so659262wri.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o2qPN3/yYW8lF91ZCBRnsgBQhkI6h9wnRlSg/COMqw=;
        b=nIMl4jAbExXJgFyaCfJqOhgTWrmLu3C8v2CaRKcFnQIvN2CqE9VK5dWCRdt37ABDqU
         N78F3tB+/mOUmIvfWCU4DJf1/UgyOn+7sr4pLKu6hpHg4MNrUjbSVvu3PCLS04bLPQKN
         Gpl/jwQQD5skko7FPKT5ZyJV+trTpB7rAaI4wbVX8teLZIuVNpMHgxO9NLS3KHfDPDqA
         hDk+DVqv9Zg3ReQlOpLZtbb2Qbjt3KZKNrQFgfrWyL+U37qMVGWAsyf86/l3w0Q3riOY
         LMyaB2IQUseLY/hP8MhrusWNMDsBvEg3TjRc/OHmis9SolJ2oB2rgpZf5VQrVrXO+JAf
         aVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o2qPN3/yYW8lF91ZCBRnsgBQhkI6h9wnRlSg/COMqw=;
        b=RWDXdVreO0LdrtCU5Fi38TcHMd9YVICPHRHneGGYVKgA0bHcwqDu9Pq1lOxx7m5HrP
         3Oz/ubQ6cJ70AB+n7GE+a1vRhH29EZZ6IzTEIOnQpkY/ylxvPDXF+1KDw71+dpW4Oi1R
         G21l4Qf4El4kwMcualvJ+r0r4UzafWg8yAQn5D3f9Cr6yFiMd8N/bs719H7Nles0hphr
         0Q315FDuUpOgik7w5T51Txo5Hb59GqoBkhs7ghV7zAqMA1VXM00kIXc6cKGudHiOnEn7
         /qLMdfnu/ghNGtcXGC4Jz8C521x6DnhIzEYyty1hbxEsbe9iuLqCtq9mTmjJNwC//1zz
         fJbw==
X-Gm-Message-State: AO0yUKUFgIoa8OpxvkGyv6bS55nqmmuzyD/ul1nUS3VDeNu8YfGu1eL0
        h9MARjck8SMlnYMEsAzbdYstfw==
X-Google-Smtp-Source: AK7set+NvkQE4qL74JGUamf8KJhlCGSE06Lyjy/dgum0HQGWrelDK/Ibwr7TJ5POVxuaQ1ehKJxmKQ==
X-Received: by 2002:a5d:4d89:0:b0:2c5:8ca5:58a3 with SMTP id b9-20020a5d4d89000000b002c58ca558a3mr91236wru.59.1676817491835;
        Sun, 19 Feb 2023 06:38:11 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:11 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 12/17] thermal/hwmon: Use the thermal_core.h header
Date:   Sun, 19 Feb 2023 15:36:52 +0100
Message-Id: <20230219143657.241542-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 15158715b967..e1b9e95deade 100644
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

