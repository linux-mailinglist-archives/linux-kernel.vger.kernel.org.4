Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB326CF390
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjC2TrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjC2Tp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A886A58
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 604FCB82433
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1EDC433A4;
        Wed, 29 Mar 2023 19:45:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbk1-002RpO-0u;
        Wed, 29 Mar 2023 15:45:53 -0400
Message-ID: <20230329194553.094479648@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 20/25] tracing/user_events: Update documentation for ABI
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

The ABI for user_events has changed from mmap() based to remote writes.
Update the documentation to reflect these changes, add new section for
unregistering events since lifetime is now tied to tasks instead of
files.

Link: https://lkml.kernel.org/r/20230328235219.203-10-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/user_events.rst | 167 ++++++++++++++++------------
 1 file changed, 97 insertions(+), 70 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index 422802ef4025..f79987e16cf4 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -20,11 +20,10 @@ dynamic_events is the same as the ioctl with the u: prefix applied.
 
 Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
-process gives back two ints to the program for each event. The first int is
-the status bit. This describes which bit in little-endian format in the
-/sys/kernel/tracing/user_events_status file represents this event. The
-second int is the write index which describes the data when a write() or
-writev() is called on the /sys/kernel/tracing/user_events_data file.
+process tells the kernel which address and bit to reflect if any tool has
+enabled the event and data should be written. The registration will give back
+a write index which describes the data when a write() or writev() is called
+on the /sys/kernel/tracing/user_events_data file.
 
 The structures referenced in this document are contained within the
 /include/uapi/linux/user_events.h file in the source tree.
@@ -41,23 +40,64 @@ DIAG_IOCSREG.
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
+
++ size: This must be set to sizeof(struct user_reg).
 
-The struct user_reg requires two inputs, the first is the size of the structure
-to ensure forward and backward compatibility. The second is the command string
-to issue for registering. Upon success two outputs are set, the status bit
-and the write index.
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
 events need to use /sys/kernel/tracing/events/user_events/[name]/enable
 or perf record -e user_events:[name] when attaching/recording.
 
-**NOTE:** *The write_index returned is only valid for the FD that was used*
+**NOTE:** The event subsystem name by default is "user_events". Callers should
+not assume it will always be "user_events". Operators reserve the right in the
+future to change the subsystem name per-process to accomodate event isolation.
 
 Command Format
 ^^^^^^^^^^^^^^
@@ -94,7 +134,7 @@ Would be represented by the following field::
   struct mytype myname 20
 
 Deleting
------------
+--------
 Deleting an event from within a user process is done via ioctl() out to the
 /sys/kernel/tracing/user_events_data file. The command to issue is
 DIAG_IOCSDEL.
@@ -104,92 +144,79 @@ its name. Delete will only succeed if there are no references left to the
 event (in both user and kernel space). User programs should use a separate file
 to request deletes than the one used for registration due to this.
 
-Status
-------
-When tools attach/record user based events the status of the event is updated
-in realtime. This allows user programs to only incur the cost of the write() or
-writev() calls when something is actively attached to the event.
-
-User programs call mmap() on /sys/kernel/tracing/user_events_status to
-check the status for each event that is registered. The bit to check in the
-file is given back after the register ioctl() via user_reg.status_bit. The bit
-is always in little-endian format. Programs can check if the bit is set either
-using a byte-wise index with a mask or a long-wise index with a little-endian
-mask.
+Unregistering
+-------------
+If after registering an event it is no longer wanted to be updated then it can
+be disabled via ioctl() out to the /sys/kernel/tracing/user_events_data file.
+The command to issue is DIAG_IOCSUNREG. This is different than deleting, where
+deleting actually removes the event from the system. Unregistering simply tells
+the kernel your process is no longer interested in updates to the event.
 
-Currently the size of user_events_status is a single page, however, custom
-kernel configurations can change this size to allow more user based events. In
-all cases the size of the file is a multiple of a page size.
+This command takes a packed struct user_unreg as an argument::
 
-For example, if the register ioctl() gives back a status_bit of 3 you would
-check byte 0 (3 / 8) of the returned mmap data and then AND the result with 8
-(1 << (3 % 8)) to see if anything is attached to that event.
+  struct user_unreg {
+        /* Input: Size of the user_unreg structure being used */
+        __u32 size;
 
-A byte-wise index check is performed as follows::
+        /* Input: Bit to unregister */
+        __u8 disable_bit;
 
-  int index, mask;
-  char *status_page;
+        /* Input: Reserved, set to 0 */
+        __u8 __reserved;
 
-  index = status_bit / 8;
-  mask = 1 << (status_bit % 8);
-
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
@@ -217,7 +244,7 @@ For example, if I have a struct like this::
         int src;
         int dst;
         int flags;
-  };
+  } __attribute__((__packed__));
 
 It's advised for user programs to do the following::
 
-- 
2.39.1
