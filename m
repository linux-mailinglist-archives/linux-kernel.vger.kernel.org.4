Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483E7653AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiLVCuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiLVCuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:50:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99E1B79B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671677379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kThFGykb7MnuCuNb2lJR0gBltHWCcpSBG2QAsyZbZJs=;
        b=OxedUSOo615OvJi6ycC4ex69wAxGs3RZqUh2O470akN4v0o7IrPTerUl2LqIDSGiNWRCFU
        cIMvzz1/zC70WrTWefEj96F0AE2UNpm4bSImomMX895iZJXA3++Vetrm9F3zJLplpokIp3
        AigEPrncKp3gOuadvQjflSB2yGSBTC4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-kB93dcHHPIaFnaKmHsVXKg-1; Wed, 21 Dec 2022 21:49:36 -0500
X-MC-Unique: kB93dcHHPIaFnaKmHsVXKg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B98729A9D42;
        Thu, 22 Dec 2022 02:49:35 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20E1F492C14;
        Thu, 22 Dec 2022 02:49:33 +0000 (UTC)
Date:   Thu, 22 Dec 2022 10:49:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Rudo <prudo@redhat.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kexec@lists.infradead.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] kexec: Introduce sysctl parameters
 kexec_load_limit_*
Message-ID: <Y6PFugKAUckXXpvi@MiWiFi-R3L-srv>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
 <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/21/22 at 08:45pm, Ricardo Ribalda wrote:
> Add two parameters to specify how many times a kexec kernel can be loaded.
> 
> The sysadmin can set different limits for kexec panic and kexec reboot
> kernels.
> 
> The value can be modified at runtime via sysctl, but only with a value
> smaller than the current one (except -1).

This patch is not complex, and doens't add code complexity. And from
code comment and document, we can easily know how the new toggles can be
used. BUT I am wondering if everybody have got why they are needed, and
where or when they are needed and will be used, except of stupid me. 

We have had a toggle kexec_load_disabled which can be used to close the
door before alread loading image. Now we want another two toggles to
guard how many times we can flip the door. I am not familiar with
kernel security policy, is it not safe to provide details in log? If so,
please ignore this mail.

In fact, my concern is that in the future, if a new user of kexec/kdump
want to know why these two knobs are added, while can't get any helpful
information from commit message. If she/he asks me, I can only shrug. Up
to now, I don't know what real use case these two toggles are used for,
why they have to be added. And the default value of them are '-1', how
will we make use of them in distros? What's the suggested value? Or '-1'
is the suggested value, you just use them in some cornor case on some
mysterious system?

Just saying we want to add some new useful stuffs, that's it. Frankly
speaking, w/o special reason, this is not the way we are supposed to add
new stuffs into kernel. 

Thanks
Baoquan

> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 18 ++++++
>  include/linux/kexec.h                       |  2 +-
>  kernel/kexec.c                              |  4 +-
>  kernel/kexec_core.c                         | 87 ++++++++++++++++++++++++++++-
>  kernel/kexec_file.c                         | 11 ++--
>  5 files changed, 114 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 97394bd9d065..a3922dffbd47 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -461,6 +461,24 @@ allowing a system to set up (and later use) an image without it being
>  altered.
>  Generally used together with the `modules_disabled`_ sysctl.
>  
> +kexec_load_limit_panic
> +======================
> +
> +This parameter specifies a limit to the number of times the syscalls
> +``kexec_load`` and ``kexec_file_load`` can be called with a crash
> +image. It can only be set with a more restrictive value than the
> +current one.
> +
> +=  =============================================================
> +-1 Unlimited calls to kexec. This is the default setting.
> +N  Number of calls left.
> +=  =============================================================
> +
> +kexec_load_limit_reboot
> +======================
> +
> +Similar functionality as ``kexec_load_limit_panic``, but for a crash
> +image.
>  
>  kptr_restrict
>  =============
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 182e0c11b87b..791e65829f86 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>  extern struct kimage *kexec_image;
>  extern struct kimage *kexec_crash_image;
>  
> -bool kexec_load_permitted(void);
> +bool kexec_load_permitted(int kexec_image_type);
>  
>  #ifndef kexec_flush_icache_page
>  #define kexec_flush_icache_page(page)
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index ce1bca874a8d..92d301f98776 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -190,10 +190,12 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
> +	int image_type = (flags & KEXEC_ON_CRASH) ?
> +			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>  	int result;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!kexec_load_permitted())
> +	if (!kexec_load_permitted(image_type))
>  		return -EPERM;
>  
>  	/* Permit LSMs and IMA to fail the kexec */
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index a1efc70f4158..951541d78ca8 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -926,10 +926,64 @@ int kimage_load_segment(struct kimage *image,
>  	return result;
>  }
>  
> +struct kexec_load_limit {
> +	/* Mutex protects the limit count. */
> +	struct mutex mutex;
> +	int limit;
> +};
> +
> +static struct kexec_load_limit load_limit_reboot = {
> +	.mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
> +	.limit = -1,
> +};
> +
> +static struct kexec_load_limit load_limit_panic = {
> +	.mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
> +	.limit = -1,
> +};
> +
>  struct kimage *kexec_image;
>  struct kimage *kexec_crash_image;
>  static int kexec_load_disabled;
> +
>  #ifdef CONFIG_SYSCTL
> +static int kexec_limit_handler(struct ctl_table *table, int write,
> +			       void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct kexec_load_limit *limit = table->data;
> +	int val;
> +	struct ctl_table tmp = {
> +		.data = &val,
> +		.maxlen = sizeof(val),
> +		.mode = table->mode,
> +	};
> +	int ret;
> +
> +	if (write) {
> +		ret = proc_dointvec(&tmp, write, buffer, lenp, ppos);
> +		if (ret)
> +			return ret;
> +
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		mutex_lock(&limit->mutex);
> +		if (limit->limit != -1 && val >= limit->limit)
> +			ret = -EINVAL;
> +		else
> +			limit->limit = val;
> +		mutex_unlock(&limit->mutex);
> +
> +		return ret;
> +	}
> +
> +	mutex_lock(&limit->mutex);
> +	val = limit->limit;
> +	mutex_unlock(&limit->mutex);
> +
> +	return proc_dointvec(&tmp, write, buffer, lenp, ppos);
> +}
> +
>  static struct ctl_table kexec_core_sysctls[] = {
>  	{
>  		.procname	= "kexec_load_disabled",
> @@ -941,6 +995,18 @@ static struct ctl_table kexec_core_sysctls[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "kexec_load_limit_panic",
> +		.data		= &load_limit_panic,
> +		.mode		= 0644,
> +		.proc_handler	= kexec_limit_handler,
> +	},
> +	{
> +		.procname	= "kexec_load_limit_reboot",
> +		.data		= &load_limit_reboot,
> +		.mode		= 0644,
> +		.proc_handler	= kexec_limit_handler,
> +	},
>  	{ }
>  };
>  
> @@ -952,13 +1018,30 @@ static int __init kexec_core_sysctl_init(void)
>  late_initcall(kexec_core_sysctl_init);
>  #endif
>  
> -bool kexec_load_permitted(void)
> +bool kexec_load_permitted(int kexec_image_type)
>  {
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
> +	limit = (kexec_image_type == KEXEC_TYPE_CRASH) ?
> +		&load_limit_panic : &load_limit_reboot;
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
> index 29efa43ea951..da9cfbbb0cbd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -326,11 +326,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
>  		unsigned long, flags)
>  {
> -	int ret = 0, i;
> +	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
> +			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>  	struct kimage **dest_image, *image;
> +	int ret = 0, i;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!kexec_load_permitted())
> +	if (!kexec_load_permitted(flags & KEXEC_FILE_ON_CRASH))
>  		return -EPERM;
>  
>  	/* Make sure we have a legal set of flags */
> @@ -342,11 +344,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (!kexec_trylock())
>  		return -EBUSY;
>  
> -	dest_image = &kexec_image;
> -	if (flags & KEXEC_FILE_ON_CRASH) {
> +	if (image_type == KEXEC_TYPE_CRASH) {
>  		dest_image = &kexec_crash_image;
>  		if (kexec_crash_image)
>  			arch_kexec_unprotect_crashkres();
> +	} else {
> +		dest_image = &kexec_image;
>  	}
>  
>  	if (flags & KEXEC_FILE_UNLOAD)
> 
> -- 
> 2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

