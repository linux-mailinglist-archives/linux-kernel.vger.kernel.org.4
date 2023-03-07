Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A649E6AF617
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjCGTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCGTqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A54AA8834
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678217734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KYmc83GBs2GOcntamM7m0RX9zUZjNNeykOZSju7+M+k=;
        b=Peyz9I6v7IDmTGpAgsSdarPOJDbQZd8EOEnZFbcv+ejyJ/yNcJi8bkn2GH/flMYyV8prNa
        T/12XRRmzPcwKQkWpAIY5esHdH+XJr1/SmxtRCj20Ab7v90EeYAuHcDqWgTjh05ZvAUEQE
        zo3lNsE5XqHSHAiB9lOVOK4oN79rAMI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-uzgBD1CGMaG1HXufJ1pQuA-1; Tue, 07 Mar 2023 14:35:17 -0500
X-MC-Unique: uzgBD1CGMaG1HXufJ1pQuA-1
Received: by mail-wm1-f69.google.com with SMTP id az12-20020a05600c600c00b003e8910ec2fdso5152987wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 11:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678217716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYmc83GBs2GOcntamM7m0RX9zUZjNNeykOZSju7+M+k=;
        b=jooI4+FjkL4foz3fWyoFxZLj5KFJAMFgxUkLXFz7OX12zOehYgHsQhqBOlo4Q2lx0F
         GW4kE5dqYamadaCC25F7OC7PTyNg+3/71E17pbK4XhiPOrK6LqPLLuMZVfqQl4FVrFMQ
         7MZ3C7jeQf0hC1OG+OLANbS6DKiRXIsLtMyVNkbwyESVju6qOvwxG2nGzFYev2Fzz4VE
         KCkozM0PSoUzZChc2X/YzbtjXfx+zi4UpudxHoAp/9eMT5K/FQMjt7QONOreXP9Vt6HG
         sfe4apa4YWcgtS27oh41pA5jSw7GIZEuEsUYBnCvRgcn3Zbo9e5o+U4iZ56cye9+uuja
         LwIQ==
X-Gm-Message-State: AO0yUKWb7pG/u/0QAvxVf3uieQrKeNC7qrXbOZzbXiXp9Nc52/Jmfw6n
        qp2iHwafCLMuJReN7Gr930HD2wOBz2H7woAtEqM+r73FnLb83tx9eEkuxxpQdI+oWPB3LhL3JL7
        6zxNdg+bFmMPQkfktz64Nrju1a71g3qvmQqgsxD0MOjz1i06DAN0iGgV2fG/s9ghsx0HU5AYwzY
        aDX8u3DK0=
X-Received: by 2002:a05:600c:468b:b0:3df:fcbd:3159 with SMTP id p11-20020a05600c468b00b003dffcbd3159mr10930191wmo.3.1678217716410;
        Tue, 07 Mar 2023 11:35:16 -0800 (PST)
X-Google-Smtp-Source: AK7set9EF/utzGu8fX4TGyh6OXkCzZGiyskAxyksONYkz/GnN0X7MyJNW1dFFpEng/Xh1ROJ6z3ctw==
X-Received: by 2002:a05:600c:468b:b0:3df:fcbd:3159 with SMTP id p11-20020a05600c468b00b003dffcbd3159mr10930163wmo.3.1678217716056;
        Tue, 07 Mar 2023 11:35:16 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003e91b9a92c9sm13617137wmg.24.2023.03.07.11.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 11:35:15 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arthur Grillo <arthurgrillo@riseup.net>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Gow <davidgow@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/format-helper: Make conversion_buf_size() support sub-byte pixel fmts
Date:   Tue,  7 Mar 2023 20:34:57 +0100
Message-Id: <20230307193457.331360-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are DRM fourcc formats that have pixels smaller than a byte, but the
conversion_buf_size() function assumes that pixels are a multiple of bytes
and use the struct drm_format_info .cpp field to calculate the dst_pitch.

Instead, calculate it by using the bits per pixel (bpp) and char per pixel
(cpp) to account for formats that have sub-byte pixels.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
Tested by making sure that the following command still succeeds:

./tools/testing/kunit/kunit.py run \
--kunitconfig=drivers/gpu/drm/tests/.kunitconfig

 drivers/gpu/drm/tests/drm_format_helper_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 9536829c6e3a..f200347a1db7 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -409,12 +409,16 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
 				  const struct drm_rect *clip)
 {
 	const struct drm_format_info *dst_fi = drm_format_info(dst_format);
+	unsigned int bpp, cpp;
 
 	if (!dst_fi)
 		return -EINVAL;
 
-	if (!dst_pitch)
-		dst_pitch = drm_rect_width(clip) * dst_fi->cpp[0];
+	if (!dst_pitch) {
+		bpp = drm_format_info_bpp(dst_fi, 0);
+		cpp = DIV_ROUND_UP(bpp, 8);
+		dst_pitch = DIV_ROUND_UP(drm_rect_width(clip) * bpp, 8);
+	}
 
 	return dst_pitch * drm_rect_height(clip);
 }
-- 
2.39.2

