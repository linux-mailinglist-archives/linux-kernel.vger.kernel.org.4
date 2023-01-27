Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16BC67E363
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjA0Lbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjA0LbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:31:25 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F23B673
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:30:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c6so4650979pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ba3H0Jv5D/YGUkRP3LoEJju4yx/M3VQLseaE6FBWtQ=;
        b=fNWxbBCxDLMICiRNBvmigvDVed4NsKEIn0as/dW/01VrXNsvx4+HKf99XPFmU4Qro9
         gAO4rZTDO5pDFMXIkAbPdVLlFEAjv3goiC78HODs5nuj4pOZ9lMDbcmIMQXbdiiwZfv/
         caCljnb/NH9BpcdP2Oj9kxmQ9jiJAFireTJz344qGOvh1d4/f8LANxcxB74DAvNvnI0S
         so0hCsTAKt0VhyZdy1s10Qr9xK7/ffL6gRTNnCuF5mnsG5ktOblyQyVdmzeINYS75zFy
         tMSQIpnNSMM2YLQbt10XjNg8xRnp61OnWbLzaDD+AHfmdbtFCVZVhK+LPRmXJGNGYaJi
         1DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ba3H0Jv5D/YGUkRP3LoEJju4yx/M3VQLseaE6FBWtQ=;
        b=DzPfytvRKt8rCU93P6NRV8XlJ1W9j4J8YH9kkB0K70sJSIaJLItd5XfvwqBsuRc3P/
         czPpeFyRW3N4rSv1iE/2FpmXFOdYmOs0wrpsh+WEchpl226Ss+qwpNKja2B513U7uXFI
         zhvfgMogDRS91EnzMA9ePsiGKYTk4f9Z1cBrw2DFPBxYJVFTYoCmnd6L6uls0ZhH5ecV
         Jqbgkau/MnUA7tqliYRTzXMENYM/4AcllBO5MQPQVbha3j4S5iGRgKBibLgWDlk+Nfu7
         34kjVoPaESqwGZtyhNuULCvSD2FhHBIVFF9ZRNoUI6kyN+XQrr5HWbMlDlZC4YgGpXkS
         dHcA==
X-Gm-Message-State: AFqh2kr9fQO08MdVgxf2MMedKw6yoOOIb01JoWj1gq4T/9cAr9uNngAJ
        7dtfw+Myc4B9Nnzl4kkalYlzew==
X-Google-Smtp-Source: AMrXdXskYvkrjZYR/AZWCt8tfG+6SAbzCrcFxanXm2GWzvtyXE0s3axugA2Cg23Mtfnsfr56nItvhg==
X-Received: by 2002:a17:902:aa04:b0:194:6253:d69c with SMTP id be4-20020a170902aa0400b001946253d69cmr35240186plb.2.1674818994327;
        Fri, 27 Jan 2023 03:29:54 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902b20700b00192e1590349sm2605953plr.216.2023.01.27.03.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:29:53 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2] RISC-V: KVM: Redirect illegal instruction traps to guest
Date:   Fri, 27 Jan 2023 16:59:34 +0530
Message-Id: <20230127112934.2749592-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Chiu <andy.chiu@sifive.com>

The M-mode redirects an unhandled illegal instruction trap back
to S-mode. However, KVM running in HS-mode terminates the VS-mode
software when it receives illegal instruction trap. Instead, KVM
should redirect the illegal instruction trap back to VS-mode, and
let VS-mode trap handler decide the next step. This futher allows
guest kernel to implement on-demand enabling of vector extension
for a guest user space process upon first-use.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_exit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index c9f741ab26f5..4ea101a73d8b 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -160,6 +160,9 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
 
 	/* Set Guest PC to Guest exception vector */
 	vcpu->arch.guest_context.sepc = csr_read(CSR_VSTVEC);
+
+	/* Set Guest privilege mode to supervisor */
+	vcpu->arch.guest_context.sstatus |= SR_SPP;
 }
 
 /*
@@ -179,6 +182,12 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	ret = -EFAULT;
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	switch (trap->scause) {
+	case EXC_INST_ILLEGAL:
+		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV) {
+			kvm_riscv_vcpu_trap_redirect(vcpu, trap);
+			ret = 1;
+		}
+		break;
 	case EXC_VIRTUAL_INST_FAULT:
 		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
 			ret = kvm_riscv_vcpu_virtual_insn(vcpu, run, trap);
-- 
2.34.1

