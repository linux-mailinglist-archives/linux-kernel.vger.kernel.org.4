Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3279173CAD0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjFXMVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjFXMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:21:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C87E2112
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:21:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa86011753so602375e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687609259; x=1690201259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep2XsA9j2LD9YyooNd5WW+/YowFL7q+DOAVN9RNvwtM=;
        b=HqVG27IW75eotRBvjQJoz9xZyhDt145raK7ooTKnqu1gvdfvCTqjpUDRkjfALOWDC0
         mD4PWhAlcqJI/GE4WBdRaig1Nz8ol5rOsAd1cbvTM2oyWEp7MKJVmPD5p3RVYsNRacUG
         sSx6dGcqzbcvueBBPiznmCyGLZPSjkqnwnArEjLJjlVEsOUNt0jqnQMYHN1cbCbjreWN
         9Dv/hx7mxiAdn1EYlTNvcONsABk7uWEp4Illmj3F/P02ehGh4ZDXsTIenjMWEoDbCzVv
         zi2pv57FNYPvzvif4UrJc9KZEoR4YszV5m2YdtNmQuKZc3J4J9ZgfMyzfWnjkuUIqH81
         SX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609259; x=1690201259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep2XsA9j2LD9YyooNd5WW+/YowFL7q+DOAVN9RNvwtM=;
        b=KnoHxWd7Rkq1EiST7EHlfgzjZME1850M/jOhQSbdLZbyQozmbKeTwO4A/4vijR5H4C
         GZUsGf14IuMjx3WfG5tsGipBEBaOEF4DAdAunCoFIE05sxi3gWJEOYHbEW3gMKI3iOm/
         CEO9EtfXPBgxrpLDaJgwcExEwYnta2/w4u384LNT3lfePqovk6z+tIa4BEZopuCnKGnY
         HR8YMdQh1H/T5x7x+DW4txLpFT6kcjeSg1NPGk8coKAYxFoLaeGk0a4bEO5XFiI5i20u
         4tfqYX8rI95CXqsfnC8A9bq2OYTaOkxI+672mfJe7hqel3iEBFOXoK996vHLy7ptDBO4
         N5Ow==
X-Gm-Message-State: AC+VfDwS1zfRhD3j6Vx1CgYGAacFxa2zAZ8VWSgXR83ki/37SX+b/qv0
        NW0akjK2o1ii0PjMuPlG0pvREg==
X-Google-Smtp-Source: ACHHUZ7YN3i+JPKbbojGoxNDyVgRp5DPwz5gJYk2TtRpMCkPHy0uZUm4weZNeKjABF/uBJNYciMH5g==
X-Received: by 2002:a05:600c:3d93:b0:3f9:7c2:175c with SMTP id bi19-20020a05600c3d9300b003f907c2175cmr20595520wmb.2.1687609259522;
        Sat, 24 Jun 2023 05:20:59 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:94c1:d2b1:7300:5620])
        by smtp.gmail.com with ESMTPSA id y15-20020a7bcd8f000000b003f8f9ab6f30sm2058823wmj.20.2023.06.24.05.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:20:59 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/6] riscv: allow S-mode to handle misaligned traps
Date:   Sat, 24 Jun 2023 14:20:46 +0200
Message-Id: <20230624122049.7886-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230624122049.7886-1-cleger@rivosinc.com>
References: <20230624122049.7886-1-cleger@rivosinc.com>
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

Now that we will be able to configure the SBI to let us handle the
traps, let this misalignment handling be available for S-mode.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8c258b78c925..b544cdd52dd2 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -149,12 +149,6 @@ DO_ERROR_INFO(do_trap_insn_illegal,
 	SIGILL, ILL_ILLOPC, "illegal instruction");
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
-#ifndef CONFIG_RISCV_M_MODE
-DO_ERROR_INFO(do_trap_load_misaligned,
-	SIGBUS, BUS_ADRALN, "Oops - load address misaligned");
-DO_ERROR_INFO(do_trap_store_misaligned,
-	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
-#else
 int handle_misaligned_load(struct pt_regs *regs);
 int handle_misaligned_store(struct pt_regs *regs);
 
@@ -199,7 +193,6 @@ asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs
 		irqentry_nmi_exit(regs, state);
 	}
 }
-#endif
 DO_ERROR_INFO(do_trap_store_fault,
 	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
 DO_ERROR_INFO(do_trap_ecall_s,
-- 
2.40.1

