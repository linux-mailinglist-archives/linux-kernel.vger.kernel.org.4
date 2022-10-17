Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32649600AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiJQJdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiJQJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:33:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ABA58DDA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999172; x=1697535172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7/TXOlwKuSkPVUCwoST/WEVHFeOcyRbxSbjIiLRy7U=;
  b=PrqjAqatzmj+SDSe7Zmp0LLH3c6tgxjGuGgJSJEmAO7DoyDCCAB2rSIU
   rjM1mm1xQ0xNTH1weArVIFuy8hads1OPRXplQ/LDEpcKh6wt/VRvUNKFl
   Aw0da7Mz1NaXYQLfGriz90/MwEtO3FbOTqwBFEQgiUrhT34L4wijhs89V
   0K4+rATJZUQFeYNnkWIqW74OttLC+WHYOXrqNFc4aU1z/maCjsowI+cLE
   pGOIdfULdGhP8jAfkn0+ijPC6RHbWsZQxKW6vs0HfnTfUGtXuf29iBxdi
   Ef3dg1064iC07Zzi4qvLVSSs7DQrd3/dJasu34ZPN+91blw+NBgh//9Ue
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305741632"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305741632"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="717431321"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="717431321"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 02:32:48 -0700
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
Subject: [PATCH 7/9] drm/i915: Use memcpy_from_page() in gt/uc/intel_uc_fw.c
Date:   Mon, 17 Oct 2022 17:37:23 +0800
Message-Id: <20221017093726.2070674-8-zhao1.liu@linux.intel.com>
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

In drm/i915/gt/uc/intel_us_fw.c, the function intel_uc_fw_copy_rsa()
just use the mapping to do memory copy so it doesn't need to disable
pagefaults and preemption for mapping. Thus the local mapping without
atomic context (not disable pagefaults / preemption) is enough.

Therefore, intel_uc_fw_copy_rsa() is a function where the use of
memcpy_from_page() with kmap_local_page() in place of memcpy() with
kmap_atomic() is correctly suited.

Convert the calls of memcpy() with kmap_atomic() / kunmap_atomic() to
memcpy_from_page() which uses local mapping to copy.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/T/#u

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credits:
  Ira: Referred to his task document and suggestions about using
       memcpy_from_page() directly.
  Fabio: Referred to his boiler plate commit message.
---
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
index b91ad4aede1f..64d56f175d32 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
@@ -962,16 +962,13 @@ size_t intel_uc_fw_copy_rsa(struct intel_uc_fw *uc_fw, void *dst, u32 max_len)
 
 		for_each_sgt_page(page, iter, uc_fw->obj->mm.pages) {
 			u32 len = min_t(u32, size, PAGE_SIZE - offset);
-			void *vaddr;
 
 			if (idx > 0) {
 				idx--;
 				continue;
 			}
 
-			vaddr = kmap_atomic(page);
-			memcpy(dst, vaddr + offset, len);
-			kunmap_atomic(vaddr);
+			memcpy_from_page(dst, page, offset, len);
 
 			offset = 0;
 			dst += len;
-- 
2.34.1

