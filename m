Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74015F5DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJFApV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJFApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:45:18 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B32EF2D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:45:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x23-20020a634857000000b0043c700f6441so180968pgk.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/f92dm4ZeTvJd7PsFL2Za3VtIXCkQKM6x4xMOTGe5sU=;
        b=Eg+5mnZzAC/lwg2ZjxfKh4X2unfsjHq+81nHaZtYdcUwoq+09r72B+dxg4L0gzRBvo
         eZFV1WwRNiNDk++b982iaw5L9Rexy4sz+6upo+e22p5oP8whvU9pKursCZMryeEDTvcQ
         +ojvErTvYHRX7OXDY1MNhLcDoTcPOPsFyo4ZkrFSGXrdmZjHLuUEiM3gcN5tmKMdwKqW
         ADcOf4gsLQQDzAJZShAamC93i+C5fnt8sZTW5GSZixsmOEO4fZQaOnZa6pHN6vuIHvis
         FHa5ZHCmMLM1pOhnwXSXpAc5dwTascGRGgIclsqoMWMdbicLKcHvuVcjm7jRXs9NKzX+
         BRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/f92dm4ZeTvJd7PsFL2Za3VtIXCkQKM6x4xMOTGe5sU=;
        b=ncPWdHaJnXYKnue5ymnK25v3g+W/9KGSynoO9WtNHjsI2/Ev33rG/8Set4Mwqe+Xly
         UX8Pi6E5/8+hw9inPzBdxlkTEQGGSSdzyGvESVkxycwudSaA1yQoQM6ipJueGuY0ii57
         0wKMLpb6E8JaVXxygV1xkA4y5eeV5qMwhAYdnFqB7CFb46OlxSGj6jKGf527iSgEadkS
         V+vDTNiY23ZkjPEKhNSamDGfwGcZmxrPf3kel+0PSi1YSngpjtvFoCC26NuQ4JgVIlzU
         Xg/5SYDPRHIXYkFYzel4KotAkgtBIa+m3CU1r3aKL+QXZGHV9Gz3K5oaYRHueonhDbxH
         hbdg==
X-Gm-Message-State: ACrzQf0449APLZflcAGBRGcB6S1U1nlDCHvE0tqYg7iASYCjNe6cDPLp
        swT3MVfYKfJsfauTFUkidQcYt6VYK1E=
X-Google-Smtp-Source: AMsMyM4Qwv/qeTZc3trJF9sGTNOxdWkcSGNES31lOZ26eTIlFlKspU9scRzBRqtPRpi9nPyUzfTSPDRvOe8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1353:b0:541:5258:4e43 with SMTP id
 k19-20020a056a00135300b0054152584e43mr2440189pfu.6.1665017116943; Wed, 05 Oct
 2022 17:45:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:45:06 +0000
In-Reply-To: <20221006004512.666529-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006004512.666529-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006004512.666529-2-seanjc@google.com>
Subject: [PATCH 1/7] KVM: selftests: Drop helpers to read/write page table entries
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Drop vm_{g,s}et_page_table_entry() and instead expose the "inner"
helper (was _vm_get_page_table_entry()) that returns a _pointer_ to the
PTE, i.e. let tests directly modify PTEs instead of bouncing through
helpers that just make life difficult.

Opportunsitically use BIT_ULL() in emulator_error_test, and use the
MAXPHYADDR define to set the "rogue" GPA bit instead of open coding the
same value.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  6 ++----
 .../selftests/kvm/lib/x86_64/processor.c      | 21 ++-----------------
 .../kvm/x86_64/emulator_error_test.c          |  6 ++++--
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e8ca0d8a6a7e..30d5df1ebaad 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -827,10 +827,8 @@ static inline uint8_t wrmsr_safe(uint32_t msr, uint64_t val)
 
 bool kvm_is_tdp_enabled(void);
 
-uint64_t vm_get_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
-				 uint64_t vaddr);
-void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
-			     uint64_t vaddr, uint64_t pte);
+uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+				  uint64_t vaddr);
 
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 39c4409ef56a..90b35998b0f3 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -241,9 +241,8 @@ void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	}
 }
 
-static uint64_t *_vm_get_page_table_entry(struct kvm_vm *vm,
-					  struct kvm_vcpu *vcpu,
-					  uint64_t vaddr)
+uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+				  uint64_t vaddr)
 {
 	uint16_t index[4];
 	uint64_t *pml4e, *pdpe, *pde;
@@ -313,22 +312,6 @@ static uint64_t *_vm_get_page_table_entry(struct kvm_vm *vm,
 	return &pte[index[0]];
 }
 
-uint64_t vm_get_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
-				 uint64_t vaddr)
-{
-	uint64_t *pte = _vm_get_page_table_entry(vm, vcpu, vaddr);
-
-	return *(uint64_t *)pte;
-}
-
-void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
-			     uint64_t vaddr, uint64_t pte)
-{
-	uint64_t *new_pte = _vm_get_page_table_entry(vm, vcpu, vaddr);
-
-	*(uint64_t *)new_pte = pte;
-}
-
 void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 {
 	uint64_t *pml4e, *pml4e_start;
diff --git a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
index 236e11755ba6..bde247f3c8a1 100644
--- a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
+++ b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
@@ -152,8 +152,9 @@ int main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
-	uint64_t gpa, pte;
+	uint64_t *pte;
 	uint64_t *hva;
+	uint64_t gpa;
 	int rc;
 
 	/* Tell stdout not to buffer its content */
@@ -178,8 +179,9 @@ int main(int argc, char *argv[])
 	virt_map(vm, MEM_REGION_GVA, MEM_REGION_GPA, 1);
 	hva = addr_gpa2hva(vm, MEM_REGION_GPA);
 	memset(hva, 0, PAGE_SIZE);
+
 	pte = vm_get_page_table_entry(vm, vcpu, MEM_REGION_GVA);
-	vm_set_page_table_entry(vm, vcpu, MEM_REGION_GVA, pte | (1ull << 36));
+	*pte |= BIT_ULL(MAXPHYADDR);
 
 	vcpu_run(vcpu);
 	process_exit_on_emulation_error(vcpu);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

