Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C80672200B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjFEHtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjFEHtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010DACD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685951298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkfyBiLVG0HjTgYBw5BL2+2f7LnDXq371QsA6cUQbfY=;
        b=VFWmmIRyvud0K2VzEDd1rtp4oZs8VqkStcG2W2rl32qG5WB3nTkW9rQecJOAMPia48kZNF
        QSa4zkCPBgVMgEP9VIcf6HLyUBHJFcBgVwthqFnytQTRE1QJi45uCk8UhAvDE2Dk5GFwht
        0YU+rd52/h7gTzyk20SOdJl34fvC/+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-e7pjfwCfPtCrv1874NWQPg-1; Mon, 05 Jun 2023 03:48:16 -0400
X-MC-Unique: e7pjfwCfPtCrv1874NWQPg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f6045853c1so21875255e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685951294; x=1688543294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkfyBiLVG0HjTgYBw5BL2+2f7LnDXq371QsA6cUQbfY=;
        b=Ftc8SRAq1/3MjuI291HZJ6Qgv6WC/zgipVAxUQ//WoWfbLc0E4Mx2OWU0TQG+cKxCp
         /bbYUsJV7rvkCKqgsMjndCGAIgd5nevvdlgiVMwB8LM+jSW8JTpu36qynGxsAHVPZEyD
         vuVzL9SHxtbLj+7m0GEH+GabcgQ0vdpgoy99d+RkYLq7UUfh9BTLLENnn+kRhCqDwbJi
         U6htLpcGdtl7vWgco0QsjzJqrbikLg6e0VO/IKFTwdPrPvzxI8GBoQJytNnsiv2hJMoV
         MahE562yb4gsTpz+xQg6pldPHm8wlLj7tys+EHWbJMWIx87upCeiBkRchwsL2cX1HMc7
         z5qA==
X-Gm-Message-State: AC+VfDxr8DPccV1c6JiBrxAyD/DU24GzFcOs0lmY0C+q/U2/LucdNJx2
        PW2+k8Ar70nPPWiQ2S0xntL5nOrOGGO5xgM6VxBLzKRJWUqzldCKW13cvMUxntXSxtvhuhfB763
        NlNQoZ3pxbo/XSzMXfOWt/8Becb3HAUbphenQjMN3UY1v+SqTaQvolmPGyfBf87aRp2x75xvTnS
        Vr/1ptTYQ=
X-Received: by 2002:a1c:7705:0:b0:3f4:2897:4eb7 with SMTP id t5-20020a1c7705000000b003f428974eb7mr6150070wmi.38.1685951294688;
        Mon, 05 Jun 2023 00:48:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lQbDXqEhzDQtCOm3eBqsPv8QaZ/hSWBzIQiuedzRf86vjl1o6k2bXEStnJY2w/EfQS4x/HQ==
X-Received: by 2002:a1c:7705:0:b0:3f4:2897:4eb7 with SMTP id t5-20020a1c7705000000b003f428974eb7mr6150051wmi.38.1685951294488;
        Mon, 05 Jun 2023 00:48:14 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b003f4fb5532a1sm9715192wmc.43.2023.06.05.00.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:48:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 5/5] drm/ssd130x: Remove hardcoded bits-per-pixel in ssd130x_buf_alloc()
Date:   Mon,  5 Jun 2023 09:47:53 +0200
Message-Id: <20230605074753.562332-6-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605074753.562332-1-javierm@redhat.com>
References: <20230605074753.562332-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only supports OLED controllers that have a native DRM_FORMAT_C1
pixel format and that is why it has harcoded a division of the width by 8.

But the driver might be extended to support devices that have a different
pixel format. So it's better to use the struct drm_format_info helpers to
compute the size of the buffer, used to store the pixels in native format.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0be3b476dc60..b3dc1ca9dc10 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -150,9 +150,16 @@ static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
 {
 	unsigned int page_height = ssd130x->device_info->page_height;
 	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	const struct drm_format_info *fi;
+	unsigned int pitch;
 
-	ssd130x->buffer = kcalloc(DIV_ROUND_UP(ssd130x->width, 8),
-				  ssd130x->height, GFP_KERNEL);
+	fi = drm_format_info(DRM_FORMAT_C1);
+	if (!fi)
+		return -EINVAL;
+
+	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
+
+	ssd130x->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
 	if (!ssd130x->buffer)
 		return -ENOMEM;
 
-- 
2.40.1

