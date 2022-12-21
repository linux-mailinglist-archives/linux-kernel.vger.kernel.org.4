Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12998652A73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiLUAWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiLUAWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:22:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10677F583;
        Tue, 20 Dec 2022 16:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 972AF61629;
        Wed, 21 Dec 2022 00:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA947C433EF;
        Wed, 21 Dec 2022 00:22:09 +0000 (UTC)
Date:   Tue, 20 Dec 2022 19:22:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH v3 3/3] kexec: Introduce parameters load_limit_reboot
 and load_limit_panic
Message-ID: <20221220192208.4d0c934f@gandalf.local.home>
In-Reply-To: <20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org>
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
        <20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 23:05:45 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

I hate to be the grammar police, but..

> Add two parameter to specify how many times a kexec kernel can be loaded.

   "parameters"

> 
> The sysadmin can set different limits for kexec panic and kexec reboot
> kernels.
> 
> The value can be modified at runtime via sysfs, but only with a value
> smaller than the current one (except -1).
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++
>  include/linux/kexec.h                           |  2 +-
>  kernel/kexec.c                                  |  2 +-
>  kernel/kexec_core.c                             | 91 ++++++++++++++++++++++++-
>  kernel/kexec_file.c                             |  2 +-
>  5 files changed, 106 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 42af9ca0127e..2b37d6a20747 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2374,6 +2374,20 @@
>  			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
>  			are exclusive, so you cannot specify multiple forms.
>  
> +	kexec_core.load_limit_reboot=
> +	kexec_core.load_limit_panic=
> +			[KNL]
> +			This parameter specifies a limit to the number of times
> +			a kexec kernel can be loaded.
> +			Format: <int>
> +			-1  = Unlimited.
> +			int = Number of times kexec can be called.
> +
> +			During runtime, this parameter can be modified with a

> +			value smaller than the current one (but not -1).

Perhaps state:
			smaller positive value than the current one or if
			current is currently -1.

> +
> +			Default: -1
> +
>  	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
>  			Format: <Controller#>[,poll interval]
>  			The controller # is the number of the ehci usb debug
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 182e0c11b87b..5daf9990d5b8 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>  extern struct kimage *kexec_image;
>  extern struct kimage *kexec_crash_image;
>  
> -bool kexec_load_permitted(void);
> +bool kexec_load_permitted(bool crash_image);
>  
>  #ifndef kexec_flush_icache_page
>  #define kexec_flush_icache_page(page)
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index ce1bca874a8d..7aefd134e319 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	int result;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!kexec_load_permitted())
> +	if (!kexec_load_permitted(flags & KEXEC_ON_CRASH))

Note, here we have KEXEC_ON_CRASH (see bottom).

>  		return -EPERM;
>  
>  	/* Permit LSMs and IMA to fail the kexec */
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index a1efc70f4158..adf71f2be3ff 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
>  late_initcall(kexec_core_sysctl_init);
>  #endif
>  
> -bool kexec_load_permitted(void)
> +struct kexec_load_limit {
> +	/* Mutex protects the limit count. */
> +	struct mutex mutex;
> +	int limit;
> +};
> +
> +struct kexec_load_limit load_limit_reboot = {

Perhaps make the above static?

> +	.mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
> +	.limit = -1,
> +};
> +
> +struct kexec_load_limit load_limit_panic = {

static?

> +	.mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
> +	.limit = -1,
> +};
> +
> +static int param_get_limit(char *buffer, const struct kernel_param *kp)
>  {
> +	int ret;
> +	struct kexec_load_limit *limit = kp->arg;

Looks better if "int ret;" is after the "limit".

> +
> +	mutex_lock(&limit->mutex);
> +	ret = scnprintf(buffer, PAGE_SIZE, "%i\n", limit->limit);

The above string can be at most "-2147483648\n\0"

Which is 13 characters. Why use PAGE_SIZE. Or scnprintf(), and not just
state:

	/* buffer is PAGE_SIZE, much larger than what %i can be */
	ret = sprintf(buffer, "%i\n", limit->limit);

> +	mutex_unlock(&limit->mutex);
> +
> +	return ret;
> +}
> +
> +static int param_set_limit(const char *buffer, const struct kernel_param *kp)
> +{
> +	int ret;
> +	struct kexec_load_limit *limit = kp->arg;
> +	int new_val;
> +
> +	ret = kstrtoint(buffer, 0, &new_val);
> +	if (ret)
> +		return ret;
> +
> +	new_val = max(-1, new_val);

I wonder if anything less than -1 should be invalid.

> +
> +	mutex_lock(&limit->mutex);
> +
> +	if (new_val == -1 && limit->limit != -1) {

If -1 can't change the value, why allow it to be passed in to begin with.

Perhaps we should only allow sysctl to set positive values? Would make the
code simpler.

> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	if (limit->limit != -1 && new_val > limit->limit) {

Since the above documentation said "small than" perhaps ">="?

> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	limit->limit = new_val;
> +
> +done:
> +	mutex_unlock(&limit->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct kernel_param_ops load_limit_ops = {
> +	.get = param_get_limit,
> +	.set = param_set_limit,
> +};
> +
> +module_param_cb(load_limit_reboot, &load_limit_ops, &load_limit_reboot, 0644);
> +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec reboot kernel");
> +
> +module_param_cb(load_limit_panic, &load_limit_ops, &load_limit_panic, 0644);
> +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec panic kernel");

Wait, why the module params if this can not be a module?

The kernel/kexec.c is decided via CONFIG_KEXEC_CORE which is bool. Either
builtin or not at all. No module selection possible.

For kernel parameters, we should just use __setup(), right?

> +
> +bool kexec_load_permitted(bool crash_image)
> +{
> +	struct kexec_load_limit *limit;
> +
>  	/*
>  	 * Only the superuser can use the kexec syscall and if it has not
>  	 * been disabled.
>  	 */
> -	return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
> +	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> +		return false;
> +
> +	/* Check limit counter and decrease it.*/
> +	limit = crash_image ? &load_limit_panic : &load_limit_reboot;
> +	mutex_lock(&limit->mutex);
> +	if (!limit->limit) {
> +		mutex_unlock(&limit->mutex);
> +		return false;
> +	}
> +	if (limit->limit != -1)
> +		limit->limit--;
> +	mutex_unlock(&limit->mutex);
> +
> +	return true;
>  }
>  
>  /*
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 29efa43ea951..6a1d4b07635e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	struct kimage **dest_image, *image;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!kexec_load_permitted())
> +	if (!kexec_load_permitted(flags & KEXEC_FILE_FLAGS))

Here we have KEXEC_FILE_FLAGS, where above it was KEXCE_FILE_CRASH.

This is confusing to what denotes the "crash_image" boolean. Can we just
pass in flags and figure it out in the kexec_load_permitted() function?

-- Steve


>  		return -EPERM;
>  
>  	/* Make sure we have a legal set of flags */
> 

