Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5011639773
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKZRfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKZRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:35:10 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300BB1D67E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:35:09 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a16so6339809pfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwWFYCYJumXDNukDFpgq6aZHdE7ume2pA+aIBGQJqXE=;
        b=MwU705xJfUSSthvCC2sCblhJGza3LUZ6vZ+xE5SfJhDq1VVPVBRVRY4SjvFc1a6dpF
         DmqFF0Cnpi5WwEys551+bUiSJJgGozG0jq4ZTu7erwDTn8wYTbNjNqL7wBBcQhRN9boW
         bYX1cXyn7E9RHOMSexxdCwW0xMCfAEzJTvQbnuje58RHifyiTaz+z5166w4uZrueOiSH
         UihbKxtFRwE1qwShwdRekG2IQGpH9qP4gEyzOhxOvmT1fn6iXz2d0IzBPpoirXW944bX
         OlWsFpNHLjAW/qkDxFGJRry+R97zBwLfBpFUEPvrjyMOJRJs7pjtGZaHPx7fbIWGTNkG
         RM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwWFYCYJumXDNukDFpgq6aZHdE7ume2pA+aIBGQJqXE=;
        b=6O5dBBOCfOO56cvIc9PylsUUPS8sPZ9ERJvoov7o27iJBp8s83E8BxhOTgnFSMxq5c
         rV6QuORXxVPWERVcjpdu51nZCtYU6+Ht72Ox7oZJPJ75yr1FbOZISt0eN9H9EVDSAQiq
         Tl41kp/yPVZujW95Dy3wcJuC+/61VGYf3eLBxRfhpisEtyrNIRyGs+3ohWp11uBI05Xk
         TVkNKK4XweRorq+XePYZQ1Dh21Y2ZNjbqxmkzWD+3ngT8JCUBPawJ1JmKETEzuSfjwkR
         6hN4aStwJ8MOk/fPh2cCcTsV4qCVO7JcGK+bIAh4OeKoeIpIvqRTOVRqWCuxyerGvRdH
         IMng==
X-Gm-Message-State: ANoB5pkyBHTU/elyf5zdCeiWdCOFgr6wHGVQdYb6nHEXWwCMgBV0aYnV
        Zso48ap/c/LGtrDtqwILuIo0Dw==
X-Google-Smtp-Source: AA0mqf4ibNWUxq21jp2gH963hS7vCNyCn0MP75l7OIuyiXZGb9912g+Gqdf1XMO7PYUQKUhjUzNkQg==
X-Received: by 2002:a63:5d63:0:b0:462:85d6:6276 with SMTP id o35-20020a635d63000000b0046285d66276mr21009901pgm.293.1669484108516;
        Sat, 26 Nov 2022 09:35:08 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902bf4b00b0017f7c4e260fsm5639813pls.150.2022.11.26.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 09:35:08 -0800 (PST)
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
Subject: [PATCH v12 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Sat, 26 Nov 2022 23:04:47 +0530
Message-Id: <20221126173453.306088-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221126173453.306088-1-apatel@ventanamicro.com>
References: <20221126173453.306088-1-apatel@ventanamicro.com>
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

