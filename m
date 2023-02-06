Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E40668C497
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBFRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjBFRYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:24:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155082A16F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:23:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u8-20020a258408000000b00880a7cc9684so5991684ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkWHRJ3DaV8HyItO3IxH/uOsr0AuzsEy+IWd0D6gRm0=;
        b=gDebpZOlByZMcipJS7iiuEaEoz2LNOZhbfjLuHHnTzbhZvH4gPrm4N5h+hXmgtUVft
         sBsxc7NH3DIOlVtD10BAJGlhmkwzLmogWYFoJs75t0sGYS78+904yzwoYUpRcqYIdZOC
         Izj40XAX4urHpYj2KXU9Uborl412/oBiHYOR+vPy/sQ+dwLzU2UsJo3sVKpTKOGZtBdr
         XYxW4tjeM7GYcDvx8ygtuvIjH4aCXWwWKx7PizQkoTYhJk5w3afxDp5BHjrSL9uL7X3a
         sPqadJaV7P2oGojYZ5LLqsjeGRZroWjZdrQRfrgtR2lF1mbNkF0I+xCdw2/zFn/VXQmr
         KDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkWHRJ3DaV8HyItO3IxH/uOsr0AuzsEy+IWd0D6gRm0=;
        b=ioLqSNTi3utyGG5KByyddvyhnaoY/G2suMZO6ykWBj0FrHaopERC1Ut26sAggG+38X
         5DWF70KNPIInn2IgNvdkzWpIvBmKhw9Bhuq9Muz0drvoWHosjwaKdkhR7MLi4a4ukoSr
         hlaiJdtz/92WdDAg9vaMFhVYmKk+4jmW/xIrRP5cf97hTpftI1idK642l1u8DMUGPaMX
         gnuXqPUk+Lq6Mj10hSS80+e+DaoP7t8XvQ77OiNa+igspfFaidyAzpMaEJM1etW+7OGw
         oi6Km85MYB/ZcrPQBtkGVAKnS1hDsaEPa5RXv+cfcezSZGKzZlgNhzrdvyVe3EbAoe/v
         XL4g==
X-Gm-Message-State: AO0yUKXOT+92OvmTDlSP8pjX2+8k0GkYxdN4EMdhwMFgMXiqiF+/cDW9
        L+8aCXHe6MOkRAU4c9eHUGGXyeNTN5wv
X-Google-Smtp-Source: AK7set+MnrswiwWWU7VjVXEwJFGUTZwq2+FDuhGHpgxo1swkM3BdaMOiSD9i23X6Wo2T0up/ZIHq2NMFv4Er
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a81:4e95:0:b0:527:b484:aa14 with SMTP id
 c143-20020a814e95000000b00527b484aa14mr602256ywb.263.1675704229352; Mon, 06
 Feb 2023 09:23:49 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:23:35 +0000
In-Reply-To: <20230206172340.2639971-1-rananta@google.com>
Mime-Version: 1.0
References: <20230206172340.2639971-1-rananta@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230206172340.2639971-3-rananta@google.com>
Subject: [PATCH v2 2/7] KVM: arm64: Add FEAT_TLBIRANGE support
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

Define a generic function __kvm_tlb_flush_range() to
invalidate the TLBs over a range of addresses. The
implementation accepts 'op' as a generic TLBI operation.
Upcoming patches will use this to implement IPA based
TLB invalidations (ipas2e1is).

If the system doesn't support FEAT_TLBIRANGE, the
implementation falls back to flushing the pages one by one
for the range supplied.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 43c3bc0f9544d..995ff048e8851 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -221,6 +221,24 @@ DECLARE_KVM_NVHE_SYM(__per_cpu_end);
 DECLARE_KVM_HYP_SYM(__bp_harden_hyp_vecs);
 #define __bp_harden_hyp_vecs	CHOOSE_HYP_SYM(__bp_harden_hyp_vecs)
 
+#define __kvm_tlb_flush_range(op, mmu, start, end, level, tlb_level) do {	\
+	unsigned long pages, stride;						\
+										\
+	stride = kvm_granule_size(level);					\
+	start = round_down(start, stride);					\
+	end = round_up(end, stride);						\
+	pages = (end - start) >> PAGE_SHIFT;					\
+										\
+	if ((!system_supports_tlb_range() &&					\
+	     (end - start) >= (MAX_TLBI_OPS * stride)) ||			\
+	    pages >= MAX_TLBI_RANGE_PAGES) {					\
+		__kvm_tlb_flush_vmid(mmu);					\
+		break;								\
+	}									\
+										\
+	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false);	\
+} while (0)
+
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_flush_cpu_context(struct kvm_s2_mmu *mmu);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu, phys_addr_t ipa,
-- 
2.39.1.519.gcb327c4b5f-goog

