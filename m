Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2944260E51B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiJZQAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiJZQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5851147B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666799994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zds5b/EQDqkx7Pyf1ZJFBZj3XHxRFNCLAcjtw1LYg8w=;
        b=BAtebcG8RQcZMHwNp/HF9717vUaX+IdbxEKCLaUO/CSbjm0MhSNOW4sb+gewH1qzxx0UFi
        7wWzG9mPOWCi4K/+RgzY1VSG0QeyoWNvRsoATjZ413VSK+eq8SVVUl2ShL0sv+se+7GaEw
        5Y1VwG0vrWWQ7WOi8OyqJ36+2l7Ijh0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-GLbyE5sMPpKGcr9nkHilYg-1; Wed, 26 Oct 2022 11:59:52 -0400
X-MC-Unique: GLbyE5sMPpKGcr9nkHilYg-1
Received: by mail-ej1-f69.google.com with SMTP id qw17-20020a1709066a1100b0078e25b6a52fso4789978ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zds5b/EQDqkx7Pyf1ZJFBZj3XHxRFNCLAcjtw1LYg8w=;
        b=hteLIvOa7tkFyDCMRB+sNhoIvzZzIbbJiKIq31lPccGtrmVCGtoXuI81Nu40WHWjoV
         teewp2eoVoMucLL2WY8WsV/ZM6nfSQDabwh552P60Bo0qkjJjlftgr0hOBTzenCPHVYC
         B14wq2dnKCx5BVsNbA5ggbpkNSwT5GvRKjifJUk+naeKRpDiZsPNcw4sSbzzvzUJb+wp
         mKKwdDGfn4GSsMRYswtdQLLccIfiVNrwaGNcxBvNrC0+v/QzvEHTorpOJtEa/XZW9Iuo
         c3oY8KCEe8X1768krnym1a16xZUWuz4gtiynzgKGgORwo6A7uafaemydIvxJdP1T0aYx
         YOaw==
X-Gm-Message-State: ACrzQf3t8AGVR5OpMRW4Bph05D5Z3q16RGilOMg25X+dHJOmO1AO+U2j
        l7Qz6eeQNKtulbheMbHhdYOtqi62J2OosHN5U0gHgN/myc0ilnMlceKW+E7NqsSPtP+T6HGgfem
        QNRduzNoq/IgWJ4gPFCeF9ACw
X-Received: by 2002:a17:907:7f25:b0:7aa:acf9:c07e with SMTP id qf37-20020a1709077f2500b007aaacf9c07emr11861163ejc.280.1666799991737;
        Wed, 26 Oct 2022 08:59:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7WRefB+4uZiJzq4JmOLaBwL3ie2XJ4MVLpXX9v2tYlWPKvm20oby9JWTOy7syw9NVzzMm8tQ==
X-Received: by 2002:a17:907:7f25:b0:7aa:acf9:c07e with SMTP id qf37-20020a1709077f2500b007aaacf9c07emr11861142ejc.280.1666799991498;
        Wed, 26 Oct 2022 08:59:51 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7d488000000b00461a6997c5dsm3708285edr.83.2022.10.26.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:59:50 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 3/5] drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
Date:   Wed, 26 Oct 2022 17:59:32 +0200
Message-Id: <20221026155934.125294-4-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026155934.125294-1-dakr@redhat.com>
References: <20221026155934.125294-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

