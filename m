Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B28662234
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjAIJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjAIJv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:58 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6806D7666;
        Mon,  9 Jan 2023 01:51:19 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q9so5483292pgq.5;
        Mon, 09 Jan 2023 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP1IGQWoe2Wm2Hwa/p6WLQ62fc5Nm8epIo7HcOBeu6g=;
        b=gNrPBdvxH5BR3Q0vvWQahpKoqOHi4FppaWePJP0yXAdxsWOxMZS6+y9ADc+74shgUM
         1iP/myhIKIizonrGHb1XjyvPl4bB3dsLwe2Nlo94qPdyaXwFfWEXAMpGFnH/Q+enSvZD
         roMHRTxipy4J9IJWzfvLwrZ1hg94YEkbOZVTABzBGw3gcSbPYJxg0iUJJpnqiuq33Aqz
         ROEFJBnltwyRnSfEjNUg/qipsJMyvZtfr2mI8ugeRQkuMTP+LRpmXJRC5JIPIdevzVdt
         B9bF4g+pptNa9NXSjk9WlnVfl52o1gpb/svWCLSrAlWyajS6sdwb70VZlgV9g+Lcs1gg
         dbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP1IGQWoe2Wm2Hwa/p6WLQ62fc5Nm8epIo7HcOBeu6g=;
        b=LXe23pAow+7Bi9qzPH4XOZhg2WQUj2j9c2J/iiWuTG7eCMVk3r83Glo3jVWQvd2FuE
         4NmSS7yXwIno5qMq5fPnoOXl+uaFNY8d4T8a06xq2TOU6ktDNlxzbIUUk9+dMwd3Vq/C
         2YHkn3ouZM2WA2J2AouRRR+oviP+YrSicT210M2R1PhG2clHA+EZHP9fxsh9XFcy8CcQ
         8mc3wbWvZPaeO3Y/Pk1GFB3V16gOPVUbyjguFDjgw14koYSh7IfyKgR6N5Uwl4oVskR1
         lz0fEO/94OF/UGIQOUoiz+jJGtLJp7j0WVR2gweh5ic+AP3ROQNS/KMU25kGFm1SpAsf
         UXIQ==
X-Gm-Message-State: AFqh2kpLBY9moZIGKQpUszZ7MQ7fv4QcddOT47+G88tbd4PfLC2OWtD3
        jPDrQNlswYPVW3nChVCpgNs=
X-Google-Smtp-Source: AMrXdXsumcrc8/rx72sg9TBehK42gezsJH6/nTzrOT/gsuKHUfTjmYtocv8vWNU7NNqj/haWu8DUuw==
X-Received: by 2002:a62:2544:0:b0:589:8fac:cfe5 with SMTP id l65-20020a622544000000b005898faccfe5mr753365pfl.13.1673257877706;
        Mon, 09 Jan 2023 01:51:17 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id e18-20020aa79812000000b0058119caa82csm5598727pfl.205.2023.01.09.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:15 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 81A9E104957; Mon,  9 Jan 2023 16:51:11 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 8/8] Documentation: kvx: reword
Date:   Mon,  9 Jan 2023 16:51:08 +0700
Message-Id: <20230109095108.21229-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=60293; i=bagasdotme@gmail.com; h=from:subject; bh=qhvIpICM+km+udNBRMt23gZQwKaL8C7q+O94O0Am7Nc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3db7E171Be30+8fVynTozKdKQtOPRf0vqXH3lRgsojx Z19DRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZSf5iRYYZU9h0ht+51BxX82M9t1F 3E+e+91aa4dzlOSWdvKW9jUmVkuJK0YtWE53+vzD+aeLXc8b+foti+okdz+JdO03pzUKMhhgkA
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

Improve the documentation wording to be clearer and effective.

In most cases, third-person perspective ("we") is avoided unless
absolutely necessary.

Also, monospacize programming keywords (like variable and function names).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kvx/kvx-exceptions.rst | 114 +++++++-------
 Documentation/kvx/kvx-iommu.rst      | 124 +++++++--------
 Documentation/kvx/kvx-mmu.rst        | 227 ++++++++++++++-------------
 Documentation/kvx/kvx-smp.rst        |  29 ++--
 Documentation/kvx/kvx.rst            | 209 ++++++++++++------------
 5 files changed, 351 insertions(+), 352 deletions(-)

diff --git a/Documentation/kvx/kvx-exceptions.rst b/Documentation/kvx/kvx-exceptions.rst
index 15692f14b9219d..2ce7a62174a40a 100644
--- a/Documentation/kvx/kvx-exceptions.rst
+++ b/Documentation/kvx/kvx-exceptions.rst
@@ -2,11 +2,10 @@
 Exception handling in kvx
 =========================
 
-On kvx, handlers are set using $ev (exception vector) register which
-specifies a base address.
-An offset is added to $ev upon exception and the result is used as
-"Next $pc".
-The offset depends on which exception vector the cpu wants to jump to:
+On kvx, handlers are set using $ev (exception vector) register which specifies
+a base address. An offset is added to $ev upon exception and the result is used
+as "Next $pc". The offset depends on which exception vector the cpu wants to
+jump to:
 
 * $ev + 0x00 for debug
 * $ev + 0x40 for trap
@@ -30,53 +29,52 @@ Then, handlers are laid in the following order::
   BASE -> +-------------+ v
 
 
-Interrupts, and traps are serviced similarly, ie:
+Interrupts and traps are serviced similarly, ie:
 
 - Jump to handler
 - Save all registers
 - Prepare the call (do_IRQ or trap_handler)
-- restore all registers
-- return from exception
+- Restore all registers
+- Return from exception
 
-entry.S file is (as for other architectures) the entry point into the kernel.
+``entry.S`` is (as for other architectures) the entry point into the kernel.
 It contains all assembly routines related to interrupts/traps/syscall.
 
 Syscall handling
 ================
 
 When executing a syscall, it must be done using "scall $r6"
-where $r6 contains the syscall number. Using this convention allow to
+where $r6 contains the syscall number. This convention allows to
 modify and restart a syscall from the kernel.
 
 Syscalls are handled differently than interrupts/exceptions. From an ABI
-point of view, scalls are like function calls: any caller saved register
+point of view, syscalls are like function calls: any caller-saved register
 can be clobbered by the syscall. However, syscall parameters are passed
 using registers r0 through r7. These registers must be preserved to avoid
-cloberring them before the actual syscall function.
+clobbering them before the actual syscall function.
 
-On syscall from userspace (scall instruction), the processor will put
+On syscall from userspace (``scall`` instruction), the processor will put
 the syscall number in $es.sn and switch from user to kernel privilege
-mode. kvx_syscall_handler will be called in kernel mode.
+mode. ``kvx_syscall_handler`` will then be called in kernel mode.
 
-The following steps are then taken:
+Below is the path when executing syscall:
 
-- Switch to kernel stack
-- Extract syscall number
-- Check that the syscall number is not bogus.
-  If so, set syscall func to a not implemented one
+- Switch to kernel stack.
+- Extract syscall number.
+- Check that the syscall number is not bogus. If so, set syscall func to the
+  unimplemented one.
 
-- Check if tracing is enabled.
-  If so, jump to trace_syscall_enter, then:
+- Check if tracing is enabled. If so, jump to ``trace_syscall_enter``, then:
 
- - Save syscall arguments (r0 -> r7) on stack in pt_regs
- - Call do_trace_syscall_enter function
+  - Save syscall arguments (r0 -> r7) on stack in pt_regs.
+  - Call ``do_trace_syscall_enter`` function.
 
-- Restore syscall arguments since they have been modified by C call
-- Call the syscall function
-- Save $r0 in pt_regs since it can be cloberred afterward
-- If tracing was enabled, call trace_syscall_exit
-- Call work_pending
-- Return to user !
+- Restore syscall arguments since they have been modified by C function call.
+- Call the ``syscall`` function.
+- Save $r0 in ``pt_regs`` since it can be clobbered afterward.
+- If tracing is enabled, call ``trace_syscall_exit``.
+- Call ``work_pending``.
+- Return to user
 
 The trace call is handled out of the fast path. All slow path handling
 is done in another part of code to avoid messing with the cache.
@@ -85,18 +83,18 @@ Signals
 =======
 
 Signals are handled when exiting kernel before returning to user.
-When handling a signal, the path is the following:
+When handling a signal, the execution path is:
 
 1. User application is executing normally, then exception occurs (syscall,
    interrupt, trap)
-2. The exception handling path is taken
-   and before returning to user, pending signals are checked.
+2. The exception handling path is taken and before returning to user, pending
+   signals are checked.
 
 3. The signal handling path is as follows:
 
-   * Signals are handled by do_signal.
+   * Signals are handled by ``do_signal``.
    * Registers are saved and a special part of the stack is modified
-     to create a trampoline to call rt_sigreturn.
+     to create a trampoline to call ``rt_sigreturn``.
    * $spc is modified to jump to user signal handler.
    * $ra is modified to jump to sigreturn trampoline directly after
      returning from user signal handler.
@@ -104,9 +102,9 @@ When handling a signal, the path is the following:
 4. User signal handler is called after rfe from exception.
    When returning, $ra is retored to $pc, resulting in a call
    to the syscall trampoline.
-5. syscall trampoline is executed, leading to rt_sigreturn syscall
-6. rt_sigreturn syscall is executed.
-   Previous registers are restored to allow returning to user correctly
+5. syscall trampoline is executed, leading to ``rt_sigreturn`` syscall
+6. ``rt_sigreturn`` syscall is executed. Previous registers are restored to
+   allow returning to user correctly
 7. User application is restored at the exact point it was interrupted
    before.
 
@@ -175,18 +173,18 @@ Registers handling
 ==================
 
 MMU is disabled in all exceptions paths, during register save and restoration.
-This will prevent from triggering MMU fault (such as TLB miss) which could
+This will prevent triggering MMU fault (such as TLB miss) which could
 clobber the current register state. Such event can occurs when RWX mode is
 enabled and the memory accessed to save register can trigger a TLB miss.
 Aside from that which is common for all exceptions path, registers are saved
-differently regarding the type of exception.
+differently according to exception type.
 
 Interrupts and traps
 --------------------
 
-When interrupt and traps are triggered, we only save the caller-saved registers.
+When interrupt and traps are triggered, only caller-saved registers are saved.
 Indeed, we rely on the fact that C code will save and restore callee-saved and
-hence, there is no need to save them. This path is the following::
+hence, there is no need to save them. The path is::
 
        +------------+          +-----------+        +---------------+
   IT   | Save caller| C Call   | Execute C |  Ret   | Restore caller| Ret from IT
@@ -194,12 +192,13 @@ hence, there is no need to save them. This path is the following::
        | registers  |          +-----------+        |   registers   |
        +------------+                               +---------------+
 
-However, when returning to user, we check if there is work_pending. If a signal
-is pending and there is a signal handler to be called, then we need all
-registers to be saved on the stack in the pt_regs before executing the signal
-handler and restored after that. Since we only saved caller-saved registers, we
-need to also save callee-saved registers to restore them correctly when
-returning to user. This path is the following (a bit more complicated !)::
+However, when returning to user, we check if there is ``work_pending``. If a
+signal is pending and there is a signal handler to be called, then all
+registers are needed to be saved on the stack in ``pt_regs`` before executing
+the signal handler and restored after that. Since only caller-saved registers
+are saved, we need to also save callee-saved registers to restore them
+correctly when returning to user. The path will be (note: a bit more
+complicated!)::
 
         +------------+
         | Save caller|          +-----------+  Ret   +------------+
@@ -246,13 +245,14 @@ returning to user. This path is the following (a bit more complicated !)::
 
 Syscalls
 --------
-As explained before, for syscalls, we can use whatever callee-saved registers
-we want since syscall are seen as a "classic" call from ABI pov.
-Only different path is the one for clone. For this path, since the child expects
-to find same callee-registers content than his parent, we must save them before
-executing the clone syscall and restore them after that for the child. This is
-done via a redefinition of __sys_clone in assembly which will be called in place
-of the standard sys_clone. This new call will save callee saved registers
-in pt_regs. Parent will return using the syscall standard path. Freshly spawned
-child however will be woken up via ret_from_fork which will restore all
-registers (even if caller saved are not needed).
+As explained before, for syscalls, any arbitrary callee-saved registers can
+besince syscall are seen as a "classic" call from ABI pov. The only different
+path is the one for :manpage:`clone(2)`. For this path, since the child expects
+to find same callee-registers content than its parent, they must be saved
+before executing the :manpage:`clone(2)` syscall and restore them after that
+for the child. This is done via a redefinition of ``__sys_clone`` in assembly
+which will be called in place of the standard ``sys_clone``. This new call will
+save callee-saved registers in ``pt_regs``. Parent will return using the
+syscall standard path. Freshly spawned child however will be woken up via
+``ret_from_fork`` which will restore all registers (even if caller-saved
+registers are not needed).
diff --git a/Documentation/kvx/kvx-iommu.rst b/Documentation/kvx/kvx-iommu.rst
index c95d9231d5b665..dc642ff20d8f67 100644
--- a/Documentation/kvx/kvx-iommu.rst
+++ b/Documentation/kvx/kvx-iommu.rst
@@ -4,28 +4,28 @@ IOMMU in kvx
 General Overview
 ----------------
 
-To exchange data between device and users through memory, the driver has to
-set up a buffer by doing some kernel allocation. The address of the buffer is
-virtual and the physical one is obtained through the MMU. When the device wants
-to access the same physical memory space it uses a bus address. This address is
-obtained by using the DMA mapping API. The Coolidge SoC includes several IOMMUs for clusters,
-PCIe peripherals, SoC peripherals, and more; that will translate this "bus address"
-into a physical one during DMA operations.
+To exchange data between device and users through memory, the driver has to set
+up a buffer by doing some kernel memory allocation. The address of the buffer
+is virtual and the physical one is obtained through the MMU. When the device
+wants to access the same physical memory space it uses a bus address, which is
+obtained by using the DMA mapping API. The Coolidge SoC includes several IOMMUs
+for clusters, PCIe peripherals, SoC peripherals, and more; that will translate
+this "bus address" into a physical one during DMA operations.
 
 The bus addresses are IOVA (I/O Virtual Address) or DMA addresses. This
 addresses can be obtained by calling the allocation functions of the DMA APIs.
-It can also be obtained through classical kernel allocation of physical
+It can also be obtained through classical allocation of physical
 contiguous memory and then calling mapping functions of the DMA API.
 
-In order to be able to use the kvx IOMMU we have implemented the IOMMU DMA
-interface in arch/kvx/mm/dma-mapping.c. DMA functions are registered by
-implementing arch_setup_dma_ops() and generic IOMMU functions. Generic IOMMU
-are calling our specific IOMMU functions that adding or removing mappings
+In order to be able to use the kvx IOMMU the necessary IOMMU DMA interface is
+implemented in ``arch/kvx/mm/dma-mapping.c``. DMA functions are registered by
+implementing ``arch_setup_dma_ops()`` and generic IOMMU functions. Generic
+IOMMU are calling our specific IOMMU functions that adding or removing mappings
 between DMA addresses and physical addresses in the IOMMU TLB.
 
-Specifics IOMMU functions are defined in the kvx IOMMU driver. A kvx IOMMU
-driver is managing two physical hardware IOMMU used for TX and RX. In the next
-section we described the HW IOMMUs.
+Specifics IOMMU functions are defined in the kvx IOMMU driver. It manages two
+physical hardware IOMMU used for TX and RX. In the next section we described
+the HW IOMMUs.
 
 
 Cluster IOMMUs
@@ -45,9 +45,9 @@ SoC peripherals IOMMUs
 ----------------------
 
 Since SoC peripherals are connected to an AXI bus, two IOMMUs are used: one for
-each AXI channel (read and write). These two IOMMUs are shared between all master
-devices and DMA. These two IOMMUs will have the same entries but need to be configured
-independently.
+each AXI channel (read and write). These two IOMMUs are shared between all
+master devices and DMA. These two IOMMUs will have the same entries but need to
+be configured independently.
 
 PCIe IOMMUs
 -----------
@@ -56,8 +56,8 @@ There is a slave IOMMU (read and write from the MPPA to the PCIe endpoint)
 and a master IOMMU (read and write from a PCIe endpoint to system DDR).
 The PCIe root complex and the MSI/MSI-X controller have been designed to use
 the IOMMU feature when enabled. (For example for supporting endpoint that
-support only 32 bits addresses and allow them to access any memory in a
-64 bits address space). For security reason it is highly recommended to
+support only 32-bit addresses and allow them to access any memory in the
+64-bit address space). For security reason it is highly recommended to
 activate the IOMMU for PCIe.
 
 IOMMU implementation
@@ -99,13 +99,12 @@ and translations that occurs between memory and devices::
      +--------------+
 
 
-There is also an IOMMU dedicated to the crypto module but this module will not
+There is also an IOMMU dedicated to the crypto module but the module will not
 be accessed by the operating system.
 
-We will provide one driver to manage IOMMUs RX/TX. All of them will be
-described in the device tree to be able to get their particularities. See
-the example below that describes the relation between IOMMU, DMA and NoC in
-the cluster.
+The kernel provides one driver to manage IOMMUs RX/TX. All of them are
+described in the device tree in detail. See the example below that describes
+the relation between IOMMU, DMA and NoC in the cluster.
 
 IOMMU is related to a specific bus like PCIe we will be able to specify that
 all peripherals will go through this IOMMU.
@@ -113,38 +112,38 @@ all peripherals will go through this IOMMU.
 IOMMU Page table
 ~~~~~~~~~~~~~~~~
 
-We need to be able to know which IO virtual addresses (IOVA) are mapped in the
-TLB in order to be able to remove entries when a device finishes a transfer and
-release memory. This information could be extracted when needed by computing all
-sets used by the memory and then reads all sixteen ways and compare them to the
-IOVA but it won't be efficient. We also need to be able to translate an IOVA
-to a physical address as required by the iova_to_phys IOMMU ops that is used
-by DMA. Like previously it can be done by extracting the set from the address
-and comparing the IOVA to each sixteen entries of the given set.
+It is necessary to know which IO virtual addresses (IOVA) are mapped in the TLB
+in order to be able to remove entries when a device finishes a transfer and
+release memory. This information could be extracted when needed by computing
+all sets used by the memory and then reads all 16 entries and compare them to
+the IOVA but it won't be efficient. It is also necessary to translate an IOVA
+to a physical address as required by the ``iova_to_phys`` IOMMU ops that is
+used by DMA. Again, it can be done by extracting the set from the address and
+comparing the IOVA to each sixteen entries of the given set.
 
-A solution is to keep a page table for the IOMMU. But this method is not
-efficient for reloading an entry of the TLB without the help of an hardware
-page table. So to prevent the need of a refill we will update the TLB when a
-device request access to memory and if there is no more slot available in the
-TLB we will just fail and the device will have to try again later. It is not
-efficient but at least we won't need to manage the refill of the TLB.
+A possible solution is to keep a page table for the IOMMU. However, this method
+is not efficient for reloading an entry of the TLB without the help of an
+hardware page table. So to prevent the need to refill the TLB is updated when
+a device requests access to memory and if there is no more slot available in
+the TLB the request will just fail and the device will have to try again later.
+It is not efficient but at least managing TLB refill can be avoided.
 
 This leads to an issue with the memory that can be used for transfer between
-device and memory (see Limitations below). As we only support 4Ko page size we
-can only map 8Mo. To be able to manage bigger transfer we can implement the
-huge page table in the Linux kernel and use a page table that match the size of
-huge page table for a given IOMMU (typically the PCIe IOMMU).
+device and memory (see Limitations below). As the kernel only supports 4KB page
+size only 8MB transfer can be mapped. In order to be able to manage bigger
+transfer size, it is required to implement the huge page table in the Linux
+kernel and use a page table that match the size of huge page table for a given
+IOMMU (typically the PCIe IOMMU).
 
-As we won't refill the TLB we know that we won't have more than 128*16 entries.
-In this case we can simply keep a table with all possible entries.
+Consequently, the maximum page table entries is 128*16 (2048) and the approach
+chosen to manage IOMMU TLB is is to keep a table with all posible entries.
 
 Maintenance interface
 ~~~~~~~~~~~~~~~~~~~~~
 
 It is possible to have several "maintainers" for the same IOMMU. The driver is
-using two of them. One that writes the TLB and another interface reads TLB. For
-debug purpose it is possible to display the content of the tlb by using the
-following command in gdb::
+using two of them: one that writes the TLB and another interface that reads it.
+For debug purpose it is possible to display the TLB content in gdb by::
 
     gdb> p kvx_iommu_dump_tlb( <iommu addr>, 0)
 
@@ -155,34 +154,35 @@ Interrupts
 ~~~~~~~~~~
 
 IOMMU can have 3 kind of interrupts that corresponds to 3 different types of
-errors (no mapping. protection, parity). When the IOMMU is shared between
-clusters (SoC periph and PCIe) then fifteen IRQs are generated according to the
-configuration of an association table. The association table is indexed by the
-ASN number (9 bits) and the entry of the table is a subscription mask with one
-bit per destination. Currently this is not managed by the driver.
+errors: no mapping, protection, and parity. When the IOMMU is shared between
+clusters (SoC periph and PCIe), 15 IRQs are generated corresponding to
+association table configuration. The association table is indexed by the ASN
+number (9 bits) and the entry of the table is a subscription mask with one bit
+per destination. Currently this is not managed by the driver.
 
 The driver is only managing interrupts for the cluster. The mode used is the
-stall one. So when an interrupt occurs it is managed by the driver. All others
-interrupts that occurs are stored and the IOMMU is stalled. When driver cleans
-the first interrupt others will be managed one by one.
+stall one. Thus, when an interrupt occurs it is managed by the driver. All
+others interrupts that occurs are stored and the IOMMU is stalled. When the
+driver cleans up the first interrupt, other interrupts will be managed
+sequentially.
 
 ASN (Address Space Number)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This is also know as ASID in some other architecture. Each device will have a
 given ASN that will be given through the device tree. As address space is
-managed at the IOMMU domain level we will use one group and one domain per ID.
+managed at the IOMMU domain level one group and one domain per ID is used.
 ASN are coded on 9 bits.
 
 Device tree
 -----------
 
-Relationships between devices, DMAs and IOMMUs are described in the
-device tree (see ``Documentation/devicetree/bindings/iommu/kalray,kvx-iommu.txt``
-for more details).
+Relationships between devices, DMAs and IOMMUs are described in the device tree
+(see ``Documentation/devicetree/bindings/iommu/kalray,kvx-iommu.txt`` for more
+details).
 
 Limitations
 -----------
 
-Only supporting 4 KB page size will limit the size of mapped memory to 8 MB
-because the IOMMU TLB can have at most 128*16 entries.
+kvx kernel only supports 4 KB page size, which will limit the size of mapped
+memory to 8 MB because the IOMMU TLB can have at most 128*16 (2048) entries.
diff --git a/Documentation/kvx/kvx-mmu.rst b/Documentation/kvx/kvx-mmu.rst
index 05b9bc111e02db..edad3c52caf47f 100644
--- a/Documentation/kvx/kvx-mmu.rst
+++ b/Documentation/kvx/kvx-mmu.rst
@@ -2,26 +2,26 @@
 kvx Memory Management Unit
 ==========================
 
-Virtual addresses are on 41 bits for kvx when using 64-bit mode.
-To differentiate kernel from user space, we use the high order bit
-(bit 40). When bit 40 is set, then the higher remaining bits must also be set to
-1. The virtual address must be extended with 1 when the bit 40 is set,
-if not the address must be zero extended. Bit 40 is set for kernel space
-mappings and not set for user space mappings.
+Virtual addresses are on 41 bits for kvx when using 64-bit mode. To
+differentiate kernel from user space, the high order bit (bit 40) is used. If
+it is set, then the higher remaining bits must also be set to 1. The virtual
+address must be extended with 1 when the bit 40 is set, if not the address must
+be zero extended. Bit 40 is set for kernel space mappings and not set for user
+space mappings.
 
 Memory Map
 ==========
 
-In Linux physical memories are arranged into banks according to the cost of an
-access in term of distance to a memory. As we are UMA architecture we only have
-one bank and thus one node.
+In Linux physical memories are arranged into "banks" according to the cost of
+an access in term of distance to a memory. As kvx is an UMA architecture there
+is only one bank and thus one node.
 
 A node is divided into several kind of zone. For example if DMA can only access
-a specific area in the physical memory we will define a ZONE_DMA for this purpose.
-In our case we are considering that DMA can access all DDR so we don't have a specific
-zone for this. On 64 bit architecture all DDR can be mapped in virtual kernel space
-so there is no need for a ZONE_HIGHMEM. That means that in our case there is
-only one ZONE_NORMAL. This will be updated if DMA cannot access all memory.
+a specific area in the physical memory, the region is called ``ZONE_DMA``. In
+kvx we assume that DMA can access all memory so we don't have a specific zone
+for this purpose. On 64-bit architecture all memory can be mapped in virtual
+kernel space so ``ZONE_HIGHMEM`` is unnecessary. This implies that there is
+only ``ZONE_NORMAL``. This can change if DMA cannot access all memory.
 
 Currently, the memory mapping is the following for 4KB page:
 
@@ -46,92 +46,94 @@ Currently, the memory mapping is the following for 4KB page:
 Enable the MMU
 ==============
 
-All kernel functions and symbols are in virtual memory except for kvx_start()
-function which is loaded at 0x0 in physical memory.
-To be able to switch from physical addresses to virtual addresses we choose to
+All kernel functions and symbols are in virtual memory except for
+``kvx_start()`` function which is loaded at 0x0 in physical memory. To be able
+to switch from physical addresses to virtual addresses, the decision is to
 setup the TLB at the very beginning of the boot process to be able to map both
-pieces of code. For this we added two entries in the LTLB. The first one,
-LTLB[0], contains the mapping between virtual memory and DDR. Its size is 512MB.
-The second entry, LTLB[1], contains a flat mapping of the first 2MB of the SMEM.
-Once those two entries are present we can enable the MMU. LTLB[1] will be
-removed during paging_init() because once we are really running in virtual space
-it will not be used anymore.
-In order to access more than 512MB DDR memory, the remaining memory (> 512MB) is
-refill using a comparison in kernel_perf_refill that does not walk the kernel
-page table, thus having a faster refill time for kernel. These entries are
-inserted into the LTLB for easier computation (4 LTLB entries). The drawback of
-this approach is that mapped entries are using RWX protection attributes,
-leading to no protection at all.
+pieces of code. For this two entries in the LTLB are added. The first one,
+LTLB[0], contains the mapping between virtual and physical memory. Its size is
+512MB. The second entry, LTLB[1], contains a flat mapping of the first 2MB of
+the SMEM. Once those two entries are present the MMU can be enabled. LTLB[1]
+will be removed during paging_init() because once we are really running in
+virtual space it will not be used anymore.
+
+In order to access more than 512MB of physical memory, the remaining memory (>
+512MB) is refilled using a comparison in ``kernel_perf_refill`` that does not
+walk the kernel page table, thus having a faster refill time for kernel. These
+entries are inserted into the LTLB for easier computation (4 LTLB entries). The
+drawback of this approach is that mapped entries are read-write (RWX), hence
+there is no protection and anything can happen.
 
 Kernel strict RWX
 =================
 
-CONFIG_STRICT_KERNEL_RWX is enabled by default in default_defconfig.
-Once booted, if CONFIG_STRICT_KERNEL_RWX is enable, the kernel text and memory
-will be mapped in the init_mm page table. Once mapped, the refill routine for
-the kernel is patched to always do a page table walk, bypassing the faster
-comparison but enforcing page protection attributes when refilling.
-Finally, the LTLB[0] entry is replaced by a 4K one, mapping only exceptions with
-RX protection. It allows us to never trigger nomapping on nomapping refill
-routine which would (obviously) not work... Once this is done, we can flush the
-4 LTLB entries for kernel refill in order to be sure there is no stalled
-entries and that new entries inserted in JTLB will apply.
+``CONFIG_STRICT_KERNEL_RWX`` is enabled by default. Once booted, if
+``CONFIG_STRICT_KERNEL_RWX`` is enable, the kernel text and memory will be
+mapped in the init_mm page table. Once mapped, the refill routine for the
+kernel is patched to always do walk the page table, bypassing the faster
+comparison but enforcing page protection attributes when refilling. Finally,
+the LTLB[0] entry is replaced by a 4K one, mapping only exceptions read-only
+(RX). It allows us to never trigger nomapping on nomapping refill routine which
+would (obviously) not work. Once this is done, 4 LTLB entries can be flushed
+for kernel refill in order to be sure there is no stalled entries and that new
+entries inserted in JTLB will apply.
 
 By default, the following policy is applied on vmlinux sections:
 
 - init_data: RW
-- init_text: RX (or RWX if parameter rodata=off)
-- text: RX (or RWX if parameter rodata=off)
+- init_text: RX (or RWX if parameter ``rodata=off`` is specified)
+- text: RX (or RWX if parameter ``rodata=off`` is specified)
 - rodata: RW before init, RO after init
 - sdata: RW
 
-Kernel RWX mode can then be switched on/off using /sys/kvx/kernel_rwx file.
+Kernel RWX mode can then be switched on/off with ``/sys/kvx/kernel_rwx``.
 
 Privilege Level
 ================
-Since we are using privilege levels on kvx, we make use of the virtual
-spaces to be in the same space as the user. The kernel will have the
-$ps.mmup set in kernel (PL1) and unset for user (PL2).
-As said in kvx documentation, we have two cases when the kernel is
-booted:
+Since kvx uses privilege levels, the virtual spaces is leveraged so that the
+kernel memory space is same as userspace. The kernel will have the $ps.mmup set
+in kernel (PL1) and unset for user (PL2). As said in kvx documentation, there
+are two cases when the kernel is booted:
 
 - Boot via intermediaries (bootloader, hypervisor, etc)
 - Direct boot from flash
 
-In both cases, we will use the virtual space 0. Indeed, if we are alone
-on the core, then it means nobody is using the MMU and we can take the
-first virtual space. If not alone, then when writing an entry to the tlb
-using writetlb instruction, the hypervisor will catch it and change the
+In both cases, the virtual space 0 is used. Indeed, if there is only kernel
+running on the core, nothing else is using the MMU and the first virtual space
+can be used directly by the kernel. Otherwise, when writing an entry to the tlb
+using ``writetlb`` instruction, the hypervisor will catch it and change the
 virtual space accordingly.
 
 Memblock
 ========
 
 When the kernel starts there is no memory allocator available. One of the first
-step in the kernel is to detect the amount of DDR available by getting this
-information in the device tree and initialize the low-level "memblock" allocator.
+step in the kernel is to detect the amount of available memory by getting this
+information in the device tree and initialize the low-level "memblock"
+allocator.
 
-We start by reserving memory for the whole kernel. For instance with a device
-tree containing 512Mo of DDR you could see the following boot messages:
+Memory initialization starts by reserving memory for the whole kernel. For
+instance with a 512MB RAM device dmesg will print::
 
-setup_bootmem: Memory  : 0x100000000 - 0x120000000
-setup_bootmem: Reserved: 0x10001f000 - 0x1002d1bc0
+  setup_bootmem: Memory  : 0x100000000 - 0x120000000
+  setup_bootmem: Reserved: 0x10001f000 - 0x1002d1bc0
 
 During the paging init we need to set:
 
-  - min_low_pfn that is the lowest PFN available in the system
-  - max_low_pfn that indicates the end if NORMAL zone
-  - max_pfn that is the number of pages in the system
+  - ``min_low_pfn`` - the lowest PFN available in the system
+  - ``max_low_pfn`` - the end of ``ZONE_NORMAL``
+  - ``max_pfn that`` - the number of pages in the system
 
-This setting is used for dividing memory into pages and for configuring the
-zone. See the memory map section for more information about ZONE.
+This scheme is used for dividing memory into pages and for configuring the
+zone. See the memory map section for more details.
 
-Zones are configured in free_area_init_core(). During start_kernel() other
-allocations are done for command line, cpu areas, PID hash table, different
-caches for VFS. This allocator is used until mem_init() is called.
+Zones are configured in ``free_area_init_core()``. During ``start_kernel()``
+other allocations are done for command line, cpu areas, PID hash table,
+different caches for VFS. The memblock allocator is used until ``mem_init()``
+is called.
 
-mem_init() is provided by the architecture. For MPPA we just call
-free_all_bootmem() that will go through all pages that are not used by the
+``mem_init()`` is provided by the architecture. For MPPA we just call
+``free_all_bootmem()`` that will go through all pages that are not used by the
 low level allocator and mark them as not used. So physical pages that are
 reserved for the kernel are still used and remain in physical memory. All pages
 released will now be used by the buddy allocator.
@@ -146,20 +148,20 @@ LTLB Usage
 ==========
 
 LTLB is used to add resident mapping which allows for faster MMU lookup.
-Currently, the LTLB is used to map some mandatory kernel pages and to allow fast
-accesses to l2 cache (mailbox and registers).
-When CONFIG_STRICT_KERNEL_RWX is disabled, 4 entries are reserved for kernel
-TLB refill using 512MB pages. When CONFIG_STRICT_KERNEL_RWX is enabled, these
+Currently, the LTLB is used to map some mandatory kernel pages and to allow
+fast accesses to l2 cache (mailbox and registers). When
+``CONFIG_STRICT_KERNEL_RWX`` is disabled, 4 entries are reserved for kernel TLB
+refill using 512MB pages. When ``CONFIG_STRICT_KERNEL_RWX`` is enabled, these
 entries are unused since kernel is paginated using the same mecanism than for
 user (page walking and entries in JTLB)
 
 Page Table
 ==========
 
-We only support three levels for the page table and 4KB for page size.
+Only three-level page table and 4KB page size are supported.
 
-3 levels page table
--------------------
+3-level page table
+------------------
 
 ::
 
@@ -172,16 +174,16 @@ We only support three levels for the page table and 4KB for page size.
            |          +----------------------->  [29:21] PMD offset (9 bits)
            +---------------------------------->  [39:30] PGD offset (10 bits)
 
-Bits 40 to 64 are signed extended according to bit 39. If bit 39 is equal to 1
-we are in kernel space.
+Bits 40 to 64 are signed extended according to bit 39. If this bit is equal to
+1 the process is in kernel space.
 
-As 10 bits are used for PGD we need to allocate 2 pages.
+As 10 bits are used for PGD 2 pages are needed to be allocated.
 
 PTE format
 ==========
 
-About the format of the PTE entry, as we are not forced by hardware for choices,
-we choose to follow the format described in the RiscV implementation as a
+For PTE entry format, instead of being forced by hardware constraints,
+we choose to follow the format described in the RISC-V implementation as a
 starting point::
 
   +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
@@ -207,16 +209,16 @@ starting point::
 Huge bit must be somewhere in the first 12 bits to be able to detect it
 when reading the PMD entry.
 
-PageSZ must be on bit 10 and 11 because it matches the TEL.PS bits. And
-by doing that it is easier in assembly to set the TEL.PS to PageSZ.
+PageSZ must be on bit 10 and 11 because it matches the TEL.PS bits. As such,
+it is easier in assembly to set the TEL.PS to PageSZ.
 
 Fast TLB refill
 ===============
 
-kvx core does not feature a hardware page walker. This work must be done
-by the core in software. In order to optimize TLB refill, a special fast
-path is taken when entering in kernel space.
-In order to speed up the process, the following actions are taken:
+kvx core does not feature a hardware page walker. Instead, page walking must be
+done by the core in software. In order to optimize TLB refill, a special fast
+path is utilized when entering in kernel space. In order to speed up the
+process, TLB refill is done by:
 
 1. Save some registers in a per process scratchpad
 2. If the trap is a nomapping then try the fastpath
@@ -224,21 +226,22 @@ In order to speed up the process, the following actions are taken:
 4. Check if faulting address is a memory direct mapping one. If entry is a
    direct mapping one and RWX is not enabled, add an entry into LTLB.
    Otherwise, continue
-5. Try to walk the page table. If entry is not present, take the slowpath (do_page_fault)
+5. Try to walk the page table. If entry is not present, take the slowpath
+   (``do_page_fault``)
 6. Refill the tlb properly
 7. Exit by restoring only a few registers
 
 ASN Handling
 ============
 
-Disclaimer: Some part of this are taken from ARC architecture.
+.. note::
+   Some part of ASN handling is inspired from ARC architecture.
 
 kvx MMU provides 9-bit ASN (Address Space Number) in order to tag TLB entries.
 It allows for multiple process with the same virtual space to cohabit without
-the need to flush TLB everytime we context switch.
-kvx implementation to use them is based on other architectures (such as arc
-or xtensa) and uses a wrapping ASN counter containing both cycle/generation and
-asn.
+the need to flush TLB everytime we context switch. kvx implementation to use
+them is based on other architectures (such as arc or xtensa) and uses a
+wrapping ASN counter containing both cycle/generation and asn.
 
 ::
 
@@ -250,27 +253,27 @@ asn.
 This ASN counter is incremented monotonously to allocate new ASNs. When the
 counter reaches 511 (9 bit), TLB is completely flushed and a new cycle is
 started. A new allocation cycle, post rollover, could potentially reassign an
-ASN to a different task. Thus the rule is to reassign an ASN when the current
-context cycles does not match the allocation cycle.
-The 64 bit @cpu_asn_cache (and mm->asn) have 9 bits MMU ASN and rest 55 bits
-serve as cycle/generation indicator and natural 64 bit unsigned math
-automagically increments the generation when lower 9 bits rollover.
-When the counter completely wraps, we reset the counter to first cycle value
-(ie cycle = 1). This allows to distinguish context without any ASN and old cycle
-generated value with the same operation (XOR on cycle).
+ASN to a different task, hence the rule is to reassign an ASN when the current
+context cycles does not match the allocation cycle. The 64 bit
+``@cpu_asn_cache`` (and ``mm->asn``) have 9 bits MMU ASN and rest 55 bits serve
+as cycle/generation indicator and natural 64 bit unsigned math automagically
+increments the generation when lower 9 bits rollover. When the counter
+completely wraps, we reset the counter to first cycle value (ie cycle = 1).
+This allows to distinguish context without any ASN and old cycle generated
+value with the same operation (XOR on cycle).
 
 Huge page
 =========
 
-Currently only 3 level page table has been implemented for 4Ko base page size.
-So the page shift is 12 bits, the pmd shift is 21 and the pgdir shift is 30
-bits. This choice implies that for 4Ko base page size if we use a PMD as a huge
-page the size will be 2Mo and if we use a PUD as a huge page it will be 1Go.
+Currently only 3-level page table has been implemented for 4Ko base page size.
+As such, the page shift is 12 bits, the pmd shift is 21 and the pgdir shift is
+30 bits. This also implies that for 4Ko base page size, if PMD is used as a
+huge page the size will be 2Mo and if we use a PUD as a huge page it will be
+1Go.
 
-To support other huge page sizes (64Ko and 512Mo) we need to use several
-contiguous entries in the page table. For huge page of 64Ko we will need to
-use 16 entries in the PTE and for a huge page of 512Mo it means that 256
-entries in PMD will be used.
+To support other huge page sizes (64KB and 512MB) it is necessary to use
+several contiguous entries in the page table. For 64KB page size 16 entries in
+the PTE are needed whereas for 512MB page size it requires 256 entries in PMD.
 
 Debug
 =====
@@ -278,14 +281,14 @@ Debug
 In order to debug the page table and tlb entries, gdb scripts contains commands
 which allows to dump the page table:
 
-- lx-kvx-page-table-walk
+- ``lx-kvx-page-table-walk``
     Display the current process page table by default
-- lx-kvx-tlb-decode
+- ``lx-kvx-tlb-decode``
     Display the content of $tel and $teh into something readable
 
-Other commands available in kvx-gdb are the following:
+Other commands available in kvx-gdb are:
 
-- mppa-dump-tlb
+- ``mppa-dump-tlb``
     Display the content of TLBs (JTLB and LTLB)
-- mppa-lookup-addr
+- ``mppa-lookup-addr``
     Find physical address matching a virtual one
diff --git a/Documentation/kvx/kvx-smp.rst b/Documentation/kvx/kvx-smp.rst
index f170bc48ea5f7f..dbb02207beaff0 100644
--- a/Documentation/kvx/kvx-smp.rst
+++ b/Documentation/kvx/kvx-smp.rst
@@ -2,30 +2,29 @@
 Symmetric Multiprocessing Implementation in kvx
 ===============================================
 
-On kvx, 5 clusters are organized as groups of 16 processors + 1
-secure core (RM) for each cluster. These 17 processors are L1$ coherent
-for TCM (tightly Coupled Memory). A mixed hw/sw L2$ is present to have
-cache coherency on DDR as well as TCM.
-The RM manager is not meant to run Linux so, 16 processors are available
-for SMP.
+On kvx, 5 clusters are organized as groups of 16 processors + 1 secure core
+(RM) for each cluster. These 17 processors are L1$ coherent for TCM (tightly
+Coupled Memory). There is also a mixed hw/sw L2$ to provide cache coherency on
+DDR as well as TCM.  As the secure core (RM) is not meant to run the kernel,
+the rest 16 processors are available for SMP.
 
 Booting
 =======
 
-When booting the kvx processor, only the RM is woken up. This RM will
-execute a portion of code located in a section named .rm_firmware.
-By default, a simple power off code is embedded in this section.
-To avoid embedding the firmware in kernel sources, the section is patched
-using external tools to add the L2$ firmware (and replace the default firmware).
-Before executing this firmware, the RM boots the PE0. PE0 will then enable L2
+When booting the kvx processor, only the RM is woken up. This secure core will
+execute a portion of code located in a section named ``.rm_firmware``. By
+default, a simple power off code is embedded in this section. To avoid
+embedding the firmware in kernel sources, the section is patched using external
+tools to add the L2$ firmware (and replace the default firmware). Before
+executing this firmware, the RM boots the PE0. PE0 will then enable L2
 coherency and request will be stalled until RM boots the L2$ firmware.
 
 Locking primitives
 ==================
 
-spinlock/rwlock are using the kernel standard queued spinlock/rwlocks.
-These primitives are based on cmpxch and xchg. More particularly, it uses xchg16
-which is implemented as a read modify write with acswap on 32 bit word since
+spinlock/rwlock are using the kernel standard queued spinlock/rwlocks. These
+primitives are based on cmpxch and xchg. More particularly, it uses xchg16
+which is implemented as a read-modify-write with acswap on 32 bit word since
 kvx does not have cmpxchg for size < 32bits.
 
 IPI
diff --git a/Documentation/kvx/kvx.rst b/Documentation/kvx/kvx.rst
index 5385e1e3d30187..c2b26ed7b06a8b 100644
--- a/Documentation/kvx/kvx.rst
+++ b/Documentation/kvx/kvx.rst
@@ -5,18 +5,19 @@ kvx Core Implementation
 This documents will try to explain any architecture choice for the kvx
 linux port.
 
-Regarding the peripheral, we MUST use device tree to describe ALL
-peripherals. The bindings should always start with "kalray,kvx" for all
-core related peripherals (watchdog, timer, etc)
+Regarding the peripheral, devicetree must be used to describe ALL
+peripherals. The bindings should always start with ``kalray,kvx`` for all
+core-related peripherals (watchdog, timer, etc)
 
 System Architecture
 ===================
 
-On kvx, we have 4 levels of privilege level starting from 0 (most
-privileged one) to 3 (less privilege one). A system of owners allows
-to delegate ownership of resources by using specials system registers.
+On kvx, there are 4 levels of privilege level, starting from 0 (most
+privileged) to 3 (least privileged). Ownership system allows to delegate
+ownership of resources by using specials system registers.
 
-The 2 main software stacks for Linux Kernel are the following::
+The 2 main software stacks for Linux Kernel are bare metal and hypervisor.
+Below is simple privilege level diagrams of both stacks::
 
   +-------------+       +-------------+
   | PL0: Debug  |       | PL0: Debug  |
@@ -32,104 +33,100 @@ In both cases, the kvx support for privileges has been designed using
 only relative PL and thus should work on both configurations without
 any modifications.
 
-When booting, the CPU is executing in PL0 and owns all the privileges.
-This level is almost dedicated to the debug routines for the debugguer.
-It only needs to own few privileges (breakpoint 0 and watchpoint 0) to
-be able to debug a system executing in PL1 to PL3.
-Debug routines are not always there for instance when the kernel is
-executing alone (booted from flash).
-In order to ease the load of debug routines, software convention is to
-jump directly to PL1 and let PL0 for the debug.
-When the kernel boots, it checks if the current privilege level is 0
-($ps.pl is the only absolute value). If so, then it will delegate
-almost all resources to PL1 and use a RFE to lower its execution
-privilege level (see asm_delegate_pl in head.S).
-If the current PL is already different from 0, then it means somebody
-is above us and we need to request resource to inform it we need them. It will
-then either delegate them to us directly or virtualize the delegation.
-All privileges levels have their set of banked registers (ps, ea, sps,
-sr, etc) which contain privilege level specific values.
-$sr (system reserved) is banked and will hold the current task_struct.
-This register is reserved and should not be touched by any other code.
+When booting, the CPU is executing in PL0 and owns all the privileges. This
+level is almost dedicated to the debug routines for the debugguer. It only
+needs to own few privileges (breakpoint 0 and watchpoint 0) to be able to debug
+a system executing in PL1 to PL3. Debug routines are not always there, for
+instance when the kernel is executing alone (directly booted from flash). In
+order to ease the loading them, the software convention is to jump directly to
+PL1 and let PL0 for the debug. When the kernel boots, it checks if the current
+privilege level is 0 (note that ``$ps.pl`` can only contains positive integer).
+If so, then it will delegate almost all resources to PL1 and use a RFE to lower
+its execution privilege level (see ``asm_delegate_pl`` in ``head.S``). If the
+current PL is already different from 0, then it means that there is something
+in PL 0 and it is necessary to request resource in order to inform it that the
+privilege is needed. It will then either delegate them to the kernel directly
+or virtualize the delegation. All privileges levels have their set of banked
+registers (ps, ea, sps, sr, etc) which contain privilege level specific values.
+$sr (system reserved) is banked and hold the current task_struct. This register
+is reserved and should not be touched by any other code.
+
 For more information, refer to the kvx system level architecture manual.
 
 Boot
 ====
 
-On kvx, the RM (Secure Core) of Cluster 0 will boot first. It will then be able
-to boot a firmware. This firmware is stored in the rm_firmware section.
-The first argument ($r0) of this firmware will be a pointer to a function with
-the following prototype: void firmware_init_done(uint64_t features). This
-function is responsible of describing the features supported by the firmware and
-will start the first PE after that.
-By default, the rm_firmware function act as the "default" firmware. This
-function does nothing except calling firmware_init_done and then goes to sleep.
-In order to add another firmware, the rm_firmware section is patched using
-objcopy. The content of this section is then replaced by the provided firmware.
-This firmware will do an init and then call firmware_init_done before running
-the main loop.
+On kvx, the RM (Secure Core) of Cluster 0 will boot first. It will be used to
+boot a firmware. This firmware is stored in the ``rm_firmware`` section. The
+first argument ($r0) of this firmware will be a pointer to a function with
+``void firmware_init_done(uint64_t features)`` prototype. This function is
+responsible of describing the features supported by the firmware and will start
+the first PE after that. By default, the ``rm_firmware`` function act as the
+"default" firmware. This function does nothing except calling
+``firmware_init_done`` and then goes to sleep. In order to add another
+firmware, the ``rm_firmware`` section is patched using ``objcopy``. The content
+of this section is then replaced by the provided firmware. This firmware will
+be initialized and then call firmware_init_done before running the main loop.
 When the PE boots, it will check for the firmware features to enable or disable
 specific core features (L2$ for instance).
 
-When entering the C (kvx_lowlevel_start) the kernel will look for a special
-magic in $r0 (0x494C314B). This magic tells the kernel if there is arguments
-passed by a bootloader.
-Currently, the following values are passed through registers:
+When entering the C code (``kvx_lowlevel_start``) the kernel will look for a
+special magic in $r0 (0x494C314B). It tells the kernel if there are arguments
+passed by a bootloader. Currently, the following values are passed through
+registers:
 
  - r1: pointer to command line setup by bootloader
  - r2: device tree
 
-If this magic is not set, then, the command line will be the one
-provided in the device tree (see bootargs). The default device tree is
-not builtin but will be patched by the runner used (simulator or jtag) in the
-dtb section.
+If this magic is not set, then, the command line will be the one provided in
+the device tree (see ``bootargs``). The default devicetree is not builtin but
+will be patched by the runner used (simulator or jtag) in the dtb section.
 
-A default stdout-path is desirable to allow early printk.
+The default stdout path is sufficient to allow early printk.
 
 Boot Memory Allocator
 =====================
 
 The boot memory allocator is used to allocate memory before paging is enabled.
 It is initialized with DDR and also with the shared memory. This first one is
-initialized during the setup_bootmem() and the second one when calling
-early_init_fdt_scan_reserved_mem().
+initialized during ``setup_bootmem()`` and the second one is initialized when
+calling ``early_init_fdt_scan_reserved_mem()``.
 
 
 Virtual and physical memory
 ===========================
 
 The mapping used and the memory management is described in
-Documentation/kvx/kvx-mmu.txt.
-Our Kernel is compiled using virtual addresses that starts at
-0xffffff0000000000. But when it is started the kernel uses physical addresses.
-Before calling the first function arch_low_level_start() we configure 2 entries
-of the LTLB.
+Documentation/kvx/kvx-mmu.rst. The kernel is compiled using virtual addresses
+that starts at 0xffffff0000000000, however when it is started it uses physical
+addresses. Before calling the first function ``arch_low_level_start()``, 2 LTLB
+entries are configured first.
 
-The first entry will map the first 1G of virtual address space to the first
-1G of DDR:
+The first one maps the first 1G of virtual address space to the first 1G of
+DDR:
 
   - TLB[0]: 0xffffff0000000000 -> 0x100000000 (size 512Mo)
 
-The second entry will be a flat mapping of the first 512 Ko of the SMEM. It
+The second one is a flat mapping of the first 512 Ko of the SMEM. It
 is required to have this flat mapping because there is still code located at
 this address that needs to be executed:
 
   - TLB[1]: 0x0 -> 0x0 (size 512Ko)
 
-Once virtual space reached the second entry is removed.
+Once virtual memory space is reached the second entry is removed.
 
-To be able to set breakpoints when MMU is enabled we added a label called
-gdb_mmu_enabled. If you try to set a breakpoint on a function that is in
-virtual memory before the activation of the MMU this address as no signification
-for GDB. So, for example, if you want to break on the function start_kernel()
-you will need to run::
+To be able to set breakpoints when MMU is enabled, ``gdb_mmu_enabled`` label is
+added. If you try to set a breakpoint on a function that is in virtual memory
+before the activation of the MMU it will be unhelpful for GDB. Thus, for
+example, if you want to break on the function ``start_kernel()`` you will need
+to do::
 
 	kvx-gdb -silent path_to/vmlinux \
 		-ex 'tbreak gdb_mmu_enabled' -ex 'run' \
 		-ex 'break start_kernel' \
 		-ex 'continue'
 
-We will also add an option to kvx-gdb to simplify this step.
+In the future there will be an option to kvx-gdb to simplify this step.
 
 Timers
 ======
@@ -137,7 +134,7 @@ Timers
 The free-runinng clock (clocksource) is based on the DSU. This clock is
 not interruptible and never stops even if core go into idle.
 
-Regarding the tick (clockevent), we use the timer 0 available on the core.
+Regarding the tick (clockevent), the timer 0 available on the core is used.
 This timer allows to set a periodic tick which will be used as the main
 tick for each core. Note that this clock is percpu.
 
@@ -149,60 +146,58 @@ stop the cycle counter)
 Context switching
 =================
 
-context switching is done in entry.S. When spawning a fresh thread,
-copy_thread is called. During this call, we setup callee saved register
-r20 and r21 to special values containing the function to call.
+context switching is done in ``entry.S``. When spawning a fresh thread,
+copy_thread is called. During this call, callee-saved registers r20 and r21
+are set up to special values containing the function to call.
 
-The normal path for a kernel thread will be the following:
+The normal path for a kernel thread is:
 
- 1. Enter copy_thread_tls and setup callee saved registers which will
-    be restored in __switch_to.
- 2. set r20 and r21 (in thread_struct) to function and argument and
-    ra to ret_from_kernel_thread.
-    These callee saved will be restored in switch_to.
- 3. Call _switch_to at some point.
- 4. Save all callee saved register since switch_to is seen as a
+ 1. Enter ``copy_thread_tls`` and setup callee saved registers which will
+    be restored in ``__switch_to``.
+ 2. Set r20 and r21 (in ``thread_struct``) to function and argument and
+    ra to ``ret_from_kernel_thread``. These callee-saved registers will be
+    restored in switch_to.
+ 3. Call ``_switch_to`` at some point.
+ 4. Save all callee-saved registers since ``switch_to`` is seen as a
     standard function call by the caller.
  5. Change stack pointer to the new stack
  6. At the end of switch to, set sr0 to the new task and use ret to
-    jump to ret_from_kernel_thread (address restored from ra).
- 7. In ret_from_kernel_thread, execute the function with arguments by
+    jump to ``ret_from_kernel_thread`` (address restored from ra).
+ 7. In ``ret_from_kernel_thread``, execute the function with arguments by
     using r20, r21 and we are done
 
-For more explanation, you can refer to https://lwn.net/Articles/520227/
+For more explanation, see https://lwn.net/Articles/520227/
 
 User thread creation
 ====================
 
-We are using almost the same path as copy_thread to create it.
-The detailed path is the following:
+The similar path as ``copy_thread`` is used to create threads. It consists of:
 
- 1. Call start_thread which will setup user pc and stack pointer in
-    task regs. We also set sps and clear privilege mode bit.
-    When returning from exception, it will "flip" to user mode.
- 2. Enter copy_thread_tls and setup callee saved registers which will
-    be restored in __switch_to. Also, set the "return" function to be
-    ret_from_fork which will be called at end of switch_to
- 3. set r20 (in thread_struct) with tracing information.
-    (simply by lazyness to avoid computing it in assembly...)
- 4. Call _switch_to at some point.
- 5. The current pc will then be restored to be ret_from fork.
- 6. Ret from fork calls schedule_tail and then check if tracing is
-    enabled. If so call syscall_trace_exit
- 7. Finally, instead of returning to kernel, we restore all registers
-    that have been setup by start_thread by restoring regs stored on
-    stack
+ 1. Call ``start_thread`` which will set up user pc and stack pointer in
+    task regs. sps and clear privilege mode bits are also set.
+    When return from exception, it will "flip" to user mode.
+ 2. Enter ``copy_thread_tls`` and setup callee-saved registers which will
+    be restored in ``__switch_to``. Also, set the "return" function to be
+    ``ret_from_fork`` which will be called at end of ``switch_to``
+ 3. set r20 (in ``thread_struct``) with tracing information.
+    (this is done to avoid computing it in assembly...)
+ 4. Call ``_switch_to`` at some point.
+ 5. The current pc will then be restored to be ``ret_from`` fork.
+ 6. ``ret_from`` fork calls ``schedule_tail`` and then check if tracing is
+    enabled. If so call ``syscall_trace_exit``.
+ 7. Finally, instead of returning to kernel, all registers that have been
+    setup by ``start_thread`` are restored by restoring regs stored on stack.
 
 L2$ handling
 ============
 
 On kvx, the L2$ is handled by a firmware running on the RM. This firmware needs
 various information to be aware of its configuration and communicate with the
-kernel. In order to do that, when firmware is starting, the device tree is given
-as parameter along with the "registers" zone. This zone is simply a memory area
-where data are exchanged between kernel <-> L2$. When some commands are written
-to it, the kernel sends an interrupt using a mailbox.
-If the L2$ node is not present in the device tree, then, the RM will directly go
+kernel. In order to do that, when firmware is starting, the device tree is
+given as parameter along with the "registers" zone. This zone is simply a
+memory area where data are exchanged between kernel and L2$. When firmware
+commands are written to it, the kernel sends an interrupt using a mailbox. If
+the L2$ node is not present in the device tree, then, the RM will directly go
 into sleeping.
 
 Boot diagram::
@@ -246,14 +241,16 @@ Boot diagram::
   +------------+            +            v
 
 
-Since this driver is started early (before SMP boot), A lot of drivers are not
+Since this driver is started early (before SMP boot), a lot of drivers are not
 yet probed (mailboxes, iommu, etc) and thus can not be used.
 
 Building
 ========
 
-In order to build the kernel, you will need a complete kvx toolchain.
-First, setup the config using the following command line::
+In order to build the kernel, you will need kvx cross toolchain and have it
+somewhere in the ``PATH``.
+
+First, prepare the config by::
 
 $ make ARCH=kvx O=your_directory default_defconfig
 
@@ -261,11 +258,11 @@ Adjust any configuration option you may need and then, build the kernel::
 
 $ make ARCH=kvx O=your_directory -j12
 
-You will finally have a vmlinux image ready to be run::
+You will finally have a vmlinux image which can be run by::
 
 $ kvx-mppa -- vmlinux
 
-Additionally, you may want to debug it. To do so, use kvx-gdb::
+In case you need to debug the kernel, you can simply launch::
 
 $ kvx-gdb vmlinux
 
-- 
An old man doll... just what I always wanted! - Clara

