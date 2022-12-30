Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA6654A36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiLWA7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiLWA7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:59:04 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DD430567
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3dfb9d11141so36794347b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tTYp657RV3f6OWCBTwP1Ico5ltwPOdlqPIOy28hvvc8=;
        b=TgKSelY3BZKddDJU33MkrreJCxryFlBA+1WmAEgJzpPyAUxDUEhSub/jTCmikK4WcV
         S5gkndGcULbcRzKEMYVP5FQqOMgtFcXZLFheV+XOIgin5X6tEAeAM6bQWvKP7yZVF9Ry
         Xm9XwgbMxSPSTo2ZEyqi3wKJSnTkVqJLNFNBByHuMXRfCYj4P0iRSzORpBkGrEARBLgv
         vTn/3CekNTKCoEREFqyU2mBlrLUxs0YubhczF2l/VEeBhIYKKV4aBLpJARke1/Bc7Rw7
         alQePw2Tz6Tw/mmaj9vPzdaY29kc2hOJExw9SkLOIRG0bJD18lS8p3TbLDoTY6HW2nWP
         +JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTYp657RV3f6OWCBTwP1Ico5ltwPOdlqPIOy28hvvc8=;
        b=dbJWJDE751IZgK9SPpg4uPVeMfd934wt9urpT+mF8fkdkEmUPxe4GBkXjbcgxMOv/x
         0MHKqEy6nrHmzdUOUxffVJTzALe8y46CBGoPoc69QB3LeltKIgmWzfjEBRrr/rAytedU
         mlrXFz/2iRWX6mQvxLNby94njWJ6yqmXF4eaUMMZfY6Lf6J3T5l0FtUHx4HYwg3Ucjp/
         qvUbLOkJTjVUuoAzBVWfZNh54cnyseJ4YoRDCDqJghToGHjOrhbMTtFANei6jSXSAxof
         5ygH2IGSCz8Zb/RpJavZ6EOU/jBtIv3Mq0D4d7+L2N0rOphHr8Bd20lbH4odUW6e3SSC
         NjQQ==
X-Gm-Message-State: AFqh2kqyO91T1R1L7Qrk6Iqm68TDbttnJnhMUhSD39PWv1AaMRRkZyxr
        TuklOkTfEwyy6HxpaHKZ8OsMSOBM7YE=
X-Google-Smtp-Source: AMrXdXtk0haqZ9uKo/Anv4Tarco7/FhQRLORJkuD6ov40UlBr5tunkzR6pAO3bcqpM8GBARIsrl1smmbZpk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ef0e:0:b0:766:504a:2a85 with SMTP id
 g14-20020a25ef0e000000b00766504a2a85mr273770ybd.597.1671757086843; Thu, 22
 Dec 2022 16:58:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:25 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-14-seanjc@google.com>
Subject: [PATCH 13/27] KVM: x86: Reject memslot MOVE operations if KVMGT is attached
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

Disallow moving memslots if the VM has external page-track users, i.e. if
KVMGT is being used to expose a virtual GPU to the guest, as KVM doesn't
correctly handle moving memory regions.

Note, this is potential ABI breakage!  E.g. userspace could move regions
that aren't shadowed by KVMGT without harming the guest.  However, the
only known user of KVMGT is QEMU, and QEMU doesn't move generic memory
regions.  KVM's own support for moving memory regions was also broken for
multiple years (albeit for an edge case, but arguably moving RAM is
itself an edge case), e.g. see commit edd4fa37baa6 ("KVM: x86: Allocate
new rmap and large page tracking when moving memslot").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_page_track.h | 3 +++
 arch/x86/kvm/mmu/page_track.c         | 5 +++++
 arch/x86/kvm/x86.c                    | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 0d65ae203fd6..6a287bcbe8a9 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -77,4 +77,7 @@ kvm_page_track_unregister_notifier(struct kvm *kvm,
 void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 			  int bytes);
 void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot);
+
+bool kvm_page_track_has_external_user(struct kvm *kvm);
+
 #endif
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 32357599cb09..c474a0ff24ba 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -320,3 +320,8 @@ enum pg_level kvm_page_track_max_mapping_level(struct kvm *kvm, gfn_t gfn,
 	return max_level;
 }
 EXPORT_SYMBOL_GPL(kvm_page_track_max_mapping_level);
+
+bool kvm_page_track_has_external_user(struct kvm *kvm)
+{
+	return hlist_empty(&kvm->arch.track_notifier_head.track_notifier_list);
+}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af0d83e33bc4..b587858e878e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12419,6 +12419,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
+	/*
+	 * KVM doesn't support moving memslots when there are external page
+	 * trackers attached to the VM, i.e. if KVMGT is in use.
+	 */
+	if (change == KVM_MR_MOVE && kvm_page_track_has_external_user(kvm))
+		return -EINVAL;
+
 	if (change == KVM_MR_CREATE || change == KVM_MR_MOVE) {
 		if ((new->base_gfn + new->npages - 1) > kvm_mmu_max_gfn())
 			return -EINVAL;
-- 
2.39.0.314.g84b9a713c41-goog

