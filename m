Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178806D07C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjC3OLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjC3OLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:11:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2465BDEA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:11:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d17so19217083wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680185495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+FoJdn0v3mxQP8H3rv8z+g2SXXjZfcMeYd0mBDcN58=;
        b=a49YjFIziZlCSUFnzcypUe3Vbs/P/pZFB1JfUdfg1cCflz0+0TpTIqRyvVav/hYc2O
         ygZG6EhI3MLhz+tAlP8PaSKGZO+aA7TZ9gnTwHIzlnqLSFuNQHVCAkQw6Lk4hLd6qe9q
         w9UgFcBtHjjzeUkAtDIxBBrtK2cSlYn3baAUx4G/V9wsUz4c2uZadquagx/bTH8m4zAS
         uSq18TxuF2jpOa+YaoLG/lRy8euHZnwQ3kRAdBkB3183bF8jbr2OgRyTRLbBStpc/+69
         avifYLVbfUYOfHZTAYLn7YnTnLsasqRktRAYcLK+FDxTWXCuXL8gZZQqrGeYjSEIUpFU
         lqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680185495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+FoJdn0v3mxQP8H3rv8z+g2SXXjZfcMeYd0mBDcN58=;
        b=dnb4aPU01fv4vZRxpWedoTCXUMrdVo0bKZbsv1fWTXb6PlOpCXglzJDI5rTOzhCCc0
         pMwJNXVMwYtWiGvA3fkx8Qmxwm88vz80sIyopJU/0NXQ4v8wtBUmuyYtrXJVH4LT25b4
         qOF5VB1cTKW8n769HUTG89lqUCi0qCW70CHMKdHkRpinijEQcSBC7AYPR5nDfgvoM9gd
         Riwug+X/XBw1nihbgpd6MefbqxOo8TM3H/7/gGCpuVfV/L9tNRHHi1wx5xpN+IYjJrJF
         7V4pjqTz2xQKp5bgQGWgVX0nsxFwP1xY6svSLzI5EkZ6L4CHRk0yOBbuhhImy+gF8ybD
         CM/A==
X-Gm-Message-State: AAQBX9cp8qV4vdWOPin6hPyxHm4UPWQ7T6R3XRESlbAqYIXezVHG52zs
        ScjaxeuVaF3wT1VEcHqh9kQ=
X-Google-Smtp-Source: AKy350bWVUPToKKGL3iWneHoEStvcoEquC3yrNGYcOy60iAv+Ky8hm0FdCIU3pgtTNqsbC8TVFQoow==
X-Received: by 2002:a5d:500a:0:b0:2cb:29eb:a35e with SMTP id e10-20020a5d500a000000b002cb29eba35emr5019627wrt.11.1680185494763;
        Thu, 30 Mar 2023 07:11:34 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id b5-20020adfee85000000b002c573778432sm32761705wro.102.2023.03.30.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:11:34 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
Date:   Thu, 30 Mar 2023 19:11:25 +0500
Message-Id: <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680185025.git.kamrankhadijadj@gmail.com>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel coding-style suggests to fix your program if it needs more
than 3 levels of indentation. Due to indentation, line length also
exceeds 100 columns, resulting in issues reported by checkpatch.

Refactor the arche_platform_wd_irq() function and reduce the indentation
with the help of goto statement.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/greybus/arche-platform.c | 79 ++++++++++++------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index a64c1af091b0..dde30c8da1a1 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -158,49 +158,52 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 
 	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
 
-	if (gpiod_get_value(arche_pdata->wake_detect)) {
-		/* wake/detect rising */
+	if (!gpiod_get_value(arche_pdata->wake_detect))
+		goto falling;
 
+	/* wake/detect rising */
+
+	/*
+	 * If wake/detect line goes high after low, within less than
+	 * 30msec, then standby boot sequence is initiated, which is not
+	 * supported/implemented as of now. So ignore it.
+	 */
+	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
+		goto out;
+
+	if (time_before(jiffies,
+			arche_pdata->wake_detect_start +
+			msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
+		arche_platform_set_wake_detect_state(arche_pdata,
+						     WD_STATE_IDLE);
+		got out;
+	}
+
+	/* Check we are not in middle of irq thread already */
+	if (arche_pdata->wake_detect_state !=
+			WD_STATE_COLDBOOT_START) {
+		arche_platform_set_wake_detect_state(arche_pdata,
+						     WD_STATE_COLDBOOT_TRIG);
+		rc = IRQ_WAKE_THREAD;
+		goto out;
+	}
+
+falling:
+	/* wake/detect falling */
+	if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
+		arche_pdata->wake_detect_start = jiffies;
 		/*
-		 * If wake/detect line goes high after low, within less than
-		 * 30msec, then standby boot sequence is initiated, which is not
-		 * supported/implemented as of now. So ignore it.
+		 * In the beginning, when wake/detect goes low
+		 * (first time), we assume it is meant for coldboot
+		 * and set the flag. If wake/detect line stays low
+		 * beyond 30msec, then it is coldboot else fallback
+		 * to standby boot.
 		 */
-		if (arche_pdata->wake_detect_state == WD_STATE_BOOT_INIT) {
-			if (time_before(jiffies,
-					arche_pdata->wake_detect_start +
-					msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
-				arche_platform_set_wake_detect_state(arche_pdata,
-								     WD_STATE_IDLE);
-			} else {
-				/*
-				 * Check we are not in middle of irq thread
-				 * already
-				 */
-				if (arche_pdata->wake_detect_state !=
-						WD_STATE_COLDBOOT_START) {
-					arche_platform_set_wake_detect_state(arche_pdata,
-									     WD_STATE_COLDBOOT_TRIG);
-					rc = IRQ_WAKE_THREAD;
-				}
-			}
-		}
-	} else {
-		/* wake/detect falling */
-		if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
-			arche_pdata->wake_detect_start = jiffies;
-			/*
-			 * In the beginning, when wake/detect goes low
-			 * (first time), we assume it is meant for coldboot
-			 * and set the flag. If wake/detect line stays low
-			 * beyond 30msec, then it is coldboot else fallback
-			 * to standby boot.
-			 */
-			arche_platform_set_wake_detect_state(arche_pdata,
-							     WD_STATE_BOOT_INIT);
-		}
+		arche_platform_set_wake_detect_state(arche_pdata,
+						     WD_STATE_BOOT_INIT);
 	}
 
+out:
 	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
 
 	return rc;
-- 
2.34.1

