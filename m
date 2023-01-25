Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519F067B9B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjAYSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjAYSnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C727045BEA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674672157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z+BBIerRTFgcd1PQmeAjWnPoawpkV/Pm3EMJIWf956I=;
        b=XgY3LxQFsnkiywRThFr3Nu5lzDrMLK/JRfd0C3whzgxQAQRf/F/y1e4z0mH43cfGfWD3wP
        cYgQXuzTMRhHcqAkV+ctgOWkywtZVrkRhbgeZhGdn+k/eMWjJPNGJSaMu3sQ87IpAbtly6
        R6W39oBJv6fse8rT48hvPcLKb2nhh0M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-hsVn2CjONaKLnoqWwzzciw-1; Wed, 25 Jan 2023 13:42:36 -0500
X-MC-Unique: hsVn2CjONaKLnoqWwzzciw-1
Received: by mail-wr1-f72.google.com with SMTP id bj7-20020a0560001e0700b002bfb3c6ec00so952854wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+BBIerRTFgcd1PQmeAjWnPoawpkV/Pm3EMJIWf956I=;
        b=088V4r3nqzs6f4CvznZh2CYw9AiKGOrakNCPu2DzWcpOotq4uB7jUFEz24qsKZWO2N
         NjxPrpR/4y1WjDJ9rBoXKekWaXkII3iwaAp/8glGyB1do27dAmttxAddinGB5/mCKRcj
         00n1dTXZFNKcaojAlkFsFT/+/KhR8MQL1EqcnTiNZyWx9Oe090M1s6aEvC/mP8r0463R
         dWcZAaSmBBKOvFm7kRmKnWfx+6D1nGrY5ia+lw4smkJSsn51OaXDVjiIGuLb2CiNld0m
         rCay6zyrv6reijyH9D3ViqFlDLueIewfFY7gwxum8/uT6SCvoDU+5YuTcWFKd3eyb9p+
         QlSw==
X-Gm-Message-State: AFqh2kp/rbyhBEN0zC5wWJW6J8BQqyrlo/ls/d9ySxXccX5XOauDCCxN
        nQwsB9Pcvps8OfY+sDLlQdgd3K60+t0wiQ9tDcvAHJoII8W2liIyX5p7gqt6wI0lVjstmn+e1VV
        Jjl1KJKhcTJxwsUm7g9prmrtsJ51SdI/zt8T02R/Ir2reO1dzl22+5Ct9n+sJUdqZEcoxH4ANLB
        Y=
X-Received: by 2002:a05:600c:4689:b0:3d6:80b5:f948 with SMTP id p9-20020a05600c468900b003d680b5f948mr31078750wmo.39.1674672155112;
        Wed, 25 Jan 2023 10:42:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvu7swuc3fCODlAmXzO3G98ZhFibsWBg+iJ5cK7WtNewYD33+Ngij/lMSQGu6CJfOf+hA1LVQ==
X-Received: by 2002:a05:600c:4689:b0:3d6:80b5:f948 with SMTP id p9-20020a05600c468900b003d680b5f948mr31078734wmo.39.1674672154864;
        Wed, 25 Jan 2023 10:42:34 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x26-20020a1c7c1a000000b003db01178b62sm2524197wmc.40.2023.01.25.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 10:42:34 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Init display before the SSD130X_DISPLAY_ON command
Date:   Wed, 25 Jan 2023 19:42:30 +0100
Message-Id: <20230125184230.3343206-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 622113b9f11f ("drm/ssd130x: Replace simple display helpers with the
atomic helpers") changed the driver to just use the atomic helpers instead
of the simple KMS abstraction layer.

But the commit also made a subtle change on the display power sequence and
initialization order, by moving the ssd130x_power_on() call to the encoder
.atomic_enable handler and the ssd130x_init() call to CRTC .reset handler.

Before this change, both ssd130x_power_on() and ssd130x_init() were called
in the simple display pipeline .enable handler, so the display was already
initialized by the time the SSD130X_DISPLAY_ON command was sent.

For some reasons, it only made the ssd130x SPI driver to fail but the I2C
was still working. That is the reason why the bug was not noticed before.

To revert to the old driver behavior, move the ssd130x_init() call to the
encoder .atomic_enable as well. Besides fixing the panel not being turned
on when using SPI, it also gets rid of the custom CRTC .reset callback.

Fixes: 622113b9f11f ("drm/ssd130x: Replace simple display helpers with the atomic helpers")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index b16330a8b624..8cbf5aa66e19 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -663,18 +663,8 @@ static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
 	.atomic_check = drm_crtc_helper_atomic_check,
 };
 
-static void ssd130x_crtc_reset(struct drm_crtc *crtc)
-{
-	struct drm_device *drm = crtc->dev;
-	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
-
-	ssd130x_init(ssd130x);
-
-	drm_atomic_helper_crtc_reset(crtc);
-}
-
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
-	.reset = ssd130x_crtc_reset,
+	.reset = drm_atomic_helper_crtc_reset,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
@@ -693,6 +683,12 @@ static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ret = ssd130x_init(ssd130x);
+	if (ret) {
+		ssd130x_power_off(ssd130x);
+		return;
+	}
+
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_ON);
 
 	backlight_enable(ssd130x->bl_dev);
-- 
2.39.0

