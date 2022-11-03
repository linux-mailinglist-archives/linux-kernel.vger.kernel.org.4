Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7723617E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiKCNl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiKCNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A31BE3E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i21so3020233edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoS0akrQ6TeQveFfFSMyc13cjNtaNvtsE6SeYOBvOEk=;
        b=MLQgHUyIriV6RdPmja4T9uFEXXUXFwshLRPcoh7SpM0CnJu+5+LRheI4aIQ62WzYhQ
         yhDTQnx6sZ7KkjIZVCqpxpXZ/6cdNic0kN5q9FHvCIuCdIrg9Bod2vt5FBq1nBFqJz+o
         HkiHnMNb+5qZJ9Css6/W4xpFWXEdZmzPNdMbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoS0akrQ6TeQveFfFSMyc13cjNtaNvtsE6SeYOBvOEk=;
        b=SZxoN4hd1I6BAWpk7c+Ln4Pv/2nQKygL361FRL/1AsBhrWVN78zsUCB+G7o9kneI7S
         R76pd742WnW0r6MNQhW9nlRaAP9nPE7ODfdY+GxtT3Y/opbUrQ1zgnzTRrpFCWyVCzs3
         Jk1LuhvDG0Tak3ncvpSZxW9r5c8Bnp+MEG6+urHuKCWCE4swQW+tbg99L49r6Wm7seyV
         a5GF1mjuI7X0K7PJeBLCJDM/mb/rt0cYcwQaRZZaKayC9UpHfbpSr0FJZdsx0a/J90XD
         3SPEMsz9FA+AoDbYH/Zjp/Ddvdat3SEcFZgUA6c61wLVVHQGGctAB+KD29bY4jgImIII
         gqiw==
X-Gm-Message-State: ACrzQf2kBkwwXtRQS8RzN2Qv9sXH4Lb7HYIK6Op5QA0oJ5QxXaFwp4lE
        EODD2boB4Z7wSkmIPb1g496YEPE7LhvjgKvf
X-Google-Smtp-Source: AMsMyM6NzSZ17t8Rq94EfXDfVaLKmcua0tk5kwFCY8HhJ4Ex5qPZmm6mI/dC2DnjnhsQIyljpjFWqA==
X-Received: by 2002:aa7:c389:0:b0:463:5926:7254 with SMTP id k9-20020aa7c389000000b0046359267254mr22814190edq.255.1667482868053;
        Thu, 03 Nov 2022 06:41:08 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:07 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:43 +0100
Subject: [PATCH v2 2/8] media: uvc: Allow quirking by entity guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v2-2-d8d0616bb612@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=anGRVDFD85vsGKk21Uxm3s9uLgr7IvjTjJHKWEWi0Pg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8Tl5NZFMLDHqMroQzfNDlU9yRplmkVU67bnePXf
 eTV/5fOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE5QAKCRDRN9E+zzrEiGpFD/
 9JX3HaPi2suJ4GMvYRHsf+hbBMWhA9OH0IkPyeM3mB/c6+94JJoamvLRpBEyIYJvrahKiEUCivgLre
 +owtY12LRuklzovJs6d24N8TqaT0Amp++llLv+ekx4aSMiaZa/pvjze+lX3g2Z+kjETUYR2p0YlrG4
 HdV22s3MrTFXTHwr5/MrXj8soPClS1XnwpXCD7F3qjBxTOxx7M+cRr0jZxlQdnbhqHFUHKGS1+1hmf
 m26KCbQpt9kN+4bh30tNIWZOlyGJKNLmjSbPl9Cc4Ftfd5HU98M8rbpjcG07HmNZj9xOTo4vU26KGq
 vI0fwRWLEkhMLq4Ae42P5wvjkS+xssX6WKVbiImGDM30SCvu66uSLTMtAtUTeDxHP6c1QqUaTO+yiA
 54bceNWIGSa4VwIsjr41CLtnkKUvLs+fpRgPnymyarx6KEm3xykLuDh3Azavy5Wq2VlTGylVLQZM9P
 aLs6ZP2Ga5ERGBnfko6I8mEO6oMRpfdpiBoZidfnQLqWOsPTQym7CfF8tsGTv+8HjMGtUssyZ7JlEK
 QnUcspRv9pGALRYSoiE/d001PiSsKBQ9rCl1GGE/i4WPDclTqF8m2JKfYvjgNEFbt9XE2GOfdM9lpp
 Xzy2wXju3H1HaVudS8tOltB7kXLCGMrJU8SsZhYMyBvmh+AU8+rw5+XhxUFA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
b4 0.11.0-dev-d93f8
