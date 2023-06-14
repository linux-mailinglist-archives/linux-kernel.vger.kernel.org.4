Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7584720709
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjFBQK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbjFBQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:10:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE4AE43
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:09:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565d1b86a63so31914217b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722188; x=1688314188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATfYeV4iZLydVfrv7VkfrrcrF6Iyfqli3wOIB/41cFU=;
        b=Rqyu16keB0kE0WrdwrfeOOljSmmTEf5ym2HasOLzHF8ArvodVvyp0S6Lr0lp8jhqaO
         yU7vlRlNbGqDi7zvQpbHT6R5zFRE8DckASYhOzfH9V34Q20hh77zuuNe12GxNtHCZXh5
         lnbwZ2Svz+2HB81mY68YPRkYswYr7F2GvqW0LS+zjsO1U81VkyPUwY6eD2Ki1IgFqmLS
         03LcT6Q3zPmFBx5Lk1wR2QR7kJ2u+CVAlb7S/W7GXhPrjwIAChkVcnGC08nkCFgLZ6+3
         IJyon3TZZUbxyP2iFDZRsS+2chcqzC8RuTMktYv6Efxwhi8TOTgmYLyH3MqqUylTOe6h
         6cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722188; x=1688314188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATfYeV4iZLydVfrv7VkfrrcrF6Iyfqli3wOIB/41cFU=;
        b=gu0d0/TCzfyFcPvNPeUcd/sOl6nUhM8CT/CNN9nItwtw3jKD2bObfK08B+SA8HmxpD
         V6avQLczs8IRX3h58ZIuZdcflS5JliWnJh+8TTL3qdmdRmJldDuOFhWtoaVU8IhTccDl
         KlPhHO1IDSdwqiPl1wj4hc9mySAjtV/zX7VlvVPGh2D/PL0H5ZUsSAmSAFtBo0KCOMrx
         JL+EyS4nCYzmFj0kWOGP+mTPD0pDVqSjxCK8x0yQarRu/0XM3YRIGlUtWCxUv7VJ7dCY
         AZE/+KVr1Eo3xuUyqwK0Q8SKHe8HDIpdVF9LWtVlbbndX6sZ0qgobFFi9dUU99zmx7J7
         1/TQ==
X-Gm-Message-State: AC+VfDyY/064Az9LnXSJkGTEH8z9qRyIz0iPvlLENZJ8EZQGFlCyuaxL
        9R/yuJNl+30Th6ZGreeTJQC6oTZh+Us+
X-Google-Smtp-Source: ACHHUZ4IW8kR8j7bn7igS1kcMhvfZS4XncKRF7NLGQ8SgKKpwW4y3+9yGIJ+PiwzD8LO4pWUxsLhYeKpfotT
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a25:e706:0:b0:bac:5d2c:844b with SMTP id
 e6-20020a25e706000000b00bac5d2c844bmr1305917ybh.8.1685722187745; Fri, 02 Jun
 2023 09:09:47 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:09:12 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-15-vipinsh@google.com>
Subject: [PATCH v2 14/16] KVM: arm64: Pass page walker flags from callers of
 stage 2 split walker
From:   Vipin Sharma <vipinsh@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Pass enum kvm_pgtable_walk_flags{} to kvm_pgtable_stage2_split() walker
from its caller.

This allows split walker users to specify if they want to run split
logic via shared walker or non-shared walker.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 4 +++-
 arch/arm64/kvm/hyp/pgtable.c         | 5 +++--
 arch/arm64/kvm/mmu.c                 | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 145be12a5fc2..fbf5c6c509fb 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -684,6 +684,7 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size,
  * @size:	 Size of the range.
  * @mc:		 Cache of pre-allocated and zeroed memory from which to allocate
  *		 page-table pages.
+ * @flags:	 Page walker flags
  *
  * The function tries to split any level 1 or 2 entry that overlaps
  * with the input range (given by @addr and @size).
@@ -693,7 +694,8 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size,
  * blocks in the input range as allowed by @mc_capacity.
  */
 int kvm_pgtable_stage2_split(struct kvm_pgtable *pgt, u64 addr, u64 size,
-			     struct kvm_mmu_memory_cache *mc);
+			     struct kvm_mmu_memory_cache *mc,
+			     enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_walk() - Walk a page-table.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 23cda3de2dd4..7e84be13d76d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1408,11 +1408,12 @@ static int stage2_split_walker(const struct kvm_pgtable_visit_ctx *ctx,
 }
 
 int kvm_pgtable_stage2_split(struct kvm_pgtable *pgt, u64 addr, u64 size,
-			     struct kvm_mmu_memory_cache *mc)
+			     struct kvm_mmu_memory_cache *mc,
+			     enum kvm_pgtable_walk_flags flags)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_split_walker,
-		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.flags	= flags | KVM_PGTABLE_WALK_LEAF,
 		.arg	= mc,
 	};
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7c966f6f1a41..34d2bd03cf5f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -153,7 +153,7 @@ static int kvm_mmu_split_huge_pages(struct kvm *kvm, phys_addr_t addr,
 			return -EINVAL;
 
 		next = __stage2_range_addr_end(addr, end, chunk_size);
-		ret = kvm_pgtable_stage2_split(pgt, addr, next - addr, cache);
+		ret = kvm_pgtable_stage2_split(pgt, addr, next - addr, cache, 0);
 		if (ret)
 			break;
 	} while (addr = next, addr != end);
-- 
2.41.0.rc0.172.g3f132b7071-goog

