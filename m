Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A94701370
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbjEMAiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbjEMAiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:38:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34B5FCD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:37:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba2d0b391d3so15107503276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683938211; x=1686530211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=d+sFY9wdlYEr+BsMeb/f8vTRCaTs7vfifkJ4zvl7LGw=;
        b=64N8psPjCU8NCbfgAoPhVHhIo35afPxNCSfUEDPc6JEFhfmjZIqhvtqtCxju3ayooD
         rLtO6OgYd01HPHrZnVMraPg/wvIulWsNrZaYYd3Q2cuVPa4BEcmEV3mEsul3XrhRjsp+
         aJ3JMXVJz3CR+BKQBzSr5PUTPuq5LMv/qpzFT9AXutEQGIhFf59wMsyaAHBpLpysfc/Q
         5h8AgBMeBJE20odwJFjCXSKGq2qIWtRbb+o7daVN32UhhZQwjWvMckTBuPmrfJMgaGYa
         tWHBeWXd1xseZCzWjFZKA19DhbXGNxq1i3PG7V0P1+RQ2Cbwc2JaOc8fDwY7PDd1c0r8
         ZJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683938211; x=1686530211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+sFY9wdlYEr+BsMeb/f8vTRCaTs7vfifkJ4zvl7LGw=;
        b=DyFobEwTk4saSxXY/YMxcjJxzEQDWKwzdUZSz7kNUL5QInrIJBBZEm14gQc7C1ZbkH
         RyTgwKhdC5u8IXNZ26Nv/xnmtC0YQT4fafpYeWdlhWhnFHeC11PK3sy6t2q0sJf0emgq
         TwFfz+XqGp6+t6IpkDdEwLWohD4oo8K2Zu5d1XXnKmKhOOY7biQgg7h2staVzyDaunuN
         HQe95QvRsijfvMR5pQqrrRtOo8vLmrFf3wjzdjR4xy+uOMdZsc2p1mkRWrih/9JKrxEa
         i2JqbltRUG0IXt76JkKOeuiBPUtkYLxl3TWZ4nQBONiSUWMjIqFNc/LgESqJc9RVBio1
         cIJA==
X-Gm-Message-State: AC+VfDzQlAqmPuzQgX9U0pO6ltOIQ4W8BGMw3IpDatTjkdpvc3U2CwJ+
        k0H5Fo16YMAQ2BRjk5WrBSCBu/LxFu4=
X-Google-Smtp-Source: ACHHUZ5zdcnj/hq68r0lrjsegbj6c4YZMheMUdNtJ3k1/upYeQmR6HdFpgZIKNg6Oz6JUMAbVtXPBMF+WH4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1241:0:b0:ba6:3890:3e55 with SMTP id
 62-20020a251241000000b00ba638903e55mr6939739ybs.2.1683938211420; Fri, 12 May
 2023 17:36:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 17:35:56 -0700
In-Reply-To: <20230513003600.818142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230513003600.818142-25-seanjc@google.com>
Subject: [PATCH v3 24/28] KVM: x86/mmu: Assert that correct locks are held for
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding/removing gfns to/from write-tracking, assert that mmu_lock
is held for write, and that either slots_lock or kvm->srcu is held.
mmu_lock must be held for write to protect gfn_write_track's refcount,
and SRCU or slots_lock must be held to protect the memslot itself.

Tested-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/page_track.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index b835ba7f325c..29ae61f1e303 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -12,6 +12,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/lockdep.h>
 #include <linux/kvm_host.h>
 #include <linux/rculist.h>
 
@@ -77,9 +78,6 @@ static void update_gfn_write_track(struct kvm_memory_slot *slot, gfn_t gfn,
  * add guest page to the tracking pool so that corresponding access on that
  * page will be intercepted.
  *
- * It should be called under the protection both of mmu-lock and kvm->srcu
- * or kvm->slots_lock.
- *
  * @kvm: the guest instance we are interested in.
  * @slot: the @gfn belongs to.
  * @gfn: the guest page.
@@ -87,6 +85,11 @@ static void update_gfn_write_track(struct kvm_memory_slot *slot, gfn_t gfn,
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
 
@@ -107,9 +110,6 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
  * remove the guest page from the tracking pool which stops the interception
  * of corresponding access on that page.
  *
- * It should be called under the protection both of mmu-lock and kvm->srcu
- * or kvm->slots_lock.
- *
  * @kvm: the guest instance we are interested in.
  * @slot: the @gfn belongs to.
  * @gfn: the guest page.
@@ -117,6 +117,11 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
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
2.40.1.606.ga4b1b128d6-goog

