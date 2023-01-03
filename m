Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3625E65C218
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjACOhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbjACOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:36:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A8DF5D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:36:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r26so38830053edc.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQ39IOVw3moKdkeR5wnNzBJ9M+k6/kqT58GkeY6kRfU=;
        b=Oyi/FMO8dPSi+gTq/T0EBXugBrSrsBqfOatsjam/6Lnf16DuB5NfBxE9tnOMaqimBj
         UK9nffZucqy4W9JpIBLhExMPnyHUM4HSA1dljacVjjyupIHs8I5f3FrrGFlriD2yx8xD
         m4lWBBtDo0wEVsLe7sRjkl3ZJTHdtUJtvizSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ39IOVw3moKdkeR5wnNzBJ9M+k6/kqT58GkeY6kRfU=;
        b=NRKqWU4EHxekAHELs89KUrkJllGx7s9ozHYtI8T+stV0Xv0I7LKGr1MADCU7kASVsJ
         TcinQRAJcXAtY9W2KQqlBvyxiWSUlJD3kODlD9XFCaCODjVOF5POKOWlYf/TPPnfCZhL
         GrqzThVOYKwaeQ1RsUzUwti98WXpLaW/96A1DDoWaqz4bErXojxO30XrvoWK182A1AJY
         /gwUeBh4FPcjDUkN6L+oQ/nJmBx8NtojabIAJH0pY9bRZKcvHTlnz/8lJwmZDulVrxJy
         PeJpwllp6zWPRp0TqydTiPN4j0DF5hgcUqV40TkRLBVLKbMkpn6XT1Rgk/r7jvQO3kcc
         tqyQ==
X-Gm-Message-State: AFqh2kqXQONZ9Iiet9fLXx9wtSzFsmvR7vvlfrWi1z/k6A0y744KSL1c
        qbduniB8/Xe2j7QzCdy5oWnkLQ==
X-Google-Smtp-Source: AMrXdXt45vQ+iH17GwUFClbUO+rypyCu/MAyaZEfS0HHHkGJYvdbtLLIox3WmqmXbXnSk/9vP8f2rA==
X-Received: by 2002:a05:6402:33a:b0:47d:c06a:c272 with SMTP id q26-20020a056402033a00b0047dc06ac272mr38542370edw.31.1672756606939;
        Tue, 03 Jan 2023 06:36:46 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:9789:8e2b:74ac:a9a0])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0048ebf8a5736sm877245edc.21.2023.01.03.06.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:36:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 15:36:22 +0100
Subject: [PATCH v3 4/8] media: uvcvideo: Do not return positive errors in
 uvc_query_ctrl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v3-4-598d33a15815@chromium.org>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=yxgPmvZyTx1x+TY7IUGRFua/vffmv7MJCLBQE3ospZY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtD1xyCcB64eeoZqfpJYhCy/YtzURE6aTnDr3+j5L
 ZOBCoAyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7Q9cQAKCRDRN9E+zzrEiMZYD/
 4iuQJXS6BIc4hiZmDS/bNt4SrzIKdPC+Ml0Yr1VjziVZLUtx1b65snPKAYiN0mZcEY7qrRg5vDodY1
 E07qSoGd4uTuhgvp+QFOaF0pFqoxQ/uU0+tXy8lVgQOBIZ2Q5/WA/curty4FlrF246K3SSecfhMIiK
 /n1YWm20+llcbRYIxfEj3oNpsMTHoWkQEDdV6VHGND2otUVSD3oEedRxh6hMgxsO762KyTrdDmc9i6
 5Fj0EWWQamFHcXEFKhsPk+G35DxqK79jnFeHw6NML799lUwtIrZrVcKpfwEATKjIVoPwPRxfl1UuWz
 GiTuaKiQqVGeTzwLG2r+0lMXFNI7HJxoM49E1Y00RU4pBJgZltDgbONttoOkhuts645otbwynyAamu
 WmqN9JsF8HwEemFYPj9DSrp84ZSUcS1rpO6pCJ6GqudgGCSTyturEoeEcuLllKgYuZgDfSuhy1O8EF
 safrqQpR3PFAM5rZezwLl/cIWzF3cNRX3mSxOJQqUXtSGFk68m9YpM2ga05TYB4wp8Wf4wN6p4/x6m
 gfwqIYCQNdfmNGVzS/6C+wkeIfP7Wx+Bjy/w/dgTUOtoXBt+MBl4GXSyQavBs8+q+vnX1v9qoWFgzA
 s3jKK1OQzjodeq9RHTRmYZ14ggY3FHzgAEG6V1pj57ANN1DoMhRK8yiCri+Q==
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

If the returned size of the query does not match the expected size or it
is zero, return -EPIPE instead of 0 or a positive value.

This will avoid confusing the caller (and ultimately userspace) that
doesn't expect a positive or zero value.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e56ccde9bd10..feba058fcb06 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -83,7 +83,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 		dev_err(&dev->udev->dev,
 			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
 			uvc_query_name(query), cs, unit, ret, size);
-		return ret;
+		return ret < 0 ? ret : -EPIPE;
 	}
 
 	/* Reuse data[0] to request the error code. */

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
