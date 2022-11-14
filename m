Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFDD627927
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiKNJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiKNJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:39:41 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ADC1A82B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:39:39 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so11915601fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwWFYCYJumXDNukDFpgq6aZHdE7ume2pA+aIBGQJqXE=;
        b=Xi1BnJtNMYRdJZ2TbhlC5Q0oACc5D9Aao30md8TQAP7uC1rk/+NR0kDINIYj1rv17o
         iPv6xJH8fVEVgQbecalQ4Hc/D2XO48FBcLJLOrSH/FlYSGHtPGFcV2h7LGlbDp8z7vsz
         iGfn3RIcwaG5bqkyhZPxJjPMNnnk8hgHvykzW+UpvBN3OepJrbqEU/aXYy0eeeSIBbab
         cIwu3k83fQCNoCQrCdSwJPWQ5lfJWIX+2OQllT8E0fl+nUZTCwtyq//p9Yio3lQvLJhj
         DwzCsiLDk8oVmXBSAmYLcAQIPiaVGHnRQWa7jMdkbNrp3Fx4bnpUpsRBVYS7BxGEHdpx
         IOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwWFYCYJumXDNukDFpgq6aZHdE7ume2pA+aIBGQJqXE=;
        b=FIbntqHe3TOi2o74Agotl6rsq8CimZq2MYQ8+p4Ed6TSUMAYONctBiRoN3ko3Ut4hF
         HmbTKfEn5Kz0SqUnytSDFyMgIRjkeYFPl0B8kEKP+aI8XSN1jqfTf+uTuhYYdBrMXP0E
         QFE3obxjDcKTV82K713kmJHvlr9VlbNJ1ZMSeomTdpVXGWxDHTE2i55BzHvgycJfViHm
         UuLgXH3h//sjOeuH7G2fyHJNIR7waHEr9B+riAb+4KACtHSVHFv394AxeCTMxgfwOeF0
         TfvO2QI+2DxVt0E+lzj/H74Gs/6jwhkJxbP2+XcelxZjEKG9Rua1J4Tyr+pwpTDABh7Q
         xN8g==
X-Gm-Message-State: ANoB5pltzDkPDHEYsPsAkc2DeJGKgxRRm2zrRd8S30GWo6TwnCHx2S0C
        cxwL92Frgm/f9a8hR+yaxdGK8g==
X-Google-Smtp-Source: AA0mqf4n/MGOfR3c293RCkhSYFOhnOqRp7IrAuEe9A9pVPkEO4n5/3QXx/pmoP3HyVk+tCvAQtY7+g==
X-Received: by 2002:a05:6870:b0f:b0:13b:b20d:5c6d with SMTP id lh15-20020a0568700b0f00b0013bb20d5c6dmr6290794oab.250.1668418778314;
        Mon, 14 Nov 2022 01:39:38 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id l12-20020a4ae38c000000b0049f3bdd791esm3222677oov.26.2022.11.14.01.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:39:38 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v11 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Mon, 14 Nov 2022 15:08:58 +0530
Message-Id: <20221114093904.1669461-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114093904.1669461-1-apatel@ventanamicro.com>
References: <20221114093904.1669461-1-apatel@ventanamicro.com>
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

The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
S-mode but read-only for M-mode so we clear this bit only when using
SBI IPI operations.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/sbi.c | 8 +++++++-
 arch/riscv/kernel/smp.c | 2 --
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 775d3322b422..fc614650a2e3 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -643,8 +643,14 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
 	sbi_send_ipi(target);
 }
 
+static void sbi_ipi_clear(void)
+{
+	csr_clear(CSR_IP, IE_SIE);
+}
+
 static const struct riscv_ipi_ops sbi_ipi_ops = {
-	.ipi_inject = sbi_send_cpumask_ipi
+	.ipi_inject = sbi_send_cpumask_ipi,
+	.ipi_clear = sbi_ipi_clear
 };
 
 void __init sbi_init(void)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 760a64518c58..c56d67f53ea9 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -83,8 +83,6 @@ void riscv_clear_ipi(void)
 {
 	if (ipi_ops && ipi_ops->ipi_clear)
 		ipi_ops->ipi_clear();
-
-	csr_clear(CSR_IP, IE_SIE);
 }
 EXPORT_SYMBOL_GPL(riscv_clear_ipi);
 
-- 
2.34.1

