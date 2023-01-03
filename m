Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168065C20E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjACOhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjACOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:36:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A430210B70
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:36:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i15so44100283edf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL6vjumDEZ8bp9EfDhAS6U23Sa8DpoR9rvInW/saadw=;
        b=G2By3BqJTaOu7tcF/DiJTm7we72oLpjph2rOGNoSu+JD8xr2DkYMcjrUUF9vdGMtea
         MlzYiKHewd3ACEitRrIqPdDGCY7yjVTgnQ9jjkI7pDAq3NsmTuWr1GoKLnKWWwY8BBtw
         22kHIAil8+r17B8kM9KP4j4xw82PnctDUJ9pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL6vjumDEZ8bp9EfDhAS6U23Sa8DpoR9rvInW/saadw=;
        b=GmhiB/DebM4XBTG6eKcs/d2BP1iln2hMl4KNsY00XqOknkjFcURwKzdwQATbZerf0C
         draL3Ahg00DHi4PF5/4EbdNJ0weU+wV7zEi36ShI7Tdiq4NyPTFVnQgnYDqOWjhDZb6M
         NGxZSR4nb6CBLQcDUb+BIGTX0061j8wtTbJgFrCIo9+MONeyVzYr7BkpsgGCXSt1RQ9y
         3APyCLlXdp4dzUZQGR5R951u3OPG1wy6lw/mC9ve/YRwArGYFAlXvVis3ac9M7bjtmiz
         n12fbePtrNxhhvpyTc9FVmkKxElFM8Fq6mSlaR/RGUy7CnDMbXq0t55rrWYNRTn8Ibuu
         q2Ug==
X-Gm-Message-State: AFqh2ko32TTEzqyvoY48VjHpmro9iT0SXXoVoU8eO3oGo0mye2JrEAam
        8it7x0/3pStfUgzrjG9WeGG8ag==
X-Google-Smtp-Source: AMrXdXvjqPPYzbopbrJmWLjzf+kJEn8sIFmgDwOGZIYyPJaThxKy8VZaNxUZ0dVmtzYuIZIoAuzcNA==
X-Received: by 2002:a50:cc4c:0:b0:463:e2cd:a8b5 with SMTP id n12-20020a50cc4c000000b00463e2cda8b5mr39293162edi.11.1672756605285;
        Tue, 03 Jan 2023 06:36:45 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:9789:8e2b:74ac:a9a0])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0048ebf8a5736sm877245edc.21.2023.01.03.06.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:36:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 15:36:20 +0100
Subject: [PATCH v3 2/8] media: uvcvideo: improve error logging in uvc_query_ctrl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v3-2-598d33a15815@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=xOoehc4vwLA0iipvzwLxfRoUl2KbfEEdDxl6zHy2Huk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtD1uUt2X//JNsQhBiFozEJj3L0qZd4uDB5oeAeJE
 GHvpzAaJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7Q9bgAKCRDRN9E+zzrEiIvdD/
 9KuCrPeHfK/M/hRHQYcLzHTK8be+wwTwYRSKkanRDWf0KHAK5MM6zVmT5hriYH0w3YqxzeeHKaIIDd
 j1dQFL4sAMUqRD3GdBx24cAX/8qC+5vp3bS73dMCCbUcMFpS7/M6nBPomAgyCIH1aWr9wSctQJUSf4
 9d8evKsYnfknwWBOECRm81z7mFaegh42WjAlWu2jMbNZIcBRUsjSNL0LANTmbhppLhA+ZH9FM07br8
 Rc/pK4V0ep5yaH2noRepY/hy1HgGwD/Jtc4I9Frn4jdPlKhoIQSLcHidf++AEBt6jPkQlxyS+FQu3H
 UJeZVUhbUOReB/JNNyOjATS03KvlfmYvhSBM4FAOVH+70gnYpRXCMpgOu3SNFfH/xPAPAUG05Zo71I
 21xh3S9K7J+f1fVvpwcL96kLpgP9V7F3axwK7gGvjHHVIuX45vA4mWkA4Hz8G4p+veRNDLoCZZd+k/
 qS5dK7hzhc9djVwq2bGXNpJ4yZ/K9r06KM4p/h9l+S/sNuPlHDexcN3n0Q5ZrAMbHyl22gaNn0OHTP
 IYfCDOoaoTSmZqlYQyzpButmheKxlcvzHjBou4K5SSFyrq/yeHTMQ9TkZDde4lTLzJLKlGQ6KtS76O
 RRxFuWoNuaohxgmgUePIsytf8tpmXzESQauylOQA5ibkSt0XMxJrLxOyQ/eQ==
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Standard use of the driver may result in error messages on the kernel
ring buffer. This can hide other more important messages, and alert
unnecessarily the user. Let's keep dev_err() for the important
occasions.

If __uvc_query_ctrl() failed with a non -EPIPE error, then report that
with dev_err. If an error code is obtained, then report that with
dev_dbg.

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/usb/uvc/uvc_video.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d2eb9066e4dc..6b20a23bc3cf 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -79,13 +79,14 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
-	dev_err(&dev->udev->dev,
-		"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
-		uvc_query_name(query), cs, unit, ret, size);
-
-	if (ret != -EPIPE)
+	if (ret != -EPIPE) {
+		dev_err(&dev->udev->dev,
+			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
+			uvc_query_name(query), cs, unit, ret, size);
 		return ret;
+	}
 
+	/* Reuse data[0] to request the error code. */
 	tmp = *(u8 *)data;
 
 	ret = __uvc_query_ctrl(dev, UVC_GET_CUR, 0, intfnum,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
