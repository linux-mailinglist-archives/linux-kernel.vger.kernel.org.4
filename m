Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989A1654A47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 02:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiLWBAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 20:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiLWA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:59:47 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FDA24F11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:27 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d2-20020a170902cec200b001899479b1d8so2397888plg.22
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=B3/6HakM8bEsRSpLUSLtN60b55NBVvdxdMcoYovzhTY=;
        b=A58qocwqTx05B2FmPj8edb5Jmqh2KY526wyAjjih8PFgDTeJUoUodgN252cOLS3nXI
         2g5SIoFRZBSR3ULbZM+/hEJBPAZTzB6do/IjoPOTMKPqwzDQsqAef6BRNPdYv7EyEUy5
         GyGJN7L5R5tDhwDSb4b7o65LOH2L914IhnkGhIlWDwPCt1H1SPwD3Po1gc+VNauUEBbE
         DLZv7aX0CyGBqUeVUCyM8GjZE/eEr9qXjKyeFmN/ttMWihF2QuPx7KgDA9uLVtHB7DJP
         AIdSfLY8HT/0Mw4Ia9UGCChjF96hnYTstI2Dxp6P4lORb7XM9+FTAqegNDEtRcCCzK+X
         wnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3/6HakM8bEsRSpLUSLtN60b55NBVvdxdMcoYovzhTY=;
        b=LfBmtJTx/Y3nv3jDN135K6ppB+m7JWScLz8i+YgCMZn3Savo46riaYtDH4lgdM55Ze
         45wqBbkMd2N9ZWFG/J5pNnKjycg54fPJ/pv2yr+bwcUwLsfpMBKwn+E4IVB9pa2SH2tK
         ZrVdoa/Hv1/We5NOddPTg5Tiry+MUAJAP8MHe4aFwf5pHAqQi9t9QSh7hrd53m/WBTKS
         VZpgXF0lgv6QPpw/jP8eCcOyfyoFAiv45Ky76AXbZUFNg5jy9AJ8+7lGS7nYWadB1kEC
         FqfLyYerhseS7AvGRg+NV3KiLq59dbnGdpynmydcOLmqnFr0G7J4+UMi5LWG1F2a4KxF
         RuVA==
X-Gm-Message-State: AFqh2kptxAwfg1lG0KVqZJreUfz/LNUtpUjFCsoUxS0HZf7ZsrshdJ2s
        NwSO2xD+lmlhL0/V4pMLrdSJUC2bWYE=
X-Google-Smtp-Source: AMrXdXskxY09HMUv4ylJiwceP/1EuN1X8FenwLyi4ei9/D0xFfMtbr3o/pBLoAlAklnmhUths4WH9DqVUk0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:164c:b0:575:b4c0:f664 with SMTP id
 m12-20020a056a00164c00b00575b4c0f664mr500069pfc.56.1671757103078; Thu, 22 Dec
 2022 16:58:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:34 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-23-seanjc@google.com>
Subject: [PATCH 22/27] KVM: x86/mmu: Assert that correct locks are held for
 page write-tracking
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

When adding/removing gfns to/from write-tracking, assert that mmu_lock
is held for write, and that either slots_lock or kvm->srcu is held.
mmu_lock must be held for write to protect gfn_write_track's refcount,
and SRCU or slots_lock must be held to protect the memslot itself.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/page_track.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 1eb516119fdb..209f6beba5ac 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -11,6 +11,7 @@
  *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
  */
 
+#include <linux/lockdep.h>
 #include <linux/kvm_host.h>
 #include <linux/rculist.h>
 
@@ -76,9 +77,6 @@ static void update_gfn_write_track(struct kvm_memory_slot *slot, gfn_t gfn,
  * add guest page to the tracking pool so that corresponding access on that
  * page will be intercepted.
  *
- * It should be called under the protection both of mmu-lock and kvm->srcu
- * or kvm->slots_lock.
- *
  * @kvm: the guest instance we are interested in.
  * @slot: the @gfn belongs to.
  * @gfn: the guest page.
@@ -86,6 +84,11 @@ static void update_gfn_write_track(struct kvm_memory_slot *slot, gfn_t gfn,
 void kvm_write_track_add_gfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 			     gfn_t gfn)
 {
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	lockdep_assert_once(lockdep_is_held(&kvm->slots_lock) ||
+			    srcu_read_lock_held(&kvm->srcu));
+
 	if (WARN_ON(!kvm_page_track_write_tracking_enabled(kvm)))
 		return;
 
@@ -106,9 +109,6 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
  * remove the guest page from the tracking pool which stops the interception
  * of corresponding access on that page.
  *
- * It should be called under the protection both of mmu-lock and kvm->srcu
- * or kvm->slots_lock.
- *
  * @kvm: the guest instance we are interested in.
  * @slot: the @gfn belongs to.
  * @gfn: the guest page.
@@ -116,6 +116,11 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
 void kvm_write_track_remove_gfn(struct kvm *kvm,
 				struct kvm_memory_slot *slot, gfn_t gfn)
 {
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	lockdep_assert_once(lockdep_is_held(&kvm->slots_lock) ||
+			    srcu_read_lock_held(&kvm->srcu));
+
 	if (WARN_ON(!kvm_page_track_write_tracking_enabled(kvm)))
 		return;
 
-- 
2.39.0.314.g84b9a713c41-goog

