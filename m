Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0535F64226C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiLEFBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiLEFBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:01:06 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11735F007;
        Sun,  4 Dec 2022 21:01:01 -0800 (PST)
X-QQ-mid: bizesmtp83t1670216440tdylbiir
Received: from ubuntu.. ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Dec 2022 13:00:39 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: PsQCk6chbj5eK9ByDZQ9MzbRQ+lBTauZ/hMtMvyxFIKaWgsW4FUHY+4JhPLWp
        N8cebpF9TczECdys04OEy9HJn9oZa3VLtz3WoQfuUwnGABxRVV92ZnKGLKSiUNXJ5vOly2i
        EmIlXEJEYBtM4ApVe9usMvY0zPi/qFYgvjmCUU+0nd4O1v/vE9Ch275x3rBjfwiHDf3A2T1
        ALae+DDCvEXhohsbyENwZm6hzz3JChV1omL5zQ9O6OghO903vD0KT3kQqoUEiDhoenU0Bhw
        fitqzjEco1KqPtDZACKdNQMZ2GeNH3iCax7PxJS9Eqz/Xv5K1uxwzC+K3OLB1vn9HYngpfU
        +ZkRbjl7WKf7o7fqqO6e0i0kHY+jg==
X-QQ-GoodBg: 0
From:   Bin Meng <bmeng@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 1/2] serial: Adapt Arm semihosting earlycon driver to RISC-V
Date:   Mon,  5 Dec 2022 13:00:37 +0800
Message-Id: <20221205050038.195746-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per RISC-V semihosting spec [1], adapt the existing Arm semihosting
earlycon driver to RISC-V.

[1] https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/tty/serial/Kconfig                 |  2 +-
 drivers/tty/serial/earlycon-arm-semihost.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 434f83168546..e94d1265151c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -75,7 +75,7 @@ config SERIAL_AMBA_PL011_CONSOLE
 
 config SERIAL_EARLYCON_ARM_SEMIHOST
 	bool "Early console using ARM semihosting"
-	depends on ARM64 || ARM
+	depends on ARM64 || ARM || RISCV
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
diff --git a/drivers/tty/serial/earlycon-arm-semihost.c b/drivers/tty/serial/earlycon-arm-semihost.c
index fcdec5f42376..25a0f91926a3 100644
--- a/drivers/tty/serial/earlycon-arm-semihost.c
+++ b/drivers/tty/serial/earlycon-arm-semihost.c
@@ -6,6 +6,10 @@
  * Adapted for ARM and earlycon:
  * Copyright (C) 2014 Linaro Ltd.
  * Author: Rob Herring <robh@kernel.org>
+ *
+ * Adapted for RISC-V and earlycon:
+ * Copyright (C) 2022 tinylab.org
+ * Author: Bin Meng <bmeng@tinylab.org>
  */
 #include <linux/kernel.h>
 #include <linux/console.h>
@@ -23,7 +27,18 @@
  */
 static void smh_putc(struct uart_port *port, unsigned char c)
 {
-#ifdef CONFIG_ARM64
+#if defined(CONFIG_RISCV)
+	asm volatile("addi    a1, %0, 0\n"
+		     "addi    a0, zero, 3\n"
+		     ".balign 16\n"
+		     ".option push\n"
+		     ".option norvc\n"
+		     "slli    zero, zero, 0x1f\n"
+		     "ebreak\n"
+		     "srai    zero, zero, 0x7\n"
+		     ".option pop\n"
+		     : : "r" (&c) : "a0", "a1", "memory");
+#elif defined(CONFIG_ARM64)
 	asm volatile("mov  x1, %0\n"
 		     "mov  x0, #3\n"
 		     "hlt  0xf000\n"
-- 
2.34.1

