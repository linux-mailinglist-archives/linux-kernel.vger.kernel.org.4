Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2C5F38FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJCW1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJCW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:27:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2C5D0FA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 15:23:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h10so8183542plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=z1/2plwrXjBAn1kAQlG8HZaZ4O1cAMi4uWpIyecb3WY=;
        b=fL7uVv5uocG4gFvRiRzu57UBR+Y+hOjSt1rMC9dMipp0dZgJYkPj5efzAvlOD26mpe
         f++eXumz+X91j0ZagKBWZTHo8Kl7b3zELSamfhfgQ+F7k426k2hwkZHBxmeLHXs8rtPR
         aGOXykeUS0F0d6SIzP4G+ZZ+bPrCLDt8t7s+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=z1/2plwrXjBAn1kAQlG8HZaZ4O1cAMi4uWpIyecb3WY=;
        b=Zdpymls7t0hMGN6Wkk8Rc1G2yBxNrLxEomltvfbsKP1C8nxefuVmz40DdwMqBOqrri
         y6/GcjlOeopFtQ8j+uRo6jQJafDzrgXMXQr82IbvgVCkAk2wudWGDtQCG+/63tsRY7ZH
         hlnMlo7Pu3d9Xmfi/5hn7PbQ3TjbKMiCQgFq9bXaC3beO0B+W/oY548MiNMhR7/rSatl
         QacN7D8FQ+eNkxUjKYOzHIIXXXVVBAtvaBaT1OsCcTO10TIFOm1fBP4L+Ien2pFGHFhP
         UBnXWIzGmwLo0HuTwR1Uf+cXF8hhcikSO8Cx18wOhKzMZq0ytLsYr5KZQTNIYGFPwqxj
         ko8Q==
X-Gm-Message-State: ACrzQf07mYJt2xCxC+6qDZjznAtKx63Vnt1/MwcEsyx/BQS71BCsd03k
        e38bk2fFCPsCZKA0g+4ghfnMug==
X-Google-Smtp-Source: AMsMyM5T8uqzbmlhDwK2iJakHiD/I/rnTl7wYc9IoQSun+00KcqIfUGmuustAbFdNeZC1kbM95GA+A==
X-Received: by 2002:a17:90b:3852:b0:203:a68c:9a7c with SMTP id nl18-20020a17090b385200b00203a68c9a7cmr14529200pjb.119.1664835834467;
        Mon, 03 Oct 2022 15:23:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b00174f61a7d09sm7713150plf.247.2022.10.03.15.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 15:23:53 -0700 (PDT)
Date:   Mon, 3 Oct 2022 15:23:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 28/39] x86/cet/shstk: Introduce map_shadow_stack
 syscall
Message-ID: <202210031446.E4AD9EE66@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-29-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-29-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:25PM -0700, Rick Edgecombe wrote:
> [...]
> The following example demonstrates how to create a new shadow stack with
> map_shadow_stack:
> void *shstk = map_shadow_stack(adrr, stack_size, SHADOW_STACK_SET_TOKEN);

typo: addr

> [...]
> +451	common	map_shadow_stack	sys_map_shadow_stack

Isn't this "64", not "common"?

> [...]
> +#define SHADOW_STACK_SET_TOKEN	0x1	/* Set up a restore token in the shadow stack */

I think this should get an intro comment, like:

/* Flags for map_shadow_stack(2) */

Also, as with the other UAPI fields, please use "(1ULL << 0)" here.

> @@ -62,24 +63,34 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
>  	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
>  		return -EFAULT;
>  
> -	*token_addr = addr;
> +	if (token_addr)
> +		*token_addr = addr;
>  
>  	return 0;
>  }
>  

Can this just be collapsed into the patch that introduces create_rstor_token()?

> -static unsigned long alloc_shstk(unsigned long size)
> +static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
> +				 unsigned long token_offset, bool set_res_tok)
>  {
>  	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
>  	struct mm_struct *mm = current->mm;
> -	unsigned long addr, unused;
> +	unsigned long mapped_addr, unused;
>  
>  	mmap_write_lock(mm);
> -	addr = do_mmap(NULL, addr, size, PROT_READ, flags,

Oops, I missed in the other patch that "addr" was being passed here.
(uninitialized?)

> -		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
> -
> +	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> +			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);

I don't see do_mmap() doing anything here to avoid remapping a prior vma
as shstk. Is the intention to allow userspace to convert existing VMAs?
This has caused pain in the past, perhaps force MAP_FIXED_NOREPLACE ?

> [...]
> @@ -174,6 +185,7 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
>  
>  
>  	stack_size = PAGE_ALIGN(stack_size);
> +	addr = alloc_shstk(0, stack_size, 0, false);
>  	if (IS_ERR_VALUE(addr))
>  		return PTR_ERR((void *)addr);
>  

As mentioned earlier, I was expecting this patch to replace a (missing)
call to alloc_shstk. i.e. expecting:

-	addr = alloc_shstk(stack_size);

> @@ -395,6 +407,26 @@ int shstk_disable(void)
>  	return 0;
>  }
>  
> +
> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)

Please add kern-doc for this, with some notes. E.g. at least one thing isn't immediately
obvious, maybe more: "addr" must be a multiple of 8.

> +{
> +	unsigned long aligned_size;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return -ENOSYS;

This needs to explicitly reject unknown flags[1], or expanding them in the
future becomes very painful:

	if (flags & ~(SHADOW_STACK_SET_TOKEN))
		return -EINVAL;


[1] https://docs.kernel.org/process/adding-syscalls.html#designing-the-api-planning-for-extension

> +
> +	/*
> +	 * An overflow would result in attempting to write the restore token
> +	 * to the wrong location. Not catastrophic, but just return the right
> +	 * error code and block it.
> +	 */
> +	aligned_size = PAGE_ALIGN(size);
> +	if (aligned_size < size)
> +		return -EOVERFLOW;

The intention here is to allow userspace to ask for _less_ than a page
size multiple, and to put the restore token there?

Is it worth adding a check for size >= 8 here? Or, I guess it would just
immediately crash on the next call?

> +
> +	return alloc_shstk(addr, aligned_size, size, flags & SHADOW_STACK_SET_TOKEN);
> +}

-- 
Kees Cook
