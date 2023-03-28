Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2CA6CCE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjC1Xwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjC1Xw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:52:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC1482D44;
        Tue, 28 Mar 2023 16:52:25 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id BFB5920FDAA3;
        Tue, 28 Mar 2023 16:52:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFB5920FDAA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680047545;
        bh=OSmDP26J8YzoMhJc3UKK7slznwSGVE3KNwggNF1IdJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6twUb0ke7eK5ynz9/PeHHdyqh6KQ95zr0iOHhkyuxOiVKml3Xc5Fptvp8sR+DX9z
         HbY+oR9AqNC+ixwArDWbmpgy9CbMHTMw45k8BgakrhTAN7tbRtHxDCy1121cQ7VOB9
         6piQBcmQptm2Bl1DBPVjQQwn+jIkf6LcGJAezy2M=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 01/12] tracing/user_events: Split header into uapi and kernel
Date:   Tue, 28 Mar 2023 16:52:08 -0700
Message-Id: <20230328235219.203-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328235219.203-1-beaub@linux.microsoft.com>
References: <20230328235219.203-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.25.1

