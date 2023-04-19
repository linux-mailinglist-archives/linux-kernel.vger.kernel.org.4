Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120B6E84C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjDSWWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjDSWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:21:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF588B440
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b73203e0aso2786785b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942727; x=1684534727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF8Qn0Z7zg/7RPDtBuNuOPN3zeJXhr/Jx4YP7Fj6yI4=;
        b=G/Fug0YDh/vT2gLC0JnMu9cK8/lm7JaHRK8wavACXkcusYj2LIYmBRBKMqHOqlZK+w
         4X0VmEj6BTotc/ZSwQ/hqCf5XFjDLPfMNoRWYQ9eoQMvSpOlejZpx2S6qdCGkDr0mV1j
         tz/t8nrgfTSM3p2DcPJ6IP/ULX8p9u8n4bLZ8UppcJfyijITcktTN9QxUA/PYL/GUGR2
         g1Dwy3qOR6S1EA5f1HDfH1/Z8AcgmbMd6OoD3Rpin7C3Tw7AepN0itfwNNwkxK4BS08T
         wI5vk6637oOkFsektud4GizoiS09rEJkFLg8xFSYn4+9QqroF/v5cNomyMNwCRJWPRAY
         /ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942727; x=1684534727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PF8Qn0Z7zg/7RPDtBuNuOPN3zeJXhr/Jx4YP7Fj6yI4=;
        b=l8bLfvxtrAJQV1AyAX2eALO58Hi8gC9kUwu7MQadQ0zOfvGauzWRqrr5mzMC2FT6HC
         EHY5/VG1EKzKNNoMXpzsR+20GARQ0MBQBxl3uuKlPPAuE8t+FWs/cpC6zLo57J68BMn1
         pvGvNALp2sfSCK2iUz2WT0Ood9Y8z1AUXd9JsySwUEzaAiIo1U+d5nj2ir6tn9FfER9p
         C7LJCocijQ4/c8KRBCBmEsXSbsLBG4Cmb2keG7BAwn5w5lMUQfe7qC+SCGh7uAZvNXfW
         StyRsp2pB+R0x1YqOkfJhoRQ9mGwGtqK5fiXuTBGFNm5adZjffmZ2DuzpCXbmRez5Cht
         1cSg==
X-Gm-Message-State: AAQBX9cZFHAp0umZiJeN12L4qDRGgZSF9thQy7w5Qx0b0fYxeaZI6sEJ
        lek/8sEHDQZWs05HJsVyheRx5u1gcJT7D7/TyyI=
X-Google-Smtp-Source: AKy350Zh1JoIu/w89g7BU4hvCJLzB5n1X2PHzMgJ8jQn7nK1FJDYYuKYpLhfuRupPsetmV7URaqafw==
X-Received: by 2002:a17:902:ea03:b0:19b:64bb:d546 with SMTP id s3-20020a170902ea0300b0019b64bbd546mr4360345plg.18.1681942727339;
        Wed, 19 Apr 2023 15:18:47 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:47 -0700 (PDT)
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
Subject: [RFC 35/48] RISC-V: KVM: Add TVM init/destroy calls
Date:   Wed, 19 Apr 2023 15:17:03 -0700
Message-Id: <20230419221716.3603068-36-atishp@rivosinc.com>
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

A TVM can only be created upon explicit request from the VMM via
the vm type if CoVE SBI extensions must supported by the TSM.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 1b59a8f..8a1460d 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -42,6 +42,19 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		return r;
 	}
 
+	if (unlikely(type == KVM_VM_TYPE_RISCV_COVE)) {
+		if (!kvm_riscv_cove_enabled()) {
+			kvm_err("Unable to init CoVE VM because cove is not enabled\n");
+			return -EPERM;
+		}
+
+		r = kvm_riscv_cove_vm_init(kvm);
+		if (r)
+			return r;
+		kvm->arch.vm_type = type;
+		kvm_info("Trusted VM instance init successful\n");
+	}
+
 	kvm_riscv_aia_init_vm(kvm);
 
 	kvm_riscv_guest_timer_init(kvm);
@@ -54,6 +67,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_destroy_vcpus(kvm);
 
 	kvm_riscv_aia_destroy_vm(kvm);
+
+	if (unlikely(is_cove_vm(kvm)))
+		kvm_riscv_cove_vm_destroy(kvm);
 }
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
-- 
2.25.1

