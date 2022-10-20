Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31960592F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiJTH7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiJTH7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:59:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADF18027C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:59:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so2352456pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuilwbSjTkXNw6j4kYlnUJ0pwJrZlWFK5/+cTZqJbNQ=;
        b=ZKNy4Em5+FuBRP2gsIy40Yrk6FnGU3CqJrbS4NGA0H4o/nv3ogel1a+BelUzdLO1+g
         EU+MmxJ/fG6lCskSK8CjnrO6mvqd192jk75tdkMPCx2sj0HVYrLPSIl/FCjUKLQqhXIR
         O+B28Y0IXu56SXNEgwVgKrhhZ6VobhnpNyQY2oG3K0B/EDQxN58o7Xd2xk1gaHZyl3fF
         njlaQHg7PekkPyXa7GZgMueBWS6N6jJ9f91rD5qgIsxZw9SBJj74KQ+Ze7eazFE4kmgx
         E0MgKtM0nHURmmTr65D876z74uLsOqBlxTsCGuq16N7OZB/lo37TXNpMWUkkYyqExwcp
         ohiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuilwbSjTkXNw6j4kYlnUJ0pwJrZlWFK5/+cTZqJbNQ=;
        b=nt/YEA4WlhHgqWBYt5RKh0akxUMMIKOQsEEBz4ogQs8BGpL/uCHhhemZmr+9pB9xg0
         oufUjil5VPqUNWsis2qnfUN6AQMy4lH0KZ9LD/GpMgc+iQbALWJ/2tqBO6K94H4S5Bty
         ZhKrRQ35nVvGC/xqYLJOJAO3E/cOG+2j/o6Uye7m4YugoIF1/mZGnNoxRFKWAG0uCVRY
         GfWc+XF4AsvWwdkd08vscqaz54BqJENpt0rxO9n7RGC9ZMXTPNuaAHQ1RVT1ALZ9T8tr
         2XDtLbvmZNiLI7MBPt3XCsqJMqRwfXFqjiV427w0gdpVZJcjvGSx9sJg92pPP/Dr2Y4O
         eLRg==
X-Gm-Message-State: ACrzQf3CFtLaPuN2tZ3rqh8lGOAIuC1DB5B4ZDCmAHlLKDexhKfGos0l
        5J8eNzuAEaCfKKxMBrfpYqy8uQ==
X-Google-Smtp-Source: AMsMyM4owvZnTyqDDywJXkxNgsuebJjnZ5lE2U3qnXcYFm8cRhbjwN/IzGov1M7IHnfRXLtTT1BHcA==
X-Received: by 2002:a17:902:eb89:b0:185:33d:cb34 with SMTP id q9-20020a170902eb8900b00185033dcb34mr12806731plg.55.1666252744045;
        Thu, 20 Oct 2022 00:59:04 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.23])
        by smtp.gmail.com with ESMTPSA id h30-20020aa79f5e000000b0052dfe83e19csm13206438pfr.16.2022.10.20.00.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 00:59:03 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v5 2/4] RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
Date:   Thu, 20 Oct 2022 13:28:44 +0530
Message-Id: <20221020075846.305576-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020075846.305576-1-apatel@ventanamicro.com>
References: <20221020075846.305576-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the memremap() called with MEMREMAP_WB maps memory using
the generic ioremap() function which breaks on system with Svpbmt
because memory mapped using _PAGE_IOREMAP page attributes is treated
as strongly-ordered non-cacheable IO memory.

To address this, we implement RISC-V specific arch_memremap_wb()
which maps memory using _PAGE_KERNEL page attributes resulting in
write-back cacheable mapping on systems with Svpbmt.

Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 92080a227937..42497d487a17 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -135,4 +135,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 
 #include <asm-generic/io.h>
 
+#ifdef CONFIG_MMU
+#define arch_memremap_wb(addr, size)	\
+	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
+#endif
+
 #endif /* _ASM_RISCV_IO_H */
-- 
2.34.1

