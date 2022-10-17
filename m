Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F395600AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiJQJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJQJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:32:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E345347BAB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999143; x=1697535143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ZU9PDhvVYa7AEOd0lamaGEe6sVuaqOTNJI83nJvfl8=;
  b=b7x7iaPyCtJSx9+o7AlKF5xK3Px7Gx7jozLoPsXofnr6plHJ4JRBXlaB
   QGQTYq0WMp8LQJ/It5058aZ5u0jiTOEFJuZVUoxogoRUY39Vgq4o+uO4u
   glZWzySRegqEkLDjQ7innXAUMcNeJ+Nl+uikWQ9FRrpDmb6Vx7jx3xA16
   bbtedNMVAe6eQzEumktyJQuvwVlewAoyGf77Zlpx8RKAen5caVX1BAlcL
   X0Ng7SgdB2q66DexGPvTp/UZmKxvZPeLSoI/JOt7vVm1bw09wiryHxlpu
   UBQvD1cTZj5PWf48B3AQjUw1uy/y/Z0Hz2ylEyZFewBK0tvuxnEKvpVQS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305741538"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305741538"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="717431199"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="717431199"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 02:32:19 -0700
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/9] drm/i915: Replace kmap_atomic() with kmap_local_page()
Date:   Mon, 17 Oct 2022 17:37:16 +0800
Message-Id: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Liu <zhao1.liu@intel.com>

The use of kmap_atomic() is being deprecated in favor of
kmap_local_page()[1].

In the following patches, we can convert the calls of kmap_atomic() /
kunmap_atomic() to kmap_local_page() / kunmap_local(), which can
instead do the mapping / unmapping regardless of the context.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
---
Zhao Liu (9):
  drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
  drm/i915: Use kmap_local_page() in gem/i915_gem_pyhs.c
  drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
  drm/i915: Use kmap_local_page() in gem/selftests/huge_pages.c
  drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_coherency.c
  drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_context.c
  drm/i915: Use memcpy_from_page() in gt/uc/intel_uc_fw.c
  drm/i915: Use kmap_local_page() in i915_cmd_parser.c
  drm/i915: Use kmap_local_page() in gem/i915_gem_execbuffer.c

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c       | 10 +++++-----
 drivers/gpu/drm/i915/gem/i915_gem_object.c           |  8 +++-----
 drivers/gpu/drm/i915/gem/i915_gem_phys.c             |  8 ++++----
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c            |  6 ++++--
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c      |  6 +++---
 .../gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 12 ++++--------
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c    |  8 ++++----
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c             |  5 +----
 drivers/gpu/drm/i915/i915_cmd_parser.c               |  4 ++--
 9 files changed, 30 insertions(+), 37 deletions(-)

-- 
2.34.1

