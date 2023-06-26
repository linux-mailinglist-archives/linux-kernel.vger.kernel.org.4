Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E88673DB27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFZJU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFZJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:19:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB5A3C1E;
        Mon, 26 Jun 2023 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687771002; x=1719307002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=63Y0TPem7frMMGW3N/FgR3d/cjkXyqdp+LijdVM6QYA=;
  b=QSk1xxcr2jgUsY9vkBuh/5wj0nYFU5HO9HZ5QCf5OYH/THgNy1QCFxmC
   ys+fH+YyfbQdF1ZrfpO9FwrToj+l9K9aOTs9v3y5iB/lxajcMo1ImuSh7
   nx5QZhw9ndYWQe6YIekKezLlzQlUbR00vvzzOE+5bIl3OaGDdpuvtaK2x
   D+z5DZsNCfKkOT6TA1g3cyrBqukGD6EVb2+mp6A8kRmNzoYxCYcNceYKa
   0MHuOotKKjK+iDSAfjX9Y+IcPKIqvRk43tpUXBG7I4iPRm3eKXdSibx5p
   HoKwqaO7XeRBZ3UeK6JCZNk3m980qi5wM3yIJpSg8GSiYd0oCdtwKPzTz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="345974135"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="345974135"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="781357838"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="781357838"
Received: from ettammin-mobl1.ger.corp.intel.com (HELO thellstr-mobl1.intel.com) ([10.249.254.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:15:11 -0700
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/ttm: Don't leak a resource on swapout move error
Date:   Mon, 26 Jun 2023 11:14:50 +0200
Message-Id: <20230626091450.14757-5-thomas.hellstrom@linux.intel.com>
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

If moving the bo to system for swapout failed, we were leaking
a resource. Fix.

Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of embedding it v2")
Cc: Christian König <christian.koenig@amd.com>
Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.14+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index c0e3bbd21d3d..d9a8f227f310 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1166,6 +1166,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
 		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
 		if (unlikely(ret != 0)) {
 			WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput - likely driver bug.\n");
+			ttm_resource_free(bo, &evict_mem);
 			goto out;
 		}
 	}
-- 
2.40.1

