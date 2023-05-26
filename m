Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0A97129E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbjEZPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjEZPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:46:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCD119
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:46:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f603d4bc5bso10091545e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685115994; x=1687707994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GWh9UDKye2M20srh+R8Vryxrum2NkiwrFA9635wntA=;
        b=mAnILZNnk/4CYo5pVG/iS9vkO1SnDeZwD3+xRXH7NanqhZoZeSn8FMqcBtzJa+Hi/t
         G3Y9tZzZSSCZG0Q5rnyuc3pFJgdNCFFQaxZe9O84iYBuGfDwIM05oLvxa2byTdLYn50n
         8CJY85sep/QmwfdU67veyl4OfaBn2sNIwLEezvBypEiboJ0zoOM5VulhN7SNd8GhS3BT
         5kEe3M8tWLz5VysifPEsu7Im0BUycU+q0J/6alQywOUuyWNIWatLD+3c3ymh2ILWkWWD
         kINojqleKsckPtypyHuNZF86nn5ouDQumSUmuKOHKPMMAPQCjdheF2PNSsyZRjJY4WTu
         qD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685115994; x=1687707994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GWh9UDKye2M20srh+R8Vryxrum2NkiwrFA9635wntA=;
        b=H+3EY5Xx4X7IfGWws33WIAly9ObIDreIky6IfCRmV+NlfzDLhVc5wKOlMp42LN/8uQ
         4pbzXX/obmttdA3gCbKzbokAC6n4t6K9YGCYCxZtsZdKYAg+fjgzlD3OvzJWuB2E+t6t
         VXSLxSNSaR+yVVLnRBSft0Vvhl6LfgpOqMPiWVMaj8qWA/fTyRLFxx/XYvwkslCU+ojH
         N4DBp4YUZnjXb276n/MQnQfYVMmITwDhxs5MX2LntxyVDxlg5//RViVK2x4iKRZobwCT
         u2fNbne0euqvxAew6x50e262XEEKduCmtjfaY3ZrY7MXsa3pTKc8n6FC016TNSF0CHM5
         XaAw==
X-Gm-Message-State: AC+VfDx10p8HdHtE6DN35W8Ffv68k8FEqf/aOuYlyDwRewMpLqgI33Et
        gUs6V91vb1j6WfGI1+bGky1wXw==
X-Google-Smtp-Source: ACHHUZ5XXs2GMoQKsr/YnhgTOA+ohouMlIaRXuTLbaMqGUWjzcoGSbojgLOVlZ4NceYDJk6KEsMlkA==
X-Received: by 2002:a05:600c:2197:b0:3f6:787:5e53 with SMTP id e23-20020a05600c219700b003f607875e53mr1969948wme.20.1685115994303;
        Fri, 26 May 2023 08:46:34 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003f42ceb3bf4sm5562995wml.32.2023.05.26.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:46:34 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes] riscv: Fix relocatable kernels with early alternatives using -fno-pie
Date:   Fri, 26 May 2023 17:46:30 +0200
Message-Id: <20230526154630.289374-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early alternatives are called with the mmu disabled, and then should not
access any global symbols through the GOT since it requires relocations,
relocations that we do before but *virtually*. So only use medany code
model for this early code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Note that I'm not very happy with this fix, I think we need to put more
effort into "harmonizing" this very early code (ie before the mmu is
enabled) as it is spread between different locations and compiled
differently. I'll work on that later, but for now, this fix does what is
needed to work (from my testing at least). Any Tested-by on the Unmatched
and T-head boards is welcome!

 arch/riscv/errata/Makefile | 4 ++++
 arch/riscv/kernel/Makefile | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index a1055965fbee..7b2637c8c332 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -1,2 +1,6 @@
+ifdef CONFIG_RELOCATABLE
+KBUILD_CFLAGS += -fno-pie
+endif
+
 obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
 obj-$(CONFIG_ERRATA_THEAD) += thead/
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fbdccc21418a..153864e4f399 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -23,6 +23,10 @@ ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
 endif
+ifdef CONFIG_RELOCATABLE
+CFLAGS_alternative.o += -fno-pie
+CFLAGS_cpufeature.o += -fno-pie
+endif
 ifdef CONFIG_KASAN
 KASAN_SANITIZE_alternative.o := n
 KASAN_SANITIZE_cpufeature.o := n
-- 
2.39.2

