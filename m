Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E331B6E84A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjDSWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjDSWSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:18:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C17ED7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:18:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a814fe0ddeso5125335ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942691; x=1684534691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN7cfqRTuUxE4NYFTrE6RcyXhfZTP+XO506Z7P5jnSo=;
        b=2HntuY5n1tLM4pNJa7nz4osjLmrd+gHhTujKcUSE8JGJeCF47AW9Dyj0rRPbdS8CKR
         ec8mdHxJp3zhFL+VPoHjKpwqqItbmuGrX1ePOLL/H/CjhizNW48AJx/+m0SEc6hw+lrg
         4TAnXTUfT+76XBgFTJYmo+eDlVergYm7g4UDIIG8q8towz6RIKhd0qUN5gI1M3MPJ6Yf
         v6+fwgTgJxyGyevBN2wreiHgOozsBMp0FBa2pY9PJ2gXBMvj4I9WYLUgQzPavzY4XGMn
         BfwkMktMwYiFO0NHEmqBJ8uwsXt7UjR2yMhk7oglZtm60MHD5OqGzZFoQLQcULwN1VOW
         9p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942691; x=1684534691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN7cfqRTuUxE4NYFTrE6RcyXhfZTP+XO506Z7P5jnSo=;
        b=ArA1i9bfk0msltXm9HoAS7KewZ18osG6Sh4/WM3CLCvyR4VY/tZ5JPe3H6NnHJxYs5
         jRFqMozvJ4B2MRF0mstjCrSPyws6AYW5xBaSsXnAr4SsBGK2vkJdrG5FR6+wf2IxSQSv
         HpKVUyc7gwQF/r15+yiWW8Nx/2GXDfWUHj5nRIsxJIHXYMpXEVjEgqLb1VOOEqYgt2po
         1kiwSA6wJvRgvy9tdGO7ZZwpFcqAIgpmRgi0IsWrcTScw9hz/JcnnggjqV85LsP98F2O
         8u2gc0DLOas7zBPLag8Y6qzDI4aia5IHCR5FVNE6HhYXKmCaSNiZjgSHAJEYBPqtgelJ
         2Peg==
X-Gm-Message-State: AAQBX9eH5KYUz1koj3I1QF0HWJF9kTrvsxiU9nHwBl4gnJPbI0dF1AGn
        eTK8wsuN9mfiwiN2BduyT0ZFAQykf+TNGtpmRio=
X-Google-Smtp-Source: AKy350ZYsA8lzJG7NSbCoTlmBQanAcDJyPETNQetpvDDQv9McJwUAM0nHCIZ5qbS6IwUoaXgRnH5YQ==
X-Received: by 2002:a17:902:8b8a:b0:1a6:dfb3:5f4b with SMTP id ay10-20020a1709028b8a00b001a6dfb35f4bmr5466195plb.55.1681942691242;
        Wed, 19 Apr 2023 15:18:11 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:11 -0700 (PDT)
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
Subject: [RFC 19/48] RISC-V: KVM: Register memory regions as confidential for TVMs
Date:   Wed, 19 Apr 2023 15:16:47 -0700
Message-Id: <20230419221716.3603068-20-atishp@rivosinc.com>
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

The entire DRAM region of a TVM running in CoVE must be confidential by
default. If a TVM wishes to share any sub-region, the TVM has to
request it explicitly with memory share APIs.

Mark the memory region as confidential during vm create itself.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 4b0f09e..63889d9 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -499,6 +499,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 
 	mmap_read_lock(current->mm);
 
+	if (is_cove_vm(kvm)) {
+		ret = kvm_riscv_cove_vm_add_memreg(kvm, base_gpa, size);
+		if (ret)
+			return ret;
+	}
 	/*
 	 * A memory region could potentially cover multiple VMAs, and
 	 * any holes between them, so iterate over all of them to find
-- 
2.25.1

