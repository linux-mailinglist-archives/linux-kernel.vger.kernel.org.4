Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB79614CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKAOen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKAOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:34:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331671B7A1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:34:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r18so13549250pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwWFYCYJumXDNukDFpgq6aZHdE7ume2pA+aIBGQJqXE=;
        b=GFcmRIesUWIz/XTK/DZOnuFn9hhDBdvIgSX+tNR4YNV02qbkLgAb0VRAQzpftjbynm
         i67Zt2PpSUy3ObjokrZCMzlwwwcRqRUz2/FZY0cprReKwAky0iyKfRQ2qPcRFVCebn4/
         tcdO4dftOeCtLKTNKhgjtGlxbbZovxnenlGQdbc1bhh0XZbFj66iqJh79gQUpgINBLFa
         1uy5vR2ZquzfPKjcwVnsoQzQEEiGgHu4uD5JtPfbzTrEx6nwnOre74V7wuRpy7JyIPEy
         UA3L2tSHdvrXvsh16MFn5OKFZvg4eK3o9g/Mh5LJ/sWbJkDCBVi4Bwg8wovl4YVBGNjt
         if3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwWFYCYJumXDNukDFpgq6aZHdE7ume2pA+aIBGQJqXE=;
        b=cU9/KrkiDuRMMfZioVw2NsGRG1OhdkqEZeoJUF0DuGrMfjJv9N6FNKhFmOGx0T2uAH
         6HJtOA4ZbNPKLDZNJM7+H/tOnVkNm2ocHBqxOweD+cyFf2+YlRkyFHSZljHWgMAdRguF
         LgO9doByIQb0MtmXgsfxd0RTWcWcE7+J+5exwvqVc+ihhKNWNndYxA5lG+pr5nadmz+I
         cdHVUWHiJSAQSh516p4khwhWn2PVIILilm3oA2NKpIxbTWEE9xFxMGpsumfvIqvui4xj
         NT2YgJJ/aAyczIbWWTAWzLsakZ6g74A6F4J/vmSPE1/LMzTzGQascP2gILK0zWcbjs9E
         Cazw==
X-Gm-Message-State: ACrzQf2BTLelZMGiDSmMIBPf4koyswHWOQ8fX4Y02z0cZmJie/lVtGbn
        WSeSjuw2deK+c9omjYYzJ19s5w==
X-Google-Smtp-Source: AMsMyM5o6B9od63fp9tZyjjhp++8fvomY8nAOhDDu44nFRorJDvpVOxvp8UIvFvTaMmL0/Pq5YO+4g==
X-Received: by 2002:a05:6a00:1f06:b0:56c:ee8a:29f7 with SMTP id be6-20020a056a001f0600b0056cee8a29f7mr20213771pfb.44.1667313277494;
        Tue, 01 Nov 2022 07:34:37 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.52])
        by smtp.gmail.com with ESMTPSA id o20-20020a170903009400b0018685aaf41dsm6449055pld.18.2022.11.01.07.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:34:37 -0700 (PDT)
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
Subject: [PATCH v10 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Tue,  1 Nov 2022 20:03:54 +0530
Message-Id: <20221101143400.690000-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101143400.690000-1-apatel@ventanamicro.com>
References: <20221101143400.690000-1-apatel@ventanamicro.com>
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

