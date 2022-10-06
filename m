Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CC5F6C73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJFRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJFRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:01:06 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E24EB94113
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=P36UR
        nJL820ycRfoyiCP6wRhwOEFM7keKtxcCy0do6Y=; b=k1r//rUT0jPaTi4Zb6m4l
        gF/gDqEbUjlP7rTKA6nHge1W794HsPuoV5GntaM0CDWf6d9xhkLaqFaHELRhK62/
        IhJ/bH6nCNCby408gobEyoU/WmpLFFKqM8Lahgj8pthY70XaT3pEPwrqwPQuqoX5
        0lZv2y2nGILIFGg6DHMGhA=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by smtp1 (Coremail) with SMTP id GdxpCgA3n2dGCT9jRdswiQ--.20016S2;
        Fri, 07 Oct 2022 00:58:46 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     zyytlz.wz@163.com
Cc:     1002992920@qq.com, airlied@linux.ie, alex000young@gmail.com,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        hackerzheng666@gmail.com, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        security@kernel.org, tvrtko.ursulin@linux.intel.com
Subject: [PATCH v2] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
Date:   Fri,  7 Oct 2022 00:58:45 +0800
Message-Id: <20221006165845.1735393-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928033340.1063949-1-zyytlz.wz@163.com>
References: <20220928033340.1063949-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgA3n2dGCT9jRdswiQ--.20016S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1UKr1xtFW3GFWDAr18Xwb_yoW5ur18pF
        W5XFZ0yFs8Aw4Ivr4xCw1kZF15JF1fWry8GrZ3K3ZYyF1DtF1kKFZ3ZrW7Jr9agrZ7Gr1f
        Ar4UtF4UCa47XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRH5lnUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQgaSU1aEDIPvewAAsM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If intel_gvt_dma_map_guest_page failed, it will call
ppgtt_invalidate_spt, which will finally free the spt.
But the caller does not notice that, it will free spt again in error path.

Fix this by spliting invalidate and free in ppgtt_invalidate_spt.
Only free spt when in good case.

Reported-by: Zheng Wang <hackerzheng666@gmail.com>
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v2:
- split initial function into two api function suggested by Greg

v1: https://lore.kernel.org/all/20220928033340.1063949-1-zyytlz.wz@163.com/
---
 drivers/gpu/drm/i915/gvt/gtt.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index ce0eb03709c3..55d8e1419302 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -959,6 +959,7 @@ static inline int ppgtt_put_spt(struct intel_vgpu_ppgtt_spt *spt)
 	return atomic_dec_return(&spt->refcount);
 }
 
+static int  ppgtt_invalidate_and_free_spt(struct intel_vgpu_ppgtt_spt *spt);
 static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
 
 static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
@@ -995,7 +996,7 @@ static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
 				ops->get_pfn(e));
 		return -ENXIO;
 	}
-	return ppgtt_invalidate_spt(s);
+	return ppgtt_invalidate_and_free_spt(s);
 }
 
 static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *spt,
@@ -1016,18 +1017,31 @@ static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *spt,
 	intel_gvt_dma_unmap_guest_page(vgpu, pfn << PAGE_SHIFT);
 }
 
-static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
+static int  ppgtt_invalidate_and_free_spt(struct intel_vgpu_ppgtt_spt *spt)
 {
 	struct intel_vgpu *vgpu = spt->vgpu;
-	struct intel_gvt_gtt_entry e;
-	unsigned long index;
 	int ret;
 
 	trace_spt_change(spt->vgpu->id, "die", spt,
-			spt->guest_page.gfn, spt->shadow_page.type);
-
+		spt->guest_page.gfn, spt->shadow_page.type);
 	if (ppgtt_put_spt(spt) > 0)
 		return 0;
+	ret = ppgtt_invalidate_spt(spt);
+	if (!ret) {
+		trace_spt_change(spt->vgpu->id, "release", spt,
+			 spt->guest_page.gfn, spt->shadow_page.type);
+		ppgtt_free_spt(spt);
+	}
+
+	return ret;
+}
+
+static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
+{
+	struct intel_vgpu *vgpu = spt->vgpu;
+	struct intel_gvt_gtt_entry e;
+	unsigned long index;
+	int ret;
 
 	for_each_present_shadow_entry(spt, &e, index) {
 		switch (e.type) {
@@ -1059,9 +1073,6 @@ static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
 		}
 	}
 
-	trace_spt_change(spt->vgpu->id, "release", spt,
-			 spt->guest_page.gfn, spt->shadow_page.type);
-	ppgtt_free_spt(spt);
 	return 0;
 fail:
 	gvt_vgpu_err("fail: shadow page %p shadow entry 0x%llx type %d\n",
@@ -1393,7 +1404,7 @@ static int ppgtt_handle_guest_entry_removal(struct intel_vgpu_ppgtt_spt *spt,
 			ret = -ENXIO;
 			goto fail;
 		}
-		ret = ppgtt_invalidate_spt(s);
+		ret = ppgtt_invalidate_and_free_spt(s);
 		if (ret)
 			goto fail;
 	} else {
-- 
2.25.1

