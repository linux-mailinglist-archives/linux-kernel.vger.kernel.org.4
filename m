Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397185F1DB8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJAQkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJAQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29912528A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zds5b/EQDqkx7Pyf1ZJFBZj3XHxRFNCLAcjtw1LYg8w=;
        b=Rt+uZYpqVqwWIuc3IuZg2vQpCeBvkVy9aI+FJLTxUp5ZV8TMlL2lCnr8JTWICY+/O9UTPL
        8amysgf3Jjmq7TGdt3gFv3Rb/Yfr2Q1iAR/Osbn4YGpW8HIblTkDAwz/goZieQb0XW6tCw
        xw/ReDfO9kH74trooj3OxfG/kWKLKuA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-lanEiFRNPWKNwNNPHGTS9Q-1; Sat, 01 Oct 2022 12:40:02 -0400
X-MC-Unique: lanEiFRNPWKNwNNPHGTS9Q-1
Received: by mail-ed1-f72.google.com with SMTP id w17-20020a056402269100b0045249bc17a9so5712506edd.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zds5b/EQDqkx7Pyf1ZJFBZj3XHxRFNCLAcjtw1LYg8w=;
        b=Cx5emnTDEDYt/Bro79c5lIVNpQvGWUFxv+3La3/CIgd+WqntFomXoq3vRVPnVmu1Bp
         9+58sn4+EKUb821JSa1s4TAA/94+fzPDD1WXoA8LkZuPtyT5IK8P7OSf0/KVirDyyJhP
         caw3LRhDpzy3tdcZZ7IXBziNUfFT4FmbjsS+Wj36PntM3U3I/ptuBqJEaXuLUCNK4hwB
         b6T5o0Po8PmSxiZDOVBhEqL4CyDqOpFuhJWLV1jO0TjFS4iDjpMhG+yoMn1F6m2jUgBM
         Bss0SkoBFQSZv6cfLkY+oZAc4mGme+Qoh0p7gkTT2bW0UTiE6W2WoKPG80BXQTxFq4SK
         BtiQ==
X-Gm-Message-State: ACrzQf1O0Jn9WxDlYe8hHWQYOPr8nOOHrIHyRE3xqNgK5CjZAN8IUmCR
        mV24tReeAHqxyvSzozhDBdLwZ947BoYexdyEL7GYBiOdh3n8GLzCapdSFyDRBv+0IC9Yq0olFCn
        vt99w2g9ap++f/Vk2tY55cIFQ
X-Received: by 2002:a05:6402:90c:b0:457:b5ce:5f18 with SMTP id g12-20020a056402090c00b00457b5ce5f18mr12517589edz.309.1664642400681;
        Sat, 01 Oct 2022 09:40:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6oFsJ5/vkjCjrOH42LhRQl7FKzQpDN5xpPB29HBBbAof6bb+X69T6LRMlsEyBBdMK9vS++Ng==
X-Received: by 2002:a05:6402:90c:b0:457:b5ce:5f18 with SMTP id g12-20020a056402090c00b00457b5ce5f18mr12517575edz.309.1664642400495;
        Sat, 01 Oct 2022 09:40:00 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id bi6-20020a170906a24600b00782cd82db09sm2923342ejb.106.2022.10.01.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:40:00 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 3/9] drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
Date:   Sat,  1 Oct 2022 18:39:40 +0200
Message-Id: <20221001163946.534067-4-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001163946.534067-1-dakr@redhat.com>
References: <20221001163946.534067-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drmm_crtc_init_with_planes() instead of drm_crtc_init_with_planes()
to get rid of the explicit destroy hook in struct drm_plane_funcs.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index 34ad7e1cd2b8..dc01c43f6193 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -514,7 +514,6 @@ static void malidp_crtc_disable_vblank(struct drm_crtc *crtc)
 }
 
 static const struct drm_crtc_funcs malidp_crtc_funcs = {
-	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = malidp_crtc_reset,
@@ -548,8 +547,8 @@ int malidp_crtc_init(struct drm_device *drm)
 		return -EINVAL;
 	}
 
-	ret = drm_crtc_init_with_planes(drm, &malidp->crtc, primary, NULL,
-					&malidp_crtc_funcs, NULL);
+	ret = drmm_crtc_init_with_planes(drm, &malidp->crtc, primary, NULL,
+					 &malidp_crtc_funcs, NULL);
 	if (ret)
 		return ret;
 
-- 
2.37.3

