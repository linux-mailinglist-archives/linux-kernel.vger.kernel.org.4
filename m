Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80386F95EC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjEGAin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjEGAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83F2D406;
        Sat,  6 May 2023 17:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7EB661546;
        Sun,  7 May 2023 00:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BB6C433EF;
        Sun,  7 May 2023 00:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419756;
        bh=XltpuxPzVtU2xkDWc+swRogKIHT7jMBQtRUWp2ZNb88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6IJBgn9ubgQVKSmilauo6EyAaz0Nvy/WU2y7fPY+Hh27h2Yu3Hk7WQpmudYN/hp3
         T/a12gshtVh3IMCUDXV/QduasvCEHgMP8dCNaCmGMbLJkR9Nt5FtZDubOnwOhq2tx1
         dZs+WuOjhcigl9pm/zMVHl5PwN926F4qvRIYllQvvgm7NT5enDANkcwlA96lmSffXZ
         z+UWUV1ygB+45ZWs5txDm9w/IMbH0S4RIDW2rQamRtItpnHFv/IcviMkNX9qIPVhXb
         +To0GoW0qKGTqXbsj7B8TT5k4sQMZh7l8kn+qp4GL1SM4tF7sDirV9FIZKtCAogt2M
         yAfvLwWOqfcmA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/9] HID: logitech-hidpp: Don't use the USB serial for USB devices
Date:   Sat,  6 May 2023 20:35:39 -0400
Message-Id: <20230507003545.4078941-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003545.4078941-1-sashal@kernel.org>
References: <20230507003545.4078941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit 7ad1fe0da0fa91bf920b79ab05ae97bfabecc4f4 ]

For devices that support the 0x0003 feature (Device Information) version 4,
set the serial based on the output of that feature, rather than relying
on the usbhid code setting the USB serial.

This should allow the serial when connected through USB to (nearly)
match the one when connected through a unifying receiver.

For example, on the serials on a G903 wired/wireless mouse:
- Unifying: 4067-e8-ce-cd-45
- USB before patch: 017C385C3837
- USB after patch: c086-e8-ce-cd-45

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Link: https://lore.kernel.org/r/20230302130117.3975-1-hadess@hadess.net
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f5ea8e1d84452..4921000d8b092 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -922,6 +922,55 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x0003: Device Information                                                 */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_DEVICE_INFORMATION			0x0003
+
+#define CMD_GET_DEVICE_INFO				0x00
+
+static int hidpp_get_serial(struct hidpp_device *hidpp, u32 *serial)
+{
+	struct hidpp_report response;
+	u8 feature_type;
+	u8 feature_index;
+	int ret;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_DEVICE_INFORMATION,
+				     &feature_index,
+				     &feature_type);
+	if (ret)
+		return ret;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_GET_DEVICE_INFO,
+					  NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	/* See hidpp_unifying_get_serial() */
+	*serial = *((u32 *)&response.rap.params[1]);
+	return 0;
+}
+
+static int hidpp_serial_init(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	u32 serial;
+	int ret;
+
+	ret = hidpp_get_serial(hidpp, &serial);
+	if (ret)
+		return ret;
+
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
+		 hdev->product, &serial);
+	dbg_hid("HID++ DeviceInformation: Got serial: %s\n", hdev->uniq);
+
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x0005: GetDeviceNameType                                                  */
 /* -------------------------------------------------------------------------- */
@@ -3855,6 +3904,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
 		hidpp_unifying_init(hidpp);
+	else if (hid_is_usb(hidpp->hid_dev))
+		hidpp_serial_init(hidpp);
 
 	connected = hidpp_root_get_protocol_version(hidpp) == 0;
 	atomic_set(&hidpp->connected, connected);
-- 
2.39.2

