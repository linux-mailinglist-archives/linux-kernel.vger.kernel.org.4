Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D066E84B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjDSWVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjDSWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:20:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011C46B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b73203e0aso2785832b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942713; x=1684534713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzHgRd9E4939KzL4yVjhGODBFacgyWrf3hGucLzcUO8=;
        b=5j01fN0ij/sx5aznVSQ+84ebob97Uk9ftFvgEXxpPwjhV5dco0Y79w6bw9ez6K4LUG
         x4ifblG/7m++Uyimmc36fD0O2cl/AoZnom3oZdZMqItGTqYdBH4OIN/teuA3aWTggftI
         cpfXd7inCZOHfFSvtG6jQH1j/NF3x6zzJYA/BAWcjUuRPw/Oif2Cfb9K4X/RvX3EuV6I
         rB2tIUmFeiD583OWXUG9/aKVA+9N3U2MddLb8BWDGvrP++iluedDlml9YMOSTGq8prU7
         8uZJLu/6wc33TCPOi7KP6620z50VzFYs35XGvSNltrv2JUItl6JoRg3XUUwIodj1A03e
         LxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942713; x=1684534713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzHgRd9E4939KzL4yVjhGODBFacgyWrf3hGucLzcUO8=;
        b=Zv3ZHZ5vrb/kyemrl7F2yTiCuVvPxKZfqGZaLsoZWuEt/fzByrAn9T/1Qh3YM8z78F
         rwfVVsJ32J7JqqdFnGriUJfH7unTcDFGaWtbzyebsyW0J8YeziROdBWvb5i1mUrXIKVv
         JmjdWs9hvykQk8tRZQ/InDiOZqzRLQxVzzqww0GncEvW8/Mth1jXilsjNMADF72Chh7N
         XHrVXYTcYUAKrB90idkA3Vv58hwVtMOEnqSyQ14H+antR87gzQfwMeMO7YtSQu09us6L
         D9UjX/OMvMZ2G3TEQqqk/GuujU6Hcp9YeEzWcSQroqdsiHEVUIziWR2QrMJpLTIxchoc
         46BA==
X-Gm-Message-State: AAQBX9e/rCjZQhjK7WaLe204E50YTIq7uqny/1l3olZ37RowLhH8cA4z
        Gh+RSMdT63WLcyIV7g5S9WCJN9dzd0aloMNBPs4=
X-Google-Smtp-Source: AKy350Zeg7WcBlbIeS4PGWBrU+nA6D3ZQw2RQUdtMzrRIbcOBcnB4FvzAieagBSVaRSEerSYF/00HQ==
X-Received: by 2002:a17:903:25d1:b0:1a6:3e45:8df with SMTP id jc17-20020a17090325d100b001a63e4508dfmr3379688plb.33.1681942713552;
        Wed, 19 Apr 2023 15:18:33 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:33 -0700 (PDT)
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
Subject: [RFC 29/48] RISC-V: KVM: Skip AIA CSR updates for TVMs
Date:   Wed, 19 Apr 2023 15:16:57 -0700
Message-Id: <20230419221716.3603068-30-atishp@rivosinc.com>
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

For TVMs, the host must not support AIA CSR emulation. In addition to
that, during vcpu load/put the CSR updates are not necessary as the CSR
state must not be visible to the host.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/aia.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 71216e1..e3da661 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -15,6 +15,7 @@
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <asm/hwcap.h>
+#include <asm/kvm_cove.h>
 
 struct aia_hgei_control {
 	raw_spinlock_t lock;
@@ -134,7 +135,7 @@ void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
-	if (!kvm_riscv_aia_available())
+	if (!kvm_riscv_aia_available() || is_cove_vcpu(vcpu))
 		return;
 
 	csr_write(CSR_VSISELECT, csr->vsiselect);
@@ -152,7 +153,7 @@ void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
-	if (!kvm_riscv_aia_available())
+	if (!kvm_riscv_aia_available() || is_cove_vcpu(vcpu))
 		return;
 
 	csr->vsiselect = csr_read(CSR_VSISELECT);
@@ -370,6 +371,10 @@ int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
 	if (!kvm_riscv_aia_available())
 		return KVM_INSN_ILLEGAL_TRAP;
 
+	/* TVMs do not support AIA emulation */
+	if (is_cove_vcpu(vcpu))
+		return KVM_INSN_EXIT_TO_USER_SPACE;
+
 	/* First try to emulate in kernel space */
 	isel = csr_read(CSR_VSISELECT) & ISELECT_MASK;
 	if (isel >= ISELECT_IPRIO0 && isel <= ISELECT_IPRIO15)
@@ -529,6 +534,9 @@ void kvm_riscv_aia_enable(void)
 	if (!kvm_riscv_aia_available())
 		return;
 
+	if (unlikely(kvm_riscv_cove_enabled()))
+		goto enable_gext;
+
 	aia_set_hvictl(false);
 	csr_write(CSR_HVIPRIO1, 0x0);
 	csr_write(CSR_HVIPRIO2, 0x0);
@@ -539,6 +547,7 @@ void kvm_riscv_aia_enable(void)
 	csr_write(CSR_HVIPRIO2H, 0x0);
 #endif
 
+enable_gext:
 	/* Enable per-CPU SGEI interrupt */
 	enable_percpu_irq(hgei_parent_irq,
 			  irq_get_trigger_type(hgei_parent_irq));
@@ -559,7 +568,9 @@ void kvm_riscv_aia_disable(void)
 	csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
 	disable_percpu_irq(hgei_parent_irq);
 
-	aia_set_hvictl(false);
+	/* The host is not allowed modify hvictl for TVMs */
+	if (!unlikely(kvm_riscv_cove_enabled()))
+		aia_set_hvictl(false);
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-- 
2.25.1

