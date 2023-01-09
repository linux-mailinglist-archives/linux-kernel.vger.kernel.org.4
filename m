Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A633D662227
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbjAIJxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjAIJvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC85A12AB8;
        Mon,  9 Jan 2023 01:51:17 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q64so8177087pjq.4;
        Mon, 09 Jan 2023 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pY4ZKXVLOrE6gD68z6GRMauw7Dx/dgMLhheE8eJci0=;
        b=BDPwNvqefBDNX9Ref2snXWVTU0ETDThH4C4K8JZ55jYDlgRZuRMhIcPIqY/ZQRun44
         y1NID1LZ+gMjRrM36zVNlGQlEdZ/+o8pk2fgk0vjwgYDr5VaeNKj4FVSAIdUwIA6kcTC
         kO31rUMHso2pgbbBjurwJikiX3Aljipw0P79uFfMKLsH1LetkW4iHifhQVaXWRpFlaTw
         DDfjhCh9hKiPVrQBMoed11CJ0CcqFEgCyJ75p1/PGJBQB8DFp6q165kT+T4tcQpYpNp1
         gc21q0Ur4V6d5P7OPvgldAXEWDVtEkNKGJg35TRk+2568qO8kSg0mz4iUb+dn1KVczR2
         FNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pY4ZKXVLOrE6gD68z6GRMauw7Dx/dgMLhheE8eJci0=;
        b=jfbnbf9dNn7+eqDH32t6iiFqDl67OLT+r/3VzFWYpXU7XsRx0q8n5aCqs6h/SsjS6g
         6Wyh9NlJLWROStFL3VHBZrBouQ8qtF0hiaCxlMKA9JoJw0w8lXtZX6q2e2Q5y86FJGLp
         99fZfvGvm6362QIH/KXtzXPz94rFSlDXGxhRrHwL87wpVcbItHoCcIVDzPWvfV1qnQjl
         roQead5UfPg6fyZcwXyKl6DIJfWzxUdKk/37VzWTBMXdwpD4gsVqQZbXS1s94H6jMiJU
         8fG05zglDgc0xRWmWiDl/jv+lvIQhcpPbTOr9JoaeDB6LGqSvpXg2JYSD/FVmxZSa9Cx
         DiYQ==
X-Gm-Message-State: AFqh2kqiMFnT2vQk0S2PwWJ9CVjsldud6fGEVB3qYamaR2WWwFs0Dt+m
        NUMvvux8cgc1Csnw3TkMPWw=
X-Google-Smtp-Source: AMrXdXtgweC1kVhPoQNQh3kHXUCXyIpa6J9Yux3VpMe0mfYIEnspuyIr3MNUNrJaLyJ4KFQFE1Ttpg==
X-Received: by 2002:a17:90b:70e:b0:227:1f03:f22d with SMTP id s14-20020a17090b070e00b002271f03f22dmr1483298pjz.15.1673257877212;
        Mon, 09 Jan 2023 01:51:17 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id ha18-20020a17090af3d200b00219eefe47c7sm4975315pjb.47.2023.01.09.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:15 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 97994105014; Mon,  9 Jan 2023 16:51:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/8] Documentation: kvx: Fix lists
Date:   Mon,  9 Jan 2023 16:51:03 +0700
Message-Id: <20230109095108.21229-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13049; i=bagasdotme@gmail.com; h=from:subject; bh=yapx+R4CPIYDKlrP7H+zacYOrKBXnpEEf/JMW3WEweI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3exN9+sLdqsvP7nn8kpLPH9htbHzFSKLwZ+TzUoXckk JZTXUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlkXWb4p7Oh9ENytHB3/fqczbqs1x k70pJvX/q879ASRWkHu6UanYwM1x82VX1wUS62mCm9J7vDRV7zC+vy/lq1nMh/Kov8O0q4AQ==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many "unexpected indentation" and block quote warnings are generated due
to errors in lists. Fix them up by:

  * Align lists texts just after the lists marker
  * Add required blank line between nested lists and between paragraphs
    and the lists
  * Use appropriate syntax for numbered lists

While at it, also lightly reword.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kvx/kvx-exceptions.rst | 53 ++++++++++++++-----------
 Documentation/kvx/kvx-iommu.rst      |  3 +-
 Documentation/kvx/kvx-mmu.rst        | 37 +++++++++--------
 Documentation/kvx/kvx.rst            | 59 +++++++++++++++-------------
 4 files changed, 85 insertions(+), 67 deletions(-)

diff --git a/Documentation/kvx/kvx-exceptions.rst b/Documentation/kvx/kvx-exceptions.rst
index bb9010efb14196..bd485efd2362c1 100644
--- a/Documentation/kvx/kvx-exceptions.rst
+++ b/Documentation/kvx/kvx-exceptions.rst
@@ -5,6 +5,7 @@ specifies a base address.
 An offset is added to $ev upon exception and the result is used as
 "Next $pc".
 The offset depends on which exception vector the cpu wants to jump to:
+
 * $ev + 0x00 for debug
 * $ev + 0x40 for trap
 * $ev + 0x80 for interrupt
@@ -28,6 +29,7 @@ Then, handlers are laid in the following order::
 
 
 Interrupts, and traps are serviced similarly, ie:
+
 - Jump to handler
 - Save all registers
 - Prepare the call (do_IRQ or trap_handler)
@@ -58,12 +60,15 @@ The following steps are then taken:
 
 - Switch to kernel stack
 - Extract syscall number
-- Check that the syscall number is not bogus
- - If so, set syscall func to a not implemented one
-- Check if tracing is enabled
- - If so, jump to trace_syscall_enter
+- Check that the syscall number is not bogus.
+  If so, set syscall func to a not implemented one
+
+- Check if tracing is enabled.
+  If so, jump to trace_syscall_enter, then:
+
  - Save syscall arguments (r0 -> r7) on stack in pt_regs
  - Call do_trace_syscall_enter function
+
 - Restore syscall arguments since they have been modified by C call
 - Call the syscall function
 - Save $r0 in pt_regs since it can be cloberred afterward
@@ -80,24 +85,28 @@ Signals
 Signals are handled when exiting kernel before returning to user.
 When handling a signal, the path is the following:
 
-1 - User application is executing normally
-    Then any exception happens (syscall, interrupt, trap)
-2 - The exception handling path is taken
-    and before returning to user, pending signals are checked
-3 - Signal are handled by do_signal
-    Registers are saved and a special part of the stack is modified
-    to create a trampoline to call rt_sigreturn
-    $spc is modified to jump to user signal handler
-    $ra is modified to jump to sigreturn trampoline directly after
-    returning from user signal handler.
-4 - User signal handler is called after rfe from exception
-    when returning, $ra is retored to $pc, resulting in a call
-    to the syscall trampoline.
-5 - syscall trampoline is executed, leading to rt_sigreturn syscall
-6 - rt_sigreturn syscall is executed
-    Previous registers are restored to allow returning to user correctly
-7 - User application is restored at the exact point it was interrupted
-    before.
+1. User application is executing normally, then exception occurs (syscall,
+   interrupt, trap)
+2. The exception handling path is taken
+   and before returning to user, pending signals are checked.
+
+3. The signal handling path is as follows:
+
+   * Signals are handled by do_signal.
+   * Registers are saved and a special part of the stack is modified
+     to create a trampoline to call rt_sigreturn.
+   * $spc is modified to jump to user signal handler.
+   * $ra is modified to jump to sigreturn trampoline directly after
+     returning from user signal handler.
+
+4. User signal handler is called after rfe from exception.
+   When returning, $ra is retored to $pc, resulting in a call
+   to the syscall trampoline.
+5. syscall trampoline is executed, leading to rt_sigreturn syscall
+6. rt_sigreturn syscall is executed.
+   Previous registers are restored to allow returning to user correctly
+7. User application is restored at the exact point it was interrupted
+   before.
 
     ::
 
diff --git a/Documentation/kvx/kvx-iommu.rst b/Documentation/kvx/kvx-iommu.rst
index 69eca8d1bc37a1..f7f61777eee21e 100644
--- a/Documentation/kvx/kvx-iommu.rst
+++ b/Documentation/kvx/kvx-iommu.rst
@@ -32,7 +32,8 @@ Cluster IOMMUs
 --------------
 
 IOMMUs on cluster are used for DMA and cryptographic accelerators.
-There are six IOMMUs connected to the:
+There are six IOMMUs connected:
+
 	- cluster DMA tx
 	- cluster DMA rx
 	- first non secure cryptographic accelerator
diff --git a/Documentation/kvx/kvx-mmu.rst b/Documentation/kvx/kvx-mmu.rst
index 832fb7c41a49d8..faa6bda2c39959 100644
--- a/Documentation/kvx/kvx-mmu.rst
+++ b/Documentation/kvx/kvx-mmu.rst
@@ -77,6 +77,7 @@ routine which would (obviously) not work... Once this is done, we can flush the
 entries and that new entries inserted in JTLB will apply.
 
 By default, the following policy is applied on vmlinux sections:
+
 - init_data: RW
 - init_text: RX (or RWX if parameter rodata=off)
 - text: RX (or RWX if parameter rodata=off)
@@ -92,8 +93,9 @@ spaces to be in the same space as the user. The kernel will have the
 $ps.mmup set in kernel (PL1) and unset for user (PL2).
 As said in kvx documentation, we have two cases when the kernel is
 booted:
-- Either we have been booted by someone (bootloader, hypervisor, etc)
-- Or we are alone (boot from flash)
+
+- Boot via intermediaries (bootloader, hypervisor, etc)
+- Direct boot from flash
 
 In both cases, we will use the virtual space 0. Indeed, if we are alone
 on the core, then it means nobody is using the MMU and we can take the
@@ -115,6 +117,7 @@ setup_bootmem: Memory  : 0x100000000 - 0x120000000
 setup_bootmem: Reserved: 0x10001f000 - 0x1002d1bc0
 
 During the paging init we need to set:
+
   - min_low_pfn that is the lowest PFN available in the system
   - max_low_pfn that indicates the end if NORMAL zone
   - max_pfn that is the number of pages in the system
@@ -213,16 +216,16 @@ kvx core does not feature a hardware page walker. This work must be done
 by the core in software. In order to optimize TLB refill, a special fast
 path is taken when entering in kernel space.
 In order to speed up the process, the following actions are taken:
-# Save some registers in a per process scratchpad
-# If the trap is a nomapping then try the fastpath
-# Save some more registers for this fastpath
-# Check if faulting address is a memory direct mapping one.
- # If entry is a direct mapping one and RWX is not enabled, add an entry into LTLB
- # If not, continue
-# Try to walk the page table
- # If entry is not present, take the slowpath (do_page_fault)
-# Refill the tlb properly
-# Exit by restoring only a few registers
+
+1. Save some registers in a per process scratchpad
+2. If the trap is a nomapping then try the fastpath
+3. Save some more registers for this fastpath
+4. Check if faulting address is a memory direct mapping one. If entry is a
+   direct mapping one and RWX is not enabled, add an entry into LTLB.
+   Otherwise, continue
+5. Try to walk the page table. If entry is not present, take the slowpath (do_page_fault)
+6. Refill the tlb properly
+7. Exit by restoring only a few registers
 
 ASN Handling
 ============
@@ -273,13 +276,15 @@ Debug
 
 In order to debug the page table and tlb entries, gdb scripts contains commands
 which allows to dump the page table:
+
 - lx-kvx-page-table-walk
- - Display the current process page table by default
+    Display the current process page table by default
 - lx-kvx-tlb-decode
- - Display the content of $tel and $teh into something readable
+    Display the content of $tel and $teh into something readable
 
 Other commands available in kvx-gdb are the following:
+
 - mppa-dump-tlb
- - Display the content of TLBs (JTLB and LTLB)
+    Display the content of TLBs (JTLB and LTLB)
 - mppa-lookup-addr
- - Find physical address matching a virtual one
+    Find physical address matching a virtual one
diff --git a/Documentation/kvx/kvx.rst b/Documentation/kvx/kvx.rst
index 20c3666f445e26..8982d10f2678df 100644
--- a/Documentation/kvx/kvx.rst
+++ b/Documentation/kvx/kvx.rst
@@ -74,6 +74,7 @@ When entering the C (kvx_lowlevel_start) the kernel will look for a special
 magic in $r0 (0x494C314B). This magic tells the kernel if there is arguments
 passed by a bootloader.
 Currently, the following values are passed through registers:
+
  - r1: pointer to command line setup by bootloader
  - r2: device tree
 
@@ -105,11 +106,13 @@ of the LTLB.
 
 The first entry will map the first 1G of virtual address space to the first
 1G of DDR:
+
   - TLB[0]: 0xffffff0000000000 -> 0x100000000 (size 512Mo)
 
 The second entry will be a flat mapping of the first 512 Ko of the SMEM. It
 is required to have this flat mapping because there is still code located at
 this address that needs to be executed:
+
   - TLB[1]: 0x0 -> 0x0 (size 512Ko)
 
 Once virtual space reached the second entry is removed.
@@ -151,19 +154,19 @@ r20 and r21 to special values containing the function to call.
 
 The normal path for a kernel thread will be the following:
 
- 1 - Enter copy_thread_tls and setup callee saved registers which will
-     be restored in __switch_to.
- 2 - set r20 and r21 (in thread_struct) to function and argument and
-     ra to ret_from_kernel_thread.
-     These callee saved will be restored in switch_to.
- 3 - Call _switch_to at some point.
- 4 - Save all callee saved register since switch_to is seen as a
-     standard function call by the caller.
- 5 - Change stack pointer to the new stack
- 6 - At the end of switch to, set sr0 to the new task and use ret to
-     jump to ret_from_kernel_thread (address restored from ra).
- 7 - In ret_from_kernel_thread, execute the function with arguments by
-     using r20, r21 and we are done
+ 1. Enter copy_thread_tls and setup callee saved registers which will
+    be restored in __switch_to.
+ 2. set r20 and r21 (in thread_struct) to function and argument and
+    ra to ret_from_kernel_thread.
+    These callee saved will be restored in switch_to.
+ 3. Call _switch_to at some point.
+ 4. Save all callee saved register since switch_to is seen as a
+    standard function call by the caller.
+ 5. Change stack pointer to the new stack
+ 6. At the end of switch to, set sr0 to the new task and use ret to
+    jump to ret_from_kernel_thread (address restored from ra).
+ 7. In ret_from_kernel_thread, execute the function with arguments by
+    using r20, r21 and we are done
 
 For more explanation, you can refer to https://lwn.net/Articles/520227/
 
@@ -173,21 +176,21 @@ User thread creation
 We are using almost the same path as copy_thread to create it.
 The detailed path is the following:
 
- 1 - Call start_thread which will setup user pc and stack pointer in
-     task regs. We also set sps and clear privilege mode bit.
-     When returning from exception, it will "flip" to user mode.
- 2 - Enter copy_thread_tls and setup callee saved registers which will
-     be restored in __switch_to. Also, set the "return" function to be
-     ret_from_fork which will be called at end of switch_to
- 3 - set r20 (in thread_struct) with tracing information.
-     (simply by lazyness to avoid computing it in assembly...)
- 4 - Call _switch_to at some point.
- 5 - The current pc will then be restored to be ret_from fork.
- 6 - Ret from fork calls schedule_tail and then check if tracing is
-     enabled. If so call syscall_trace_exit
- 7 - finally, instead of returning to kernel, we restore all registers
-     that have been setup by start_thread by restoring regs stored on
-     stack
+ 1. Call start_thread which will setup user pc and stack pointer in
+    task regs. We also set sps and clear privilege mode bit.
+    When returning from exception, it will "flip" to user mode.
+ 2. Enter copy_thread_tls and setup callee saved registers which will
+    be restored in __switch_to. Also, set the "return" function to be
+    ret_from_fork which will be called at end of switch_to
+ 3. set r20 (in thread_struct) with tracing information.
+    (simply by lazyness to avoid computing it in assembly...)
+ 4. Call _switch_to at some point.
+ 5. The current pc will then be restored to be ret_from fork.
+ 6. Ret from fork calls schedule_tail and then check if tracing is
+    enabled. If so call syscall_trace_exit
+ 7. Finally, instead of returning to kernel, we restore all registers
+    that have been setup by start_thread by restoring regs stored on
+    stack
 
 L2$ handling
 ============
-- 
An old man doll... just what I always wanted! - Clara

