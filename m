Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F256B569E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCKAYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjCKAYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:24:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A318CC4885
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t25-20020a252d19000000b00b341ad1b626so1512438ybt.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mbfokw6SfssUbU6cRB8EBVuRgsuGh3GvzrnTHWP4v/w=;
        b=L+aPyQ9eudQKqhuQmVhN78/Im8AKZDgw5zsVXO6h59EZ+tE2ci0NZC1fR42hBuBC5U
         jz/TIRY7hm98RuznxZdktcTuzYmihP5FVoky+f1Z8KvuM2vPWllzHD3UqlbDhV5qPHHl
         K6dpxv3FaVZz2McBCBpsOP4oR/X9iw6/UeVysx0E+Km1CDXR5ZlDJo5wxAfuzXFdV+XA
         FBDhZeVUhSLRyacD1Kr5BRnlYrxZ1kd2l+2TqrSKeQ2HwO0xpHRMLTajtmRuuXlhfaA7
         t+VVXVGX6RZywNa33DcPA34DDD+vAO7xrBY6gsG5sPUka77r+y0WJ0QMXQ/ao7kfoWB/
         1bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbfokw6SfssUbU6cRB8EBVuRgsuGh3GvzrnTHWP4v/w=;
        b=NsUy7miMb8G01iDpNNq5qhesGzrifaKchofVl1yVp4LL/Pt/03EcBOOCVVCe39DWYB
         ADVXOB7ho1AdOiGmvVEeA5Jp1agvrYWe1ATgiiFM9tHfveveV9oDMYSKskduqDdcNghS
         9Izb+NPaJCS/ItMAKgUg473UuooAFmFv2VLkWhiB2nlTP7MZS35R6UrX+P8xAWKmSc7f
         JjSaymUo2w2YXZ1ZhQWVYMZZPi7WSj0w20zY2fhNageHC4yUJQo6hOHzHS4KLNRfiA6F
         C/LDXQ5XC9l//nGZdqShZ7t3a5DFbFabP3LQsSzIzkk+80DKaPOTvJ6oxZEftdFYaGVE
         nO0w==
X-Gm-Message-State: AO0yUKVTu3v+r5xMG9spsYqChTwVsNIs9v0VGWX6esM/Z9+rBtGFf1gN
        RNBt7/ZHIWNxyFLdPbT6JYegCkmq0vU=
X-Google-Smtp-Source: AK7set+7rYCP+XNSH5GJISmhmRLApRaRlrDHIoQoq/cUevBD2kV2PyuUC3KwpF5yVh9RU2o80SoVitZ/HLo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:2cc:0:b0:a02:a3a6:78fa with SMTP id
 h12-20020a5b02cc000000b00a02a3a678famr13313899ybp.12.1678494210465; Fri, 10
 Mar 2023 16:23:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:44 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-14-seanjc@google.com>
Subject: [PATCH v2 13/27] KVM: drm/i915/gvt: Drop @vcpu from KVM's
 ->track_write() hook
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

Drop @vcpu from KVM's ->track_write() hook provided for external users of
the page-track APIs now that KVM itself doesn't use the page-track
mechanism.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_page_track.h |  5 ++---
 arch/x86/kvm/mmu/page_track.c         |  2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c      | 10 ++++------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 3f72c7a172fc..0d65ae203fd6 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -26,14 +26,13 @@ struct kvm_page_track_notifier_node {
 	 * It is called when guest is writing the write-tracked page
 	 * and write emulation is finished at that time.
 	 *
-	 * @vcpu: the vcpu where the write access happened.
 	 * @gpa: the physical address written by guest.
 	 * @new: the data was written to the address.
 	 * @bytes: the written length.
 	 * @node: this node
 	 */
-	void (*track_write)(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
-			    int bytes, struct kvm_page_track_notifier_node *node);
+	void (*track_write)(gpa_t gpa, const u8 *new, int bytes,
+			    struct kvm_page_track_notifier_node *node);
 	/*
 	 * It is called when memory slot is being moved or removed
 	 * users can drop write-protection for the pages in that memory slot
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index f39f190ad4ae..39a0863af8b4 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -272,7 +272,7 @@ void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 	hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
 				srcu_read_lock_held(&head->track_srcu))
 		if (n->track_write)
-			n->track_write(vcpu, gpa, new, bytes, n);
+			n->track_write(gpa, new, bytes, n);
 	srcu_read_unlock(&head->track_srcu, idx);
 
 	kvm_mmu_track_write(vcpu, gpa, new, bytes);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 9824d075562e..292750dc819f 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -106,9 +106,8 @@ struct gvt_dma {
 #define vfio_dev_to_vgpu(vfio_dev) \
 	container_of((vfio_dev), struct intel_vgpu, vfio_device)
 
-static void kvmgt_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa,
-		const u8 *val, int len,
-		struct kvm_page_track_notifier_node *node);
+static void kvmgt_page_track_write(gpa_t gpa, const u8 *val, int len,
+				   struct kvm_page_track_notifier_node *node);
 static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		struct kvm_page_track_notifier_node *node);
@@ -1617,9 +1616,8 @@ int intel_gvt_page_track_remove(struct intel_vgpu *info, u64 gfn)
 	return 0;
 }
 
-static void kvmgt_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa,
-		const u8 *val, int len,
-		struct kvm_page_track_notifier_node *node)
+static void kvmgt_page_track_write(gpa_t gpa, const u8 *val, int len,
+				   struct kvm_page_track_notifier_node *node)
 {
 	struct intel_vgpu *info =
 		container_of(node, struct intel_vgpu, track_node);
-- 
2.40.0.rc1.284.g88254d51c5-goog

