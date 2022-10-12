Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC35FCCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJLVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJLVUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:20:06 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78F31CFC1;
        Wed, 12 Oct 2022 14:19:58 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Mnlsf5j9vzMq66Y;
        Wed, 12 Oct 2022 23:19:50 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Mnlsd6018zMppr6;
        Wed, 12 Oct 2022 23:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665609590;
        bh=jMT0lTl/kvSRcIMaFquNYDT6INl7FL1StAnorHHJrCg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=etGPN6gs/hRhjmsOO890PE5RQhNAu/OvHvWU1mU86bLHzxX77lXAUftysrEAxV6FD
         jqgID4zL7BeMnzX7OcUDD5XmzaqMtUJ6i8qWaBhqnyDSxVhAkPfldlsvtteDPtxHZ7
         SfFGeKhmO2JjJz40VHX5qy7rtPB5oIlHmk9QvZZY=
Message-ID: <13ab134b-e7a9-fe3f-a05a-7cece1d52403@digikod.net>
Date:   Wed, 12 Oct 2022 23:19:49 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v38 39/39] LSM: Create lsm_module_list system call
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927203155.15060-1-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220927203155.15060-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/09/2022 22:31, Casey Schaufler wrote:
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.

With lsm_self_attr(), this would look like a dir/file structure.

Would it be useful for user space to list all the currently used LSMs 
instead of only retrieving information about a known (list of) LSM?
What is the use case for this syscall?


> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>   include/linux/syscalls.h               |  1 +
>   include/uapi/asm-generic/unistd.h      |  5 ++-
>   kernel/sys_ni.c                        |  1 +
>   security/lsm_syscalls.c                | 50 ++++++++++++++++++++++++++
>   5 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 56d5c5202fd0..40b35e7069a7 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -373,6 +373,7 @@
>   449	common	futex_waitv		sys_futex_waitv
>   450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
>   451	common	lsm_self_attr		sys_lsm_self_attr
> +452	common	lsm_module_list		sys_lsm_module_list

As for the other syscall, this should also be in the same dedicated 
"wire syscalls" patch.


>   
>   #
>   # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 7f87ef8be546..e2e2a9e93e8c 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1057,6 +1057,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
>   					    unsigned long home_node,
>   					    unsigned long flags);
>   asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
> +asmlinkage long sys_lsm_module_list(unsigned int *ids, size_t *size, int flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index aa66718e1b48..090617a9a53a 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -889,8 +889,11 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>   #define __NR_lsm_self_attr 451
>   __SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)
>   
> +#define __NR_lsm_module_list 452
> +__SYSCALL(__NR_lsm_module_list, sys_lsm_module_list)
> +
>   #undef __NR_syscalls
> -#define __NR_syscalls 452
> +#define __NR_syscalls 453

Same here.


>   
>   /*
>    * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 0fdb0341251d..bde9e74a3473 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -264,6 +264,7 @@ COND_SYSCALL(mremap);
>   
>   /* security/lsm_syscalls.c */
>   COND_SYSCALL(lsm_self_attr);
> +COND_SYSCALL(lsm_module_list);
>   
>   /* security/keys/keyctl.c */
>   COND_SYSCALL(add_key);
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index da0fab7065e2..41d9ef945ede 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -154,3 +154,53 @@ SYSCALL_DEFINE3(lsm_self_attr,
>   	kfree(final);
>   	return rc;
>   }
> +
> +/**
> + * lsm_module_list - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_module_list,
> +	       unsigned int __user *, ids,
> +	       size_t __user *, size,
> +	       int, flags)
> +{
> +	unsigned int *interum;
> +	size_t total_size = lsm_id * sizeof(*interum);
> +	size_t usize;
> +	int rc;
> +	int i;
> +
> +	if (get_user(usize, size))
> +		return -EFAULT;
> +
> +	if (usize < total_size) {
> +		if (put_user(total_size, size) != 0)
> +			return -EFAULT;
> +		return -E2BIG;
> +	}
> +
> +	interum = kzalloc(total_size, GFP_KERNEL);
> +	if (interum == NULL)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lsm_id; i++)
> +		interum[i] = lsm_idlist[i]->id;
> +
> +	if (copy_to_user(ids, interum, total_size) != 0 ||
> +	    put_user(total_size, size) != 0)
> +		rc = -EFAULT;
> +	else
> +		rc = lsm_id;
> +
> +	kfree(interum);
> +	return rc;
> +}
