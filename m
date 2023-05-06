Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2D6F8D0C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjEFAJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEFAJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:09:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB619B0;
        Fri,  5 May 2023 17:09:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6434e263962so1881992b3a.2;
        Fri, 05 May 2023 17:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683331760; x=1685923760;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5vlwuQQzarAYkhB292oKMA0GoqtakjsP3WeXM4SqcU=;
        b=RCAo8XhwccTmXXwMkX6qh8DDee6r40bHnCPYaP31nxoxPF4jpsBYZ3xId2IqacgXvy
         UyNR6ow8E5/uInZptjPw/68CtCh7jOjtId5byDWi4UHHsfAMOpO7hYLe1McZhnZ07Z6y
         ExMzRBVMrZOB9EVwG8yQ1bowy6S5DTCU0EmT7f8k4u4lDO77wGdHZ7dVWpkWt9EWKlv3
         o+rrN90HG2MwgyCeCfrwa9UUpQ19h7TBosjyzVbpR7dhVy8csFcYTwEnwyqZ7kRDxFUu
         XD+bnmB2qICs+TEb2raKaQLMzMZTPPHvavXBKTmo3yuOCWvhJ375XpJlkqY5VH5A/Inr
         MCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683331760; x=1685923760;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5vlwuQQzarAYkhB292oKMA0GoqtakjsP3WeXM4SqcU=;
        b=jUCIpb0Eo26ZpGGfaSGHWo9jTZTnCS/UZfXtQMF/heDP2hffqy2vmq0yDpNV8CeG/7
         PcCn+UopkxFEM07hVLqe1I7srxxUZC5O/tBxrjc2x4APerHe1c05xiFwZEXvR0yfbjuh
         YQLofmS20Oa/0ZM3OKnyUXfl7iQYupy4utCLtE0fRco6GoHMf2hLNzivjcIp0KBJvm/i
         sQS2k36+CWOej/Yq9kILcBOW/HBLYomJj+b4ElqRYOsbiuwTrdidah00Vzh5YWZkvov2
         qX4dRz2Eg2gaOH5IBNqO9tMWA7s7CUDLOyxy0Acd0FJkFerqz4Q6Uy9Pw8jAarVHHqtn
         llDg==
X-Gm-Message-State: AC+VfDwDB8DBMDBDK4YRy4b/wPqMEJ4+WSwsb3C6EpUSE7WotkG5bnGu
        aA01y68u4XQOeg/JGtjbvejPI7TT17s=
X-Google-Smtp-Source: ACHHUZ76kNoiRMANJN9qukIn6OGXThA1BVQ1YvKK1V+oXW1jsWARZ0AGfqp9Y5EBHnD9YADdXSCuMA==
X-Received: by 2002:a05:6a00:1142:b0:63d:254a:3909 with SMTP id b2-20020a056a00114200b0063d254a3909mr4437374pfm.32.1683331760128;
        Fri, 05 May 2023 17:09:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4440:ecf6:7bf5:244])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b00643b04b515fsm732458pff.160.2023.05.05.17.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 17:09:19 -0700 (PDT)
Date:   Fri, 5 May 2023 17:09:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: ensure timely release of driver-allocated resources
Message-ID: <ZFWarGkRAfPOmI6E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 drivers/hid/hid-core.c | 55 ++++++++++++++++++++++++++++--------------
 include/linux/hid.h    |  1 +
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c4ac9081194c..02a43bba9091 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2602,35 +2602,29 @@ static bool hid_device_check_match(struct hid_device *hdev,
 	return !hid_ignore_special_drivers;
 }
 
-static int hid_device_probe(struct device *dev)
+static int __hid_device_probe(struct hid_device *hdev)
 {
-	struct hid_driver *hdrv = to_hid_driver(dev->driver);
-	struct hid_device *hdev = to_hid_device(dev);
+	struct hid_driver *hdrv = to_hid_driver(hdev->dev.driver);
 	const struct hid_device_id *id;
 	int ret;
 
-	if (down_interruptible(&hdev->driver_input_lock)) {
-		ret = -EINTR;
-		goto end;
-	}
 	hdev->io_started = false;
-
 	clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
 
-	if (hdev->driver) {
-		ret = 0;
-		goto unlock;
-	}
+	if (hdev->driver)
+		return 0;
 
-	if (!hid_device_check_match(hdev, hdrv, &id)) {
-		ret = -ENODEV;
-		goto unlock;
-	}
+	if (!hid_device_check_match(hdev, hdrv, &id))
+		return -ENODEV;
 
 	/* Reset the quirks that have been previously set */
 	hdev->quirks = hid_lookup_quirk(hdev);
 	hdev->driver = hdrv;
 
+	hdev->devres_group_id = devres_open_group(&hdev->dev, NULL, GFP_KERNEL);
+	if (!hdev->devres_group_id)
+		return -ENOMEM;
+
 	if (hdrv->probe) {
 		ret = hdrv->probe(hdev, id);
 	} else { /* default probe */
@@ -2639,15 +2633,36 @@ static int hid_device_probe(struct device *dev)
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
 
-unlock:
+	return ret;
+}
+
+static int hid_device_probe(struct device *dev)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	int ret;
+
+	if (down_interruptible(&hdev->driver_input_lock))
+		return -EINTR;
+
+	 ret = __hid_device_probe(hdev);
+
 	if (!hdev->io_started)
 		up(&hdev->driver_input_lock);
-end:
+
 	return ret;
 }
 
@@ -2665,6 +2680,10 @@ static void hid_device_remove(struct device *dev)
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
index 1ea8c7a3570b..4e4cb3873468 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -596,6 +596,7 @@ struct hid_device {							/* device report descriptor */
 	struct semaphore driver_input_lock;				/* protects the current driver */
 	struct device dev;						/* device */
 	struct hid_driver *driver;
+	void *devres_group_id;						/* ID of probe devres group	*/
 
 	const struct hid_ll_driver *ll_driver;
 	struct mutex ll_open_lock;
-- 
2.40.1.521.gf1e218fcd8-goog


-- 
Dmitry
