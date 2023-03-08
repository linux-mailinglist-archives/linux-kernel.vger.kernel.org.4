Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCDB6B0D18
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjCHPkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjCHPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:40:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF91B8F16
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678289990; x=1709825990;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UFsc11qcv0An3YTgsx2jUXx1nEcHzBdMgxW2w6BVW+0=;
  b=MACEQGZmaVuwhCs7LR/uQarID42E+EPlwAMla0aSVcu3DH6MYc3Ehbmw
   yXpZm/xLQIUqUSp9TXgiMVx3/p3U7j2oawiOyRzuA1oTZY7Xoq4VlO9yT
   dJA/6cJ3m6A9HWWI9ovnfQHqsZE672GSYLnZdpy0IyIk9gH9BuXdpbeS6
   uCWPzLJpH/cNoUhyDgUZOBnZx74s/LtIVPkTr/8dMtL2D2mR4vk30hXMu
   diVHnds+untvk1QMH96rlAs9B/K++bshEd3SZrPFdZ/6wN+hhkPSnjSQP
   mwdnCOMd55EnuLYEiWm1QM5jDM5wI6n3KuaZozbCmub7C6EDCjttHdu3o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337703537"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="337703537"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="787160246"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="787160246"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:44 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Wed, 08 Mar 2023 16:39:03 +0100
Subject: [PATCH v5 1/4] drm/i915/gt: make nop_clear_range public
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-guard_error_capture-v5-1-6d1410d13540@intel.com>
References: <20230308-guard_error_capture-v5-0-6d1410d13540@intel.com>
In-Reply-To: <20230308-guard_error_capture-v5-0-6d1410d13540@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function nop_clear_range can be used instead of local implementations.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt.c | 3 +--
 drivers/gpu/drm/i915/gt/intel_gtt.h  | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 842e69c7b21e49..b925da42c7cfc4 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -345,8 +345,7 @@ static void gen6_ggtt_insert_entries(struct i915_address_space *vm,
 	ggtt->invalidate(ggtt);
 }
 
-static void nop_clear_range(struct i915_address_space *vm,
-			    u64 start, u64 length)
+void nop_clear_range(struct i915_address_space *vm, u64 start, u64 length)
 {
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
index 5a775310d3fcb5..c15a4892e9f45d 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
@@ -672,4 +672,6 @@ static inline struct sgt_dma {
 	return (struct sgt_dma){ sg, addr, addr + sg_dma_len(sg) };
 }
 
+void nop_clear_range(struct i915_address_space *vm, u64 start, u64 length);
+
 #endif

-- 
2.34.1
