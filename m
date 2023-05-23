Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255BD70E718
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjEWVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbjEWVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:04:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E9EDD;
        Tue, 23 May 2023 14:04:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae6dce19f7so966465ad.3;
        Tue, 23 May 2023 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684875883; x=1687467883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gONh6AqSE8N1Psg514GpnJnE48CzNdfkrGouBQ/djr4=;
        b=nZUpMOBvl6yP+qAhDzHDqe1HYqYQC3avvla5rUfI76OKHwnGLf9zNQiyOpGTPqib09
         9RMDyVtINPaXjHK6zJ/DmK7Fmjx22LLzSr+FbBz1mi5zfAovXMk6Y8mYWz2k5ODfmZKy
         ceYMm7Hwsi4O2vLsDxv7WXeRXsjorVtVUTnxrQBGMIg0NE3p2gzAivfzZXytjXVAlMeP
         V3oWa4gLTCap064aHhC2wDcZb9Jh9J401u2akwr4vqazL0PEmeKHKXDw3dDPtwUsjlZA
         y0msvzNJyQFyyuevsr+Ixm5r37nQ/4pE0mzLLUCDsZY2r1k6UjUFB9SV+MUOpQuQNQhs
         yvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875883; x=1687467883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gONh6AqSE8N1Psg514GpnJnE48CzNdfkrGouBQ/djr4=;
        b=O0Ycb71L6JNt5QtRYzsEdIHgNQlDVUqLJknmNeTexDewzCwEAECoeCvjuVf1M4BcTW
         2Qx3Wk+6+XcJ939ZKPiYu52vjDVjOdJ5zOmTvZXDbvMP4of2uQUClG45tl8KTiXP+5e8
         9bnWM5DI2HTdwp5o9uzY335Xe9kzwGp3xjAlbiiXfSn2gi42fF51gPZOELhLOBK0giCq
         Gh43IVnboPgh+2yt5afn5WtWEsgqAQNu4eiEMqw3qKNkrl0JInn2SX+Pn+EB3PSGRYJ/
         nb3aM3F941kGcI9YbN9uFj0nuJYiEMoFyvIg0L2qWqz8M5W9Ze2Ei87HLXvUKsx6S79K
         sh4g==
X-Gm-Message-State: AC+VfDya9UmnjD2a/EsMWBwGCxrNfg7cq95YqZZDy2UMqYIGheKI8OII
        aqAj1DNTNfVizvn8sW1MMls=
X-Google-Smtp-Source: ACHHUZ4Dnt1VLPDpRGY9Y5FeKCb3CK0PNv4NJD8lKqy7SMpM7CB0fiB8o755iKbQgnJxYpWL811dkw==
X-Received: by 2002:a17:903:18b:b0:1ad:d995:54a with SMTP id z11-20020a170903018b00b001add995054amr16689333plg.46.1684875882586;
        Tue, 23 May 2023 14:04:42 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001ab01b909c9sm7216892plg.120.2023.05.23.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:04:41 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 2/2] HID: ensure timely release of driver-allocated resources
Date:   Tue, 23 May 2023 14:04:32 -0700
Message-ID: <20230523-hid-devres-v2-2-5220211a428c@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230523-hid-devres-v2-0-5220211a428c@gmail.com>
References: <20230523-hid-devres-v2-0-5220211a428c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-2eb1a
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More and more drivers rely on devres to manage their resources, however
if bus' probe() and release() methods are not trivial and control some
of resources as well (for example enable or disable clocks, or attach
device to a power domain), we need to make sure that driver-allocated
resources are released immediately after driver's remove() method
returns, and not postponed until driver core gets around to releasing
resources.

In case of HID we should not try to close the report and release
associated memory until after all devres callbacks are executed. To fix
that we open a new devres group before calling driver's probe() and
explicitly release it when we return from driver's remove().

This is similar to what we did for I2C bus in commit 5b5475826c52 ("i2c:
ensure timely release of driver-allocated resources"). It is tempting to
try and move this into driver core, but actually doing so is challenging,
we need to split bus' remove() method into pre- and post-remove methods,
which would make the logic even less clear.

Reported-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20230505232417.1377393-1-swboyd@chromium.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 17 +++++++++++++++++
 include/linux/hid.h    |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1f0bb2784bfc..4b7062dcefec 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2614,6 +2614,10 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	if (!hid_check_device_match(hdev, hdrv, &id))
 		return -ENODEV;
 
+	hdev->devres_group_id = devres_open_group(&hdev->dev, NULL, GFP_KERNEL);
+	if (!hdev->devres_group_id)
+		return -ENOMEM;
+
 	/* reset the quirks that has been previously set */
 	hdev->quirks = hid_lookup_quirk(hdev);
 	hdev->driver = hdrv;
@@ -2626,7 +2630,16 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 			ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	}
 
+	/*
+	 * Note that we are not closing the devres group opened above so
+	 * even resources that were attached to the device after probe is
+	 * run are released when hid_device_remove() is executed. This is
+	 * needed as some drivers would allocate additional resources,
+	 * for example when updating firmware.
+	 */
+
 	if (ret) {
+		devres_release_group(&hdev->dev, hdev->devres_group_id);
 		hid_close_report(hdev);
 		hdev->driver = NULL;
 	}
@@ -2669,6 +2682,10 @@ static void hid_device_remove(struct device *dev)
 			hdrv->remove(hdev);
 		else /* default remove */
 			hid_hw_stop(hdev);
+
+		/* Release all devres resources allocated by the driver */
+		devres_release_group(&hdev->dev, hdev->devres_group_id);
+
 		hid_close_report(hdev);
 		hdev->driver = NULL;
 	}
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 4e4c4fe36911..39e21e3815ad 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -597,6 +597,7 @@ struct hid_device {							/* device report descriptor */
 	struct semaphore driver_input_lock;				/* protects the current driver */
 	struct device dev;						/* device */
 	struct hid_driver *driver;
+	void *devres_group_id;						/* ID of probe devres group	*/
 
 	const struct hid_ll_driver *ll_driver;
 	struct mutex ll_open_lock;

-- 
2.40.1.698.g37aff9b760-goog

