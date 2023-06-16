Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2009732EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbjFPKid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345734AbjFPKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B213A658E;
        Fri, 16 Jun 2023 03:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D67563783;
        Fri, 16 Jun 2023 10:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0DFC433C0;
        Fri, 16 Jun 2023 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911339;
        bh=jFp0Hq2POJGsZrpeXaqiQ8IhrQ8rVyOi86cT82XbsEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6c/ulQlX4yt3zwCrsz5nPxY0lgM9da0xqm8Ow/ejULZ4FwERufrKHESFXWcgTmyr
         7m0hiSWT+7GpnlA6tb2GYVS5o6A+7qFxXjc8zh1Fc6xQiyWKPWsQL2ALK36UR6A7d8
         jpGRbbLPpWa4XvxS2uCNfAauYrG3POhYQ6DPfGHAWwzvCyBWkxzuj/Fj1KHuV2BCnf
         6FRL0kS3Ky/zZR9xEv2pc69IVBm3QzpjkgOztyU+9EOJXcjQ5cq3pbfL4yjIeSVRuC
         sfRCeBc+bACQo2Bxx1Jwno8vTt3T+XeEA6RNUYGXgXGb9EJk1kMWMU4OPHexuBRENn
         Dju/cWGgNhzRg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Min Li <lm0963hack@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 4/5] drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl
Date:   Fri, 16 Jun 2023 06:28:50 -0400
Message-Id: <20230616102852.674366-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102852.674366-1-sashal@kernel.org>
References: <20230616102852.674366-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.318
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <lm0963hack@gmail.com>

[ Upstream commit 982b173a6c6d9472730c3116051977e05d17c8c5 ]

Userspace can race to free the gobj(robj converted from), robj should not
be accessed again after drm_gem_object_put, otherwith it will result in
use-after-free.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Min Li <lm0963hack@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index ac467b80edc7c..59ad0a4e2fd53 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -376,7 +376,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -389,13 +388,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 		up_read(&rdev->exclusive_lock);
 		return -ENOENT;
 	}
-	robj = gem_to_radeon_bo(gobj);
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
 	drm_gem_object_put_unlocked(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
-- 
2.39.2

