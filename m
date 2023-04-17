Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD546E456A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjDQKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjDQKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:40:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2576EBF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:40:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f16ecaadd1so11692205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681727946; x=1684319946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH79Swn8ZRJ2/YarOj91Bz0xxg30p0nVIyjLTbfZHEk=;
        b=YRKjuLMhTl40C+QqFYNyd1bRihczrfYWx/yGU36IRsJfmSPwWm5zftNVBsPia6yv+S
         Zxqe6js3OrRVHvL9eVEwsHAVrpNhJPpvZcA3/CuoUjouJePIvyzvpsD+QqepRoAlloZ/
         0fsrKdoUG/TsMKLWUBTOHqggXyBAQ2C+BlCWcOm9TvmHiaIgIBq5KhCWjFeagOpEmB8d
         1DAQ0WsJbDJw9QEjshxivpMLqq89xEmLpV7P0ecn/QKP2xODoAfG9PcVZbGxJetEzBPJ
         tD5YqlokKpW5QqC7IQ0a6OqDD1KDVY5I3WNXvmUYrxVtT80Kmg/URg+3ZpE9rLMH6zR0
         2NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681727946; x=1684319946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH79Swn8ZRJ2/YarOj91Bz0xxg30p0nVIyjLTbfZHEk=;
        b=Iu8XvljOAjUbj48L0H5aC9fjQ4BVI/jq/utLLJmTi1Oq4ULnErhb2U4Sm8D4IzhSrS
         8gqnjuXv1p1eEmtoDq6jaPz1mUC9CjYfycoBtK8NaT2DEf0DABKn/bJzHEjIRY51r3c7
         xtlXdyeCY4OMuP2DTl1Gwyq5ZfTqAgypoUTF8jlnJ98s3zf3vXCdFmcLcOKvplj2IWyp
         gu6+73oJZ9Mi5BPkGOD8i6goagzMPFwV8UFgsDY9238AH5Z/h9mVIR8p2+6rwWDGImpC
         Kuh+dBDNdTzzK2K3LHqwOlBw7LjQoLniAxBi81r8aVC4xopoke81Uvaw4RGSYKZJoTZz
         woiw==
X-Gm-Message-State: AAQBX9dCA6r2f3A0osGKfBLhR0jdEnXd5345nG90mbodnFv5iJ3GrRz8
        O9fBj06k/oM+POGlzYA3DVU=
X-Google-Smtp-Source: AKy350ZHLsYNFXN5GyVB3dvmvIOZLfVbmy328/EyKvOC+gnAZGSMikYnaDOJgYq7gQ7O8a2gX7ryOA==
X-Received: by 2002:adf:d085:0:b0:2fa:88f2:b04c with SMTP id y5-20020adfd085000000b002fa88f2b04cmr1956315wrh.20.1681727945938;
        Mon, 17 Apr 2023 03:39:05 -0700 (PDT)
Received: from localhost.localdomain (host-87-19-108-254.retail.telecomitalia.it. [87.19.108.254])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d470c000000b002c70ce264bfsm10238018wrq.76.2023.04.17.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:39:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matt Roper <matthew.d.roper@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 3/3] drm/i915/gem: Replace kmap() with kmap_local_page()
Date:   Mon, 17 Apr 2023 12:38:54 +0200
Message-Id: <20230417103854.23333-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417103854.23333-1-fmdefrancesco@gmail.com>
References: <20230417103854.23333-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() s been deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Obviously, thread locality implies that the kernel virtual addresses are
only valid in the context of the callers. The kmap_local_page() use in
i915/gem doesn't break the above-mentioned constraint, so it should be
preferred to kmap().

Therefore, replace kmap() with kmap_local_page() in i915/gem and use
memcpy_to_page() where it is possible to avoid the open coding of
mapping + memcpy() + un-mapping.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          | 6 ++----
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 37d1efcd3ca6..8856a6409e83 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -657,16 +657,14 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *dev_priv,
 	do {
 		unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
 		struct page *page;
-		void *pgdata, *vaddr;
+		void *pgdata;

 		err = aops->write_begin(file, file->f_mapping, offset, len,
 					&page, &pgdata);
 		if (err < 0)
 			goto fail;

-		vaddr = kmap(page);
-		memcpy(vaddr, data, len);
-		kunmap(page);
+		memcpy_to_page(page, 0, data, len);

 		err = aops->write_end(file, file->f_mapping, offset, len, len,
 				      page, pgdata);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 56279908ed30..5fd9e1ee2340 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -155,7 +155,7 @@ static int check_partial_mapping(struct drm_i915_gem_object *obj,
 	intel_gt_flush_ggtt_writes(to_gt(i915));

 	p = i915_gem_object_get_page(obj, offset >> PAGE_SHIFT);
-	cpu = kmap(p) + offset_in_page(offset);
+	cpu = kmap_local_page(p) + offset_in_page(offset);
 	drm_clflush_virt_range(cpu, sizeof(*cpu));
 	if (*cpu != (u32)page) {
 		pr_err("Partial view for %lu [%u] (offset=%llu, size=%u [%llu, row size %u], fence=%d, tiling=%d, stride=%d) misalignment, expected write to page (%lu + %u [0x%lx]) of 0x%x, found 0x%x\n",
@@ -173,7 +173,7 @@ static int check_partial_mapping(struct drm_i915_gem_object *obj,
 	}
 	*cpu = 0;
 	drm_clflush_virt_range(cpu, sizeof(*cpu));
-	kunmap(p);
+	kunmap_local(cpu);

 out:
 	i915_gem_object_lock(obj, NULL);
@@ -251,7 +251,7 @@ static int check_partial_mappings(struct drm_i915_gem_object *obj,
 		intel_gt_flush_ggtt_writes(to_gt(i915));

 		p = i915_gem_object_get_page(obj, offset >> PAGE_SHIFT);
-		cpu = kmap(p) + offset_in_page(offset);
+		cpu = kmap_local_page(p) + offset_in_page(offset);
 		drm_clflush_virt_range(cpu, sizeof(*cpu));
 		if (*cpu != (u32)page) {
 			pr_err("Partial view for %lu [%u] (offset=%llu, size=%u [%llu, row size %u], fence=%d, tiling=%d, stride=%d) misalignment, expected write to page (%lu + %u [0x%lx]) of 0x%x, found 0x%x\n",
@@ -269,7 +269,7 @@ static int check_partial_mappings(struct drm_i915_gem_object *obj,
 		}
 		*cpu = 0;
 		drm_clflush_virt_range(cpu, sizeof(*cpu));
-		kunmap(p);
+		kunmap_local(cpu);
 		if (err)
 			return err;

--
2.40.0

