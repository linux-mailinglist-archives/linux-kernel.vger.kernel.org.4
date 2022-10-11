Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9505FB891
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJKQwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiJKQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480EE95AC8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665507115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sz4P4Z4QEIQJ7tRSOPnfB5n0/AjqOBcHz0ZToIWPFi4=;
        b=fYamY7CD26XcPbLLAD8iYtQSKev9Pzv9FY9DICy1DvaFIH+rN3YH4m96RGJP6v5ZiCMbRE
        iyXf8lFFdSAozyb7PLtM8YydXStusRW4/TvQwzgHEWyG5YHmbxxIjmZp454uc51CYBG2x7
        Z9vAT0rzTsksDPeElPWEjTWo7CNZkSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-212-k_5dMgxlOQCs_Om-mMV_jQ-1; Tue, 11 Oct 2022 12:51:54 -0400
X-MC-Unique: k_5dMgxlOQCs_Om-mMV_jQ-1
Received: by mail-wr1-f69.google.com with SMTP id g4-20020adfbc84000000b0022fc417f87cso2223865wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz4P4Z4QEIQJ7tRSOPnfB5n0/AjqOBcHz0ZToIWPFi4=;
        b=DrstSMdmHF9zxm6VWBzM8Jlic5eps54yYEKxO24PI9F9np/+ZL5Ur7tQ7JRmzTNyOO
         xHhjnJrjM05pODq/Ec17L76zCaxlUhtUIlKX1AlCj+UUFCBC22teAgD0QuxTiLVsMv8A
         9HxDMPS8WENNSC2SCJuaUDPkk8EXeinT0yMVxdGBq1nrFZXzKjb6UNX7N9tU2lTLzxDX
         VUjqT2SVcf5+MeYyHZtGiq9A6zrEXDRONIy+7eVGJZ8pKbMR1UAM3qzalrfknwuIIXh4
         abdFHVpxmoFgoI0u3h6ncPb52TNoa6Y/c2lslrLaClTcPuLJbqKKS4fyjK/CQSMKrVyX
         Qt0Q==
X-Gm-Message-State: ACrzQf3MZ4E5CcrEbLRACw77yP7uHwMqT7swPSb/sFWA1QfyWEStmA3A
        nPmYd5lGblWLyx+WMDsPfRaE33mOLCNZVAmXZ7bBym1hMSHuiOf5LFu9+/yPMBxMObYzolPp25Y
        y5PAqJgut2rVf1nUfueDAM4OEYN8puz6J+vkmhlf2mEkQOX/kH7f2VDQfbc/Ak84UF3juq5SeYb
        I=
X-Received: by 2002:a05:600c:5119:b0:3c6:cae1:1512 with SMTP id o25-20020a05600c511900b003c6cae11512mr30898wms.80.1665507112309;
        Tue, 11 Oct 2022 09:51:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5U+XbYS3G1P9BD3p7rBLERKgQ1Sen4O+UBvYTZW1wRJWgLPMDaK7PiKSRaj+mRj9bHXSiUJw==
X-Received: by 2002:a05:600c:5119:b0:3c6:cae1:1512 with SMTP id o25-20020a05600c511900b003c6cae11512mr30866wms.80.1665507111840;
        Tue, 11 Oct 2022 09:51:51 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003c6c76b43a1sm2025629wmq.13.2022.10.11.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:51:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/4] drm/simpledrm: Do not call drm_atomic_add_affected_planes()
Date:   Tue, 11 Oct 2022 18:51:34 +0200
Message-Id: <20221011165136.469750-3-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011165136.469750-1-javierm@redhat.com>
References: <20221011165136.469750-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to add planes to the atomic state. Remove the call
to drm_atomic_add_affected_planes() from simpledrm.

On full modesets, the DRM helpers already add a CRTC's planes to the
atomic state; see drm_atomic_helper_check_modeset(). There's no reason
to call drm_atomic_add_affected_planes() unconditionally in the CRTC's
atomic_check() in simpledrm. It's also too late, as the atomic_check()
of the added planes will not be called before the commit.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/gpu/drm/tiny/simpledrm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index ecd49a8f3334..f03f17f62a56 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -549,17 +549,11 @@ static int simpledrm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 					      struct drm_atomic_state *new_state)
 {
 	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(new_state, crtc);
-	int ret;
 
 	if (!new_crtc_state->enable)
-		goto out;
-
-	ret = drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
-	if (ret)
-		return ret;
+		return 0;
 
-out:
-	return drm_atomic_add_affected_planes(new_state, crtc);
+	return drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
 }
 
 /*
-- 
2.37.3

