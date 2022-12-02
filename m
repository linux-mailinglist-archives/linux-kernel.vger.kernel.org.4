Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3C640BCD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiLBRIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiLBRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:08:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6734D15AC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:08:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n20so13078954ejh.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtZA1IbfmQV1q6JbQ4L1axaQ6pL7lh9jXHUHF+NGf+s=;
        b=XpikTCNVTwEOA5uF8nNd5n/17A51tYzKCsH3sFvNsx7NQIlGfqeYPmt+MPPTil0B9c
         HoA1iwi/zEldKG9JkeVX+amy3q/vGckf4YOJJZq6aKxUtcpQqtvsP97cy1tjVEwII11V
         nOqCsWmk2LGIUPqE1HZG8UiN0l0cJKQvaKSjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtZA1IbfmQV1q6JbQ4L1axaQ6pL7lh9jXHUHF+NGf+s=;
        b=ERKZq23HCDfjemzOtv+HS/5uSbloHuwrZcHJNyYj6ViWrvLe/bq1bMUJWTI/HEv76q
         arSHFe57aOG+QQOXceU/61g1wfmynRRCpsTG7YG9r9jUx7FVBGwD7hDqrDYmTVxhnIV+
         OhZ1H6Z7uqhw4AcNrtMOzEEKeILfGvDwpFOy8u1te/jg4x2MYGxqYjanhNoiePdHJySc
         vXq9ySDuvSbX7EIRHEIKYN9O8b5y/KIV1313vc8i2u9hrtysW/6nju77ieZExbSo6XCi
         kh5QZg7u4RMFwZz6Gmptw7cCgpxmivoI1+WbHymYts0X1+fKvCiauFtTMr5sdXakDV6k
         AbNQ==
X-Gm-Message-State: ANoB5plpJGSLSshRRGwlbCbyKk6kY3VmCA1jCCYlndxR75Uf2y9osLhq
        5Yn2HEQV/plCrQ1ksndiXs3Z1Q==
X-Google-Smtp-Source: AA0mqf5dJzt7LrpazmQka4+jBMsdtoK0r3QFvYdUKX1Vh8sKmomDA3k5HIQLxQG/VkNHAbFh65F7bg==
X-Received: by 2002:a17:906:c303:b0:7ad:95d2:9df2 with SMTP id s3-20020a170906c30300b007ad95d29df2mr14266490ejz.607.1670000910978;
        Fri, 02 Dec 2022 09:08:30 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p23-20020aa7d317000000b00461cdda400esm3168080edq.4.2022.12.02.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:08:30 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:08:19 +0100
Subject: [PATCH v4 3/3] media: uvcvideo: Add a unique suffix to camera names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-meta-v4-3-3ac355b66723@chromium.org>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
In-Reply-To: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
To:     Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=nncAxgIlMLPqi8B4D2XzAtMUAbjMzg6DbKN4jx7ltvo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijEKf6IQrPsYfpx8DB/t21WB2f//wrtkc3pBusyj
 OJet42yJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4oxCgAKCRDRN9E+zzrEiEf9EA
 CQ4I7QGoNfJc9SX11wg89UhJOeSV96QkPThsmoSd+ZSPI54GSWuTIU5scGGnYkXaCUoMlZh0UUvz2Q
 aIq7bDEfpmwCV6ioehV41ihZyXx3jAk8hHwjArKCdkvjxXL3qcBuYBvqDnNhPDufiMbdt020JrednB
 SlFrEa9DrGYNGERL7H5gyh60gLTxvT6i3TNP+8Q4+cgnXkMYDwTWXZ2Qgc5WY8ULBtXzWW8/BxNocr
 yVr3Lh795K3zVpg/AEiG+ZseaV9I5VTc5NzMDwAwEzOS66uLFPBNYuN67PlW/WO354hOJw8hdkgZqu
 nyem3E/OvSF6k5Je/csoQ3OUJFbw0b657ilB4bOQy/BL7yH6MYQPRfziUKJkLi4z+H7FdbuFZwpWEK
 EgdH9jGHSGYUD+ePn1TGzttAah24E17G4QOWGt2a23um4b00eIMvXZcYap/n6BfO6jDiJpMYiyfqZN
 swe6t1+t0zmKdYVcznkLD7F8Mj+WmkwYcQQrphdjKlQN8NsuSi2lXExVumSnGRNT3CahDuqovBw/Bq
 vJ187rhlO897Szhl+WuAzg1quLkKQ9J6sXb9M3Exexs3r1hdyg3alVYAjzxAFARErx9E4Y8C7HWJjG
 To1sxIYs0gyIO7Zacp/WnYB3q6NuiAnaIjJrWXFe32Bp18lk1ikY4VrFPJsg==
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

Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
append a unique number to the device name.

Fixes v4l2-compliance:
    Media Controller ioctls:
         fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
       test MEDIA_IOC_G_TOPOLOGY: FAIL
         fail: v4l2-test-media.cpp(394): num_data_links != num_links
       test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 215fb483efb0..f4032ebb3689 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1963,7 +1963,8 @@ int uvc_register_video_device(struct uvc_device *dev,
 		break;
 	}
 
-	strscpy(vdev->name, dev->name, sizeof(vdev->name));
+	snprintf(vdev->name, sizeof(vdev->name), "%s %u", dev->name,
+		 stream->header.bTerminalLink);
 
 	/*
 	 * Set the driver data before calling video_register_device, otherwise

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
