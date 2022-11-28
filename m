Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510263ACD7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiK1Pp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiK1Pp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:45:26 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D061DA7A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:45:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so14410237pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ6qMqhLPYmOksP+CNivCn9CufwufiSEDlOoPaJxGkY=;
        b=ELsZ9KVmQrQ9u5e5iCNQJs/dW4r1dpDN+HoIIyBQgS0fgBM/07KBEKTgu+CmmuTLYm
         +bYeBfUqV16S906fSz0D7rC2x2ug420Azz4cSZ3fm6vP+ksvE1r+2ZxgNPIFvg1io68H
         Ae0NBuafKvNO3bVoPMGXl5ERQsUeGEmCzhUQ3f9foacr/fUdJw77JBC/cfD3ljmJXl1o
         C18DLedoBUC/rlB7ta+vZXvjsMxiZ/kjpfvwHF3No0QhvjWfl8GjqpHG55ZWAjRpeMfa
         scnwV6WKeiElIU3KKLI9baq6cH2W2QLCd0hr17L0HAmiDv7nf7fmIyvDEZot9idfi3hk
         s/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQ6qMqhLPYmOksP+CNivCn9CufwufiSEDlOoPaJxGkY=;
        b=KPEbUvFrmaMaxjjtK4Xg2jmhSTs6btP81aY2HUT4YVPOdD3EqzMw9DciRSuPJlvJM5
         xRiB53s7BUpVuzmFUzVn1IFxm87hftDzUNbnan3ZVKLLxgyTXbgHkh8Nnqkw0147ryNA
         JlSWChS99iCOnctMknakeHtHsYXswBYl5Wry2RQcWkpUPpbUinJByL8obv1BsZP2KeXh
         u99k81FWdy81TxVOwfTLvGvSSEif/MaagZeOfp5b2h/Hld5bU7s5BFCDynhYbXvn2Uio
         tZvQCmZkHzbcQt+FOe+gdy75CSe4IFF/1zApEfJO4mCE8MTNPygKIHmpYVpJkhI490XC
         L77w==
X-Gm-Message-State: ANoB5pkGwWumdR9WzjP0D0UT/CR3V8gwVsAdgZzoGj7dsd/LY0482Csg
        2180XLQ7yjVMYwtAoVGvX+k=
X-Google-Smtp-Source: AA0mqf6Se+XAK16ioF43g+Bg1u3Q35NXI2DREMP4L6ERe9Ftma1p0a59cHHO7cIvxwiSdDHiwjqkig==
X-Received: by 2002:a17:902:7482:b0:189:855c:eb56 with SMTP id h2-20020a170902748200b00189855ceb56mr3669644pll.54.1669650325145;
        Mon, 28 Nov 2022 07:45:25 -0800 (PST)
Received: from localhost.localdomain ([112.2.230.25])
        by smtp.gmail.com with ESMTPSA id b28-20020a630c1c000000b0045dc85c4a5fsm7025520pgl.44.2022.11.28.07.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:45:24 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
X-Google-Original-From: Song Shuai
To:     guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com, heiko@sntech.de,
        atishp@atishpatra.org, conor.dooley@microchip.com,
        alexandre.ghiti@canonical.com, anshuman.khandual@arm.com,
        juerg.haefliger@canonical.com, wangkefeng.wang@huawei.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v2] riscv/ftrace: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Mon, 28 Nov 2022 23:45:06 +0800
Message-Id: <20221128154506.2691-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

In RISC-V, -fpatchable-function-entry option is used to support
dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
don't have to be called to create the __mcount_loc section before
the vmlinux linking.

Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
Makefile not to run recordmcount.

Link: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa78595a6089..afc520a45ded 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -277,6 +277,7 @@ config ARCH_RV64I
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select SWIOTLB if MMU
-- 
2.34.1

