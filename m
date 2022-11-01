Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE673614CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiKAOfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKAOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:35:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786211B9E3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:35:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d10so13623437pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR0zkcTR64wHAjX9AnDry5ZpqjNrgt1ho9rCOwWk1u4=;
        b=PrmfwbdEoaA+/aYLn6KyPDuRPIrF4ku2zpK97abpZpsznZm3urteLLw9eV0BBgWNwM
         Bjo54YGJEsSxkGd4Trm8DnISuPbfN4cRiqrZXElAhSWk+T6LuEebogO1ylpJrCtLrLk+
         0HPxBa8a25+1p1YfDdYLr+uXUeXNpKLHGnoZ0+m1i7AV4BqdVpHtxlzeKv1CJukCveEJ
         I0CQ57IhbBLeODYGchxZnqqbt6rH9n5Vi8m9aV7H3xN/mZrk0pS5BLi0G7odfFT8KJ8D
         5HERjnKGl3waiShgzUrwLCgmZERsHYutExRuYTM6/kmqaliV9H/tva8mc3Hz8j2kJhhH
         eI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR0zkcTR64wHAjX9AnDry5ZpqjNrgt1ho9rCOwWk1u4=;
        b=ZRz011ETLo9iG2WCiTkiQFEplM7gExEA23Yi8xQnmuQ97YzzbrKG+p02u1eIL8TMIh
         uzw4HmvPd2b5xkrn+g+krC9XrX/zXvIY1bBpvbhipxJMiczU15aK8b4kIb/GJB2XJYaa
         QdrZ/TnmcN/NfrC2RoeYQHTvp9M9qdn5CSlYUSrCSp4Ju03CbElFOfhpbNJ5650iTBlf
         lzxAf2c4o4qk/ti/CQqL/xwzfIvUkF+V9e5eyFYnyKnf50LCCnQQxp+Iq73b32PVcDXo
         LU4URRH/ZDhSKIHgMajrVCY8cPz6tf+vi5J6nivFqb0DrLCNTxugWOxU6/H6U58W223c
         u68Q==
X-Gm-Message-State: ACrzQf2QQvT+VqKtdXgZQt2UMvhWTV6oLl8bM0A2sYl86WJhq9ml1dFC
        lYuvIgped8BKKfJHPcEgoj/SXhEMUJzFuQ==
X-Google-Smtp-Source: AMsMyM5ziTFAirnAfSVMBfXauwPF5l+do40/tZsapEiJXWEdNzYhHb0bMdaYzsJPlxk7HV/celXeBQ==
X-Received: by 2002:a63:eb03:0:b0:46f:80a3:737d with SMTP id t3-20020a63eb03000000b0046f80a3737dmr141167pgh.447.1667313299873;
        Tue, 01 Nov 2022 07:34:59 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.52])
        by smtp.gmail.com with ESMTPSA id o20-20020a170903009400b0018685aaf41dsm6449055pld.18.2022.11.01.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:34:59 -0700 (PDT)
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
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Tue,  1 Nov 2022 20:04:00 +0530
Message-Id: <20221101143400.690000-8-apatel@ventanamicro.com>
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

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote icache flushe directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote icache flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
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

