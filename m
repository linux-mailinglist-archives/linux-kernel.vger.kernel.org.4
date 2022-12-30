Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE9653AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiLVCfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiLVCfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:35:04 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E820BDC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:35:03 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j21-20020a63fc15000000b00476d6932baeso397205pgi.23
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvgCZzGuCZEbUtwnqfq9owkASUBDttKfTawhWhWdLK8=;
        b=Lj/SLu+ZPDBJ2sGiuCeMbA8Eib+ys2Vq5L2kcNArJJ27StQ16ma1UJb42Mlbw+MX2y
         +vrXP50O/g9dt+8oLnnQPMY/pVvzZccMhn37yhkkMKRf4OlgdSQXrJ+ZWJgL43dFFYR+
         tdwnZfiM6qXzjCF0pB4Ud8WosLspziQJwWE3TyKPGONvwBr+KawoDzl0ACL4bYB7f0ka
         +9u/KzDX7Y/WSElPNKVuB24p/2FtsBTEOpi1zH9/xrJSOu0EbYYUmkBsdvah4qZZp3Yj
         04qEKwX3b7Ue+pkFRhxsJ6kCgSSMeS3TCIzw3hYmLO78q2Llvjee+NN6cvHnX+T+1k7v
         btLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvgCZzGuCZEbUtwnqfq9owkASUBDttKfTawhWhWdLK8=;
        b=J/UK/VrMirhF6brZ2oOIGpqfuCgjfp4TLsdloNwyryMps2DSbsiH3r+jKrEGeP7vwR
         a1tcjEeMMAO+plD7GOCvk1Z8Rl80ErWyMSqXrjNoWsmDHkH+TjfpS8wTJNXOZ271+fDf
         MRs5oEENxdaVM0jeFIpJBQwa0wG00uHxDKKLqc23KlJIXOS815NybYP7SdmeLfSRPZH6
         WmuEIHXAqsjacJ8ZkWKH1P4RsNvj4m11nRHLGr2ROGv+7K/p7+5czHcONCG/YlpIXguX
         zX8V5KMmdC2B5bGPtxjkrinhUKMBG/7M/Jb0IBBpNPxf5LWe5oHZyGomWuSOMduXQwEg
         DBXQ==
X-Gm-Message-State: AFqh2kpdBrbaQpS0tJCF5B9pITc9H0JUIqqdvXvtDV0iOYydq2xCNUuN
        hLihwGS7jZDx2cBdovJROYx5+LVIsIZe
X-Google-Smtp-Source: AMrXdXvpyhuXUSV2ZgsVbb3u/vup+sTPI608UoPHhlRzsUzMCiUiErRLse5yLEL+556xYOprZ+VJNxunZl78
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90b:d8a:b0:223:f336:1519 with SMTP id
 bg10-20020a17090b0d8a00b00223f3361519mr359433pjb.198.1671676503393; Wed, 21
 Dec 2022 18:35:03 -0800 (PST)
Date:   Wed, 21 Dec 2022 18:34:50 -0800
In-Reply-To: <20221222023457.1764-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221222023457.1764-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222023457.1764-3-vipinsh@google.com>
Subject: [Patch v3 2/9] KVM: x86/mmu: Remove zapped_obsolete_pages from struct kvm_arch{}
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

zapped_obsolete_pages list was used in struct kvm_arch{} to provide
pages for KVM MMU shrinker. This is not needed now as KVM MMU shrinker
has been repurposed to free shadow page caches and not
zapped_obsolete_pages.

Remove zapped_obsolete_pages from struct kvm_arch{} and use local list
in kvm_zap_obsolete_pages().

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/mmu/mmu.c          | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 89cc809e4a00..f89f02e18080 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1215,7 +1215,6 @@ struct kvm_arch {
 	u8 mmu_valid_gen;
 	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
 	struct list_head active_mmu_pages;
-	struct list_head zapped_obsolete_pages;
 	/*
 	 * A list of kvm_mmu_page structs that, if zapped, could possibly be
 	 * replaced by an NX huge page.  A shadow page is on this list if its
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 157417e1cb6e..3364760a1695 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5987,6 +5987,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 {
 	struct kvm_mmu_page *sp, *node;
 	int nr_zapped, batch = 0;
+	LIST_HEAD(zapped_pages);
 	bool unstable;
 
 restart:
@@ -6019,8 +6020,8 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 			goto restart;
 		}
 
-		unstable = __kvm_mmu_prepare_zap_page(kvm, sp,
-				&kvm->arch.zapped_obsolete_pages, &nr_zapped);
+		unstable = __kvm_mmu_prepare_zap_page(kvm, sp, &zapped_pages,
+						      &nr_zapped);
 		batch += nr_zapped;
 
 		if (unstable)
@@ -6036,7 +6037,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 	 * kvm_mmu_load()), and the reload in the caller ensure no vCPUs are
 	 * running with an obsolete MMU.
 	 */
-	kvm_mmu_commit_zap_page(kvm, &kvm->arch.zapped_obsolete_pages);
+	kvm_mmu_commit_zap_page(kvm, &zapped_pages);
 }
 
 /*
@@ -6112,7 +6113,6 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 	int r;
 
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
-	INIT_LIST_HEAD(&kvm->arch.zapped_obsolete_pages);
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
 	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
 
-- 
2.39.0.314.g84b9a713c41-goog

