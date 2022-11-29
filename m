Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8563C262
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiK2OZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiK2OZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:25:03 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3B266F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:25:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k5so12812793pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXLvXXdTgugvaqwC5VnS0gtZiRjZW9Lq1RMlH39mGsc=;
        b=jdsucmnVILuZ3Qemss8/fjATR1/LMZxJMMNLJzvghhxXWtVwdiyQ679xMAD4/YdU+r
         fFBe1Ho2LUOt7gZAlFMAh75XXttpn2CJEfh5fDXZvj11/242xCM4SoMZHdkCtY0rRq0u
         liunwBbiTXwg2pFUfG4OJkTii6i0QZYZ83PJ1+/AGUabkpBaBowzctSJRsSyH1vmsPX2
         fwokAj7ss5ZGxsiZ5rAD+KeKxKI5YS1Tq4F3XUI8tasvBTyiWaYJN1Og1FPm6Z8jHcc1
         FopsC+YN9vai+YUeZafeP7R4MB2B5gIQtS5IKA4bx6TCh+Vv7gctHuQCmX/DLuR1eD2B
         peFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXLvXXdTgugvaqwC5VnS0gtZiRjZW9Lq1RMlH39mGsc=;
        b=j2uEshTAfvmUuYSQNhbn3nQz/WZMW0Ak6TEebjznrzT5lkS9HmyJvPzXgfCIBkIfkN
         o1u5Jf3eEon1GeGH/DG4X9gtd+SXwKlxrnwbDVyNFUBJGpexzYU4mYhNetnTBm3sUIv1
         W2sTFQfWtPH1kSIhYwPqIfQqkd2ZUG+f9LDdNyaiPXpGtiIHot3JTib77Hub6JCXf2Ds
         I5ocRB2UCH9Fz6Wx7UGTLBz0z+GvSwWGw+YkI/sRvrquqk+rm9LLRUcuRhYx1oSZX7MS
         cL3KxKafAG9OWcUQT0+hI4aoJ4UhDddTbbqZasmMJRHXcdA9k/OdH76S03Vouw5tqyvx
         vAcg==
X-Gm-Message-State: ANoB5pluYKVlvE9ZJeAuiheOAU7uRihOEX2gMlZGSC9LOcQqP4xLLKgR
        1dZyWzC/Gz5aGdJA8s1ytAQ+ag==
X-Google-Smtp-Source: AA0mqf6zpsQVlYbUz71/pV/CIhxdNR/fGGYGsGYYapd85XiiSvvt55Pl6nwPzz5JBk2M0uJFy0cHYA==
X-Received: by 2002:a17:903:31d5:b0:185:4e4c:3483 with SMTP id v21-20020a17090331d500b001854e4c3483mr39081193ple.163.1669731902202;
        Tue, 29 Nov 2022 06:25:02 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.98])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b00176a2d23d1asm11039076plh.56.2022.11.29.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:25:01 -0800 (PST)
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
Subject: [PATCH v13 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Tue, 29 Nov 2022 19:54:43 +0530
Message-Id: <20221129142449.886518-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129142449.886518-1-apatel@ventanamicro.com>
References: <20221129142449.886518-1-apatel@ventanamicro.com>
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
index 5c87db8fdff2..ac99a70ead6a 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -646,8 +646,14 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
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

