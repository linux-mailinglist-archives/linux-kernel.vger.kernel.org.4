Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E254C68A307
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjBCTbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjBCTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:31:00 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FD31C7D4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675452635; bh=bkktwzcTrVERotqO7zXpzdBHdLDyij1klnN7HWoIRu0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ClxlJqIOzwlIRAUnCY67NIR/vPpRQkPIyBlu3fSnwYsSORbcB8Ex1Mtdx8fUybM73
         fyCk31gT44NQCkcOukeY3W0yMnJ407D+w+14BMTfJYmxs/XEZCZpeQLyydOpY5oive
         B4f+m4nbnskTPERLknxJHAC3mLgbK58g6Cxe8V7I=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri,  3 Feb 2023 20:30:35 +0100 (CET)
X-EA-Auth: LCVZG3qeAH/AKO5KQB9nnONmJiWgMjCPXypOWNIGmFbWyTfyMJMpBn+0scKaJ0et5iR3gOQyGEt2Mud03HTaMyL0S0UPAtI1
Date:   Sat, 4 Feb 2023 01:00:27 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] drm/i915/gt: Avoid redundant pointer validity check
Message-ID: <Y91g081OauhQNxMe@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro definition of gen6_for_all_pdes() expands to a for loop such
that it breaks when the page table is null. Hence there is no need to
again test validity of the page table entry pointers in the pde list.
This change is identified using itnull.cocci semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: Proposed change is compile tested only.

 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
index 5aaacc53fa4c..787b9e6d9f59 100644
--- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
@@ -258,8 +258,7 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *ppgtt)
 	u32 pde;
 
 	gen6_for_all_pdes(pt, pd, pde)
-		if (pt)
-			free_pt(&ppgtt->base.vm, pt);
+		free_pt(&ppgtt->base.vm, pt);
 }
 
 static void gen6_ppgtt_cleanup(struct i915_address_space *vm)
@@ -304,7 +303,7 @@ static void pd_vma_unbind(struct i915_address_space *vm,
 
 	/* Free all no longer used page tables */
 	gen6_for_all_pdes(pt, ppgtt->base.pd, pde) {
-		if (!pt || atomic_read(&pt->used))
+		if (atomic_read(&pt->used))
 			continue;
 
 		free_pt(&ppgtt->base.vm, pt);
-- 
2.34.1



