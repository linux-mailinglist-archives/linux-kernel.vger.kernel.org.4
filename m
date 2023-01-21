Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D76C676205
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAUARB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjAUAQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:16:59 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F6CC4E83
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:16:33 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id s24-20020a17090aa11800b00229fef3ac5dso2106641pjp.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QxiTKLEOm+oMFK9aaHGMPXI17btDBmCLc/NZqm71Tbk=;
        b=ltg8p9DEmbRdkxoxc6sGLalH7h0V44/ZmiZXmsQJH6kv+DbmFIWf5KGM42u6kDqI1C
         kJrNb8zRDReE8eeRiN8umkJCpsFiX+UYIu+pGuoluI1Zuek9LVJsFIykRih4Xw1SQm72
         OIcEima7xZ1R1ZJYnf0j5FZPl6Dr94ZMPGNKFmBeR+L8GqvRWIx0t0Y7l8uAFFjkt/Gg
         j1fv9SYiKYWxSPStjIQRcJAwCJFpf+iEOWEw4MwV70sQfJN7vm9CGFM1/JzgS4MEn3td
         dcgTt8nvI3TeKTgF0Af3BzAV/Ox4IwvVmxyRyqYz7fbV6XDJoOorffqL27rXS6JNXrWd
         xFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxiTKLEOm+oMFK9aaHGMPXI17btDBmCLc/NZqm71Tbk=;
        b=NEZYa6KRsJ98WH5EeJg26ZYkb22fV3cjd/psxFwMV74oaN4+rTIPJrZjakLdXFHNwN
         zCZpuCJibICjytWE6uKpK49181AT77pOHi3BDcjwO80dhWGqBth3TZK1GWwC9MFELT7u
         qUJ2vkOIpFRj3gGGjpP7dxEr2gdYPH40YPfyplYQTgkU8yXrgTbi7xX9eXEEpizUIB1c
         Y73bmE0MIJH3lukuDshMWainor2eYgHa1WcA6T2M5CMJuHR8HjgZkiJNp4F17Dq2aOEa
         zNVLg4G0DUpq7a972FnDxZR7+CEC+dP1zbq4QhS6kSAuwWvCoyvvXd9K6C517FlYzrs9
         YXjA==
X-Gm-Message-State: AFqh2kp0e2xAAtJu7R+c09fJ5Sm/gEBl0NX7JrjH5LyJ6RzIg23JX3Fv
        yAAiULmm1ZLu6hAZoAQQrrc6rn858h6cvEqOXA==
X-Google-Smtp-Source: AMrXdXv3LAmIr5JKeM8fvEWbKjfhX1gzLGtTUG4MGSdye8JI6uNnwFl9V9QefgMRzXdW7pmlEuZDNWb1BB8eEn9p6w==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:9a81:b0:194:6f35:db45 with
 SMTP id w1-20020a1709029a8100b001946f35db45mr1817207plp.27.1674260192836;
 Fri, 20 Jan 2023 16:16:32 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:16 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-6-ackerleytng@google.com>
Subject: [RFC PATCH v3 05/31] KVM: selftests: Refactor steps in vCPU
 descriptor table initialization
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
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

Split the vCPU descriptor table initialization process into a few
steps and expose them:

+ Setting up the IDT
+ Syncing exception handlers into the guest

In kvm_setup_idt(), we conditionally allocate guest memory for vm->idt
to avoid double allocation when kvm_setup_idt() is used after
vm_init_descriptor_tables().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  2 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 74e0d3698f30c..abaaab4d885c1 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -750,6 +750,8 @@ struct ex_regs {
 	uint64_t rflags;
 };
 
+void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt);
+void sync_exception_handlers_to_guest(struct kvm_vm *vm);
 void vm_init_descriptor_tables(struct kvm_vm *vm);
 void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 3046b555fee49..1ea1019d48c13 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1174,19 +1174,32 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
 			DEFAULT_CODE_SELECTOR);
 }
 
+void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt)
+{
+	if (!vm->idt)
+		vm->idt = vm_vaddr_alloc_page(vm);
+
+	dt->base = vm->idt;
+	dt->limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+}
+
+void sync_exception_handlers_to_guest(struct kvm_vm *vm)
+{
+	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+}
+
 void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vm *vm = vcpu->vm;
 	struct kvm_sregs sregs;
 
 	vcpu_sregs_get(vcpu, &sregs);
-	sregs.idt.base = vm->idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	kvm_setup_idt(vcpu->vm, &sregs.idt);
 	sregs.gdt.base = vm->gdt;
 	sregs.gdt.limit = getpagesize() - 1;
 	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
 	vcpu_sregs_set(vcpu, &sregs);
-	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+	sync_exception_handlers_to_guest(vm);
 }
 
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
-- 
2.39.0.246.g2a6d74b583-goog

