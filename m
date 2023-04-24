Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52856E84BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjDSWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjDSWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:20:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357959031
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5465fb99so383339b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942716; x=1684534716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1210zPiD8zHFMhzBINzpx5nEW8Eoe5MAD0zhuCIRKc=;
        b=ANhU+J8nQWq2obESgBEJE0X9NLT82kBUBDzc1BRbSeZ1EgPeiOl0GddoyWaEPDRU8N
         vnwjEIo0UjaS9xezvAc/UGttMWlJo7ew/iqSZCawFdCpXkbeL6whYMnxnv1UE0Mkzjl9
         zxU19X9QWwNQwOpt5WP+CxQUT1ZA3xUcznURR03bnG+WcdbBRPDMOVkCCCi+rkT0f8qL
         85oGYhbbNz2xb1HJWq0YwM9QGXFDFKbWMgSuumHQ7xfEhCPnY/6ETL+ra68ruaG7yl2u
         qOhetkOJdoWKqEsNNxd/aiUVnUUF2SqhhyrAmB8w+eSk+hd8cQeWPbuaUf1XaZLgT9mw
         WXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942716; x=1684534716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1210zPiD8zHFMhzBINzpx5nEW8Eoe5MAD0zhuCIRKc=;
        b=h7pLfOB117/X7oGF2apEWXIzTKjvVGQR2kZRFI3j6IVPEsgQ+tNRAYmkBIDrktHsob
         FGPH9MZDygBqr8PkPWtHmbfnqc+LZFJ062eMfmXnFfNJBOUJcfWqDqskisRPlrbTi3P0
         FXtTQ2aWqx3ru73bJKGTCUlJeH3VEslDvHQYyn1x9V4AcTKGDfTFn1XbEfR+lYLFALMZ
         qV76vwLQ/rEmKQaM5M6XcVaCalVitonZLR+G2YPaoyFOvmACRoUUx5hHfWViGyC1HTv2
         lS1rB9RxzXvsZkH4KiRbOgtQ1gkLZ1xw79hoURWrtSqf1eKeLzCp8hZcNxI3uP/SqjZD
         u59g==
X-Gm-Message-State: AAQBX9c+najO4s4EGCbNVlR5g8P3YaMWP3tuQ5Zqk+5YPN69BrcRtznx
        UbHACBd87Vsq6fulwhqIv4GwcNvXPfabCJTxDfg=
X-Google-Smtp-Source: AKy350YnFYoQc/AGMgRzA7K3To1EBVIiHBUS1P/8MWh29k47wvhKo2iefk2kUhAwoVQIoToGy+/bcA==
X-Received: by 2002:a17:903:1c4:b0:1a1:ee8c:eeba with SMTP id e4-20020a17090301c400b001a1ee8ceebamr7881066plh.59.1681942715856;
        Wed, 19 Apr 2023 15:18:35 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:35 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC 30/48] RISC-V: KVM: Perform limited operations in hardware enable/disable
Date:   Wed, 19 Apr 2023 15:16:58 -0700
Message-Id: <20230419221716.3603068-31-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419221716.3603068-1-atishp@rivosinc.com>
References: <20230419221716.3603068-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware enable/disable path only need to perform AIA/NACL enable/disable
for TVMs. All other operations i.e. interrupt/exception delegation,
counter access must be provided by the TSM as host doesn't have control
of these operations for a TVM.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 45ee62d..842b78d 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -13,6 +13,7 @@
 #include <asm/hwcap.h>
 #include <asm/kvm_nacl.h>
 #include <asm/sbi.h>
+#include <asm/kvm_cove.h>
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg)
@@ -29,6 +30,15 @@ int kvm_arch_hardware_enable(void)
 	if (rc)
 		return rc;
 
+	/*
+	 * We just need to invoke aia enable for CoVE if host is in VS mode
+	 * However, if the host is running in HS mode, we need to initialize
+	 * other CSRs as well for legacy VMs.
+	 * TODO: Handle host in HS mode use case.
+	 */
+	if (unlikely(kvm_riscv_cove_enabled()))
+		goto enable_aia;
+
 	hedeleg = 0;
 	hedeleg |= (1UL << EXC_INST_MISALIGNED);
 	hedeleg |= (1UL << EXC_BREAKPOINT);
@@ -49,6 +59,7 @@ int kvm_arch_hardware_enable(void)
 
 	csr_write(CSR_HVIP, 0);
 
+enable_aia:
 	kvm_riscv_aia_enable();
 
 	return 0;
@@ -58,6 +69,8 @@ void kvm_arch_hardware_disable(void)
 {
 	kvm_riscv_aia_disable();
 
+	if (unlikely(kvm_riscv_cove_enabled()))
+		goto disable_nacl;
 	/*
 	 * After clearing the hideleg CSR, the host kernel will receive
 	 * spurious interrupts if hvip CSR has pending interrupts and the
@@ -69,6 +82,7 @@ void kvm_arch_hardware_disable(void)
 	csr_write(CSR_HEDELEG, 0);
 	csr_write(CSR_HIDELEG, 0);
 
+disable_nacl:
 	kvm_riscv_nacl_disable();
 }
 
-- 
2.25.1

