Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DBF64C43B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiLNHIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiLNHHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:07:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EEFB1D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:07:32 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-348608c1cd3so198713077b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwk10ScpIHN3TWeoCLrvB+vfcB+zS8T8ixzqnuDxGoQ=;
        b=S+ZBF0aetxStcQmCeGXzwYt5EYr7NqwSqJG8AaIaHEbqVpEpSuzSjYiSUhXEiNbImV
         Ea2GwSaPoQtaG8OF5d5huZF63W3lOkhWYFBhUN4HaXVfI5kKpUCHmE56fYPUv4HE3TRZ
         AJGNUmrvAUpDemnzYe+M/w6HXUE6IyRoOn00f/cCeosedEWCZ7NRvAQBBQzInBW+LvqH
         RMOyqbRFhjmyfTvTiUzIdN02SO9Q24DA+MljcTeC7wSNU9/sYR4oFxxCQxXgiJqW6kPo
         Fa0u60FF0bOFRWFEHRXhwPiB9SWZ8B1p3GspHFf5Ehg484k4HqLEH+gP3sh1YIarVrMD
         8S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwk10ScpIHN3TWeoCLrvB+vfcB+zS8T8ixzqnuDxGoQ=;
        b=yxhkPFaAm6sblGgBqRdfAZ5zMccYA+znTMXUQlsE39sEJlB9/3EV9q1Rad5syiWVbS
         wA/k4ZVrbaeUgVeOZS/++ttoMi2UbZTw16kqBNZLwA9wbMtA3UEctkY/qg/6XQppFhA0
         mkuKHLjPwqihpgW1/a+ZKCearFhzK4RosbKqRvFwS4GQ5nHlL8pBgCL1wq/wYTb0UCG/
         YTNsZkQn92Kt8tg495FMZAuA6pTRJW8rbaCz+xTHXNdr/OzgjCfEovTir4X+uU6LFT0q
         Al0xxffqLAbbBMAm+SEGTHFMOKDwn4tdfXhqFXtTGRTSIGt8E7vEIZSfc80HkmAXMKah
         /3ig==
X-Gm-Message-State: ANoB5pkZxSHQsSnqMvLwOo1lCKnx0FNba9mAz0FgbKJ8ADPTHLAvmf1q
        L7TYuDePAs+BAb3F/xrQWWB/Gg5AhLrr
X-Google-Smtp-Source: AA0mqf7avn4Qaej3IKAY16Oodzg8JnzSJ4uRyWnL1FJxff/YhffcMhV0BRcdqYY6ra/CH47c9Wb2HHr+juUv
X-Received: from pumahsu.ntc.corp.google.com ([2401:fa00:fc:202:cb1:cbe3:3a49:1751])
 (user=pumahsu job=sendgmr) by 2002:a5b:d0d:0:b0:6fe:bdb1:1529 with SMTP id
 y13-20020a5b0d0d000000b006febdb11529mr22480701ybp.628.1671001651345; Tue, 13
 Dec 2022 23:07:31 -0800 (PST)
Date:   Wed, 14 Dec 2022 15:06:50 +0800
In-Reply-To: <20221214070650.703793-1-pumahsu@google.com>
Message-Id: <20221214070650.703793-3-pumahsu@google.com>
Mime-Version: 1.0
References: <20221214070650.703793-1-pumahsu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH 2/2] usb: core: add implementations for usb suspend/resume hooks
From:   Puma Hsu <pumahsu@google.com>
To:     gregkh@linuxfoundation.org, mka@chromium.org, dianders@chromium.org
Cc:     albertccwang@google.com, raychi@google.com, howardyen@google.com,
        leejj@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mobile, a co-processor can be used for USB audio. When the co-processor
is working for USB audio, the co-processor is the user/owner of the USB
driver, and the ACPU is able to sleep in such condition to improve power
consumption. In order to support this, we implement the hooks to handle USB
suspend/resume requests.

This commit introduces two hook implementations:
- usb_device_vendor_suspend()
  Determine whether we should skip suspend request according to the status
  of USB audio playback/capture.
  Return:
  - true: let driver.c know that we "handled" and it can just return
          succeeded to ACPU to continue system suspend process.
  - false: let driver.c know that it still run original suspend process.

- usb_device_vendor_resume()
  Determine whether we should skip resume request according to the USB
  device's suspend state.
  Return:
  - true: let driver.c know that it doesn't need to run resume process.
  - false: let driver.c know that it still run original resume process.

Signed-off-by: Puma Hsu <pumahsu@google.com>
---
 drivers/usb/core/usb-hooks-impl-goog.c | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 drivers/usb/core/usb-hooks-impl-goog.c

diff --git a/drivers/usb/core/usb-hooks-impl-goog.c b/drivers/usb/core/usb-hooks-impl-goog.c
new file mode 100644
index 000000000000..89dc360babed
--- /dev/null
+++ b/drivers/usb/core/usb-hooks-impl-goog.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Google Corp.
+ *
+ * Author:
+ *  Puma Hsu <pumahsu@google.com>
+ */
+
+#include <linux/usb.h>
+#include "usb.h"
+
+extern int usb_dev_register_vendor_ops(struct usb_device_vendor_ops *vendor_ops);
+
+static bool usb_device_vendor_suspend(struct usb_device *udev, pm_message_t msg)
+{
+	bool usb_playback = false;
+	bool usb_capture = false;
+	bool handled = false;
+
+	if (!udev)
+		return handled;
+
+	/*
+	 * Note: Our private driver provides APIs to know the device is in audio playback
+	 * or capture.
+	 *
+	 * usb_playback = usb_audio_playback_enabled();
+	 * usb_capture = usb_audio_capture_enabled();
+	 */
+
+	/*
+	 * Note: When the USB audio is working, we will not let the usb device suspend.
+	 * Return handled = true so that the System core can it's suspend process.
+	 */
+	if (usb_playback || usb_capture) {
+		dev_info(&udev->dev, "%s: skip suspend process (playback:%d,capture:%d)\n",
+			 __func__, usb_playback, usb_capture);
+		handled = true;
+	}
+
+	return handled;
+}
+
+static bool usb_device_vendor_resume(struct usb_device *udev, pm_message_t msg)
+{
+	bool handled = false;
+
+	if (!udev)
+		return handled;
+
+	/*
+	 * Note: If the udev didn't suspend actually, we don't need to do resume.
+	 */
+	if (udev->port_is_suspended || udev->state == USB_STATE_SUSPENDED) {
+		handled = false;
+	} else {
+		dev_info(&udev->dev, "%s: skip resume process\n", __func__);
+		handled = true;
+	}
+
+	return handled;
+}
+
+static struct usb_device_vendor_ops usb_dev_vendor_ops = {
+	.usb_dev_suspend = usb_device_vendor_suspend,
+	.usb_dev_resume = usb_device_vendor_resume,
+};
+
+int usb_vendor_helper_init(void)
+{
+	return usb_dev_register_vendor_ops(&usb_dev_vendor_ops);
+}
-- 
2.39.0.rc1.256.g54fd8350bd-goog

