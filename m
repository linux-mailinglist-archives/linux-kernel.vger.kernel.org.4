Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41332641494
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiLCGsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiLCGrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:47:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04FB9562
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:47:26 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so10257467pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 22:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=O1HUEM1kuxlKgxDRZksTgkWxBmPSc8Nvnep6Fo8qupSeofGZxZUQZdS8cTjKMT/FB/
         /6w/3YB0RPnYvp+juqh71xwtrmU59lnIqNM+yI9s8p4QBfPcTiyKSNtgFvehf3aSag3T
         B1tOvPMsZih20BjojFJO/eAZn1wsgQ05BiwtQk3ypqOv6ViBTAU+7OcD0/ndsTTcabYo
         heP4OgXUBec8BfIe/9OMRANYtA3Hckw989gW1Bt94m1AlPzNYWFIL2J3BlfLZIC6fE+O
         d36vn8TnQ448DpYT+ooFjEH/shzIJNtuqtbIB/ORunx8GrtpTbz+0l3suOxftXeq2V/S
         29xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=68UoR6XMybcR1Gm9MzwJOZM4dfGkbgTk+Ug6taIv9aHfMFAFe7hsBUCnTsXXsaBUb4
         FF3Y7HzXrfq95arq7mryv4BRBnhSQzDEdubbiZhEvQdazG7Qe9sUssJCMjUwYv4aNOiK
         8GSYJ52k15b6tpoZcwFxE90Riepg11HMQ3hNW06DoyrNePYC4smfAntR40vWuv/H2T9V
         7H21+alA0twddKDRipODA//7S7PRty2O2ebr/W6pdlTGK1QOBRXDexpZvysz4kTd9pMY
         VzwAgE8VhIcHYGWwH78A8d4WunsrRT1J9TSPrIgQeDJDutx9Vlr5Mtv1Z1jMJXMi+g5A
         Ebjg==
X-Gm-Message-State: ANoB5pk40ov7BZvufYxqVrzMW8QosGOpc05SFXuiVuYTIZ7bSwEsEv8R
        dkzddetZtGFPNYrGbs2p0wI16g==
X-Google-Smtp-Source: AA0mqf5KzIZeHr4Df/4XED36JfSJMBY/dITpOcWof+TBmvy8B1PfZ/Aa0huOQwFFhzU8hz5N03WIlg==
X-Received: by 2002:a17:90b:2541:b0:213:30c4:e803 with SMTP id nw1-20020a17090b254100b0021330c4e803mr83420155pjb.209.1670050045998;
        Fri, 02 Dec 2022 22:47:25 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79471000000b00575c8242849sm6102091pfq.69.2022.12.02.22.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 22:47:25 -0800 (PST)
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
Subject: [PATCH v15 7/9] RISC-V: Use IPIs for remote icache flush when possible
Date:   Sat,  3 Dec 2022 12:16:27 +0530
Message-Id: <20221203064629.1601299-8-apatel@ventanamicro.com>
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

