Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B1D5BE84F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiITONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiITONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B55226
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 29so4061725edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=LybwIQYtr5MkOTsSbogVgHlZvfV5O5f7swHU1e23Nnk=;
        b=XGpXPObUCIdcbW6+kATPE1pa0rJOXlPSqXnXWxFCMfrdei94sbWnWOguM4Szh4xAz5
         qw3MeS//hxpC/16vm9+/7bKhnPZ1S+einB3uW2QlJzNPzg6us/9Kwz0VzjoouFyemWOP
         SLj6xaKOTLbyfGjzHyMu4JgLdaQJ+K37OTYx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LybwIQYtr5MkOTsSbogVgHlZvfV5O5f7swHU1e23Nnk=;
        b=wcFFoXnc14g2jwiVcqOvyRxy3XdLV6mHsVdt62o2AVslWTrzvIsbNyZYpk21XwkwG9
         xEj6L0rdmX7yeApFlbJVqALY/yN2DrEixjwk9tGaufH+NLHuXO7kqLS9wQWz9tirro5s
         bqmqgU4p6yFYniYX01Y9EWzbq6fc6JxnJFr7crDIZ2Wkf1bWezhVTQPQ1GGzYslHMSRE
         rCkOq7j1ejbVouqk24HKvy0cZBmN1q2xkYb4TFjJCmzLG1OzMKfseUIzgUEm9bi5cmbr
         H2PFa3DvpKmrYaLlCZuk1fi9h2oGG314NivJlL4A50FL25y5FE1ir2S3WhxnEI94Wuhv
         5CiQ==
X-Gm-Message-State: ACrzQf1SBTTDTx55P9exCn9ljuUaoFO0BHVChEsxsbnlg9v25b+NbX68
        ZZFzixM/oYdghHEQKN9AxDLSWONdqRAlZ+reD6w=
X-Google-Smtp-Source: AMsMyM6GueK/ScSoEqg+pIo2Qo627Mmr5ypK8TeU2+MpGfijHbEmj7S/BGDsKKkFvndBRaJ42Aqo9A==
X-Received: by 2002:a05:6402:b85:b0:44e:dad7:3e24 with SMTP id cf5-20020a0564020b8500b0044edad73e24mr21080703edb.264.1663683083754;
        Tue, 20 Sep 2022 07:11:23 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id b24-20020aa7c918000000b004518ee90b4dsm129668edt.1.2022.09.20.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:11:23 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:11:07 +0200
Subject: [PATCH v1 4/5] media: uvcvideo: Do not return positive errors in
 uvc_query_ctrl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v1-4-81364c15229b@chromium.org>
References: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=lvRGgJW7MhPUQfG+nYO+p570MCZiCiBKUgYSsY4PyFM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcoBYgbZrbg5ljLAWYbJnhg/lWzmT9LI8kdMIM6Y
 A04RZISJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynKAQAKCRDRN9E+zzrEiMJfD/
 9mQFTZGV9/PXf7DjRSKX9FoxJQmOgiqY4qZ5id+f7u+hpqhJmjnQgYEBPaWvIan+xqNkPMN5IxotY5
 nZT4mrnDNc2tr9NSaPHwpV5CGjYpDgvWIV8ABMSnFHwmJ9njolndOOccOVrsro1w6IYKJPEnH3oelC
 p8A+oEPhsZdgqHTWlsO53mBY2+YVnQLSxaOwSblTpjV5BhAcSedYDObFMUVAped0NjJP+O0eGpgGQn
 qAQtmEh/QtsV0cZtt21RxZPFGAndVcI3xvA3/XH4646eyrzE/FsgIltSlwgSlwWrw1nzgVx+iVP7rX
 cJihDQ+akf4ssGXcfb3+gLwuXA8ywMED5/Gl9ZvWz5DLSV82WbPeS8l7YtnMRteimSUfOnaiIO1Tmh
 P/TOyPtL39wZFBKRU4iuwVuaXmsL0lkIOgjncsQsXP3n/upFns28GiBKuI5z2F6qr68lDsn2Oy0ZB0
 hkKsNPLgjA2yxJQixUSYO6GvlCis5DdizE5E0MkRBgVnoTfU8mpy1u1Ae7Yji0p+4T/0h4hSdV890L
 8nZAgdV8oOs/A+yEFtnupy3g9ZyRSHbcoitHpnHdosH5/Gh9C4dydk0mb4h5uP8NxCOejt/sTkOOwa
 JrKqUEsprp6uDE+lIFW0jJJ+G0nr1fACK8qNMpXHlivWP0K4nhFbiNN+cKLA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the returned size of the query does not match the expected size or it
is zero, return -EPIPE instead of 0 or a positive value.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 497073a50194..902f2817a743 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -83,7 +83,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 		dev_err(&dev->udev->dev,
 			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
 			uvc_query_name(query), cs, unit, ret, size);
-		return ret;
+		return ret < 0 ? ret : -EPIPE;
 	}
 
 	/* reuse data[0] to request the error code. */

-- 
b4 0.11.0-dev-d93f8
