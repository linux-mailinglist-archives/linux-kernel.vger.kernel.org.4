Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1136463F11C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiLANCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiLANCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:02:18 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBBCBB7ED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:02:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so5160045pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=S7g6waYjN+0+SwkKuvSnobOjtygf7FcxN5iSyU6NRY2OD2lh/w0ZVN9fupepMU0mjT
         Wq0Z/TU8p4Ts0c5qdkPX4OjEZuDR7A+Qxm92oZllmBCjlrjvXAX6NKnBIMox7bDHR431
         Vym09s61EigwqBmGzjklNXQ7wEEW/xdRouQ1nCGVW0N1N55i886OglkLNr07MrQYPAB7
         aRrEbiIe2Ls2J88KNodTfLhatlF2xIU6xZZ2FkZx0oMTPOKiTQBZ4E2a3kDxiY+Iib/O
         mhlC7+fLzvYlZBgYgx6+YIaYwQKDA/nq1ZIFvsKYNZAwPkm+HT6dluSLwS/ZAh04fQJX
         EbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+D6mfTqwfey0lLy9Lc3RpfTXi+1JUYYl3NRmY/n6Cg=;
        b=DhevpJd6hAB6JfpbaLbY9c4LMbZVMWIg0kukU7Cw24fZvkvtTVMaOZAPB6CDriDqko
         zvZyERRLlvWPtmMhnRKlr92o4h50f04WtIQ0wq59F9yQYQ3j+N4PR+uKGUsLgCTtM8qT
         QAraaFkFJ5kmPNIqzbnyI9NVobydaC4iJ2pwGzzf/3HhJ3iDDARyttdpl573f45Z1R6x
         qSJ5CMqzA1ZwtkxJhnI/7Ya/gx8Nv2LJuiQBdKGpp9BEvk5HoV8TnYavt96abGqJTaU5
         s3e1BWpFrknE3P2akFaWtOHTA234yJ+Bf2MBXn76LFOApmo/B0CIHbD0BVhFxkI7Q7Ab
         Nuhw==
X-Gm-Message-State: ANoB5pl2RMqYU0uNrTBImHRANjdmvprnBhuhZZpZ5AzqaddnvqEYFyyC
        E0huaBYtP7Dgs1SVModG6P8S7g==
X-Google-Smtp-Source: AA0mqf7dIIJqC87dxBsH390GH5t6+SbzyL0AgdbTUxWbHGXDJSmxVhTmVwCmHQ35gQ1I7Zu0obTQdQ==
X-Received: by 2002:a17:90b:3944:b0:214:1df0:fe53 with SMTP id oe4-20020a17090b394400b002141df0fe53mr74908231pjb.214.1669899736990;
        Thu, 01 Dec 2022 05:02:16 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.81.69])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a384400b00212c27abcaesm4855856pjf.17.2022.12.01.05.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:02:16 -0800 (PST)
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
Subject: [PATCH v14 7/8] RISC-V: Use IPIs for remote icache flush when possible
Date:   Thu,  1 Dec 2022 18:31:34 +0530
Message-Id: <20221201130135.1115380-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201130135.1115380-1-apatel@ventanamicro.com>
References: <20221201130135.1115380-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

