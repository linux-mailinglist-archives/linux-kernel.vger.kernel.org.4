Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2D6E2965
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDNR3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjDNR3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:29:35 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C087F6E8F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:29 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id n14-20020a056e02140e00b003259a56715bso10400194ilo.15
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681493369; x=1684085369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xod2ygDVduTwUHImrHGaOn1Ey3T4FHeje26KGvtdzFY=;
        b=urihsx8BJ4/z847iQ0af0/ABhs7C6WBtcCWjGJXbhxr/VPQvARnb7XaJ7A5oFQiHCD
         90urhiaRyXF7oVdI+4/fu/OPC5OJvxewZGz9QxN5hZ5yTVEjUtFiVeYjgKwW9nNFK1ru
         ce1L+PFnnDRNFsRRRIrGtENwVQTm3GxN0xCbR3syOuv9KLkEd+6jW5XLxUGt1ZHmyXnR
         HgnKGTeToQwFaAXYXVQwBhn++Abwiz3alwNHfKA9Vz6CpdqXz9JFA+VXvh7qQ0Qk8Eho
         hnqoSXzs/4uE8yim0YCcb5e3OEyL4Tz/6RTOh3sL0WbaHGriWM3BXETHdZiXgWQWsmI6
         Kx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493369; x=1684085369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xod2ygDVduTwUHImrHGaOn1Ey3T4FHeje26KGvtdzFY=;
        b=Xn6fJm0EDmE9ieRheeqCitF3VdhNsAkSvWkJ9MtLvBc9F5hx5nVHRvV0B4QGD1dZ2B
         shWAZ0mm3HrF3+AXpY7/mxIYBRJ+3il3UM3w1Sfnj2cGxPqEbMrf7gNIkCYZt7QJSlwo
         1MU2+6OhAzjlr3y7/qhN48CXBDWwZ+FkyIUlRGdletvsJxq3K03I9TLdgccmbttg15wg
         IKI8CLjknrRy/KNK3nqqPdVxb3Kk1HKgO5sFxs0Seyni3Zj5Mlai0GR1Bu/g/RNh7JGC
         187LuiwW3qLjK2tVzLkTkJSNiLrnwguOZtpDYS+RhjHpreItZAoCtMvC5Bxbq+/zm4sz
         QZTw==
X-Gm-Message-State: AAQBX9cSH52pE8vzIVRAREn9ksa6jkT7kZZqXiIB5TCAmUdnIQ5/1GFh
        3al8rWAGJHbVKQCzKSBrOIeEGsGidXou
X-Google-Smtp-Source: AKy350aPSA8VnmqDZpOyrrIV/qNFr7vvNcijupLw4tbGJajccFhHKKFJcef90ZPOEeNPVI0c8hECYDUjbfor
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a02:b19d:0:b0:40f:787a:852f with SMTP id
 t29-20020a02b19d000000b0040f787a852fmr1494204jah.6.1681493369209; Fri, 14 Apr
 2023 10:29:29 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:29:18 +0000
In-Reply-To: <20230414172922.812640-1-rananta@google.com>
Mime-Version: 1.0
References: <20230414172922.812640-1-rananta@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414172922.812640-4-rananta@google.com>
Subject: [PATCH v3 3/7] KVM: arm64: Implement kvm_arch_flush_remote_tlbs_range()
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Ricardo Koller <ricarkol@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

Implement kvm_arch_flush_remote_tlbs_range() for arm64
to invalidate the given range in the TLB.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/mmu.c              | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 17c215a2df7d7..075d3e6482e53 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1044,6 +1044,9 @@ struct kvm *kvm_arch_alloc_vm(void);
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
 int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
 
+#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
+int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u64 pages);
+
 static inline bool kvm_vm_is_protected(struct kvm *kvm)
 {
 	return false;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d0a0d3dca9316..e3673b4c10292 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -92,6 +92,17 @@ int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
 	return 0;
 }
 
+int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u64 pages)
+{
+	phys_addr_t start, end;
+
+	start = start_gfn << PAGE_SHIFT;
+	end = (start_gfn + pages) << PAGE_SHIFT;
+
+	kvm_call_hyp(__kvm_tlb_flush_vmid_range, &kvm->arch.mmu, start, end);
+	return 0;
+}
+
 static bool kvm_is_device_pfn(unsigned long pfn)
 {
 	return !pfn_is_map_memory(pfn);
-- 
2.40.0.634.g4ca3ef3211-goog

