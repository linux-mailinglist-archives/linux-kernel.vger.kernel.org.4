Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED256D0418
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjC3L5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjC3L5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:57:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94797;
        Thu, 30 Mar 2023 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k7uaT+sMnmeDWcjQU/N6p9lwO5v20LsnKAG8porccmM=; b=bKGHblLxGK5HyB9nqT1iZNN8IZ
        Jwito8ISCxvONnPiJog41gh0/xiv7+Jr9a+RNjRX4fIvDUXNpAMXuDzjdxZiPH2bE/T4GiOyJZuEz
        uPstI2+e99KjsP8XnUsWohuERcczDzOwwKt85tANyMCCTzf4P2WcXR5K5Kc5SDj/xuXwWlqDKKQDl
        WxkhhKhMVFQUzSOY5HgmDQdmi03mOHGJHcMvCRQqUgbgVlC9s87CMizLxdEwF5NCmvCCN0zsFn08W
        DwR9NDzy3fkGdpNS93mHwCzMZNuQr0v1MoLUc2UAjnU3AGEUlmie7i/MhPkLNAXcK+XHxw2ux0G2k
        Vdeh4uuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phqtJ-007B4v-2x;
        Thu, 30 Mar 2023 11:56:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD71E3002A3;
        Thu, 30 Mar 2023 13:56:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B9402421D7A0; Thu, 30 Mar 2023 13:56:26 +0200 (CEST)
Date:   Thu, 30 Mar 2023 13:56:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        song@kernel.org, rppt@kernel.org, willy@infradead.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
Message-ID: <20230330115626.GA124812@hirez.programming.kicks-ass.net>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
 <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:50:39AM -0700, Linus Torvalds wrote:
> So ack on your patch, but don't bother with DEFINE_BINARY_SEMAPHORE().

Sure thing; still completely untested...

---
Subject: Change DEFINE_SEMAPHORE() to take a number argument
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 29 Mar 2023 12:14:42 +0200

Fundamentally semaphores are a counted primitive, but
DEFINE_SEMAPHORE() does not expose this and explicitly creates a
binary semaphore.

Change DEFINE_SEMAPHORE() to take a number argument and use that in the
few places that open-coded it using __SEMAPHORE_INITIALIZER().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/cavium-octeon/setup.c                               |    2 +-
 arch/x86/kernel/cpu/intel.c                                   |    2 +-
 drivers/firmware/efi/runtime-wrappers.c                       |    2 +-
 drivers/firmware/efi/vars.c                                   |    2 +-
 drivers/macintosh/adb.c                                       |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c              |    2 +-
 drivers/platform/x86/intel/ifs/sysfs.c                        |    2 +-
 drivers/scsi/esas2r/esas2r_ioctl.c                            |    2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |    2 +-
 include/linux/semaphore.h                                     |    4 ++--
 kernel/printk/printk.c                                        |    2 +-
 net/rxrpc/call_object.c                                       |    6 ++----
 12 files changed, 14 insertions(+), 16 deletions(-)

--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -72,7 +72,7 @@ extern void pci_console_init(const char
 static unsigned long long max_memory = ULLONG_MAX;
 static unsigned long long reserve_low_mem;
 
-DEFINE_SEMAPHORE(octeon_bootbus_sem);
+DEFINE_SEMAPHORE(octeon_bootbus_sem, 1);
 EXPORT_SYMBOL(octeon_bootbus_sem);
 
 static struct octeon_boot_descriptor *octeon_boot_desc_ptr;
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1177,7 +1177,7 @@ static const struct {
 static struct ratelimit_state bld_ratelimit;
 
 static unsigned int sysctl_sld_mitigate = 1;
-static DEFINE_SEMAPHORE(buslock_sem);
+static DEFINE_SEMAPHORE(buslock_sem, 1);
 
 #ifdef CONFIG_PROC_SYSCTL
 static struct ctl_table sld_sysctls[] = {
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -158,7 +158,7 @@ void efi_call_virt_check_flags(unsigned
  * none of the remaining functions are actually ever called at runtime.
  * So let's just use a single lock to serialize all Runtime Services calls.
  */
-static DEFINE_SEMAPHORE(efi_runtime_lock);
+static DEFINE_SEMAPHORE(efi_runtime_lock, 1);
 
 /*
  * Expose the EFI runtime lock to the UV platform
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -21,7 +21,7 @@
 /* Private pointer to registered efivars */
 static struct efivars *__efivars;
 
-static DEFINE_SEMAPHORE(efivars_lock);
+static DEFINE_SEMAPHORE(efivars_lock, 1);
 
 static efi_status_t check_var_size(bool nonblocking, u32 attributes,
 				   unsigned long size)
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -80,7 +80,7 @@ static struct adb_driver *adb_controller
 BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
-static DEFINE_SEMAPHORE(adb_probe_mutex);
+static DEFINE_SEMAPHORE(adb_probe_mutex, 1);
 static int sleepy_trackpad;
 static int autopoll_devs;
 int __adb_probe_sync;
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -298,7 +298,7 @@ const u32 dmae_reg_go_c[] = {
 
 /* Global resources for unloading a previously loaded device */
 #define BNX2X_PREV_WAIT_NEEDED 1
-static DEFINE_SEMAPHORE(bnx2x_prev_sem);
+static DEFINE_SEMAPHORE(bnx2x_prev_sem, 1);
 static LIST_HEAD(bnx2x_prev_list);
 
 /* Forward declaration */
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -13,7 +13,7 @@
  * Protects against simultaneous tests on multiple cores, or
  * reloading can file while a test is in progress
  */
-static DEFINE_SEMAPHORE(ifs_sem);
+static DEFINE_SEMAPHORE(ifs_sem, 1);
 
 /*
  * The sysfs interface to check additional details of last test
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -56,7 +56,7 @@ dma_addr_t esas2r_buffered_ioctl_addr;
 u32 esas2r_buffered_ioctl_size;
 struct pci_dev *esas2r_buffered_ioctl_pcid;
 
-static DEFINE_SEMAPHORE(buffered_ioctl_semaphore);
+static DEFINE_SEMAPHORE(buffered_ioctl_semaphore, 1);
 typedef int (*BUFFERED_IOCTL_CALLBACK)(struct esas2r_adapter *,
 				       struct esas2r_request *,
 				       struct esas2r_sg_context *,
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -149,7 +149,7 @@ static char *g_fragments_base;
 static char *g_free_fragments;
 static struct semaphore g_free_fragments_sema;
 
-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
+static DEFINE_SEMAPHORE(g_free_fragments_mutex, 1);
 
 static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -25,8 +25,8 @@ struct semaphore {
 	.wait_list	= LIST_HEAD_INIT((name).wait_list),		\
 }
 
-#define DEFINE_SEMAPHORE(name)	\
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name, 1)
+#define DEFINE_SEMAPHORE(_name, _n)	\
+	struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -89,7 +89,7 @@ static DEFINE_MUTEX(console_mutex);
  * console_sem protects updates to console->seq and console_suspended,
  * and also provides serialization for console printing.
  */
-static DEFINE_SEMAPHORE(console_sem);
+static DEFINE_SEMAPHORE(console_sem, 1);
 HLIST_HEAD(console_list);
 EXPORT_SYMBOL_GPL(console_list);
 DEFINE_STATIC_SRCU(console_srcu);
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -40,10 +40,8 @@ const char *const rxrpc_call_completions
 
 struct kmem_cache *rxrpc_call_jar;
 
-static struct semaphore rxrpc_call_limiter =
-	__SEMAPHORE_INITIALIZER(rxrpc_call_limiter, 1000);
-static struct semaphore rxrpc_kernel_call_limiter =
-	__SEMAPHORE_INITIALIZER(rxrpc_kernel_call_limiter, 1000);
+static DEFINE_SEMAPHORE(rxrpc_call_limiter, 1000);
+static DEFINE_SEMAPHORE(rxrpc_kernel_call_limiter, 1000);
 
 void rxrpc_poke_call(struct rxrpc_call *call, enum rxrpc_call_poke_trace what)
 {
