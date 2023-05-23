Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE2370E716
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjEWVEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbjEWVEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:04:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987A1DD;
        Tue, 23 May 2023 14:04:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a516fb6523so1154765ad.3;
        Tue, 23 May 2023 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684875881; x=1687467881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oif66uyid7/Yvwm1H8mOfwf8GcawmBSVr6I2ONcWn0=;
        b=eaj7DsiqHSBDRhIAp3W95sPbfFqH8kVwvK1Yc4IGVmaOOtaPu8jrI2Vrrjd4lR188W
         QYGQEyZbWloC6+cG2fuDhD3UcT9qWgKT9PEy8XU3Ni9lkOhPWrlV5F0qWqr0jRmnvsRR
         90YYRinzUfBvMMURh9iDejeqwoSsAQO9T1GgE6D3iOSrfm9I/mj/c2rjaTZF7DS0yM9M
         zpGL8AAev5yqxCctIKnxDtYtFbz2YSStvRxVz7kCT60h2awAejTUK78O3ROYLdiJRUDy
         Tmm43FU3CmOTNIFetPZx7lDuQ/S7YNSGpggbQJepptpykxx0fhCJsU0lQoFcM3qTrvJL
         /3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875881; x=1687467881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oif66uyid7/Yvwm1H8mOfwf8GcawmBSVr6I2ONcWn0=;
        b=FszbHCjko+NYNxCSY7m7QJIqD6BrnSpgm4K4J/L59W3SoHJBpP5b3g/wAd3HXnFOQt
         areTwPJWmlvICJL8XBsq/YNipDOtK0yV8XZorVQAsf9dyKfpiUKLJT8DT99ljLcGzW1Y
         2OrpUoTtXrSOdt7axSi8UpEbfrCBnV0t/KeIt6hpeS8k1hPNKFE7SygBnJwiniQqTlHG
         NPgYBFnq+HAtCgGkQB5exnqmZinK3OFZAAZbVf3w0SmI7t67XTqYmj7WMMVqjGt1QrEx
         JviuAUrKuOytTAXq/FI+FcTbr7+ZTa+WW8uEZbGNPet1y9pFQiyVPcEK/6Uzg+qEdCDi
         yMiw==
X-Gm-Message-State: AC+VfDxM3p2sdnHeqzJYP6rVMznhdmjcwlgtr4ybLDWtpw1rjzfsUzDi
        bFXPHoI+yTzzLxOBtvM28gY=
X-Google-Smtp-Source: ACHHUZ4WLFV50r9QIriAzhdsMMgUdgzOIfsPg76cqeSZmHXzJiqkJr/WO26gwZzoeodUjaMbVth40w==
X-Received: by 2002:a17:902:6b8c:b0:1af:bae0:6bed with SMTP id p12-20020a1709026b8c00b001afbae06bedmr4847449plk.56.1684875880956;
        Tue, 23 May 2023 14:04:40 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001ab01b909c9sm7216892plg.120.2023.05.23.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:04:40 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 1/2] HID: split apart hid_device_probe to make logic more apparent
Date:   Tue, 23 May 2023 14:04:31 -0700
Message-ID: <20230523-hid-devres-v2-1-5220211a428c@gmail.com>
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

hid_device_probe() has a complex flow and locks and unlocks a mutex.
Move the most of the logic into __hid_device_probe() and
hid_check_device_match() and leave the locking in hid_device_probe()
which makes the code more clear.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 101 ++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 47 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 22623eb4f72f..1f0bb2784bfc 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2587,64 +2587,71 @@ bool hid_compare_device_paths(struct hid_device *hdev_a,
 }
 EXPORT_SYMBOL_GPL(hid_compare_device_paths);
 
+static bool hid_check_device_match(struct hid_device *hdev,
+				   struct hid_driver *hdrv,
+				   const struct hid_device_id **id)
+{
+	*id = hid_match_device(hdev, hdrv);
+	if (!*id)
+		return -ENODEV;
+
+	if (hdrv->match)
+		return hdrv->match(hdev, hid_ignore_special_drivers);
+
+	/*
+	 * hid-generic implements .match(), so we must be dealing with a
+	 * different HID driver here, and can simply check if
+	 * hid_ignore_special_drivers is set or not.
+	 */
+	return !hid_ignore_special_drivers;
+}
+
+static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
+{
+	const struct hid_device_id *id;
+	int ret;
+
+	if (!hid_check_device_match(hdev, hdrv, &id))
+		return -ENODEV;
+
+	/* reset the quirks that has been previously set */
+	hdev->quirks = hid_lookup_quirk(hdev);
+	hdev->driver = hdrv;
+
+	if (hdrv->probe) {
+		ret = hdrv->probe(hdev, id);
+	} else { /* default probe */
+		ret = hid_open_report(hdev);
+		if (!ret)
+			ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	}
+
+	if (ret) {
+		hid_close_report(hdev);
+		hdev->driver = NULL;
+	}
+
+	return ret;
+}
+
 static int hid_device_probe(struct device *dev)
 {
-	struct hid_driver *hdrv = to_hid_driver(dev->driver);
 	struct hid_device *hdev = to_hid_device(dev);
-	const struct hid_device_id *id;
+	struct hid_driver *hdrv = to_hid_driver(dev->driver);
 	int ret = 0;
 
-	if (down_interruptible(&hdev->driver_input_lock)) {
-		ret = -EINTR;
-		goto end;
-	}
-	hdev->io_started = false;
+	if (down_interruptible(&hdev->driver_input_lock))
+		return -EINTR;
 
+	hdev->io_started = false;
 	clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
 
-	if (!hdev->driver) {
-		id = hid_match_device(hdev, hdrv);
-		if (id == NULL) {
-			ret = -ENODEV;
-			goto unlock;
-		}
+	if (!hdev->driver)
+		ret = __hid_device_probe(hdev, hdrv);
 
-		if (hdrv->match) {
-			if (!hdrv->match(hdev, hid_ignore_special_drivers)) {
-				ret = -ENODEV;
-				goto unlock;
-			}
-		} else {
-			/*
-			 * hid-generic implements .match(), so if
-			 * hid_ignore_special_drivers is set, we can safely
-			 * return.
-			 */
-			if (hid_ignore_special_drivers) {
-				ret = -ENODEV;
-				goto unlock;
-			}
-		}
-
-		/* reset the quirks that has been previously set */
-		hdev->quirks = hid_lookup_quirk(hdev);
-		hdev->driver = hdrv;
-		if (hdrv->probe) {
-			ret = hdrv->probe(hdev, id);
-		} else { /* default probe */
-			ret = hid_open_report(hdev);
-			if (!ret)
-				ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-		}
-		if (ret) {
-			hid_close_report(hdev);
-			hdev->driver = NULL;
-		}
-	}
-unlock:
 	if (!hdev->io_started)
 		up(&hdev->driver_input_lock);
-end:
+
 	return ret;
 }
 

-- 
2.40.1.698.g37aff9b760-goog

