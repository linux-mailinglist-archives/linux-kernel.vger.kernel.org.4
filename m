Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C23647BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLIBxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiLIBxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:53:34 -0500
Received: from out-233.mta0.migadu.com (out-233.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A441D941AB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:53:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] KVM: selftests: Setup ucall after loading program into guest memory
Date:   Fri,  9 Dec 2022 01:53:01 +0000
Message-Id: <20221209015307.1781352-3-oliver.upton@linux.dev>
In-Reply-To: <20221209015307.1781352-1-oliver.upton@linux.dev>
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new ucall infrastructure needs to update a couple of guest globals
to pass through the ucall MMIO addr and pool of ucall structs. A
precondition of writing to the guest's program image is to have it
already loaded into guest memory.

Call ucall_init() after kvm_vm_elf_load(). Continue to park the ucall
MMIO addr after MEM_REGION_TEST_DATA.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/aarch64/page_fault_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index 92d3a91153b6..95d22cfb7b41 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -609,8 +609,13 @@ static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
 				    data_size / guest_page_size,
 				    p->test_desc->data_memslot_flags);
 	vm->memslots[MEM_REGION_TEST_DATA] = TEST_DATA_MEMSLOT;
+}
+
+static void setup_ucall(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region = vm_get_mem_region(vm, MEM_REGION_TEST_DATA);
 
-	ucall_init(vm, data_gpa + data_size);
+	ucall_init(vm, region->region.guest_phys_addr + region->region.memory_size);
 }
 
 static void setup_default_handlers(struct test_desc *test)
@@ -702,6 +707,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	vm = ____vm_create(mode);
 	setup_memslots(vm, p);
 	kvm_vm_elf_load(vm, program_invocation_name);
+	setup_ucall(vm);
 	vcpu = vm_vcpu_add(vm, 0, guest_code);
 
 	setup_gva_maps(vm);
-- 
2.39.0.rc1.256.g54fd8350bd-goog

