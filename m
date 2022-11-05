Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966C761D9B0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKEL03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKEL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:26:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F21C93B;
        Sat,  5 Nov 2022 04:26:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b2so19256128eja.6;
        Sat, 05 Nov 2022 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mvbWRnJLjkEbJwbK1HqoKZYYWWWpHEGeJghtyoGl4P0=;
        b=C8gR2s0AAAG6uGJhhbsKl5NJ2n+1peuiSWA7QXTiZTMalCVYF+kWkYB4pzVxrQPawu
         RKLgbkvoQDXSjjiuyYupi3fNKABc1mppEqnPCuuNxIswwNEdB9js1on29IY/Y3KZYxp6
         nnWbgja5HcwueVtL5j5vmXpzGc491l49mzUnQo+fIUJhPmEyQ4KPGnLsaX+y+8Zp08Ca
         ErkVwbpcVmFgQ3egvFuvyQOuEPy++nUCS2tf1zq0r+4wxAyTXX05mP3J4WFH28Mbe82V
         J868hOcDys45rd3Z7hxksZkNznnB+4q7796VJXRrIbDdnpB17jFdYItX5VVZhWRRpQDm
         W8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvbWRnJLjkEbJwbK1HqoKZYYWWWpHEGeJghtyoGl4P0=;
        b=P4GUQiILJkv+yQk9hvxhchX2xjR/8VviVHdN5pY3HY84szVXOQysHKIjfSfHVFuqHn
         1m262+HrVjTVvVVaZNBQsffHapLdDexC+rfr+XOI7Cym77cEal9FssAQuwo/VAa+nesa
         7ln8uumdi/SiW4iSoBldAX2jkJ6s86BjhOPvCq1ioo8m/BCCYIvRo+QmLwOBIBPCow4o
         hy1j57IcVbqpGLMbY7nUaKvP/YYngLEgxLUA3fV2WuzV256VzuaBftWo+kHsqotNMpwH
         3rdHB7nv4I5sWuD53ZEzJYNTgEheLr8UCOalM4fi8ENqcBwfKLMJZnhmZiD0fIxyYbD5
         EtRg==
X-Gm-Message-State: ACrzQf3tRs7afrX78re9n43+jdmZKw5FE1yU+bxfJOoM0j0uS9+vEuba
        yeNDRRsqNCRvu/bh6nra/DQ=
X-Google-Smtp-Source: AMsMyM5gSZ3vMm058PZBZ+dQHGu5BEHhBA2xxSSBckD8jzrtkNp0w2PkNJJdyWNC4caX/Fw4xiXNCA==
X-Received: by 2002:a17:907:608f:b0:78e:1b60:60e2 with SMTP id ht15-20020a170907608f00b0078e1b6060e2mr39212115ejc.382.1667647576266;
        Sat, 05 Nov 2022 04:26:16 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id u18-20020a509512000000b004611c230bd0sm1050069eda.37.2022.11.05.04.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Nov 2022 04:26:15 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/3] power: supply: cpcap-battery: Fix battery identification
Date:   Sat,  5 Nov 2022 13:25:43 +0200
Message-Id: <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same logic to identify genuine batteries as Android does.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 8869067..ca6ee2b 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -422,7 +422,7 @@ static int cpcap_battery_cc_to_ua(struct cpcap_battery_ddata *ddata,
 
 static int cpcap_battery_match_nvmem(struct device *dev, const void *data)
 {
-	if (strcmp(dev_name(dev), "89-500029ba0f73") == 0)
+	if (strncmp(dev_name(dev), "89-500", 6) == 0)
 		return 1;
 	else
 		return 0;
@@ -439,10 +439,19 @@ static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
 	if (IS_ERR_OR_NULL(nvmem)) {
 		ddata->check_nvmem = true;
 		dev_info_once(ddata->dev, "Can not find battery nvmem device. Assuming generic lipo battery\n");
-	} else if (nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
-		battery_id = 0;
-		ddata->check_nvmem = true;
-		dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
+	} else {
+		char buf[24];
+
+		if (nvmem_device_read(nvmem, 96, 4, buf) < 0 ||
+		    strncmp(buf, "COPR", 4) != 0 ||
+		    nvmem_device_read(nvmem, 104, 24, buf) < 0 ||
+		    strncmp(buf, "MOTOROLA E.P CHARGE ONLY", 24) != 0 ||
+		    nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
+			battery_id = 0;
+			ddata->check_nvmem = true;
+			dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
+		}
+
 	}
 
 	switch (battery_id) {
-- 
1.9.1

