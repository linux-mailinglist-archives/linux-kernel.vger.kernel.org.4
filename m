Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0366F67ED6D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjA0S0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjA0S0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:26:19 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E791B7B405
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:26:17 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 5so5885398plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izgQjGebJOE3RdsQHdegT8RbHZUq8xzpqR3/LUH4GSg=;
        b=a9q6O59eBw3CpprTPbzQxW83Q7UrY2+lKmZmXjuTmVoRmWq832uyL21I+/u/2jlFsO
         bTlm0YBWf2ah/OxNoOPiZxfWIeGbfnN6qqpFy+vDApROfAjY7xLdi+oHeD5YAzXrntLp
         0iA7A84/LEUf3mVNSHCXRjpqYhD5EyLDz8/2zyHnDr7cKiUp7p2pzS596BsBKHsnBxAk
         G89h93eoTjPyxN8e6Txu2tZ0uIjZaYWgpUApxOIgGu3sq4yuNH7SSPIAbXdbH2l+GwV5
         PzoXrmBsDm+Di6HYC9puIB+BtcJFyZ4EposGAB4Xp8Pyn5GQ/BX/pp2f8FI38oYMDVU5
         OtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izgQjGebJOE3RdsQHdegT8RbHZUq8xzpqR3/LUH4GSg=;
        b=seizOioNcZDlVGj5079cHPB7c4bFmKtLKtO0W+kj/GmgHRqkL+CUzxonGpaZF78hLy
         YzvguDD74yR1hnyBqQiHz2x24w1bzeab4BM9GwUnBo75wKwOLAeVb7+gH0sU9LfWSaBL
         guYsSIW56xx7xV+haxTGt7DfIv5puozzbzBb+TJUcxhQ6i1f02YGoWDTPnmVApcpcBTN
         KIPoZ1zkae3xaqArEkub/PlcWc1rqGxke9xIrQq0GNXFJ1c/Xb0Hr0JVkABXMjggKoq3
         2zt3D/5HLq4H9efFdnanCERf3XsLapCR68lu1SXyV9CZqktZ8f2zKquY97PM/I9RTYT5
         mXnA==
X-Gm-Message-State: AFqh2kqX7+QocRr+kEEb/Sjqn3n2nIljJfNQObGdngK3Bj2lRnNdBbaf
        xqeFi/4DGjJeyz+Nh8zguVukAYO6O/HQyvkY
X-Google-Smtp-Source: AMrXdXvB7tRUnB3Hfypgm0M3o3xtG8B8LuON2IbfpnFe7fWjhVF0jWMVK4kOMJuFNqdvYFt/7ZMBfA==
X-Received: by 2002:a17:902:6a89:b0:194:88a3:6e28 with SMTP id n9-20020a1709026a8900b0019488a36e28mr38634507plk.51.1674843977309;
        Fri, 27 Jan 2023 10:26:17 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jc5-20020a17090325c500b00189d4c666c8sm3195219plb.153.2023.01.27.10.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:26:17 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 04/14] RISC-V: KVM: Define a probe function for SBI extension data structures
Date:   Fri, 27 Jan 2023 10:25:48 -0800
Message-Id: <20230127182558.2416400-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127182558.2416400-1-atishp@rivosinc.com>
References: <20230127182558.2416400-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index f79478a..45ba341 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -29,6 +29,9 @@ struct kvm_vcpu_sbi_extension {
 	int (*handler)(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		       unsigned long *out_val, struct kvm_cpu_trap *utrap,
 		       bool *exit);
+
+	/* Extension specific probe function */
+	unsigned long (*probe)(struct kvm_vcpu *vcpu);
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index 5d65c63..846d518 100644
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
+					*out_val = sbi_ext->probe(vcpu);
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

