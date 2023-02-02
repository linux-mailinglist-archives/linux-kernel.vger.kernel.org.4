Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7A6871AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjBAXNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjBAXNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:13:02 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4D7EFB2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:12:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so133307pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCMwx+bNWqE6Uw0wVFvOC8mb8JgaxncZy1aDemdVBjk=;
        b=mdNqkzYUs2zpA4DU4VEmsE/uQMZGivSWSfYeFb6rmpfasEsLsAcZPkheNKsoOFTjd/
         vq9cpIn8un8CiRxkgXJuDEjVEYrtJ32FDY0W7HHlquY0qlzqPXTcULeK+8fOMeeOu4q2
         KFCm+0LEilFqCX77NN1juCn9Vsy8dCUzU+XMU+VY4HOD7MUu/P4iJlmI9p2JWXUxJMek
         PFCms9ed2SH/2qADoAi9aUd56mwgsDRaJ8qXSYWlqAfPFPqBzVuVn5/izTeKikNZjBbu
         uLGwwhc5JtW06s+X/OhthIZeYKsfpk7/u4oZ+Kf3xMlvFwzbWXO9KAYnvfWKrspcZmap
         vTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCMwx+bNWqE6Uw0wVFvOC8mb8JgaxncZy1aDemdVBjk=;
        b=MTYSFGBKFZ+xEU+1dCiPLEFjJPHeWsnRmWgOiKC8yQewTLGLwouJUS0ro5CfErOyYc
         lMhkmx+/J9b1zZk5yljyx6aGNll88/o1SsFITC3lbgpYFOXET5QRgAh2w3ySFgDXH9/9
         IckGsujjRzgNVG80WVQf7ibYybgNnGqOiNXu/dZgdSGM0VE3y5ptS1oJoisO6rWRwN7F
         cOuvCCP4lLFh18f7VBF74jYhZ91zeSFJUpV2vKmS+Wp1iEJQieNZka09AtGmRcLPcFtY
         0FtvImDjpWjESCvDSy49XaeQTY9iZEOQXmTdUmtEj8jPdIgQxXaHembsES6YVLnUiG2K
         x29A==
X-Gm-Message-State: AO0yUKVHSLeu/kIsZqJK761M0gr3K7LiQtxvgbfqYYTwzJGGt/dRxnLG
        9b0eKTFdt1qmBgDFoAoiRrCO4qbC1BKPtm4Z
X-Google-Smtp-Source: AK7set9HfqeuPhdedfadqcZDEVftRlnyWsjXY3IpoobY3rvnO7Fx5H9DRvVWwp0++NVgN6ZbRqMVQQ==
X-Received: by 2002:a17:90b:1c05:b0:22b:b5c7:4fc with SMTP id oc5-20020a17090b1c0500b0022bb5c704fcmr4086441pjb.46.1675293176534;
        Wed, 01 Feb 2023 15:12:56 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a510300b0022bf0b0e1b7sm1861774pjh.10.2023.02.01.15.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:12:56 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Eric Lin <eric.lin@sifive.com>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 04/14] RISC-V: KVM: Define a probe function for SBI extension data structures
Date:   Wed,  1 Feb 2023 15:12:40 -0800
Message-Id: <20230201231250.3806412-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201231250.3806412-1-atishp@rivosinc.com>
References: <20230201231250.3806412-1-atishp@rivosinc.com>
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

Reviewed-by: Anup Patel <anup@brainfault.org>
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

