Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A364148D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiLCGq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLCGqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:46:51 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E69B0A22
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:46:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so6563683plw.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 22:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXLvXXdTgugvaqwC5VnS0gtZiRjZW9Lq1RMlH39mGsc=;
        b=Bk8IMyiJJcigVI9/tPvFR3iMFW0qALSihXCl6Q/O+2yH5AaA8bhG3wB0ZMKYLkuwPf
         UqgRpCQW2j/D6WcogjqE+MF8OCpTYarOX1z+fV5KX1ku79rTvsUPtMvCcDoSmpMOMuVz
         DI3dL5wUHZ8hL1Z11rSxjpPQWt8xIfZF2JNScYBHPcwCzvp5Z3mMBxLBwpfCmxDo0J0N
         09drmoMJtBhGX1PxvHvSXPSyRt4miHIXCM6YQKzJYCwn3e/pens4fqt9ezpMJ4QTG6jQ
         YsjGDwgy6UrHEs8KbL1brWzVcasItFUYXLi2CjqlQVPu1x4a8b3RqNAOMyo2G83hiuZN
         EPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXLvXXdTgugvaqwC5VnS0gtZiRjZW9Lq1RMlH39mGsc=;
        b=wqE5iAaJ52BuHDt+DmQTxGaurqR/av7TP24muoCqMhwGrTwt1x8nlPcZti/PJg7mBI
         eQe74lg3TktkCZviAnuQjw7Fu4OTDJ/R51qBcuPyiGHCM05D8v9WO2jyNZ2DEH3jVUIM
         NKbcCDsptMZ2iGvNywhROcEJddHa0xaDlR2/JzibwM6z+26YEG1B6Be4+MpilK437vKL
         7qwDqGOqnukCPlzjI4AbMv4yoIhUHDfEUN3J11MrXOqJpjm7WRlN3Fs3M1lysXDpZQ+O
         eA5sHAae9Ra+E+CchW5YZwafg6+vTqAXpVBtpjkctk5+Sh8kQl3jVaD20MnEi0loVUUQ
         gKgg==
X-Gm-Message-State: ANoB5plUUHcimtN5KaIODg5WhgD26+nVprKNORzK0wscHO29ktnKh4RT
        wWh68vFUpL4iz6T1+q9/tyrgYw==
X-Google-Smtp-Source: AA0mqf5EueLG5umo38k+Oy9FmPwR0t58Ma+OGjVEDqGQWiGk3snpn+pIfIke8R+7tljJ8H3spMsNEg==
X-Received: by 2002:a17:902:b20f:b0:188:fd02:5462 with SMTP id t15-20020a170902b20f00b00188fd025462mr57588715plr.36.1670050009954;
        Fri, 02 Dec 2022 22:46:49 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79471000000b00575c8242849sm6102091pfq.69.2022.12.02.22.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 22:46:49 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v15 1/9] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Sat,  3 Dec 2022 12:16:21 +0530
Message-Id: <20221203064629.1601299-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221203064629.1601299-1-apatel@ventanamicro.com>
References: <20221203064629.1601299-1-apatel@ventanamicro.com>
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

