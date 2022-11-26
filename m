Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E97639779
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKZRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiKZRfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:35:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1561E704
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:35:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a16so6340405pfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=Zwh+Ahf+PgqpdmwI+hiwrJofafPo1sFBQ6IhDsfkFERh+5Gx5QG/aejVs6P5aJJjmF
         /RfUcP1ztUo+ceXPHow4SZF7bt3cOsKwJEayT7pptuzlQDh41whAJYNg1neIaBaE9wTY
         cRCdZCKcvTqwBNsHzAru2WW/bhu42orX7JAtQpE2PX3BNRBzCVjcLFCBbcqwRy9J0O6j
         YUOPHYluSq7pwYM6meho8d/yhogNg3hXYZ5D9JT6K1M7VYhxAnhcypyEYytXVMpCHUTn
         ITTcASdbPEtUP8QhbMuCgrEPvt2Y/l/qux7M7/UL8e9q1TTYIxVdGIIW7KWpZTm9o6pb
         SqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=64JHqe9bd1CN44vPIGCpi5SoAj0N9+PDf5MSuFj35lGUIyQbbA04RUY4Pu+3JwOydx
         6O6KW2uqHs9vaCerBLfk4/j0g1l/k2V3AFHzri9+yO0DJq9Lgv8EBVYWMwIwWhSq5ZF9
         0dT2XbX/XbLeWN7ToA3HVqmSYL1hfrWHgZeIe7I45o/F3pZcoCkCNp88I4+3np4MKFDO
         j+xaBaGHsNZNZny3tAbSONR9hnhsBwzTn4myq7bFqEX2AyC1do17plOzT1DJt1BCUqZ7
         punfGeXLn4vySvoMngPFCTb++glxJT45dfmKDcu6pwO/JRXmq7NYKi+xS4vlQh2bXqSS
         1GoQ==
X-Gm-Message-State: ANoB5pkfyxWW6qHk2AeoOylXqtjIXGdoN1OioSrMygX+KBQhuZim4NRP
        d9fN6GBfGls5MODxKM5DlZCwRQ==
X-Google-Smtp-Source: AA0mqf5dfIgCp17C7LQceJaVkBMaJSg5WjR+0IJyFoAGzJcOgVQZJMoxNB9lQFwQNI7UtlFh4ByEEw==
X-Received: by 2002:a05:6a00:26c4:b0:574:9a44:45eb with SMTP id p4-20020a056a0026c400b005749a4445ebmr12148774pfw.1.1669484137553;
        Sat, 26 Nov 2022 09:35:37 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902bf4b00b0017f7c4e260fsm5639813pls.150.2022.11.26.09.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 09:35:37 -0800 (PST)
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
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v12 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Sat, 26 Nov 2022 23:04:53 +0530
Message-Id: <20221126173453.306088-8-apatel@ventanamicro.com>
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
index 57b40a350420..f10cb47eac3a 100644
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

