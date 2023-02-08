Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8DC68ECB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjBHKTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBHKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:19:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411DD2B280
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:18:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso1806188pjt.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOMPizwvZIOCZuA+NM2fq3lJj7qsjRo1bnIWUyEuTFc=;
        b=pvZLiQNLHy9hWo+yq3uZlY0c64wAYreH5GuiHBFTDCbc2xdxHfcesCS8f7NwuR19fN
         cnCRuvQAXZ58p9HRzyXJNOGdf1hC83l9Z/DtVV3Xc3ytSpPeSvo4zzxnaq5Iy/JhY1XO
         N+kQ20lInIiwi4AA79wm1ixmSeKBbIM4U6BiZm9Ze/LGFNis8B9gsmzP7tMPp0xqzo+G
         /uix2YIijYl6aDGs0T+Z+hklBCU1mdtsw83zYNuqv14xUea3Qro11pIqm3s0pZzWU9bz
         BbMtnkI2OreevPsTTyNjb/lCwvjtUR/Nl/81mj1mCY9biHHSko4tc/ZCkOL8qNXLl7Cn
         8PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOMPizwvZIOCZuA+NM2fq3lJj7qsjRo1bnIWUyEuTFc=;
        b=N6Tqr6wSWd8FMZCnCAAiGNqbhSPzXTDRJPKcJd/PPQneU1c+4NEVu7p4cPg/e7XDjg
         Tts48X2fUHt1jYyiEP1MyznYR1H6WNJbHGYWgzH61TzbDaoMH0qJbo7BzqmfuNVR3J9v
         eZvCaVqLBaUc7l/OnX+H44QgKR6gPYWQ5meJdC0Ktu5su8GRet+exbLg2AyF0dWNWZiR
         VX3GAhIjAZrmQlUs4u8M80lCxp72s241aYIGhlpsteQo+i/qIGKxashWbB+OlaezrNG0
         2qUWsJTQ0Irpk4z7HYqlF2LSbrd2zrfE5Ziw+tZoDIvGDnDzFg/fh/MDHGkeFZ2ECUWP
         PyAw==
X-Gm-Message-State: AO0yUKVzr8Wu4dx7E2AGqMsPx6gdcO1ekpFqp26Y+2tWdL5mVJe0DGHL
        S0iKZLR1p6NrPKBAELJp5vk=
X-Google-Smtp-Source: AK7set+hU57Pu5ZJnmJUCtECcmtn9PlGnGm6KGO32y4b9Q2Rg9v3pJczxX5jmX59fRDABK8zGuDuLQ==
X-Received: by 2002:a17:902:e1c2:b0:198:e4da:f9be with SMTP id t2-20020a170902e1c200b00198e4daf9bemr5080568pla.48.1675851509282;
        Wed, 08 Feb 2023 02:18:29 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b0019926c7757asm3991058plo.289.2023.02.08.02.18.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 02:18:28 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] selftests/nolibc: Adjust indentation for Makefile
Date:   Wed,  8 Feb 2023 18:17:54 +0800
Message-Id: <3fcba51af876acc05af9998ce65ab5fc0cb01116.1675851111.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675851111.git.chenfeiyang@loongson.cn>
References: <cover.1675851111.git.chenfeiyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Reindent only, no functional changes.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/testing/selftests/nolibc/Makefile | 74 ++++++++++++-------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index e9c4a9d011a0..ea2b82a3cd86 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -13,56 +13,56 @@ ARCH = $(SUBARCH)
 endif
 
 # kernel image names by architecture
-IMAGE_i386    = arch/x86/boot/bzImage
-IMAGE_x86_64  = arch/x86/boot/bzImage
-IMAGE_x86     = arch/x86/boot/bzImage
-IMAGE_arm64   = arch/arm64/boot/Image
-IMAGE_arm     = arch/arm/boot/zImage
-IMAGE_mips    = vmlinuz
-IMAGE_riscv   = arch/riscv/boot/Image
-IMAGE_s390    = arch/s390/boot/bzImage
+IMAGE_i386       = arch/x86/boot/bzImage
+IMAGE_x86_64     = arch/x86/boot/bzImage
+IMAGE_x86        = arch/x86/boot/bzImage
+IMAGE_arm64      = arch/arm64/boot/Image
+IMAGE_arm        = arch/arm/boot/zImage
+IMAGE_mips       = vmlinuz
+IMAGE_riscv      = arch/riscv/boot/Image
+IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
-IMAGE         = $(IMAGE_$(ARCH))
-IMAGE_NAME    = $(notdir $(IMAGE))
+IMAGE            = $(IMAGE_$(ARCH))
+IMAGE_NAME       = $(notdir $(IMAGE))
 
 # default kernel configurations that appear to be usable
-DEFCONFIG_i386    = defconfig
-DEFCONFIG_x86_64  = defconfig
-DEFCONFIG_x86     = defconfig
-DEFCONFIG_arm64   = defconfig
-DEFCONFIG_arm     = multi_v7_defconfig
-DEFCONFIG_mips    = malta_defconfig
-DEFCONFIG_riscv   = defconfig
-DEFCONFIG_s390    = defconfig
+DEFCONFIG_i386       = defconfig
+DEFCONFIG_x86_64     = defconfig
+DEFCONFIG_x86        = defconfig
+DEFCONFIG_arm64      = defconfig
+DEFCONFIG_arm        = multi_v7_defconfig
+DEFCONFIG_mips       = malta_defconfig
+DEFCONFIG_riscv      = defconfig
+DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
-DEFCONFIG         = $(DEFCONFIG_$(ARCH))
+DEFCONFIG            = $(DEFCONFIG_$(ARCH))
 
 # optional tests to run (default = all)
 TEST =
 
 # QEMU_ARCH: arch names used by qemu
-QEMU_ARCH_i386    = i386
-QEMU_ARCH_x86_64  = x86_64
-QEMU_ARCH_x86     = x86_64
-QEMU_ARCH_arm64   = aarch64
-QEMU_ARCH_arm     = arm
-QEMU_ARCH_mips    = mipsel  # works with malta_defconfig
-QEMU_ARCH_riscv   = riscv64
-QEMU_ARCH_s390    = s390x
+QEMU_ARCH_i386       = i386
+QEMU_ARCH_x86_64     = x86_64
+QEMU_ARCH_x86        = x86_64
+QEMU_ARCH_arm64      = aarch64
+QEMU_ARCH_arm        = arm
+QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
+QEMU_ARCH_riscv      = riscv64
+QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
-QEMU_ARCH         = $(QEMU_ARCH_$(ARCH))
+QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
-QEMU_ARGS_i386    = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_x86_64  = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_x86     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_arm64   = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_arm     = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_mips    = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_riscv   = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_s390    = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS         = $(QEMU_ARGS_$(ARCH))
+QEMU_ARGS            = $(QEMU_ARGS_$(ARCH))
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
-- 
2.39.0

