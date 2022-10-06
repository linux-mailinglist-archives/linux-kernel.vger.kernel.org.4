Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FDE5F5DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJFAe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJFAeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:34:19 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B0C86886
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:34:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 69-20020a630148000000b0043bbb38f75bso187418pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyz+ls9SzvDB0IvQmenZjlUIosIc2LDHAdTvYwIgnJ8=;
        b=kHeHb1YMAO78AphiKKV5QPgfcpCxJabS7hQX9eymBKfV1NmRhoFW5qLcwdu/aXjwMQ
         eab9kr5t8HNGzMR2yJtIi3E1tbxBq3l2iCu0ZRJBQUC/J6AwVkjvAvEu9+jWLPGCkHFm
         GyumDVwqL5t3OfsCQh4FOdIhcfeUoKDrNLMZBoEmAdoAWRkC9wx4wH0ym4X3HIKQ4wwK
         zTAhKBJQae/KJJ5tGeRzWIQTURQuEX255Kpg9kUYPeEmm9iEfVakYxDArg+pSR02zFRm
         4Fo6PpSpv6rvTgNKkWvnt/01xsstUS5AbVeMT9OQkSTWN+PGGrPYPWXayeJnkV1C78FE
         GUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uyz+ls9SzvDB0IvQmenZjlUIosIc2LDHAdTvYwIgnJ8=;
        b=Go0DllS3WfGxaeWOtmunVQANMB2rKeh7j5PFYIqQpqqU/RwawVdKBThSDU0/Z1sErW
         zkjLaF/m7IMFoFMp8a2xb2xDkdImtJX7n19tRA+O6xJYZF4JWzoIFHFhiL5yZ+n2elwz
         kFxijsVsLjB447XIrp0K4YSt3ydEqf6N67xFEcurHg5VceSF0ekz12OQE8aRfoEFTeZI
         jH1gE19sNao12DYYutVlu4JqWiiArI07/ZRM3rDiFV0Xa6E77aTSY3QZ7d8NiXHoXAcf
         LpzRNdDX6MtZXrUHKUf3CQsbHZTCD8TKSJRz1WPm2LbSgYtPIFFyWW/dkjc1sCErYdTd
         jI8Q==
X-Gm-Message-State: ACrzQf0U7LNAfg1jPi7UlZmExml1Kyz6M/J0QXcFnRadTv3sT02G5a6Z
        uqqZGyJ9FQKPEn6Kt/We64yhIxxOpTU=
X-Google-Smtp-Source: AMsMyM6/nTsMR7mog9QNPYiNKe4XQJEjVHCqrl0WxSqAaPPxmAm8kr9I2iQTFbpiOIqXqQMJ8t3sFBomyjA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2a4:b0:561:b88f:e723 with SMTP id
 q4-20020a056a0002a400b00561b88fe723mr2405162pfs.48.1665016457245; Wed, 05 Oct
 2022 17:34:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:34:04 +0000
In-Reply-To: <20221006003409.649993-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006003409.649993-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006003409.649993-3-seanjc@google.com>
Subject: [PATCH v6 2/7] KVM: selftests: Consolidate boilerplate code in get_ucall()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Peter Gonda <pgonda@google.com>,
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

Consolidate the actual copying of a ucall struct from guest=>host into
the common get_ucall().  Return a host virtual address instead of a guest
virtual address even though the addr_gva2hva() part could be moved to
get_ucall() too.  Conceptually, get_ucall() is invoked from the host and
should return a host virtual address (and returning NULL for "nothing to
see here" is far superior to returning 0).

Use pointer shenanigans instead of an unnecessary bounce buffer when the
caller of get_ucall() provides a valid pointer.

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Tested-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/ucall_common.h      |  8 ++------
 .../testing/selftests/kvm/lib/aarch64/ucall.c | 14 +++-----------
 tools/testing/selftests/kvm/lib/riscv/ucall.c | 19 +++----------------
 tools/testing/selftests/kvm/lib/s390x/ucall.c | 16 +++-------------
 .../testing/selftests/kvm/lib/ucall_common.c  | 19 +++++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/ucall.c  | 16 +++-------------
 6 files changed, 33 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 5a85f5318bbe..63bfc60be995 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -27,9 +27,10 @@ struct ucall {
 void ucall_arch_init(struct kvm_vm *vm, void *arg);
 void ucall_arch_uninit(struct kvm_vm *vm);
 void ucall_arch_do_ucall(vm_vaddr_t uc);
-uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
 
 void ucall(uint64_t cmd, int nargs, ...);
+uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
 
 static inline void ucall_init(struct kvm_vm *vm, void *arg)
 {
@@ -41,11 +42,6 @@ static inline void ucall_uninit(struct kvm_vm *vm)
 	ucall_arch_uninit(vm);
 }
 
-static inline uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
-{
-	return ucall_arch_get_ucall(vcpu, uc);
-}
-
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
 #define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index 3630708c32d6..f214f5cc53d3 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -75,13 +75,9 @@ void ucall_arch_do_ucall(vm_vaddr_t uc)
 	WRITE_ONCE(*ucall_exit_mmio_addr, uc);
 }
 
-uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	struct ucall ucall = {};
-
-	if (uc)
-		memset(uc, 0, sizeof(*uc));
 
 	if (run->exit_reason == KVM_EXIT_MMIO &&
 	    run->mmio.phys_addr == (uint64_t)ucall_exit_mmio_addr) {
@@ -90,12 +86,8 @@ uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 		TEST_ASSERT(run->mmio.is_write && run->mmio.len == 8,
 			    "Unexpected ucall exit mmio address access");
 		memcpy(&gva, run->mmio.data, sizeof(gva));
-		memcpy(&ucall, addr_gva2hva(vcpu->vm, gva), sizeof(ucall));
-
-		vcpu_run_complete_io(vcpu);
-		if (uc)
-			memcpy(uc, &ucall, sizeof(ucall));
+		return addr_gva2hva(vcpu->vm, gva);
 	}
 
-	return ucall.cmd;
+	return NULL;
 }
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index b1598f418c1f..37e091d4366e 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -51,27 +51,15 @@ void ucall_arch_do_ucall(vm_vaddr_t uc)
 		  uc, 0, 0, 0, 0, 0);
 }
 
-uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	struct ucall ucall = {};
-
-	if (uc)
-		memset(uc, 0, sizeof(*uc));
 
 	if (run->exit_reason == KVM_EXIT_RISCV_SBI &&
 	    run->riscv_sbi.extension_id == KVM_RISCV_SELFTESTS_SBI_EXT) {
 		switch (run->riscv_sbi.function_id) {
 		case KVM_RISCV_SELFTESTS_SBI_UCALL:
-			memcpy(&ucall,
-			       addr_gva2hva(vcpu->vm, run->riscv_sbi.args[0]),
-			       sizeof(ucall));
-
-			vcpu_run_complete_io(vcpu);
-			if (uc)
-				memcpy(uc, &ucall, sizeof(ucall));
-
-			break;
+			return addr_gva2hva(vcpu->vm, run->riscv_sbi.args[0]);
 		case KVM_RISCV_SELFTESTS_SBI_UNEXP:
 			vcpu_dump(stderr, vcpu, 2);
 			TEST_ASSERT(0, "Unexpected trap taken by guest");
@@ -80,6 +68,5 @@ uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 			break;
 		}
 	}
-
-	return ucall.cmd;
+	return NULL;
 }
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
index 114cb4af295f..0f695a031d35 100644
--- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -20,13 +20,9 @@ void ucall_arch_do_ucall(vm_vaddr_t uc)
 	asm volatile ("diag 0,%0,0x501" : : "a"(uc) : "memory");
 }
 
-uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	struct ucall ucall = {};
-
-	if (uc)
-		memset(uc, 0, sizeof(*uc));
 
 	if (run->exit_reason == KVM_EXIT_S390_SIEIC &&
 	    run->s390_sieic.icptcode == 4 &&
@@ -34,13 +30,7 @@ uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 	    (run->s390_sieic.ipb >> 16) == 0x501) {
 		int reg = run->s390_sieic.ipa & 0xf;
 
-		memcpy(&ucall, addr_gva2hva(vcpu->vm, run->s.regs.gprs[reg]),
-		       sizeof(ucall));
-
-		vcpu_run_complete_io(vcpu);
-		if (uc)
-			memcpy(uc, &ucall, sizeof(ucall));
+		return addr_gva2hva(vcpu->vm, run->s.regs.gprs[reg]);
 	}
-
-	return ucall.cmd;
+	return NULL;
 }
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 2395c7f1d543..ced480860746 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -18,3 +18,22 @@ void ucall(uint64_t cmd, int nargs, ...)
 
 	ucall_arch_do_ucall((vm_vaddr_t)&uc);
 }
+
+uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+{
+	struct ucall ucall;
+	void *addr;
+
+	if (!uc)
+		uc = &ucall;
+
+	addr = ucall_arch_get_ucall(vcpu);
+	if (addr) {
+		memcpy(uc, addr, sizeof(*uc));
+		vcpu_run_complete_io(vcpu);
+	} else {
+		memset(uc, 0, sizeof(*uc));
+	}
+
+	return uc->cmd;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index 9f532dba1003..ead9946399ab 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -22,25 +22,15 @@ void ucall_arch_do_ucall(vm_vaddr_t uc)
 		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
 }
 
-uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	struct ucall ucall = {};
-
-	if (uc)
-		memset(uc, 0, sizeof(*uc));
 
 	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
 		struct kvm_regs regs;
 
 		vcpu_regs_get(vcpu, &regs);
-		memcpy(&ucall, addr_gva2hva(vcpu->vm, (vm_vaddr_t)regs.rdi),
-		       sizeof(ucall));
-
-		vcpu_run_complete_io(vcpu);
-		if (uc)
-			memcpy(uc, &ucall, sizeof(ucall));
+		return addr_gva2hva(vcpu->vm, regs.rdi);
 	}
-
-	return ucall.cmd;
+	return NULL;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

