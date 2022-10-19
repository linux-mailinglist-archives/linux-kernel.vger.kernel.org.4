Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148496044B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiJSMLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiJSMLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:11:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E3C169134
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:46:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h14so107967pjv.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGoLnZ3sUUjQ6T551O77F/cGWLjVF5P0hXeaCsgTaUA=;
        b=Vskm+yty8cHq30qB1XgOoU1LcXaaEsiDus8pFxuanPbvYIXPc6bX1hGlNQ0jVDCNx7
         eRrfGWJZtsJKhE+FRBodn3GyYJNof9dRTPdWw5kWatcodxLb7pielQnya3aMZ/idFhDz
         vUhdMfRJQRw1mCEpBP+iGQQneQTwaShSGR5vqu6EqaRbpx9/VFR+p4m+mkzBr8pVVLq1
         T6EgPUC/QTeQCwSmc1lS2hjHIohlhAAjTGDGvl5YxbLcF7TflrNID3CGaZSVQtm1pzVi
         FwQErpkGCfvYOQBTLy5ztGY7xHOyWDh7flnFI3HPRO9Iaf8HYeUTDbjlB2mesrR4KVO/
         Xupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGoLnZ3sUUjQ6T551O77F/cGWLjVF5P0hXeaCsgTaUA=;
        b=6clMM/e1hi2TyvK8n1sfc2KIMRDsB7uBQxe6ujm1Bi9w5q5kVLQ4Wi6jTySarWvR0W
         L046DYceBA1btCBKr3ni9/Vp52VJtGgvHsTmSwi/qAPq3SD3FARxYAaFl03dJiVgfkZi
         xBJzTEiEmI8QqqzI4izGW1n/+n5HftxOHtV+EEbFlgyKtg26fcVZJw5trd0BljR8jqYJ
         VOz4UnAsUAn/u7zw0prKNEk8bRXgAyLynKM3bRP3lr1phg2+NxSAAYebAU1/6UWyh8Wj
         KRGhpaxoiQCWgJLWgtz7I3A4kdo4jRHd7gjrrABGTfWXB8yuHqjVmpDj4m9cY2z4tnN5
         zFrw==
X-Gm-Message-State: ACrzQf0YxR3ENEuXS5VoMiUUQiPqvVpXb8BcjSsqJa3FJwymx7fnfXoW
        IHaToUOFppAlY8pFunZu8HUqQw==
X-Google-Smtp-Source: AMsMyM77U4ULWvxjJJOXxoE5nYztOUYKiByZiqSqBWtTwWGz4p8dLYj8lRpsHAlLZdstaJ2qIsHw8g==
X-Received: by 2002:a17:90b:1bc3:b0:20d:75b8:ee74 with SMTP id oa3-20020a17090b1bc300b0020d75b8ee74mr46164266pjb.1.1666179945267;
        Wed, 19 Oct 2022 04:45:45 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b00185507b5ef8sm6664148plh.50.2022.10.19.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:45:44 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] RISC-V: KVM: Fix kvm_riscv_vcpu_timer_pending() for Sstc
Date:   Wed, 19 Oct 2022 17:15:35 +0530
Message-Id: <20221019114535.131469-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvm_riscv_vcpu_timer_pending() checks per-VCPU next_cycles
and per-VCPU software injected VS timer interrupt. This function
returns incorrect value when Sstc is available because the per-VCPU
next_cycles are only updated by kvm_riscv_vcpu_timer_save() called
from kvm_arch_vcpu_put(). As a result, when Sstc is available the
VCPU does not block properly upon WFI traps.

To fix the above issue, we introduce kvm_riscv_vcpu_timer_sync()
which will update per-VCPU next_cycles upon every VM exit instead
of kvm_riscv_vcpu_timer_save().

Fixes: 8f5cb44b1bae ("RISC-V: KVM: Support sstc extension")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_timer.h |  1 +
 arch/riscv/kvm/vcpu.c                   |  3 +++
 arch/riscv/kvm/vcpu_timer.c             | 17 +++++++++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_timer.h b/arch/riscv/include/asm/kvm_vcpu_timer.h
index 0d8fdb8ec63a..82f7260301da 100644
--- a/arch/riscv/include/asm/kvm_vcpu_timer.h
+++ b/arch/riscv/include/asm/kvm_vcpu_timer.h
@@ -45,6 +45,7 @@ int kvm_riscv_vcpu_timer_deinit(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_timer_reset(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu);
 void kvm_riscv_guest_timer_init(struct kvm *kvm);
+void kvm_riscv_vcpu_timer_sync(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_timer_save(struct kvm_vcpu *vcpu);
 bool kvm_riscv_vcpu_timer_pending(struct kvm_vcpu *vcpu);
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index a032c4f0d600..71ebbc4821f0 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -708,6 +708,9 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 				clear_bit(IRQ_VS_SOFT, &v->irqs_pending);
 		}
 	}
+
+	/* Sync-up timer CSRs */
+	kvm_riscv_vcpu_timer_sync(vcpu);
 }
 
 int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index 185f2386a747..ad34519c8a13 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -320,20 +320,33 @@ void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
 	kvm_riscv_vcpu_timer_unblocking(vcpu);
 }
 
-void kvm_riscv_vcpu_timer_save(struct kvm_vcpu *vcpu)
+void kvm_riscv_vcpu_timer_sync(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_timer *t = &vcpu->arch.timer;
 
 	if (!t->sstc_enabled)
 		return;
 
-	t = &vcpu->arch.timer;
 #if defined(CONFIG_32BIT)
 	t->next_cycles = csr_read(CSR_VSTIMECMP);
 	t->next_cycles |= (u64)csr_read(CSR_VSTIMECMPH) << 32;
 #else
 	t->next_cycles = csr_read(CSR_VSTIMECMP);
 #endif
+}
+
+void kvm_riscv_vcpu_timer_save(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_timer *t = &vcpu->arch.timer;
+
+	if (!t->sstc_enabled)
+		return;
+
+	/*
+	 * The vstimecmp CSRs are saved by kvm_riscv_vcpu_timer_sync()
+	 * upon every VM exit so no need to save here.
+	 */
+
 	/* timer should be enabled for the remaining operations */
 	if (unlikely(!t->init_done))
 		return;
-- 
2.34.1

