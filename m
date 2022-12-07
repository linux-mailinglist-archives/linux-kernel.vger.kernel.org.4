Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9927B645B73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLGNy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLGNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:54:21 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6074048774;
        Wed,  7 Dec 2022 05:54:19 -0800 (PST)
X-QQ-mid: bizesmtp74t1670421240tpugafm0
Received: from ubuntu.. ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Dec 2022 21:53:59 +0800 (CST)
X-QQ-SSF: 01200000002000B0B000B00A0000000
X-QQ-FEAT: WfQrrMZtGtFaBhCIjFkwlouFogiRdBICx5npfjqOayIRbX/Flh8LzJ93MYCFh
        36X35vAPGzUK6kjShIP7otSDF0ZW6nd1bkmmFzHHzjDrZYl2OsqoTk0Zz7hFXdq3Dw19JIB
        kKjISittyAUaHDPTnXlZtLYNZgmDRE6fon+hkNT/Lp8E/T09fUcoErU3Js7KONhTPwYzOWQ
        ai7k+ZIRsSQgaurOY1zU3WIdrNIbh2qgEigV/9325z9PywKyNrTwOmUq+E80jl/rpsoEzwo
        nfnv+NSCaYIX8vdLu8G7yMR/sMKJb7f9Ka/F5NyWt9vgcsc1uaHibUBnFqzNQr8yob5P7FB
        30Z9Ilrkk8MZVXrBeZCLIGbhzumN94YTX34evrXQ6lxCwHpwnM=
X-QQ-GoodBg: 0
From:   Bin Meng <bmeng@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 3/3] serial: Rename earlycon semihost driver
Date:   Wed,  7 Dec 2022 21:53:52 +0800
Message-Id: <20221207135352.592556-3-bmeng@tinylab.org>
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

Now that earlycon semihost driver works on RISC-V too, let's use a
much more generic name for the driver.

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

(no changes since v1)

 drivers/tty/serial/Kconfig                           | 12 ++++++------
 drivers/tty/serial/Makefile                          |  2 +-
 .../{earlycon-arm-semihost.c => earlycon-semihost.c} |  0
 3 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/tty/serial/{earlycon-arm-semihost.c => earlycon-semihost.c} (100%)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e94d1265151c..a3779472edf6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -73,17 +73,17 @@ config SERIAL_AMBA_PL011_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
-config SERIAL_EARLYCON_ARM_SEMIHOST
-	bool "Early console using ARM semihosting"
+config SERIAL_EARLYCON_SEMIHOST
+	bool "Early console using Arm compatible semihosting"
 	depends on ARM64 || ARM || RISCV
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-	  Support for early debug console using ARM semihosting. This enables
-	  the console before standard serial driver is probed. This is enabled
-	  with "earlycon=smh" on the kernel command line. The console is
-	  enabled when early_param is processed.
+	  Support for early debug console using Arm compatible semihosting.
+	  This enables the console before standard serial driver is probed.
+	  This is enabled with "earlycon=smh" on the kernel command line.
+	  The console is enabled when early_param is processed.
 
 config SERIAL_EARLYCON_RISCV_SBI
 	bool "Early console using RISC-V SBI"
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 238a9557b487..cd9afd9e3018 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
-obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
+obj-$(CONFIG_SERIAL_EARLYCON_SEMIHOST) += earlycon-semihost.o
 obj-$(CONFIG_SERIAL_EARLYCON_RISCV_SBI) += earlycon-riscv-sbi.o
 
 # These Sparc drivers have to appear before others such as 8250
diff --git a/drivers/tty/serial/earlycon-arm-semihost.c b/drivers/tty/serial/earlycon-semihost.c
similarity index 100%
rename from drivers/tty/serial/earlycon-arm-semihost.c
rename to drivers/tty/serial/earlycon-semihost.c
-- 
2.34.1

