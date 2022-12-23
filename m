Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E9654A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 02:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiLWBAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 20:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiLWA70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:59:26 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EFF30F6D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:21 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id y186-20020a638ac3000000b004932d1b6885so1905543pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rKCW8m8IAHoIRlubB2TYcWLgdcBH42t3bfi5TuBdz08=;
        b=h9aMawpy9BBBaLOtJV17IMJCudTgWyQsradbxq24d9j0tXeeNHTbfFvAizPtxlAKK2
         yzYhnZ7sAPDfr8hApkk5FKvdqiYvRbqI4EPACiWF3Lthmi9fcUsINEAgR5NE2Rn0UYot
         mcq8G+GbgcpUH1mH0yBxHISJ5hAemaGExIUWBy0+CPIi8IY9jnx1RgyPZ4AKL3V1k6Ej
         A/a1i1OR1h52x76FPdDPGFrashJy4LswSqDS53/YkQYWeyfsP9V/DyQBaIVlXq7VrR0l
         Od0sRkGnnafTiHbuZVFzL8KNNmnOwIdnbxzZMw6TufSAI3L0VUideimQ2i5jjuUNPoU1
         zu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKCW8m8IAHoIRlubB2TYcWLgdcBH42t3bfi5TuBdz08=;
        b=Qc14lHc+v9QC+P8A/CfZG4BDW2yrXLhMMM+xtHeBU2SxPliIui7AKoP/Nonxk0YKpP
         SHv/Zsb4l6sTbCng8IZcpqABUuJTExd2Typd7h9wNN+8FeX7sNhyMJneUDnHPCztLlJl
         nfeeh8j1bTsvQkrk7jSpJTC8HKNFO6kGFSsCV3ufXJjxIDpgV7depdSUriu6a2N5YxoI
         92VerCYfEiWgGVY2eA005Y/1mkr3oxekKyY6W34eq3RmdGoTHaIiseuPbB8+/hxQpBxl
         1Ml9phx6bXMpj2oIJLyvLaXyteUiTOvf/qMdtzRAtLQcF1vbV1sggW+rETU8nGerQhJO
         hNFg==
X-Gm-Message-State: AFqh2koPpGPMfK2JetCB9wHmJr0w9mKOk9x6dfWZt2hFHSCvBLruPWTe
        VV1UHo7gnHVhk4ACb73wORtZERxz7m0=
X-Google-Smtp-Source: AMrXdXusrG5wCodfdwxI7qje0UNrTbPqLuDOsUiG9EVI28zgf+jPQnw6lBq7jCHkYuAfiJD8F+h684U1/h0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:a006:b0:21d:203f:a306 with SMTP id
 q6-20020a17090aa00600b0021d203fa306mr598567pjp.148.1671757092679; Thu, 22 Dec
 2022 16:58:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:28 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-17-seanjc@google.com>
Subject: [PATCH 16/27] drm/i915/gvt: switch from ->track_flush_slot() to ->track_remove_region()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

Switch from the poorly named and flawed ->track_flush_slot() to the newly
introduced ->track_remove_region().  From KVMGT's perspective, the two
hooks are functionally equivalent, the only difference being that
->track_remove_region() is called only when KVM is 100% certain the
memory region will be removed, i.e. is invoked slightly later in KVM's
memslot modification flow.

Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
[sean: handle name change, massage changelog, rebase]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 3c59e7cd75d9..9f251bc00a7e 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -108,9 +108,8 @@ struct gvt_dma {
 
 static void kvmgt_page_track_write(gpa_t gpa, const u8 *val, int len,
 				   struct kvm_page_track_notifier_node *node);
-static void kvmgt_page_track_flush_slot(struct kvm *kvm,
-		struct kvm_memory_slot *slot,
-		struct kvm_page_track_notifier_node *node);
+static void kvmgt_page_track_remove_region(gfn_t gfn, unsigned long nr_pages,
+					   struct kvm_page_track_notifier_node *node);
 
 static ssize_t intel_vgpu_show_description(struct mdev_type *mtype, char *buf)
 {
@@ -690,7 +689,7 @@ static int intel_vgpu_open_device(struct vfio_device *vfio_dev)
 	gvt_cache_init(vgpu);
 
 	vgpu->track_node.track_write = kvmgt_page_track_write;
-	vgpu->track_node.track_flush_slot = kvmgt_page_track_flush_slot;
+	vgpu->track_node.track_remove_region = kvmgt_page_track_remove_region;
 	kvm_get_kvm(vgpu->vfio_device.kvm);
 	kvm_page_track_register_notifier(vgpu->vfio_device.kvm,
 					 &vgpu->track_node);
@@ -1647,20 +1646,17 @@ static void kvmgt_page_track_write(gpa_t gpa, const u8 *val, int len,
 	mutex_unlock(&info->vgpu_lock);
 }
 
-static void kvmgt_page_track_flush_slot(struct kvm *kvm,
-		struct kvm_memory_slot *slot,
-		struct kvm_page_track_notifier_node *node)
+static void kvmgt_page_track_remove_region(gfn_t gfn, unsigned long nr_pages,
+					   struct kvm_page_track_notifier_node *node)
 {
 	unsigned long i;
-	gfn_t gfn;
 	struct intel_vgpu *info =
 		container_of(node, struct intel_vgpu, track_node);
 
 	mutex_lock(&info->gfn_lock);
-	for (i = 0; i < slot->npages; i++) {
-		gfn = slot->base_gfn + i;
-		if (kvmgt_gfn_is_write_protected(info, gfn))
-			kvmgt_protect_table_del(info, gfn);
+	for (i = 0; i < nr_pages; i++) {
+		if (kvmgt_gfn_is_write_protected(info, gfn + i))
+			kvmgt_protect_table_del(info, gfn + i);
 	}
 	mutex_unlock(&info->gfn_lock);
 }
-- 
2.39.0.314.g84b9a713c41-goog

