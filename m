Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF05BE819
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiITOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiITOId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AB457274
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r18so6391738eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=L+YXSruL8FZXKkluNVYHxY4b4v+zabzmrYEwgelER8o=;
        b=jLhG91LTt3NbAgXp8TrnzBdO/e978j4vjVG6AHEceU6M4C7BJdCPH1ghLlLN4PJF+H
         8r7dPO/6e0oBCRGeUJKhaSBU95zlOTsFaSUrl7TPkQ19dZIOk5r90huzhehGVjssoyMn
         Oc43BGp2HhEbve9XtZsiDWU3aXeZaxiHJIiEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L+YXSruL8FZXKkluNVYHxY4b4v+zabzmrYEwgelER8o=;
        b=Yv1cIJBSW4VpT63PGymw5uzp9ZMlnGYYGYOqky8IqE6An3mK3qxb8pGA342dylpCm7
         kWY1uA80DQ+EnZqCT54ywJiglqnKD8db8ielK99mmd4O0C8a06OZCt7+UCe64USEjoV8
         p9U9L43iHClyNqXXAbK/Pe+ic0adu0JyQZiDg3hXRRFWHXyrpxErYNmFXWfiMr0pEYlm
         yhEnT+G9H3StLy4uKAQ9nADi881N0HvW/hHxfg0o5eU7oOnLm/oRjFYr1WJtuecj2/jE
         ZAqW2PH1rrnrI0l2qm4CrpsMgh69amC9Ps72m1s+5nhTtdxjdL7ogZJmPvaa8M0UQ33d
         h+RQ==
X-Gm-Message-State: ACrzQf0aGU0iPgjpCf12yk0qxP4pKR2ws8vaCrm6mxeEeFrj2u5Q3IaK
        2fp3xMtYgNZnoUL5+w5fdCAZxj7gjJL29yLwhVk=
X-Google-Smtp-Source: AMsMyM7jwon6ecxE7NfNiosUmO0/077D8sLx6myf2Iq2py+mmFDrAXVRIF/KlIaZRTTQ0lO7e09XKg==
X-Received: by 2002:a17:907:94c9:b0:781:316c:755e with SMTP id dn9-20020a17090794c900b00781316c755emr9029571ejc.749.1663682909106;
        Tue, 20 Sep 2022 07:08:29 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0077016f4c6d4sm936564ejg.55.2022.09.20.07.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:08:28 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:08:08 +0200
Subject: [PATCH v1 2/8] media: uvc: Allow quirking by entity guid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v1-2-e9c14b258404@chromium.org>
References: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=xw2dHHXml1PIJfr+b0l5YFAoO7vYI8kJa5F3mUvTDDE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKclNlN/M2/uzNrk1dLEasraRExVc/PHIaHyxNNab
 6gs57eeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJTQAKCRDRN9E+zzrEiJLKD/
 0TxLIsGVcYtl/NZJTBqh+6CiPU0BLBb/KSqIrT2cJ7n2j1tdyFURkMHE6nx8ygSjlaIhJh6uhTwa/I
 QeMvxKp1CXa66K7vZ4Xz1bLxNmtgj8pI1nFzVL9N79T65JipilQIQfHFyKfvveAXNDDHvcXUZhznd7
 lRfjbOb6TEo5fve8hON8hcjDdQ6vOEWMzyUrQqSEj7eNHXyQT6MQIJZyqANLlrfGVVjs0mrF3eukOT
 68rgjP51ueB6NNhwmur7IonIw7j1YMZC99QN2KDZoSKx9xjixMO0a6YxY5R4bDl7WeWsNpIjsr2Oxh
 VZOixCy0pdcHbR3vfPJWn82Q71Ed+uIa2HMLXSh0+2gZhEhPhm8Sg8JMkFfyuCi6ZqNp3s0EHN3lgB
 e+OKXtOsKGH8ggy9T1bt2w9kfVT4TgyBZQL8hRvfjnz/wh1Y6W4iKhnq8hmUc3p0sRboiReXYED0+A
 nuSbtYrID+VsQ7t4HMqmeVRUPCTmITgPvnoLYr/WqaO2iCH91o4mVIGGPxsCDFwLiZhKvarQ296net
 /nIIHwie6eawv6mjC0ckXHe5jdvfkqgzc4RSEAmjj7Lx0XoiOvzaQnWr5m7RhIzmK5MBvQ/VGTGKqo
 ahBoeeKgZmHIEqCQpQ/+4sZUixPJbm9TmYEX/oOcKFYdTlJ4L86pDPdlAeWA==
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

Tested-by: hn.chen <hn.chen@sunplusit.com>
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
