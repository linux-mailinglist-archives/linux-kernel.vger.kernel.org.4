Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E2676136
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjATXF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjATXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:05:35 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C1536A329;
        Fri, 20 Jan 2023 15:05:27 -0800 (PST)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0DBA120E1A63;
        Fri, 20 Jan 2023 15:05:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DBA120E1A63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674255927;
        bh=gZQIOerORAHQ2Mn7LD3nOn2GElU/ypPYbhlbPDEbsno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsculfqACPtg3RfHPD35QcUkjVXWmlt1QzW6dWekOnwNIgn0HE27yd6gk5jLw9wwM
         oBt2hGe4+1SeSv2pvLCe+lSObtEqmVWv6o9iv9N7bBD5ASsBvbj7M18MHsmmcB+DxX
         P5xBija1HAc0XZACI04PfZhtVREVI/GynrnXu/TE=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/11] tracing/user_events: Update documentation for ABI
Date:   Fri, 20 Jan 2023 15:05:16 -0800
Message-Id: <20230120230518.17697-10-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120230518.17697-1-beaub@linux.microsoft.com>
References: <20230120230518.17697-1-beaub@linux.microsoft.com>
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

The ABI for user_events has changed from mmap() based to remote writes.
Update the documentation to reflect these changes, add new section for
unregistering events since lifetime is now tied to tasks instead of
files.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 Documentation/trace/user_events.rst | 177 ++++++++++++++++------------
 1 file changed, 102 insertions(+), 75 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index 9f181f342a70..0180714f10e3 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -11,20 +11,19 @@ that can be viewed via existing tools, such as ftrace and perf.
 To enable this feature, build your kernel with CONFIG_USER_EVENTS=y.
 
 Programs can view status of the events via
-/sys/kernel/debug/tracing/user_events_status and can both register and write
-data out via /sys/kernel/debug/tracing/user_events_data.
+/sys/kernel/tracing/user_events_status and can both register and write
+data out via /sys/kernel/tracing/user_events_data.
 
-Programs can also use /sys/kernel/debug/tracing/dynamic_events to register and
+Programs can also use /sys/kernel/tracing/dynamic_events to register and
 delete user based events via the u: prefix. The format of the command to
 dynamic_events is the same as the ioctl with the u: prefix applied.
 
 Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
-process gives back two ints to the program for each event. The first int is
-the status bit. This describes which bit in little-endian format in the
-/sys/kernel/debug/tracing/user_events_status file represents this event. The
-second int is the write index which describes the data when a write() or
-writev() is called on the /sys/kernel/debug/tracing/user_events_data file.
+process tells the kernel which address and bit to reflect if any tool has
+enabled the event and data should be written. The registration will give back
+a write index which describes the data when a write() or writev() is called
+on the /sys/kernel/tracing/user_events_data file.
 
 The structures referenced in this document are contained within the
 /include/uapi/linux/user_events.h file in the source tree.
@@ -35,29 +34,70 @@ filesystem and may be mounted at different paths than above.*
 Registering
 -----------
 Registering within a user process is done via ioctl() out to the
-/sys/kernel/debug/tracing/user_events_data file. The command to issue is
+/sys/kernel/tracing/user_events_data file. The command to issue is
 DIAG_IOCSREG.
 
 This command takes a packed struct user_reg as an argument::
 
   struct user_reg {
-        u32 size;
-        u64 name_args;
-        u32 status_bit;
-        u32 write_index;
-  };
+        /* Input: Size of the user_reg structure being used */
+        __u32 size;
+
+        /* Input: Bit in enable address to use */
+        __u8 enable_bit;
+
+        /* Input: Enable size in bytes at address */
+        __u8 enable_size;
+
+        /* Input: Flags for future use, set to 0 */
+        __u16 flags;
+
+        /* Input: Address to update when enabled */
+        __u64 enable_addr;
+
+        /* Input: Pointer to string with event name, description and flags */
+        __u64 name_args;
+
+        /* Output: Index of the event to use when writing data */
+        __u32 write_index;
+  } __attribute__((__packed__));
+
+The struct user_reg requires all the above inputs to be set appropriately.
 
-The struct user_reg requires two inputs, the first is the size of the structure
-to ensure forward and backward compatibility. The second is the command string
-to issue for registering. Upon success two outputs are set, the status bit
-and the write index.
++ size: This must be set to sizeof(struct user_reg).
+
++ enable_bit: The bit to reflect the event status at the address specified by
+  enable_addr.
+
++ enable_size: The size of the value specified by enable_addr.
+  This must be 4 (32-bit) or 8 (64-bit). 64-bit values are only allowed to be
+  used on 64-bit kernels, however, 32-bit can be used on all kernels.
+
++ flags: The flags to use, if any. For the initial version this must be 0.
+  Callers should first attempt to use flags and retry without flags to ensure
+  support for lower versions of the kernel. If a flag is not supported -EINVAL
+  is returned.
+
++ enable_addr: The address of the value to use to reflect event status. This
+  must be naturally aligned and write accessible within the user program.
+
++ name_args: The name and arguments to describe the event, see command format
+  for details.
+
+Upon successful registration the following is set.
+
++ write_index: The index to use for this file descriptor that represents this
+  event when writing out data. The index is unique to this instance of the file
+  descriptor that was used for the registration. See writing data for details.
 
 User based events show up under tracefs like any other event under the
 subsystem named "user_events". This means tools that wish to attach to the
-events need to use /sys/kernel/debug/tracing/events/user_events/[name]/enable
+events need to use /sys/kernel/tracing/events/user_events/[name]/enable
 or perf record -e user_events:[name] when attaching/recording.
 
-**NOTE:** *The write_index returned is only valid for the FD that was used*
+**NOTE:** The event subsystem name by default is "user_events". Callers should
+not assume it will always be "user_events". Operators reserve the right in the
+future to change the subsystem name per-process to accomodate event isolation.
 
 Command Format
 ^^^^^^^^^^^^^^
@@ -94,9 +134,9 @@ Would be represented by the following field::
   struct mytype myname 20
 
 Deleting
------------
+--------
 Deleting an event from within a user process is done via ioctl() out to the
-/sys/kernel/debug/tracing/user_events_data file. The command to issue is
+/sys/kernel/tracing/user_events_data file. The command to issue is
 DIAG_IOCSDEL.
 
 This command only requires a single string specifying the event to delete by
@@ -104,92 +144,79 @@ its name. Delete will only succeed if there are no references left to the
 event (in both user and kernel space). User programs should use a separate file
 to request deletes than the one used for registration due to this.
 
-Status
-------
-When tools attach/record user based events the status of the event is updated
-in realtime. This allows user programs to only incur the cost of the write() or
-writev() calls when something is actively attached to the event.
-
-User programs call mmap() on /sys/kernel/debug/tracing/user_events_status to
-check the status for each event that is registered. The bit to check in the
-file is given back after the register ioctl() via user_reg.status_bit. The bit
-is always in little-endian format. Programs can check if the bit is set either
-using a byte-wise index with a mask or a long-wise index with a little-endian
-mask.
-
-Currently the size of user_events_status is a single page, however, custom
-kernel configurations can change this size to allow more user based events. In
-all cases the size of the file is a multiple of a page size.
+Unregistering
+-------------
+If after registering an event it is no longer wanted to be updated then it can
+be disabled via ioctl() out to the /sys/kernel/tracing/user_events_data file.
+The command to issue is DIAG_IOCSUNREG. This is different than deleting, where
+deleting actually removes the event from the system. Unregistering simply tells
+the kernel your process is no longer interested in updates to the event.
 
-For example, if the register ioctl() gives back a status_bit of 3 you would
-check byte 0 (3 / 8) of the returned mmap data and then AND the result with 8
-(1 << (3 % 8)) to see if anything is attached to that event.
+This command takes a packed struct user_unreg as an argument::
 
-A byte-wise index check is performed as follows::
+  struct user_unreg {
+        /* Input: Size of the user_unreg structure being used */
+        __u32 size;
 
-  int index, mask;
-  char *status_page;
+        /* Input: Bit to unregister */
+        __u8 disable_bit;
 
-  index = status_bit / 8;
-  mask = 1 << (status_bit % 8);
+        /* Input: Reserved, set to 0 */
+        __u8 __reserved;
 
-  ...
+        /* Input: Reserved, set to 0 */
+        __u16 __reserved2;
 
-  if (status_page[index] & mask) {
-        /* Enabled */
-  }
+        /* Input: Address to unregister */
+        __u64 disable_addr;
+  } __attribute__((__packed__));
 
-A long-wise index check is performed as follows::
+The struct user_unreg requires all the above inputs to be set appropriately.
 
-  #include <asm/bitsperlong.h>
-  #include <endian.h>
++ size: This must be set to sizeof(struct user_unreg).
 
-  #if __BITS_PER_LONG == 64
-  #define endian_swap(x) htole64(x)
-  #else
-  #define endian_swap(x) htole32(x)
-  #endif
++ disable_bit: This must be set to the bit to disable (same bit that was
+  previously registered via enable_bit).
 
-  long index, mask, *status_page;
++ disable_addr: This must be set to the address to disable (same address that was
+  previously registered via enable_addr).
 
-  index = status_bit / __BITS_PER_LONG;
-  mask = 1L << (status_bit % __BITS_PER_LONG);
-  mask = endian_swap(mask);
+**NOTE:** Events are automatically unregistered when execve() is invoked. During
+fork() the registered events will be retained and must be unregistered manually
+in each process if wanted.
 
-  ...
+Status
+------
+When tools attach/record user based events the status of the event is updated
+in realtime. This allows user programs to only incur the cost of the write() or
+writev() calls when something is actively attached to the event.
 
-  if (status_page[index] & mask) {
-        /* Enabled */
-  }
+The kernel will update the specified bit that was registered for the event as
+tools attach/detach from the event. User programs simply check if the bit is set
+to see if something is attached or not.
 
 Administrators can easily check the status of all registered events by reading
 the user_events_status file directly via a terminal. The output is as follows::
 
-  Byte:Name [# Comments]
+  Name [# Comments]
   ...
 
   Active: ActiveCount
   Busy: BusyCount
-  Max: MaxCount
 
 For example, on a system that has a single event the output looks like this::
 
-  1:test
+  test
 
   Active: 1
   Busy: 0
-  Max: 32768
 
 If a user enables the user event via ftrace, the output would change to this::
 
-  1:test # Used by ftrace
+  test # Used by ftrace
 
   Active: 1
   Busy: 1
-  Max: 32768
-
-**NOTE:** *A status bit of 0 will never be returned. This allows user programs
-to have a bit that can be used on error cases.*
 
 Writing Data
 ------------
-- 
2.25.1

