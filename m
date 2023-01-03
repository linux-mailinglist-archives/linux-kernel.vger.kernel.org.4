Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE5665C217
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbjACOh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbjACOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:36:48 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B7E1146B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:36:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i9so44030934edj.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJf+h2f2R0607iPBKTi3aOdsbu1qoQNWuR3plbe+zVU=;
        b=DORFtksWSOAqwT83xzT791DCgSBLtY4QkVrt8RDWSezJ0Zzr3fxsYJjXA8m5j8JzSx
         D7fUA+MI4PnroF7PXK2faRne8PvsK8CqZxfi8AKDe6AqMe5FPpK6/8D3I7vMBSZYQpUJ
         EAT/1RabDaErRpWq/ydEfXK54MtXH/ianXzgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJf+h2f2R0607iPBKTi3aOdsbu1qoQNWuR3plbe+zVU=;
        b=aaBG+9U+MdUGalQdLiG+d5Qwkcd7meUrgY2Oju703XIerzt6MZcUn0L0Z4MqF5rTvj
         pnio8MhaScZpfe7Td2ps8VHDG/D3cK+GyaF/eScSgw4/3n5eEcE7bJXkNFk7rGREBXm5
         NgRIVFJaGIlJ54h1mXy+4NX9l7VIf/dlqMJ5edFkKqdFSTbT+UAUZ8jSeO+Sor7I3kj1
         5dI2ehYGA5hXbsKyN0G/nVVYNuUm5ZEGFArKdBQQk0k7EUNloe1TVOA8IyWrW/b2vOOD
         vVk0dWhU+zGklqixD9MWwoqa+l9DK7su/lIQ0UKka3QEfMn6b2j0mRig+Bjc4izrjnbI
         RGqQ==
X-Gm-Message-State: AFqh2kpqQcyZPzh1mjOTMdcI/vlB2v1sZBNqdw42/KCuKEL+zGvyDUVu
        dA2dp5fJiKF8dQ0fbOyE7Jc/XA==
X-Google-Smtp-Source: AMrXdXv/ERkpbmQUN1jOPgeP5z2kA5nwMnSadpWDuFkONa4pSNM4CEf4WAdUSkPlrEy5oOzet90Jhg==
X-Received: by 2002:a05:6402:14d6:b0:479:6bf2:a9bb with SMTP id f22-20020a05640214d600b004796bf2a9bbmr35770781edx.15.1672756606094;
        Tue, 03 Jan 2023 06:36:46 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:9789:8e2b:74ac:a9a0])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0048ebf8a5736sm877245edc.21.2023.01.03.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:36:45 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 15:36:21 +0100
Subject: [PATCH v3 3/8] media: uvcvideo: Return -EACCES for Wrong state error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v3-3-598d33a15815@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=sEdvpc4Bk0VAM3TYxG5czBefJfH6Gr4ihACOSTYlAUo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtD1vAXIWeI4gUm0GA0hIn8dST/3ChZRkz+xJCg47
 FeLEYjGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7Q9bwAKCRDRN9E+zzrEiGS0D/
 4hVkfk3RSkYUUFd1IJWWUGPZbi+dKG41xyvSqchdNJcO2eHDgfpa5JXTQDnPIxg+OkW/wV7q4eE5kf
 xsGSHI7nSs5ZY7aYxgisLTea27DJrhAqCqRKDVX/oXucirOFyOHUwGNijn6YlIjW0v72rxWWfjB00b
 kJJr0dNLrFmnchDcTIH54rb+1qNTrzrqceCNMezZ0OjNak90RHchQtnizV8oi5OMNHlt274fjwMOhd
 4lZwz33wVOFopez5y8qlUE5EukTYzd9vFeuBGWoK8No9P0Y27oKWB6VcmFIc2BAt+31SmA9HmlShwR
 4w2QNOR80PzrQbBl4gNoFF6ddEYf6eBXuyQGYjf5TSRkCCRIJGVV+hf1a34/XAVszMUkKu5FZKKRjt
 eiD7g74cXIHyIvFHd9eOroN5l+WLdS/W5x7ETRUQWwE2hYyo9iyJ91Sj3v3eD/QRC033A8fZGn2qx8
 cTDdI/754jIuYXP4Q+FQm0xuwFHUMptUzGB1qwJUFO5X/hHy7JPHJ5QkyXjo9w4Tr2/SYfnl3bXLwG
 d+T1IqsyQaU4ftJrWDG6I56sfhUGq/H+iUWvA62flRzfXTmdmDt6HiWg1t1jEy8VTXFF7mZ6JMduu9
 DVHLBP7lDdEOJ1XcArye038zZkIAsPGZUmkeDdfFgPnl0LBWv3W1X6QWFoPw==
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

Error 2 is defined by UVC as:
 Wrong State: The device is in a state that disallows the specific
 request. The device will remain in this state until a specific action
 from the host or the user is completed.

This is documented as happening when attempting to set the value of a
manual control when the device is in auto mode. While V4L2 allows this,
the closest error code defined by VIDIOC_S_CTRL is indeed EACCES:
 EACCES: Attempt to set a read-only control or to get a write-only control.
 Or if there is an attempt to set an inactive control and the driver
 is not capable of caching the new value until the control is active
 again.

Replace EILSEQ with EACCES.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Suggested-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 6b20a23bc3cf..e56ccde9bd10 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -108,7 +108,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	case 1: /* Not ready */
 		return -EBUSY;
 	case 2: /* Wrong state */
-		return -EILSEQ;
+		return -EACCES;
 	case 3: /* Power */
 		return -EREMOTE;
 	case 4: /* Out of range */

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
