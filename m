Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D36AF808
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCGVvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCGVvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:51:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F417A8C48
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678225845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YF8J1V/HdyW06qHE0PQyU5JTwvkaiAFhMsVbeRAMzxc=;
        b=EYpqUxU0TuqDv5TqA3HoCfG7UkFvzRDGyyVjCnSYL3/WvSATweSMp3sPwmjqyZpE2jW/jZ
        LpJDW85tLj0bZe58vuxw46nVCQ3EAChqHn7wi6qmnzufuLtftKGIRd5C29nm4dfxfEaYvf
        7Z5ukW9R2t0qFN4rJD0cT8t6gvru5fU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-HaRtYFU_NrCw_3Vfjfw3uQ-1; Tue, 07 Mar 2023 16:50:44 -0500
X-MC-Unique: HaRtYFU_NrCw_3Vfjfw3uQ-1
Received: by mail-wm1-f70.google.com with SMTP id x18-20020a1c7c12000000b003e1e7d3cf9fso26012wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678225843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF8J1V/HdyW06qHE0PQyU5JTwvkaiAFhMsVbeRAMzxc=;
        b=2kvF5DmuEWr38f4kGfqgYjPqJVaGNsEgLw/mUYyuM834NDxZuJ9ZpQSQRuOz9LZxZ8
         8ix7f54gIdr+oUwk+YBx0gtItxO/DOFqWJi5+44yxJKkbsWrZsa++RETxKCNt7FO3cOY
         nymIIvcYjoIKNbLegzdsVnv5b+5tSSlCpdIO1nOQ23CTA8kSwRYmt5kHU5Rn7i3w36Fd
         v3HSfUMsn7MYIxACKMMWhwnQIRViZBk2CTTZbIjb2SEgrTnz9703ehaCj4gq7fAGHUyr
         RpPhm5dDJglI/6SYoBayVwkXAY7x0qc78k7Awv/bgxsPuQNlDFun7gsjrVmjZjSvFPQU
         Haww==
X-Gm-Message-State: AO0yUKWO/G3m6U7QpABwL+gHF/y/dlPRbKf0UiIVOXPmxCy/etsrunpT
        K0xk5SEAr1vzJAtUH5pX/tOObw+SpXCd6r0/DyDFXrEkZi69PP9nov41dkVT+lRSUQ9zMZ0uF3N
        h66ps3HO0dTHId7CHkxZqQHRIckTnAQH1TOFSxJEVe2C+Nernh9dkwZg4kBreTizyH0qfJnmSqI
        QNeBCxaBY=
X-Received: by 2002:adf:dc90:0:b0:2c5:4c1f:3c9 with SMTP id r16-20020adfdc90000000b002c54c1f03c9mr9559851wrj.49.1678225843090;
        Tue, 07 Mar 2023 13:50:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+uVPmsd4FkYozdPgfD3LO/a/Iz7EnaE1PW2RaXdbG/aTax4E/3JZNF5gCuRxnqwggEuHOsiw==
X-Received: by 2002:adf:dc90:0:b0:2c5:4c1f:3c9 with SMTP id r16-20020adfdc90000000b002c54c1f03c9mr9559834wrj.49.1678225842666;
        Tue, 07 Mar 2023 13:50:42 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d6042000000b002c70d269b4esm13305988wrt.91.2023.03.07.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:50:42 -0800 (PST)
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
Subject: [PATCH v2] drm/format-helper: Make conversion_buf_size() support sub-byte pixel fmts
Date:   Tue,  7 Mar 2023 22:50:39 +0100
Message-Id: <20230307215039.346863-1-javierm@redhat.com>
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

Instead, calculate it by using the bits per pixel (bpp) and divide it by 8
to account for formats that have sub-byte pixels.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
Tested by making sure that the following command still succeeds:

./tools/testing/kunit/kunit.py run \
--kunitconfig=drivers/gpu/drm/tests/.kunitconfig

Changes in v2:
- Drop an unused variable, that was pointed out by the kernel robot.

 drivers/gpu/drm/tests/drm_format_helper_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 9536829c6e3a..84b5cc29c8fc 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -409,12 +409,15 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
 				  const struct drm_rect *clip)
 {
 	const struct drm_format_info *dst_fi = drm_format_info(dst_format);
+	unsigned int bpp;
 
 	if (!dst_fi)
 		return -EINVAL;
 
-	if (!dst_pitch)
-		dst_pitch = drm_rect_width(clip) * dst_fi->cpp[0];
+	if (!dst_pitch) {
+		bpp = drm_format_info_bpp(dst_fi, 0);
+		dst_pitch = DIV_ROUND_UP(drm_rect_width(clip) * bpp, 8);
+	}
 
 	return dst_pitch * drm_rect_height(clip);
 }
-- 
2.39.2

