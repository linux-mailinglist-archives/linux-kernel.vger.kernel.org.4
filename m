Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C1D5BE84D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiITONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiITONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554971A388
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l14so6464310eja.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=IsXtqWi3aYMJWgr4SCjULTHnfzXmNkyNP5+0rfZs3GE=;
        b=Wg+USxpTe2mvtgr+Cd7kMlIFnWdYOcgj1feCbTD48oJIvWAGrIPvx2p8i8NZ/2hCCw
         /aY2Y9toBiozhvZ4WbJOC7ncsBCDHggHirIjyMR3EAlySXxJYEuiK7YN8m3uLWpByMIn
         AxXP1glYWmVsKB6atXE12CCxANcsv/229T6Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IsXtqWi3aYMJWgr4SCjULTHnfzXmNkyNP5+0rfZs3GE=;
        b=R7N1liekFMPATAaf+WtKBqVzrwoNN+6mvUoaFgErlxdMyt2pJPOPNGwI9dBxsYKzNi
         fTd+FPRw5caWh70BX+VrvD6gXOgQK9hwHnKKbamPEchtyMgarSzP9R975tBCvVjmKcSJ
         irTA5IJA7GcDGNt2EffHkMVECj+uEKNo634P7iaZysoDKnYpBTUGfc+BZozBhtUNupbM
         UgV7w5LyneDNSDHW59kbsSQvILiXF4lEJxjSeDckYpEWjYa5AiDV7/kZCzsl/b+jiVw/
         fKSx3s5tn8qEirJ3U6dUg+s4RuHB4ltO87V4bVWtaBRcdEocEW6DYQrnM1NtAsXCDqkJ
         fn/w==
X-Gm-Message-State: ACrzQf2yf6mWTvD6KG4Bu7/s1QxQxi0PoHb9ZDWp5+jN9x3C111Tbfm7
        IqFIbNq/mr25I/xAFHYjyAPjK+yTFa0ZExYox90=
X-Google-Smtp-Source: AMsMyM4Tsu6DrqVeVB0QDh8AuoFV1Dh8rvxs30c/15xLvA3rnx8VcrJnpsiyiZ2SBJy+3SARBYf2RA==
X-Received: by 2002:a17:906:730f:b0:781:cb9a:cc1b with SMTP id di15-20020a170906730f00b00781cb9acc1bmr2194784ejc.41.1663683081472;
        Tue, 20 Sep 2022 07:11:21 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id b24-20020aa7c918000000b004518ee90b4dsm129668edt.1.2022.09.20.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:11:21 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:11:05 +0200
Subject: [PATCH v1 2/5] media: uvcvideo: improve error logging in uvc_query_ctrl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v1-2-81364c15229b@chromium.org>
References: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=xuDJMTqPwFnBT90gGjW9sM+//WBwScMY4uWO/jQUOuQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcn+BMi7ITepYifnHZ0BCDGSoJWTOm0BW6fy98Tr
 u8zH2QOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJ/gAKCRDRN9E+zzrEiM9tD/
 9GwAfC5G1onbDTMyTZEVTc2GnoQQi38QcbejqNYFqdF8qfKCD7qvdjt4OvAYlFnNIOXmBPbqy/arGd
 vaILw71ZtnaXhAet00YxVRvtswXeWlWJdCyzRpaMT71o2p2tGGZO+aBQOYwCqp/CjGAOe6+rTlFx93
 RbzBAPiKnkMlnsj9guKyWLE4p3vCPDHfhTdihcC7xYX4bHEYjGF687htu/Ilfxt0PSbJ36+HEObyOk
 E4IjvA393FCnsfxUWe/IQLk9m2fpseYmDw9yOjmp2eb5jmXsrrXdmfDn+7vSy/+rrZoN4I9VszxZ5s
 0UvmzTcU9YcgyLIbq7bvhfSyHV8iukbm5hV2REtlcl0dczDBSVd/IbQPd9UjQX28ffsiGGLQ70boiK
 6nfAEFnnnnNVmgjAudGOElgbphyocRrBBL8ZEPA/oM4Hk2VEUPGHDAyLMC54Q0sD8BBA3wbV0J/JI5
 EzQVTuK+crzLdqN4lxzPZZ4saFP0z4jae1Hb4BK+j3eylNsSJ8y8gYJwEAorD51xLPXGC+AUrxt5j5
 FoB0RxDkq7aRDlOdeDM0AQXd45YewZRlwY49y1qDKuRgxNPnvj0jDMkYSBLItMQvW0Mb7ijR7v/7KI
 2/zsy8E4S9lT38JtFfq2x2Ik4hQMhy7b8T3Gz8g+G4E0EgiU4ym9Lis48iEA==
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

If __uvc_query_ctrl() failed with a non-EPIPE error, then
report that with dev_err. If an error code is obtained, then
report that with dev_dbg.

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..2cf7f692c0bb 100644
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
 
+	/* reuse data[0] to request the error code. */
 	tmp = *(u8 *)data;
 
 	ret = __uvc_query_ctrl(dev, UVC_GET_CUR, 0, intfnum,

-- 
b4 0.11.0-dev-d93f8
