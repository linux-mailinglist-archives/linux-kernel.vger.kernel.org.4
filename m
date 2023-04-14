Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130626E291F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjDNRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjDNRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:17:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150C468B;
        Fri, 14 Apr 2023 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+o8HlPIT+5Zt6pD4QH2LDwA9eouiBbycs0Cj8k5v134=; b=PiMTAPMszGVSnbBIWVtb3kTJ4e
        sYE4TOZ26E5T0tfa6TzjNsQzcGP5nOMrp/UuSkW2/HqmlHpIJOC9wE+25gGOx8neS3I4pWnt3HEpI
        ZAK16n/EmPq/JQGhQ7c/ANUbrjSSx1tD/MkRq5G2477O2eCZX6jrI0L5Xy0VPmGRNTYHzAHGqyuPR
        a71P+2lgy2xsey0DonwLHwAXz4fJ578/EzgXWkCjM/iM6UXssebUQ1nzby55uT9DL5u50Qm4BXeNz
        pOwk3IIgfRkGHaS3UvuTPD0MFO49NEVOAPzhvahnqTN0lw5SQXuZgdEtjbu3ZJRpGV3mZuAqBrEE6
        DpiRjC2w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnN2k-00ADLZ-2g;
        Fri, 14 Apr 2023 17:17:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 1/2] Change DEFINE_SEMAPHORE() to take a number argument
Date:   Fri, 14 Apr 2023 10:16:43 -0700
Message-Id: <20230414171644.2434448-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414171644.2434448-1-mcgrof@kernel.org>
References: <20230414171644.2434448-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Fundamentally semaphores are a counted primitive, but
DEFINE_SEMAPHORE() does not expose this and explicitly creates a
binary semaphore.

Change DEFINE_SEMAPHORE() to take a number argument and use that in the
few places that open-coded it using __SEMAPHORE_INITIALIZER().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[mcgrof: add some tribal knowledge about why some folks prefer
 binary sempahores over mutexes]
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/mips/cavium-octeon/setup.c                        |  2 +-
 arch/x86/kernel/cpu/intel.c                            |  2 +-
 drivers/firmware/efi/runtime-wrappers.c                |  2 +-
 drivers/firmware/efi/vars.c                            |  2 +-
 drivers/macintosh/adb.c                                |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c       |  2 +-
 drivers/platform/x86/intel/ifs/sysfs.c                 |  2 +-
 drivers/scsi/esas2r/esas2r_ioctl.c                     |  2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c      |  2 +-
 include/linux/semaphore.h                              | 10 ++++++++--
 kernel/printk/printk.c                                 |  2 +-
 net/rxrpc/call_object.c                                |  6 ++----
 12 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a71727f7a608..c5561016f577 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -72,7 +72,7 @@ extern void pci_console_init(const char *arg);
 static unsigned long long max_memory = ULLONG_MAX;
 static unsigned long long reserve_low_mem;
 
-DEFINE_SEMAPHORE(octeon_bootbus_sem);
+DEFINE_SEMAPHORE(octeon_bootbus_sem, 1);
 EXPORT_SYMBOL(octeon_bootbus_sem);
 
 static struct octeon_boot_descriptor *octeon_boot_desc_ptr;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 291d4167fab8..12bad63822f0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1177,7 +1177,7 @@ static const struct {
 static struct ratelimit_state bld_ratelimit;
 
 static unsigned int sysctl_sld_mitigate = 1;
-static DEFINE_SEMAPHORE(buslock_sem);
+static DEFINE_SEMAPHORE(buslock_sem, 1);
 
 #ifdef CONFIG_PROC_SYSCTL
 static struct ctl_table sld_sysctls[] = {
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 1fba4e09cdcf..a400c4312c82 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -158,7 +158,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
  * none of the remaining functions are actually ever called at runtime.
  * So let's just use a single lock to serialize all Runtime Services calls.
  */
-static DEFINE_SEMAPHORE(efi_runtime_lock);
+static DEFINE_SEMAPHORE(efi_runtime_lock, 1);
 
 /*
  * Expose the EFI runtime lock to the UV platform
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index bd75b87f5fc1..bfc5fa6aa47b 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -21,7 +21,7 @@
 /* Private pointer to registered efivars */
 static struct efivars *__efivars;
 
-static DEFINE_SEMAPHORE(efivars_lock);
+static DEFINE_SEMAPHORE(efivars_lock, 1);
 
 static efi_status_t check_var_size(bool nonblocking, u32 attributes,
 				   unsigned long size)
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 23bd0c77ac1a..56599515d51a 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -80,7 +80,7 @@ static struct adb_driver *adb_controller;
 BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
-static DEFINE_SEMAPHORE(adb_probe_mutex);
+static DEFINE_SEMAPHORE(adb_probe_mutex, 1);
 static int sleepy_trackpad;
 static int autopoll_devs;
 int __adb_probe_sync;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 5d1e4fe335aa..5a105bab4387 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -298,7 +298,7 @@ const u32 dmae_reg_go_c[] = {
 
 /* Global resources for unloading a previously loaded device */
 #define BNX2X_PREV_WAIT_NEEDED 1
-static DEFINE_SEMAPHORE(bnx2x_prev_sem);
+static DEFINE_SEMAPHORE(bnx2x_prev_sem, 1);
 static LIST_HEAD(bnx2x_prev_list);
 
 /* Forward declaration */
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index ee636a76b083..4c3c642ee19a 100644
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
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index e003d923acbf..055d2e87a2c8 100644
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
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index cddcd3c596c9..1a656fdc9445 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -149,7 +149,7 @@ static char *g_fragments_base;
 static char *g_free_fragments;
 static struct semaphore g_free_fragments_sema;
 
-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
+static DEFINE_SEMAPHORE(g_free_fragments_mutex, 1);
 
 static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 6694d0019a68..04655faadc2d 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -25,8 +25,14 @@ struct semaphore {
 	.wait_list	= LIST_HEAD_INIT((name).wait_list),		\
 }
 
-#define DEFINE_SEMAPHORE(name)	\
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name, 1)
+/*
+ * Unlike mutexes, binary semaphores do not have an owner, so up() can
+ * be called in a different thread from the one which called down().
+ * It is also safe to call down_trylock() and up() from interrupt
+ * context.
+ */
+#define DEFINE_SEMAPHORE(_name, _n)	\
+	struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd0c9f913940..76987aaa5a45 100644
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
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index e9f1f49d18c2..3e5cc70884dd 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -40,10 +40,8 @@ const char *const rxrpc_call_completions[NR__RXRPC_CALL_COMPLETIONS] = {
 
 struct kmem_cache *rxrpc_call_jar;
 
-static struct semaphore rxrpc_call_limiter =
-	__SEMAPHORE_INITIALIZER(rxrpc_call_limiter, 1000);
-static struct semaphore rxrpc_kernel_call_limiter =
-	__SEMAPHORE_INITIALIZER(rxrpc_kernel_call_limiter, 1000);
+static DEFINE_SEMAPHORE(rxrpc_call_limiter, 1000);
+static DEFINE_SEMAPHORE(rxrpc_kernel_call_limiter, 1000);
 
 void rxrpc_poke_call(struct rxrpc_call *call, enum rxrpc_call_poke_trace what)
 {
-- 
2.39.2

