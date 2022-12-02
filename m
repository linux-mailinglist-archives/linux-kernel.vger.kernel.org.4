Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F9E640AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiLBQgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiLBQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:36:21 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF5F92FF1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:36:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id fc4so5835858ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTfsSfwZwkecUTqY7J0NcVfk6tqWDBxDeWzJix7mI0g=;
        b=f6uTGOEJ6elrS5hWZZ+3f5mt5agG6XuLyJFtsH5d+1vwQETaD4+0Ndk+KuzMnaQ1Uo
         4bkehW6so7BEChtjTAApH0kLF8hnqFpZsFAl3qCHv0YHAvkYfKBRrDQMGvwbzJS9ZCHj
         vo/Sj48fBSRK+5XFgY3r8bQPjYzAFlcshSvdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTfsSfwZwkecUTqY7J0NcVfk6tqWDBxDeWzJix7mI0g=;
        b=tFcQDZYULGsGHaBGq6/fWDzUVZf1AyYWWz105s2KiIAGlUbfYEeUyIh3qohQ5nPzCB
         q8mG1+xd2HVj33l2oqBIPE01jnYVccxHJyw/jvUXQQYGRqfQF0xVaweU25THJ/Q5cCBx
         /e103YUzjNmDosxHkEDCYQPVvQw9quUfAgQvQ8TVhUyWN4p/DqnccQQrfXDbTV1X+SEP
         lN04PsLxBoVQOsYUbITJgiaKnu6DyLsc8lWtoOj9fhQphYzYee0KJad/0DNq4VSWdg8j
         HMHTu5kC6eQbNXplIbt+mSsW+oaCEHq2GS5qjvXwvACYut3YPm2i3+77OVZbzFxcn49O
         tD1Q==
X-Gm-Message-State: ANoB5plakNNp2e4FYwylO+SrVkdyc2TVvbNjuXvoMJynLtVH0SiaAaQ1
        Uz1Jq7PBQ+w8/P0weCRqO63W6Aw/fjthh1dRWR4=
X-Google-Smtp-Source: AA0mqf6BoozUELhBhW30z7XeDO1/hKYSc6nf+BW/zqOcHQJph9jwPFzeRQdVFF1L1OhBH1aWKU1Ueg==
X-Received: by 2002:a17:906:cc8f:b0:78b:8ce7:fe3c with SMTP id oq15-20020a170906cc8f00b0078b8ce7fe3cmr60745459ejb.557.1669998979244;
        Fri, 02 Dec 2022 08:36:19 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0079dbf06d558sm3159125ejf.184.2022.12.02.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:36:18 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 17:35:59 +0100
Subject: [PATCH v2] media: i2c: ad5820: Fix error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220921-ad5820-v2-0-3e5cabb04786@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pali Rohar <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=BpgwaMzMJqVURp63/UtwLeKeq6j68HUmKu2qHJ8ERhg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjiil/rNTPe0uVTyxrJec0gzkWuf0fgTL0Xw9TfGI8
 KWsj5p+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4opfwAKCRDRN9E+zzrEiP9CD/
 9C+soFU4bC3FwIuSrPVrWymioupe4RZJ6mlXY8qV1Ur2UlwGgoXCpQw9gibbokM+RxOjfxhJajRm7Y
 vEpPWlWUDlDnBaeOmBes5yAgu44SSQeSnvH96qRl/gv8WQ4yQUixcE/Qj4kiI+olWXaEJKAR+6+HNh
 wgkIn2V+Bzw9H6nzxcCoBfQrXnzRchtrpYd368NnDZOK5VIGBrEtTx2Zy8DGOsBgsIYG2yme43CPo/
 k1EZDWz98VMpStVCrqWZIoZ57RgwWDNrR5Qn+1tKD2JtQOVMejQvnfd1S64X9c6q1TLAzcLcttbpjS
 pgj2KxEqziAZBFm1+Lp+IOSekelCRyO4uUwT33TBETBZL59Y1vlHfCWBl+9ESH86IYV7PHSMIzm3NR
 W2pUrV9QJ6QZOM5D+wWArumPNGXnzH19zN9A+HiJWYM2oULXNENP8+ggw603eomHhnjRJ/JqmI+Grp
 om2CCbQSUenr9gpyfXWAvCoPWbHCssW1Ef4NJpaVBLH8dCqPBs7Q2MacHlbW+Kiknz24b0zgFDTXai
 hsjlBciZIbckUmOFNkI+VrRI9YThYQyALBChsLviD5AmUPD9kf5Rv/wseQu0wjlUzXn7Bk5vhL405r
 Hh9SQ10hEZ87nlH2U/reNDvib4qBUNQ15WjA+k17We5XT6N2w7ejy2ti4iaw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error path seems to be swaped. Fix the order and provide some meaningful
names.

Fixes: bee3d5115611 ("[media] ad5820: Add driver for auto-focus coil")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
media: i2c: ad5280: Fix error path

While revieweing dev_err_probe() series I found something weird,
lets try to fix it.

To: Pavel Machek <pavel@ucw.cz>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Pali Rohar <pali@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- Rebase on top of linux-master
- Remove non-ascii chars from To:
- Link to v1: https://lore.kernel.org/r/20220921-ad5820-v1-0-871c517d69fc@chromium.org
---
 drivers/media/i2c/ad5820.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 516de278cc49..a12fedcc3a1c 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -327,18 +327,18 @@ static int ad5820_probe(struct i2c_client *client,
 
 	ret = media_entity_pads_init(&coil->subdev.entity, 0, NULL);
 	if (ret < 0)
-		goto cleanup2;
+		goto clean_mutex;
 
 	ret = v4l2_async_register_subdev(&coil->subdev);
 	if (ret < 0)
-		goto cleanup;
+		goto clean_entity;
 
 	return ret;
 
-cleanup2:
-	mutex_destroy(&coil->power_lock);
-cleanup:
+clean_entity:
 	media_entity_cleanup(&coil->subdev.entity);
+clean_mutex:
+	mutex_destroy(&coil->power_lock);
 	return ret;
 }
 

---
base-commit: a4412fdd49dc011bcc2c0d81ac4cab7457092650
change-id: 20220921-ad5820-73d40ca9f707

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
