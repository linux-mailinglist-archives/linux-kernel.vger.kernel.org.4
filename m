Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050236CD1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjC2Fqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjC2Fq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:46:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C856A2127;
        Tue, 28 Mar 2023 22:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4361E618A6;
        Wed, 29 Mar 2023 05:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D43EC433D2;
        Wed, 29 Mar 2023 05:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680068784;
        bh=8fFU5kQOTeWdxd4ArzXKxbPdX+xWPqKjjB5BunJ/kq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YagHrNkk9RhqYdv9JtmPBrpRhmrJItBxcfMzCp+C+Xii9kTK3UQyw4SIZV0vP5YrJ
         fzX06H+ru5EhB+2v0+tWWdD4+0rGHtZa37VIdh+uQPo+NS0d2JWO5JyNmqQ8zzwAeK
         fgNAZEkodp8FJfR/Xkwpl/11SYNumWb21jg2x7Xw=
Date:   Wed, 29 Mar 2023 07:46:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH 7/7] module: add debug stats to help identify memory
 pressure
Message-ID: <ZCPQrouSMQbFc8D0@kroah.com>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329053149.3976378-8-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:31:49PM -0700, Luis Chamberlain wrote:
> Loading modules with finit_module() can end up using vmalloc(), vmap()
> and vmalloc() again, for a total of up to 3 separate allocations in the
> worse case for a single module. We always kernel_read*() the module,
> that's a vmalloc(). Then vmap() is used for the module decompression,
> and if so the last read buffer is freed as we use the now decompressed
> module buffer to stuff data into our copy module. The last one is
> specific to architectures but pretty much that's generally a series
> of vmalloc() for different ELF sections...
> 
> Evaluation with new stress-ng module support [1] with just 100 ops
> us proving that you can end up using GiBs of data easily even if
> we are trying to be very careful not to load modules which are already
> loaded. 100 ops seems to resemble the sort of pressure a system with
> about 400 CPUs can create on modules. Although those issues for so
> many concurrent loads per CPU is silly and are being fixed, we lack
> proper tooling to help diagnose easily what happened, when it happened
> and what likely are the culprits -- userspace or kernel module
> autoloading.
> 
> Provide an initial set of stats for debugfs which let us easily scrape
> post-boot information about failed loads. This sort of information can
> be used on production worklaods to try to optimize *avoiding* redundant
> memory pressure using finit_module().
> 
> Screen shot:
> 
> root@kmod ~ # cat /sys/kernel/debug/modules/stats
>            Modules loaded       67

Is this "loaded now", or "ever successfully loaded"?  As in a
modprobe/rmmod/modprobe would bump this by 2, right?

Anyway, minor comment on the code, this looks overall great to me:


>         Total module size       11464704
>       Total mod text size       4194304
>        Failed kread bytes       890064
>         Failed kmod bytes       890064
>       Invalid kread bytes       890064
>  Invalid decompress bytes       0
>         Invalid mod bytes       890064
>          Average mod size       171115
>     Average mod text size       62602
> Failed modules:
>                 kvm_intel
>                       kvm
>                 irqbypass
>          crct10dif_pclmul
>       ghash_clmulni_intel
>              sha512_ssse3
>            sha512_generic
>               aesni_intel
>               crypto_simd
>                    cryptd
>                     evdev
>                 serio_raw
>                virtio_pci
>                      nvme
>                 nvme_core
>     virtio_pci_legacy_dev
>                    t10_pi
>            crc64_rocksoft
>     virtio_pci_modern_dev
>              crc32_pclmul
>                    virtio
>              crc32c_intel
>               virtio_ring
>                     crc64
> 
> [0] https://github.com/ColinIanKing/stress-ng.git
> [1] echo 0 > /proc/sys/vm/oom_dump_tasks
>     ./stress-ng --module 100 --module-name xfs
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/module/Kconfig    |  32 +++++++
>  kernel/module/Makefile   |   4 +
>  kernel/module/debug.c    |  16 ++++
>  kernel/module/internal.h |  35 +++++++
>  kernel/module/main.c     |  45 ++++++++-
>  kernel/module/stats.c    | 200 +++++++++++++++++++++++++++++++++++++++
>  kernel/module/tracking.c |   7 +-
>  7 files changed, 331 insertions(+), 8 deletions(-)
>  create mode 100644 kernel/module/debug.c
>  create mode 100644 kernel/module/stats.c
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 424b3bc58f3f..fbf7b92cb3d0 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -22,6 +22,12 @@ menuconfig MODULES
>  
>  if MODULES
>  
> +config MODULE_DEBUG
> +	bool "Module debugging"
> +	default n

default is always "n", no need to set that specifically.

> +	help
> +	  Allows to help debug module functionality.

Might want to make this a bit more verbose.

>  config MODULE_FORCE_LOAD
>  	bool "Forced module loading"
>  	default n
> @@ -48,6 +54,8 @@ config MODULE_FORCE_UNLOAD
>  	  rmmod).  This is mainly for kernel developers and desperate users.
>  	  If unsure, say N.
>  
> +if MODULE_DEBUG
> +
>  config MODULE_UNLOAD_TAINT_TRACKING
>  	bool "Tainted module unload tracking"
>  	depends on MODULE_UNLOAD
> @@ -59,6 +67,30 @@ config MODULE_UNLOAD_TAINT_TRACKING
>  	  page (see bad_page()), the aforementioned details are also
>  	  shown. If unsure, say N.
>  
> +config MODULE_STATS
> +	bool "Module statistics"
> +	depends on DEBUG_FS
> +	default n

Again, already default.


> +	help
> +	  This option allows you to maintain a record of module statistics.
> +	  For example each all modules size, average size, text size, and
> +	  failed modules and the size for each of those. For failed
> +	  modules we keep track of module which failed due to either the
> +	  existing module taking too long to load or that module already
> +	  was loaded.
> +
> +	  You should enable this if you are debugging production loads
> +	  and want to see if userspace or the kernel is doing stupid things
> +	  with loading modules when it shouldn't or if you want to help
> +	  optimize userspace / kernel space module autoloading schemes.
> +	  You might want to do this because failed modules tend to use
> +	  use up significan amount of memory, and so you'd be doing everyone
> +	  a favor in avoiding these failure proactively.
> +
> +	  If unsure, say N.
> +
> +endif # MODULE_DEBUG
> +
>  config MODVERSIONS
>  	bool "Module versioning support"
>  	help
> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> index 5b1d26b53b8d..fe97047f3807 100644
> --- a/kernel/module/Makefile
> +++ b/kernel/module/Makefile
> @@ -20,4 +20,8 @@ obj-$(CONFIG_PROC_FS) += procfs.o
>  obj-$(CONFIG_SYSFS) += sysfs.o
>  obj-$(CONFIG_KGDB_KDB) += kdb.o
>  obj-$(CONFIG_MODVERSIONS) += version.o
> +
> +# Link order matters here, keep debug.o first.
> +obj-$(CONFIG_MODULE_DEBUG) += debug.o
> +obj-$(CONFIG_MODULE_STATS) += stats.o
>  obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
> diff --git a/kernel/module/debug.c b/kernel/module/debug.c
> new file mode 100644
> index 000000000000..ef580d70b751
> --- /dev/null
> +++ b/kernel/module/debug.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
> + */
> +
> +#include <linux/debugfs.h>
> +#include "internal.h"
> +
> +struct dentry *mod_debugfs_root;
> +
> +static int module_debugfs_init(void)
> +{
> +	mod_debugfs_root = debugfs_create_dir("modules", NULL);
> +	return 0;
> +}
> +module_init(module_debugfs_init);

Why is this a whole separate file?

And as MODULE_DEBUG does not reference debugfs, yet it still creates the
debugfs directory here?  Yes, it will just not do anything if debugfs is
not enabled, but then why is this file here?

> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 6ae29bb8836f..a645cb3fafc7 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -143,6 +143,41 @@ static inline bool set_livepatch_module(struct module *mod)
>  #endif
>  }
>  
> +#ifdef CONFIG_MODULE_STATS
> +
> +#define mod_stat_add64(count, var) atomic64_add(count, var)
> +#define mod_stat_inc(name) atomic_inc(name)

Ok, but:

> +
> +extern atomic64_t total_mod_size;
> +extern atomic64_t total_text_size;
> +extern atomic64_t invalid_kread_bytes;
> +extern atomic64_t invalid_decompress_bytes;
> +extern atomic64_t invalid_mod_becoming_bytes;
> +extern atomic64_t invalid_mod_bytes;
> +
> +extern atomic_t modcount;
> +extern atomic_t failed_kreads;
> +extern atomic_t failed_decompress;
> +extern atomic_t failed_load_modules;
> +struct mod_fail_load {
> +	struct list_head list;
> +	char name[MODULE_NAME_LEN];
> +	atomic_t count;
> +};
> +
> +int try_add_failed_module(const char *name);
> +
> +#else
> +
> +#define mod_stat_inc64(name)
> +#define mod_stat_inc(name) atomic_inc(name)

Why do you still increment the variable here if the option is not
enabled?

Also, didn't we have some sort of "we want to use an atomic variable as
statistics" type somewhere in the kernel?  Or did that never get
accepted?

And do all of these really need to be atomic variables?  Don't you have
locks for some of this to not need the atomic-ness of them?  I guess it
doesn't matter much as this isn't that fast of a code-path.

thanks,

greg k-h
