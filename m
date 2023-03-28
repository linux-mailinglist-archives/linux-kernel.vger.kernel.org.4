Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1536CB529
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjC1Dx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjC1Dxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:53:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83802D74
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:53:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f22so6309574plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679975587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYuh0nFD6NwJIy6fdJnMZv8jO7haLudDJ7hSHLvipCc=;
        b=NRNMyNcfhSZoLR9QbApNoQGXQbsEn+nMfcydEcWh43W2IrC9oJayOkID0hWw2bbqud
         pNNWjHB5OsIh6Cr6PvSd/uU38XSrUeybs01nBOpjb3Mc5iQOwqktTIQcn5zoQcFz3Uon
         gZN2VHNBarpa5eMPfvR8p60EQQUFD3MgAC7OTC+P8WLF6SjIUUeuFkgZMQnC0CFB6IgA
         PVn+fVGZm45Qv46wtNxfOq3uHDxA6KA7bD3CMl22qgA1d01jGEqIE+in216JphBA2OfU
         PXT6kjzlmbUgKUhP0M2daD0hxQUifb4FoJbbIK2zDj8myPaBCwMg+jP2Jz4gv63cH92Q
         AyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYuh0nFD6NwJIy6fdJnMZv8jO7haLudDJ7hSHLvipCc=;
        b=7RT6r1LvqekH0E7ExfojXyu7H2HXzhrpNCZxTWx4zsA1JwS45W4SjPPQUJXyDPokKO
         DwD55QDFxNAiOyd7dGqh+H9XLRHVTOdgMvbFWFDjMDyWrKlfRKKXY4IOd5n8C1IsiAOR
         i8pm6HqVMiyX84jqx/id2tBK/qYHBEztaeeiAJqo9i97DA2b+LsCm6P/gRxQBj4NLaSF
         Hu/lx6p8tKC2Qs9LjWxRbjSr0W+EZPUxJWYm02X2I1YusoFSQbpKFmUNlF3AnG2ETumG
         BVgFzIeuenPo8KsXXoyiktuTy7e/HmQSVQdgdR7meMyWMEkt9A/i2tmk3/yDYTeYOf+x
         CzPA==
X-Gm-Message-State: AAQBX9cma8jFGQgc3FwOw10VwIkhc+t/dI227CkiF0FL5kgEyaWrmiZd
        hqxSLKrJkgySqCkWr2ajW/C592RTb7fMkttEL84=
X-Google-Smtp-Source: AKy350bLV4PR6X0dU3ueROaof97i4KEfz0eeNx8Bf+3cEA9GQev1ByHDUyeQfvUumBlKcwHa7FSKNw==
X-Received: by 2002:a17:902:e80c:b0:19b:afb:b92e with SMTP id u12-20020a170902e80c00b0019b0afbb92emr18463729plg.40.1679975587300;
        Mon, 27 Mar 2023 20:53:07 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.82.104])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b0019cb534a824sm19880278pll.172.2023.03.27.20.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:53:06 -0700 (PDT)
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
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v18 6/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Tue, 28 Mar 2023 09:22:22 +0530
Message-Id: <20230328035223.1480939-7-apatel@ventanamicro.com>
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index fcd6145fbead..20cec5e7cdbf 100644
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

