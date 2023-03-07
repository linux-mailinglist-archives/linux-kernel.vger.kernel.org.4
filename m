Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF86AEAC6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjCGRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjCGRgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:36:52 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142D7CDEF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:32:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id ce7so8543513pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1678210370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBw3TUvFHk4RKUwdqt9BFDNXuR7r1OX9/mPGk36mvP4=;
        b=no8qYmaEO+2AGv/Ic0WpAXhLuyjcpmP+pddKfSSqCaCJt71sjedirQTG5rKbhWo0VO
         LbeOdWHltmNGIhPh4VVLPe8P5FMb29kcKyVbQU5NovEd9UTjfP/gi9mg8iWkPgw5xuNZ
         a/bqLpllTxdQABnMfcHSDA7BAhWlFaFFc1NVdJDeT6F77CHXS4Xa4dZUwk2lJ/Rd6zj8
         p/TYLthWsJW2lXPKQa+KoHE5/C7R5grh6KH+lvllRdXaKOTVwfZDBHCDJoLsWerQb4IP
         KL8KUpFZ+eHG0Hnr4LbUCzwyraOdF7O4veUu1+YmM3Hp41EBZlNT/TapTa8XVGvOr1fF
         TLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBw3TUvFHk4RKUwdqt9BFDNXuR7r1OX9/mPGk36mvP4=;
        b=ROtLamoG3XThrRN3PhXJI+0pc6lpI+2zRYS5tb8qDGneRuGWqwRo2TmNFX+/D7Fh43
         SxBoCgzpUPZuHSrbO5was5znfGo9Y/3BGFfeaRkwQMRhl48L/tgkmeGyO72YJwAkTQgF
         sGQlnGreuCwHNqO3+CvGzm4hWRL9UqV68OhRVqOorEHuo2ErJZUI+ZolMw1oyizJrIOK
         2KPRX4K8Y1ndbdzwfUatGked3VpJ9rGW8roaIaN45k2wzI6TFaYUkTrWuASQryVsyLtU
         yFlwVpcJwDfJ0gwS3jB5M1Gob28uc99M4VZYWbu9Bot2cTrkeW/nDVuHOxsEhXuNqNNo
         2/Yw==
X-Gm-Message-State: AO0yUKXXj0s/uO0/3ZlQMW3l210Or4eOHiX5eyM0H1diR0IZNIC2kMAT
        oiCJrjROM+ZHsaiEZ0YWEgaT+g==
X-Google-Smtp-Source: AK7set9VDW+R8Pvm7Nwl6Z27bo4m6udIt0gmbM7cBQHWzoLcG66d1Q09gvMWXcvjsWgwx+3bYcCocg==
X-Received: by 2002:a62:1c07:0:b0:5a8:a467:f975 with SMTP id c7-20020a621c07000000b005a8a467f975mr13843121pfc.17.1678210370359;
        Tue, 07 Mar 2023 09:32:50 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 1-20020a630301000000b004fb11a7f2d4sm7996185pgd.57.2023.03.07.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:32:49 -0800 (PST)
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
        asahi@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v17 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Tue,  7 Mar 2023 23:02:25 +0530
Message-Id: <20230307173231.2189275-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307173231.2189275-1-apatel@ventanamicro.com>
References: <20230307173231.2189275-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
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
index 8c3b59f1f9b8..8a12768c09ee 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -112,8 +112,6 @@ void riscv_clear_ipi(void)
 {
 	if (ipi_ops && ipi_ops->ipi_clear)
 		ipi_ops->ipi_clear();
-
-	csr_clear(CSR_IP, IE_SIE);
 }
 EXPORT_SYMBOL_GPL(riscv_clear_ipi);
 
-- 
2.34.1

