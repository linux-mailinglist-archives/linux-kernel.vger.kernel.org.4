Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB65688667
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjBBS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjBBS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:28:41 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC754542
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:28:24 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id v23-20020aa78097000000b005748c087db1so1356000pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=23k7ngnnq1dagvKcwTov6zadXURGVa/hBCuLb+iV0g0=;
        b=qlL/NRrpG/+vpCbk4ZkF9xxNrvsWRSi6Ew/JHzWHJRFEE18vAOAO0CiLpVr7HiCAIS
         Xe+67hFPUl+94O9IvYmpLCQy2+x2p+BQrVc5ZrQIT6CqMJ4N9kHM1xwcuvqQSdloVLTl
         4h9uMBNRWSRlWSp3i/vCULSGzs4w2spCcj5cGI0XJ7GVEtCFgRZS+QcocrikNW3ysSjD
         0/27DxwuU9cVtWo6s0S9Vmak9nzECvFXw97c22bO2QBK2MLxHv3N+Z1FpfaQ5iGdvYz1
         VjUJ6CgH/iBzlsETUhDGS6soZPFVpZQHzdogttMDnsowbI5LcqQ/mCsxEGfDGAwDjG0S
         n4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23k7ngnnq1dagvKcwTov6zadXURGVa/hBCuLb+iV0g0=;
        b=Ww0FZsoqWstDI3QG7hsJdUGvMdJsbxIxoHt/mEeWP4QGI5gV9T9kphvmhFMc+prQxy
         87kVNaxW8YMi5UE08KaccdSYwzGZZOOXCbBOE04BBtJGygZwXo0mA1XieHqUsxheAymg
         4V772L3FpdPnES5FGzWtSY2Lit4NPzln2LSMDBFNwpJ7YxOFoAf/l6F98nVo3LF0SVj7
         c7VN0nAC9y0TdBz/fYREpQoxW/fkmXJOYdNCSSJBIZx+vIAFLaxuhnqgCDaLGvTPoDPJ
         E8Qg+qokEm82xc+ZCtReaT82DcnvpnhVJhVNDbj88oFdXZyehstlODP4TQdFooOs04Tt
         cJ+w==
X-Gm-Message-State: AO0yUKUXi1eXSOo7jdCYoRwAg/lxgyGGXKiDO31WkKyOcdCUzzQGiSo6
        +r70IKzFyB9NthqHudJJJZyAR0sY2Q4=
X-Google-Smtp-Source: AK7set9nxsXLdOaC/swc1VO//GxkzUtI6Eo0OktLOLbkC37FgdLIBAWf3HiQs/s6L8HdWKAC3fbJ1/vLVQk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5715:0:b0:477:c1a3:9a10 with SMTP id
 l21-20020a635715000000b00477c1a39a10mr1205868pgb.33.1675362503600; Thu, 02
 Feb 2023 10:28:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  2 Feb 2023 18:28:16 +0000
In-Reply-To: <20230202182817.407394-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230202182817.407394-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202182817.407394-3-seanjc@google.com>
Subject: [PATCH v2 2/3] KVM: x86/mmu: Detect write #PF to shadow pages during
 FNAME(fetch) walk
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huang Hang <hhuang@linux.alibaba.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
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

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Move the detection of write #PF to shadow pages, i.e. a fault on a write
to a page table that is being shadowed by KVM that is used to translate
the write itself, from FNAME(is_self_change_mapping) to FNAME(fetch).
There is no need to detect the self-referential write before
kvm_faultin_pfn() as KVM does not consume EMULTYPE_WRITE_PF_TO_SP for
accesses that resolve to "error or no-slot" pfns, i.e. KVM doesn't allow
retrying MMIO accesses or writes to read-only memslots.

Detecting the EMULTYPE_WRITE_PF_TO_SP scenario in FNAME(fetch) will allow
dropping FNAME(is_self_change_mapping) entirely, as the hugepage
interaction can be deferred to kvm_mmu_hugepage_adjust().

Cc: Huang Hang <hhuang@linux.alibaba.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Link: https://lore.kernel.org/r/20221213125538.81209-1-jiangshanlai@gmail.com
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 5d2958299b4f..f57d9074fb9b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -685,6 +685,9 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 
 		if (sp != ERR_PTR(-EEXIST))
 			link_shadow_page(vcpu, it.sptep, sp);
+
+		if (fault->write && table_gfn == fault->gfn)
+			fault->write_fault_to_shadow_pgtable = true;
 	}
 
 	kvm_mmu_hugepage_adjust(vcpu, fault);
@@ -741,17 +744,13 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
  * created when kvm establishes shadow page table that stop kvm using large
  * page size. Do it early can avoid unnecessary #PF and emulation.
  *
- * @write_fault_to_shadow_pgtable will return true if the fault gfn is
- * currently used as its page table.
- *
  * Note: the PDPT page table is not checked for PAE-32 bit guest. It is ok
  * since the PDPT is always shadowed, that means, we can not use large page
  * size to map the gfn which is used as PDPT.
  */
 static bool
 FNAME(is_self_change_mapping)(struct kvm_vcpu *vcpu,
-			      struct guest_walker *walker, bool user_fault,
-			      bool *write_fault_to_shadow_pgtable)
+			      struct guest_walker *walker, bool user_fault)
 {
 	int level;
 	gfn_t mask = ~(KVM_PAGES_PER_HPAGE(walker->level) - 1);
@@ -765,7 +764,6 @@ FNAME(is_self_change_mapping)(struct kvm_vcpu *vcpu,
 		gfn_t gfn = walker->gfn ^ walker->table_gfn[level - 1];
 
 		self_changed |= !(gfn & mask);
-		*write_fault_to_shadow_pgtable |= !gfn;
 	}
 
 	return self_changed;
@@ -826,7 +824,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		return r;
 
 	is_self_change_mapping = FNAME(is_self_change_mapping)(vcpu,
-	      &walker, fault->user, &fault->write_fault_to_shadow_pgtable);
+	      &walker, fault->user);
 
 	if (is_self_change_mapping)
 		fault->max_level = PG_LEVEL_4K;
-- 
2.39.1.519.gcb327c4b5f-goog

