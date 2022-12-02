Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1A76410F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiLBW6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiLBW6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:58:17 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77227EC092
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:58:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f9so5536061pgf.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 14:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upaT+sdu1PUgCY4O0p9/7LkD8IOLMCcZDugjWhKNlK4=;
        b=l85jUC/DqAPZvEYgUIpIrLCQteerGjMuSO76KqAaSQDY0PqxFHi4Ujln2i36MQXwbg
         04evTFkxS6+1jBOHt9FyVbJqSCWEQ6Jqb3030s1YMyMW1+RAQ0gWDaeTmUKQetK/p3M1
         Nvper3R+yLsGqi6HoDD5kYNVQrjgQ1dKZhRPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upaT+sdu1PUgCY4O0p9/7LkD8IOLMCcZDugjWhKNlK4=;
        b=pme+pr74c8uNnqTAcw31q7oSmJJp6D1YpkLKRLyZParq3Dn/GSt1iQbXowzmKoBJ5p
         s0OGLQMsNgK9OS0Z+Rg17TTGymakXxTzjx+EO1XNXktD8/2NmE/ABrqahwA/ycM0vUkl
         o8PeFFgRyFZOFj85GbPlfg8NIK8f2awuf8FvSadDFY3W5+7TezW/rHevS8j/ZCZNbLhK
         sj39m5V2LyyoeEGRewCBmOp5pC3Lq1QMyCloNhY+k6vOspthONWrl1/YAlct/PlTD/SR
         ng+Q8nYMo4pAQGqJcdpD7yeNv6wcWNWkXia8ObH4duKpdekZdO44sLSof4x/1S0th/b+
         HVjw==
X-Gm-Message-State: ANoB5pk1LERiDTiOC15PBy/jcupZ8LuC52D9N41yMCmOkS3VExoYMnZ6
        rO6e36lqANCvkB/VrunihXbvFA==
X-Google-Smtp-Source: AA0mqf58I2M3EjTdP3Dmy0wD9kMeMByx5zT7S4bmeYzFJKYUTETvLZG6hfKOhPTmoEmqClAr5nPKaQ==
X-Received: by 2002:a63:e442:0:b0:477:bfab:5a81 with SMTP id i2-20020a63e442000000b00477bfab5a81mr39813306pgk.64.1670021895014;
        Fri, 02 Dec 2022 14:58:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b00189ac5a2340sm5754875pln.124.2022.12.02.14.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:58:14 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:58:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] mm/memfd: security hook for memfd_create
Message-ID: <202212021457.EC46B27677@keescook>
References: <20221202013404.163143-1-jeffxu@google.com>
 <20221202013404.163143-6-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202013404.163143-6-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:34:03AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> The new security_memfd_create allows lsm to check flags of
> memfd_create.
> 
> The security by default system (such as chromeos) can use this
> to implement system wide lsm to allow only non-executable memfd
> being created.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  include/linux/lsm_hook_defs.h | 1 +
>  include/linux/lsm_hooks.h     | 4 ++++
>  include/linux/security.h      | 6 ++++++
>  mm/memfd.c                    | 5 +++++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ec119da1d89b..fd40840927c8 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -164,6 +164,7 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
> +LSM_HOOK(int, 0, memfd_create, char *name, unsigned int flags)
>  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
>  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
>  	 unsigned long prot, unsigned long flags)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..5a18a6552278 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -543,6 +543,10 @@
>   *	simple integer value.  When @arg represents a user space pointer, it
>   *	should never be used by the security module.
>   *	Return 0 if permission is granted.
> + * @memfd_create:
> + *	@name is the name of memfd file.
> + *	@flags is the flags used in memfd_create.
> + *	Return 0 if permission is granted.
>   * @mmap_addr :
>   *	Check permissions for a mmap operation at @addr.
>   *	@addr contains virtual address that will be used for the operation.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ca1b7109c0db..5b87a780822a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -384,6 +384,7 @@ int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +int security_memfd_create(char *name, unsigned int flags);
>  int security_mmap_file(struct file *file, unsigned long prot,
>  			unsigned long flags);
>  int security_mmap_addr(unsigned long addr);
> @@ -963,6 +964,11 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
>  	return 0;
>  }
>  
> +static inline int security_memfd_create(char *name, unsigned int flags)
> +{
> +	return 0;
> +}

I think this is missing the security/security.c changes for the
non-inline version?

-Kees

> +
>  static inline int security_mmap_file(struct file *file, unsigned long prot,
>  				     unsigned long flags)
>  {
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 69e897dea6d5..96dcfbfed09e 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -346,6 +346,11 @@ SYSCALL_DEFINE2(memfd_create,
>  		goto err_name;
>  	}
>  
> +	/* security hook for memfd_create */
> +	error = security_memfd_create(name, flags);
> +	if (error)
> +		return error;
> +
>  	if (flags & MFD_HUGETLB) {
>  		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
>  					HUGETLB_ANONHUGE_INODE,
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 

-- 
Kees Cook
