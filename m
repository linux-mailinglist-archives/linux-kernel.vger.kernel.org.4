Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72D564226D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiLEFBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEFBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:01:06 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42425FADF;
        Sun,  4 Dec 2022 21:01:02 -0800 (PST)
X-QQ-mid: bizesmtp83t1670216444t8l5fgul
Received: from ubuntu.. ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Dec 2022 13:00:43 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: TOO/YuwAHLNsU0I0UDkDXj1aiAPrDdXJhTuoCy6bPBDajHhPYPR1SwPcUNi48
        hVXep8OiNbPn4Zn65lGbchtJpLbNMBKVt+/em4uIyB4L7sQbYMUfE7CUn9mcORqFxtY4yH9
        Pdbu0xJVtlJUDBlhdjVnsgQsMXlw6aMZZj1nWdAAAAnlbCPOdPdxuuxBjKq2nPbfgaUEKVn
        tcSwlg8PCcS2y8pxeMIUpy1LDDgFbvdVRvHxvRmOeL6kirMgkgPgMpgTarbL89YrIGQ6i4t
        FUPHHXnk6/lhDKO7bpsacw+R8P71ag10HUVeqA9MiwnXaO2TnX1DErGFITGucKpnQpyEYBs
        fV2OBqVArNAc34+qgyT4i0jG4Vsytk4Fx/QW+JhUcOCur0iq+w=
X-QQ-GoodBg: 0
From:   Bin Meng <bmeng@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 2/2] serial: Rename earlycon semihost driver
Date:   Mon,  5 Dec 2022 13:00:38 +0800
Message-Id: <20221205050038.195746-2-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205050038.195746-1-bmeng@tinylab.org>
References: <20221205050038.195746-1-bmeng@tinylab.org>
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

