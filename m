Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C55F011A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiI2W4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiI2Wzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98BAEC55A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E949621E1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A63C433D7;
        Thu, 29 Sep 2022 22:55:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oe2SP-000ctN-3D;
        Thu, 29 Sep 2022 18:56:42 -0400
Message-ID: <20220929225641.570530955@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Sep 2022 18:55:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 15/15] tracing/user_events: Update ABI documentation to align to bits vs
 bytes
References: <20220929225542.784716766@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Update the documentation to reflect the new ABI requirements and how to
use the byte index with the mask properly to check event status.

Link: https://lkml.kernel.org/r/20220728233309.1896-7-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/user_events.rst | 86 +++++++++++++++++++----------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index c180936f49fc..9f181f342a70 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -20,14 +20,14 @@ dynamic_events is the same as the ioctl with the u: prefix applied.
 
 Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
-process gives back two ints to the program for each event. The first int is the
-status index. This index describes which byte in the
+process gives back two ints to the program for each event. The first int is
+the status bit. This describes which bit in little-endian format in the
 /sys/kernel/debug/tracing/user_events_status file represents this event. The
-second int is the write index. This index describes the data when a write() or
+second int is the write index which describes the data when a write() or
 writev() is called on the /sys/kernel/debug/tracing/user_events_data file.
 
-The structures referenced in this document are contained with the
-/include/uap/linux/user_events.h file in the source tree.
+The structures referenced in this document are contained within the
+/include/uapi/linux/user_events.h file in the source tree.
 
 **NOTE:** *Both user_events_status and user_events_data are under the tracefs
 filesystem and may be mounted at different paths than above.*
@@ -38,18 +38,18 @@ Registering within a user process is done via ioctl() out to the
 /sys/kernel/debug/tracing/user_events_data file. The command to issue is
 DIAG_IOCSREG.
 
-This command takes a struct user_reg as an argument::
+This command takes a packed struct user_reg as an argument::
 
   struct user_reg {
         u32 size;
         u64 name_args;
-        u32 status_index;
+        u32 status_bit;
         u32 write_index;
   };
 
 The struct user_reg requires two inputs, the first is the size of the structure
 to ensure forward and backward compatibility. The second is the command string
-to issue for registering. Upon success two outputs are set, the status index
+to issue for registering. Upon success two outputs are set, the status bit
 and the write index.
 
 User based events show up under tracefs like any other event under the
@@ -111,15 +111,56 @@ in realtime. This allows user programs to only incur the cost of the write() or
 writev() calls when something is actively attached to the event.
 
 User programs call mmap() on /sys/kernel/debug/tracing/user_events_status to
-check the status for each event that is registered. The byte to check in the
-file is given back after the register ioctl() via user_reg.status_index.
+check the status for each event that is registered. The bit to check in the
+file is given back after the register ioctl() via user_reg.status_bit. The bit
+is always in little-endian format. Programs can check if the bit is set either
+using a byte-wise index with a mask or a long-wise index with a little-endian
+mask.
+
 Currently the size of user_events_status is a single page, however, custom
 kernel configurations can change this size to allow more user based events. In
 all cases the size of the file is a multiple of a page size.
 
-For example, if the register ioctl() gives back a status_index of 3 you would
-check byte 3 of the returned mmap data to see if anything is attached to that
-event.
+For example, if the register ioctl() gives back a status_bit of 3 you would
+check byte 0 (3 / 8) of the returned mmap data and then AND the result with 8
+(1 << (3 % 8)) to see if anything is attached to that event.
+
+A byte-wise index check is performed as follows::
+
+  int index, mask;
+  char *status_page;
+
+  index = status_bit / 8;
+  mask = 1 << (status_bit % 8);
+
+  ...
+
+  if (status_page[index] & mask) {
+        /* Enabled */
+  }
+
+A long-wise index check is performed as follows::
+
+  #include <asm/bitsperlong.h>
+  #include <endian.h>
+
+  #if __BITS_PER_LONG == 64
+  #define endian_swap(x) htole64(x)
+  #else
+  #define endian_swap(x) htole32(x)
+  #endif
+
+  long index, mask, *status_page;
+
+  index = status_bit / __BITS_PER_LONG;
+  mask = 1L << (status_bit % __BITS_PER_LONG);
+  mask = endian_swap(mask);
+
+  ...
+
+  if (status_page[index] & mask) {
+        /* Enabled */
+  }
 
 Administrators can easily check the status of all registered events by reading
 the user_events_status file directly via a terminal. The output is as follows::
@@ -137,7 +178,7 @@ For example, on a system that has a single event the output looks like this::
 
   Active: 1
   Busy: 0
-  Max: 4096
+  Max: 32768
 
 If a user enables the user event via ftrace, the output would change to this::
 
@@ -145,21 +186,10 @@ If a user enables the user event via ftrace, the output would change to this::
 
   Active: 1
   Busy: 1
-  Max: 4096
-
-**NOTE:** *A status index of 0 will never be returned. This allows user
-programs to have an index that can be used on error cases.*
-
-Status Bits
-^^^^^^^^^^^
-The byte being checked will be non-zero if anything is attached. Programs can
-check specific bits in the byte to see what mechanism has been attached.
-
-The following values are defined to aid in checking what has been attached:
-
-**EVENT_STATUS_FTRACE** - Bit set if ftrace has been attached (Bit 0).
+  Max: 32768
 
-**EVENT_STATUS_PERF** - Bit set if perf has been attached (Bit 1).
+**NOTE:** *A status bit of 0 will never be returned. This allows user programs
+to have a bit that can be used on error cases.*
 
 Writing Data
 ------------
-- 
2.35.1
