Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C286A1F99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBXQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBXQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:26:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747576A9E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677255997; x=1708791997;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tWIS1fDOoAR997SIfPLRFSn5hDKzRRgGJcW8CcVa3mw=;
  b=KPcJXU1ZJW5oJoR6vD2w+0IIlNFxgbYlXvtJkxV2Yy9LhuBDxDiHLxhN
   6YmzBezt1l41ReS4PKGHr0M8yaib8pm0tKWixavhuMfO00KgB+AI8JN8O
   +ll6iP9/PxRqW3RIj9nwT80sEJEgDDc/VwXClwuUA9/7F5zzY7a5ADLXI
   TzQhwzOLWkw7hRqv4T+Zwc8BME4E/FyVHtM0ncEamdAMO6FLzF4Fy5Lpi
   MZtvcK+8xD6XTd+wRI4NFTHLDBwOUdXAa1H8NR8/OgmGZO5wsxEAjQiKK
   kshpRwdqvUxi5UNu6pd5SwcjG+x/5i1TZ/4SdwmQlnXwe19caWaoQ1fHI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="317273426"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="317273426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:26:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="705321998"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="705321998"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:26:22 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Fri, 24 Feb 2023 17:25:42 +0100
Subject: [PATCH 3/3] drm/i915: Correct type of wakeref variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-track_gt-v1-3-0222096fcdc6@intel.com>
References: <20230224-track_gt-v1-0-0222096fcdc6@intel.com>
In-Reply-To: <20230224-track_gt-v1-0-0222096fcdc6@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wakeref has dedicated type. Assumption it will be int
compatible forever is incorrect.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 978820f8697059..c35f551193c9ad 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -3235,7 +3235,7 @@ static void destroyed_worker_func(struct work_struct *w)
 	struct intel_guc *guc = container_of(w, struct intel_guc,
 					     submission_state.destroyed_worker);
 	struct intel_gt *gt = guc_to_gt(guc);
-	int tmp;
+	intel_wakeref_t tmp;
 
 	with_intel_gt_pm(gt, tmp)
 		deregister_destroyed_contexts(guc);

-- 
2.34.1
