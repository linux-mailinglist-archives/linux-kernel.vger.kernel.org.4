Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211206C272C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCUBPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCUBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:15:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81419743
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60679B811C5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9323C433AE;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=XbcHM5o/5dF7rnFY9neqUQfFJg26hV1YxFH7UsKvUsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRxvUzUr3JN0DcNA/rF1jnadkMVsngxlcoGo47G/nq842oFpK6kI5zX+6tvSNpiyo
         KpSu7KBZ2BYtXVma3nRs54gZ0dBTqPMrLoHgJ092/SFvl/uLNzwRE9IkL4fKLDzVbY
         KbdCg+diQOWuAA7mQZJVUJSTfkf25IaQ5V2fZdB/HgZDRgehP6gVvNFUmgp5+gKDjF
         JiRN6UMyzfzxukyu8ru+Qq3VmkdUkwSq2dNkP/u69EM/0GGchMZM0Mi7Wz7vjAUqVt
         zla29/K7bEniIVy2RVMnzuZU8QvCT6b1vZWO8IxHgXDXYXTR23uPtDJ4e3DjFMwPGD
         q8ObVQzEjUltA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 09B7B15403A5; Mon, 20 Mar 2023 18:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 13/14] selftests/nolibc: Add support for LoongArch
Date:   Mon, 20 Mar 2023 18:11:36 -0700
Message-Id: <20230321011137.51837-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 874d141da8c4..7992287ebbbd 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -23,6 +23,7 @@ IMAGE_arm     = arch/arm/boot/zImage
 IMAGE_mips    = vmlinuz
 IMAGE_riscv   = arch/riscv/boot/Image
 IMAGE_s390    = arch/s390/boot/bzImage
+IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE         = $(IMAGE_$(ARCH))
 IMAGE_NAME    = $(notdir $(IMAGE))
 
@@ -35,6 +36,7 @@ DEFCONFIG_arm     = multi_v7_defconfig
 DEFCONFIG_mips    = malta_defconfig
 DEFCONFIG_riscv   = defconfig
 DEFCONFIG_s390    = defconfig
+DEFCONFIG_loongarch  = defconfig
 DEFCONFIG         = $(DEFCONFIG_$(ARCH))
 
 # optional tests to run (default = all)
@@ -49,6 +51,7 @@ QEMU_ARCH_arm     = arm
 QEMU_ARCH_mips    = mipsel  # works with malta_defconfig
 QEMU_ARCH_riscv   = riscv64
 QEMU_ARCH_s390    = s390x
+QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH         = $(QEMU_ARCH_$(ARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
@@ -60,6 +63,7 @@ QEMU_ARGS_arm     = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips    = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv   = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390    = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS         = $(QEMU_ARGS_$(ARCH))
 
 # OUTPUT is only set when run from the main makefile, otherwise
-- 
2.40.0.rc2

