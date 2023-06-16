Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69644732EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345431AbjFPKiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345428AbjFPKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:34:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370BC46AF;
        Fri, 16 Jun 2023 03:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB3763710;
        Fri, 16 Jun 2023 10:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC0FC433CD;
        Fri, 16 Jun 2023 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911318;
        bh=fu9TykgKigfM0LbtTAtm/eDYH/TVPGk6gMDOb/KrQ5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGIehwvASiZAkbqLmmTAMEcg0j1AA3u+42zOEj8yYJiRZC34lZqrUNBQJZ2570/rB
         /EpGFN63kKeSygjQ5gRp/Yj4d4VlCuRrHcJc1Oi/fsglZQqbNqMY/kIezXRNMJKyjJ
         /Av33JbQP4S5RorsvLX0S8dlxeGmZiWuEcKXqJbT1X4o6XzTaC/z/16bD07MIfw0n/
         XmQGrXwERixXtBaNmDkQqQERhNPO5UuX9Xb6ZbWVn6vWbZzD5qcG+Zd5jRp+qYBrNa
         w8kT44TU2htbqnJCtF9B+jvEpHrSfAVYej7oO+mAfv59ASmKwxTcG5H1fl6wqsu4At
         zU85+TmgTvFcg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Min Li <lm0963hack@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 7/8] drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl
Date:   Fri, 16 Jun 2023 06:28:20 -0400
Message-Id: <20230616102821.674153-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102821.674153-1-sashal@kernel.org>
References: <20230616102821.674153-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.247
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
index b2b076606f54b..e164b3c7a234f 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -384,7 +384,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -397,13 +396,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
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

