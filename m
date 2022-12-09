Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B605648497
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLIPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiLIPFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:05:12 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5A719C23;
        Fri,  9 Dec 2022 07:05:06 -0800 (PST)
X-QQ-mid: bizesmtp89t1670598285td8rum5u
Received: from ubuntu.. ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Dec 2022 23:04:44 +0800 (CST)
X-QQ-SSF: 01200000002000B0C000B00A0000000
X-QQ-FEAT: eSZ1CZgv+JDxI3bkYMKbTdjkw3HK7jXPhTCSg7Rm3gGAzVEQh3qZVDk772x62
        RcnlQ3TCDQBKpL4HEXYtAYBq+s10VpGHenajCYPlmnRYkDW1cCyvU28bP3dGoFJzt/NnAAi
        9pbziDhkypc8rcrRB2SXSoQ9okkCAjY0JDno58pfyZqblYWybP98pprywYy6WnA30twSSkk
        HtUjsUs0pEf3XziNrqPZPNwjWhRxgNggsCplY7mQcxnOAKQawZmsOycyzYMOeAirqYRIVT6
        f0vj/eey25M+7iykhR5ifMsDFZiAAyU+ULt91TPKJ7Y3MhD+QWQEG0xfqPE7M5sWLXpuFjU
        BkP38Blu5oPle1WhiJqDtKkDcUCCyCD7fzWHdV0BNU0Wonfe/4=
X-QQ-GoodBg: 0
From:   Bin Meng <bmeng@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v3 2/3] riscv: Implement semihost.h for earlycon semihost driver
Date:   Fri,  9 Dec 2022 23:04:36 +0800
Message-Id: <20221209150437.795918-3-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209150437.795918-1-bmeng@tinylab.org>
References: <20221209150437.795918-1-bmeng@tinylab.org>
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

Link: https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc [1]

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

Changes in v3:
- add #ifdef in the header to prevent from multiple inclusion
- add forward-declare struct uart_port
- add a Link tag in the commit message

Changes in v2:
- Move the RISC-V implementation to semihost.h

 arch/riscv/include/asm/semihost.h | 26 ++++++++++++++++++++++++++
 drivers/tty/serial/Kconfig        |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/semihost.h

diff --git a/arch/riscv/include/asm/semihost.h b/arch/riscv/include/asm/semihost.h
new file mode 100644
index 000000000000..557a34938193
--- /dev/null
+++ b/arch/riscv/include/asm/semihost.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 tinylab.org
+ * Author: Bin Meng <bmeng@tinylab.org>
+ */
+
+#ifndef _RISCV_SEMIHOST_H_
+#define _RISCV_SEMIHOST_H_
+
+struct uart_port;
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
+
+#endif /* _RISCV_SEMIHOST_H_ */
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

