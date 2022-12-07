Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7F645B71
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLGNyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGNyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:54:17 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A51E4AF07;
        Wed,  7 Dec 2022 05:54:14 -0800 (PST)
X-QQ-mid: bizesmtp74t1670421238tac3l1oe
Received: from ubuntu.. ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Dec 2022 21:53:57 +0800 (CST)
X-QQ-SSF: 01200000002000B0B000B00A0000000
X-QQ-FEAT: xwvWJGGFd7MwyO0I/Q6cO3SN87cXTA0Qqfh8HCCQSS6fqMBr/qkBzS+Hb4sLp
        RIF6DZbbbporXK5SG5F4L4GnHn3cPJgPb5h4J9lKGr5wkCAxIZIeU5807depEIkwOLe/Mvy
        w0fF2c1Xl1ux4LFQLywy9e9/clKPMiR6ZcYxicJ41cKAl3Xv6ZkiqQ6IruvUZk/stFlQJH8
        iJdiwmmZOrFZdI9SL+AxAuRudDrkCSZ1BMsWKQjKaEPDbO972J8msrOerMwffpes+NXzixA
        M0hzvtwl06PkTeG8l2CIIQ8YzQIf4d5qZW2xX3RNckdIF9+X7lJdOdEAGAlDSChORGQtg0r
        FGahlUmropJkxzJ1wNuBcRJWrhJuK4yhfdO3fVCeNsWeoQ6Ohn9G58xYSpL8A==
X-QQ-GoodBg: 0
From:   Bin Meng <bmeng@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 2/3] riscv: Implement semihost.h for earlycon semihost driver
Date:   Wed,  7 Dec 2022 21:53:51 +0800
Message-Id: <20221207135352.592556-2-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207135352.592556-1-bmeng@tinylab.org>
References: <20221207135352.592556-1-bmeng@tinylab.org>
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

Per RISC-V semihosting spec [1], implement semihost.h for the existing
Arm semihosting earlycon driver to work on RISC-V.

[1] https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

Changes in v2:
- Move the RISC-V implementation to semihost.h

 arch/riscv/include/asm/semihost.h | 19 +++++++++++++++++++
 drivers/tty/serial/Kconfig        |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/semihost.h

diff --git a/arch/riscv/include/asm/semihost.h b/arch/riscv/include/asm/semihost.h
new file mode 100644
index 000000000000..886f21d7a476
--- /dev/null
+++ b/arch/riscv/include/asm/semihost.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 tinylab.org
+ * Author: Bin Meng <bmeng@tinylab.org>
+ */
+
+static inline void smh_putc(struct uart_port *port, unsigned char c)
+{
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
+}
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
-- 
2.34.1

