Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975A6DB12E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjDGRJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDGRJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:09:10 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2BFA5D5;
        Fri,  7 Apr 2023 10:09:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BE7D77E0AE8;
        Fri,  7 Apr 2023 17:09:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1691F7E1A96;
        Fri,  7 Apr 2023 17:09:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680887345; a=rsa-sha256;
        cv=none;
        b=0w37L2Bp273EsmJVRJNc6UPN+x7CvTtGXOa4DFAllCAZ9injSJyAopNK7er+OZ8JbKzNgn
        EYcllsOi9sIH8ppuYFb5BLNM4F7bSJBiIHYHNTL1XxJ3r90YjWJTZLN+e1dJfsAx7BBj5Y
        ih/D10HAWMISKTrn4as5+tAZMFtt+4DxjS5I7omG8rWJHWfsdWNMuTmw/KmUbATyf/cNNi
        W/EFR69xmkzxjpRUDxDdDR2uL5AX3CAU7gK0jpzQdpWmIoVQMsSp5heRdBSK5RYBm84oge
        sIzZWr8vKNloWrMzVu10eW9Sy3fZRZOjuAAxePrbwkG7eKrzC9h51A0qJj3l9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680887345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=d2aUmo3rJ5lUkyAT4XLlxLCXaIv9eNhVcZKrxYHkXcw=;
        b=mnQhqKK/vQTY9D8KzLGz4Fa9Y42Jn57E4bieQHL7kXil9Dzjd4swkoCqBlkoFHkEvIp2nJ
        vKasn1W8zS25r7zKFSwFc/UWgyLSf1Hy7l8vZizbBp3lptbziYWx4CqI7c4J8pXDIcpSAc
        w4LXGr1ooPhICB3dJateM6BifeQp84zMNYQrj+w5B3UytR6eDwvqA+7XnzuVR4w9SVW4DX
        RZ9CyhJ5uqPc2lP/AW4czS/ECFfIjG+Ed7YIGuFb4BjER2wBqCy9iWjmgSc1GvPQT25gqk
        2OCAL8Am95HXnyGsVGhBomN3kduHgXH+jWevl3ZglStd6TExAr8BF9OQ3y2jJA==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-5m8fq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Tasty: 353cd12f2cd8c1c0_1680887346628_3090312142
X-MC-Loop-Signature: 1680887346628:900449146
X-MC-Ingress-Time: 1680887346628
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.176 (trex/6.7.2);
        Fri, 07 Apr 2023 17:09:06 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4PtPwb2lCpz3j;
        Fri,  7 Apr 2023 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1680887344;
        bh=d2aUmo3rJ5lUkyAT4XLlxLCXaIv9eNhVcZKrxYHkXcw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=CHai2nVUs4T3eWku5z1nVgcCeVv8k4vtDKkM9mYh5UiUMQsnRXwPFPwFQRKCPNkSz
         RH4xNiIQFym6iIHvHRzU9u56moQONzB16F+nnS4PQO90jbpUo+cWy5/KvAnFnJGf0h
         7gz+Zr6EKGKhjP5Z3g0jqhgsqp5CYB8SPuTcvhQwzRNa2seVv6mnwcCb5akdT2iU5z
         8rbXMta7LFkn28gDkO163GZ31eWeotkUh0XE4TZbAS4uTqf8vjOBiE9Yao7xRQUJy6
         0tP80nSn1tCNzuWaSp4WNxNLLNV5jI5ZhdgLKCNrPfuYNWiBAGQD38o9w+4jvKZalp
         QFqarLb5LSUhg==
Date:   Fri, 7 Apr 2023 09:38:17 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 1/2] Change DEFINE_SEMAPHORE() to take a number
 argument
Message-ID: <20230407163817.laev7h7mxwtz72fh@offworld>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
References: <20230405203505.1343562-1-mcgrof@kernel.org>
 <20230405203505.1343562-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230405203505.1343562-2-mcgrof@kernel.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Luis Chamberlain wrote:

>From: Peter Zijlstra <peterz@infradead.org>
>
>Fundamentally semaphores are a counted primitive, but
>DEFINE_SEMAPHORE() does not expose this and explicitly creates a
>binary semaphore.
>
>Change DEFINE_SEMAPHORE() to take a number argument and use that in the
>few places that open-coded it using __SEMAPHORE_INITIALIZER().

No big deal considering the changelog is small, but I would have expected
just for __SEMAPHORE_INITIALIZER() to be used in the next patch, instead
of changing DEFINE_SEMAPHORE, which users just need because of the mutex
api restrictions.

>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>[mcgrof: add some tribal knowledge about why some folks prefer
> binary sempahores over mutexes]
>Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> arch/mips/cavium-octeon/setup.c                       |  2 +-
> arch/x86/kernel/cpu/intel.c                           |  2 +-
> drivers/firmware/efi/runtime-wrappers.c               |  2 +-
> drivers/firmware/efi/vars.c                           |  2 +-
> drivers/macintosh/adb.c                               |  2 +-
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c      |  2 +-
> drivers/platform/x86/intel/ifs/sysfs.c                |  2 +-
> drivers/scsi/esas2r/esas2r_ioctl.c                    |  2 +-
> .../vc04_services/interface/vchiq_arm/vchiq_arm.c     |  2 +-
> include/linux/semaphore.h                             | 11 +++++++++--
> kernel/printk/printk.c                                |  2 +-
> net/rxrpc/call_object.c                               |  6 ++----
> 12 files changed, 21 insertions(+), 16 deletions(-)
>
>diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
>index a71727f7a608..c5561016f577 100644
>--- a/arch/mips/cavium-octeon/setup.c
>+++ b/arch/mips/cavium-octeon/setup.c
>@@ -72,7 +72,7 @@ extern void pci_console_init(const char *arg);
> static unsigned long long max_memory = ULLONG_MAX;
> static unsigned long long reserve_low_mem;
>
>-DEFINE_SEMAPHORE(octeon_bootbus_sem);
>+DEFINE_SEMAPHORE(octeon_bootbus_sem, 1);
> EXPORT_SYMBOL(octeon_bootbus_sem);
>
> static struct octeon_boot_descriptor *octeon_boot_desc_ptr;
>diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>index 291d4167fab8..12bad63822f0 100644
>--- a/arch/x86/kernel/cpu/intel.c
>+++ b/arch/x86/kernel/cpu/intel.c
>@@ -1177,7 +1177,7 @@ static const struct {
> static struct ratelimit_state bld_ratelimit;
>
> static unsigned int sysctl_sld_mitigate = 1;
>-static DEFINE_SEMAPHORE(buslock_sem);
>+static DEFINE_SEMAPHORE(buslock_sem, 1);
>
> #ifdef CONFIG_PROC_SYSCTL
> static struct ctl_table sld_sysctls[] = {
>diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
>index 1fba4e09cdcf..a400c4312c82 100644
>--- a/drivers/firmware/efi/runtime-wrappers.c
>+++ b/drivers/firmware/efi/runtime-wrappers.c
>@@ -158,7 +158,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
>  * none of the remaining functions are actually ever called at runtime.
>  * So let's just use a single lock to serialize all Runtime Services calls.
>  */
>-static DEFINE_SEMAPHORE(efi_runtime_lock);
>+static DEFINE_SEMAPHORE(efi_runtime_lock, 1);
>
> /*
>  * Expose the EFI runtime lock to the UV platform
>diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
>index bd75b87f5fc1..bfc5fa6aa47b 100644
>--- a/drivers/firmware/efi/vars.c
>+++ b/drivers/firmware/efi/vars.c
>@@ -21,7 +21,7 @@
> /* Private pointer to registered efivars */
> static struct efivars *__efivars;
>
>-static DEFINE_SEMAPHORE(efivars_lock);
>+static DEFINE_SEMAPHORE(efivars_lock, 1);
>
> static efi_status_t check_var_size(bool nonblocking, u32 attributes,
>				   unsigned long size)
>diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
>index 23bd0c77ac1a..56599515d51a 100644
>--- a/drivers/macintosh/adb.c
>+++ b/drivers/macintosh/adb.c
>@@ -80,7 +80,7 @@ static struct adb_driver *adb_controller;
> BLOCKING_NOTIFIER_HEAD(adb_client_list);
> static int adb_got_sleep;
> static int adb_inited;
>-static DEFINE_SEMAPHORE(adb_probe_mutex);
>+static DEFINE_SEMAPHORE(adb_probe_mutex, 1);
> static int sleepy_trackpad;
> static int autopoll_devs;
> int __adb_probe_sync;
>diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
>index 5d1e4fe335aa..5a105bab4387 100644
>--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
>+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
>@@ -298,7 +298,7 @@ const u32 dmae_reg_go_c[] = {
>
> /* Global resources for unloading a previously loaded device */
> #define BNX2X_PREV_WAIT_NEEDED 1
>-static DEFINE_SEMAPHORE(bnx2x_prev_sem);
>+static DEFINE_SEMAPHORE(bnx2x_prev_sem, 1);
> static LIST_HEAD(bnx2x_prev_list);
>
> /* Forward declaration */
>diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
>index ee636a76b083..4c3c642ee19a 100644
>--- a/drivers/platform/x86/intel/ifs/sysfs.c
>+++ b/drivers/platform/x86/intel/ifs/sysfs.c
>@@ -13,7 +13,7 @@
>  * Protects against simultaneous tests on multiple cores, or
>  * reloading can file while a test is in progress
>  */
>-static DEFINE_SEMAPHORE(ifs_sem);
>+static DEFINE_SEMAPHORE(ifs_sem, 1);
>
> /*
>  * The sysfs interface to check additional details of last test
>diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
>index e003d923acbf..055d2e87a2c8 100644
>--- a/drivers/scsi/esas2r/esas2r_ioctl.c
>+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
>@@ -56,7 +56,7 @@ dma_addr_t esas2r_buffered_ioctl_addr;
> u32 esas2r_buffered_ioctl_size;
> struct pci_dev *esas2r_buffered_ioctl_pcid;
>
>-static DEFINE_SEMAPHORE(buffered_ioctl_semaphore);
>+static DEFINE_SEMAPHORE(buffered_ioctl_semaphore, 1);
> typedef int (*BUFFERED_IOCTL_CALLBACK)(struct esas2r_adapter *,
>				       struct esas2r_request *,
>				       struct esas2r_sg_context *,
>diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>index cddcd3c596c9..1a656fdc9445 100644
>--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>@@ -149,7 +149,7 @@ static char *g_fragments_base;
> static char *g_free_fragments;
> static struct semaphore g_free_fragments_sema;
>
>-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
>+static DEFINE_SEMAPHORE(g_free_fragments_mutex, 1);
>
> static int
> vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
>diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
>index 6694d0019a68..2d6aa3fd7861 100644
>--- a/include/linux/semaphore.h
>+++ b/include/linux/semaphore.h
>@@ -25,8 +25,15 @@ struct semaphore {
>	.wait_list	= LIST_HEAD_INIT((name).wait_list),		\
> }
>
>-#define DEFINE_SEMAPHORE(name)	\
>-	struct semaphore name = __SEMAPHORE_INITIALIZER(name, 1)
>+/*
>+ * There is a big difference between a binary semaphore and a mutex.
>+ * You cannot call mutex_unlock() from IRQ context because it takes an
>+ * internal mutex spin_lock in a non-IRQ-safe manner. Both try_lock()
>+ * and unlock() can be called from IRQ context. A mutex must also be
>+ * released in the same context that locked it.
>+ */
>+#define DEFINE_SEMAPHORE(_name, _n)	\
>+	struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
>
> static inline void sema_init(struct semaphore *sem, int val)
> {
>diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>index fd0c9f913940..76987aaa5a45 100644
>--- a/kernel/printk/printk.c
>+++ b/kernel/printk/printk.c
>@@ -89,7 +89,7 @@ static DEFINE_MUTEX(console_mutex);
>  * console_sem protects updates to console->seq and console_suspended,
>  * and also provides serialization for console printing.
>  */
>-static DEFINE_SEMAPHORE(console_sem);
>+static DEFINE_SEMAPHORE(console_sem, 1);
> HLIST_HEAD(console_list);
> EXPORT_SYMBOL_GPL(console_list);
> DEFINE_STATIC_SRCU(console_srcu);
>diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
>index e9f1f49d18c2..3e5cc70884dd 100644
>--- a/net/rxrpc/call_object.c
>+++ b/net/rxrpc/call_object.c
>@@ -40,10 +40,8 @@ const char *const rxrpc_call_completions[NR__RXRPC_CALL_COMPLETIONS] = {
>
> struct kmem_cache *rxrpc_call_jar;
>
>-static struct semaphore rxrpc_call_limiter =
>-	__SEMAPHORE_INITIALIZER(rxrpc_call_limiter, 1000);
>-static struct semaphore rxrpc_kernel_call_limiter =
>-	__SEMAPHORE_INITIALIZER(rxrpc_kernel_call_limiter, 1000);
>+static DEFINE_SEMAPHORE(rxrpc_call_limiter, 1000);
>+static DEFINE_SEMAPHORE(rxrpc_kernel_call_limiter, 1000);
>
> void rxrpc_poke_call(struct rxrpc_call *call, enum rxrpc_call_poke_trace what)
> {
>--
>2.39.2
>
