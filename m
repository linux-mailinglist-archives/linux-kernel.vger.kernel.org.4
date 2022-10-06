Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C845F6354
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiJFJJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiJFJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:09:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F8FCEF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:09:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 189-20020a2516c6000000b006bbbcc3dd9bso1258172ybw.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=W6dnd6MUybWhVHYUHQ8d7S6D4UzG0vGs7tI9w8WKSPw=;
        b=SSpzU+3wLTsbRTZVM5yu2Enu8uvoYL9bqFOuq1fID5Ck3vddYC9Fn2fSzvLKbenMUx
         fuF4R6M5SBRsLSABcNeCV9rpYF62Ev+3xv/A+pnTFcZsv2lxVRPguNBfm5QCC6EMr7E7
         H2vr6MX5XTebP3D0H5ofNAwLXJkTUMjqS54djUwpy0stP3+jl9ypp6h1ipVNdaNPtss1
         SpAiACIC768tO0rIonQB/nhoOdlTl9Bl9YlCeF4YPv6cVlA7MjUcyKgelLElupjTIX2q
         KiDfZ6dzGys/MZJ8FBdi91HZBLTjIe20tkGm6j4flwNHexG6NHjuhpLIIUgDGpxwmrpg
         3Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=W6dnd6MUybWhVHYUHQ8d7S6D4UzG0vGs7tI9w8WKSPw=;
        b=qtm23fY/pD0Kqlj5sfO2nG8TT7EhTuoGR9ItaqXscMcN62jJTyJuEECBAi1APiLZGD
         I76td6sIqDb5aKHF7MN3kaRf6ONYFi6S6PtuZbHBESjd2ckSOdtUavALB8/WkZrRUJAU
         W8NaH6dx0rg9j4dJJM/n/GlzbJ5E0sq4DQPUSDX+vK/FfjsStBBqEHdVIuk0vKX3jIoj
         klZlfUMh/k317PwchvJF3brTFSZCYEpAZ2rehGzYxxw+2zWIOEQ7uh9Yzf0fjuJSmhUd
         xyWnUP+tkrJaQ2ILl8DwRIHXmL7TpMf24QussdMhl8tXDg3ZmKIpJeS4WQzhxDIjNicK
         U7DQ==
X-Gm-Message-State: ACrzQf3wjqN7uNoW/ycRQoNwxZT8Aao3u8GCkJ9RyKEHH5Ti3fYZDe3S
        5Iaqpkzt0lYQMTUZJ4ampvq07FJEu+mc
X-Google-Smtp-Source: AMsMyM7BSEaT9DRaVmFt6QmDrsflEMyuH9+JhiEkNuJR/D+9w0X/VRjRUTm1V5JxJGcr0IWCFKhdt8ZK2Am/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:1fb9:e3c:c40d:dd12])
 (user=apusaka job=sendgmr) by 2002:a25:bc83:0:b0:6bc:a6d2:5216 with SMTP id
 e3-20020a25bc83000000b006bca6d25216mr3841415ybk.204.1665047376628; Thu, 06
 Oct 2022 02:09:36 -0700 (PDT)
Date:   Thu,  6 Oct 2022 17:09:31 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006170915.v3.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
Subject: [PATCH v3] Bluetooth: btusb: Introduce generic USB reset
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Ying Hsu <yinghsu@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

From: Archie Pusaka <apusaka@chromium.org>

On cmd_timeout with no reset_gpio, reset the USB port as a last
resort.

This patch changes the behavior of btusb_intel_cmd_timeout and
btusb_rtl_cmd_timeout.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Reviewed-by: Ying Hsu <yinghsu@chromium.org>

---
Tested by not cancelling cmd_timer when handing hci event.
Before the patch:
ERR kernel: [  716.929206] Bluetooth: hci_cmd_timeout() hci0: command 0x0000 tx timeout
ERR kernel: [  716.929218] Bluetooth: btusb_rtl_cmd_timeout() hci0: No gpio to reset Realtek device, ignoring

After the patch:
ERR kernel: [  225.270048] Bluetooth: hci_cmd_timeout() hci0: command 0x0000 tx timeout
ERR kernel: [  225.270060] Bluetooth: btusb_rtl_cmd_timeout() hci0: Resetting usb device.
INFO kernel: [  225.386613] usb 3-3: reset full-speed USB device number 3 using xhci_hcd

Changes in v3:
* introduce hdev->reset to override the generic reset function

Changes in v2:
* Update commit message

 drivers/bluetooth/btusb.c        | 35 +++++++++++++++++++++++---------
 include/net/bluetooth/hci_core.h |  1 +
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..e6add3604214 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -696,6 +696,28 @@ struct btusb_data {
 	unsigned cmd_timeout_cnt;
 };
 
+static void btusb_reset(struct hci_dev *hdev)
+{
+	struct btusb_data *data;
+	int err;
+
+	if (hdev->reset) {
+		hdev->reset(hdev);
+		return;
+	}
+
+	data = hci_get_drvdata(hdev);
+	/* This is not an unbalanced PM reference since the device will reset */
+	err = usb_autopm_get_interface(data->intf);
+	if (err) {
+		bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
+		return;
+	}
+
+	bt_dev_err(hdev, "Resetting usb device.");
+	usb_queue_reset_device(data->intf);
+}
+
 static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -705,7 +727,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	if (!reset_gpio) {
-		bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
+		btusb_reset(hdev);
 		return;
 	}
 
@@ -736,7 +758,7 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	if (!reset_gpio) {
-		bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
+		btusb_reset(hdev);
 		return;
 	}
 
@@ -761,7 +783,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
-	int err;
 
 	if (++data->cmd_timeout_cnt < 5)
 		return;
@@ -787,13 +808,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 		return;
 	}
 
-	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
-	/* This is not an unbalanced PM reference since the device will reset */
-	err = usb_autopm_get_interface(data->intf);
-	if (!err)
-		usb_queue_reset_device(data->intf);
-	else
-		bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d", err);
+	btusb_reset(hdev);
 }
 
 static inline void btusb_free_frags(struct btusb_data *data)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c54bc71254af..55a40f5606c3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -659,6 +659,7 @@ struct hci_dev {
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 	void (*cmd_timeout)(struct hci_dev *hdev);
+	void (*reset)(struct hci_dev *hdev);
 	bool (*wakeup)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

