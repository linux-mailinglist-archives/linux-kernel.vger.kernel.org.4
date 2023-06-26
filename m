Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825E173DA82
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjFZIuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjFZIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:50:00 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46C0C26A0;
        Mon, 26 Jun 2023 01:48:20 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8BxU8TGUJlkZDUCAA--.3417S3;
        Mon, 26 Jun 2023 16:48:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxxsy5UJlk4hQJAA--.19269S31;
        Mon, 26 Jun 2023 16:48:05 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn,
        tangyouling@loongson.cn, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v15 29/30] LoongArch: KVM: Supplement kvm document about LoongArch-specific part
Date:   Mon, 26 Jun 2023 16:47:51 +0800
Message-Id: <20230626084752.1138621-30-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626084752.1138621-1-zhaotianrui@loongson.cn>
References: <20230626084752.1138621-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsy5UJlk4hQJAA--.19269S31
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supplement kvm document about LoongArch-specific part, such as add
api introduction for GET/SET_ONE_REG, GET/SET_FPU, GET/SET_MP_STATE,
etc.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 Documentation/virt/kvm/api.rst | 70 +++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index add067793b90..0bae97c63156 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -416,6 +416,13 @@ Reads the general purpose registers from the vcpu.
 	__u64 pc;
   };
 
+  /* LoongArch */
+  struct kvm_regs {
+	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
+        unsigned long gpr[32];
+        unsigned long pc;
+  };
+
 
 4.12 KVM_SET_REGS
 -----------------
@@ -506,7 +513,7 @@ translation mode.
 ------------------
 
 :Capability: basic
-:Architectures: x86, ppc, mips, riscv
+:Architectures: x86, ppc, mips, riscv, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_interrupt (in)
 :Returns: 0 on success, negative on failure.
@@ -592,6 +599,14 @@ b) KVM_INTERRUPT_UNSET
 
 This is an asynchronous vcpu ioctl and can be invoked from any thread.
 
+LOONGARCH:
+^^^^^^^^^^
+
+Queues an external interrupt to be injected into the virtual CPU. A negative
+interrupt number dequeues the interrupt.
+
+This is an asynchronous vcpu ioctl and can be invoked from any thread.
+
 
 4.17 KVM_DEBUG_GUEST
 --------------------
@@ -737,7 +752,7 @@ signal mask.
 ----------------
 
 :Capability: basic
-:Architectures: x86
+:Architectures: x86, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_fpu (out)
 :Returns: 0 on success, -1 on error
@@ -746,7 +761,7 @@ Reads the floating point state from the vcpu.
 
 ::
 
-  /* for KVM_GET_FPU and KVM_SET_FPU */
+  /* x86: for KVM_GET_FPU and KVM_SET_FPU */
   struct kvm_fpu {
 	__u8  fpr[8][16];
 	__u16 fcw;
@@ -761,12 +776,21 @@ Reads the floating point state from the vcpu.
 	__u32 pad2;
   };
 
+  /* LoongArch: for KVM_GET_FPU and KVM_SET_FPU */
+  struct kvm_fpu {
+        __u32 fcsr;
+        __u64 fcc;
+        struct kvm_fpureg {
+                __u64 val64[4];
+        }fpr[32];
+  };
+
 
 4.23 KVM_SET_FPU
 ----------------
 
 :Capability: basic
-:Architectures: x86
+:Architectures: x86, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_fpu (in)
 :Returns: 0 on success, -1 on error
@@ -775,7 +799,7 @@ Writes the floating point state to the vcpu.
 
 ::
 
-  /* for KVM_GET_FPU and KVM_SET_FPU */
+  /* x86: for KVM_GET_FPU and KVM_SET_FPU */
   struct kvm_fpu {
 	__u8  fpr[8][16];
 	__u16 fcw;
@@ -790,6 +814,15 @@ Writes the floating point state to the vcpu.
 	__u32 pad2;
   };
 
+  /* LoongArch: for KVM_GET_FPU and KVM_SET_FPU */
+  struct kvm_fpu {
+        __u32 fcsr;
+        __u64 fcc;
+        struct kvm_fpureg {
+                __u64 val64[4];
+        }fpr[32];
+  };
+
 
 4.24 KVM_CREATE_IRQCHIP
 -----------------------
@@ -1387,7 +1420,7 @@ documentation when it pops into existence).
 -------------------
 
 :Capability: KVM_CAP_ENABLE_CAP
-:Architectures: mips, ppc, s390, x86
+:Architectures: mips, ppc, s390, x86, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_enable_cap (in)
 :Returns: 0 on success; -1 on error
@@ -1442,7 +1475,7 @@ for vm-wide capabilities.
 ---------------------
 
 :Capability: KVM_CAP_MP_STATE
-:Architectures: x86, s390, arm64, riscv
+:Architectures: x86, s390, arm64, riscv, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_mp_state (out)
 :Returns: 0 on success; -1 on error
@@ -1460,7 +1493,7 @@ Possible values are:
 
    ==========================    ===============================================
    KVM_MP_STATE_RUNNABLE         the vcpu is currently running
-                                 [x86,arm64,riscv]
+                                 [x86,arm64,riscv,loongarch]
    KVM_MP_STATE_UNINITIALIZED    the vcpu is an application processor (AP)
                                  which has not yet received an INIT signal [x86]
    KVM_MP_STATE_INIT_RECEIVED    the vcpu has received an INIT signal, and is
@@ -1516,11 +1549,14 @@ For riscv:
 The only states that are valid are KVM_MP_STATE_STOPPED and
 KVM_MP_STATE_RUNNABLE which reflect if the vcpu is paused or not.
 
+On LoongArch, only the KVM_MP_STATE_RUNNABLE state is used to reflect
+whether the vcpu is runnable.
+
 4.39 KVM_SET_MP_STATE
 ---------------------
 
 :Capability: KVM_CAP_MP_STATE
-:Architectures: x86, s390, arm64, riscv
+:Architectures: x86, s390, arm64, riscv, loongarch
 :Type: vcpu ioctl
 :Parameters: struct kvm_mp_state (in)
 :Returns: 0 on success; -1 on error
@@ -1538,6 +1574,9 @@ For arm64/riscv:
 The only states that are valid are KVM_MP_STATE_STOPPED and
 KVM_MP_STATE_RUNNABLE which reflect if the vcpu should be paused or not.
 
+On LoongArch, only the KVM_MP_STATE_RUNNABLE state is used to reflect
+whether the vcpu is runnable.
+
 4.40 KVM_SET_IDENTITY_MAP_ADDR
 ------------------------------
 
@@ -2839,6 +2878,19 @@ Following are the RISC-V D-extension registers:
   0x8020 0000 0600 0020 fcsr      Floating point control and status register
 ======================= ========= =============================================
 
+LoongArch registers are mapped using the lower 32 bits. The upper 16 bits of
+that is the register group type.
+
+LoongArch csr registers are used to control guest cpu or get status of guest
+cpu, and they have the following id bit patterns::
+
+  0x9030 0000 0001 00 <reg:5> <sel:3>   (64-bit)
+
+LoongArch KVM control registers are used to implement some new defined functions
+such as set vcpu counter or reset vcpu, and they have the following id bit patterns::
+
+  0x9030 0000 0002 <reg:16>
+
 
 4.69 KVM_GET_ONE_REG
 --------------------
-- 
2.39.1

