Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043255B91C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiIOAd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiIOAdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2388B2C0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663201971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xaw3iUtMLKwH2xCvo5P17z6DGidg5D+TvENUAVXK2ek=;
        b=OZ9NZ5puW7iyMjMsSmMoAYVQ6p+iKKdd1abqES+HrjMkNF17UxMUF8oVtCbfx/gtPma7lJ
        rTP3I/mfK0zJQMr045Hce55qFWAlLYcVjsDGKicaPEJb0qcQX7yOV+OUgD5Nu1fVfys1kZ
        4jPC685c5/yoGQbaDPeW0LDtS6f1h6Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-NawfuPHhMgCn1JdXbWnmiA-1; Wed, 14 Sep 2022 20:32:50 -0400
X-MC-Unique: NawfuPHhMgCn1JdXbWnmiA-1
Received: by mail-ed1-f71.google.com with SMTP id q32-20020a05640224a000b004462f105fa9so11716674eda.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Xaw3iUtMLKwH2xCvo5P17z6DGidg5D+TvENUAVXK2ek=;
        b=uUtKHenhd2PG82tdSsd4CUTkK+Vj2OwVXnpkbRKQthJWe2wLZ+ErS3yJpKcSqpUPnD
         8O6vR9na+IcH3pPwPpu8SAIFtvCpADPWmsY4LcixXTya8MwEvkVv4Wvaca6wUGQHpIbx
         hz8I04pkOzeAgUxBXkIr2okti43buWqQHCb+/6QGs/+Vs/oR2ZXbGNVt2ArV+9u5qaz1
         nFVGsOExaY0or/iLA1+KXHDxk5bjdnccdUS2+QvQr+WKRfON8RNRQTg3EqhSS6ZkXcMv
         W8J1Hr1VE6eTTS1JQdmEebSJEIIHovf70vfNo2+INlNrbzFXna9MNNDiWPRYYh+9f1nX
         44WA==
X-Gm-Message-State: ACgBeo0761na+v+CbaTikOQlmpRc4Xdt8C8OEaxHsZ3ugg42fPqORNby
        vgDjw78Pty5njR6B9mKmWIrbKiczJ067LKf4pkbI1rFxj6dLRdWfu3Wikg7mVMUzyKLJM/txzFq
        kl+UXfLkKnD8+qV4FLUCog2yT
X-Received: by 2002:a17:907:6293:b0:769:9dfc:10eb with SMTP id nd19-20020a170907629300b007699dfc10ebmr28017386ejc.191.1663201969518;
        Wed, 14 Sep 2022 17:32:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR76AUHZP7TSM1OI8rVca0sDWA90ENPNmx7n18UfSpYDwhdtincdX9d/3H678m4vxuSNRmwafw==
X-Received: by 2002:a17:907:6293:b0:769:9dfc:10eb with SMTP id nd19-20020a170907629300b007699dfc10ebmr28017377ejc.191.1663201969380;
        Wed, 14 Sep 2022 17:32:49 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402014100b0044e8d0682b2sm10672079edu.71.2022.09.14.17.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:32:48 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 3/8] drm/fsl-dcu: crtc: use drmm_crtc_init_with_planes()
Date:   Thu, 15 Sep 2022 02:32:26 +0200
Message-Id: <20220915003231.363447-4-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915003231.363447-1-dakr@redhat.com>
References: <20220915003231.363447-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index e05311e2b0e0..0b70624260fc 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -159,7 +159,6 @@ static void fsl_dcu_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 static const struct drm_crtc_funcs fsl_dcu_drm_crtc_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
-	.destroy = drm_crtc_cleanup,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
 	.set_config = drm_atomic_helper_set_config,
@@ -180,8 +179,8 @@ int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev)
 	if (!primary)
 		return -ENOMEM;
 
-	ret = drm_crtc_init_with_planes(drm, crtc, primary, NULL,
-					&fsl_dcu_drm_crtc_funcs, NULL);
+	ret = drmm_crtc_init_with_planes(drm, crtc, primary, NULL,
+					 &fsl_dcu_drm_crtc_funcs, NULL);
 	if (ret) {
 		primary->funcs->destroy(primary);
 		return ret;
-- 
2.37.3

