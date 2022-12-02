Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392A1640B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiLBRDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiLBRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:03 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED5C13F15
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:02 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id o13so12982462ejm.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNwN70fEkttO9/UpjS90pNFzNVmjhBb547h7/recR+g=;
        b=YMYF3FKLRKlD+VLDPSP4cm/n9VDbH+eOQhMJ4Ub0qET1/4YDbnMaYFow1EP3RGfI+m
         vyNQwoImPxvn4FEnFouVF4PoTlzo+tCYB4JJvcJyL2Jw440PlHUJbuIcJTc6gtRPIlbT
         7m7jbmZvRpcEM+ytuQZkODS4ts/U3+6fqeuOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNwN70fEkttO9/UpjS90pNFzNVmjhBb547h7/recR+g=;
        b=LOvTLoVPb2RVk7QXqnwbnsk6eYmb22hQTs6Gux95O/e6tnQFhUPEB3EQbdIBB4cByS
         8ixfFVWsjQeIeG5zUA3whdLQv5Q++JzS+Yrr+ELa06drTWOUMB2Zg1bFhMmiBywdbsgq
         Hyn9rbNqOkWXKVeKuKxYFCmOnLwG1MUePFrcX9sxrl6GD1YyWOxyqJmHB8zQGp1FJ51M
         kk59d4WrOBJbUP+Q1sCZptdgc+1ffiRevzRCzxRYLt6JfqLFUfeMzQfsvE3hNnERkfsW
         H87SPEBCnQzVIP6jr4yDqY0wXUPk3rM1hHIyXWz30+7y+2xFvy/nbvpmSEv24FXDJc6b
         f4iQ==
X-Gm-Message-State: ANoB5pk5SuWHvuejF+t8FFT7afrgFBF4fvWpxlYLnR0LGYVpuYQ0RVWM
        H6C0lj4PvHV/+fippKcruJRrfQ==
X-Google-Smtp-Source: AA0mqf7j0ojwl/0ab78IwDUCpSYN3+EkBoWKs2AM8Wssw53FrEnbQ+LP+OZh9FaM8Gz3BMpLN0e6OQ==
X-Received: by 2002:a17:906:5586:b0:7ad:902c:d158 with SMTP id y6-20020a170906558600b007ad902cd158mr47425492ejp.121.1670000581051;
        Fri, 02 Dec 2022 09:03:01 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:03:00 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:42 +0100
Subject: [PATCH RESEND v2 2/8] media: uvc: Allow quirking by entity guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v2-2-0d7978a817cc@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=es8VifXL1MkLaxdmrIj9wvoFjqnH8ap0KliznPX0ArQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii+4UFyy5wEL7JacPovRxgY/wDg86ABUbzcK85TJ
 WJqFrIeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovuAAKCRDRN9E+zzrEiHZ9D/
 4yXuaKvxm2kV9m+nvZzNTV1+awqBpG5QYMl05OQ1Oww/Pq5x7PBGr0GQgVM4IauG2bLsRv6BKdFSAs
 z/H+qXgVE6q+ObvX1yOphZgnRXAuYZv+Jfy5o3Q1gQNjgw0glnps8A/gHuRf7PEmq0aWuNYRKsEjMB
 gl/cT+EP8p9dSNX9e7mWK44C4z9dsWfmR12O8urSGzRzR98LOeEED1ywLmh4dklEJId4WjexIOmvhU
 gmBL9Ir+GUgGk5oVY3VwyzOi2RgVxVhb/WqgwVNe1VuRGINTN/bVE2ckUzey56teTB/+JJeNp7LBo1
 WkxaGSUqVvACvKaNZEavwD6p9a7tP5Pyuk25zQrAhlT2DbljorwNyZa55B1b7K4lll7EzVBQ+HwBUd
 LRy893zuzDEWmtJGgcoK3dGXoaG2VSw9plEXXmSqFZbUQaK0pRDw8bPLhdlRitgpchX9WWcVNQCXsz
 t8FquJoH4sbmjRR2wxCWLeIFHiwTHTZwJ/eMQEWdjptRspwhpTyGqp2w9rjhxvM8wzrAgEepCNsS6a
 /3NMoA7ws+dnZ9urdLId4T+nCP70rUtzhB+9uuPKlcIoH77AQBac/aWleL+IjjjIxFGRJhakl9XHD0
 7U+mdJMfjOq8KDm+v1elgwnafSKwNHNc7QQwICG6oMjE6VfMcpNT9kFzvt/w==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an IP is shared by multiple devices its erratas will be shared by
all of them. Instead of creating a long list of device quirks, or
waiting for the users to report errors in their hardware lets add a
routine to add quirks based on the entity guid.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c05776f11d1..c63ecfd4617d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1493,6 +1493,28 @@ static int uvc_parse_control(struct uvc_device *dev)
 	return 0;
 }
 
+static const struct uvc_entity_quirk {
+	u8 guid[16];
+	u32 quirks;
+} uvc_entity_quirk[] = {
+};
+
+static void uvc_entity_quirks(struct uvc_device *dev)
+{
+	struct uvc_entity *entity;
+	int i;
+
+	list_for_each_entry(entity, &dev->entities, list) {
+		for (i = 0; i < ARRAY_SIZE(uvc_entity_quirk); i++) {
+			if (memcmp(entity->guid, uvc_entity_quirk[i].guid,
+				   sizeof(entity->guid)) == 0) {
+				dev->quirks |= uvc_entity_quirk[i].quirks;
+				break;
+			}
+		}
+	}
+}
+
 /* -----------------------------------------------------------------------------
  * Privacy GPIO
  */
@@ -2452,6 +2474,9 @@ static int uvc_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	/* Apply entity based quirks */
+	uvc_entity_quirks(dev);
+
 	dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
 		 dev->uvc_version >> 8, dev->uvc_version & 0xff,
 		 udev->product ? udev->product : "<unnamed>",

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
