Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7E643643
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiLEVAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiLEVAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:00:24 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 918E525C5A;
        Mon,  5 Dec 2022 13:00:23 -0800 (PST)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2946F20B83CB;
        Mon,  5 Dec 2022 13:00:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2946F20B83CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670274023;
        bh=I4E3aVZX0lnhRkF9kXic/1+xlwkA1aElztKCxR5PD6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXG9B1nkLoY2DlfEp+gZKSXyxLn3Y2DxCFurjycAWfMkbEIewW5ckwLoPpWFlSv8g
         0gUjxcAJSWnQgBAeUJKUtXQ5v9L7W34WTu2zIC4S9xykYHxSGt1PuksucJ6SZqf8Uj
         CaS/roRVyj1F6eJUNe8107F3r5E9pSCrsx1fZzSk=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/11] tracing/user_events: Split header into uapi and kernel
Date:   Mon,  5 Dec 2022 13:00:07 -0800
Message-Id: <20221205210017.23440-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205210017.23440-1-beaub@linux.microsoft.com>
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UAPI parts need to be split out from the kernel parts of user_events
now that other parts of the kernel will reference it. Do so by moving
the existing include/linux/user_events.h into
include/uapi/linux/user_events.h.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/linux/user_events.h      | 52 +++++---------------------------
 include/uapi/linux/user_events.h | 48 +++++++++++++++++++++++++++++
 kernel/trace/trace_events_user.c |  5 ---
 3 files changed, 56 insertions(+), 49 deletions(-)
 create mode 100644 include/uapi/linux/user_events.h

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 592a3fbed98e..036b360f3d97 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -1,54 +1,18 @@
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
+#include <uapi/linux/user_events.h>
+
+#ifdef CONFIG_USER_EVENTS
 #else
-#include <sys/uio.h>
 #endif
 
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
index 000000000000..7700759a7cd9
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
+/* Requests to register a user_event */
+#define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg*)
+
+/* Requests to delete a user_event */
+#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)
+
+#endif /* _UAPI_LINUX_USER_EVENTS_H */
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ae78c2d53c8a..890357b48c37 100644
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
2.25.1

