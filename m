Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F668ECAF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBHKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjBHKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:18:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5AB25294
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:18:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d2so14264697pjd.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq3h6NGHFAxHZ5DLcg6qPLA20/eRYQpYkN3wnk0IEiI=;
        b=aI8k4UFkjpEuClZ/YCcgimxe4z73Kt9OcHFahkgUnhnMecQ9PNdRGPS2gYQ6MHm+po
         Bq2plDHND7AlLt3dfoyXb5RJdn4Zz1Z+B4wTnhE7xRRp921JaeXpek5VoDxOTDIFswpm
         P3hsPa6R4dVHAbICYJkwAuFwf3p0swhdlHIfo98uS/nH/G1JcZTMTC9CUCk2OcpDpLC0
         0AyS6tCqLHsYC37tn/pT3M8R7KvhVZuJsLOJGlF45wK5eXC6aNvbJo4R5O3o0PzascYP
         5LUY4F0FdRCzDnnWCJMhVtAn3rYbBKcQGUFK8wFgDlVnhv8+rYJ4gWSFMQ88pBZnNfyU
         SYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fq3h6NGHFAxHZ5DLcg6qPLA20/eRYQpYkN3wnk0IEiI=;
        b=pv/X/vfgnNrdKtrlnlAzIeCoHRbGS8jS0I40C4mm/HumllBgC0Cf0ExLtptlVJKH4d
         yPRkgLrG9hAJgnychvDzPWNmEuXLy1IGRrIADIZKuDIg8VEoh0olAgkevAoXSv7rghHG
         f5dU71GSKAgnQBhsGTIwhCa6j2NEEQQmDu8zVT5ayVE6gignoga1M8kTHDTxxU0tzS5N
         9ijJ13j0DZE/Jxec/Uz8PMBeGLPbRe0PKL33qlDIMDaI+6nKEfQ/gaqwMIgJUk8gdUtC
         rp17zRdBVecJ5u4NrpkT+ocLJneXK20YFYKsVurMzv0rQ7/az+1scgcaj33AqxNIbQdV
         LpjA==
X-Gm-Message-State: AO0yUKXCt+7r822AlCkn5t4s0uGHkq9tCnxULyfOd1h5wjUCf+U5YLll
        CVkGsbxrH9az2B20L33BWRY=
X-Google-Smtp-Source: AK7set/FfeYbxbkOAj+M5ndUKEczPf+wcyYb9OC9Vx/qSjjYchGNqTfzPraz2U4R3e1to9J6qd5CRg==
X-Received: by 2002:a17:902:e285:b0:199:109e:829 with SMTP id o5-20020a170902e28500b00199109e0829mr5454679plc.30.1675851504549;
        Wed, 08 Feb 2023 02:18:24 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b0019926c7757asm3991058plo.289.2023.02.08.02.18.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 02:18:24 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] selftests/nolibc: Add support for LoongArch
Date:   Wed,  8 Feb 2023 18:17:53 +0800
Message-Id: <d3fd493792cd7fa432843691d86221f5ad2ef32c.1675851111.git.chenfeiyang@loongson.cn>
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

