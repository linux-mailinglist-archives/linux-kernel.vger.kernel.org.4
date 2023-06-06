Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD262724D15
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjFFT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbjFFT3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:29:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721D11701
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:29:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacfa4eefcbso13892143276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686079746; x=1688671746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WYVW7sMItJ+/qNz0zQExZlTscw6/G0/crBTyowFvIE=;
        b=5IlabwCGrIyj/AGVDbv02tLgdBhugCUdfaXNCXYMSgWmeO4GWMwq9kUV8ZLcrznmtJ
         9w/fRVw2Q8vQO+X8PD0RiK+E4de/ZlpNpjX//3+ZJ/z1bgt4IWCS+WCqcmPYchdYMhu7
         6ZyTyuOgCdCzQ6Qd9R9LhK4vGuuDSFhKZxBgCoDZYz1ivx6gHwTZc2aV0zJ34iKVwEts
         b+wR3veNb0Evao1qV8B/2Wkryz4orAqDviNP7ie3it9vbdqD20hDgy70q8P3ZsyWQY24
         V90tcmm1HDL61ztZ1eduvI73n/LrSx8omh8WnuH0h1b7VOBl7pbLKx3+xvncMPyB0MAp
         TYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686079746; x=1688671746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WYVW7sMItJ+/qNz0zQExZlTscw6/G0/crBTyowFvIE=;
        b=cRYjfEuG73DEYfJeZueajCyDh6rFvpuQYbVBaMG6EXrP04muJkhvMiLRXI0mn5uFVy
         mDxVAqZT27Zu/Jv66YDUAOFI3dwY/9i1KWdxVMMGZyekObCuuL/dZgQQGVTmrzHQ6vOv
         Vg9YWpwKcamcL1cPYJevSCbwPxAtrh1A+Aa+TppI8vOgUNLHt2RI8u9cCWs+gQOY/rF3
         ZcJB38YTp0Tl1c0uYCcyGe3qCRHrG0/niOztzUBf3GT6XMhu3aUN6MQRFuSvo6wgxGtB
         Cg/Uk9PS/dxcOwbku6u962EmSvIedrAws5H8r1O7NM5E5bxqNVYWmGfmW2bpc6A/E+l0
         kt2w==
X-Gm-Message-State: AC+VfDx0QVqzwXbOUkMN4OAaqxP+dEJkz8UrB9+bAow3x2yq2vPRAIee
        zqBiUjY6FrKBTTzu88e/u6ovsM8kgcCw
X-Google-Smtp-Source: ACHHUZ6EqwKWg0miPDGHXqsiKtPZWCKDCcQHa7RLTfS8/ASb2ZH4UEIkh0Qo1ATHiY2DnDeSbDhiY4EFJcXm
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a25:aac6:0:b0:b9e:7fbc:15e1 with SMTP id
 t64-20020a25aac6000000b00b9e7fbc15e1mr8330733ybi.0.1686079746618; Tue, 06 Jun
 2023 12:29:06 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:28:55 +0000
In-Reply-To: <20230606192858.3600174-1-rananta@google.com>
Mime-Version: 1.0
References: <20230606192858.3600174-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606192858.3600174-5-rananta@google.com>
Subject: [PATCH v5 4/7] KVM: arm64: Implement kvm_arch_flush_remote_tlbs_range()
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

Implement kvm_arch_flush_remote_tlbs_range() for arm64
to invalidate the given range in the TLB.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 3 +++
 arch/arm64/kvm/mmu.c              | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 81ab41b84f436..343fb530eea9c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1081,6 +1081,9 @@ struct kvm *kvm_arch_alloc_vm(void);
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
 int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
 
+#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
+int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u64 pages);
+
 static inline bool kvm_vm_is_protected(struct kvm *kvm)
 {
 	return false;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d0a0d3dca9316..c3ec2141c3284 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -92,6 +92,13 @@ int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
 	return 0;
 }
 
+int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u64 pages)
+{
+	kvm_tlb_flush_vmid_range(&kvm->arch.mmu,
+				start_gfn << PAGE_SHIFT, pages << PAGE_SHIFT);
+	return 0;
+}
+
 static bool kvm_is_device_pfn(unsigned long pfn)
 {
 	return !pfn_is_map_memory(pfn);
-- 
2.41.0.rc0.172.g3f132b7071-goog

