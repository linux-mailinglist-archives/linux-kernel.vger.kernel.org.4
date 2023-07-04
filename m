Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F367473BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGDOLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGDOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:11:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785B211D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:10:59 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55acbe0c7e4so548655a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479859; x=1691071859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nyDpPdQazxwk2pvs7+quB1sTF8r3wWKIala/GUDnoY=;
        b=CZLXwP5VfQFjNrQnljMV5Zy85jJG3k4y+dCeHiq43dFIAPlLI6+Aiw8u7Ewmj6ZKMI
         n+2VmRvDI146eRvT1T3tUKueL+wVMfiGNCkgHowSMdHmjUhXxC77nDSpU1HjavoSOI8Z
         7s3o8t88db/r3H9oFk6dS28esOW0KptWw4EDcpiqhwINWZFpDI4YUDxEGLpp/R+Qg2+N
         r8R4zP+32ZhTE58O4FHU8SuQK6bg4pwmqJ9ozEq7N0kwMILYVuLSx5y3anN59D6P2hyJ
         2c1rC7vxx/kZY9dKN6Y6OOZa+SeVG6fUBp4FnXLQ6YRLuHyOnoIl1dHz5pGdkSsPSEZU
         lVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479859; x=1691071859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nyDpPdQazxwk2pvs7+quB1sTF8r3wWKIala/GUDnoY=;
        b=Mo3P7jn/f0Gk5nj6yvXMcwijNTAmt3K3rLAAZo5yI0ObW8r1BDcl4eMlrN4+PKiZSh
         eKAge2qgLmYRYYenZGMtGiCwUxdji8PazDxiFZ1A0YHSNB2rgVf5GelVCKm9VHAEKWf1
         p/mHMqLRKbNRHZybv1P8K5hNkTdra7pSfLU1erm1BUohJANwBh2696P+qf7Xy3NoV9BB
         X7KUm4ZVczLJL9ypJcsN1ftuxabUookl9YX7qfel+a3e8insvsaeu8yjM+sH+nIwyQb9
         1GrKUEJ9FdlnQfyy96e3neECA/KYwWEGB8AFr8mme6RmlBy7YNNZpz32cLaZthL04TlY
         7/gg==
X-Gm-Message-State: ABy/qLbGry6nfjfjmiownFVfpyZkE7cZRAhgTGkTQWOXd8X6bf2xelvw
        F/eCBfmL1V7a+rwUnIQ4o4flKA==
X-Google-Smtp-Source: APBJJlGlJHbQn1fjO2ojYVmiw4VmYk3Pe31P5xg00a17Fz/X6ELKBxWagGdfOYtxZ6KCYAit5lucQQ==
X-Received: by 2002:a17:90b:2396:b0:262:f76d:b29c with SMTP id mr22-20020a17090b239600b00262f76db29cmr14800835pjb.2.1688479858934;
        Tue, 04 Jul 2023 07:10:58 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:10:58 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 PATCH 4/9] riscv: report perf event for misaligned fault
Date:   Tue,  4 Jul 2023 16:09:19 +0200
Message-Id: <20230704140924.315594-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704140924.315594-1-cleger@rivosinc.com>
References: <20230704140924.315594-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing calls to account for misaligned fault event using
perf_sw_event().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 9daed7d756ae..804f6c5e0e44 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/perf_event.h>
 #include <linux/irq.h>
 #include <linux/stringify.h>
 
@@ -294,6 +295,8 @@ int handle_misaligned_load(struct pt_regs *regs)
 	unsigned long addr = regs->badaddr;
 	int i, fp = 0, shift = 0, len = 0;
 
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
@@ -382,6 +385,8 @@ int handle_misaligned_store(struct pt_regs *regs)
 	unsigned long addr = regs->badaddr;
 	int i, len = 0;
 
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-- 
2.40.1

