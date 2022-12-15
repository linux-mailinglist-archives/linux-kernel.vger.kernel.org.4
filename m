Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46864DF30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiLORBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiLORBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:01:18 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527BD25EAB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:01:16 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x2so6184191plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe+UropDcs41uZsJl5UoQsMteKaso09Ma6XjETIRZjA=;
        b=pv5pECr+7yhCoGDeSuvAT6ApQZ4t2eT4MBkXtO3ghYvONHQbcMSuQGcD9oGpIsBLnY
         /xLSkLLvxmyncb6xOOfdWjHyOw/ArLKeJf/3mj4P6+7Bmr4tkGvqunp9WMoatiCBSwD7
         hND+BjAF9VNuICeGf4XADiRiWjW71fp1xI/2HaFUI174oykQvLOPa1/Ny/anECFnDjB5
         7HzLQhqbjKh0RSmKFzwZRjmBSXmLk4JKeO5oXCoP50lXYLrIu2fOkOlWaspGWkaDYpGk
         3GpeYxJjVG0fGpyj4ohFiMTZpw/FCZy/Hqm++CmBZ36Zz+0jR4sUxHU15x5dHYBOEEOP
         L1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oe+UropDcs41uZsJl5UoQsMteKaso09Ma6XjETIRZjA=;
        b=sDH6yQr9LulkLFqUw1FfYPIrtjNBT+awMOawK/jKUAn/jfUIf5p5U3NlVWtxXE4Hru
         MELW4vlz7P2M/xpwdAvT8iy8E81GoMhgNMiZmqcLx58etMY/2AK7yQgG0vxDjDMABn4E
         kKmHkycF5bKTw5kUQpZCw14yvsQgbVgGQqA/4TW4Xxqx5wX49rn1Ggv43s1rMLJgbCfH
         nxM95fQmngZzrBKMKLCw/OLxthVmZ8D2mTIqLYuOf9wDK3juYzw9yM8qjt8QjqwaHt8b
         D6J80c2+VdB6cdGPrADq5oheb8+ymfyRPxZOf+fxeYlXM8r+dV1cuQO4fVgKNic5afpm
         WVxA==
X-Gm-Message-State: ANoB5pkEwfsYURlf/C9DARPw46I8fyVbaDprW9XWnOkprHmzKk9bRxdN
        grLHHvuOcGEhPJLIEgCqRv7WEoz1toAg5dzJ
X-Google-Smtp-Source: AA0mqf7rpf1DYdCy6MEJCPXmVFu1iVBoY4PGgeIxOVYoUigt1rdcD6Iks5r7UqhKDjTl7/0JeAcqkg==
X-Received: by 2002:a17:902:7044:b0:186:ada3:c1a0 with SMTP id h4-20020a170902704400b00186ada3c1a0mr27971825plt.45.1671123675053;
        Thu, 15 Dec 2022 09:01:15 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b001897bfc9800sm4067449pll.53.2022.12.15.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 09:01:14 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Eric Lin <eric.lin@sifive.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 02/11] RISC-V: KVM: Define a probe function for SBI extension data structures
Date:   Thu, 15 Dec 2022 09:00:37 -0800
Message-Id: <20221215170046.2010255-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215170046.2010255-1-atishp@rivosinc.com>
References: <20221215170046.2010255-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the probe function just checks if an SBI extension is
registered or not. However, the extension may not want to advertise
itself depending on some other condition.
An additional extension specific probe function will allow
extensions to decide if they want to be advertised to the caller or
not. Any extension that does not require additional dependency checks
can avoid implementing this function.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  3 +++
 arch/riscv/kvm/vcpu_sbi_base.c        | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index f79478a..61dac1b 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -29,6 +29,9 @@ struct kvm_vcpu_sbi_extension {
 	int (*handler)(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		       unsigned long *out_val, struct kvm_cpu_trap *utrap,
 		       bool *exit);
+
+	/* Extension specific probe function */
+	unsigned long (*probe)(struct kvm_vcpu *vcpu, unsigned long extid);
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index 5d65c63..89e2415 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -19,6 +19,7 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	int ret = 0;
 	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
+	const struct kvm_vcpu_sbi_extension *sbi_ext;
 
 	switch (cp->a6) {
 	case SBI_EXT_BASE_GET_SPEC_VERSION:
@@ -43,8 +44,16 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			 */
 			kvm_riscv_vcpu_sbi_forward(vcpu, run);
 			*exit = true;
-		} else
-			*out_val = kvm_vcpu_sbi_find_ext(cp->a0) ? 1 : 0;
+		} else {
+			sbi_ext = kvm_vcpu_sbi_find_ext(cp->a0);
+			if (sbi_ext) {
+				if (sbi_ext->probe)
+					*out_val = sbi_ext->probe(vcpu, cp->a0);
+				else
+					*out_val = 1;
+			} else
+				*out_val = 0;
+		}
 		break;
 	case SBI_EXT_BASE_GET_MVENDORID:
 		*out_val = vcpu->arch.mvendorid;
-- 
2.25.1

