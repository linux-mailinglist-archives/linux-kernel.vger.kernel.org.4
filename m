Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B9663C26C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiK2O0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiK2OZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:25:32 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385272314C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:25:28 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y17so5659313plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=lpZEuc7klowGPJ/NMiV/VZEhANaP3uvyFfM1FKPBQxBVQRqFNVVVW0YLyIrotuIPwD
         TZbDgPaGoELOTncKZP0eKmfV0T1IMaYzoqN5sRIcbOfMTORA3sEJOqmxJd8bsPsqCqER
         H5BYlsYBKxLJ5MRjN7FQfDrPTaM6ajsC2EVOaMT26IAs0cHiehd5WAU8RteLjaA6oKYG
         Gk2VAsz2Gg+8s2NkpgPnkRvrkGS4CxLjxmkmz9ezTVbga4EA7SxzHtF1zUQRJex1uOTg
         BFx4PmZnVcwm6d8ELHcqS9eqrUVlVjp0PZHhZgHy24AYdpPcOtUWCi4LUxcNQ1nwUYoE
         Uphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=lCc9s2eOUIKalS+55xyrf6VjHvwb+j1tMdukebei70XtgAUzeujW2k8QSlRm6bXCjv
         YbTaqwaZynef2yQd/+g72WZVy1u6z5PpzB9wDEmmNnpQZILC+Ii6jLLaN960QMT3f0a6
         0NV3EoKwBfQ95qpz9/ib0ET8DC/tT1n+YZWwUDTsVivpWbNnrUEmzly0MuHyKUaAw7Jj
         ZW/U2T/6PPR38+7vy/qVwUlTR+92MsS9F8lr1HOyVsWdrHW/AqV87W5u7sAOT0phDew/
         zwrjUyC2VlivK+P1rTw1zH0HM+FtkWIUCe7WokBCYbahsMzhPlVLFtAj4eyW4H5X4fUb
         005g==
X-Gm-Message-State: ANoB5plF9aT+J6F7yq2cDcTXQ9n5u9mLANjwhSkpxtI9Cd2WRiPFT/q9
        0I1tPpDx6LqaSfnoFA9CeqXOTA==
X-Google-Smtp-Source: AA0mqf67J/4IsI5+V9s2LsFzINvQREYJvabQuwxJTZs8OfX+ZXBF/hE5DZYijVrXwsPv+J7MW/IODA==
X-Received: by 2002:a17:902:aa07:b0:186:a97d:6bcc with SMTP id be7-20020a170902aa0700b00186a97d6bccmr37868667plb.121.1669731927646;
        Tue, 29 Nov 2022 06:25:27 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.98])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b00176a2d23d1asm11039076plh.56.2022.11.29.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:25:27 -0800 (PST)
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
Subject: [PATCH v13 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Tue, 29 Nov 2022 19:54:49 +0530
Message-Id: <20221129142449.886518-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129142449.886518-1-apatel@ventanamicro.com>
References: <20221129142449.886518-1-apatel@ventanamicro.com>
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

