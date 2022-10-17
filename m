Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374EE600ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJQJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiJQJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:32:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86752802
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999155; x=1697535155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h0hmpKyvdxb2sKw8lROgYrffCQobTfXddN7YtzQHU7M=;
  b=Ul4mgQ2PEWvaEHTyCXo+CpuOqncgpmy7bqoqyJLIaDvc0LS0uGxTBa7q
   xGSfbEPWNDAcbn1EEklVi0+OMzGQrUCwC0UJsMs2Y3UJXHXkmcmWjbf+3
   q4h6zIyS//A0GM0phFQyG5AK8OTNT+c2epftNrFUT3LZX7miEC78ZOl8P
   kEIDverLDm6dOPMNvmufC2NmtxTFfT+m8RjLr0K2qUO+960SQ2KpFAfc3
   KFJMkB8dudpBdwUaa/MAiNouKZvB0bJAT3yCKYL03HjtWraAlISk/hzER
   tRzANd8yFzjNhkAu2ReA1klGptaBniNjOwGSElWB7WE4V+sg34MFboUHz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305741585"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305741585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="717431242"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="717431242"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 02:32:31 -0700
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
Subject: [PATCH 3/9] drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
Date:   Mon, 17 Oct 2022 17:37:19 +0800
Message-Id: <20221017093726.2070674-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
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

The main difference between atomic and local mappings is that local
mappings doesn't disable page faults or preemption.

In drm/i915/gem/i915_gem_shmem.c, the function shmem_pwrite() need to
disable pagefault to eliminate the potential recursion fault[2]. But
here __copy_from_user_inatomic() doesn't need to disable preemption and
local mapping is valid for sched in/out.

So it can use kmap_local_page() / kunmap_local() with
pagefault_disable() / pagefault_enable() to replace atomic mapping.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
[2]: https://patchwork.freedesktop.org/patch/295840/

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credits:
  Ira: Referred to his suggestions about keeping pagefault_disable().
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index f42ca1179f37..e279a3e30c02 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -472,11 +472,13 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		if (err < 0)
 			return err;
 
-		vaddr = kmap_atomic(page);
+		vaddr = kmap_local_page(page);
+		pagefault_disable();
 		unwritten = __copy_from_user_inatomic(vaddr + pg,
 						      user_data,
 						      len);
-		kunmap_atomic(vaddr);
+		pagefault_enable();
+		kunmap_local(vaddr);
 
 		err = aops->write_end(obj->base.filp, mapping, offset, len,
 				      len - unwritten, page, data);
-- 
2.34.1

