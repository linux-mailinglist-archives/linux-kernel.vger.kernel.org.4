Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313C63F091
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiLAMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiLAMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:32:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C77FBA0A6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:32:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAE03CE1C78
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F6EC433B5;
        Thu,  1 Dec 2022 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669897931;
        bh=cyq5kIRv82DEDlrrKEjscpNYjNg7wkLn5qZtpqQLPDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwMCScF9Rw+XyaDy5ow4vQgD3EQfqQYLkKlojLHUk2T7qmDxfQR3etHzaUPbIP6mT
         /e/uFkoFEsT+9mxLYMApnoDEq01ctopUcmYzxXdSQkAqZ5lI8tPM2sPYjJ/kd8Jw9v
         SV7ra4o0yDVSuj+Zsl2Azo9mmPYmDWwYH/e2V5DvzFXCPwP7fBPaWQofIVxy8K5w5l
         4yWCyT/nLSdhZ/0lCyF98b1EzQ6nE/IAZpl8H0cSYWGLCNy5qvoJidzB28UOLCuHtF
         uiYVy7IHer5V7oNErrv2SXSWin+V2LQ8XHhyElyUV8C8pabSbGgrf7EpwNoHIT8zWY
         rF1hoglFLqt8g==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1p0ijZ-00FYFM-0H;
        Thu, 01 Dec 2022 12:32:09 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arunpravin <Arunpravin.PaneerSelvam@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Harish Chegondi <harish.chegondi@intel.com>,
        Jan Kara <jack@suse.cz>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <john.c.harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sujaritha Sundaresan <sujaritha.sundaresan@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/i915: export all mock selftest functions
Date:   Thu,  1 Dec 2022 12:32:06 +0000
Message-Id: <f5ded98084d4806a8932123eebe6b3383d830804.1669897668.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669897668.git.mchehab@kernel.org>
References: <cover.1669897668.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for a new KUnit module that will run
selftests, export all mock selftest functions to I915_SELFTEST
namespace.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1669897668.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/selftests/huge_pages.c      | 1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c | 1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c   | 1 +
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c         | 1 +
 drivers/gpu/drm/i915/gt/selftest_ring.c              | 1 +
 drivers/gpu/drm/i915/gt/selftest_timeline.c          | 1 +
 drivers/gpu/drm/i915/gt/st_shmem_utils.c             | 1 +
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c      | 1 +
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c        | 1 +
 drivers/gpu/drm/i915/selftests/i915_request.c        | 1 +
 drivers/gpu/drm/i915/selftests/i915_selftest.c       | 1 +
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c       | 1 +
 drivers/gpu/drm/i915/selftests/i915_syncmap.c        | 1 +
 drivers/gpu/drm/i915/selftests/i915_vma.c            | 1 +
 drivers/gpu/drm/i915/selftests/intel_memory_region.c | 1 +
 drivers/gpu/drm/i915/selftests/intel_uncore.c        | 1 +
 drivers/gpu/drm/i915/selftests/scatterlist.c         | 1 +
 18 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index beaf27e09e8a..954d37552681 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1944,6 +1944,7 @@ int i915_gem_huge_page_mock_selftests(void)
 	mock_destroy_device(dev_priv);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_huge_page_mock_selftests, I915_SELFTEST);
 
 int i915_gem_huge_page_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index e57f9390076c..2f6422eb9801 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -543,6 +543,7 @@ int i915_gem_dmabuf_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_dmabuf_mock_selftests, I915_SELFTEST);
 
 int i915_gem_dmabuf_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
index bdf5bb40ccf1..4c50be935462 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
@@ -88,6 +88,7 @@ int i915_gem_object_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_mock_selftests, I915_SELFTEST);
 
 int i915_gem_object_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
index d43d8dae0f69..03cd27066153 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
@@ -85,3 +85,4 @@ int i915_gem_phys_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_phys_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 881b64f3e7b9..e3e4918b3f9e 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -437,3 +437,4 @@ int intel_engine_cs_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_engine_cs_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_ring.c b/drivers/gpu/drm/i915/gt/selftest_ring.c
index 2a8c534dc125..6590c9c504b9 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring.c
@@ -108,3 +108,4 @@ int intel_ring_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_ring_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_timeline.c b/drivers/gpu/drm/i915/gt/selftest_timeline.c
index 522d0190509c..fcf044c9feea 100644
--- a/drivers/gpu/drm/i915/gt/selftest_timeline.c
+++ b/drivers/gpu/drm/i915/gt/selftest_timeline.c
@@ -450,6 +450,7 @@ int intel_timeline_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_timeline_mock_selftests, I915_SELFTEST);
 
 static int emit_ggtt_store_dw(struct i915_request *rq, u32 addr, u32 value)
 {
diff --git a/drivers/gpu/drm/i915/gt/st_shmem_utils.c b/drivers/gpu/drm/i915/gt/st_shmem_utils.c
index b279fe88b70e..46c9d4fca1f8 100644
--- a/drivers/gpu/drm/i915/gt/st_shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/st_shmem_utils.c
@@ -61,3 +61,4 @@ int shmem_utils_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(shmem_utils_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index 8c6517d29b8e..5461ecc9b6a2 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -555,6 +555,7 @@ int i915_gem_evict_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_evict_mock_selftests, I915_SELFTEST);
 
 int i915_gem_evict_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index eae7d947d7de..0a4c1a061a0c 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1935,6 +1935,7 @@ int i915_gem_gtt_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_gtt_mock_selftests, I915_SELFTEST);
 
 static int context_sync(struct intel_context *ce)
 {
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index 0daa8669181d..fda88361619e 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -563,6 +563,7 @@ int i915_request_mock_selftests(void)
 
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_request_mock_selftests, I915_SELFTEST);
 
 static int live_nop_request(void *arg)
 {
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index bc85dac4eb15..69941d5a6a31 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -39,6 +39,7 @@ int i915_mock_sanitycheck(void)
 	pr_info(DRIVER_NAME ": %s() - ok!\n", __func__);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(i915_mock_sanitycheck, I915_SELFTEST);
 
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
index daa985e5a19b..deccd30fed12 100644
--- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
@@ -755,3 +755,4 @@ int i915_sw_fence_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(i915_sw_fence_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_syncmap.c b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
index 47f4ae18a1ef..09b04f280e73 100644
--- a/drivers/gpu/drm/i915/selftests/i915_syncmap.c
+++ b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
@@ -614,3 +614,4 @@ int i915_syncmap_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(i915_syncmap_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index 71b52d5efef4..ae25bd6c58cd 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -949,6 +949,7 @@ int i915_vma_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_vma_mock_selftests, I915_SELFTEST);
 
 static int igt_vma_remapped_gtt(void *arg)
 {
diff --git a/drivers/gpu/drm/i915/selftests/intel_memory_region.c b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
index 3b18e5905c86..91cfd5d5cad2 100644
--- a/drivers/gpu/drm/i915/selftests/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
@@ -1376,6 +1376,7 @@ int intel_memory_region_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(intel_memory_region_mock_selftests, I915_SELFTEST);
 
 int intel_memory_region_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
index e4281508d580..2b61377d4b60 100644
--- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
+++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
@@ -138,6 +138,7 @@ int intel_uncore_mock_selftests(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_uncore_mock_selftests, I915_SELFTEST);
 
 static int live_forcewake_ops(void *arg)
 {
diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index d599186d5b71..d29aa7303b16 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -378,3 +378,4 @@ int scatterlist_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(scatterlist_mock_selftests, I915_SELFTEST);
-- 
2.38.1

