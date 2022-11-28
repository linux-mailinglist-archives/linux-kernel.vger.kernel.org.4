Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C763AE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiK1Q5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiK1Q5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:57:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246CA1D323;
        Mon, 28 Nov 2022 08:57:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so8843924wmi.3;
        Mon, 28 Nov 2022 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vew6IID4ljm4heiw9CiVMz5FKmMEPqWRzVvaDisBb5I=;
        b=UjXq7Ztj+MduzKhQZ8vmeyZv7ih71rSO6vxUrYmW9MkDT1sCOn7RJoDrSa52WVfeBA
         Kbk0NvqLnOyZhtDjdaVoErpK/1+MHHr5bMduMJr4Gf+FDKrGcMOIMBlR2EHyRN7sVXTP
         SCBsb+XKi7hlFJ4denlaw7F9pFZDTPLDDkglOAXq82a8GgEn9g/cxSNNRX0HrxX9nkRk
         LINuZhf8esJdtbYRN8CgSb9lte/EW7cUCP+IJpr0XIDUydpVLBn8suhIoY65PR+uLzYf
         It4FjjtG/K3n28SlgHqWmXMM1N51Wy1bhfUpFIaTpEep3J87BiQZiXmOBI5mr/deIYBg
         oO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vew6IID4ljm4heiw9CiVMz5FKmMEPqWRzVvaDisBb5I=;
        b=s6isi1dpNbgY1gnsXwBM7iHZXuSGTGDp2pWCKl15tqm/wpMsbc9WX2w2tEY+EFc2TJ
         QWT8JZmmhpKO1058Fa7yNKCz7DIgks3TQNajHOtbKQzHYuW2cufpYZt5GS6UsHrbbH9K
         2w49MvPQRzhLT+d495YNI2HJlBSF7gipABAUhkLzoSrG6bc3JBJZNR0KV2kpZWOa709H
         O7fYvhPXlXTb0Ibw/gqrS8uI0CYhYM0CVD3a57aNOEJEVyMgO5BwLChrHyAeV3fRDfwS
         eRH1rwzbxsu4GxmjtR8weelQ+nZ+DIDkxMWtO61JRfStkMQQOJhMMLG2eQFrzgCQpSJe
         vxUw==
X-Gm-Message-State: ANoB5plOYMiXgQ1mjsA9bARKG/yClWQVeBlmNbTLJbMMVcvadVZzv6aV
        KONzk47rFljgL5lQ3tJqcOg=
X-Google-Smtp-Source: AA0mqf7z4UvRKndhNUHlnIZ1E1nA42RVLroivn5aMK1KdDrN6XfQphXgJTmiiU4C5EY3fjuJYLMP4w==
X-Received: by 2002:a05:600c:1d92:b0:3cf:78fc:eda2 with SMTP id p18-20020a05600c1d9200b003cf78fceda2mr24981454wms.47.1669654638691;
        Mon, 28 Nov 2022 08:57:18 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.229])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c205400b003b476cabf1csm15316847wmg.26.2022.11.28.08.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:57:18 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Akito <the@akito.ooo>
Subject: [PATCH] HID: multitouch: fix Asus ExpertBook P2 P2451FA trackpoint
Date:   Mon, 28 Nov 2022 17:57:05 +0100
Message-Id: <20221128165705.7008-1-jose.exposito89@gmail.com>
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

The HID descriptor of this device contains two mouse collections, one
for mouse emulation and the other for the trackpoint.

Both collections get merged and, because the first one defines X and Y,
the movemenent events reported by the trackpoint collection are
ignored.

Set the MT_CLS_WIN_8_FORCE_MULTI_INPUT class for this device to be able
to receive its reports.

This fix is similar to/based on commit 40d5bb87377a ("HID: multitouch:
enable multi-input as a quirk for some devices").

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/825
Reported-by: Akito <the@akito.ooo>
Tested-by: Akito <the@akito.ooo>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 91a4d3fc30e0..372cbdd223e0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1967,6 +1967,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ELAN, 0x313a) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ELAN, 0x3148) },
+
 	/* Elitegroup panel */
 	{ .driver_data = MT_CLS_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_ELITEGROUP,
-- 
2.38.1

