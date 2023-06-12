Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1E672D110
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbjFLUuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbjFLUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A565119AB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2DD062F1C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAF5C4332E;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=aVqOtwmx537eWDCmSDJwrEESzYvq7/Do2SB85XSCprw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0m4+Gw20RtEfRWkpnsxaIZ4QVmx9svEupWtYqPIuH09CgLPYnTyS/dws3buXQOMf
         qEltOAQJeHpPfJtHSFVVY92O6BQ0WmyvZlr6Ln77x7o1ISW7nicsJMpGQ2EikcMqET
         niDWnICFABYmCvpc+VZgMZUj2ZJd+x5O+nlm07CKOz3gNdQHQywzKKfpAJTyNTQTfW
         mdhJJ9BwrntgNTnBkeB6q0Ed+YZetfLyFU+v1T7IoFKwpE+s84MzsDZROlVW/p1VpQ
         U586gEuzIL1b/3ijOLbItcXr2OyU00ja5ZhzUxqdcW4FlSIIb72oZl1RUXIlVGeWDF
         e8bOvRMsEG7CQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1706ECE3A8A; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 43/53] selftests/nolibc: allow specify extra arguments for qemu
Date:   Mon, 12 Jun 2023 13:45:04 -0700
Message-Id: <20230612204514.292087-43-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

The opensbi package from Ubuntu 20.04 only provides rv64 firmwares:

    $ dpkg -S opensbi | grep -E "fw_.*bin|fw_.*elf" | uniq
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_dynamic.bin
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.bin
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_dynamic.elf
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf

To run this nolibc test for rv32, users must build opensbi or download a
prebuilt one from qemu repository:

    https://gitlab.com/qemu-project/qemu/-/blob/master/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin

And then use -bios to tell qemu use it to avoid such failure:

    $ qemu-system-riscv32 -display none -no-reboot -kernel /path/to/arch/riscv/boot/Image -serial stdio -M virt -append "console=ttyS0 panic=-1"
    qemu-system-riscv32: Unable to load the RISC-V firmware "opensbi-riscv32-generic-fw_dynamic.bin"

To run from makefile, QEMU_ARGS_EXTRA is added to allow pass extra
arguments like -bios:

    $ make run QEMU_ARGS_EXTRA="-bios /path/to/opensbi-riscv32-generic-fw_dynamic.bin" ...

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/2ab94136-d341-4a26-964e-6d6c32e66c9b@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 47c3c89092e4..44088535682e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -64,7 +64,7 @@ QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(ARCH))
+QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
-- 
2.40.1

