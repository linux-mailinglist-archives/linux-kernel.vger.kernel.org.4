Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB236E085F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMH5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDMH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:57:42 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB8093CB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:57:14 -0700 (PDT)
X-UUID: 523ffd16c1d74ba2bebaa48baf1044d8-20230413
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e27458f9-b223-4a29-a75f-dc1628b0353d,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:1
X-CID-INFO: VERSION:1.1.22,REQID:e27458f9-b223-4a29-a75f-dc1628b0353d,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:1
X-CID-META: VersionHash:120426c,CLOUDID:952432a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230413111352DVZVW4B9,BulkQuantity:2,Recheck:0,SF:24|17|19|43|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 523ffd16c1d74ba2bebaa48baf1044d8-20230413
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <liucong2@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1709036445; Thu, 13 Apr 2023 15:57:06 +0800
From:   Cong Liu <liucong2@kylinos.cn>
To:     jani.nikula@linux.intel.com
Cc:     airlied@gmail.com, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, chris@chris-wilson.co.uk, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, gwan-gyeong.mun@intel.com,
        intel-gfx@lists.freedesktop.org, jonathan.cavitt@intel.com,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        liucong2@kylinos.cn, matthew.auld@intel.com,
        matthew.brost@intel.com, mchehab@kernel.org, nirmoy.das@intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com
Subject: [PATCH] drm/i915: Fix memory leaks in i915 selftests
Date:   Thu, 13 Apr 2023 15:55:26 +0800
Message-Id: <20230413075526.221068-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <874jpkckxw.fsf@intel.com>
References: <874jpkckxw.fsf@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes memory leaks on error escapes in function fake_get_pages

Fixes: c3bfba9a2225 ("drm/i915: Check for integer truncation on scatterlist creation")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 5361ce70d3f2..154801f1c468 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -69,8 +69,10 @@ static int fake_get_pages(struct drm_i915_gem_object *obj)
 
 	rem = round_up(obj->base.size, BIT(31)) >> 31;
 	/* restricted by sg_alloc_table */
-	if (overflows_type(rem, unsigned int))
+	if (overflows_type(rem, unsigned int)) {
+		kfree(pages);
 		return -E2BIG;
+	}
 
 	if (sg_alloc_table(pages, rem, GFP)) {
 		kfree(pages);
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus
