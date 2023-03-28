Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE84F6CC475
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjC1PFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjC1PFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:05:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29EEC4E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:03:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l8-20020a05600c1d0800b003ef6708bbf6so5637448wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1680015819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfc+TC6H1PlSlxFpFQCACZ1XBg01+cDV6KBw8cNxn8g=;
        b=OSxGGIhx4Vg56wUYCQ8KPg1Tn15IEXVy/NE8SBWMkUB+t1fVYmTGzMzAm3e0QMWpo0
         mFD0OFqbk4JF9UVuu1sLUF9zcmjB200QemNxXvwGQEWJ+cauUTiF/NLLKfW5i33tr9x6
         IOZxSnymHZ0Q/vqSBEr0C5QY/RNWiyhS/ANwMlBW0A5f3aJCb4j1shzwZfnt9/a/74ip
         3jcHt6CYFKkvo2t90KcW6wjsCdbRg5eCxBDIYkx6nE5tIToF27jJ4c5ldWacSZfKOc8o
         RN93a69cFu2mrGGIzqa41H/UwG4OSbxPV53X/65FGZ+17LkXm8VynWqRWAKAOmCdv+la
         c+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfc+TC6H1PlSlxFpFQCACZ1XBg01+cDV6KBw8cNxn8g=;
        b=m93ALOIyhEE6ll5z/6TKNle8aTQgLqTs2VnjEhzQ64PMdTPAyLEV4pGBjACZOo5jr+
         4Mpr1zSCXRCzefclbvqJtwbZpaxf0zkdXo6z72jNCwpQTpR7e/y2YWOlV8OII1ftFJpF
         4CH2nrpfhiDueLQE/tFOSzj9mnENWPar//h6xDnm1a2q0tQX8Eu77X2y3iPeZs8Gqbm5
         28MKGxhGdo/NfJ8Z7AJhc5RgnTf/Ic1vKJgY5oxP2/W0hssUaCrR76BgaMB1XEp/mPZF
         peGVikBKG5xe8Y1lR5TUP8XD72j+zp3jAI4iswyf7bg0vw7ddRoEaVZ39ibauORKop+R
         I69w==
X-Gm-Message-State: AAQBX9cl2PcQIow2UpzPIKygnOPUiUMVRUF+NUFPK8qnVcNdBJjB61Re
        M4u39pScbf/DjxeMGupUJgDH0Q==
X-Google-Smtp-Source: AKy350Zq9kh1XDdBrXtJ26uONjHkQWtkYQ+GRH/EveKHYfw0tWJwIteiGoDJWP4n9ulHqlgwF9iL+Q==
X-Received: by 2002:a1c:7714:0:b0:3ed:ea48:cd92 with SMTP id t20-20020a1c7714000000b003edea48cd92mr5643697wmi.15.1680015819441;
        Tue, 28 Mar 2023 08:03:39 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b003ee63fe5203sm17429293wmm.36.2023.03.28.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:03:39 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] hwmon: (pmbus/core): Notify regulator events
Date:   Tue, 28 Mar 2023 17:03:35 +0200
Message-Id: <20230328150335.90238-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify regulator events in PMBus irq handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 509bc0ef1706..86cc8001a788 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3159,11 +3159,29 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 
 	return 0;
 }
+
+static int pmbus_regulator_notify(struct pmbus_data *data, int page, int event)
+{
+		int j;
+
+		for (j = 0; j < data->info->num_regulators; j++) {
+			if (page == rdev_get_id(data->rdevs[j])) {
+				regulator_notifier_call_chain(data->rdevs[j], event, NULL);
+				break;
+			}
+		}
+		return 0;
+}
 #else
 static int pmbus_regulator_register(struct pmbus_data *data)
 {
 	return 0;
 }
+
+static int pmbus_regulator_notify(struct pmbus_data *data, int page, int event)
+{
+		return 0;
+}
 #endif
 
 static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
@@ -3178,9 +3196,13 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 
 	int i, status, event;
 	mutex_lock(&data->update_lock);
-	for (i = 0; i < data->info->pages; i++)
+	for (i = 0; i < data->info->pages; i++) {
 		_pmbus_get_flags(data, i, &status, &event, true);
 
+		if (event)
+			pmbus_regulator_notify(data, i, event);
+	}
+
 	pmbus_clear_faults(client);
 	mutex_unlock(&data->update_lock);
 
-- 
2.39.1

