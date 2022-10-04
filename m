Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F685F404B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJDJuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJDJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:50:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ABC5A166
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:47:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o4-20020a258d84000000b006bcfc1aafbdso10123111ybl.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=ghNlSazUBlSssMryUfGeRu8nHv3dJlLHUt+J7yhS3Pc=;
        b=V86fPWoZule0ularpOpJHJxJRlCsOspfjHcOfXMUHhIBV9LFzfaQXKT0AMWIa4t3Ss
         HQH8Av0u7KpaLwl2UDxrIuMFlfnWfaB7R4fiH5hS0KtZ7Yr027WHbHaX7ILoGfPsXjgf
         AhogQ2eAZuEo0dqW5f3ckIvIwdcD5XWZ+zvFIx2v10e8yLnv15zvpLQGQ0KJqHhF1YDO
         ECPTbJjE41VOb5g5GVS1AcH+4gPc5ALxV42qba8FcoAaGRK28lYMCE9c4PHM4FbpXOwW
         BsiliWOKGZPMk47mdhMNFp90L8MeQRj1Ae3irmTS6TGOpEiEVtUQYN7dUEIb1scOSFWU
         oxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ghNlSazUBlSssMryUfGeRu8nHv3dJlLHUt+J7yhS3Pc=;
        b=FjRslPtXKKI8rMjK/OWiPb1IPpioam/5s5lzYF5KNNShmNpiQaSdT7iLDka/uAbDHZ
         HI4Pde0yBGf7vhnWV+SwaPhzfQpkWNr49rhjC6JELQfrN+NDMGfwoW/GBFH+d7mqZ0j8
         gKVZUbEAoGEfRJFExmjXA9i1hnhpJKOtjsqA7aE8YzHUaeOhn5BtYX3t8GOweY/52nlL
         TAPKxO8m+3/XZrsFi7TUWt+XO356ENUtd0vySaBaQIT/vigG6wZMME4MC+oweNUn2WHx
         Sx1tawsZIfVl3JTAXlhWUv+fzmNE0LUtkvLln95jPy9V+XxJ594ziFQx4ftDR4SeUhUn
         sO8g==
X-Gm-Message-State: ACrzQf3+plzPKvlvw/OhKNyx04C2szBvaPVFi8z077fFgHloc0u+K0Mw
        AB7JZsiPsmMP1r5i1paqdJ06RPCLJVGi
X-Google-Smtp-Source: AMsMyM6N8tTfKjGzw+gCuEFo/2fyyp1veF5w80UTW1Pigpg4h0NnYRryMZiSgRiJGnOW+31/nB9+am1tDNGm
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:e06f:8778:ebde:592c])
 (user=apusaka job=sendgmr) by 2002:a81:9b0f:0:b0:354:488:c995 with SMTP id
 s15-20020a819b0f000000b003540488c995mr23515334ywg.167.1664876842230; Tue, 04
 Oct 2022 02:47:22 -0700 (PDT)
Date:   Tue,  4 Oct 2022 17:47:14 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004174632.v2.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
Subject: [PATCH v2] Bluetooth: btusb: Introduce generic USB reset
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
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

Changes in v2:
* Update commit message

 drivers/bluetooth/btusb.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..11040124ef79 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -696,6 +696,19 @@ struct btusb_data {
 	unsigned cmd_timeout_cnt;
 };
 
+static void generic_usb_reset(struct hci_dev *hdev, struct btusb_data *data)
+{
+	int err;
+
+	bt_dev_err(hdev, "Resetting usb device.");
+	/* This is not an unbalanced PM reference since the device will reset */
+	err = usb_autopm_get_interface(data->intf);
+	if (!err)
+		usb_queue_reset_device(data->intf);
+	else
+		bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
+}
+
 static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -705,7 +718,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	if (!reset_gpio) {
-		bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
+		generic_usb_reset(hdev, data);
 		return;
 	}
 
@@ -736,7 +749,7 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	if (!reset_gpio) {
-		bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
+		generic_usb_reset(hdev, data);
 		return;
 	}
 
@@ -761,7 +774,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
-	int err;
 
 	if (++data->cmd_timeout_cnt < 5)
 		return;
@@ -787,13 +799,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 		return;
 	}
 
-	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
-	/* This is not an unbalanced PM reference since the device will reset */
-	err = usb_autopm_get_interface(data->intf);
-	if (!err)
-		usb_queue_reset_device(data->intf);
-	else
-		bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d", err);
+	generic_usb_reset(hdev, data);
 }
 
 static inline void btusb_free_frags(struct btusb_data *data)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

