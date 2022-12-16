Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD42564EF0D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiLPQ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiLPQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:28:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1909D2D1FB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:27:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso4465647wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qYMZscnhg3axVtI2bTNdXZnKgui98AcKoWlQAnIeCs=;
        b=vhEZGm1QXPdlJCD+7d9PcJy32KzwQJAMknHGf8qqBajr4gCrr0UxQ70GIvhyqSYoNz
         eNFWzXaH5KOeakclklBAaJQTNJ0A+j2VNskqQLWwhTpZd3CKARTbDX2opCaYTEhAiOvq
         eDh8gvk1mz/IqzUCP055btEAV/12C4EOpPySxKaOT77Zrlsdsqr1WHFXoPE8sw6Z8D7R
         b/AXf/Dv1w9KgT2gAp/6tjyNEmhKOTfQn9SLuqxmHOEsjI2c695gxRTAVuu+HCIMCAl1
         4PamHQAR09nYPNXQzRqMO1oJkExVcjPxnkbuboCIC60O7ssqlEycQyWCYz4hAYvth7Dw
         WRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qYMZscnhg3axVtI2bTNdXZnKgui98AcKoWlQAnIeCs=;
        b=P9J1yLSB9RjVQg2pzFkPf7hizpDcnwl5A6A0I1Z5Dhf2ekWLbYR5T6hdE8K8UM0BQf
         QXQateTYnLiTnIe4t6zYUjeln+kEFnpS+qpH9QDF+H+ci4OOuvL76c0HR9jbparck44X
         JS392uzbtu1ggBaaOgs6AIp+g/RapdPRKwLshS3MtKEtRR0oJIPeDBTrTq+AVvAAJ6CE
         cnZ7WNkGt1U4apXmpPjNAltUmp3Tr0VjyyG47pLPNmQIGNIKdPB11ti0a+gnAtYbfGEc
         YcK2XVm+D1V2sIeIZw0oOfFCgix5hQBMlgrA+KScFUQOBkfFJQme040jmPNW2nZJ2qH0
         XAbg==
X-Gm-Message-State: ANoB5pnWlFGFO1LYo+nZ4/NA/PT5KQU/QjTM4QO56VQyUR/QKXB4/qLi
        MM9lEBLCDQURRkWSWoeJ3Oxrhg==
X-Google-Smtp-Source: AA0mqf7guqpBhqTNxv/AP9fjpSc862y9DanbVLkBzjvCq+Op7BGNw9IUHI5Lc+bbIkQyrsvM9opB4g==
X-Received: by 2002:a05:600c:34cd:b0:3cf:c2a5:5abc with SMTP id d13-20020a05600c34cd00b003cfc2a55abcmr26558882wmq.17.1671208077738;
        Fri, 16 Dec 2022 08:27:57 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003d220ef3232sm2784387wmp.34.2022.12.16.08.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:27:57 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
Date:   Fri, 16 Dec 2022 17:21:41 +0100
Message-Id: <20221216162141.1701255-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221216162141.1701255-1-alexghiti@rivosinc.com>
References: <20221216162141.1701255-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If KASAN is enabled, VMAP_STACK depends on KASAN_VMALLOC so enable
KASAN_VMALLOC with KASAN so that we can enable VMAP_STACK by default.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b48a3ae9843..2be0d0d230df 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -113,6 +113,7 @@ config RISCV
 	select HAVE_RSEQ
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select KASAN_VMALLOC if KASAN
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
-- 
2.37.2

