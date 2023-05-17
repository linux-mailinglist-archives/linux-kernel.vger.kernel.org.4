Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41428705F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjEQFCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEQFCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:02:51 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF2E2136
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:02:49 -0700 (PDT)
X-UUID: 97ba50cf53c147aaa6f2d5b5e43098f3-20230517
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:d2b87ce7-df4a-4b37-adae-eb666f7a01d2,IP:15,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:d2b87ce7-df4a-4b37-adae-eb666f7a01d2,IP:15,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:73f4116c-2f20-4998-991c-3b78627e4938,B
        ulkID:230517130233VKXSJLJ6,BulkQuantity:0,Recheck:0,SF:17|19|44|38|24|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 97ba50cf53c147aaa6f2d5b5e43098f3-20230517
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <liucong2@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 247450098; Wed, 17 May 2023 13:02:31 +0800
From:   Cong Liu <liucong2@kylinos.cn>
To:     liucong2@kylinos.cn, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915: Fix memory leaks in function live_nop_switch
Date:   Wed, 17 May 2023 13:02:03 +0800
Message-Id: <20230517050204.4111874-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508085016.437836-1-liucong2@kylinos.cn>
References: <20230508085016.437836-1-liucong2@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be sure to properly free the allocated memory before exiting
the live_nop_switch function.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Suggested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index a81fa6a20f5a..2fb125d0cb5e 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -66,7 +66,7 @@ static int live_nop_switch(void *arg)
 		ctx[n] = live_context(i915, file);
 		if (IS_ERR(ctx[n])) {
 			err = PTR_ERR(ctx[n]);
-			goto out_file;
+			goto out_ctx;
 		}
 	}
 
@@ -82,7 +82,7 @@ static int live_nop_switch(void *arg)
 			this = igt_request_alloc(ctx[n], engine);
 			if (IS_ERR(this)) {
 				err = PTR_ERR(this);
-				goto out_file;
+				goto out_ctx;
 			}
 			if (rq) {
 				i915_request_await_dma_fence(this, &rq->fence);
@@ -96,7 +96,7 @@ static int live_nop_switch(void *arg)
 			intel_gt_set_wedged(to_gt(i915));
 			i915_request_put(rq);
 			err = -EIO;
-			goto out_file;
+			goto out_ctx;
 		}
 		i915_request_put(rq);
 
@@ -107,7 +107,7 @@ static int live_nop_switch(void *arg)
 
 		err = igt_live_test_begin(&t, i915, __func__, engine->name);
 		if (err)
-			goto out_file;
+			goto out_ctx;
 
 		end_time = jiffies + i915_selftest.timeout_jiffies;
 		for_each_prime_number_from(prime, 2, 8192) {
@@ -120,7 +120,7 @@ static int live_nop_switch(void *arg)
 				this = igt_request_alloc(ctx[n % nctx], engine);
 				if (IS_ERR(this)) {
 					err = PTR_ERR(this);
-					goto out_file;
+					goto out_ctx;
 				}
 
 				if (rq) { /* Force submission order */
@@ -165,7 +165,7 @@ static int live_nop_switch(void *arg)
 
 		err = igt_live_test_end(&t);
 		if (err)
-			goto out_file;
+			goto out_ctx;
 
 		pr_info("Switch latencies on %s: 1 = %lluns, %lu = %lluns\n",
 			engine->name,
@@ -173,6 +173,8 @@ static int live_nop_switch(void *arg)
 			prime - 1, div64_u64(ktime_to_ns(times[1]), prime - 1));
 	}
 
+out_ctx:
+	kfree(ctx);
 out_file:
 	fput(file);
 	return err;
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus
