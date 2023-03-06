Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C41F6AD1CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCFWls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCFWln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:41:43 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952E75854
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:41:38 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id lm13-20020a170903298d00b0019a8c8a13dfso6633161plb.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=40gADokIJp7LXp0jd/R1DBU/pOdMA934Lm+cHTZ9qZM=;
        b=T+lSmTcVs1GzNKHcrL6yDPRcrmA/On3+n7qFsig/y3to2l4Di94gZCGr/bCF/QIFCL
         cLBeX1YxouACoIAPgs5QY9rBE2OkiwAkgbEVHRpOGc3BwbxvIbCvo7tmUGlTyZWsYjaM
         rcOL2MkUhC/hl7Y55rrGwp+7FG30goIjn4DoVJHcpFT4JcRvPQBwQZiwyp74cNGlB9/G
         dLwyS0IwCuOH0hP26IbUG5UrvLBfOyWMRTXW1uwn01yE277FOUncIfgzp+cXW4MWpJr2
         gy6GNgQW2rkbETRch+20PWhJaRjHq2yMu6JjDYYIH/Bwi7mxegFKsQmmksJVz6W7VuaU
         nxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40gADokIJp7LXp0jd/R1DBU/pOdMA934Lm+cHTZ9qZM=;
        b=fnCEO0cZuDnth3OmsgcjwUPNqupKmiSHV2DcIPE5m+pYbzHuBeKPlkhWVsLvv8g5y3
         OL851FL+GdVLBmsuPcqleRiUkPMybqdJ5vltn2zOg8CUmT4XtIUq/7WRrRD2Ui5EDrE+
         IIZpvxcG6GRT0hA/qAFJCq9+HSNI0ozjktR4XZfZFOXSUZ7dgccrqh/vhL6TUH6ZFHW5
         8xkEOBMm4WIyV8augY7pYp6zhQMZkyiqf7Gnl0+Pv4rEX1VzJaTG/uOIzSegzYwd+Pnm
         jeKPXvQBY71mv6IOWPQnXgxiKVA/g1S/ZHoXWRYq/bPUkwpjkMmRXX/EFXt7tgyKhoi/
         BXpg==
X-Gm-Message-State: AO0yUKU+NslgiXzgrZyzr9Dm1jokUYYK/eTWX9a9YHxCDhVuUy+878U7
        jIgX8zmjk+IHp1o9XrzoMq2Ggz0heBDo
X-Google-Smtp-Source: AK7set9sR45L+LDHCgEH2QOACc5WTVEZlCHYGVdCn/w8i1k+AVwEVcDMNn8+7HF/fl2p/1eVU/27oQXHjqdY
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:d58e:b0:233:fbe0:5ccf with SMTP id
 v14-20020a17090ad58e00b00233fbe05ccfmr4320085pju.1.1678142498162; Mon, 06 Mar
 2023 14:41:38 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:11 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-3-vipinsh@google.com>
Subject: [Patch v4 02/18] KVM: x86/mmu: Remove zapped_obsolete_pages from
 struct kvm_arch{}
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

Remove zapped_obsolete_pages from struct kvm_arch{} and use local list
in kvm_zap_obsolete_pages().

zapped_obsolete_pages list was used in struct kvm_arch{} to provide
pages for KVM MMU shrinker. Since, KVM MMU shrinker is no-op now, this
is not needed.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>

---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/mmu/mmu.c          | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 808c292ad3f4..ebbe692acf3f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1252,7 +1252,6 @@ struct kvm_arch {
 	u8 mmu_valid_gen;
 	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
 	struct list_head active_mmu_pages;
-	struct list_head zapped_obsolete_pages;
 	/*
 	 * A list of kvm_mmu_page structs that, if zapped, could possibly be
 	 * replaced by an NX huge page.  A shadow page is on this list if its
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0d07767f7922..3a452989f5cd 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5947,6 +5947,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 {
 	struct kvm_mmu_page *sp, *node;
 	int nr_zapped, batch = 0;
+	LIST_HEAD(invalid_list);
 	bool unstable;
 
 restart:
@@ -5979,8 +5980,8 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 			goto restart;
 		}
 
-		unstable = __kvm_mmu_prepare_zap_page(kvm, sp,
-				&kvm->arch.zapped_obsolete_pages, &nr_zapped);
+		unstable = __kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list,
+						      &nr_zapped);
 		batch += nr_zapped;
 
 		if (unstable)
@@ -5996,7 +5997,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 	 * kvm_mmu_load()), and the reload in the caller ensure no vCPUs are
 	 * running with an obsolete MMU.
 	 */
-	kvm_mmu_commit_zap_page(kvm, &kvm->arch.zapped_obsolete_pages);
+	kvm_mmu_commit_zap_page(kvm, &invalid_list);
 }
 
 /*
@@ -6072,7 +6073,6 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 	int r;
 
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
-	INIT_LIST_HEAD(&kvm->arch.zapped_obsolete_pages);
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
 	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

