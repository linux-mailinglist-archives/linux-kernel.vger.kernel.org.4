Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDD36D161E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCaDqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCaDqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:46:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E91881E;
        Thu, 30 Mar 2023 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=wtWLrHjeLNn2iW0gv9NsXxpP7xhe7X8yoqyD2zWfuio=; b=dC/KEhV7YeehrUyjqvDPzZf97n
        e5AbMODDIkAQ+4QaeBwVPA0e7bQFasp6reVJCO6Km9fMfa8D6jBLqQzv6hylx26TNNa7tdfPS0m39
        biV1RGkIhfCRBAPQYjREiVuXHPbjjKetMBWiCmvHFPOc+qLeIPXlmV579E7LZEwL5K5xbDU1Yenl7
        hYIVOfpoKzwGEMLodxvbderl9T3bRaVnvyo8+lyiq8RWz8DpBuovWOIT9tB9I/PGA69M57hmgUj2C
        YFXTWCX42w7VF3KjiCUL4G6uc4rhFzWp8ZEC6q12oHNshINNgfo0++YqRlibv6ypjwrTGSipmgnyk
        z/3/XKZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pi5i4-005jMw-2B;
        Fri, 31 Mar 2023 03:45:52 +0000
Date:   Thu, 30 Mar 2023 20:45:52 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, petr.pavlu@suse.com,
        prarit@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, song@kernel.org,
        rppt@kernel.org, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
Message-ID: <ZCZXcJ+KJffpFrpX@bombadil.infradead.org>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
 <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
 <20230330115626.GA124812@hirez.programming.kicks-ass.net>
 <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:23:54AM -0700, Linus Torvalds wrote:
> On Thu, Mar 30, 2023 at 4:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Sure thing; still completely untested...
> 
> Seems obvious enough.
> 
> Looking at the people who use a semaphore as a mutex, one core user stands out:
> 
> >  kernel/printk/printk.c                                        |    2 +-
> 
> .. and I'm not entirely sure why that uses a semaphore. It may be
> *entirely* legacy, and should just be changed to be a mutex.
> 
> But it may also be that the 'console_sem' has some subtle reason why
> it wants to be a semaphore, and why it then plays games with lockdep
> (which doesn't support counting semaphores) and does things like
> 
>   #define down_console_sem() do { \
>         down(&console_sem);\
>         mutex_acquire(&console_lock_dep_map, 0, 0, _RET_IP_);\
>   } while (0)
> 
> Anyway, I think your patch is obviously safe as-is, and I think it's
> long overdue to make it clear that the only real reason to use
> semaphores rather than mutexes is if you do need the counting thing.
> 
> Of course, there is the thing about lockdep, and also about how
> semaphores these days have no architecture-specific parts, so if
> anybody wants to play deep games with their locking, that may be a
> reason for using them.
> 
> Although we also do have some other issues - I think down_trylock() is
> ok in irq contexts, but mutex_trylock() is not. Maybe that's why
> printk uses semaphores? I forget.

It sounds like perhaps we should take our time with the conversion and
let each component review / decide and get things tested just in case.
kmod can just open code the __SEMAPHORE_INITIALIZER(name, n) for now
and once we get all conversions we replace it with the counter one
in semaphore.h.

I'll drop this and the kmod stuff from this series as separate effort,
no point to hold up the other stuff part of this patchset.

The coccinelle approach to this is as follows, it goes build tested
with allmodconfig and boot tested on x86_64 without issues.

You'd use:

make coccicheck MODE=patch SPFLAGS="--in-place --no-show-diff" COCCI=./sema-binary-to-mutex.cocci

$ cat sema-binary-to-mutex.cocci

virtual patch

@ binary_sema_found depends on patch @
identifier sema;
declarer name DEFINE_SEMAPHORE;
declarer name DEFINE_MUTEX;
@@

-DEFINE_SEMAPHORE(sema);
+DEFINE_MUTEX(sema);

@ sema_down_replace_with_mutex_lock depends on binary_sema_found @
identifier binary_sema_found.sema;
@@

-down(&sema)
+mutex_lock(&sema)

@ sema_up_replace_with_mutex_unlock depends on binary_sema_found @
identifier binary_sema_found.sema;
@@

-up(&sema)
+mutex_unlock(&sema)

@ sema_mutex_lock_interruptible depends on binary_sema_found @
identifier binary_sema_found.sema;
@@

-down_interruptible(&sema)
+mutex_lock_interruptible(&sema)

@ sema_mutex_trylock depends on binary_sema_found @
identifier binary_sema_found.sema;
@@

-down_trylock(&sema)
+!mutex_trylock(&sema)

This produces the following patch, I'll send each separately next.

 arch/mips/cavium-octeon/setup.c               |  2 +-
 arch/x86/kernel/cpu/intel.c                   |  6 +-
 drivers/firmware/efi/runtime-wrappers.c       | 58 +++++++++----------
 drivers/firmware/efi/vars.c                   | 20 +++----
 drivers/macintosh/adb.c                       | 18 +++---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 28 ++++-----
 drivers/platform/x86/intel/ifs/sysfs.c        | 10 ++--
 drivers/scsi/esas2r/esas2r_ioctl.c            |  6 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 10 ++--
 kernel/printk/printk.c                        |  8 +--
 10 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a71727f7a608..30c286c5ac9c 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -72,7 +72,7 @@ extern void pci_console_init(const char *arg);
 static unsigned long long max_memory = ULLONG_MAX;
 static unsigned long long reserve_low_mem;
 
-DEFINE_SEMAPHORE(octeon_bootbus_sem);
+DEFINE_MUTEX(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);
 
 static struct octeon_boot_descriptor *octeon_boot_desc_ptr;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 291d4167fab8..00c9fcd90e1a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1177,7 +1177,7 @@ static const struct {
 static struct ratelimit_state bld_ratelimit;
 
 static unsigned int sysctl_sld_mitigate = 1;
-static DEFINE_SEMAPHORE(buslock_sem);
+static DEFINE_MUTEX(buslock_sem);
 
 #ifdef CONFIG_PROC_SYSCTL
 static struct ctl_table sld_sysctls[] = {
@@ -1315,7 +1315,7 @@ static void split_lock_init(void)
 static void __split_lock_reenable_unlock(struct work_struct *work)
 {
 	sld_update_msr(true);
-	up(&buslock_sem);
+	mutex_unlock(&buslock_sem);
 }
 
 static DECLARE_DELAYED_WORK(sl_reenable_unlock, __split_lock_reenable_unlock);
@@ -1364,7 +1364,7 @@ static void split_lock_warn(unsigned long ip)
 		 * Misery factor #2:
 		 * only allow one buslocked disabled core at a time.
 		 */
-		if (down_interruptible(&buslock_sem) == -EINTR)
+		if (mutex_lock_interruptible(&buslock_sem) == -EINTR)
 			return;
 		work = &sl_reenable_unlock;
 	} else {
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 1fba4e09cdcf..4826e2a2f193 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -158,7 +158,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
  * none of the remaining functions are actually ever called at runtime.
  * So let's just use a single lock to serialize all Runtime Services calls.
  */
-static DEFINE_SEMAPHORE(efi_runtime_lock);
+static DEFINE_MUTEX(efi_runtime_lock);
 
 /*
  * Expose the EFI runtime lock to the UV platform
@@ -254,10 +254,10 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_GET_TIME, tm, tc, NULL, NULL, NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -265,10 +265,10 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_SET_TIME, tm, NULL, NULL, NULL, NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -278,11 +278,11 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_GET_WAKEUP_TIME, enabled, pending, tm, NULL,
 				NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -290,11 +290,11 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
 				NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -306,11 +306,11 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_GET_VARIABLE, name, vendor, attr, data_size,
 				data);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -320,11 +320,11 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_GET_NEXT_VARIABLE, name_size, name, vendor,
 				NULL, NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -336,11 +336,11 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_SET_VARIABLE, name, vendor, &attr, &data_size,
 				data);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -351,12 +351,12 @@ virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 {
 	efi_status_t status;
 
-	if (down_trylock(&efi_runtime_lock))
+	if (!mutex_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
 	status = efi_call_virt(set_variable, name, vendor, attr, data_size,
 			       data);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -371,11 +371,11 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_QUERY_VARIABLE_INFO, &attr, storage_space,
 				remaining_space, max_variable_size, NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -390,12 +390,12 @@ virt_efi_query_variable_info_nonblocking(u32 attr,
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
-	if (down_trylock(&efi_runtime_lock))
+	if (!mutex_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
 	status = efi_call_virt(query_variable_info, attr, storage_space,
 			       remaining_space, max_variable_size);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -403,11 +403,11 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
 				NULL, NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -416,14 +416,14 @@ static void virt_efi_reset_system(int reset_type,
 				  unsigned long data_size,
 				  efi_char16_t *data)
 {
-	if (down_trylock(&efi_runtime_lock)) {
+	if (!mutex_trylock(&efi_runtime_lock)) {
 		pr_warn("failed to invoke the reset_system() runtime service:\n"
 			"could not get exclusive access to the firmware\n");
 		return;
 	}
 	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
 	__efi_call_virt(reset_system, reset_type, status, data_size, data);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 }
 
 static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
@@ -435,11 +435,11 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_UPDATE_CAPSULE, capsules, &count, &sg_list,
 				NULL, NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
@@ -453,11 +453,11 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (mutex_lock_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
 	status = efi_queue_work(EFI_QUERY_CAPSULE_CAPS, capsules, &count,
 				max_size, reset_type, NULL);
-	up(&efi_runtime_lock);
+	mutex_unlock(&efi_runtime_lock);
 	return status;
 }
 
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index bd75b87f5fc1..4a7e4cb8a04a 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -21,7 +21,7 @@
 /* Private pointer to registered efivars */
 static struct efivars *__efivars;
 
-static DEFINE_SEMAPHORE(efivars_lock);
+static DEFINE_MUTEX(efivars_lock);
 
 static efi_status_t check_var_size(bool nonblocking, u32 attributes,
 				   unsigned long size)
@@ -64,7 +64,7 @@ int efivars_register(struct efivars *efivars,
 {
 	int rv;
 
-	if (down_interruptible(&efivars_lock))
+	if (mutex_lock_interruptible(&efivars_lock))
 		return -EINTR;
 
 	if (__efivars) {
@@ -80,7 +80,7 @@ int efivars_register(struct efivars *efivars,
 	pr_info("Registered efivars operations\n");
 	rv = 0;
 out:
-	up(&efivars_lock);
+	mutex_unlock(&efivars_lock);
 
 	return rv;
 }
@@ -97,7 +97,7 @@ int efivars_unregister(struct efivars *efivars)
 {
 	int rv;
 
-	if (down_interruptible(&efivars_lock))
+	if (mutex_lock_interruptible(&efivars_lock))
 		return -EINTR;
 
 	if (!__efivars) {
@@ -116,7 +116,7 @@ int efivars_unregister(struct efivars *efivars)
 
 	rv = 0;
 out:
-	up(&efivars_lock);
+	mutex_unlock(&efivars_lock);
 	return rv;
 }
 EXPORT_SYMBOL_GPL(efivars_unregister);
@@ -133,10 +133,10 @@ EXPORT_SYMBOL_GPL(efivar_supports_writes);
  */
 int efivar_lock(void)
 {
-	if (down_interruptible(&efivars_lock))
+	if (mutex_lock_interruptible(&efivars_lock))
 		return -EINTR;
 	if (!__efivars->ops) {
-		up(&efivars_lock);
+		mutex_unlock(&efivars_lock);
 		return -ENODEV;
 	}
 	return 0;
@@ -149,10 +149,10 @@ EXPORT_SYMBOL_NS_GPL(efivar_lock, EFIVAR);
  */
 int efivar_trylock(void)
 {
-	if (down_trylock(&efivars_lock))
+	if (!mutex_trylock(&efivars_lock))
 		 return -EBUSY;
 	if (!__efivars->ops) {
-		up(&efivars_lock);
+		mutex_unlock(&efivars_lock);
 		return -ENODEV;
 	}
 	return 0;
@@ -164,7 +164,7 @@ EXPORT_SYMBOL_NS_GPL(efivar_trylock, EFIVAR);
  */
 void efivar_unlock(void)
 {
-	up(&efivars_lock);
+	mutex_unlock(&efivars_lock);
 }
 EXPORT_SYMBOL_NS_GPL(efivar_unlock, EFIVAR);
 
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 23bd0c77ac1a..8553da83ac77 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -80,7 +80,7 @@ static struct adb_driver *adb_controller;
 BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
-static DEFINE_SEMAPHORE(adb_probe_mutex);
+static DEFINE_MUTEX(adb_probe_mutex);
 static int sleepy_trackpad;
 static int autopoll_devs;
 int __adb_probe_sync;
@@ -228,7 +228,7 @@ adb_probe_task(void *x)
 	do_adb_reset_bus();
 	pr_debug("adb: finished probe task...\n");
 
-	up(&adb_probe_mutex);
+	mutex_unlock(&adb_probe_mutex);
 
 	return 0;
 }
@@ -249,7 +249,7 @@ adb_reset_bus(void)
 		return 0;
 	}
 
-	down(&adb_probe_mutex);
+	mutex_lock(&adb_probe_mutex);
 	schedule_work(&adb_reset_work);
 	return 0;
 }
@@ -262,7 +262,7 @@ static int __adb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	adb_got_sleep = 1;
 	/* We need to get a lock on the probe thread */
-	down(&adb_probe_mutex);
+	mutex_lock(&adb_probe_mutex);
 	/* Stop autopoll */
 	if (adb_controller->autopoll)
 		adb_controller->autopoll(0);
@@ -292,7 +292,7 @@ static int adb_poweroff(struct device *dev)
 static int __adb_resume(struct platform_device *dev)
 {
 	adb_got_sleep = 0;
-	up(&adb_probe_mutex);
+	mutex_unlock(&adb_probe_mutex);
 	adb_reset_bus();
 
 	return 0;
@@ -798,7 +798,7 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
 	atomic_inc(&state->n_pending);
 
 	/* If a probe is in progress or we are sleeping, wait for it to complete */
-	down(&adb_probe_mutex);
+	mutex_lock(&adb_probe_mutex);
 
 	/* Queries are special requests sent to the ADB driver itself */
 	if (req->data[0] == ADB_QUERY) {
@@ -806,14 +806,14 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
 			ret = do_adb_query(req);
 		else
 			ret = -EINVAL;
-		up(&adb_probe_mutex);
+		mutex_unlock(&adb_probe_mutex);
 	}
 	/* Special case for ADB_BUSRESET request, all others are sent to
 	   the controller */
 	else if ((req->data[0] == ADB_PACKET) && (count > 1)
 		&& (req->data[1] == ADB_BUSRESET)) {
 		ret = do_adb_reset_bus();
-		up(&adb_probe_mutex);
+		mutex_unlock(&adb_probe_mutex);
 		atomic_dec(&state->n_pending);
 		if (ret == 0)
 			ret = count;
@@ -824,7 +824,7 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
 			ret = adb_controller->send_request(req, 0);
 		else
 			ret = -ENXIO;
-		up(&adb_probe_mutex);
+		mutex_unlock(&adb_probe_mutex);
 	}
 
 	if (ret != 0) {
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 5d1e4fe335aa..f90763aa93b8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -298,7 +298,7 @@ const u32 dmae_reg_go_c[] = {
 
 /* Global resources for unloading a previously loaded device */
 #define BNX2X_PREV_WAIT_NEEDED 1
-static DEFINE_SEMAPHORE(bnx2x_prev_sem);
+static DEFINE_MUTEX(bnx2x_prev_sem);
 static LIST_HEAD(bnx2x_prev_list);
 
 /* Forward declaration */
@@ -10569,7 +10569,7 @@ static int bnx2x_prev_path_mark_eeh(struct bnx2x *bp)
 	struct bnx2x_prev_path_list *tmp_list;
 	int rc;
 
-	rc = down_interruptible(&bnx2x_prev_sem);
+	rc = mutex_lock_interruptible(&bnx2x_prev_sem);
 	if (rc) {
 		BNX2X_ERR("Received %d when tried to take lock\n", rc);
 		return rc;
@@ -10584,7 +10584,7 @@ static int bnx2x_prev_path_mark_eeh(struct bnx2x *bp)
 			  BP_PATH(bp));
 	}
 
-	up(&bnx2x_prev_sem);
+	mutex_unlock(&bnx2x_prev_sem);
 
 	return rc;
 }
@@ -10594,7 +10594,7 @@ static bool bnx2x_prev_is_path_marked(struct bnx2x *bp)
 	struct bnx2x_prev_path_list *tmp_list;
 	bool rc = false;
 
-	if (down_trylock(&bnx2x_prev_sem))
+	if (!mutex_trylock(&bnx2x_prev_sem))
 		return false;
 
 	tmp_list = bnx2x_prev_path_get_entry(bp);
@@ -10609,7 +10609,7 @@ static bool bnx2x_prev_is_path_marked(struct bnx2x *bp)
 		}
 	}
 
-	up(&bnx2x_prev_sem);
+	mutex_unlock(&bnx2x_prev_sem);
 
 	return rc;
 }
@@ -10619,12 +10619,12 @@ bool bnx2x_port_after_undi(struct bnx2x *bp)
 	struct bnx2x_prev_path_list *entry;
 	bool val;
 
-	down(&bnx2x_prev_sem);
+	mutex_lock(&bnx2x_prev_sem);
 
 	entry = bnx2x_prev_path_get_entry(bp);
 	val = !!(entry && (entry->undi & (1 << BP_PORT(bp))));
 
-	up(&bnx2x_prev_sem);
+	mutex_unlock(&bnx2x_prev_sem);
 
 	return val;
 }
@@ -10634,7 +10634,7 @@ static int bnx2x_prev_mark_path(struct bnx2x *bp, bool after_undi)
 	struct bnx2x_prev_path_list *tmp_list;
 	int rc;
 
-	rc = down_interruptible(&bnx2x_prev_sem);
+	rc = mutex_lock_interruptible(&bnx2x_prev_sem);
 	if (rc) {
 		BNX2X_ERR("Received %d when tried to take lock\n", rc);
 		return rc;
@@ -10650,10 +10650,10 @@ static int bnx2x_prev_mark_path(struct bnx2x *bp, bool after_undi)
 			   BP_PATH(bp));
 			tmp_list->aer = 0;
 		}
-		up(&bnx2x_prev_sem);
+		mutex_unlock(&bnx2x_prev_sem);
 		return 0;
 	}
-	up(&bnx2x_prev_sem);
+	mutex_unlock(&bnx2x_prev_sem);
 
 	/* Create an entry for this path and add it */
 	tmp_list = kmalloc(sizeof(struct bnx2x_prev_path_list), GFP_KERNEL);
@@ -10668,7 +10668,7 @@ static int bnx2x_prev_mark_path(struct bnx2x *bp, bool after_undi)
 	tmp_list->aer = 0;
 	tmp_list->undi = after_undi ? (1 << BP_PORT(bp)) : 0;
 
-	rc = down_interruptible(&bnx2x_prev_sem);
+	rc = mutex_lock_interruptible(&bnx2x_prev_sem);
 	if (rc) {
 		BNX2X_ERR("Received %d when tried to take lock\n", rc);
 		kfree(tmp_list);
@@ -10676,7 +10676,7 @@ static int bnx2x_prev_mark_path(struct bnx2x *bp, bool after_undi)
 		DP(NETIF_MSG_HW, "Marked path [%d] - finished previous unload\n",
 		   BP_PATH(bp));
 		list_add(&tmp_list->list, &bnx2x_prev_list);
-		up(&bnx2x_prev_sem);
+		mutex_unlock(&bnx2x_prev_sem);
 	}
 
 	return rc;
@@ -10893,7 +10893,7 @@ static int bnx2x_prev_unload(struct bnx2x *bp)
 			break;
 		}
 
-		rc = down_interruptible(&bnx2x_prev_sem);
+		rc = mutex_lock_interruptible(&bnx2x_prev_sem);
 		if (rc) {
 			BNX2X_ERR("Cannot check for AER; Received %d when tried to take lock\n",
 				  rc);
@@ -10901,7 +10901,7 @@ static int bnx2x_prev_unload(struct bnx2x *bp)
 			/* If Path is marked by EEH, ignore unload status */
 			aer = !!(bnx2x_prev_path_get_entry(bp) &&
 				 bnx2x_prev_path_get_entry(bp)->aer);
-			up(&bnx2x_prev_sem);
+			mutex_unlock(&bnx2x_prev_sem);
 		}
 
 		if (fw == FW_MSG_CODE_DRV_UNLOAD_COMMON || aer) {
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index ee636a76b083..34001b2885cd 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -13,7 +13,7 @@
  * Protects against simultaneous tests on multiple cores, or
  * reloading can file while a test is in progress
  */
-static DEFINE_SEMAPHORE(ifs_sem);
+static DEFINE_MUTEX(ifs_sem);
 
 /*
  * The sysfs interface to check additional details of last test
@@ -72,7 +72,7 @@ static ssize_t run_test_store(struct device *dev,
 	if (rc < 0 || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	if (down_interruptible(&ifs_sem))
+	if (mutex_lock_interruptible(&ifs_sem))
 		return -EINTR;
 
 	if (!ifsd->loaded)
@@ -80,7 +80,7 @@ static ssize_t run_test_store(struct device *dev,
 	else
 		rc = do_core_test(cpu, dev);
 
-	up(&ifs_sem);
+	mutex_unlock(&ifs_sem);
 
 	return rc ? rc : count;
 }
@@ -99,14 +99,14 @@ static ssize_t current_batch_store(struct device *dev,
 	if (rc < 0 || cur_batch > 0xff)
 		return -EINVAL;
 
-	if (down_interruptible(&ifs_sem))
+	if (mutex_lock_interruptible(&ifs_sem))
 		return -EINTR;
 
 	ifsd->cur_batch = cur_batch;
 
 	rc = ifs_load_firmware(dev);
 
-	up(&ifs_sem);
+	mutex_unlock(&ifs_sem);
 
 	return (rc == 0) ? count : rc;
 }
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index e003d923acbf..b935fc076fc8 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -56,7 +56,7 @@ dma_addr_t esas2r_buffered_ioctl_addr;
 u32 esas2r_buffered_ioctl_size;
 struct pci_dev *esas2r_buffered_ioctl_pcid;
 
-static DEFINE_SEMAPHORE(buffered_ioctl_semaphore);
+static DEFINE_MUTEX(buffered_ioctl_semaphore);
 typedef int (*BUFFERED_IOCTL_CALLBACK)(struct esas2r_adapter *,
 				       struct esas2r_request *,
 				       struct esas2r_sg_context *,
@@ -209,7 +209,7 @@ static u8 handle_buffered_ioctl(struct esas2r_buffered_ioctl *bi)
 	struct esas2r_sg_context sgc;
 	u8 result = IOCTL_SUCCESS;
 
-	if (down_interruptible(&buffered_ioctl_semaphore))
+	if (mutex_lock_interruptible(&buffered_ioctl_semaphore))
 		return IOCTL_OUT_OF_RESOURCES;
 
 	/* allocate a buffer or use the existing buffer. */
@@ -285,7 +285,7 @@ static u8 handle_buffered_ioctl(struct esas2r_buffered_ioctl *bi)
 	if (result == IOCTL_SUCCESS)
 		memcpy(bi->ioctl, esas2r_buffered_ioctl, bi->length);
 
-	up(&buffered_ioctl_semaphore);
+	mutex_unlock(&buffered_ioctl_semaphore);
 	return result;
 }
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index cddcd3c596c9..dde211f08145 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -149,7 +149,7 @@ static char *g_fragments_base;
 static char *g_free_fragments;
 static struct semaphore g_free_fragments_sema;
 
-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
+static DEFINE_MUTEX(g_free_fragments_mutex);
 
 static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
@@ -383,11 +383,11 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 
 		WARN_ON(!g_free_fragments);
 
-		down(&g_free_fragments_mutex);
+		mutex_lock(&g_free_fragments_mutex);
 		fragments = g_free_fragments;
 		WARN_ON(!fragments);
 		g_free_fragments = *(char **)g_free_fragments;
-		up(&g_free_fragments_mutex);
+		mutex_unlock(&g_free_fragments_mutex);
 		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
 			(fragments - g_fragments_base) / g_fragments_size;
 	}
@@ -443,10 +443,10 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 				fragments + g_cache_line_size,
 				tail_bytes);
 
-		down(&g_free_fragments_mutex);
+		mutex_lock(&g_free_fragments_mutex);
 		*(char **)fragments = g_free_fragments;
 		g_free_fragments = fragments;
-		up(&g_free_fragments_mutex);
+		mutex_unlock(&g_free_fragments_mutex);
 		up(&g_free_fragments_sema);
 	}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd0c9f913940..a896461427a0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -89,7 +89,7 @@ static DEFINE_MUTEX(console_mutex);
  * console_sem protects updates to console->seq and console_suspended,
  * and also provides serialization for console printing.
  */
-static DEFINE_SEMAPHORE(console_sem);
+static DEFINE_MUTEX(console_sem);
 HLIST_HEAD(console_list);
 EXPORT_SYMBOL_GPL(console_list);
 DEFINE_STATIC_SRCU(console_srcu);
@@ -309,7 +309,7 @@ EXPORT_SYMBOL(console_srcu_read_unlock);
  * macros instead of functions so that _RET_IP_ contains useful information.
  */
 #define down_console_sem() do { \
-	down(&console_sem);\
+	mutex_lock(&console_sem);\
 	mutex_acquire(&console_lock_dep_map, 0, 0, _RET_IP_);\
 } while (0)
 
@@ -324,7 +324,7 @@ static int __down_trylock_console_sem(unsigned long ip)
 	 * deadlock in printk()->down_trylock_console_sem() otherwise.
 	 */
 	printk_safe_enter_irqsave(flags);
-	lock_failed = down_trylock(&console_sem);
+	lock_failed = !mutex_trylock(&console_sem);
 	printk_safe_exit_irqrestore(flags);
 
 	if (lock_failed)
@@ -341,7 +341,7 @@ static void __up_console_sem(unsigned long ip)
 	mutex_release(&console_lock_dep_map, ip);
 
 	printk_safe_enter_irqsave(flags);
-	up(&console_sem);
+	mutex_unlock(&console_sem);
 	printk_safe_exit_irqrestore(flags);
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
-- 
2.39.2
