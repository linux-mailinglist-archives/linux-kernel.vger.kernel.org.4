Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC46CD779
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjC2KPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjC2KPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:15:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4CF40E9;
        Wed, 29 Mar 2023 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XD6f5bOaCAyYBS+M+TP/wCO7dC9gfBN3tBFXovXbVLc=; b=XZBBf4PrIjHEFWyGER0jptEarY
        kws9DLGDVI7fOiPMxmdFrTY6RqGGxEfMl4K8jq9s4Sevi/zJkYWjvm2UuUTDZ9nqlHwVgm+leRJVc
        YwxCPqCnTujlpnNb3RNh3zfoThf4H/c4avmeo9KvfNtvI553TcFKAbacLxteFkPaeY7NYDBDPJeDk
        PgvLKxUxosd7SXO+5B+Ql4yq1UGreP4xJpzkXP45t8v9VB3EOdFBLZHc42raluYAFREmgC4014Atu
        5i/cVms+z0Bosd7TRDmA20Hm34AXO6GZfkEYTMMiclcHK8MkiFO2jtpzh0SSpqgqfDMr1I0YG6Jae
        G/KO6Ukw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phSpH-006p42-2e;
        Wed, 29 Mar 2023 10:14:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CE5C300379;
        Wed, 29 Mar 2023 12:14:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AA9C2622EC50; Wed, 29 Mar 2023 12:14:42 +0200 (CEST)
Date:   Wed, 29 Mar 2023 12:14:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        song@kernel.org, rppt@kernel.org, willy@infradead.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
Message-ID: <20230329101442.GQ4253@hirez.programming.kicks-ass.net>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
 <ZCQJtz/P+/Mog3Wm@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCQJtz/P+/Mog3Wm@bombadil.infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:49:43AM -0700, Luis Chamberlain wrote:
> Seems OK to me. Either way works. Should I carry a patch from you for this
> series?

Sure, here goes (still not even compile tested, but what can go wrong,
right :-)

---
Subject: semaphore: Change DEFINE_SEMAPHORE() to take a number argument
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 29 12:06:08 CEST 2023

Fundamentally semaphores are a counted primitive, but
DEFINE_SEMAPHORE() does not expose this and explicitly creates a
binary semaphore.

Provide DEFINE_BINARY_SEMAPHORE() for this case and change
DEFINE_SEMAPHORE() to take a number argument and use that in the few
places that open-coded it using __SEMAPHORE_INITIALIZER().

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
 include/linux/semaphore.h                                     |    7 +++++--
 kernel/printk/printk.c                                        |    2 +-
 net/rxrpc/call_object.c                                       |    6 ++----
 12 files changed, 17 insertions(+), 16 deletions(-)

--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -72,7 +72,7 @@ extern void pci_console_init(const char
 static unsigned long long max_memory = ULLONG_MAX;
 static unsigned long long reserve_low_mem;
 
-DEFINE_SEMAPHORE(octeon_bootbus_sem);
+DEFINE_BINARY_SEMAPHORE(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);
 
 static struct octeon_boot_descriptor *octeon_boot_desc_ptr;
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1177,7 +1177,7 @@ static const struct {
 static struct ratelimit_state bld_ratelimit;
 
 static unsigned int sysctl_sld_mitigate = 1;
-static DEFINE_SEMAPHORE(buslock_sem);
+static DEFINE_BINARY_SEMAPHORE(buslock_sem);
 
 #ifdef CONFIG_PROC_SYSCTL
 static struct ctl_table sld_sysctls[] = {
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -158,7 +158,7 @@ void efi_call_virt_check_flags(unsigned
  * none of the remaining functions are actually ever called at runtime.
  * So let's just use a single lock to serialize all Runtime Services calls.
  */
-static DEFINE_SEMAPHORE(efi_runtime_lock);
+static DEFINE_BINARY_SEMAPHORE(efi_runtime_lock);
 
 /*
  * Expose the EFI runtime lock to the UV platform
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -21,7 +21,7 @@
 /* Private pointer to registered efivars */
 static struct efivars *__efivars;
 
-static DEFINE_SEMAPHORE(efivars_lock);
+static DEFINE_BINARY_SEMAPHORE(efivars_lock);
 
 static efi_status_t check_var_size(bool nonblocking, u32 attributes,
 				   unsigned long size)
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -80,7 +80,7 @@ static struct adb_driver *adb_controller
 BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
-static DEFINE_SEMAPHORE(adb_probe_mutex);
+static DEFINE_BINARY_SEMAPHORE(adb_probe_mutex);
 static int sleepy_trackpad;
 static int autopoll_devs;
 int __adb_probe_sync;
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -298,7 +298,7 @@ const u32 dmae_reg_go_c[] = {
 
 /* Global resources for unloading a previously loaded device */
 #define BNX2X_PREV_WAIT_NEEDED 1
-static DEFINE_SEMAPHORE(bnx2x_prev_sem);
+static DEFINE_BINARY_SEMAPHORE(bnx2x_prev_sem);
 static LIST_HEAD(bnx2x_prev_list);
 
 /* Forward declaration */
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -13,7 +13,7 @@
  * Protects against simultaneous tests on multiple cores, or
  * reloading can file while a test is in progress
  */
-static DEFINE_SEMAPHORE(ifs_sem);
+static DEFINE_BINARY_SEMAPHORE(ifs_sem);
 
 /*
  * The sysfs interface to check additional details of last test
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -56,7 +56,7 @@ dma_addr_t esas2r_buffered_ioctl_addr;
 u32 esas2r_buffered_ioctl_size;
 struct pci_dev *esas2r_buffered_ioctl_pcid;
 
-static DEFINE_SEMAPHORE(buffered_ioctl_semaphore);
+static DEFINE_BINARY_SEMAPHORE(buffered_ioctl_semaphore);
 typedef int (*BUFFERED_IOCTL_CALLBACK)(struct esas2r_adapter *,
 				       struct esas2r_request *,
 				       struct esas2r_sg_context *,
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -149,7 +149,7 @@ static char *g_fragments_base;
 static char *g_free_fragments;
 static struct semaphore g_free_fragments_sema;
 
-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
+static DEFINE_BINARY_SEMAPHORE(g_free_fragments_mutex);
 
 static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -25,8 +25,11 @@ struct semaphore {
 	.wait_list	= LIST_HEAD_INIT((name).wait_list),		\
 }
 
-#define DEFINE_SEMAPHORE(name)	\
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name, 1)
+#define DEFINE_SEMAPHORE(_name, _n)	\
+	struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
+
+#define DEFINE_BINARY_SEMAPHORE(_name)	\
+	DEFINE_SEMAPHORE(_name, 1)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -89,7 +89,7 @@ static DEFINE_MUTEX(console_mutex);
  * console_sem protects updates to console->seq and console_suspended,
  * and also provides serialization for console printing.
  */
-static DEFINE_SEMAPHORE(console_sem);
+static DEFINE_BINARY_SEMAPHORE(console_sem);
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
