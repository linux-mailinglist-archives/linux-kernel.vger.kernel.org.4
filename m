Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3118270212F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbjEOBel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjEOBei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:34:38 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 772D7E73;
        Sun, 14 May 2023 18:34:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 5E51618011A402;
        Mon, 15 May 2023 09:34:32 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary (void*) conversions
Date:   Mon, 15 May 2023 09:34:28 +0800
Message-Id: <20230515013428.38798-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct amdgpu_device *).

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f60753f97ac5..c837e0bf2cfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1470,7 +1470,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 
 static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct amdgpu_device *adev = m->private;
 	struct drm_device *dev = adev_to_drm(adev);
 	int r = 0, i;
 
@@ -1581,7 +1581,7 @@ static int amdgpu_debugfs_benchmark(void *data, u64 val)
 
 static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct amdgpu_device *adev = m->private;
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_file *file;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index f52d0ba91a77..f0615a43b3cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -835,7 +835,7 @@ static const struct dma_fence_ops amdgpu_job_fence_ops = {
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct amdgpu_device *adev = m->private;
 	int i;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 863cb668e000..28f79cf8c3fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -948,7 +948,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct amdgpu_device *adev = m->private;
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_file *file;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4ff348e10e4d..49a4238a120e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -436,7 +436,7 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 
 static int amdgpu_debugfs_sa_info_show(struct seq_file *m, void *unused)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct amdgpu_device *adev = m->private;
 
 	seq_printf(m, "--------------------- DELAYED --------------------- \n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DELAYED],
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0efb38539d70..9f9274249b57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1441,7 +1441,7 @@ void amdgpu_disable_vblank_kms(struct drm_crtc *crtc)
 
 static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct amdgpu_device *adev = m->private;
 	struct drm_amdgpu_info_firmware fw_info;
 	struct drm_amdgpu_query_fw query_fw;
 	struct atom_context *ctx = adev->mode_info.atom_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2cd081cbf706..21f340ed4cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2164,7 +2164,7 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
 
 static int amdgpu_ttm_page_pool_show(struct seq_file *m, void *unused)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct amdgpu_device *adev = m->private;
 
 	return ttm_pool_debugfs(&adev->mman.bdev.pool, m);
 }
-- 
2.30.2

