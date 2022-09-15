Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275805B9177
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiIOAFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiIOAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:05:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0847714D0C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:05:03 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e187-20020a6369c4000000b0041c8dfb8447so8189532pgc.23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=wHYZTxyAGx9pdQAcCVui/YtY/xjqmCAf1YOadQ9i5/0=;
        b=gbLFlFvPXtP6TXNby7OllfZ9N4HBF6G1L43fc4Iyjnuh9l317ciioiooS/FhMqHLcI
         FFKo6Z0gME9FS3RZehnMuA4D30ws/x4K2BjJX9bc0znkrZj8zpbGB7UY3B4K4X0CvWyM
         FJiWRAaN+ByVzFNcSny1fm6gDicZW0lxuK9ZCR5WFPnBDJlkXgcSF2TsRkwO/e/c7IGu
         wGST+xCaiKLMRvcU/MzTgaopt6pQg9/4jPgDFf6mHYb35cVpZz8AKZPYvwNpmULM+BdJ
         2YtKC4D7RqyKl42lib3pvuhNdLzdzajQq3B1Kw9IvXbONPebg2i/hE1c/VzeQhTqlm2J
         A8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=wHYZTxyAGx9pdQAcCVui/YtY/xjqmCAf1YOadQ9i5/0=;
        b=cVDP3yzY2aPQbLcbG1Jg+HZJ5JmOFZwN80Zgz4M7GeGfZ5QypAw0tTYugnF1AM15au
         Un1Qb2pF+GLrx/nI3OPEP+DNzE7e35pUGkziP+5R9gctZw3SEcmi5fWcnLKzXrn0vCtR
         VHlc8AmGotZO+sDmMtS/egp4PSWRr9TEe15JldLFNfiGKSrUhBsQVrzX3qD9jpCUrtjr
         i9reDqqI/l4ahh6H+O6+gDMX12c4SFm3etrPARlJKTpS37EdBqjvbzzpRW+1D2nDm2pD
         5Fkb3GHxGfgaH7nYUuJwVl7MG/BORV2o2vfqv0Iyns6QLNqMNvXAlfPFLkE9Abz3TX9e
         Qc8Q==
X-Gm-Message-State: ACrzQf3ee6kACKyKuWKD7c0dR/W6Udw3Y16hVv85muDXwHXrhgP+i2Zn
        A7mTbpDA0HesDh7e7XjXdoFcgCLMDn5SImQ1
X-Google-Smtp-Source: AMsMyM686KHHkmbDSKxbFztZuMtfsUvL0/uqvmJDi1n43H4qJ3FJxBZEQdoaI3e9i1dqLmxjW4nSzzFmdrcbYO4H
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:1bc4:b0:202:fbd0:8e86 with SMTP
 id oa4-20020a17090b1bc400b00202fbd08e86mr7603861pjb.52.1663200303049; Wed, 14
 Sep 2022 17:05:03 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:04:45 +0000
In-Reply-To: <20220915000448.1674802-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915000448.1674802-6-vannapurve@google.com>
Subject: [V2 PATCH 5/8] KVM: selftests: x86: delete svm_vmcall_test
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svm_vmcall_test is superseded by fix_hypercall_test.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |  1 -
 .../selftests/kvm/x86_64/svm_vmcall_test.c    | 74 -------------------
 2 files changed, 75 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index d625a3f83780..22e9a5b5488c 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -36,7 +36,6 @@
 /x86_64/sev_migrate_tests
 /x86_64/smm_test
 /x86_64/state_test
-/x86_64/svm_vmcall_test
 /x86_64/svm_int_ctl_test
 /x86_64/svm_nested_soft_inject_test
 /x86_64/sync_regs_test
diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
deleted file mode 100644
index c3ac45df7483..000000000000
--- a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * svm_vmcall_test
- *
- * Copyright (C) 2020, Red Hat, Inc.
- *
- * Nested SVM testing: VMCALL
- */
-
-#include "test_util.h"
-#include "kvm_util.h"
-#include "processor.h"
-#include "svm_util.h"
-
-static void l2_guest_code(struct svm_test_data *svm)
-{
-	__asm__ __volatile__("vmcall");
-}
-
-static void l1_guest_code(struct svm_test_data *svm)
-{
-	#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-	struct vmcb *vmcb = svm->vmcb;
-
-	/* Prepare for L2 execution. */
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
-
-	run_guest(vmcb, svm->vmcb_gpa);
-
-	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
-	GUEST_DONE();
-}
-
-int main(int argc, char *argv[])
-{
-	struct kvm_vcpu *vcpu;
-	vm_vaddr_t svm_gva;
-	struct kvm_vm *vm;
-
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
-
-	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
-
-	vcpu_alloc_svm(vm, &svm_gva);
-	vcpu_args_set(vcpu, 1, svm_gva);
-
-	for (;;) {
-		volatile struct kvm_run *run = vcpu->run;
-		struct ucall uc;
-
-		vcpu_run(vcpu);
-		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
-			    run->exit_reason,
-			    exit_reason_str(run->exit_reason));
-
-		switch (get_ucall(vcpu, &uc)) {
-		case UCALL_ABORT:
-			REPORT_GUEST_ASSERT(uc);
-			/* NOT REACHED */
-		case UCALL_SYNC:
-			break;
-		case UCALL_DONE:
-			goto done;
-		default:
-			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
-		}
-	}
-done:
-	kvm_vm_free(vm);
-	return 0;
-}
-- 
2.37.2.789.g6183377224-goog

