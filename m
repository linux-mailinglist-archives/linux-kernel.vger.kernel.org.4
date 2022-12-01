Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517F663F117
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLANCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiLANBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:01:51 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7775656EF7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:01:50 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 62so1585567pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXLvXXdTgugvaqwC5VnS0gtZiRjZW9Lq1RMlH39mGsc=;
        b=Xkgq6BQEcFPJ5gCrHCsooCg52GmidmDXMGoan1daErh1grF+4UP8R2qCE/AfVy4SPR
         mi05nAdiO1Fijqvm9IHmjhusQlLovEASiwF7RUe50Txg9SMFnQUm3zw8z6RgaHS+X1MX
         SMPwXqyQBnDVycEPRl/QfCpIYGuHVwX7256QrD30JY+kk6fl8mVTIbP5pIFdYch4qLHi
         ufLP1xmFa7uCnlFjq4D8AorWOEhVZOZjRqP0i7+Phce7XTHW/BGrBzwbws5yj8HhmH+T
         EfHudL9kzCtj3v5sMBexNnmVFjTT/h/CO0p7eawyY0Jb4jlomf+t5/DAc9nzFeq3uTOc
         isJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXLvXXdTgugvaqwC5VnS0gtZiRjZW9Lq1RMlH39mGsc=;
        b=rE841MZPdRTnIefOoFZWawQdEzXs0GP4kKLcYhwb/1S1e9QJtjqsq1kQaT3L56D33e
         YPyTttTTQShBbXo/h6mWdGuqCiQoHzxutAwxw4Qdid8nD0ej/kY9AnusJrLjztezad2i
         VpM+BOU7csMlkXdtsTNr5N1jkrUM3Rvfcapr3Q6CsrkpI9Ici7n5CHFnzk4/ouHAaj03
         XVzxBDJem3xxaVPQ2a8UUmow06fZ8jRCGenrCp9A1um3oHoWXYNGIBfC4rt8CRCWqTV2
         iwa+W/9cclQIhKoZ80JKvQHZOU94hj5XAkaE/Jdn6AdD2kEohWIuZiUSzkUZMQ7kyWf1
         Xtkg==
X-Gm-Message-State: ANoB5pkURYIrDfTaUX+qyWsBntyqCAHpDt91xUr3ac5pJzDAtrutjEn6
        4zt0J9tS5VwL6VhJh2vp0Ny5FA==
X-Google-Smtp-Source: AA0mqf5sVUGjUM+G6chuxm/fIpO2kBg+LSHQjHKLRSuED7OGm3sCl1RGRCdcBdb5BEnmnpVXTycpCQ==
X-Received: by 2002:a63:a61:0:b0:478:2d2c:6e82 with SMTP id z33-20020a630a61000000b004782d2c6e82mr15446563pgk.136.1669899709811;
        Thu, 01 Dec 2022 05:01:49 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.81.69])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a384400b00212c27abcaesm4855856pjf.17.2022.12.01.05.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:01:49 -0800 (PST)
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
Subject: [PATCH v14 1/8] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Thu,  1 Dec 2022 18:31:28 +0530
Message-Id: <20221201130135.1115380-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201130135.1115380-1-apatel@ventanamicro.com>
References: <20221201130135.1115380-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

