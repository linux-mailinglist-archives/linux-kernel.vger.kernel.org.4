Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8639676218
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjAUARy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjAUARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:17:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B8CD21A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:17:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z9-20020a25ba49000000b007d4416e3667so7512930ybj.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6BV0YtQOiNrXMV5swymIknunfTEIhtzL+zfELVN7Ms=;
        b=l8az0f+ywIP6e260BtoZwU44Fhm7IcULO1Flblv5y1Y1LiZ/y7PKDffHyKWKkcxHNw
         KOWmv7uS/Xfu2NSm939NvnzW3uaCNDPHjv3W+IMXLDeZMzkhAJUE7lGBu2dPlPjNSPfL
         DeI6hQcFAF7QmYLhhlPjaOcp0Znt2M0/BEL4oesWn4F7j5jGAZm8nZ80ZtRDMmujgf+C
         CvkFThYu+v7NFEn7rLXXegNqaj9Jzw6M+w46LW8ueek/hizCwJecgABJOY/9v7PurAmZ
         yK/F1qsOl1p/Aoo8e7ext2gE2Q+0az8TOUQkMfg3cT/Ym33fPBlOkFZ+rX3yTSThtExj
         Rq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6BV0YtQOiNrXMV5swymIknunfTEIhtzL+zfELVN7Ms=;
        b=mhmRJhdPATaurKRiQsLENxdL/CGVUswUrMgy8A3JmX537tAGUGL6heef1+H/shqEdX
         kooqWDnAvO+CFKXPjzRSzL/6wrrNENZF920ZoKIIj05W60Tq8858nNO5JC4VRTTFOMyh
         Xxgbhsjq1dOtt3QWzJxzF6qW+qkpKP8TawfZKO4ZWqpsYein5a5y7hvJBAv4PP7KuLKA
         SwuFcJ+3OGDHcEOCcOBPMPZQXes9Uo21rp10ekw1DaHgKduZrV7ATbZvUcE0sp68t/2h
         ayhyvd2/OMNn4epbHKt4TNf4nO8eEpF54ZzufYBpMi/KVyNCD+jNMDCHe/Fuecwgr1BE
         WxHg==
X-Gm-Message-State: AFqh2kpzX8u8dTqmix1cnHdPazcDnHwtG4RsfQZ8w1pDBeSDEZKtPM2v
        ztXuSYX8Hhxago4N0i3MTtwDAU0aFpkcLNH9tg==
X-Google-Smtp-Source: AMrXdXufsM1UYiyJ7fOSO4EaXsXUPYSCdlhfrRAC6atQl4aixkchwbE7r5eeo2uBnFLuw4tNY0+2jTPRJ9IPEu7WMQ==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a5b:a0b:0:b0:6fb:42d2:69e4 with SMTP
 id k11-20020a5b0a0b000000b006fb42d269e4mr1808452ybq.436.1674260233016; Fri,
 20 Jan 2023 16:17:13 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:25 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-15-ackerleytng@google.com>
Subject: [RFC PATCH v3 14/31] KVM: selftests: TDX: Add TDX IO writes test
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test verifies IO writes of various sizes from the guest to the host.


Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  3 +
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 91 +++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
index 78001bfec9c8d..b5e94b7c48fa5 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
@@ -10,6 +10,9 @@
 #define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
 #define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
 
+#define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
+#define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
+
 #define TDX_HCALL_HAS_OUTPUT BIT(0)
 
 #define TDX_HYPERCALL_STANDARD 0
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 188442a734dca..ac23d1ad1e687 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -338,6 +338,96 @@ void verify_get_td_vmcall_info(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IO_WRITES_TEST_PORT 0x51
+
+/*
+ * Verifies IO functionality by writing values of different sizes
+ * to the host.
+ */
+void guest_io_writes(void)
+{
+	uint64_t byte_1 = 0xAB;
+	uint64_t byte_2 = 0xABCD;
+	uint64_t byte_4 = 0xFFABCDEF;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_1);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 2,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_2);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 4,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_4);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	// Write an invalid number of bytes.
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 5,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_4);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_writes(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint8_t byte_1;
+	uint16_t byte_2;
+	uint32_t byte_4;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_writes);
+	td_finalize(vm);
+
+	printf("Verifying guest writes:\n");
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_1 = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 2,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_2 = *(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_4 = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	ASSERT_EQ(byte_1, 0xAB);
+	ASSERT_EQ(byte_2, 0xABCD);
+	ASSERT_EQ(byte_4, 0xFFABCDEF);
+
+	vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -352,6 +442,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_ioexit);
 	run_in_new_process(&verify_td_cpuid);
 	run_in_new_process(&verify_get_td_vmcall_info);
+	run_in_new_process(&verify_guest_writes);
 
 	return 0;
 }
-- 
2.39.0.246.g2a6d74b583-goog

