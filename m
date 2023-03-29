Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F177A6CF37D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjC2TqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjC2Tpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E7F196
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A398A61E26
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F65AC433AF;
        Wed, 29 Mar 2023 19:45:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjz-002Rks-23;
        Wed, 29 Mar 2023 15:45:51 -0400
Message-ID: <20230329194551.451527297@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 12/25] tracing/user_events: Split header into uapi and kernel
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

The UAPI parts need to be split out from the kernel parts of user_events
now that other parts of the kernel will reference it. Do so by moving
the existing include/linux/user_events.h into
include/uapi/linux/user_events.h.

Link: https://lkml.kernel.org/r/20230328235219.203-2-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/user_events.h      | 52 ++++----------------------------
 include/uapi/linux/user_events.h | 48 +++++++++++++++++++++++++++++
 kernel/trace/trace_events_user.c |  5 ---
 3 files changed, 54 insertions(+), 51 deletions(-)
 create mode 100644 include/uapi/linux/user_events.h

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 592a3fbed98e..13689589d36e 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -1,54 +1,14 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2021, Microsoft Corporation.
+ * Copyright (c) 2022, Microsoft Corporation.
  *
  * Authors:
  *   Beau Belgrave <beaub@linux.microsoft.com>
  */
-#ifndef _UAPI_LINUX_USER_EVENTS_H
-#define _UAPI_LINUX_USER_EVENTS_H
 
-#include <linux/types.h>
-#include <linux/ioctl.h>
+#ifndef _LINUX_USER_EVENTS_H
+#define _LINUX_USER_EVENTS_H
 
-#ifdef __KERNEL__
-#include <linux/uio.h>
-#else
-#include <sys/uio.h>
-#endif
+#include <uapi/linux/user_events.h>
 
-#define USER_EVENTS_SYSTEM "user_events"
-#define USER_EVENTS_PREFIX "u:"
-
-/* Create dynamic location entry within a 32-bit value */
-#define DYN_LOC(offset, size) ((size) << 16 | (offset))
-
-/*
- * Describes an event registration and stores the results of the registration.
- * This structure is passed to the DIAG_IOCSREG ioctl, callers at a minimum
- * must set the size and name_args before invocation.
- */
-struct user_reg {
-
-	/* Input: Size of the user_reg structure being used */
-	__u32 size;
-
-	/* Input: Pointer to string with event name, description and flags */
-	__u64 name_args;
-
-	/* Output: Bitwise index of the event within the status page */
-	__u32 status_bit;
-
-	/* Output: Index of the event to use when writing data */
-	__u32 write_index;
-} __attribute__((__packed__));
-
-#define DIAG_IOC_MAGIC '*'
-
-/* Requests to register a user_event */
-#define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg*)
-
-/* Requests to delete a user_event */
-#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)
-
-#endif /* _UAPI_LINUX_USER_EVENTS_H */
+#endif /* _LINUX_USER_EVENTS_H */
diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
new file mode 100644
index 000000000000..03f92366068d
--- /dev/null
+++ b/include/uapi/linux/user_events.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2021-2022, Microsoft Corporation.
+ *
+ * Authors:
+ *   Beau Belgrave <beaub@linux.microsoft.com>
+ */
+#ifndef _UAPI_LINUX_USER_EVENTS_H
+#define _UAPI_LINUX_USER_EVENTS_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define USER_EVENTS_SYSTEM "user_events"
+#define USER_EVENTS_PREFIX "u:"
+
+/* Create dynamic location entry within a 32-bit value */
+#define DYN_LOC(offset, size) ((size) << 16 | (offset))
+
+/*
+ * Describes an event registration and stores the results of the registration.
+ * This structure is passed to the DIAG_IOCSREG ioctl, callers at a minimum
+ * must set the size and name_args before invocation.
+ */
+struct user_reg {
+
+	/* Input: Size of the user_reg structure being used */
+	__u32 size;
+
+	/* Input: Pointer to string with event name, description and flags */
+	__u64 name_args;
+
+	/* Output: Bitwise index of the event within the status page */
+	__u32 status_bit;
+
+	/* Output: Index of the event to use when writing data */
+	__u32 write_index;
+} __attribute__((__packed__));
+
+#define DIAG_IOC_MAGIC '*'
+
+/* Request to register a user_event */
+#define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg *)
+
+/* Request to delete a user_event */
+#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char *)
+
+#endif /* _UAPI_LINUX_USER_EVENTS_H */
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 908e8a13c675..070551480747 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -19,12 +19,7 @@
 #include <linux/tracefs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
-/* Reminder to move to uapi when everything works */
-#ifdef CONFIG_COMPILE_TEST
 #include <linux/user_events.h>
-#else
-#include <uapi/linux/user_events.h>
-#endif
 #include "trace.h"
 #include "trace_dynevent.h"
 
-- 
2.39.1
