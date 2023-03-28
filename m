Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53906CB523
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjC1Dwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjC1Dwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:52:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D11985
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:52:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u10so10418272plz.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679975564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBw3TUvFHk4RKUwdqt9BFDNXuR7r1OX9/mPGk36mvP4=;
        b=lnlrjHXkDmMDlzuUoycXwQD48f4L24SZZA8SsdN6lNfctWR678XvWa5Cgq7gF+a4sM
         Kjf/fXmcYtyaxGY2EG52YmQko+UyiCDDaCYU+vx6ADZo2peUKOin3yAqtVp/UVhvtWR7
         kDnHIUAHHJ8FGb9x8jyrt7hEn+A2PKH3AMfsmPG5JZDaMlFCSQrezJ12Bc9HsgTJF7/x
         NrbqW+fRijYgcQZgHqcYetFZeYV6yQKd8KliP1t50+GlFyMAi/tLBKZJNZEUGegyjXnx
         V1N1mxiJOKfi0V/KiIfkXKqND56Aul8y95QTqnMzVHSV2E9d9sl5Ap47lQhcxCcUVTSr
         1Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBw3TUvFHk4RKUwdqt9BFDNXuR7r1OX9/mPGk36mvP4=;
        b=1xmEWeIH9Nl+NDR3uZXEwNw7vohBbsFuuU09kFb0G5nUICdnSawcTQOx1c7OJTj0Vd
         zO6O0LIj3gtJVLRW3WYb1cIdwvapJn/0l+zCYSUJrUHrqzWXsG/6SdVRshWlz3KGk0f0
         lm6ckbPREg9JLWQ5GLnbtKX7ggp0JA1k9fLWV5So8QDCbTdqyF6scGmAYpUZL5ScFnfn
         cXWZqnPfQsj6WYtVATXdfv3IhQBDhxyqHid0sqFzrDbJtJIz3jSnKoqerD5+XBucKSZw
         uljUHS6nVupjzr0WSK1aq9Dk03GxJqisVPdGx13GL9vHLDuDriSCh8txXnVElEjwd4VM
         XWTg==
X-Gm-Message-State: AAQBX9dvq03uw9PvAGpsoZU7KtjNSTGuT976QQhtxG9NCJp5SfPW2zFK
        +JGZZfAqcXUg7Kq6Npx4EMqTKA==
X-Google-Smtp-Source: AKy350afybI3qRbx5wQdWX4X4jL41bTX0UZlK8bMwkiS3yLjNrVxA7e/p3UM1qRey92yO0/nqdTlkQ==
X-Received: by 2002:a17:902:ec8f:b0:1a1:af34:ab35 with SMTP id x15-20020a170902ec8f00b001a1af34ab35mr18073772plg.2.1679975563972;
        Mon, 27 Mar 2023 20:52:43 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.82.104])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b0019cb534a824sm19880278pll.172.2023.03.27.20.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:52:43 -0700 (PDT)
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
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v18 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
Date:   Tue, 28 Mar 2023 09:22:17 +0530
Message-Id: <20230328035223.1480939-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328035223.1480939-1-apatel@ventanamicro.com>
References: <20230328035223.1480939-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

