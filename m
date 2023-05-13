Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629AA70130F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbjEMAgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbjEMAgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:36:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D84EFE
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba71ed074ceso6092697276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683938169; x=1686530169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ToNhdo1X9I43R+AkpmrkOQ51isY/Fj9++DlXC8u7pbQ=;
        b=IS3JsUH8tRbdcY5k9AcSM1Uzi3ClVKg3/HDbY64whyrqK1VrgVVoY6ZVmLp1s+0FCS
         gdx4SxuHZx8Q7rOW/fOeybjrwOpZzSwRAtqsBROAq1/TF3Xa3t+LMEkdc6H2OpbdNGWB
         TVEhwz5EvB7mETrwHIrJurRjOfGPYIaP1UrAnw95CviGKnDsfv7vt5vNSUb1sPKVCFpK
         kvNMTHalP1S+M+k1VY7zpoAhko8jc95wa0bMShfyUPOVyMnYtDaR+vBh06KLzDWhvXT+
         AyImJ5yRGlCIatXFYhUrVXe8BS6WBb5k+oJMZ0PAJlmHOYseUstCCNB2xuba4djE1jnI
         /nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683938169; x=1686530169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToNhdo1X9I43R+AkpmrkOQ51isY/Fj9++DlXC8u7pbQ=;
        b=R5mzw6C4dFwswgBRG2Z87/kJMPJvR3gwe2qnzsOvXESu9V1+72jz4O6SYMUCuJ5Y4O
         7oYLFsHXG4v1Uu5DbADI+fdneu8vQb9Kj9SLNLYhg2Ome/jNmRLCmJMsx8mRokgdxRM0
         3XtLDTsu0+2++f6CnGSRuizZfAr7ZjQIRXHrDgKukxmBN0nk0f+JYzuY5OwZwRWCO2FZ
         Aae02BL+vumqhCIVLidyf4UJPYDU0Un2CF0ZKIT64nfsD4e1dYnAfvTh4AU5fNuV1eqK
         uEPmRufediszyGXfwx/RA8rP3RPEgYElGsyahedJV3KP6QQd1n2jyc4IQVFHt698DZVp
         F2lA==
X-Gm-Message-State: AC+VfDwG97f4AQy5eI1nDtJ3eTqw8kS4YYugrOR8bTHKNJm+SQ1v4Qk/
        sw+L7RRvHO086uE2erogejtL0sWRh6c=
X-Google-Smtp-Source: ACHHUZ7tiaWA+zTl2Jv9E6tzir28YjmHh2gwoRHK6r9OoVuzqdU4HhixDtSApxkSsS7YFw9bs7RUVPDmnEU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:5b85:0:b0:ba2:9865:54 with SMTP id
 p127-20020a255b85000000b00ba298650054mr12251026ybb.3.1683938169678; Fri, 12
 May 2023 17:36:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 17:35:34 -0700
In-Reply-To: <20230513003600.818142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230513003600.818142-3-seanjc@google.com>
Subject: [PATCH v3 02/28] drm/i915/gvt: remove interface intel_gvt_is_valid_gfn
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

Currently intel_gvt_is_valid_gfn() is called in two places:
(1) shadowing guest GGTT entry
(2) shadowing guest PPGTT leaf entry,
which was introduced in commit cc753fbe1ac4
("drm/i915/gvt: validate gfn before set shadow page entry").

However, now it's not necessary to call this interface any more, because
a. GGTT partial write issue has been fixed by
   commit bc0686ff5fad
   ("drm/i915/gvt: support inconsecutive partial gtt entry write")
   commit 510fe10b6180
   ("drm/i915/gvt: fix a bug of partially write ggtt enties")
b. PPGTT resides in normal guest RAM and we only treat 8-byte writes
   as valid page table writes. Any invalid GPA found is regarded as
   an error, either due to guest misbehavior/attack or bug in host
   shadow code.
   So,rather than do GFN pre-checking and replace invalid GFNs with
   scratch GFN and continue silently, just remove the pre-checking and
   abort PPGTT shadowing on error detected.
c. GFN validity check is still performed in
   intel_gvt_dma_map_guest_page() --> gvt_pin_guest_page().
   It's more desirable to call VFIO interface to do both validity check
   and mapping.
   Calling intel_gvt_is_valid_gfn() to do GFN validity check from KVM side
   while later mapping the GFN through VFIO interface is unnecessarily
   fragile and confusing for unaware readers.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
[sean: remove now-unused local variables]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 36 +---------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 58b9b316ae46..f30922c55a0c 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -49,22 +49,6 @@
 static bool enable_out_of_sync = false;
 static int preallocated_oos_pages = 8192;
 
-static bool intel_gvt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
-{
-	struct kvm *kvm = vgpu->vfio_device.kvm;
-	int idx;
-	bool ret;
-
-	if (!test_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status))
-		return false;
-
-	idx = srcu_read_lock(&kvm->srcu);
-	ret = kvm_is_visible_gfn(kvm, gfn);
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	return ret;
-}
-
 /*
  * validate a gm address and related range size,
  * translate it to host gm address
@@ -1333,11 +1317,9 @@ static int ppgtt_populate_shadow_entry(struct intel_vgpu *vgpu,
 static int ppgtt_populate_spt(struct intel_vgpu_ppgtt_spt *spt)
 {
 	struct intel_vgpu *vgpu = spt->vgpu;
-	struct intel_gvt *gvt = vgpu->gvt;
-	const struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
 	struct intel_vgpu_ppgtt_spt *s;
 	struct intel_gvt_gtt_entry se, ge;
-	unsigned long gfn, i;
+	unsigned long i;
 	int ret;
 
 	trace_spt_change(spt->vgpu->id, "born", spt,
@@ -1354,13 +1336,6 @@ static int ppgtt_populate_spt(struct intel_vgpu_ppgtt_spt *spt)
 			ppgtt_generate_shadow_entry(&se, s, &ge);
 			ppgtt_set_shadow_entry(spt, &se, i);
 		} else {
-			gfn = ops->get_pfn(&ge);
-			if (!intel_gvt_is_valid_gfn(vgpu, gfn)) {
-				ops->set_pfn(&se, gvt->gtt.scratch_mfn);
-				ppgtt_set_shadow_entry(spt, &se, i);
-				continue;
-			}
-
 			ret = ppgtt_populate_shadow_entry(vgpu, spt, i, &ge);
 			if (ret)
 				goto fail;
@@ -2335,14 +2310,6 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 		m.val64 = e.val64;
 		m.type = e.type;
 
-		/* one PTE update may be issued in multiple writes and the
-		 * first write may not construct a valid gfn
-		 */
-		if (!intel_gvt_is_valid_gfn(vgpu, gfn)) {
-			ops->set_pfn(&m, gvt->gtt.scratch_mfn);
-			goto out;
-		}
-
 		ret = intel_gvt_dma_map_guest_page(vgpu, gfn, PAGE_SIZE,
 						   &dma_addr);
 		if (ret) {
@@ -2359,7 +2326,6 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 		ops->clear_present(&m);
 	}
 
-out:
 	ggtt_set_guest_entry(ggtt_mm, &e, g_gtt_index);
 
 	ggtt_get_host_entry(ggtt_mm, &e, g_gtt_index);
-- 
2.40.1.606.ga4b1b128d6-goog

