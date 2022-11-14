Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8F627933
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbiKNJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiKNJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:40:08 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086741DDE5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:40:08 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a7-20020a056830008700b0066c82848060so6326065oto.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=mYE+ec9IXB6vAxMkqvnDohJnignWzN6sP+uMuCmmjqMF+LN7t8mFcaVk7M/IUujQQQ
         QpMlpGljTQMKtQMDU3t8ud4Q/NRM7Xv6atQp2CVvv7sfAc6rErDtSkcYOBiWVkBwNw7V
         4RmUJ8o75a6ssu5twmDTth2IRViiHPXo/ICejPp24KRzDf3S9UCYbblReHoDtHPODOE2
         ub5hSzx8RGHlhfyaeQk2gUFDvhx2uyGBiuNuIVlf8lDV25wXQXQxHnFXaav0kCB3ltzr
         ia86Z9pdVyMViCKaidGZfx6q1Si7pyHtno+aPhr5shTjhXhLmD1sLdI9miWUhaHRNSHC
         jpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=od7fKjhQHoAY34gQ91qA5bb+ZZxN8iyz79VyylK0nIAS+MPRQ2b671lOmsJX1s5Awl
         lzC4bG3fhGkZK08GhIE3vlArD7ojTTENaERH5q6xVWJdUTRMOuP6s3zNIQUIAFnW5Fap
         5TKhTWXMekMU4UKs4IETRN083RAc+b3taZLi8uyPa1wDbi7ZGr2sQ2ss1jraxtz7ZWG5
         JSxMHan2BPXa+2R1TdzKfSc0S/ktSPCHBLgdRt7dl19b06zcA7KUxvVvNg16HJXU5JBE
         pzQQw+msyJNt0abk7Qu8FYuJhMQ58/otQqkCrWys22wYaVl4x0Pr+RHwB1LixbAltrPE
         p0bA==
X-Gm-Message-State: ANoB5pkgfZuuEIVNfFW3jen37EKvif2Fi/NykTbeGesW7LRVu3Y6bZbH
        191qvA8tOVEK2AWC04KvNRTKDw==
X-Google-Smtp-Source: AA0mqf5PWFamSHkt6BWY3FBYrOVdIwJqVj5bAOC0u2eHqPfK+YFGfVO1f3M0sLrDjrE+6PUeGz3JSA==
X-Received: by 2002:a9d:4f10:0:b0:66c:5232:b9d1 with SMTP id d16-20020a9d4f10000000b0066c5232b9d1mr5855911otl.224.1668418807264;
        Mon, 14 Nov 2022 01:40:07 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id l12-20020a4ae38c000000b0049f3bdd791esm3222677oov.26.2022.11.14.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:40:07 -0800 (PST)
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
Subject: [PATCH v11 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Mon, 14 Nov 2022 15:09:04 +0530
Message-Id: <20221114093904.1669461-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114093904.1669461-1-apatel@ventanamicro.com>
References: <20221114093904.1669461-1-apatel@ventanamicro.com>
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

