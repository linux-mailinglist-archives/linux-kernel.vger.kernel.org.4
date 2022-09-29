Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E435EEA36
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiI1Xhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiI1XhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:37:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C6F1910
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:37:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k2-20020a170902c40200b001782bd6c416so9144977plk.20
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=Od/67DGfgSZdEk0wltT/TSsm6XolwmXbW+lbYagDoWo=;
        b=XzIVUy26GrCltEvq+B8Fi+I95dgx07XyVD742iCpjVYeLCfh8Z68YuSLk+o4Y8n0yY
         WvywMCozmLkVsTKzeUc6yqeR3scqPyvBLIyyUoF8Rh3wvJryo5rD5mNXERMShAyWW5SX
         1cfGBK4W0TeAXEP7URjKTLvBNWvzIux3DnIbnE4Nkmvn/LzX+whLUL9tEYDp0KPWAOV/
         dS1NJh4PgI0jSr3g/xERgWcQi/QEkQxV0PAUoZaIaAAmXchWKzPDCaRLqTyZChBz/ARe
         IpZV6e0dTaG0nVmlENgoI+nMsMHzPHajf+jfKPLlnaLaf3jcW/fKf4W8e6JQv4oR19+q
         Vvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=Od/67DGfgSZdEk0wltT/TSsm6XolwmXbW+lbYagDoWo=;
        b=Iy+zD6AeLMA5ZeCdMUpC4sREfkVPUFB7Zd3GwG75/P8gXnT63RB5R4U2ToZULV7otO
         0w9gUxLCO/zT4ry7euB9yIeFtNXPFxNZpXd3fwAAe4cMEdiIGKjWtcwhgwSKL8pc+iMj
         2M8naxxDn+AGX2sRMB51vGG0vTiEu5k2VbBwDE+wze2ZTUkTfhTR8xIxuySTVRvXfpoY
         8EUhaK8EDlAQyHGQ21Cpf3b81I9SKzuJanRyt+HO6TBxa8vL4S8UsMr7P1MEjc08EldL
         otndmphzJplfXuMaRuVNaeJ2xaCm+2ctMd1evBvI8dFG0xYtbc85ftOoOHYzmxM7/vbe
         WQdQ==
X-Gm-Message-State: ACrzQf2UiZyQht6XxbUJvfpzKbhL4oBs9srOVCldlRaquwpuVtxO55nI
        jX3IYYyxH8K7kzbktT44BkhFNEgJ2CE=
X-Google-Smtp-Source: AMsMyM5zJT1Nj1nzZ5R05TcpmNKxRck0zM4yF/L/JbUVM5GJqLR+hU0xD5VCJG+SWpF+AAqpJoQ8XUanJsg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:33c9:b0:200:a0ca:e6c8 with SMTP id
 lk9-20020a17090b33c900b00200a0cae6c8mr12941934pjb.147.1664408224370; Wed, 28
 Sep 2022 16:37:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 28 Sep 2022 23:36:51 +0000
In-Reply-To: <20220928233652.783504-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220928233652.783504-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220928233652.783504-7-seanjc@google.com>
Subject: [PATCH v2 6/7] KVM: selftests: Dedup subtests of fix_hypercall_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Jones <andrew.jones@linux.dev>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jim Mattson <jmattson@google.com>
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

Combine fix_hypercall_test's two subtests into a common routine, the only
difference between the two is whether or not the quirk is disabled.
Passing a boolean is a little gross, but using an enum to make it super
obvious that the callers are enabling/disabling the quirk seems like
overkill.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 .../selftests/kvm/x86_64/fix_hypercall_test.c | 45 ++++++-------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 10b9482fc4d7..32f7e09ef67c 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -17,7 +17,7 @@
 /* VMCALL and VMMCALL are both 3-byte opcodes. */
 #define HYPERCALL_INSN_SIZE	3
 
-static bool ud_expected;
+static bool quirk_disabled;
 
 static void guest_ud_handler(struct ex_regs *regs)
 {
@@ -70,7 +70,7 @@ static void guest_main(void)
 	 * enabled, verify that the hypercall succeeded and that KVM patched in
 	 * the "right" hypercall.
 	 */
-	if (ud_expected) {
+	if (quirk_disabled) {
 		GUEST_ASSERT(ret == (uint64_t)-EFAULT);
 		GUEST_ASSERT(!memcmp(other_hypercall_insn, hypercall_insn,
 			     HYPERCALL_INSN_SIZE));
@@ -83,13 +83,6 @@ static void guest_main(void)
 	GUEST_DONE();
 }
 
-static void setup_ud_vector(struct kvm_vcpu *vcpu)
-{
-	vm_init_descriptor_tables(vcpu->vm);
-	vcpu_init_descriptor_tables(vcpu);
-	vm_install_exception_handler(vcpu->vm, UD_VECTOR, guest_ud_handler);
-}
-
 static void enter_guest(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -110,35 +103,23 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void test_fix_hypercall(void)
+static void test_fix_hypercall(bool disable_quirk)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
-	setup_ud_vector(vcpu);
 
-	ud_expected = false;
-	sync_global_to_guest(vm, ud_expected);
+	vm_init_descriptor_tables(vcpu->vm);
+	vcpu_init_descriptor_tables(vcpu);
+	vm_install_exception_handler(vcpu->vm, UD_VECTOR, guest_ud_handler);
 
-	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	if (disable_quirk)
+		vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
+			      KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
 
-	enter_guest(vcpu);
-}
-
-static void test_fix_hypercall_disabled(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-
-	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
-	setup_ud_vector(vcpu);
-
-	vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
-		      KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
-
-	ud_expected = true;
-	sync_global_to_guest(vm, ud_expected);
+	quirk_disabled = disable_quirk;
+	sync_global_to_guest(vm, quirk_disabled);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
@@ -149,6 +130,6 @@ int main(void)
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
 
-	test_fix_hypercall();
-	test_fix_hypercall_disabled();
+	test_fix_hypercall(false);
+	test_fix_hypercall(true);
 }
-- 
2.37.3.998.g577e59143f-goog

