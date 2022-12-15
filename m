Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656C964D5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 05:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLOEbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 23:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOEbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 23:31:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99929303FE;
        Wed, 14 Dec 2022 20:31:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D621661C54;
        Thu, 15 Dec 2022 04:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181D0C433EF;
        Thu, 15 Dec 2022 04:31:07 +0000 (UTC)
Date:   Wed, 14 Dec 2022 23:31:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring
 buffer
Message-ID: <20221214233106.69b2c01b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

While debugging some firmware that was taking a bit of time to initialize,
I enabled ACPI_DEBUG and added a bit too much info to the debug_layer and
debug_level acpi command line options, and it made the computer not be
able to boot (too much info! or too much printk).

I decided that this would be easier to handle if the acpi output was
written instead into the trace buffer. This also has the added benefit of
adding other trace events and seeing how ACPI interacts with the rest of
the system.

Ideally, the ACPI trace should have proper trace events where data can be
stored more efficiently and be filtered and parsed better. But for now,
just writing the debug string into the buffer will suffice.  This makes it
possible to enable all ACPI output (setting triggers on other events to
stop tracing, to not lose the data you are looking for).

Even with all APCI debugging enable, the system continues to run perfectly
fine.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

 drivers/acpi/Kconfig        | 13 +++++++++++++
 drivers/acpi/osl.c          |  9 ++++++++-
 include/trace/events/acpi.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/acpi.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 473241b5193f..2dfeb3bf79a7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -389,6 +389,19 @@ config ACPI_DEBUG
 	  Documentation/admin-guide/kernel-parameters.rst to control the type and
 	  amount of debug output.
 
+config ACPI_TRACE_PRINT
+	bool "Write debug into trace buffer"
+	depends on ACPI_DEBUG
+	help
+	  Instead of writing to the console, write to the trace ring buffer.
+	  This is much faster than writing to the console, and can handle
+	  all events.
+
+	  Use the acpi.debug_layer and acpi.debug_level kernel command-line
+	  parameters documented in Documentation/firmware-guide/acpi/debug.rst and
+	  Documentation/admin-guide/kernel-parameters.rst to control the type and
+	  amount of debug output.
+
 config ACPI_PCI_SLOT
 	bool "PCI slot detection driver"
 	depends on SYSFS && PCI
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..eeed5fd782ab 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -35,6 +35,9 @@
 #include <linux/uaccess.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/acpi.h>
+
 #include "acpica/accommon.h"
 #include "internal.h"
 
@@ -158,6 +161,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 #ifdef ENABLE_DEBUGGER
 	if (acpi_in_debugger) {
 		kdb_printf("%s", buffer);
+	} else if (IS_ENABLED(CONFIG_ACPI_TRACE_PRINT)) {
+		trace_acpi_print(buffer);
 	} else {
 		if (printk_get_level(buffer))
 			printk("%s", buffer);
@@ -165,7 +170,9 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 			printk(KERN_CONT "%s", buffer);
 	}
 #else
-	if (acpi_debugger_write_log(buffer) < 0) {
+	if (IS_ENABLED(CONFIG_ACPI_TRACE_PRINT)) {
+		trace_acpi_print(buffer);
+	} else if (acpi_debugger_write_log(buffer) < 0) {
 		if (printk_get_level(buffer))
 			printk("%s", buffer);
 		else
diff --git a/include/trace/events/acpi.h b/include/trace/events/acpi.h
new file mode 100644
index 000000000000..dab4dd42b5d7
--- /dev/null
+++ b/include/trace/events/acpi.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM acpi
+
+#if !defined(_TRACE_ACPI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ACPI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(acpi_print,
+
+	TP_PROTO(const char *buffer),
+
+	TP_ARGS(buffer),
+
+	TP_STRUCT__entry(
+		__string(buffer, buffer)
+	),
+
+	TP_fast_assign(
+		__assign_str(buffer, buffer);
+	),
+
+	TP_printk("%s", __get_str(buffer))
+);
+
+#endif /* _TRACE_SOCK_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.35.1

