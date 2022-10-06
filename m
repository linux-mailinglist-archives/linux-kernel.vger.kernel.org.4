Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6B5F5DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJFAps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJFApf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:45:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD132EC3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:45:24 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f186-20020a636ac3000000b0044adaa7d347so187646pgc.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BxqLMD53TfhiTianeO8Egkee4cHk0Vyl+NHu2002+Ss=;
        b=p7hPUb0VbAxxCFPB6Oz4McFK2eE02IOu1Kr2lZWbhpWlf7JDssY612BawhNZoLK4gQ
         05v7izHAQ7tGp8udrC9uvWruJmQeloPllA/3IGDTPkV1jOrThxh2hIf1R0wn0f099nYf
         71gVXHH4y3+q6BoAQcHBfHSKCxaxThrvmOrirV3nYH6kn+XmogdNcUW6m3shGDCZhEod
         F0B8Qo+hq1Z/5T+n4lXX9wMeaPmWfzUv2a5oA2YTvy9xiRpaQuaXnMZaVPnbMNP5fdni
         Y4YzX6K8F6O39ZKRW/oCQNTexuIH6TwwiI4s2eCGCZjQvpm92BRP0zIgXudqZfIp94PT
         Stow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxqLMD53TfhiTianeO8Egkee4cHk0Vyl+NHu2002+Ss=;
        b=mdicnWTwsHMrvyO3AaXIuK/yhrlnTkeSzUd9Oh6gJmQWu0EGMUtl9t7VWcothg5qyr
         bml2ZdLdKJUlzKob0LtGL+hm14HSMm927hf79MkG65NU4FgCzPuHeYmCTKehYBt6+2O0
         7UfGUkPBQlRHOkiLmqE7Pa6j6Hl35RRYLhvirCJsGSKCQFICvJ6ZE2JlS16NU+mFrGFL
         0YnIUi7VkK3H6HQXP+9zOlppiPa+3W4SDh+EoDxuBkpbJ85BZG3M+SJVkh4MpAVM9LCG
         4cSnAQjRyhbhhvwcm1LTa6YCGZAGhokL4IAjt3DHqEeVotCKbT0DLIJkx0+zUJnDMH8B
         WHxQ==
X-Gm-Message-State: ACrzQf0nm2qgV270V/s3FPnUUS67MxxK8CUusN4DoghrP6NStjz0MaoN
        bzC7GmOVZcoPvV21gOYOyc3CLZyZWH4=
X-Google-Smtp-Source: AMsMyM40w5OlJA1mKErNWmHCLCtJVCl3KoNCK/glSLxin76mF84Co7W51hm1v1hg7FsK9LWiTWsXpnloJ3g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:be03:b0:178:6f5d:e979 with SMTP id
 r3-20020a170902be0300b001786f5de979mr1866194pls.163.1665017123997; Wed, 05
 Oct 2022 17:45:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:45:10 +0000
In-Reply-To: <20221006004512.666529-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006004512.666529-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006004512.666529-6-seanjc@google.com>
Subject: [PATCH 5/7] KVM: selftests: Use virt_get_pte() when getting PTE pointer
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Use virt_get_pte() in vm_get_page_table_entry() instead of open coding
equivalent code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/x86_64/processor.c      | 29 ++++---------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c9649f19aca1..09b550fd8815 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -247,9 +247,7 @@ void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 
 uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
 {
-	uint16_t index[4];
 	uint64_t *pml4e, *pdpe, *pde;
-	uint64_t *pte;
 
 	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
 		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
@@ -264,32 +262,17 @@ uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
 	TEST_ASSERT(vaddr == (((int64_t)vaddr << 16) >> 16),
 		"Canonical check failed.  The virtual address is invalid.");
 
-	index[0] = (vaddr >> 12) & 0x1ffu;
-	index[1] = (vaddr >> 21) & 0x1ffu;
-	index[2] = (vaddr >> 30) & 0x1ffu;
-	index[3] = (vaddr >> 39) & 0x1ffu;
+	pml4e = virt_get_pte(vm, &vm->pgd, vaddr, PG_LEVEL_512G);
 
-	pml4e = addr_gpa2hva(vm, vm->pgd);
-	TEST_ASSERT(pml4e[index[3]] & PTE_PRESENT_MASK,
-		"Expected pml4e to be present for gva: 0x%08lx", vaddr);
-
-	pdpe = addr_gpa2hva(vm, PTE_GET_PFN(pml4e[index[3]]) * vm->page_size);
-	TEST_ASSERT(pdpe[index[2]] & PTE_PRESENT_MASK,
-		"Expected pdpe to be present for gva: 0x%08lx", vaddr);
-	TEST_ASSERT(!(pdpe[index[2]] & PTE_LARGE_MASK),
+	pdpe = virt_get_pte(vm, pml4e, vaddr, PG_LEVEL_1G);
+	TEST_ASSERT(!(*pdpe & PTE_LARGE_MASK),
 		"Expected pdpe to map a pde not a 1-GByte page.");
 
-	pde = addr_gpa2hva(vm, PTE_GET_PFN(pdpe[index[2]]) * vm->page_size);
-	TEST_ASSERT(pde[index[1]] & PTE_PRESENT_MASK,
-		"Expected pde to be present for gva: 0x%08lx", vaddr);
-	TEST_ASSERT(!(pde[index[1]] & PTE_LARGE_MASK),
+	pde = virt_get_pte(vm, pdpe, vaddr, PG_LEVEL_2M);
+	TEST_ASSERT(!(*pde & PTE_LARGE_MASK),
 		"Expected pde to map a pte not a 2-MByte page.");
 
-	pte = addr_gpa2hva(vm, PTE_GET_PFN(pde[index[1]]) * vm->page_size);
-	TEST_ASSERT(pte[index[0]] & PTE_PRESENT_MASK,
-		"Expected pte to be present for gva: 0x%08lx", vaddr);
-
-	return &pte[index[0]];
+	return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
 }
 
 void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

