Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AA067F64E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjA1I3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjA1I3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:29:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A77D6E4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:29:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id lp10so6760313pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FljnRzw2zIs2SaTw4PAfD3E9tIV3gHkmBf8hApNO6fw=;
        b=OQizLRENPAg09ciAbZoN5itK16Pz2bFe45sopfZppnH0Ud5XsJVtEotBWwPAg2/UWT
         P/udJB7pRNtPQqdy3cdj0M+2GNCv5rS5XLbQrM11WQ2U1/Hb2+U99G2rsJHywjGkF8hp
         lNNYYta2mdtUotMek4oyyiqqICB9JexQFicaRCgMT4X1r1cLj5EiEnIh/b65TLt76ui4
         f3n9nqSwQ0kz0qHhn542mTas5YO2S+dA6/LraWs+hCe/8PQANnV7VWEtktCRUVU9EJTI
         v4xZ/s0AevZHVyQ8Y4CcEBtoMRTEWOtEDLTPfTddIzBCl9CbwsMO74mP/0c2bEb2L32j
         1OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FljnRzw2zIs2SaTw4PAfD3E9tIV3gHkmBf8hApNO6fw=;
        b=LdrX2yH6oNuRGZJR7qdQe0knzdx/d+BKn9hgb4hGt8SGDJUesktKNcei/EmOUX9i3n
         CAZ5B8TQkC7FQ9iGR3dl5NDXlZpNblN/F8mNqArCGQDKZEzfcFJNoeMoB2BvtAUznhcq
         FNc0XQwGn7aNmYUB+HAFkzmepAPHwixafglkd30gzFQKGGpyOBqrQCJnmPf7fXcLn3Zk
         PPls542b5oFS9OwDtly3FA+E3jjgQ5H1ydUzqKGFyJAjgtTqf5DJQBvMv5Z44NWsEZyY
         brzADKo5gfl8PiBK568dHJNIpcNK7KsL+nb8ucOodPZiWZfJQVMEEs/YrTsApR9W2JM4
         ucDA==
X-Gm-Message-State: AFqh2konALyz39z640hqxVPu+f3ebHszzJbuFLj8P++CE+FcJwTHlTs+
        2RPQuloNMup80HGJ2AsgGIFu8y1mumKCzcr5
X-Google-Smtp-Source: AMrXdXvje0+V7Y5a71q6YW6SkRvl2pnS+6PeoYGrwzhIYPvr6ISBcOZNGtYQPAoOGCEHtg10GXi4Tw==
X-Received: by 2002:a05:6a20:4c16:b0:b8:6371:9abf with SMTP id fm22-20020a056a204c1600b000b863719abfmr41015379pzb.27.1674894542483;
        Sat, 28 Jan 2023 00:29:02 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id i67-20020a639d46000000b004cc95c9bd97sm3477807pgd.35.2023.01.28.00.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 00:29:01 -0800 (PST)
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
Subject: [PATCH v3 2/2] RISC-V: KVM: Redirect illegal instruction traps to guest
Date:   Sat, 28 Jan 2023 13:58:47 +0530
Message-Id: <20230128082847.3055316-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230128082847.3055316-1-apatel@ventanamicro.com>
References: <20230128082847.3055316-1-apatel@ventanamicro.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_exit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index af7c4bc07929..4ea101a73d8b 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -182,6 +182,12 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
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

