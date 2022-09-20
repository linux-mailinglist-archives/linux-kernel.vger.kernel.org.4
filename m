Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB675BE7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiITOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiITOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:05:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB81E3F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:05:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z97so3973320ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=h/Y+36rJ0XAmUVw3zSB7sEQBewEkFELkMaeQ46FL9RI=;
        b=nDxr5G3hmfov53FIPU+bMdw19ZzV3ysB58zax2UKojCpw9siSEgn05Ld0yfi6gypvh
         a8hPTZ+bADhL+dugKmmpefdko3bunzrKYJ4QgM6WqvXZwTC0V7Y165v+gDpMx5CBg0VE
         9pxdC3+iWczJ8bPHocHXYRF7QMFjq/PG7tl4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h/Y+36rJ0XAmUVw3zSB7sEQBewEkFELkMaeQ46FL9RI=;
        b=3kvfzcxQDDH0q8D0HDRv26h+Nutpff7oldkZE2+4GkHUdc9FpdErssHzlCC6kcSKA7
         VsH5Q/eCQyM/f8RiInKi5dmavT6Uft2QQBOhvu19aKmefn4EBaZO9iDnW54RGSukBLu/
         XEhdVTnJDe65ned13O/K0tMH2nQhHIsrMiLms6iBf4wXP97BmV1JN6N4nxn8Wab0GdQC
         VZj0kjFcRRpncouuBs5yMyLJ/6QL4tSQbxzPczXV8kj/VUAERjrF/cLNpzwapHd4pr+1
         R/LGqCnbtX7SO5a3BD2qFx6izNoy/oiAWcpE+FMrSlh8vb9FbvOCX2HfSwSifUWpkdX2
         z6Jw==
X-Gm-Message-State: ACrzQf0xMmJNq2FyaiU2tN+w5fUAKJQTT2h0LXP9CmHz/oCAfdBq53p5
        4qKIBceHbMfTlB3/KdnjjJVHBQ==
X-Google-Smtp-Source: AMsMyM6P6AzC5fYUByFUxhZ8UKT8Tt2oH7mdE1bRQD8H+je4WMnuqOFu96IXoHR0SBmMxmMaa3eylg==
X-Received: by 2002:a05:6402:1d4e:b0:451:d378:eed2 with SMTP id dz14-20020a0564021d4e00b00451d378eed2mr20933164edb.23.1663682703410;
        Tue, 20 Sep 2022 07:05:03 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id k12-20020a05640212cc00b0044eb4227bf6sm69903edx.63.2022.09.20.07.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:05:03 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:04:55 +0200
Subject: [PATCH v1 1/1] media: uvc: Handle cameras with invalid descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-invalid-desc-v1-1-76a93174f3bc@chromium.org>
References: <20220920-invalid-desc-v1-0-76a93174f3bc@chromium.org>
In-Reply-To: <20220920-invalid-desc-v1-0-76a93174f3bc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=785; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=yrIy3l2hnY8Y9qudM5caOkWLQdYzxUDmVwB87V4YlIg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKciKU5BRvhxeSLYCqXBMjKZdD/OSWslWH9qO7a3z
 jBqdIzWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynIigAKCRDRN9E+zzrEiCdiD/
 0YQhHecO1z0ZHXlISotWTYf12qCFjOg9p6fGk4osGFFVTFWhfJI7wA0JtN5YkjURnTccqy0cK8yqIM
 h/aaxJT6iPBBTH6oJr1efVVNRSaNGt5tNFzG3+Il2Xp67xVEnpG7ILT367xoY9+IuPPl2Th3jHgvTA
 W/3opG3DU41jItHLzPsSEHthiH5hDevJZbB9xnVWontlVYsPvEC5b3Y86JuigxWN7xOWTvjMkuHD4L
 7Pp1z8G1ATP2CduZnAQEyxl689bEUiffLUG5VIsMcNzVeK5HaqvCrMXonQtZoonBHXiIYrHnKttWkQ
 uj/d5FstHETl+FwrJMqtvs2FDwqeZ8qaEopPEa9X88HfZR/HpLP+4i1bx8GMeaZorLnkcJKKtR7R5G
 fUQ8fLqj8lqwdVonmGBT9PqbiwSKd/F0yyENUdg6UajOMY2WQf0Xt+rQ+JGkzdDyY1sUWeuEenD9Td
 lxIWKNQULtey9PEEMZ+s/yAxe3bHkUGt2p8bgts+mMKmEkcLYLuE/A7Y3CdwwKf2O7vsWFyHanGWmA
 /AMPkF2xz2XjOSyaKSbDSll2ZegagmqMF8vIZA9abbzNfQBw8pzpJZnYXgO+OQkhDyTsmSiJkENDmG
 pKNXpUSGoLMhp+Lg7gYUbL3dMW5vDxyzgrcPAJYn0OoKifJNyqCrIjwAeBJw==
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

If the source entity does not contain any pads, do not create a link.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 7c4d2f93d351..1f730cb72e58 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -43,7 +43,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 		source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
 		       ? (remote->vdev ? &remote->vdev->entity : NULL)
 		       : &remote->subdev.entity;
-		if (source == NULL)
+		if (source == NULL || source->num_pads == 0)
 			continue;
 
 		remote_pad = remote->num_pads - 1;

-- 
b4 0.11.0-dev-d93f8
