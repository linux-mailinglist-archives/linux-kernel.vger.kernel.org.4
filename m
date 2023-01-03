Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8034565C1AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjACONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjACONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:13:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483FB11452
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:13:11 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y19so13667776plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l+i8uOcQCPjKaNrtjuOObll0B7/vooLhOJlMTFIbSo=;
        b=gBGy2J1w2sNV+FKC+CwdJral87hxtnjAvNKrX/I7Kx9XxFh1Rv51fQJYZ54uQYIS4B
         1tNxT5y1i3npT2XnNuRbkMyEQ6UCS60F7ECqvYbv2KKfqlDRWssFgN13KZXsyCnuVW6h
         ac5+UnnYYm1V6/zMXBm26gN2RzGkXdr9TNei2tXCQozIE6IsXk4lhqtYmMGuHOn3Yc31
         OzBdso1OdRcYYWVh6/o8XyArpoMuNJr7DRn1HXlWRCOhHMZLolGVNoF+0SwtbCopui7q
         FqvYYrBqonmUg1ooGXM9ltL6E42vT+Q+jZm8lFncGX3YoCneec+V8bs0a9pHM6/TcMNe
         F0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l+i8uOcQCPjKaNrtjuOObll0B7/vooLhOJlMTFIbSo=;
        b=B+BkvkZg5OXdNsXlT3Oc3+2PPNcZ91qx2nGIJTrOB9yPQ7bi9mdmO+H92vfCWUkb9Y
         5k0k6yvMdKvX2P3iiJKQPeM+B0bmexXRqkB21K/4lUo42nELtpGks4WhcZiNtSxrv/Tw
         x6qgjYPqLnlDOaHXhF0jtU7n/FUFKatfHYLtssXBY1LGNgXnjaQ5QZVOAW0fmPiY6hbj
         fOTMB3ufRLApCosWE/36n9XH86rc7zTdMhHHjaw082KU3PFInzmMCxA7feFwIcCbt187
         5Kz3BqcX+XFs2PVrAJWvh5JnCyo/NWB1udYd6cJEDoOnlS5CyN0KlYQJ/5C0AgJmscKC
         bAKw==
X-Gm-Message-State: AFqh2kqAR0ECPHNQ1FMEG6vyuYqCKmfoj5O3GlXpiu/69VWtCDhh2lNB
        /ZPPWvyrD4f9CMgIN4llFImtUw==
X-Google-Smtp-Source: AMrXdXs3feqGr1SDeiC+wJOoPhGUm9jY6uwlop6e/pzHdUts4/koTGdcSOhacx6snIxjQ3SET/uLJw==
X-Received: by 2002:a17:902:e84c:b0:189:340c:20d2 with SMTP id t12-20020a170902e84c00b00189340c20d2mr71560778plg.23.1672755190683;
        Tue, 03 Jan 2023 06:13:10 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id x16-20020a1709027c1000b00192b0a07891sm8598286pll.101.2023.01.03.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:13:10 -0800 (PST)
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
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v16 7/9] RISC-V: Use IPIs for remote icache flush when possible
Date:   Tue,  3 Jan 2023 19:42:19 +0530
Message-Id: <20230103141221.772261-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141221.772261-1-apatel@ventanamicro.com>
References: <20230103141221.772261-1-apatel@ventanamicro.com>
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

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote icache flushe directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote icache flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 3cc07ed45aeb..b093727494eb 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -19,7 +19,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -67,7 +67,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+		   !riscv_use_ipi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
-- 
2.34.1

