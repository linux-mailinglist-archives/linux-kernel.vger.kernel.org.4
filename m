Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CF65F1DCB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJAQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJAQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E21386AC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnX59dffWK1EQ9RPt7g3flEI99/gWclWQ2eDM1z8XdM=;
        b=FeaxxWMNZi02H+FbvzW4IDMAhzty+9I5Uc3Np8VcldVBJaOI2/OLhB12jlrYDqfebqWDTT
        hO2qvS4bTe747G0PB2H5GpeksTFSl3FrgpR7QFNxqQNghiyq64bRbmaQHxX1qQn1j/5YGO
        nOyj/qoxMMpK1V0B6HENID8iN/mmRM8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-l_jQoT7INqaRZC73vpKpKw-1; Sat, 01 Oct 2022 12:40:20 -0400
X-MC-Unique: l_jQoT7INqaRZC73vpKpKw-1
Received: by mail-ed1-f71.google.com with SMTP id e15-20020a056402190f00b0044f41e776a0so5731100edz.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dnX59dffWK1EQ9RPt7g3flEI99/gWclWQ2eDM1z8XdM=;
        b=hqqeWr6eEmZIoECQHWJtgzE+rQzzG6mq6YxO561Yla2CAOcwoA3zydEntjTibcRLYl
         cbpWtMMFHYJy0FDXvEZ+fdilFiwKefXlYAGIIWpFOa+KN0RmAkvx3ekHbaYIsULOLe0o
         EYJsndihIJTeq4Nr52EhQOilIkasnz+AODZJlT63StgMDoAvAKSDGkd3Xq8yMgEXA4si
         zXY21DjB7zfdgiJPvA4DtHM2aBQPnwxm+qprXWm3YbJSAXxK5nnmjiCK5maD4IG1TpDy
         rimiuQRslSVNrQOTqUyRj7EauetU72HjktijhIJm+DPn4lLMu3ABvy4q59/vL0T/grxc
         Ek0A==
X-Gm-Message-State: ACrzQf1SLXUAV0iRLf2F9bxPF1zFdLEyjN0EH0r/wLzp5bODNlxN1OLg
        ns/b1pomdcmuA7DZOQjvQcV/w2/4A3VtZk+qYPbTaiobVp+4Cqfm+ivnNFgqQKM8fuyrWEAofQR
        +MAPLMjNAIdHSFPf4D5Iktt96
X-Received: by 2002:a17:907:97cd:b0:787:ccc3:fde1 with SMTP id js13-20020a17090797cd00b00787ccc3fde1mr9121361ejc.334.1664642419227;
        Sat, 01 Oct 2022 09:40:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM55Xp3BW3rc7QOk4esgcgUFW3Z9EOPnOO6tbl7W/JvSQU5pKXlUjMPacZd1NQ3DBccPKxweZQ==
X-Received: by 2002:a17:907:97cd:b0:787:ccc3:fde1 with SMTP id js13-20020a17090797cd00b00787ccc3fde1mr9121349ejc.334.1664642419069;
        Sat, 01 Oct 2022 09:40:19 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id c20-20020a1709060fd400b0078167cb4536sm2886785ejk.118.2022.10.01.09.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:40:18 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 8/9] drm/arm/malidp: drv: protect device resources after removal
Date:   Sat,  1 Oct 2022 18:39:45 +0200
Message-Id: <20221001163946.534067-9-dakr@redhat.com>
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

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index aedd30f5f451..8bb8e8d14461 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -234,9 +234,12 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 	struct malidp_drm *malidp = drm_to_malidp(drm);
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
-	int i;
+	int i, idx;
 	bool fence_cookie = dma_fence_begin_signalling();
 
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
 	pm_runtime_get_sync(drm->dev);
 
 	/*
@@ -267,6 +270,8 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 	pm_runtime_put(drm->dev);
 
 	drm_atomic_helper_cleanup_planes(drm, state);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_mode_config_helper_funcs malidp_mode_config_helpers = {
-- 
2.37.3

