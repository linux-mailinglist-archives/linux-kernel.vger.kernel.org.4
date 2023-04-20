Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B286E9717
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjDTOaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDTOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06830FD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682000971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6BdrM5PAXOTQN54lsRvoJTmZEachvXpdp/asoBdEKLk=;
        b=ATAdzKu/ZbAH7kJx9DuqLNRRx6gvQVegndN7564obIdLfl3i9Mq/f9RLCqTBNK+phC1J21
        T5/mGysDtRKxxNutjjiS7v0mu5WAQhFkSpip9LP+Xr6xM0FeHnKOojH+s1KUu2JW0aoeTK
        IzvEHnJlGF+X9r23VjyY98MkWWn35ew=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-DX99mwMRN-yn_fXWdHWrSA-1; Thu, 20 Apr 2023 10:29:30 -0400
X-MC-Unique: DX99mwMRN-yn_fXWdHWrSA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5ef4bfeacc4so10681826d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000969; x=1684592969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BdrM5PAXOTQN54lsRvoJTmZEachvXpdp/asoBdEKLk=;
        b=L8YuMskGoFCeZjAb9dEKEgSNiZ4UHWiaPedgmH4j3oERD2rbN0GM6UTZn8u3HXxdMN
         D+rOvkxbdesX59rlK9tr7OcBqt/lECH316toIEg/JJoqXK0coJDn3goPxGeYAS9CBgHb
         H/nfPqZ1fTSWvuUq6UXvbQ3TpMJvDnINU3CJ/6ndCeNF8G5KQPN9Zd8mFCJsezmO8C6X
         sIy6k/FO5RtoOo4rrAgp5erM8rp8GgLKYA0vq6xV1IfRA/LbyU/qThzjc4xhTDRKRciv
         G+xjoSjX/KPhi401WfcPXqShuFvAKQSxJgYtXM0o7Y2p3vp9w6YnHArLoY5I1ZZM8lrS
         E4pA==
X-Gm-Message-State: AAQBX9ePTxPjihKbpoPit0C1JqqmuwNJm6xcHiUTeqVZLp9lgPt+EFd5
        M6XuSrc39Z0GUXz/mF6GGAL4LExC1p8auj41j2iPWk5gacH0HGuT2A18tUuRD0MuvOiqzoB8SAf
        rgi9CK61jaAI9TekoMAm9aJvU
X-Received: by 2002:a05:6214:301e:b0:56e:b557:2d4e with SMTP id ke30-20020a056214301e00b0056eb5572d4emr2242305qvb.6.1682000968825;
        Thu, 20 Apr 2023 07:29:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350bh4jP9BRcxAXAQBGpztEZgR2c1DlH5MA0cabHVDBgEfStN28QcPkDWcM8pWXDcVwsX39FA5w==
X-Received: by 2002:a05:6214:301e:b0:56e:b557:2d4e with SMTP id ke30-20020a056214301e00b0056eb5572d4emr2242276qvb.6.1682000968521;
        Thu, 20 Apr 2023 07:29:28 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b27-20020a0cb3db000000b005e750d07153sm420904qvf.135.2023.04.20.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:29:28 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, le.ma@amd.com, Jack.Xiao@amd.com,
        YiPeng.Chai@amd.com, Lang.Yu@amd.com, Likun.Gao@amd.com,
        Arunpravin.PaneerSelvam@amd.com, andrealmeid@igalia.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: remove unused variable j
Date:   Thu, 20 Apr 2023 10:29:25 -0400
Message-Id: <20230420142925.3890505-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
  ‘amdgpu_gfx_mqd_sw_fini’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:451:16: error: variable
  ‘j’ set but not used [-Werror=unused-but-set-variable]
  451 |         int i, j;
      |                ^
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
  ‘amdgpu_gfx_disable_kcq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:486:13: error: variable
  ‘j’ set but not used [-Werror=unused-but-set-variable]
  486 |         int j;
      |             ^
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
  ‘amdgpu_gfx_enable_kcq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:529:19: error: variable
  ‘j’ set but not used [-Werror=unused-but-set-variable]
  529 |         int r, i, j;
      |                   ^

These variables are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f5c60381103..ac6fd8620279 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -448,7 +448,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_ring *ring = NULL;
-	int i, j;
+	int i;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 
 	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
@@ -462,7 +462,6 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
 		ring = &adev->gfx.compute_ring[i];
 		kfree(adev->gfx.mec.mqd_backup[i]);
 		amdgpu_bo_free_kernel(&ring->mqd_obj,
@@ -483,7 +482,6 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i, r = 0;
-	int j;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -495,11 +493,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
+	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
-	}
 
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
@@ -526,7 +522,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	uint64_t queue_mask = 0;
-	int r, i, j;
+	int r, i;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues || !kiq->pmf->kiq_set_resources)
 		return -EINVAL;
@@ -562,10 +558,8 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		queue_mask = ~0ULL;
 
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
+	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
-	}
 
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
-- 
2.27.0

