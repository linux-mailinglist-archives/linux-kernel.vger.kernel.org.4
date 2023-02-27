Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE26A47B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjB0RRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0RRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:17:14 -0500
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F9B1DBA6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:17:12 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677518229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i9zSXzAdjq87uOVavd3XUT89sHIO+bwDfGwXckE+rVI=;
        b=ZL6S5E+rmLgkemFRx5NmNh/pkMtGRent6m1mnlGFVfXv1cO/N4viUTJtIhd4KTrtJ/4nqd
        RFeu4zlYN9zbntBxYG2bSDwTgZqyYzWRNdyVtzQmNo/Kgz+fV+Rg8CXMSbJGGnjITj5BYI
        F9r9Sa9MmhoAWbxCsHLlz8yAshrKVfI=
From:   andrey.konovalov@linux.dev
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kcov: improve documentation
Date:   Mon, 27 Feb 2023 18:17:03 +0100
Message-Id: <0b5efd70e31bba7912cf9a6c951f0e76a8df27df.1677517724.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Improve KCOV documentation:

- Use KCOV instead of kcov, as the former is more widely-used.

- Mention Clang in compiler requirements.

- Use ``annotations`` for inline code.

- Rework remote coverage collection documentation for better clarity.

- Various smaller changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kcov.rst | 169 +++++++++++++++++++------------
 1 file changed, 102 insertions(+), 67 deletions(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index d83c9ab49427..a113a03a475f 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -1,42 +1,50 @@
-kcov: code coverage for fuzzing
+KCOV: code coverage for fuzzing
 ===============================
 
-kcov exposes kernel code coverage information in a form suitable for coverage-
-guided fuzzing (randomized testing). Coverage data of a running kernel is
-exported via the "kcov" debugfs file. Coverage collection is enabled on a task
-basis, and thus it can capture precise coverage of a single system call.
+KCOV collects and exposes kernel code coverage information in a form suitable
+for coverage-guided fuzzing. Coverage data of a running kernel is exported via
+the ``kcov`` debugfs file. Coverage collection is enabled on a task basis, and
+thus KCOV can capture precise coverage of a single system call.
 
-Note that kcov does not aim to collect as much coverage as possible. It aims
-to collect more or less stable coverage that is function of syscall inputs.
-To achieve this goal it does not collect coverage in soft/hard interrupts
-and instrumentation of some inherently non-deterministic parts of kernel is
-disabled (e.g. scheduler, locking).
+Note that KCOV does not aim to collect as much coverage as possible. It aims
+to collect more or less stable coverage that is a function of syscall inputs.
+To achieve this goal, it does not collect coverage in soft/hard interrupts
+(unless remove coverage collection is enabled, see below) and from some
+inherently non-deterministic parts of the kernel (e.g. scheduler, locking).
 
-kcov is also able to collect comparison operands from the instrumented code
-(this feature currently requires that the kernel is compiled with clang).
+Besides collecting code coverage, KCOV can also collect comparison operands.
+See the "Comparison operands collection" section for details.
+
+Besides collecting coverage data from syscall handlers, KCOV can also collect
+coverage for annotated parts of the kernel executing in background kernel
+tasks or soft interrupts. See the "Remote coverage collection" section for
+details.
 
 Prerequisites
 -------------
 
-Configure the kernel with::
+KCOV relies on compiler instrumentation and requires GCC 6.1.0 or later
+or any Clang version supported by the kernel.
 
-        CONFIG_KCOV=y
+Collecting comparison operands is only supported with Clang.
 
-CONFIG_KCOV requires gcc 6.1.0 or later.
+To enable KCOV, configure the kernel with::
 
-If the comparison operands need to be collected, set::
+        CONFIG_KCOV=y
+
+To enable comparison operands collection, set::
 
 	CONFIG_KCOV_ENABLE_COMPARISONS=y
 
-Profiling data will only become accessible once debugfs has been mounted::
+Coverage data only becomes accessible once debugfs has been mounted::
 
         mount -t debugfs none /sys/kernel/debug
 
 Coverage collection
 -------------------
 
-The following program demonstrates coverage collection from within a test
-program using kcov:
+The following program demonstrates how to use KCOV to collect coverage for a
+single syscall from within a test program:
 
 .. code-block:: c
 
@@ -84,7 +92,7 @@ program using kcov:
 		perror("ioctl"), exit(1);
 	/* Reset coverage from the tail of the ioctl() call. */
 	__atomic_store_n(&cover[0], 0, __ATOMIC_RELAXED);
-	/* That's the target syscal call. */
+	/* Call the target syscall call. */
 	read(-1, NULL, 0);
 	/* Read number of PCs collected. */
 	n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
@@ -103,7 +111,7 @@ program using kcov:
 	return 0;
     }
 
-After piping through addr2line output of the program looks as follows::
+After piping through ``addr2line`` the output of the program looks as follows::
 
     SyS_read
     fs/read_write.c:562
@@ -121,12 +129,13 @@ After piping through addr2line output of the program looks as follows::
     fs/read_write.c:562
 
 If a program needs to collect coverage from several threads (independently),
-it needs to open /sys/kernel/debug/kcov in each thread separately.
+it needs to open ``/sys/kernel/debug/kcov`` in each thread separately.
 
 The interface is fine-grained to allow efficient forking of test processes.
-That is, a parent process opens /sys/kernel/debug/kcov, enables trace mode,
-mmaps coverage buffer and then forks child processes in a loop. Child processes
-only need to enable coverage (disable happens automatically on thread end).
+That is, a parent process opens ``/sys/kernel/debug/kcov``, enables trace mode,
+mmaps coverage buffer, and then forks child processes in a loop. The child
+processes only need to enable coverage (it gets disabled automatically when
+a thread exits).
 
 Comparison operands collection
 ------------------------------
@@ -205,52 +214,78 @@ Comparison operands collection is similar to coverage collection:
 	return 0;
     }
 
-Note that the kcov modes (coverage collection or comparison operands) are
-mutually exclusive.
+Note that the KCOV modes (collection of code coverage or comparison operands)
+are mutually exclusive.
 
 Remote coverage collection
 --------------------------
 
-With KCOV_ENABLE coverage is collected only for syscalls that are issued
-from the current process. With KCOV_REMOTE_ENABLE it's possible to collect
-coverage for arbitrary parts of the kernel code, provided that those parts
-are annotated with kcov_remote_start()/kcov_remote_stop().
-
-This allows to collect coverage from two types of kernel background
-threads: the global ones, that are spawned during kernel boot in a limited
-number of instances (e.g. one USB hub_event() worker thread is spawned per
-USB HCD); and the local ones, that are spawned when a user interacts with
-some kernel interface (e.g. vhost workers); as well as from soft
-interrupts.
-
-To enable collecting coverage from a global background thread or from a
-softirq, a unique global handle must be assigned and passed to the
-corresponding kcov_remote_start() call. Then a userspace process can pass
-a list of such handles to the KCOV_REMOTE_ENABLE ioctl in the handles
-array field of the kcov_remote_arg struct. This will attach the used kcov
-device to the code sections, that are referenced by those handles.
-
-Since there might be many local background threads spawned from different
-userspace processes, we can't use a single global handle per annotation.
-Instead, the userspace process passes a non-zero handle through the
-common_handle field of the kcov_remote_arg struct. This common handle gets
-saved to the kcov_handle field in the current task_struct and needs to be
-passed to the newly spawned threads via custom annotations. Those threads
-should in turn be annotated with kcov_remote_start()/kcov_remote_stop().
-
-Internally kcov stores handles as u64 integers. The top byte of a handle
-is used to denote the id of a subsystem that this handle belongs to, and
-the lower 4 bytes are used to denote the id of a thread instance within
-that subsystem. A reserved value 0 is used as a subsystem id for common
-handles as they don't belong to a particular subsystem. The bytes 4-7 are
-currently reserved and must be zero. In the future the number of bytes
-used for the subsystem or handle ids might be increased.
-
-When a particular userspace process collects coverage via a common
-handle, kcov will collect coverage for each code section that is annotated
-to use the common handle obtained as kcov_handle from the current
-task_struct. However non common handles allow to collect coverage
-selectively from different subsystems.
+Besides collecting coverage data from handlers of syscalls issued from a
+userspace process, KCOV can also collect coverage for parts of the kernel
+executing in other contexts - so-called "remote" coverage.
+
+Using KCOV to collect remote coverage requires:
+
+1. Modifying kernel code to annotate the code section from where coverage
+   should be collected with ``kcov_remote_start`` and ``kcov_remote_stop``.
+
+2. Using `KCOV_REMOTE_ENABLE`` instead of ``KCOV_ENABLE`` in the userspace
+   process that collects coverage.
+
+Both ``kcov_remote_start`` and ``kcov_remote_stop`` annotations and the
+``KCOV_REMOTE_ENABLE`` ioctl accept handles that identify particular coverage
+collection sections. The way a handle is used depends on the context where the
+matching code section executes.
+
+KCOV supports collecting remote coverage from the following contexts:
+
+1. Global kernel background tasks. These are the tasks that are spawned during
+   kernel boot in a limited number of instances (e.g. one USB ``hub_event``
+   worker is spawned per one USB HCD).
+
+2. Local kernel background tasks. These are spawned when a userspace process
+   interacts with some kernel interface and are usually killed when the process
+   exits (e.g. vhost workers).
+
+3. Soft interrupts.
+
+For #1 and #3, a unique global handle must be chosen and passed to the
+corresponding ``kcov_remote_start`` call. Then a userspace process must pass
+this handle to ``KCOV_REMOTE_ENABLE`` in the ``handles`` array field of the
+``kcov_remote_arg`` struct. This will attach the used KCOV device to the code
+section referenced by this handle. Multiple global handles identifying
+different code sections can be passed at once.
+
+For #2, the userspace process instead must pass a non-zero handle through the
+``common_handle`` field of the ``kcov_remote_arg`` struct. This common handle
+gets saved to the ``kcov_handle`` field in the current ``task_struct`` and
+needs to be passed to the newly spawned local tasks via custom kernel code
+modifications. Those tasks should in turn use the passed handle in their
+``kcov_remote_start`` and ``kcov_remote_stop`` annotations.
+
+KCOV follows a predefined format for both global and common handles. Each
+handle is a ``u64`` integer. Currently, only the one top and the lower 4 bytes
+are used. Bytes 4-7 are reserved and must be zero.
+
+For global handles, the top byte of the handle denotes the id of a subsystem
+this handle belongs to. For example, KCOV uses ``1`` as the USB subsystem id.
+The lower 4 bytes of a global handle denote the id of a task instance within
+that subsystem. For example, each ``hub_event`` worker uses the USB bus number
+as the task instance id.
+
+For common handles, a reserved value ``0`` is used as a subsystem id, as such
+handles don't belong to a particular subsystem. The lower 4 bytes of a common
+handle identify a collective instance of all local tasks spawned by the
+userspace process that passed a common handle to ``KCOV_REMOTE_ENABLE``.
+
+In practice, any value can be used for common handle instance id if coverage
+is only collected from a single userspace process on the system. However, if
+common handles are used by multiple processes, unique instance ids must be
+used for each process. One option is to use the process id as the common
+handle instance id.
+
+The following program demonstrates using KCOV to collect coverage from both
+local tasks spawned by the process and the global task that handles USB bus #1:
 
 .. code-block:: c
 
-- 
2.25.1

