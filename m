Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C39640C03
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiLBRWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiLBRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:21:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0466F0F6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:21:53 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id td2so13070550ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQFSXPNg1gYWDjvMJz4jAnc9KE0EX4hKeDHlzX5rMq8=;
        b=BnzWpCO8mKVwdT7GTBAEcgvYbnL01MbI5NQsr83wBtyLA52vq8ngug/Do3zkiBUTGU
         EFl1ygWJntPuZIG82M32FyljDEI925ivDIflHNPNj/4vs3/lo3hJx+86WVXnlJiu3J2c
         S82/5sdSnehGTxs2P7Qm+mLT4cQUErat50eHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQFSXPNg1gYWDjvMJz4jAnc9KE0EX4hKeDHlzX5rMq8=;
        b=azs6djI7GnN8Ej1PtUtnTUEW4XKRQZpsePdJ8CJ7BCuhZYx/Eo39B8y8wv6fqjJbqu
         2Q7BEiuTGyAjlX7fn6uXvICmPBfDCN4mYYFPZW4Rof+RmhK7jegfEUUg4ikn5QeUukEd
         NkzgchJ/CPjD/pjLelJVP39Y+jHnNv2zsUojSKDL276QgMJN9g4iEwFE7dSSK5o5x9yW
         JT+Sbl/OVbhAGm13I/tuaD4gOlNFYS76CNHotBMLI3MRvMQ+EJTAL38hHKcZJotk9Tmp
         wjmaE0sVSRkv9d9DT4W93Meyas7dNnFnoBMwJvF3cKdWXytq4njDp3hjO67xbfi8ktxp
         3xJw==
X-Gm-Message-State: ANoB5pk1/8PsJjRKR+Sg1sNX0HvuD4AwqhqxvO1qWD4dDyPJatCojgXx
        vMIR8dW3bMQW71d+3iNcOcLmmQ==
X-Google-Smtp-Source: AA0mqf4+9k23pGxMtPaDV7JNlE7qOO4EcQSAltmwU541N1ARqTeqfv6lznQMxyulYOVRBeA6QaPnPw==
X-Received: by 2002:a17:906:a198:b0:7b4:bc42:3b44 with SMTP id s24-20020a170906a19800b007b4bc423b44mr54135498ejy.101.1670001711651;
        Fri, 02 Dec 2022 09:21:51 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm3206685ejc.211.2022.12.02.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:21:51 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:21:36 +0100
Subject: [PATCH RESEND v2 2/7] media: uvcvideo: improve error logging in
 uvc_query_ctrl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v2-2-b0ceb15353ac@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=rgm9ldOQdFvtTQWrF5DcxtzEXVIXvtMre8cRCEzUeW8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijQkk2KiH3FCrs6/9FkXB8JArDKnUjOw4uk6Fbtq
 tybbomSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o0JAAKCRDRN9E+zzrEiFFZD/
 44nlgQCwCgK7bIXKPqOnXBjUX/CBmpUHIfxXj/WT7srZAhrBEf52wH6Z+F3HUfHHnysgURi+FmipeW
 eanU/JiSfbgezrCmitzwHf/MZx0ugYok1EBad4MXzQid7LYim1h8MbG0FXViYI2DazlxdVEVxGw83K
 uGOpjPnUbwqr1RzrJfGVQqzg6YtFv6qs96q+sbD8f8j6sKPIszBB9zk4z2hzcu7jzNW4kGWa9d5n5S
 uRnD55iYeMYIgfeMc4uUzQE6e+m2KDZEGg9ilTutFYMKkSyM3YDLhXMIlS6DX/nJ9SdEn6RF+hbDuk
 MMZH0R/Hf4VFsnnlKOclKCGHBU3WOBID8LLJ7JbLdKzKQVR7YeKbKpR8xEAqyl9RXzGttP3XxG/4ej
 zk6bn+zSrjgVqKdNUOU+6xZSS8wtFi9cuyG/0rrlJUIQP/Yjkay+45QwlfZRZYmboc91bNjzYj6iif
 3acLBeKaHDp1jKDnX42a5YVmNke18FNKUGCv5j1sDS9cb1eIWJwAfvDyTNyBf4TcuE3rByLUh9uhOQ
 epjRq9+/JZ9ZwmJF95UhecCD4aiKFVYzCxASZ47wB6XyalMRyJiTnu3cO2h6rIjzRhLn2vbk950J23
 QxVYNTgEWAgfSLdCv+UUP8TaXwWa74cfPhNKhCDrJPkUEriwiD76ol3tn/Ug==
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

If __uvc_query_ctrl() failed with a non-EPIPE error, then
report that with dev_err. If an error code is obtained, then
report that with dev_dbg.

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/usb/uvc/uvc_video.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
