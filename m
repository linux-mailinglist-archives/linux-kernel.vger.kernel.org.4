Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019067BEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjAYVjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjAYVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:07 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A541F932
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:39:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-506368dc06dso80286877b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z+H+UxvTCHRq2s16xJmpZ8uSEEOupkr1b5CjiCnOkq0=;
        b=ThnR8aaRFSVJ6f1dSLQmti6T/10Si88QgufO2iD1z2YErNe8jTdRZDq6tWbXGO+1aY
         6JR7ubUZJ1ktrc4CwqGf40eFzOcSSHFCSz7OTItOt0PZq0bxEMe5Bx8eFDqyyWLQTnkk
         sBzg7v+EPWRVXqGC747qF4kjUuz531+g0SzfXiSaJ4WynBW7ktKI2gBYTohy1VN1KURX
         jS/JKpZWaNxkKZgQhhcsgb9py1ZFcc9c+nSjrCSfWyzFiII6YCUFMwycxbV/dh1/VjbQ
         4wAnqmcLadNOXItFDGiLgpmToLQQAPdldYLQflRwBmoTgylFVtOm9ymkxBkFQwV01BUl
         TSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+H+UxvTCHRq2s16xJmpZ8uSEEOupkr1b5CjiCnOkq0=;
        b=KLDkncnR1nbRNRtAwaUBSCuo6+9CMd7SzvJMOTUY6Ih9XqE9Wzh/sIAf/Fl4CBVyfv
         krdsjBjZE7NQPF8iVdYC1YHpvoGUZfkT1KDtnzioWI2W/nv8oWGIWJtqJAetvN64mu+X
         SSlTn8Yp4Q+nvN40KlhO+U+WU4fAdfA1d6xNo0GXB6z5dLi+RqbJ3H2k+sV9sDq7EVX4
         SvfqpDcPuqubxS6iWfHvx46dvRW3hTcbE/Om+CihkaurdMGRP8dcf274fYAX8KBedNj/
         IEuOR3fRWYepgwSAKkdGhSpJQjn6CcdV7AMfYGCgEY1d4VoB51/3aREqb8juVk580fyz
         lTuQ==
X-Gm-Message-State: AO0yUKWM7IFTv4n9WNk88Ent931gatR1NmajOmTt6xUxJX1qilizgWVD
        dLkW+bIouex1KTvU9u+vZJDbmKJQlkdv
X-Google-Smtp-Source: AK7set/XJtT+OUZYKL5QmyqvLrn+GZmd+oxg9T7eDFIVB7yaDs3ETS7stX45UHKTCtlRG+8g6jeJLdKSSixk
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a81:7e4b:0:b0:506:4f19:740c with SMTP id
 p11-20020a817e4b000000b005064f19740cmr722466ywn.383.1674682744614; Wed, 25
 Jan 2023 13:39:04 -0800 (PST)
Date:   Wed, 25 Jan 2023 13:38:57 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125213857.824959-1-vipinsh@google.com>
Subject: [Patch] KVM: x86/mmu: Make optimized __handle_changed_spte() for
 clear dirty log
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Use a tone down version of __handle_changed_spte() when clearing dirty
log. Remove checks which will not be needed when dirty logs are cleared.

This change shows ~13% improvement in clear dirty log calls in
dirty_log_perf_test

Before tone down version:
Clear dirty log over 3 iterations took 10.006764203s. (Avg 3.335588067s/iteration)

After tone down version:
Clear dirty log over 3 iterations took 8.686433554s. (Avg 2.895477851s/iteration)

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index bba33aea0fb0..ca21b33c4386 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -504,6 +504,19 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
+static void handle_changed_spte_clear_dirty_log(int as_id, gfn_t gfn,
+						u64 old_spte, u64 new_spte,
+						int level)
+{
+	if (old_spte == new_spte)
+		return;
+
+	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
+
+	if (is_dirty_spte(old_spte) &&  !is_dirty_spte(new_spte))
+		kvm_set_pfn_dirty(spte_to_pfn(old_spte));
+}
+
 /**
  * __handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
@@ -736,7 +749,12 @@ static u64 __tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 
 	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
 
-	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
+	if (record_dirty_log)
+		__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte,
+				      level, false);
+	else
+		handle_changed_spte_clear_dirty_log(as_id, gfn, old_spte,
+						    new_spte, level);
 
 	if (record_acc_track)
 		handle_changed_spte_acc_track(old_spte, new_spte, level);
-- 
2.39.1.456.gfc5497dd1b-goog

