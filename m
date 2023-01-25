Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3903E67AB97
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjAYI0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjAYI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:26:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749F366AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:26:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m7so2558130wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzLCWkEIOjhYvr7p7s7uKUj96vyQiWAZD9+xORl+Fd4=;
        b=43RnMhlzKC6isB+BlsuHH7/tEBHZ1/bP4D7/o9SX9jlnxONu6iV1jkJOq5Vco+FsjF
         oc3Hes7m3q8HaFo/WO2xQ9PKljtIXAx8WGirVA4cJgPmfTo4fuuVRXs/ByFS06lGVxsM
         aPVdiKVcLMSZU2ya9AX7nM6w1F193qIHtA+X2HYhctV/J3yNtCrUi49ldHzCr4Tgyv8z
         QEcVCXQq53AbqUCsokpzY0ocyF2O/vnz0nXJ83Aj2BzFFIedwu6jWWtyDVNm5mSD+BM8
         5g5MyXnPkGvD0+aEr27K9HaXKLlKTYtlvNLQLgbe83xUzGiSajRWLdyP3DOzWCgd4L4z
         4xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzLCWkEIOjhYvr7p7s7uKUj96vyQiWAZD9+xORl+Fd4=;
        b=PWhn0hSXMtAmGHientrw33wS6uaR8Y5NYFVt0mY9ub6Mz0QrEUjdH7HolSrHcVH1b3
         ypGbWBU6WV/a3JyEshASF1hZxMmD6kneFfk8LTnFPTcuBvAdICYQFXy1VH44QqHagWYd
         JktWlsuuDaKOIaXvs/d8TIxrOeVWwnawaDVLySxaL1nbA8Xezs2hmbvTV5PMZMyXZdZg
         3Exfy8AxuFEkqW1jex6WfR7yW5jQiFBxlFqjw8CHPlfppsWGNxg4a2HwbOgqwJ/WYJxx
         kIUv6nx66kMCNZq0ZChGmFcMDHwRFfDAajRlMhdEoOjoOSrci7s8jS4tw27EWbnJ+Bfg
         A1Bw==
X-Gm-Message-State: AO0yUKWpgLkW73zt4uULq/9dubWlACGgnVYw73PVjPOQRhywZHyi62Q4
        IMKqAF8qQhsdNiulax2MdczUXQ==
X-Google-Smtp-Source: AK7set90qFk1AY8kITr+4giuot8FT/Zyed3RBEfVvXtqS/ror/yZ4ozUkMAIncHs+g4uhizQZJhL9w==
X-Received: by 2002:a5d:4536:0:b0:2bf:b1a1:efc2 with SMTP id j22-20020a5d4536000000b002bfb1a1efc2mr4073913wra.18.1674635206045;
        Wed, 25 Jan 2023 00:26:46 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d452e000000b002bfb6b9f55bsm1607974wra.16.2023.01.25.00.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:26:45 -0800 (PST)
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
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
Date:   Wed, 25 Jan 2023 09:23:30 +0100
Message-Id: <20230125082333.1577572-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230125082333.1577572-1-alexghiti@rivosinc.com>
References: <20230125082333.1577572-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early virtual address should lie in the kernel address space for
inline kasan instrumentation to succeed, otherwise kasan tries to
dereference an address that does not exist in the address space (since
kasan only maps *kernel* address space, not the userspace).

Simply use the very first address of the kernel address space for the
early fdt mapping.

It allowed an Ubuntu kernel to boot successfully with inline
instrumentation.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 478d6763a01a..87f6a5d475a6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -57,7 +57,7 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
-#define DTB_EARLY_BASE_VA      PGDIR_SIZE
+#define DTB_EARLY_BASE_VA      (ADDRESS_SPACE_END - (PTRS_PER_PGD / 2 * PGDIR_SIZE) + 1)
 void *_dtb_early_va __initdata;
 uintptr_t _dtb_early_pa __initdata;
 
-- 
2.37.2

