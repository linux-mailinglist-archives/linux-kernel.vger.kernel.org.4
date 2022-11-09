Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0A62333B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiKITLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiKITK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:10:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0B272C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668021057; x=1699557057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6o2iw5GGxg52ODYXfhWmxxEkXpHYpZprWDIoibYlmQ=;
  b=BxWlv4WLTVeE3xsYNExGriUguSGZR1qbwR0ZLj5k4SStbCdQz13niJnI
   hEfyIlciDELI9CsfZolx/KSkzt1qmemryTgFpBD110qAX2LkFn1+lH+hW
   b+5eTZqbhd5cWMXkA36qit0z3FfNPpOpDXJXna3hDD7qAOMXGYEDQJBE9
   Bia3n5lUN4EoLFWVm9NaQ1dEOkP4KweOGlJwg7AOTXH6hc5ZX16klzYQ/
   ozqNk4Cg7Fk2xBZCd9Dkp0W1PnRR10vmcWt5vGKwRIhitEipsZ0Z5Aiu1
   5CkCTwULdn2oxdcIfrlru+0Ur0Jg0FDLEUQOzj+BCcf8c413dqz/Un6mt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312234713"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312234713"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:10:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="668105834"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="668105834"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.6.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:10:25 -0800
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris.p.wilson@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/i915: Fix unintended submission flush after retire times out
Date:   Wed,  9 Nov 2022 20:09:36 +0100
Message-Id: <20221109190937.64155-3-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
References: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If wait on request DMA fence times out while we are retiring requests,
-ETIME is stored as remaining time.  Then, flush_submission() called
thereafter proceeds with its work instead of returning immediately due to
the value of timeout passed to it not equal 0.  That's probably not what
was intended.

Fix it by replacing -ETIME value of the argument with 0.

Fixes: 09137e945437 ("drm/i915/gem: Unpin idle contexts from kswapd reclaim")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gt_requests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
index 6c3b8ac3055c3..309d5937d6910 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
@@ -204,7 +204,7 @@ out_active:	spin_lock(&timelines->lock);
 	list_for_each_entry_safe(tl, tn, &free, link)
 		__intel_timeline_free(&tl->kref);
 
-	if (flush_submission(gt, timeout)) /* Wait, there's more! */
+	if (flush_submission(gt, timeout > 0)) /* Wait, there's more! */
 		active_count++;
 
 	if (remaining_timeout)
-- 
2.25.1

