Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1704868FDE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjBIDZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjBIDYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:24:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C68166C9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:24:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so4868464pjy.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 19:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq3h6NGHFAxHZ5DLcg6qPLA20/eRYQpYkN3wnk0IEiI=;
        b=qKKR+nM2DTUL7pQBTtfyKhJ24S9DZe3DNHuR8Ij2bMaR9SuFBiFmkF6S7Hn64PYOz2
         4Ct67ZxnBBtXAXD+aIWgUCDMMZr9Tt8e+b7tCep8lnGPvNOdMlVcBSUTdXI/FSWwV9vm
         RJkuVkQyxsNyvPCh3XN8fhZvWkZ2hGMGl2BP8KMn9j/6hCiWTDUPikgNexGTbQ2CwAj+
         8l4VQP+NhnDPAW8P0RMAdSIRMxctxxfw3EKhlH5rklcijobSfRSDl6xCKQ4tRJx+Sc8K
         2pYNdO+CHXkc5YxF3W6MX2OioIrfRDQbxnVxFA+8STVbQkA65Ou4c1D4zFPW8Dylt5YF
         86XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fq3h6NGHFAxHZ5DLcg6qPLA20/eRYQpYkN3wnk0IEiI=;
        b=obKRKSp0DihSrlFN55xCjSBePZSdsrs/o/zo3I7WglDdM5LyiJ7r+f2NT4fj2NFM+y
         4rOx1CqNGOYA37mU1i7ZhmnsoAF3nOFhWVD5hbB+Kk0tcECQ2Huy0eUeygizZmea/si1
         X63Po/MMpOZFOH+UtagxYev0YqMKrxotQAzWbZcBXqvSgcKgOBnqALz6N0fDbB7WqGim
         K/ahKo8dpH/eq4l0wuMGZHc3qkhBvASOknOVVnBA3X0s2Am85JNbskCnTaxKz+aDFh/R
         odcAw1TvPdQ4NUMcpBcWqws9Lyg+cfFfWYCc9Hd3bEzPKRT7oKNDSkCrWFeyyr9a6PXf
         vJ0w==
X-Gm-Message-State: AO0yUKX+kKg9zALukDrIp0InFolSE0X2dH5nN5aPr1z8hCCEz6IZVzov
        BT/EbI9bTTrKewnR9BUuUSU=
X-Google-Smtp-Source: AK7set/m+uaObsdqOItdbS8+U6+7ncZOtQaKpOmizfo0FxDkFaOYzS+LS5jKPGFYF4eF0G0XG/ITXw==
X-Received: by 2002:a17:902:f20b:b0:199:aae:7569 with SMTP id m11-20020a170902f20b00b001990aae7569mr7344524plc.28.1675913076773;
        Wed, 08 Feb 2023 19:24:36 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b00192820d00d0sm216086pld.120.2023.02.08.19.24.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 19:24:36 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] selftests/nolibc: Add support for LoongArch
Date:   Thu,  9 Feb 2023 11:24:15 +0800
Message-Id: <f3745536049397cfac4cb28afb4d09785e771d52.1675907639.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675907639.git.chenfeiyang@loongson.cn>
References: <cover.1675907639.git.chenfeiyang@loongson.cn>
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

Add support for LoongArch (64 bit) to nolibc selftest.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8fe61d3e3cce..e9c4a9d011a0 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -21,6 +21,7 @@ IMAGE_arm     = arch/arm/boot/zImage
 IMAGE_mips    = vmlinuz
 IMAGE_riscv   = arch/riscv/boot/Image
 IMAGE_s390    = arch/s390/boot/bzImage
+IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE         = $(IMAGE_$(ARCH))
 IMAGE_NAME    = $(notdir $(IMAGE))
 
@@ -33,6 +34,7 @@ DEFCONFIG_arm     = multi_v7_defconfig
 DEFCONFIG_mips    = malta_defconfig
 DEFCONFIG_riscv   = defconfig
 DEFCONFIG_s390    = defconfig
+DEFCONFIG_loongarch  = defconfig
 DEFCONFIG         = $(DEFCONFIG_$(ARCH))
 
 # optional tests to run (default = all)
@@ -47,6 +49,7 @@ QEMU_ARCH_arm     = arm
 QEMU_ARCH_mips    = mipsel  # works with malta_defconfig
 QEMU_ARCH_riscv   = riscv64
 QEMU_ARCH_s390    = s390x
+QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH         = $(QEMU_ARCH_$(ARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
@@ -58,6 +61,7 @@ QEMU_ARGS_arm     = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips    = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv   = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390    = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS         = $(QEMU_ARGS_$(ARCH))
 
 # OUTPUT is only set when run from the main makefile, otherwise
-- 
2.39.0

