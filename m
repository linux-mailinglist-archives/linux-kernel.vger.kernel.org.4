Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383EB6BDBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCPWfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCPWfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3735020577
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679006061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cQjcHnFhhGHZA5Yk3fgjjkY+JL6ce3oLWezSsu1quCk=;
        b=Yu+WT9/a91D6QMKiw7x4fK+sme7bPdu5cebtsPP4yDG60oPoTCkaoPRpRfAP6R+GIFB1DJ
        MkO5mayEems8djg1zUgKAfoh6wVPgLNb7C1xljtCx+115I19ytBGDevnx/GXHAxVuAu1gd
        R1TQuNAmp2tWSGeg0lOuUOBiKgdtCjk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-wgb68QYQO9e9-J025Ud5hg-1; Thu, 16 Mar 2023 18:34:20 -0400
X-MC-Unique: wgb68QYQO9e9-J025Ud5hg-1
Received: by mail-wr1-f69.google.com with SMTP id p1-20020a5d6381000000b002cea6b2d5a9so517972wru.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQjcHnFhhGHZA5Yk3fgjjkY+JL6ce3oLWezSsu1quCk=;
        b=XnkhYICZT2nMWQrOHknHC3pQEPv4n188jTTwz+geN/Jjj095EYnOUjb/X+YjYZpE0H
         /uuEFY/44447bWbRM4OXsz6dmp6ykp2M8iT9IHrCOCcR9iXdQKNCUwkZMwRQ53+sFcOf
         2wbCH6Mw4hPj4c5FXvKaBqwUoUY8RaicpxUXgbjryXQsDuPijYgtINWV6X8GaAlkpp3n
         bwYhJFGNpUkpxumxYNZqJwTeBHR3xFJVkaZpkVJDZglXdxv9m4BfnIqjx6ohFOaY+e8v
         qXyc7ulEEa6O5jqcnv3v4VNlEtZ1BmQFUNhWVWwbs/UaJ6u6SEst3Qfq2nuuAZufAHrg
         hFrw==
X-Gm-Message-State: AO0yUKXyMeIwirKZQu8iN086JXbKuT6SZ1BWE/lx54QUXiL3xwQFZCyR
        r8WGK4tJk1GMSUb2vSHNMMMdYV2gMHuk7+pT+NO9y7sdHBegihya+skSfieUWEfR6Aw8IMe+hZ1
        Mr0yk+oVI0RSqUsvydrAhwFUkKt5+OQWWv7pMWGDWM4wyRbzt6KjYA5rzqMWMErCsBuNEKXxNdJ
        drzw2YeXc=
X-Received: by 2002:a5d:4d10:0:b0:2d1:7ade:aad with SMTP id z16-20020a5d4d10000000b002d17ade0aadmr4193285wrt.31.1679006058737;
        Thu, 16 Mar 2023 15:34:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set9v6p8hdWcWbe8F7o80naCh5TQbXl2/qaDD1HpV78Lc0LMQy8kTM9oet4mKKOKDXFt7Ra0tdw==
X-Received: by 2002:a5d:4d10:0:b0:2d1:7ade:aad with SMTP id z16-20020a5d4d10000000b002d17ade0aadmr4193267wrt.31.1679006058328;
        Thu, 16 Mar 2023 15:34:18 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600001cb00b002c54241b4fesm452499wrx.80.2023.03.16.15.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:34:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Gow <davidgow@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/format-helper: Use drm_format_info_min_pitch() in tests helper
Date:   Thu, 16 Mar 2023 23:34:04 +0100
Message-Id: <20230316223404.102806-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.2
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

There's a nice macro to calculate the destination pitch that already takes
into account sub-byte pixel formats. Use that instead of open coding it.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/tests/drm_format_helper_test.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index bfa47f8ffd09..474bb7a1c4ee 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -440,15 +440,12 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
 				  const struct drm_rect *clip)
 {
 	const struct drm_format_info *dst_fi = drm_format_info(dst_format);
-	unsigned int bpp;
 
 	if (!dst_fi)
 		return -EINVAL;
 
-	if (!dst_pitch) {
-		bpp = drm_format_info_bpp(dst_fi, 0);
-		dst_pitch = DIV_ROUND_UP(drm_rect_width(clip) * bpp, 8);
-	}
+	if (!dst_pitch)
+		dst_pitch = drm_format_info_min_pitch(dst_fi, 0, drm_rect_width(clip));
 
 	return dst_pitch * drm_rect_height(clip);
 }

base-commit: 165d5133731a2e045abdd6d9d3c9221fdc2a556e
-- 
2.39.2

