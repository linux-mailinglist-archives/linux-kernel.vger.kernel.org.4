Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B90F6CD639
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjC2JUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjC2JUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:20:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA330ED;
        Wed, 29 Mar 2023 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ySrzQLXjclJLg1JjYK7jCf+1kKZG10N39gM1j0PDJh4=; b=fppPk4+ooHcyYtNeCJtGo2G/Cl
        FlILzvi7OMVEPUEVF/ODG593J/XXNPpgrlaOPXgtFT9H4qXwcyLNZtdhTaJeAIrOQY8NyOUtNuGXO
        5D5z3tXxR/byWRjT0t4cmoNyFd7tx8bU2BP/3DRG+YtFrb9fOQZWvJmrqmBz7lNFlSs7IakXivhKp
        EXS60iCYqCJ2fzfn/lUdu28W/gu4muzX5MjKiK6Gb05q3V3sNrOivDvooJCn/Qldf4NHusSUvlqsd
        jP+0N3NMXxkx262VE8scRRhv696g/GYjUjkstNdc/DEaLS3XRC8+ss+dUW1n1hj/BsFERol+gmfNE
        uSNd0UBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phRxx-006oXs-0R;
        Wed, 29 Mar 2023 09:19:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8F56300237;
        Wed, 29 Mar 2023 11:19:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B003262EE26A; Wed, 29 Mar 2023 11:19:35 +0200 (CEST)
Date:   Wed, 29 Mar 2023 11:19:35 +0200
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
Message-ID: <20230329091935.GP4253@hirez.programming.kicks-ass.net>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 12:51:48AM -0700, Luis Chamberlain wrote:
> On Wed, Mar 29, 2023 at 09:21:12AM +0200, Peter Zijlstra wrote:
> > On Tue, Mar 28, 2023 at 10:31:46PM -0700, Luis Chamberlain wrote:
> > > While I looked at re-using the old kernel/kmod.c (now kernel/module/kmod.c)
> > > concurrency delimiter methodology for another place in the kernel Linus
> > > noted that this could be simply replaced with a sempahore [0].
> > > 
> > > So add that so we we don't re-invent the wheel and make it obvious to use.
> > > 
> > > [0] https://lore.kernel.org/all/CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com/
> > > 
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  include/linux/semaphore.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
> > > index 6694d0019a68..2ecdffdb9814 100644
> > > --- a/include/linux/semaphore.h
> > > +++ b/include/linux/semaphore.h
> > > @@ -28,6 +28,9 @@ struct semaphore {
> > >  #define DEFINE_SEMAPHORE(name)	\
> > >  	struct semaphore name = __SEMAPHORE_INITIALIZER(name, 1)
> > >  
> > > +#define CONCURRENCY_LIMITER(name, n) \
> > > +	struct semaphore name = __SEMAPHORE_INITIALIZER(name, n)
> > > +
> > 
> > Why should this live in semaphore.h?
> 
> I have no preference, but sharing seems to have been better. Do you
> have any recommendations?

Call is DEFINE_SEMAPHORE_N() ?

Arguably DEFINE_SEMAPHORE() should have the argument, as binary
semaphores are a special case, but then we gotta go and fix up all
users.

/me git-greps a little.. Hmm, not too bad.

How's this?

---
 arch/mips/cavium-octeon/setup.c                               | 2 +-
 arch/x86/kernel/cpu/intel.c                                   | 2 +-
 drivers/firmware/efi/runtime-wrappers.c                       | 2 +-
 drivers/firmware/efi/vars.c                                   | 2 +-
 drivers/macintosh/adb.c                                       | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c              | 2 +-
 drivers/platform/x86/intel/ifs/sysfs.c                        | 2 +-
 drivers/scsi/esas2r/esas2r_ioctl.c                            | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 include/linux/semaphore.h                                     | 7 +++++--
 kernel/printk/printk.c                                        | 2 +-
 net/rxrpc/call_object.c                                       | 6 ++----
 12 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a71727f7a608..794b681433a7 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -72,7 +72,7 @@ extern void pci_console_init(const char *arg);
 static unsigned long long max_memory = ULLONG_MAX;
 static unsigned long long reserve_low_mem;
 
-DEFINE_SEMAPHORE(octeon_bootbus_sem);
+DEFINE_BINARY_SEMAPHORE(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);
 
 static struct octeon_boot_descriptor *octeon_boot_desc_ptr;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 291d4167fab8..c1ace4d46c35 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1177,7 +1177,7 @@ static const struct {
 static struct ratelimit_state bld_ratelimit;
 
 static unsigned int sysctl_sld_mitigate = 1;
-static DEFINE_SEMAPHORE(buslock_sem);
+static DEFINE_BINARY_SEMAPHORE(buslock_sem);
 
 #ifdef CONFIG_PROC_SYSCTL
 static struct ctl_table sld_sysctls[] = {
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 1fba4e09cdcf..1139ad6429e7 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -158,7 +158,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
  * none of the remaining functions are actually ever called at runtime.
  * So let's just use a single lock to serialize all Runtime Services calls.
  */
-static DEFINE_SEMAPHORE(efi_runtime_lock);
+static DEFINE_BINARY_SEMAPHORE(efi_runtime_lock);
 
 /*
  * Expose the EFI runtime lock to the UV platform
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index bd75b87f5fc1..09647e133c5a 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -21,7 +21,7 @@
 /* Private pointer to registered efivars */
 static struct efivars *__efivars;
 
-static DEFINE_SEMAPHORE(efivars_lock);
+static DEFINE_BINARY_SEMAPHORE(efivars_lock);
 
 static efi_status_t check_var_size(bool nonblocking, u32 attributes,
 				   unsigned long size)
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 23bd0c77ac1a..c70b18b9f97d 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -80,7 +80,7 @@ static struct adb_driver *adb_controller;
 BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
-static DEFINE_SEMAPHORE(adb_probe_mutex);
+static DEFINE_BINARY_SEMAPHORE(adb_probe_mutex);
 static int sleepy_trackpad;
 static int autopoll_devs;
 int __adb_probe_sync;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 5d1e4fe335aa..0cade1fd266f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -298,7 +298,7 @@ const u32 dmae_reg_go_c[] = {
 
 /* Global resources for unloading a previously loaded device */
 #define BNX2X_PREV_WAIT_NEEDED 1
-static DEFINE_SEMAPHORE(bnx2x_prev_sem);
+static DEFINE_BINARY_SEMAPHORE(bnx2x_prev_sem);
 static LIST_HEAD(bnx2x_prev_list);
 
 /* Forward declaration */
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index ee636a76b083..ee6782cad44f 100644
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
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index e003d923acbf..ca40d32181a7 100644
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
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index cddcd3c596c9..c7093f367f27 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -149,7 +149,7 @@ static char *g_fragments_base;
 static char *g_free_fragments;
 static struct semaphore g_free_fragments_sema;
 
-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
+static DEFINE_BINARY_SEMAPHORE(g_free_fragments_mutex);
 
 static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 6694d0019a68..18894bffb3f4 100644
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
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd0c9f913940..a3aa21d26de2 100644
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
