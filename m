Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1061665629D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiLZMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:35:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D480BC3;
        Mon, 26 Dec 2022 04:35:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t15so1098888wro.9;
        Mon, 26 Dec 2022 04:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQalA6kD2340oU4FsQ4S0uJjJ5Z70ukhJA1ZOudNs84=;
        b=FxhHvaxKTEKeJRny0L9g6RfbHcUL+Rw6DN9Vq30rix2eoe5kv3cEgX+D8IPR5qv5Lm
         pMjHOOepd8R8uAQRGNbRBpYn8pItYB6OArBB1J3XWmu0QLoJ5Igprm9bZq8b+vhd32b0
         W/9TscDqUA5+9rOVEqbKWz4m5jKoF52aVCWEtvzVbCq6y+Yr8zkFW+uOCebXIdhZNrxq
         q44YtdtISYRSJXh6ks50j9QEOawpRN7ypx1wM7zJ1RxjPZ+wrlyntdTN4tLoDywg28s3
         WqHlQYYNgZjbgBFIGLnQ8e98K8E1+mplEjTy9LrR9yfmbLcbyegJwN0Dsj/sStqjj+z0
         u/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQalA6kD2340oU4FsQ4S0uJjJ5Z70ukhJA1ZOudNs84=;
        b=itJtjPZM7Nd4vspZE1gZBXLzP5O26WFlv1KJBXynAi526o+EdztZxos40RGtc64aIS
         ipx6Mc0ig1cJHXpc/3IsLw5/5EEQJLZALCbYJOcO/ctdTk5c16VLC2IAQ4MlkKG67JJs
         /aHWpt3/lEABB7PJGLNjnl5Bi3vFkmszUlmfeXmPZYoBp4OQCWUKAr2k3kLME3Urz6XT
         gwU6luNxJEziKFHQm3umr3j2cOtKbByTVO13WQxBzrLnhcVKFubikKz3rD8DgAivhoat
         vthxWFRKx6ma4+dvEKOwYvQnNw7CkUU3qta7lzgCcNc+41PdWUsB/iuKvh2YlJMdzKam
         DQHw==
X-Gm-Message-State: AFqh2kqW8kpZKDF1FFpvc9vNe5Opp/Dak3mYOs1lnCpVt89m7xJFxI/q
        fHn++xBWc6XacRzcuWDRpzZ2FeaXwzk=
X-Google-Smtp-Source: AMrXdXuSwqHBlzKw4UFIpTvZK4fcdooiO399YfLpYxBhmzP7+QepqUXO3Y3m+aKQl8yUR4L3W0KTdg==
X-Received: by 2002:adf:fcc6:0:b0:277:7243:5cef with SMTP id f6-20020adffcc6000000b0027772435cefmr6177260wrs.67.1672058114981;
        Mon, 26 Dec 2022 04:35:14 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d500f000000b002427bfd17b6sm11948075wrt.63.2022.12.26.04.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:35:14 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Mark Waddoups <mwaddoups@gmail.com>
Subject: [PATCH] HID: uclogic: Add support for XP-PEN Deco 01 V2
Date:   Mon, 26 Dec 2022 13:34:56 +0100
Message-Id: <20221226123456.14822-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XP-PEN Deco 01 V2 is a UGEE v2 device with a frame with 8 buttons.
Its pen has 2 buttons, supports tilt and pressure.

Add its ID in order to support the device.

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/839
Tested-by: Mark Waddoups <mwaddoups@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 82713ef3aaa6..9ca471faab65 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1295,6 +1295,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G540	0x0075
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640	0x0094
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01	0x0042
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01_V2	0x0905
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L	0x0935
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S	0x0909
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 7fa6fe04f1b2..cfbbc39807a6 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -525,6 +525,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01_V2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index cd1233d7e253..3c5eea3df328 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1655,6 +1655,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		break;
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_PARBLO_A610_PRO):
+	case VID_PID(USB_VENDOR_ID_UGEE,
+		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01_V2):
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L):
 	case VID_PID(USB_VENDOR_ID_UGEE,
-- 
2.38.1

