Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A183A65D0DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjADKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjADKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:45:54 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13A13E27
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:53 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id fy8so17561797ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyBrI1RwfXQizMxJ8rnnrBo4q45UrKGn2OI35vCZsYY=;
        b=Uep3phL55FIMMwa37576Z/9XYaU7Cjh/iSkuW19M9vpAiL+74bvM1KKqyQMnfC5vO1
         2/ANgpV/Fvb0SiM+laEYOILg+QbE0pSwYEdxLv26eD+7k9FRRQJA23cVPxX1Ou6UfxYj
         FfZTQ9PbbKeBDGGS3JYlBg8ew6fyphoje1Hok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyBrI1RwfXQizMxJ8rnnrBo4q45UrKGn2OI35vCZsYY=;
        b=kqSV4dWLPxgRGFx+ABgiLamZjg2ZcMPoBSXL6fU+7pdJPbcgT4KEZLc8OFYJ2pCdfE
         X2NGt0Wn+24fDpSg1jR/YO2N/9GZP8IBYG+Le029+URigedKlQ0I3OIzw8gHrwjHojbT
         7iZ4pxe/a4UujrpDAzIfANFhEcHNUM29e+ouE/OWCC7hogjFnj+k9ZOT8lDgRpKJgEhV
         ot3+K2q3oPoygwoge+OIfY2LizEttHzwbYbwq+bc6AJSCbEGogGbzcOOAgZipMtB2BEm
         stvvpkmg5MO0Ewug6gm3xUg0sEMqgGlJ7WaKjQ1u19k30JhlTOYYm6chWR0HCTVyGsum
         YdtQ==
X-Gm-Message-State: AFqh2krBZfjCr5f8q9lCFpGVUgXjZLZ2zAY0YtShRisbOWpVGKFPXCXS
        8nJjfZHtz21zjSlmAbjUOCo7ww==
X-Google-Smtp-Source: AMrXdXt00As5fSHArbEefv7fvImmjhDllCRKY5zJkWdWW9VOhpNt1PeXLA6fuJJKbzPfqo0kgnX+Kw==
X-Received: by 2002:a17:906:5619:b0:7c0:faca:52c with SMTP id f25-20020a170906561900b007c0faca052cmr40663884ejq.37.1672829151931;
        Wed, 04 Jan 2023 02:45:51 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:51 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:20 +0100
Subject: [PATCH v3 2/8] media: uvc: Allow quirking by entity guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v3-2-db9faee7f47d@chromium.org>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=FoOybSKY0S3eTj4qt7v1f6DB//nxdb92ZYxbnB6L0cM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjRUGIm+ptCBoYbh0RSttvX3gody0gvY/pWZOUo
 z25/ILuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VY0QAKCRDRN9E+zzrEiJyED/
 4smqXXbUx0OhCo1Gk2G1q5NSxcv/gZhUPIrEp2CohBfmROuHc6K1uWFI1PSWxodXVZi2w/hOugVSCN
 ptF8H4UiBgG0CRwz/UMibCVCYQ5/ODjGYOvcqlieVFr9wvog+Pahb2fzfCXzw/Up1qVUUynedr9WXj
 PZUOovW8NBWkos2NsAIE8qZ6oj8QRFiHck2hdqxpHrJsENA4NbHVrNldoVOFsf/VrGi5RCempnU4aL
 L7QwrwiA8A3YVK+6tTdRFnkEKD9ZCDD2FEyyHPj0TqG+HxVFDmxlDfo1IJ9uHS0h6Sc/pgjMMUNl4C
 20esCE33VIUp+jT4j2mC6EL+AEe8txMbzavnbHbVRL1BshNFl5EgmoNO72p7peoCS8ZfbSTXBXz1Wg
 gI0xVENtpBIQ0A64LjlAGM/sqOCAj/j0JkgwK/S6rLPeWbLRWgizLqXfnV4kvz9TV7CjWBVO2KcgAu
 OBZ7V4kB8YvO0zh+VvOc6QbsTjoSm/sLzqu3jPqAPk9PmrOY/Z0fWAqx5UZEbuSUIuoZe3bZeYW5DX
 OGiv1eBKLAVISJ1toBBYhwbQIHcNF6pqipBUmfpdN6HOPiwLvHZDDrCOaSA9I6RkkKmJfHF+5nog8e
 N6unuSrLBaSDn2KDvWYkEVIZU5086LK9v44mMuZH1TeJSKe54wgDHAcCeyQg==
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
index bd3716a359b0..5448576a8413 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1195,6 +1195,28 @@ static int uvc_parse_control(struct uvc_device *dev)
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
+	unsigned int i;
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
@@ -2154,6 +2176,9 @@ static int uvc_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	/* Apply entity based quirks */
+	uvc_entity_quirks(dev);
+
 	dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
 		 dev->uvc_version >> 8, dev->uvc_version & 0xff,
 		 udev->product ? udev->product : "<unnamed>",

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
