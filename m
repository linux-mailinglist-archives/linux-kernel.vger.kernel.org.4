Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E1663761
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbjAJCc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbjAJCcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93C186B3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 18:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673317897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4pDScTzr044fid5IxxgLVOMm3Ad+S8xw5b7m85GqnJE=;
        b=CUMacmzvkLsCV5LeWFeAEctEvXan9xXtJKMc4lq/nnG+RrFnT50NBx7eQ6verO5+mMXkuG
        w3OcRT/sJi0dMufqlwE8vT0cTk11j4OQMN9LysTE1UiBxPbdAkeVH3hi5XQ3XAcGJZrD3v
        fqfk/Pl10ccSy27tvNwqoBHfUSIf108=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-3WkSLzr1P7uSJtRaYyYiaA-1; Mon, 09 Jan 2023 21:31:33 -0500
X-MC-Unique: 3WkSLzr1P7uSJtRaYyYiaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48FD680234E;
        Tue, 10 Jan 2023 02:31:33 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F21E02026D4B;
        Tue, 10 Jan 2023 02:31:30 +0000 (UTC)
Date:   Tue, 10 Jan 2023 10:31:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Petr Tesarik <petr@tesarici.cz>, kexec@lists.infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@kernel.org>
Subject: Re: [PATCH v6 3/3] kexec: Introduce sysctl parameters
 kexec_load_limit_*
Message-ID: <Y7zN/zDnCAsZ+KLO@fedora>
References: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
 <20221114-disable-kexec-reset-v6-3-6a8531a09b9a@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114-disable-kexec-reset-v6-3-6a8531a09b9a@chromium.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/23 at 03:38pm, Ricardo Ribalda wrote:
> kexec allows replacing the current kernel with a different one. This is
> usually a source of concerns for sysadmins that want to harden a system.
> 
> Linux already provides a way to disable loading new kexec kernel via
> kexec_load_disabled, but that control is very coard, it is all or
> nothing and does not make distinction between a panic kexec and a
> normal kexec.
> 
> This patch introduces new sysctl parameters, with finner tunning to
> specify how many times a kexec kernel can be loaded. The sysadmin can
> set different limits for kexec panic and kexec reboot kernels. The
> value can be modified at runtime via sysctl, but only with a stricter
> value.
> 
> With these new parameters on place, a system with loadpin and verity
> enabled, using the following kernel parameters:
> sysctl.kexec_load_limit_reboot=0 sysct.kexec_load_limit_panic=1
> can have a good warranty that if initrd tries to load a panic kernel,
> a malitious user will have small chances to replace that kernel with a
> different one, even if they can trigger timeouts on the disk where the
> panic kernel lives.

This log is much clearer, thanks for the effort. I guess distros won't
set these two knobs, while customers can make use of them to enhance the
security. E.g on production environment, peopel are more concerned about
kernel panic and getting vmcore. so they can set
'sysctl.kexec_load_limit_reboot=0 sysct.kexec_load_limit_panic=1'. Thus,
they can be suggested to customers.

Guess this is not urgent fix.

> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
> index 97394bd9d065..d5fb4b6ef405 100644
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
> +== ======================================================
> +-1 Unlimited calls to kexec. This is the default setting.
> +N  Number of calls left.
> +== ======================================================
> +
> +kexec_load_limit_reboot
> +=======================
> +
> +Similar functionality as ``kexec_load_limit_panic``, but for a normal
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
> index 29efa43ea951..70e1e99038ee 100644
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
> +	if (!kexec_load_permitted(image_type))
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

