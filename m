Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AFD6AAA70
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCDOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCDOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:30:41 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 758461F5F1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:30:11 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324ETwx7006729;
        Sat, 4 Mar 2023 15:29:58 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     chenhuacai@loongson.cn, chenfeiyang@loongson.cn,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/3] selftests/nolibc: Add support for LoongArch
Date:   Sat,  4 Mar 2023 15:29:54 +0100
Message-Id: <20230304142955.6682-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230304142955.6682-1-w@1wt.eu>
References: <20230304142955.6682-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Add support for LoongArch (64 bit) to nolibc selftest.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Willy Tarreau <w@1wt.eu>
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
2.17.5

