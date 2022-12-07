Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084B645B75
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLGNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiLGNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:54:28 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67FA4908F;
        Wed,  7 Dec 2022 05:54:26 -0800 (PST)
X-QQ-mid: bizesmtp74t1670421234t6glizjv
Received: from ubuntu.. ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Dec 2022 21:53:53 +0800 (CST)
X-QQ-SSF: 01200000002000B0B000B00A0000000
X-QQ-FEAT: znfcQSa1hKahN1m9MXihhlD9H25KcTrmlTsiK+jnZWRL9/KxDfCfAcvhFsc/S
        H6xwwcByw5o8tyboieoNR+AmVut1u5dwzH1z7kU8wcl95Mbu8Q5d9o585jd++GMqxXex3jm
        CkZv5G0mO+lxy1HIvqPQgiBjL+Xg/FTbI3XP92dc2IIwtBscteuxqYwu9H8dMfTPR2pi76w
        XdcDgwtn7ldi7QrfHXzB8kvjGfAzHnmjj/vVARdO1lFukykzUI/F+5Z05FMnzMCP0w6VihL
        Ij5qHkPkSvQihQ2PzgtxZMIcnd8yQ+naJaNuU5uA8uQjy5YHwcnRNQRB0Q3PWeJGSSWdsg4
        lZEa5S3bFSh34fllrOvku39hQehmbNfimeWSEpMnQ1n/6Mvmn1T+aPsOt85ag==
X-QQ-GoodBg: 0
From:   Bin Meng <bmeng@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h
Date:   Wed,  7 Dec 2022 21:53:50 +0800
Message-Id: <20221207135352.592556-1-bmeng@tinylab.org>
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

Move smh_putc() variants in respective arch/*/include/asm/semihost.h,
in preparation to add RISC-V support.

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

Changes in v2:
- new patch: "serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h"

 arch/arm/include/asm/semihost.h            | 23 ++++++++++++++++++++
 arch/arm64/include/asm/semihost.h          | 17 +++++++++++++++
 drivers/tty/serial/earlycon-arm-semihost.c | 25 +---------------------
 3 files changed, 41 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/include/asm/semihost.h
 create mode 100644 arch/arm64/include/asm/semihost.h

diff --git a/arch/arm/include/asm/semihost.h b/arch/arm/include/asm/semihost.h
new file mode 100644
index 000000000000..c33cb5124376
--- /dev/null
+++ b/arch/arm/include/asm/semihost.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Adapted for ARM and earlycon:
+ * Copyright (C) 2014 Linaro Ltd.
+ * Author: Rob Herring <robh@kernel.org>
+ */
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define SEMIHOST_SWI	"0xab"
+#else
+#define SEMIHOST_SWI	"0x123456"
+#endif
+
+static inline void smh_putc(struct uart_port *port, unsigned char c)
+{
+	asm volatile("mov  r1, %0\n"
+		     "mov  r0, #3\n"
+		     "svc  " SEMIHOST_SWI "\n"
+		     : : "r" (&c) : "r0", "r1", "memory");
+}
diff --git a/arch/arm64/include/asm/semihost.h b/arch/arm64/include/asm/semihost.h
new file mode 100644
index 000000000000..9e56d38fe5fd
--- /dev/null
+++ b/arch/arm64/include/asm/semihost.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Adapted for ARM and earlycon:
+ * Copyright (C) 2014 Linaro Ltd.
+ * Author: Rob Herring <robh@kernel.org>
+ */
+
+static inline void smh_putc(struct uart_port *port, unsigned char c)
+{
+	asm volatile("mov  x1, %0\n"
+		     "mov  x0, #3\n"
+		     "hlt  0xf000\n"
+		     : : "r" (&c) : "x0", "x1", "memory");
+}
diff --git a/drivers/tty/serial/earlycon-arm-semihost.c b/drivers/tty/serial/earlycon-arm-semihost.c
index fcdec5f42376..e4692a8433f9 100644
--- a/drivers/tty/serial/earlycon-arm-semihost.c
+++ b/drivers/tty/serial/earlycon-arm-semihost.c
@@ -11,30 +11,7 @@
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/serial_core.h>
-
-#ifdef CONFIG_THUMB2_KERNEL
-#define SEMIHOST_SWI	"0xab"
-#else
-#define SEMIHOST_SWI	"0x123456"
-#endif
-
-/*
- * Semihosting-based debug console
- */
-static void smh_putc(struct uart_port *port, unsigned char c)
-{
-#ifdef CONFIG_ARM64
-	asm volatile("mov  x1, %0\n"
-		     "mov  x0, #3\n"
-		     "hlt  0xf000\n"
-		     : : "r" (&c) : "x0", "x1", "memory");
-#else
-	asm volatile("mov  r1, %0\n"
-		     "mov  r0, #3\n"
-		     "svc  " SEMIHOST_SWI "\n"
-		     : : "r" (&c) : "r0", "r1", "memory");
-#endif
-}
+#include <asm/semihost.h>
 
 static void smh_write(struct console *con, const char *s, unsigned n)
 {
-- 
2.34.1

