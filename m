Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3303761529A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKATyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKATyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:54:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE321838B;
        Tue,  1 Nov 2022 12:54:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so13378wms.0;
        Tue, 01 Nov 2022 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vye8HxSgbJ5V+jvH1roXnBTgLilfVcEjREHvPLd1+J4=;
        b=ZKjLYhzCb5kTc/pGMmnAS+QjR79KN9xMzxUqE9fSAXuiSt1COUtdggm2+he/fVBjDa
         UffrpFN+eIv7RsNliCrL6iST546Gm1g7qlnvFoMYmS4yGMTyUCTBhl2Xy0G9lJR6HkKZ
         WI90Zk+RDl8caGilT5dFVlcaaisOfw1t+TfZzooPW9ZD4we02xZKRHsNspb5mNqZrihY
         6X2+A0XBLeSZSco4dafmOQ5SBzya0LOS5e3Cb8fJRa2fO7CVoO9oRIHP5K9aMeOFbN76
         QIam82coNksFbpinnUe6jEV/WrdaeKDXBEijrPI0YVs89kBirAnfVT9GzWUPi4egyvQC
         Dl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vye8HxSgbJ5V+jvH1roXnBTgLilfVcEjREHvPLd1+J4=;
        b=m7yegr31mTC1R6ziJUC3NvEs47TTI/bfNBIK3qmqbtBWSKEn1+e0dq9j2fKFMfI4qS
         FHAsdU+O9UvTNqJElF9zpnyQOTYN1J8CO9qNH6Fmb/RJEgPwx17oB9c/3etDoMEkbMum
         ngfKukWjJXL1xvCajY31U5Yj+7Iw0sUD3At2rHeqoM0+7mBeTm4olHh/C6wWn5+Kqw6R
         dRrtLsi08QVy/oR5731yNcvbZ2gux0kq0DOfJYMjnD6lVL23VESZ13tA8lBtEYPyz7fz
         g0bMJrRHQFQHg2J77YJvCdnCIIL3K7RB5OWbQyz7Hp2xDWUVSceb3dBDkdut1bfbXA+U
         Zw5A==
X-Gm-Message-State: ACrzQf0oauxjTCZ3gM2VtMC7AK7GDIe0goUpll85ULCSrrKD3F5WkbZF
        yyjuf2KYm3MQUOQPDwxlihA=
X-Google-Smtp-Source: AMsMyM5qbVnKtO+Qn1pVRX6dPqvarmtqXvMGFBaoGOpVyb9l7NxYM18TzWIDmJxm0jOQbFoo7ObHKw==
X-Received: by 2002:a7b:c5d6:0:b0:3c6:f970:e755 with SMTP id n22-20020a7bc5d6000000b003c6f970e755mr13080991wmk.132.1667332447328;
        Tue, 01 Nov 2022 12:54:07 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003cf75213bb9sm6092617wmo.8.2022.11.01.12.54.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2022 12:54:06 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/3] power: supply: cpcap-battery: Fix battery identification
Date:   Tue,  1 Nov 2022 21:53:44 +0200
Message-Id: <1667332425-12536-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
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
index 2659df7..4cfc325 100644
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

