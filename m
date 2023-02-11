Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B5692CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 02:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBKBrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 20:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBKBqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:46:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF02880E6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:46:43 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52ee93d7863so5970517b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cV6anjCgKUaY0e+B+aFQ5NbnTuwKip5tCWUOTAoaYc=;
        b=HZV5xjcaT/zj7344N4oejB5i1K5DQKr/S3o+xMZz7NM4yxEvq5V75WAGRuVSQ7qaRm
         ItCLApgwaCA+CtdXN9GgtI/046ysapHYNDO77M6uqY/hu1RY1xjhUnxfNFGA2YRnNVDB
         krpQ7jimSaCg2t1vnRdk5sXw9CUfJgtg2OGvMKnoe7sl0Vne/xQjDl6RoDhuwh+6c8Sd
         W7Uf9eUm6wE2Q4d/4vCLjUbf9PbV5fB1I/yADR8b0rWHfZDv61eRsBmAapmijMIWWef1
         +1kTpL2ruNBjIjGCY22pwhL7DMqUgYJfP9Z98dboKDd430bC4cH3R71VZaCsl/B2hNmm
         AiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cV6anjCgKUaY0e+B+aFQ5NbnTuwKip5tCWUOTAoaYc=;
        b=f3xg6PgPcwXkByh3E5Rl9lJWKu3qVVV9lBe6O9V7Fs8Wpv4dvCewhfx80qephyOkfl
         yGWoBK8EV4lMaBlMuDM3O0KQsdipxYG5uZnwurFiSPlLNj41qrni/NBsgxHOmYBEhWJq
         3GjWeTtR407I1RBKg3JbEwNZG46FXs+3o3IW697lbDy6tOZJ8cmPERVSdVBbnRsCeSdW
         9mRtabs30SCJhZ7wNI5w1gjYEdSuctUjr7CJU2gregXMSwvVuv9ZBgKGi0Qlmo4xl7Pk
         Xua6WifUu9i5HHrUxaYJ95QkVmeU7r1DwTaB5DkMy7+eDxDw63OnnoygnG33ThB9vcHB
         qvjg==
X-Gm-Message-State: AO0yUKWKBXwazN+rdbfuL+hluvocaccuPsMtPnwQ4dTMFt78Ko52yhUa
        jJ0Y9UnuFrcfKhkxtMeaw6w+v/JytVHg
X-Google-Smtp-Source: AK7set+8rZs7v/xCMonTIpZIgut8OUh9JbDVoCmWOxbweb0/DRK5Qdc6F3UTroIqg/uAt5W2yJMbGe9Qzs4G
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a0d:d813:0:b0:52e:ec03:9b2f with SMTP id
 a19-20020a0dd813000000b0052eec039b2fmr0ywe.8.1676080002679; Fri, 10 Feb 2023
 17:46:42 -0800 (PST)
Date:   Fri, 10 Feb 2023 17:46:25 -0800
In-Reply-To: <20230211014626.3659152-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230211014626.3659152-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230211014626.3659152-7-vipinsh@google.com>
Subject: [Patch v3 6/7] KVM: x86/mmu: Remove handle_changed_spte_dirty_log()
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Remove handle_changed_spte_dirty_log() as there is no code flow which
sets 4KiB SPTE writable and hit this path. This function marks the page
dirty in a memslot only if new SPTE is 4KiB in size and writable.

Current users of handle_changed_spte_dirty_log() are:
1. set_spte_gfn() - Create only non writable SPTEs.
2. write_protect_gfn() - Change an SPTE to non writable.
3. zap leaf and roots APIs - Everything is 0.
4. handle_removed_pt() - Sets SPTEs to REMOVED_SPTE
5. tdp_mmu_link_sp() - Makes non leaf SPTEs.

There is also no path which creates a writable 4KiB without going
through make_spte() and this functions takes care of marking SPTE dirty
in the memslot if it is PT_WRITABLE.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index e50e869bf879..0c031319e901 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -345,24 +345,6 @@ static void handle_changed_spte_acc_track(u64 old_spte, u64 new_spte, int level)
 		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
 }
 
-static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
-					  u64 old_spte, u64 new_spte, int level)
-{
-	bool pfn_changed;
-	struct kvm_memory_slot *slot;
-
-	if (level > PG_LEVEL_4K)
-		return;
-
-	pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
-
-	if ((!is_writable_pte(old_spte) || pfn_changed) &&
-	    is_writable_pte(new_spte)) {
-		slot = __gfn_to_memslot(__kvm_memslots(kvm, as_id), gfn);
-		mark_page_dirty_in_slot(kvm, slot, gfn);
-	}
-}
-
 static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	kvm_account_pgtable_pages((void *)sp->spt, +1);
@@ -614,8 +596,6 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level,
 			      shared);
 	handle_changed_spte_acc_track(old_spte, new_spte, level);
-	handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
-				      new_spte, level);
 }
 
 /*
@@ -727,8 +707,6 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 
 	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
 	handle_changed_spte_acc_track(old_spte, new_spte, level);
-	handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte, new_spte,
-				      level);
 	return old_spte;
 }
 
-- 
2.39.1.581.gbfd45094c4-goog

