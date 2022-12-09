Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08F1648499
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiLIPFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLIPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:05:14 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596A209B1;
        Fri,  9 Dec 2022 07:05:12 -0800 (PST)
X-QQ-mid: bizesmtp89t1670598283t2j1lelf
Received: from ubuntu.. ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Dec 2022 23:04:41 +0800 (CST)
X-QQ-SSF: 01200000002000B0C000B00A0000000
X-QQ-FEAT: znfcQSa1hKZEkVEo5KsJPnztRM+YmWhuMP5lhz0A261j6bY6bsUz696ZFniYc
        IU03XC1wSi2mTpJ4Oj7Nff0Mv/eMawGUQSZLZVoQMPCrpyyWZ45AOCUMkImiFB7XXhf4GPo
        a4C1mosVhQKwwMj2rbWMSAz4HZoPpkuO2pn1BK3GOMlRTHgOhhbziFZ3fgK1f8z25438B/v
        NhmUnGbLWn6VF9J+Oa6QZvy/nu/rKuzaAkhseY4+t0ypw7NT/Yqhovc9tG3jynzpXmE6+6g
        NG4Qoz10dv3AG5/zN4SQRBb1AmUEmB+TLgvJnFXYCmlwI3Dghgs3w87u62UiIMuchUdvmWt
        FOONZXRgMzi5ce4r0xcY4MuIdqC031oicLhrpoGk00mYjUHVWk=
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
Subject: [PATCH v3 1/3] serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h
Date:   Fri,  9 Dec 2022 23:04:35 +0800
Message-Id: <20221209150437.795918-2-bmeng@tinylab.org>
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

Move smh_putc() variants in respective arch/*/include/asm/semihost.h,
in preparation to add RISC-V support.

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

Changes in v3:
- add #ifdef in the header to prevent from multiple inclusion
- add forward-declare struct uart_port

Changes in v2:
- new patch: "serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h"

 arch/arm/include/asm/semihost.h            | 30 ++++++++++++++++++++++
 arch/arm64/include/asm/semihost.h          | 24 +++++++++++++++++
 drivers/tty/serial/earlycon-arm-semihost.c | 25 +-----------------
 3 files changed, 55 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/include/asm/semihost.h
 create mode 100644 arch/arm64/include/asm/semihost.h

diff --git a/arch/arm/include/asm/semihost.h b/arch/arm/include/asm/semihost.h
new file mode 100644
index 000000000000..f365787e7c23
--- /dev/null
+++ b/arch/arm/include/asm/semihost.h
@@ -0,0 +1,30 @@
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
+#ifndef _ARM_SEMIHOST_H_
+#define _ARM_SEMIHOST_H_
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define SEMIHOST_SWI	"0xab"
+#else
+#define SEMIHOST_SWI	"0x123456"
+#endif
+
+struct uart_port;
+
+static inline void smh_putc(struct uart_port *port, unsigned char c)
+{
+	asm volatile("mov  r1, %0\n"
+		     "mov  r0, #3\n"
+		     "svc  " SEMIHOST_SWI "\n"
+		     : : "r" (&c) : "r0", "r1", "memory");
+}
+
+#endif /* _ARM_SEMIHOST_H_ */
diff --git a/arch/arm64/include/asm/semihost.h b/arch/arm64/include/asm/semihost.h
new file mode 100644
index 000000000000..87e353dab868
--- /dev/null
+++ b/arch/arm64/include/asm/semihost.h
@@ -0,0 +1,24 @@
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
+#ifndef _ARM64_SEMIHOST_H_
+#define _ARM64_SEMIHOST_H_
+
+struct uart_port;
+
+static inline void smh_putc(struct uart_port *port, unsigned char c)
+{
+	asm volatile("mov  x1, %0\n"
+		     "mov  x0, #3\n"
+		     "hlt  0xf000\n"
+		     : : "r" (&c) : "x0", "x1", "memory");
+}
+
+#endif /* _ARM64_SEMIHOST_H_ */
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

