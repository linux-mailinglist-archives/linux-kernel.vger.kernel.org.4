Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4D76BE36B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCQIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCQIXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250315CA4;
        Fri, 17 Mar 2023 01:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A5A7B824F4;
        Fri, 17 Mar 2023 08:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E07C4339C;
        Fri, 17 Mar 2023 08:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041380;
        bh=nglgtsvCUff3hoxAz81mxZbGLyBNAyLesQortl5pRh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8QPGrUr1rKK/pkPnxyrGQHlhqrAhQAz9B8YoyGAyPlwfZjOEa/wZTrJiOl3B1f1V
         dRxVSsRurlfTpiX7NHysvBEo50rrhwV7ryieiJGGqt3l0mxDh3dkKl91U+uhHHlmDL
         0tz+cX1m9mSmXzZmkZQkmFPlZkFgsko4Mi+8B8w1UKwQWvuLXGAbXEeX6FQLNqL48l
         0FokY7w66TNZ/OEGX8XGJbVq9+UaUP9LnL/f1pCIthEt1N3HMwuu4l5CKiqHj3OZnk
         4GXEw1Z+hA0hi4+teyF1NiENjb6p+qso5uJhJG3VUvfklp9SUzJNG0Tt0fjPFtUDc8
         wi2RowAwAVwrw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 17/37] drm/amd/amdgpu/amdgpu_mes: Ensure amdgpu_bo_create_kernel()'s return value is checked
Date:   Fri, 17 Mar 2023 08:16:58 +0000
Message-Id: <20230317081718.2650744-18-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function ‘amdgpu_mes_ctx_alloc_meta_data’:
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1099:13: warning: variable ‘r’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Jack Xiao <Jack.Xiao@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 82e27bd4f0383..30cd72ca1eefd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1104,6 +1104,11 @@ int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
 			    &ctx_data->meta_data_obj,
 			    &ctx_data->meta_data_mc_addr,
 			    &ctx_data->meta_data_ptr);
+	if (r) {
+		dev_warn(adev->dev, "(%d) create CTX bo failed\n", r);
+		return r;
+	}
+
 	if (!ctx_data->meta_data_obj)
 		return -ENOMEM;
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

