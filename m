Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9D658F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiL2Q5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiL2Q5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:57:30 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D60AF5A7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Bjgvc
        YpLFCPLXyGdhy/jjW+A0l9sfosElfSN1VeTjBU=; b=qSwTlsauuGHlFCP/ExbcF
        6lFaX5qVzaqgycnVb7WGf7xg+tK7fyV/Lm0r+gKVom45OCzH2yBzFd9aWzByEiFs
        NvuXsf5qHC/IBDkJ070PN3z5po5fY8zvxvD27MBIqD6Z9cEUz7sqRLow9qIcjfiz
        7j3otB5MjP4XSwAVQBt7zA=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wA3dl7Lxq1j2hKAAA--.23382S2;
        Fri, 30 Dec 2022 00:56:43 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     zhi.a.wang@intel.com
Cc:     1002992920@qq.com, airlied@gmail.com, airlied@linux.ie,
        alex000young@gmail.com, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, hackerzheng666@gmail.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        security@kernel.org, tvrtko.ursulin@linux.intel.com,
        zhenyuw@linux.intel.com, zyytlz.wz@163.com
Subject: [PATCH v6] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
Date:   Fri, 30 Dec 2022 00:56:41 +0800
Message-Id: <20221229165641.1192455-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <11728bc1-7b59-1623-b517-d1a0d57eb275@intel.com>
References: <11728bc1-7b59-1623-b517-d1a0d57eb275@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3dl7Lxq1j2hKAAA--.23382S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4kAr15Xr1rCr1kAr43KFg_yoW5GFWUpF
        W8Wa1YyF4rAF1Iva97uF1xAFy3Z3W3Xa48WrWkKa4Ykrs0qF1qkrZ0kFW5XrykuFn8Aa1f
        Cr4DJrW3C34jvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoGQgUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbCbxXmU2BbENo9ZQAAsm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If intel_gvt_dma_map_guest_page failed, it will call
 ppgtt_invalidate_spt, which will finally free the spt.
 But the caller function ppgtt_populate_spt_by_guest_entry
 does not notice that, it will free spt again in its error
 path.

Fix this by canceling the mapping of DMA address and freeing sub_spt.
Besides, leave the handle of spt destroy to caller function instead
of callee function when error occurs.

Fixes: b901b252b6cf ("drm/i915/gvt: Add 2M huge gtt support")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
v6:
- remove the code for setting unused variable to NULL and fix type suggested
by Zhenyu

v5:
- remove unnecessary switch-case code for there is only one particular case,
correct the unmap target from parent_spt to sub_spt.add more details in
commit message. All suggested by Zhenyu

v4:
- fix by undo the mapping of DMA address and free sub_spt suggested by Zhi

v3:
- correct spelling mistake and remove unused variable suggested by Greg

v2: https://lore.kernel.org/all/20221006165845.1735393-1-zyytlz.wz@163.com/

v1: https://lore.kernel.org/all/20220928033340.1063949-1-zyytlz.wz@163.com/
---
 drivers/gpu/drm/i915/gvt/gtt.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 51e5e8fb505b..7379e8d98417 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1209,10 +1209,8 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
 	for_each_shadow_entry(sub_spt, &sub_se, sub_index) {
 		ret = intel_gvt_dma_map_guest_page(vgpu, start_gfn + sub_index,
 						   PAGE_SIZE, &dma_addr);
-		if (ret) {
-			ppgtt_invalidate_spt(spt);
-			return ret;
-		}
+		if (ret)
+			goto err;
 		sub_se.val64 = se->val64;
 
 		/* Copy the PAT field from PDE. */
@@ -1231,6 +1229,17 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
 	ops->set_pfn(se, sub_spt->shadow_page.mfn);
 	ppgtt_set_shadow_entry(spt, se, index);
 	return 0;
+err:
+	/* Cancel the existing addess mappings of DMA addr. */
+	for_each_present_shadow_entry(sub_spt, &sub_se, sub_index) {
+		gvt_vdbg_mm("invalidate 4K entry\n");
+		ppgtt_invalidate_pte(sub_spt, &sub_se);
+	}
+	/* Release the new allocated spt. */
+	trace_spt_change(sub_spt->vgpu->id, "release", sub_spt,
+		sub_spt->guest_page.gfn, sub_spt->shadow_page.type);
+	ppgtt_free_spt(sub_spt);
+	return ret;
 }
 
 static int split_64KB_gtt_entry(struct intel_vgpu *vgpu,
-- 
2.25.1

