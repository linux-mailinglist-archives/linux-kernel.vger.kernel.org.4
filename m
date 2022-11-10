Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4712E62459C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiKJPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiKJPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:11 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07CF2CCB2;
        Thu, 10 Nov 2022 07:25:10 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13b23e29e36so2484168fac.8;
        Thu, 10 Nov 2022 07:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPRDmNkrm1vn+V+1JEnLY9+b9B506P/EqjPsjoC9grA=;
        b=KKlnEPm2PbaBOKwE1hreqVjPeEksFU9/M3Q+oOqwhTimgksD4vs0scvu1vOcPsSSaV
         GrWRxwkb/nKRMPhjMl8YdlQaVZsPe5c6AAcfBZwi6Yg38A/qDMtYNQ0lRUZ3s0nuE/Sm
         lcx0UdiW4tJJNh9YhZns0/iSu2DNr59c5VWVXF+Gr1IElswx/TLXKJ/gdrcBqMVFKFDE
         ejDizxQHa9DY2P3LI8ywPLjOp6Q9TSVG7mY0pMohSFQbZJ/sHm9kIY0K9K7N0Gh8rNM9
         YdcVmvQPen05DhLcjrR0fRadV0Q7rbzm5vBYlTO2E7plgaEJA4nilboEN35MD9E2ViPL
         tK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPRDmNkrm1vn+V+1JEnLY9+b9B506P/EqjPsjoC9grA=;
        b=1YlPk021bUnG0CwecgOs8RF50zHWOF3YQhwVEESpd0B2RLPMI2mr6W3VCw/Sh2K1xG
         5yUx5eRRdtkp3FOfBzdO6J6cKcmeJlSEAE5A+ktv2k4zdARqtxvqczUij2ziWM1Mqyy0
         M7CyLFu8EnFv2KSrClv/yAcfAs4cFfq2A9t3UMARQq0jyXb1PQilPol85gIrZA2H9pta
         G/Dh49EavRmln+oSQ/WjCJjtc1VGTDV/pifR2ipOZ5I2fb7DC5M3IQpEGc+/WQvgBcs9
         djWoVu00XahjTDwRbjbpCpLViQorkAlkeJZlJdim4P4H9OwUivIp/bOAeeontsAVaBff
         MqAw==
X-Gm-Message-State: ACrzQf2uIAlpQTnWlEJy6K8cUkazrsvzO0US8N7Rnro7SS4HW4ezTlz5
        P9gqdBLE0fSdXd3n/XChD5k=
X-Google-Smtp-Source: AMsMyM7c77/F8/pD3IV573ddlDZXkCtszUj2iM4SZiq4hbS00G38a5zhJVQ7IvR+nMQTMC1MAb/I4w==
X-Received: by 2002:a05:6870:525:b0:130:9e35:137a with SMTP id j37-20020a056870052500b001309e35137amr37067612oao.88.1668093910340;
        Thu, 10 Nov 2022 07:25:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r7-20020a056830418700b006618586b850sm6582808otu.46.2022.11.10.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 4/9] thermal/core: Move parameter validation from __thermal_zone_get_temp to thermal_zone_get_temp
Date:   Thu, 10 Nov 2022 07:24:55 -0800
Message-Id: <20221110152500.3032655-5-linux@roeck-us.net>
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

All callers of __thermal_zone_get_temp() already validated the
thermal zone parameters. Move validation to thermal_zone_get_temp()
where it is actually needed. Also add kernel documentation for
__thermal_zone_get_temp(), listing the requirement that the
function must be called with validated parameters and with thermal
device mutex held.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add note about added kernel documentation to description .
    Use IS_ERR_OR_NULL instead of manually coding it.

 drivers/thermal/thermal_helpers.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index fca0b23570f9..321f8020082d 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -64,6 +64,20 @@ get_thermal_instance(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
+/**
+ * __thermal_zone_get_temp() - returns the temperature of a thermal zone
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @temp: a valid pointer to where to store the resulting temperature.
+ *
+ * When a valid thermal zone reference is passed, it will fetch its
+ * temperature and fill @temp.
+ *
+ * Both tz and tz->ops must be valid pointers when calling this function,
+ * and the tz->ops->get_temp callback must be provided.
+ * The function must be called under tz->lock.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret = -EINVAL;
@@ -73,9 +87,6 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	lockdep_assert_held(&tz->lock);
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		return -EINVAL;
-
 	ret = tz->ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
@@ -114,13 +125,22 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(tz))
+		return -EINVAL;
+
 	mutex_lock(&tz->lock);
 
+	if (!tz->ops->get_temp) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	if (device_is_registered(&tz->device))
 		ret = __thermal_zone_get_temp(tz, temp);
 	else
 		ret = -ENODEV;
 
+unlock:
 	mutex_unlock(&tz->lock);
 
 	return ret;
-- 
2.36.2

