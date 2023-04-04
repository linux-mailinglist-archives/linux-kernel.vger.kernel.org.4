Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9696D678A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjDDPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjDDPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:36:08 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F8055A3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:35:48 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r14so18822276oiw.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680622546; x=1683214546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCp8YfxX6xFyqpUfUr+twYqQEVlMgTCLtcjgXZ4bJb0=;
        b=A7pfDSiLBKaXG6RPnmlfuhfDIp//TDAwQ/jfEQFYUaa36isCfr/MX73to+LqnLz02Z
         z/qf87ywLC4nWIq/qtWPrUF9DiJ/0kCOpYt6lLtQo1zHg6Yd9q2AH5LRjrkmJxWLusQa
         LN7nuZio9JqwV3soHLx5EOupQ7X8FKOXmgizJXm4dUw16GuIy2PyDYKooguetr+oVeh+
         xx6BH/TZ2zsi15N/+rAfn/r/6wDhuFvKuGbBL4miqtMIGSXQz1hgMBzRUnYZ5SqmtUeF
         /8gUGlmBs4EmzoM1TahQ/4XYHXIvrPYtRGwkED2XQolaZRCB+au/Ujny/18DbBVzO77X
         aoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622546; x=1683214546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCp8YfxX6xFyqpUfUr+twYqQEVlMgTCLtcjgXZ4bJb0=;
        b=1Qt4b4tEwHx+MPEbpD7doUrxx22aEQgc8jJgt8a8HRPkTwwbX3BECXtQaoYf06xper
         QltexN2gnZhLo2yypWyBrQm6tUuTRlZRD01uVaxWeK8yb/VW3g2c6rOsaBK/etZbWfYI
         f+4gFXsFG+G3DBf4ipg0WDux7wiCph/ddAdbk8hptaharhdZPwhyt2gabNJyFgUkNRkP
         ipk5VqEFmVTLJ5FuiHPyLjMkYKOvEuSnYQLgb/Z7zaUfrF1IslCeZpGY2aRijrtHFiu2
         w2HxQRDh3glrQjjqkv/Zird/fRzP9gKrgKCUqrqozmmsQr6qhTtR+/TBb9/5S7e8PDjM
         H75A==
X-Gm-Message-State: AAQBX9dAeMvTBDSmDhGWfE5sivYkEQOa0peFYXrFjdPLIPMJfFXyxQhM
        6BkpUveJB2WKBOQrGclXf4W/4g==
X-Google-Smtp-Source: AKy350Z+iv2NUBGXv1ZNGJaaZur3SFogg2vqjzTqiEksQXuu7dAflL/OJXbaVA4tMuyn7BpClSGefw==
X-Received: by 2002:a05:6808:2d8:b0:387:64ee:eaca with SMTP id a24-20020a05680802d800b0038764eeeacamr1396397oid.30.1680622546406;
        Tue, 04 Apr 2023 08:35:46 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id w124-20020acadf82000000b00387384dc768sm5325803oig.9.2023.04.04.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:35:46 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 6/9] RISC-V: KVM: Add ONE_REG interface for AIA CSRs
Date:   Tue,  4 Apr 2023 21:04:49 +0530
Message-Id: <20230404153452.2405681-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404153452.2405681-1-apatel@ventanamicro.com>
References: <20230404153452.2405681-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We implement ONE_REG interface for AIA CSRs as a separate subtype
under the CSR ONE_REG interface.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 8 ++++++++
 arch/riscv/kvm/vcpu.c             | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 182023dc9a51..cbc3e74fa670 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -79,6 +79,10 @@ struct kvm_riscv_csr {
 	unsigned long scounteren;
 };
 
+/* AIA CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
+struct kvm_riscv_aia_csr {
+};
+
 /* TIMER registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_timer {
 	__u64 frequency;
@@ -107,6 +111,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
 	KVM_RISCV_ISA_EXT_ZICBOM,
 	KVM_RISCV_ISA_EXT_ZBB,
+	KVM_RISCV_ISA_EXT_SSAIA,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
@@ -153,8 +158,11 @@ enum KVM_RISCV_SBI_EXT_ID {
 /* Control and status registers are mapped as type 3 */
 #define KVM_REG_RISCV_CSR		(0x03 << KVM_REG_RISCV_TYPE_SHIFT)
 #define KVM_REG_RISCV_CSR_GENERAL	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
+#define KVM_REG_RISCV_CSR_AIA		(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
 #define KVM_REG_RISCV_CSR_REG(name)	\
 		(offsetof(struct kvm_riscv_csr, name) / sizeof(unsigned long))
+#define KVM_REG_RISCV_CSR_AIA_REG(name)	\
+	(offsetof(struct kvm_riscv_aia_csr, name) / sizeof(unsigned long))
 
 /* Timer registers are mapped as type 4 */
 #define KVM_REG_RISCV_TIMER		(0x04 << KVM_REG_RISCV_TYPE_SHIFT)
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 3394859c5f85..57bdbfc17d48 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -58,6 +58,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	[KVM_RISCV_ISA_EXT_I] = RISCV_ISA_EXT_i,
 	[KVM_RISCV_ISA_EXT_M] = RISCV_ISA_EXT_m,
 
+	KVM_ISA_EXT_ARR(SSAIA),
 	KVM_ISA_EXT_ARR(SSTC),
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVPBMT),
@@ -97,6 +98,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_C:
 	case KVM_RISCV_ISA_EXT_I:
 	case KVM_RISCV_ISA_EXT_M:
+	case KVM_RISCV_ISA_EXT_SSAIA:
 	case KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
@@ -520,6 +522,9 @@ static int kvm_riscv_vcpu_get_reg_csr(struct kvm_vcpu *vcpu,
 	case KVM_REG_RISCV_CSR_GENERAL:
 		rc = kvm_riscv_vcpu_general_get_csr(vcpu, reg_num, &reg_val);
 		break;
+	case KVM_REG_RISCV_CSR_AIA:
+		rc = kvm_riscv_vcpu_aia_get_csr(vcpu, reg_num, &reg_val);
+		break;
 	default:
 		rc = -EINVAL;
 		break;
@@ -556,6 +561,9 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu *vcpu,
 	case KVM_REG_RISCV_CSR_GENERAL:
 		rc = kvm_riscv_vcpu_general_set_csr(vcpu, reg_num, reg_val);
 		break;
+	case KVM_REG_RISCV_CSR_AIA:
+		rc = kvm_riscv_vcpu_aia_set_csr(vcpu, reg_num, reg_val);
+		break;
 	default:
 		rc = -EINVAL;
 		break;
-- 
2.34.1

