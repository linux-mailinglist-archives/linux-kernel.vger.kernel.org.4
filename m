Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628616D677D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjDDPfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbjDDPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:35:32 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401154C0A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:35:29 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w133so24505995oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680622528; x=1683214528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8TEjnpfsG0YBkFpXJqRz0n2LVNq8aVMjA0y3Jy/fOE=;
        b=R8GvpSrBlRVtzdy7QE6yC/ZRRvUGif0e60w3klyhPfie6rPyttPKb2XZyWhf9NyVOb
         rr4WUz9BGwCJk8umvaRGdc1VdNTKeYll1CeGoRN92PcoRjBjH/SzMhJUhhLyNkygiX+2
         W6o9vH68YzbNY2AJ2KQZn0CsB5Avgp86aqxgJIr2skgX3Ze6+xX6cM+7g+Y2IsAIpA55
         CooSbuRrrbHDnfw0VPbuuuYDSE4h9pf8TWa3v6OF1N0jTicm1R603IXm6da9F1zb5CVY
         VFKiUI/8WC5XI4Jjzvhd/alRKcU41asb1NvaTcco9k6BHgsz+whY3B3lMWPhM1TlI4U4
         Mc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622528; x=1683214528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8TEjnpfsG0YBkFpXJqRz0n2LVNq8aVMjA0y3Jy/fOE=;
        b=blTKQLkBXA3uC5giIoH2AtRCC+T2IPgisDYNXjP2F6TtYA8eWbtfD+bz+G/FMX2CMD
         s+v8PTRJ4ll4xSuoDCLKGi108GAzsqmBC1D/T24WyHLO1MLixigz6JyZyrQ/55eK1+V9
         MOFpmh9gpDlWI5sOUhoFV2DfiSn2MdSiGrrVr/NzdjitcayZr+ADz/7ACnXKXqVXsXJw
         pWoGJA+vDll0NcyfiIRbYJbTTwEp2hRx6HEXeYWey0ovL10LVPtY6iKNTKIeMIpShk2W
         /83gi6D5GogvFq1s9UcQDKGkRVs/JrVDA7J/11PXt9cB6POBKHuHpgIPwR4x51O5dXw3
         mprQ==
X-Gm-Message-State: AAQBX9cf4AqrOXdaGwAYZxZfGnLUesKZOf+HYHzV+2RQxHPM+BcHzlFY
        CvM99jVrdTJP7KXPI1fPPo0ZSA==
X-Google-Smtp-Source: AKy350abi9ZPwjKPuTDiT1EXmWzz6cc776r4fwIEXnAScuexVNrJX78mURxtWegNGUjBSuUxFB2qwg==
X-Received: by 2002:aca:d944:0:b0:384:3cc0:9ffd with SMTP id q65-20020acad944000000b003843cc09ffdmr1507886oig.9.1680622528446;
        Tue, 04 Apr 2023 08:35:28 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id w124-20020acadf82000000b00387384dc768sm5325803oig.9.2023.04.04.08.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:35:27 -0700 (PDT)
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
Subject: [PATCH v4 3/9] RISC-V: KVM: Drop the _MASK suffix from hgatp.VMID mask defines
Date:   Tue,  4 Apr 2023 21:04:46 +0530
Message-Id: <20230404153452.2405681-4-apatel@ventanamicro.com>
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

The hgatp.VMID mask defines are used before shifting when extracting
VMID value from hgatp CSR value so based on the convention followed
in the other parts of asm/csr.h, the hgatp.VMID mask defines should
not have a _MASK suffix.

While we are here, let's use GENMASK() for hgatp.VMID and hgatp.PPN.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 12 ++++++------
 arch/riscv/kvm/mmu.c         |  3 +--
 arch/riscv/kvm/vmid.c        |  4 ++--
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 3c8d68152bce..3176355cf4e9 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -131,25 +131,25 @@
 
 #define HGATP32_MODE_SHIFT	31
 #define HGATP32_VMID_SHIFT	22
-#define HGATP32_VMID_MASK	_AC(0x1FC00000, UL)
-#define HGATP32_PPN		_AC(0x003FFFFF, UL)
+#define HGATP32_VMID		GENMASK(28, 22)
+#define HGATP32_PPN		GENMASK(21, 0)
 
 #define HGATP64_MODE_SHIFT	60
 #define HGATP64_VMID_SHIFT	44
-#define HGATP64_VMID_MASK	_AC(0x03FFF00000000000, UL)
-#define HGATP64_PPN		_AC(0x00000FFFFFFFFFFF, UL)
+#define HGATP64_VMID		GENMASK(57, 44)
+#define HGATP64_PPN		GENMASK(43, 0)
 
 #define HGATP_PAGE_SHIFT	12
 
 #ifdef CONFIG_64BIT
 #define HGATP_PPN		HGATP64_PPN
 #define HGATP_VMID_SHIFT	HGATP64_VMID_SHIFT
-#define HGATP_VMID_MASK		HGATP64_VMID_MASK
+#define HGATP_VMID		HGATP64_VMID
 #define HGATP_MODE_SHIFT	HGATP64_MODE_SHIFT
 #else
 #define HGATP_PPN		HGATP32_PPN
 #define HGATP_VMID_SHIFT	HGATP32_VMID_SHIFT
-#define HGATP_VMID_MASK		HGATP32_VMID_MASK
+#define HGATP_VMID		HGATP32_VMID
 #define HGATP_MODE_SHIFT	HGATP32_MODE_SHIFT
 #endif
 
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 46d692995830..f2eb47925806 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -755,8 +755,7 @@ void kvm_riscv_gstage_update_hgatp(struct kvm_vcpu *vcpu)
 	unsigned long hgatp = gstage_mode;
 	struct kvm_arch *k = &vcpu->kvm->arch;
 
-	hgatp |= (READ_ONCE(k->vmid.vmid) << HGATP_VMID_SHIFT) &
-		 HGATP_VMID_MASK;
+	hgatp |= (READ_ONCE(k->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
 	hgatp |= (k->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
 
 	csr_write(CSR_HGATP, hgatp);
diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
index 5246da1c9167..ddc98714ce8e 100644
--- a/arch/riscv/kvm/vmid.c
+++ b/arch/riscv/kvm/vmid.c
@@ -26,9 +26,9 @@ void __init kvm_riscv_gstage_vmid_detect(void)
 
 	/* Figure-out number of VMID bits in HW */
 	old = csr_read(CSR_HGATP);
-	csr_write(CSR_HGATP, old | HGATP_VMID_MASK);
+	csr_write(CSR_HGATP, old | HGATP_VMID);
 	vmid_bits = csr_read(CSR_HGATP);
-	vmid_bits = (vmid_bits & HGATP_VMID_MASK) >> HGATP_VMID_SHIFT;
+	vmid_bits = (vmid_bits & HGATP_VMID) >> HGATP_VMID_SHIFT;
 	vmid_bits = fls_long(vmid_bits);
 	csr_write(CSR_HGATP, old);
 
-- 
2.34.1

