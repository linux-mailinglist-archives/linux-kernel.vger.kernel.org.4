Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4572071D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbjFBQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbjFBQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:10:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B610E0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:10:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565de486762so28471877b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722190; x=1688314190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hryh0ZWAFdBP/1ensclnMWOs6DFcoKq9t8dEIwwzMjM=;
        b=yFcSJ5sk1YiYcQktVHUrIraA4vq3gzBg01wawQ+99X99BcERdv6aw79BJglFIsX38X
         Jmk2e5UaolCr5t1qAVgv5xhRcuwqz8qsPeKTN4dMinvHjEGhpXtPGawN2ICvlDQZGj8D
         ZmOScsl1sdyn4gxehMyRauugNpIrQjpu1KxL67VdJydhpwrAe8TXpUojYixIDTXpkYLZ
         L/KcS63c1WkLy8I19gAWFgXf90HgC8c3L1xN5Hze37jt9RE4scxALJ3lb9KGpgKF7m+y
         IPNOsGvdWwTPZEtqpxeUuo6lpLAcPxZcX9jQeWMRNApjKkg5jyviIXgCTWMDwLFLuVTH
         Fsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722190; x=1688314190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hryh0ZWAFdBP/1ensclnMWOs6DFcoKq9t8dEIwwzMjM=;
        b=YbRopRQ5d4s1RPszjGmOFPaWm/yWA5OdEJzOTA/SwrtUFnFzRzus75ark+vK6dR6ye
         qJsccATYaRc319kTxhnyf5eSZHA8TzAjC7M8RsUzXp8sFE3b8FcCF8WdKmKBKR7pYXcd
         DEQ4MVlAuqigBDnuLEWbwtv2Egx6ucLgot/2CsyUz7YVZ+T/9LQ2erJrCSLu1POAHj6E
         cGk600D18SN+X/yBo/jZ4dAac6NVq9+fkMupMLUAIDnxtPJcJhAFOViIz2xwaHAm5a9B
         +8MKj2C7zslBNdTGkFpUhxmkfjSsdhz0imJ+ekVM3skijW3DO0l3pxBvRFeZ/juhOpWC
         3SJw==
X-Gm-Message-State: AC+VfDxhC9da1JnZpQoOi9rjyzmpeev9JyuwOdr4C1dEIfoQMlledidV
        MxLh7WeUSL55Qg2QS0XN9Bqw41tU3sXo
X-Google-Smtp-Source: ACHHUZ5M9AG9HKhKFMo8prXUgGc/ucGnPOZDLd1OSRiqHslc40DT/QGSesfErKBawc3k99MHt4wj3TuQ4IOn
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a25:bc7:0:b0:ba8:cbd2:61b3 with SMTP id
 190-20020a250bc7000000b00ba8cbd261b3mr1223005ybl.5.1685722190144; Fri, 02 Jun
 2023 09:09:50 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:09:13 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-16-vipinsh@google.com>
Subject: [PATCH v2 15/16] KVM: arm64: Provide option to pass page walker flag
 for huge page splits
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass enum kvm_pgtable_walk_flags{} to kvm_mmu_split_huge_pages().
Use 0 as the flag value to make it no-op.

In future commit kvm_mmu_split_huge_pages() will be used under both MMU
read lock and MMU write lock. Flag allows to pass intent to use shared
or non-shared page walkers to split the huge pages.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/arm64/kvm/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 34d2bd03cf5f..6dd964e3682c 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -118,7 +118,8 @@ static bool need_split_memcache_topup_or_resched(struct kvm *kvm)
 }
 
 static int kvm_mmu_split_huge_pages(struct kvm *kvm, phys_addr_t addr,
-				    phys_addr_t end)
+				    phys_addr_t end,
+				    enum kvm_pgtable_walk_flags flags)
 {
 	struct kvm_mmu_memory_cache *cache;
 	struct kvm_pgtable *pgt;
@@ -153,7 +154,8 @@ static int kvm_mmu_split_huge_pages(struct kvm *kvm, phys_addr_t addr,
 			return -EINVAL;
 
 		next = __stage2_range_addr_end(addr, end, chunk_size);
-		ret = kvm_pgtable_stage2_split(pgt, addr, next - addr, cache, 0);
+		ret = kvm_pgtable_stage2_split(pgt, addr, next - addr, cache,
+					       flags);
 		if (ret)
 			break;
 	} while (addr = next, addr != end);
@@ -1112,7 +1114,7 @@ static void kvm_mmu_split_memory_region(struct kvm *kvm, int slot)
 	end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
 
 	write_lock(&kvm->mmu_lock);
-	kvm_mmu_split_huge_pages(kvm, start, end);
+	kvm_mmu_split_huge_pages(kvm, start, end, 0);
 	write_unlock(&kvm->mmu_lock);
 }
 
@@ -1149,7 +1151,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	 * again.
 	 */
 	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
-		kvm_mmu_split_huge_pages(kvm, start, end);
+		kvm_mmu_split_huge_pages(kvm, start, end, 0);
 	write_unlock(&kvm->mmu_lock);
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

