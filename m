Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72B654A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 02:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiLWBA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 20:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiLWA7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:59:49 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4931DCB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:30 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h88-20020a17090a29e100b00223f501b046so1820905pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E5mEvk7mhTbLTbI71CnckeUYfBuaX+0urxAADq0bdpk=;
        b=H4aiigdAaqzzU7IYxEhnMpAq+LO60LbHzZkIUHopuBtbH6R08DMSSogGhi16I6aE+4
         rBYIQ2VLojy92J2PjyPZiHasqVnT0Ui5kZCWTATNP1Cul9XqKd/nszUe4q3i+a4O0uNF
         bQZebRaR8FAgQDfzR6SWs/it4PXf9aFISvcDfu7stvlvsBejgW/qGrDacC5uvcsaP05G
         NzSEC5gIE0jjBIqUWtHqUP1Xyc9t0AIcTg6eWJlbLxpb0SMx/Yww3bYWtSkzpxW/rR/F
         c6ZwXZP4ooTQfKR+K5Oxmg1twSznhUSZNuMCeAD4BqJs9cvQednvW2HhTkFitU22C50d
         f7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5mEvk7mhTbLTbI71CnckeUYfBuaX+0urxAADq0bdpk=;
        b=Wn1KFo+XEzXQhlDXN2cphyyFnYmWc1QAYVndtrJucAl0KlcA9UjiXFo/7wB06LsfG/
         szGstMhlkOmbyWz1I3K30mfitZqc6d3uYAaemaRaQFRvVFLGFxQEEtfo7J5DAJduXJMY
         OawpKRvOY7SyV+MGPoZxayr/NbYCbOf30ljtC0n1d6W9nVWV4MjSpR4ytjePhCOdRdLQ
         L9IEKBgJT01Wr3kHaThOd+4ZGCNCWU71+EVuHwA4MV65xp2D+aP/AfFEM7nhMa39ws/D
         D2YI8M0/U93LePXMBs/aAJCalNYHkZJ2Q2s/9wPxclaByD7DXaOyFoFRPJYC19wGii42
         Px5A==
X-Gm-Message-State: AFqh2kryuphCYBFKsvaF4ejOwdPdk6+HJRw9S4kLCViIpaT5FIElQ+Vo
        T8BO+a2G7pFEMMTJMsuuUg+B/rJyrPY=
X-Google-Smtp-Source: AMrXdXsumktbf9ORj6WvpRUFhzGjzygFSn5YpEseKjoNgVCVrMAzWGMwc4HsbeZ8JZZkARlRq26lxPKoLnE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:701:b0:219:1d0a:34a6 with SMTP id
 s1-20020a17090b070100b002191d0a34a6mr180831pjz.1.1671757109874; Thu, 22 Dec
 2022 16:58:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:38 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-27-seanjc@google.com>
Subject: [PATCH 26/27] KVM: x86/mmu: Add page-track API to query if a gfn is valid
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a page-track API to query if a gfn is "valid", i.e. is backed by a
memslot and is visible to the guest.  This is one more step toward
removing KVM internal details from the page-track APIs.

Add a FIXME to call out that intel_gvt_is_valid_gfn() is broken with
respect to 2MiB (or larger) guest entries, e.g. if the starting gfn is
valid but a 2MiB page starting at the gfn covers "invalid" memory due
to running beyond the memslot.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_page_track.h |  1 +
 arch/x86/kvm/mmu/page_track.c         | 13 +++++++++++++
 drivers/gpu/drm/i915/gvt/gtt.c        | 11 ++---------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 66a0d7c34311..99e1d6eeb0fb 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -52,6 +52,7 @@ int kvm_page_track_register_notifier(struct kvm *kvm,
 void kvm_page_track_unregister_notifier(struct kvm *kvm,
 					struct kvm_page_track_notifier_node *n);
 
+bool kvm_page_track_is_valid_gfn(struct kvm *kvm, gfn_t gfn);
 int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn);
 int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn);
 #endif /* CONFIG_KVM_EXTERNAL_WRITE_TRACKING */
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 1af431a41f71..9da071a514b3 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -264,6 +264,19 @@ enum pg_level kvm_page_track_max_mapping_level(struct kvm *kvm, gfn_t gfn,
 }
 EXPORT_SYMBOL_GPL(kvm_page_track_max_mapping_level);
 
+bool kvm_page_track_is_valid_gfn(struct kvm *kvm, gfn_t gfn)
+{
+	bool ret;
+	int idx;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	ret = kvm_is_visible_gfn(kvm, gfn);
+	srcu_read_unlock(&kvm->srcu, idx);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvm_page_track_is_valid_gfn);
+
 /*
  * add guest page to the tracking pool so that corresponding access on that
  * page will be intercepted.
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 59ba6639e622..43c4fc23205d 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -51,18 +51,11 @@ static int preallocated_oos_pages = 8192;
 
 static bool intel_gvt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
 {
-	struct kvm *kvm = vgpu->vfio_device.kvm;
-	int idx;
-	bool ret;
-
 	if (!vgpu->attached)
 		return false;
 
-	idx = srcu_read_lock(&kvm->srcu);
-	ret = kvm_is_visible_gfn(kvm, gfn);
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	return ret;
+	/* FIXME: This doesn't properly handle guest entries larger than 4K. */
+	return kvm_page_track_is_valid_gfn(vgpu->vfio_device.kvm, gfn);
 }
 
 /*
-- 
2.39.0.314.g84b9a713c41-goog

