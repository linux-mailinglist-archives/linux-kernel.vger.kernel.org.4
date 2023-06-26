Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA8D73DB25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjFZJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFZJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:19:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B972D64;
        Mon, 26 Jun 2023 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687770997; x=1719306997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wfgL9qGgPwrycb+pq8eWWsXWs7vH+aYL2R+tvWwCzhA=;
  b=nhqftDRufdyEpvUJq3phJF8b3Z0bOW6K9tqsFoYeD7fTH3RFkZR++1Wu
   Jyzp24wH6qsEf+7bZ7UCWy4nZoENM+qTFXp/jIL948ULoWiQFGdT6bnJE
   DoyeB/mC1PdzJueNw66WRucHfxkjkBSmFZwxDyJ/S4ZzPeDTaT8YZbMiu
   t1B1HHGnhRUxSwMXqqjHxYtJJtw1vfOEmcVv8yoNo5bbfNJ7mFTXylAQ1
   NFth27kydNDb9F1J9G/HxhuAYCSgVhp2ofxI0ARP1Agab7jhgZVFzrarh
   FMTKMCIkb+lnh9gEYjQiDZ9qNFkTK4zCabXVd0r4Q76ekNFf/Wh/UmLsB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="345974121"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="345974121"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="781357795"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="781357795"
Received: from ettammin-mobl1.ger.corp.intel.com (HELO thellstr-mobl1.intel.com) ([10.249.254.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:15:08 -0700
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        stable@vger.kernel.org, Nirmoy Das <nirmoy.das@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "Andi Shyti" <andi.shyti@linux.intel.com>
Subject: [PATCH v2 3/4] drm/ttm: Don't leak a resource on eviction error
Date:   Mon, 26 Jun 2023 11:14:49 +0200
Message-Id: <20230626091450.14757-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On eviction errors other than -EMULTIHOP we were leaking a resource.
Fix.

v2:
- Avoid yet another goto (Andi Shyti)

Fixes: 403797925768 ("drm/ttm: Fix multihop assert on eviction.")
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com> #v1
---
 drivers/gpu/drm/ttm/ttm_bo.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 615d30c4262d..c0e3bbd21d3d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -458,18 +458,18 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 		goto out;
 	}
 
-bounce:
-	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
-	if (ret == -EMULTIHOP) {
+	do {
+		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
+		if (ret != -EMULTIHOP)
+			break;
+
 		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
-		if (ret) {
-			if (ret != -ERESTARTSYS && ret != -EINTR)
-				pr_err("Buffer eviction failed\n");
-			ttm_resource_free(bo, &evict_mem);
-			goto out;
-		}
-		/* try and move to final place now. */
-		goto bounce;
+	} while (!ret);
+
+	if (ret) {
+		ttm_resource_free(bo, &evict_mem);
+		if (ret != -ERESTARTSYS && ret != -EINTR)
+			pr_err("Buffer eviction failed\n");
 	}
 out:
 	return ret;
-- 
2.40.1

