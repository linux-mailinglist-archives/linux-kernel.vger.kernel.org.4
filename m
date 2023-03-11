Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B16B56B3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjCKA0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCKAY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:24:58 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF083C78C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:24:04 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p9-20020a17090a930900b00237a7f862dfso5054384pjo.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SrFDAuRQYSdVAaKU/q0bsjDCV6a1lvsfWXmA+4AWzfU=;
        b=e4d4/rxV1Zgd2/D2y/bvvJYmV3VmIQ2B+veoJmhzc1zL/Ok45X7QCHORoet2h5BRER
         OvyYYPlh+KjYyFnv51fNVwfqcSMtD3WCJ3Dqeqpl8zagOMT++Eucp+7VKyux3vDcum/n
         u9VknqIpRRzz39zajw9cxBkBioWmO1SWPo2U1WH/VlF4FCggvbOg5jwd9GdtQN3D8cqC
         W0uG+lHUt7Mn55Zg9Xqf5SpsPLYT4yMyWxbEUOBF9UBxuJPXodDGsYKKGfKZHMDtKzMP
         2bN5l34k5e0hHNkV4u1rXG+4w/2uckITEagP6WXSw7O+XpcZrmBXZmwNn3YKoGEGngXh
         8FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrFDAuRQYSdVAaKU/q0bsjDCV6a1lvsfWXmA+4AWzfU=;
        b=XjQoBsPwE347MJVHpMiaP3vIBKeeC/ZZ28wWNdDcV3ogxi9PB6M2cCQjPZcf/Youvl
         GbLeJtUpamhfvL0i6WowhjIjcbnLbUZRxfQfPcN1qkM5UFuFQx8fp9bHVkjM2W0CC1UC
         bv9rKkSFbwC+tL31nFkXAt3IAPpXCsvTGL0o8YmCv6T7zYCm1R3youJupcOwvffZn2xr
         4Eb7a8SM7yV2cp3OLpw5jwsNLxQrGr6RXzjvl0kZKf0I4YL3yTQ77QKFvEePA1tFXk/B
         nxt1TB8Vf9bMaeC1HJ7d3FBzkVd9jpBbpvh+lVluTDmh/TiacC0/Fif+EzenOSNIxkEP
         GU0Q==
X-Gm-Message-State: AO0yUKX/l/suS0EpfwESjsQRiVXqv36OxzdINEwTw985Ln5Y/evIc5a+
        xCfS8NqfHoJuP4D80p51wuDF8/bLOq8=
X-Google-Smtp-Source: AK7set9BOLwk0C6I6vnhUGAunlnaX/wB1YqK0ADUomrGZYyzsFfITpGsZimZf1dbvl+kuQhlqQKywNF53cc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:334f:b0:19f:22aa:692e with SMTP id
 ka15-20020a170903334f00b0019f22aa692emr312103plb.4.1678494231283; Fri, 10 Mar
 2023 16:23:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:55 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-25-seanjc@google.com>
Subject: [PATCH v2 24/27] KVM: x86/mmu: Bug the VM if write-tracking is used
 but not enabled
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

Bug the VM if something attempts to write-track a gfn, but write-tracking
isn't enabled.  The VM is doomed (and KVM has an egregious bug) if KVM or
KVMGT wants to shadow guest page tables but can't because write-tracking
isn't enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/page_track.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index ffcd7ac66f9e..327e73be62d6 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -90,7 +90,7 @@ void kvm_write_track_add_gfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	lockdep_assert_once(lockdep_is_held(&kvm->slots_lock) ||
 			    srcu_read_lock_held(&kvm->srcu));
 
-	if (WARN_ON(!kvm_page_track_write_tracking_enabled(kvm)))
+	if (KVM_BUG_ON(!kvm_page_track_write_tracking_enabled(kvm), kvm))
 		return;
 
 	update_gfn_write_track(slot, gfn, 1);
@@ -122,7 +122,7 @@ void kvm_write_track_remove_gfn(struct kvm *kvm,
 	lockdep_assert_once(lockdep_is_held(&kvm->slots_lock) ||
 			    srcu_read_lock_held(&kvm->srcu));
 
-	if (WARN_ON(!kvm_page_track_write_tracking_enabled(kvm)))
+	if (KVM_BUG_ON(!kvm_page_track_write_tracking_enabled(kvm), kvm))
 		return;
 
 	update_gfn_write_track(slot, gfn, -1);
-- 
2.40.0.rc1.284.g88254d51c5-goog

