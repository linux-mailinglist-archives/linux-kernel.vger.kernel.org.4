Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96367600FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiJQNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiJQNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:39 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDE9FDC;
        Mon, 17 Oct 2022 06:09:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so5739070otb.8;
        Mon, 17 Oct 2022 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwRejXer5Ur/UoCRRVie9rgEWzLwsDyLLE/R9VX6Lfg=;
        b=NqU8PvVseFrjUduslOpG55OpX156OcwaqAIKEcPUs7QDawFmImH0oWY2PhNbZb8+ym
         imH1qx6uQSX7oLKheirQpKNa5H46dFnFvGBw7YbQXRdo5x0+vcVH131mIj1HgF1OFQHS
         ACxH1PHJNRxdAZ/z5k1vB1BRTGPbzxz2mDSUz77gXnxVKPuep722RZ76DnHn5Rs8E+BZ
         1tr+SxiZtChqgALmebo++LZiPa9ep5DJ2Ax9Yifomt+ey55K0rrkbid7exZ3Em1pfvDY
         E82DX76B6DnL+wbkIVgmO3iEP1rTz7Z6XJ3UO6Bsd8lDR5mN9liiGzsVWoX13rKvkwZb
         Vc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BwRejXer5Ur/UoCRRVie9rgEWzLwsDyLLE/R9VX6Lfg=;
        b=dk9c6iWIuDLEYP7MVx+wOSBX0JxsZJs2RFBv7fqZGwCyDxnWe98H8Rs0K7hS58lgkk
         kWXInTg+0LKvydu+vbGef0GOVfuWyA6c71iGI7JY9k6zaK0eRkqLkjC9kP1R7qvjiVJ8
         vWjI93TtazESoTj1/6/YnJNJ+unW0bw1F6wiaeDHiTC7GCQ/V4js3E+tL9H6e+s47ckA
         so3zYryCy2/nUIH/a+iGW3M3uOMNdDsfrnjeMcvwsyAwUX8RMyKyctRyqr2JheMpNuZ5
         T4wnTX2yhhfTAwCBKARm7QkdeRdDziiijyMTih5EnZi/H0HkbnMjV3rCizX7v/vxopbC
         2NkQ==
X-Gm-Message-State: ACrzQf1pKl1ynmjJhDvosiU9Qh6ZJEEKfNJCBllXAZQO15tNA4XD+qg3
        2h9mluhlYP0UbHaQcra/vnU=
X-Google-Smtp-Source: AMsMyM4LHh3MJpONO2ERGktRDxhkSy/vP9dY+HCyWlkhaokEJWdcADgZ19J9Ab4UnoDNW6kqqKh1qQ==
X-Received: by 2002:a05:6830:660c:b0:661:a38c:a1f9 with SMTP id cp12-20020a056830660c00b00661a38ca1f9mr4819013otb.238.1666012166409;
        Mon, 17 Oct 2022 06:09:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l20-20020a0568301d7400b00661a3f4113bsm4649136oti.64.2022.10.17.06.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 9/9] thermal/core: Protect thermal device operations against thermal device removal
Date:   Mon, 17 Oct 2022 06:09:10 -0700
Message-Id: <20221017130910.2307118-10-linux@roeck-us.net>
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

Thermal device operations may be called after thermal zone device removal.
After thermal zone device removal, thermal zond device operations must
no longer be called. To prevent such calls from happening, ensure that
the thermal device is registered before executing any thermal device
operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b8e3b262b2bd..aa0107f11c98 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -203,6 +203,9 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
 	mutex_lock(&thermal_governor_lock);
 	mutex_lock(&tz->lock);
 
+	if (!device_is_registered(&tz->device))
+		goto exit;
+
 	gov = __find_governor(strim(policy));
 	if (!gov)
 		goto exit;
@@ -445,6 +448,12 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 		return ret;
 	}
 
+	if (!device_is_registered(&tz->device)) {
+		mutex_unlock(&tz->lock);
+
+		return -ENODEV;
+	}
+
 	if (tz->ops->change_mode)
 		ret = tz->ops->change_mode(tz, mode);
 
@@ -486,7 +495,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
 	mutex_lock(&tz->lock);
-	__thermal_zone_device_update(tz, event);
+	if (device_is_registered(&tz->device))
+		__thermal_zone_device_update(tz, event);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
-- 
2.36.2

