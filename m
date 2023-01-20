Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7867577A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjATOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjATOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C70D0DAF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674225331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SeYADoHzDgkbWA+7o8/pUG2OMBUG3IhX5d68pOPwQ5Y=;
        b=RuvT+spYfx2K7fG3IQfoAgBQx7Ho+BwtStG7p1L+LJJUv4nj42hI9t0Lz+aFzENAHUPex0
        nrKWSMYj25LqCL9ko4WmjJMTSH0kreaTv+gZdFMlKUcADal6BSxgBzsgnpm54S5q/IcBoD
        RLbOTVH+XLKtpWwB7oLEI0GeuAPUxYg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-QFxLofwjPvS-t1wMSGu70w-1; Fri, 20 Jan 2023 09:35:29 -0500
X-MC-Unique: QFxLofwjPvS-t1wMSGu70w-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-4fee82718afso21496177b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeYADoHzDgkbWA+7o8/pUG2OMBUG3IhX5d68pOPwQ5Y=;
        b=eLrVh3LUsG3qOrJ5QVCTV0U50faGOUuWIcLiEx0uPrMamGFtdU0qHMBPjaSBo3j812
         hhNdghH4FYTBq52LphpcmvCuv3fPXmJCQDP+lM7TUe6izCJyElL5neNnfRC+f6xn2Fkw
         fSdGnu2dcLGDPYC9m2GV6xVL/v5mfHdLc6rrRUofRT34p4qgseh9QLZDVsR0tHuQzOof
         M3gydZOk9uAJaoyZduY18+r9NzTd+l6gGl/Mr15EP5g/TfEJLFBn/hdGnMN6FzprAb6P
         he+3Xv/NisA/lMY+HhmLw0hPZqVxdnYEk/yYhPG3bGiA0sL2y0OwiJozcvTYWlTBvtKd
         W6iQ==
X-Gm-Message-State: AFqh2ko1iAT03kY04RjFFZw0qdagvZMyWBbsGtiKa/p5MxRvlLc0zHw9
        erz8FpdJWgDddR+/eBYgY71t8sknKe5U2NmlGVJD8AFxnW+8e98DmNANlmYts0qPLJCuST3hNVI
        0MGAzK13e/QGbB7qUH9ImRqto
X-Received: by 2002:a05:6902:1c8:b0:7ac:1b00:a41c with SMTP id u8-20020a05690201c800b007ac1b00a41cmr12425359ybh.63.1674225325666;
        Fri, 20 Jan 2023 06:35:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsBndu9QEt/gCtslE8PkUmjyNS//Z/mZ9+2EEOPJ+FXdH2jGGHggzFaAuy9BmUJEFannE+74w==
X-Received: by 2002:a05:6902:1c8:b0:7ac:1b00:a41c with SMTP id u8-20020a05690201c800b007ac1b00a41cmr12425342ybh.63.1674225325282;
        Fri, 20 Jan 2023 06:35:25 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a258e00b006e07228ed53sm26185815qko.18.2023.01.20.06.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 06:35:24 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:36:27 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 2/3] cachestat: implement cachestat syscall
Message-ID: <Y8qm69bYnzZk+Vni@bfoster>
References: <20230117195959.29768-1-nphamcs@gmail.com>
 <20230117195959.29768-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117195959.29768-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:59:58AM -0800, Nhat Pham wrote:
> There is currently no good way to query the page cache state of large
> file sets and directory trees. There is mincore(), but it scales poorly:
> the kernel writes out a lot of bitmap data that userspace has to
> aggregate, when the user really doesn not care about per-page
> information in that case. The user also needs to mmap and unmap each
> file as it goes along, which can be quite slow as well.
> 
> This patch implements a new syscall that queries cache state of a file
> and summarizes the number of cached pages, number of dirty pages, number
> of pages marked for writeback, number of (recently) evicted pages, etc.
> in a given range.
> 
> NAME
>     cachestat - query the page cache statistics of a file.
> 
> SYNOPSIS
>     #include <sys/mman.h>
> 
>     struct cachestat {
>         __u64 nr_cache;
>         __u64 nr_dirty;
>         __u64 nr_writeback;
>         __u64 nr_evicted;
>         __u64 nr_recently_evicted;
>     };
> 
>     int cachestat(unsigned int fd, off_t off, size_t len,
>           unsigned int cstat_version, struct cachestat *cstat,
>           unsigned int flags);
> 
> DESCRIPTION
>     cachestat() queries the number of cached pages, number of dirty
>     pages, number of pages marked for writeback, number of evicted
>     pages, number of recently evicted pages, in the bytes range given by
>     `off` and `len`.
> 
>     An evicted page is a page that is previously in the page cache but
>     has been evicted since. A page is recently evicted if its last
>     eviction was recent enough that its reentry to the cache would
>     indicate that it is actively being used by the system, and that
>     there is memory pressure on the system.
> 
>     These values are returned in a cachestat struct, whose address is
>     given by the `cstat` argument.
> 
>     The `off` and `len` arguments must be non-negative integers. If
>     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
>     0, we will query in the range from `off` to the end of the file.
> 
>     `cstat_version` is an unsigned integer indicating the specific
>     version of the cachestat struct. It must be at least 1, and does
>     not exceed the latest version number (which is currently 1). For
>     now, user should just pass 1.
> 

Still not sure about this vs. just requiring the structure size to match
(and maybe padding it), but perhaps linux-api can comment on the best
way to future proof.

I'm not the person to ack a syscall regardless, but since I've had
various previous comments on this patch and no further issues stand out
to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>     The `flags` argument is unused for now, but is included for future
>     extensibility. User should pass 0 (i.e no flag specified).
> 
> RETURN VALUE
>     On success, cachestat returns 0. On error, -1 is returned, and errno
>     is set to indicate the error.
> 
> ERRORS
>     EFAULT cstat points to an invalid address.
> 
>     EINVAL invalid `cstat_version` or `flags`
> 
>     EBADF  invalid file descriptor.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
>  arch/arm/tools/syscall.tbl                  |   1 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
>  include/linux/fs.h                          |   3 +
>  include/linux/syscalls.h                    |   4 +
>  include/uapi/asm-generic/unistd.h           |   5 +-
>  include/uapi/linux/mman.h                   |   9 ++
>  init/Kconfig                                |  10 ++
>  kernel/sys_ni.c                             |   1 +
>  mm/filemap.c                                | 154 ++++++++++++++++++++
>  20 files changed, 198 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 8ebacf37a8cf..1f13995d00d7 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -490,3 +490,4 @@
>  558	common	process_mrelease		sys_process_mrelease
>  559	common  futex_waitv                     sys_futex_waitv
>  560	common	set_mempolicy_home_node		sys_ni_syscall
> +561	common	cachestat			sys_cachestat
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index ac964612d8b0..8ebed8a13874 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -464,3 +464,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common	futex_waitv			sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 72c929d9902b..f8c74ffeeefb 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -371,3 +371,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common  futex_waitv                     sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index b1f3940bc298..4f504783371f 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -450,3 +450,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common  futex_waitv                     sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 820145e47350..858d22bf275c 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -456,3 +456,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common  futex_waitv                     sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 8a99c998da9b..7c84a72306d1 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -448,3 +448,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common	futex_waitv			sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 2bca64f96164..937460f0a8ec 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -530,3 +530,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common  futex_waitv                     sys_futex_waitv
>  450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 799147658dee..7df0329d46cb 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -453,3 +453,4 @@
>  448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
>  449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
>  450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451  common	cachestat		sys_cachestat			sys_cachestat
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 2de85c977f54..97377e8c5025 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -453,3 +453,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common  futex_waitv                     sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 4398cc6fb68d..faa835f3c54a 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -496,3 +496,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common  futex_waitv                     sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 320480a8db4f..bc0a3c941b35 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -455,3 +455,4 @@
>  448	i386	process_mrelease	sys_process_mrelease
>  449	i386	futex_waitv		sys_futex_waitv
>  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	i386	cachestat		sys_cachestat
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..227538b0ce80 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>  448	common	process_mrelease	sys_process_mrelease
>  449	common	futex_waitv		sys_futex_waitv
>  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	common	cachestat		sys_cachestat
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 52c94ab5c205..2b69c3c035b6 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -421,3 +421,4 @@
>  448	common	process_mrelease		sys_process_mrelease
>  449	common  futex_waitv                     sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	common	cachestat			sys_cachestat
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f1651..83300f1491e7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -75,6 +75,7 @@ struct fs_context;
>  struct fs_parameter_spec;
>  struct fileattr;
>  struct iomap_ops;
> +struct cachestat;
>  
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -830,6 +831,8 @@ void filemap_invalidate_lock_two(struct address_space *mapping1,
>  				 struct address_space *mapping2);
>  void filemap_invalidate_unlock_two(struct address_space *mapping1,
>  				   struct address_space *mapping2);
> +void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
> +		pgoff_t last_index, struct cachestat *cs);
>  
>  
>  /*
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a34b0f9a9972..d3fe6ba8eb38 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -72,6 +72,7 @@ struct open_how;
>  struct mount_attr;
>  struct landlock_ruleset_attr;
>  enum landlock_rule_type;
> +struct cachestat;
>  
>  #include <linux/types.h>
>  #include <linux/aio_abi.h>
> @@ -1056,6 +1057,9 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> +asmlinkage long sys_cachestat(unsigned int fd, off_t off, size_t len,
> +		unsigned int cstat_version, struct cachestat __user *cstat,
> +		unsigned int flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 45fa180cc56a..cd639fae9086 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  #define __NR_set_mempolicy_home_node 450
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>  
> +#define __NR_cachestat 451
> +__SYSCALL(__NR_cachestat, sys_cachestat)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index f55bc680b5b0..fe03ed0b7587 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -4,6 +4,7 @@
>  
>  #include <asm/mman.h>
>  #include <asm-generic/hugetlb_encode.h>
> +#include <linux/types.h>
>  
>  #define MREMAP_MAYMOVE		1
>  #define MREMAP_FIXED		2
> @@ -41,4 +42,12 @@
>  #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>  
> +struct cachestat {
> +	__u64 nr_cache;
> +	__u64 nr_dirty;
> +	__u64 nr_writeback;
> +	__u64 nr_evicted;
> +	__u64 nr_recently_evicted;
> +};
> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 694f7c160c9c..da96ac29af1d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1798,6 +1798,16 @@ config RSEQ
>  
>  	  If unsure, say Y.
>  
> +config CACHESTAT_SYSCALL
> +	bool "Enable cachestat() system call" if EXPERT
> +	default y
> +	help
> +	  Enable the cachestat system call, which queries the page cache
> +	  statistics of a file (number of cached pages, dirty pages,
> +	  pages marked for writeback, (recently) evicted pages).
> +
> +	  If unsure say Y here.
> +
>  config DEBUG_RSEQ
>  	default n
>  	bool "Enabled debugging of rseq() system call" if EXPERT
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 860b2dcf3ac4..04bfb1e4d377 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -299,6 +299,7 @@ COND_SYSCALL(set_mempolicy);
>  COND_SYSCALL(migrate_pages);
>  COND_SYSCALL(move_pages);
>  COND_SYSCALL(set_mempolicy_home_node);
> +COND_SYSCALL(cachestat);
>  
>  COND_SYSCALL(perf_event_open);
>  COND_SYSCALL(accept4);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 08341616ae7a..0305eaf5b3f5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -22,6 +22,7 @@
>  #include <linux/mm.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> +#include <linux/syscalls.h>
>  #include <linux/mman.h>
>  #include <linux/pagemap.h>
>  #include <linux/file.h>
> @@ -55,6 +56,13 @@
>  #include <linux/buffer_head.h> /* for try_to_free_buffers */
>  
>  #include <asm/mman.h>
> +#include <uapi/linux/mman.h>
> +
> +#include "swap.h"
> +
> +#ifdef CONFIG_CACHESTAT_SYSCALL
> +#define LATEST_CACHESTAT_VERSION	1
> +#endif
>  
>  /*
>   * Shared mappings implemented 30.11.1994. It's not fully working yet,
> @@ -3949,3 +3957,149 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
>  	return try_to_free_buffers(folio);
>  }
>  EXPORT_SYMBOL(filemap_release_folio);
> +
> +/**
> + * filemap_cachestat() - compute the page cache statistics of a mapping
> + * @mapping:	The mapping to compute the statistics for.
> + * @first_index:	The starting page cache index.
> + * @last_index:	The final page index (inclusive).
> + * @cs:	the cachestat struct to write the result to.
> + *
> + * This will query the page cache statistics of a mapping in the
> + * page range of [first_index, last_index] (inclusive). The statistics
> + * queried include: number of dirty pages, number of pages marked for
> + * writeback, and the number of (recently) evicted pages.
> + */
> +void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
> +		pgoff_t last_index, struct cachestat *cs)
> +{
> +	XA_STATE(xas, &mapping->i_pages, first_index);
> +	struct folio *folio;
> +
> +	rcu_read_lock();
> +	xas_for_each(&xas, folio, last_index) {
> +		unsigned long nr_pages;
> +		pgoff_t folio_first_index, folio_last_index;
> +
> +		if (xas_retry(&xas, folio))
> +			continue;
> +
> +		nr_pages = folio_nr_pages(folio);
> +		folio_first_index = folio_pgoff(folio);
> +		folio_last_index = folio_first_index + nr_pages - 1;
> +
> +		/* Folios might straddle the range boundaries, only count covered subpages */
> +		if (folio_first_index < first_index)
> +			nr_pages -= first_index - folio_first_index;
> +
> +		if (folio_last_index > last_index)
> +			nr_pages -= folio_last_index - last_index;
> +
> +		if (xa_is_value(folio)) {
> +			/* page is evicted */
> +			void *shadow = (void *)folio;
> +			bool workingset; /* not used */
> +
> +			cs->nr_evicted += nr_pages;
> +
> +#ifdef CONFIG_SWAP /* implies CONFIG_MMU */
> +			if (shmem_mapping(mapping)) {
> +				/* shmem file - in swap cache */
> +				swp_entry_t swp = radix_to_swp_entry(folio);
> +
> +				shadow = get_shadow_from_swap_cache(swp);
> +			}
> +#endif
> +			if (workingset_test_recent(shadow, true, &workingset))
> +				cs->nr_recently_evicted += nr_pages;
> +
> +			goto resched;
> +		}
> +
> +		/* page is in cache */
> +		cs->nr_cache += nr_pages;
> +
> +		if (folio_test_dirty(folio))
> +			cs->nr_dirty += nr_pages;
> +
> +		if (folio_test_writeback(folio))
> +			cs->nr_writeback += nr_pages;
> +
> +resched:
> +		if (need_resched()) {
> +			xas_pause(&xas);
> +			cond_resched_rcu();
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(filemap_cachestat);
> +
> +#ifdef CONFIG_CACHESTAT_SYSCALL
> +/*
> + * The cachestat(5) system call.
> + *
> + * cachestat() returns the page cache statistics of a file in the
> + * bytes range specified by `off` and `len`: number of cached pages,
> + * number of dirty pages, number of pages marked for writeback,
> + * number of evicted pages, and number of recently evicted pages.
> + *
> + * An evicted page is a page that is previously in the page cache
> + * but has been evicted since. A page is recently evicted if its last
> + * eviction was recent enough that its reentry to the cache would
> + * indicate that it is actively being used by the system, and that
> + * there is memory pressure on the system.
> + *
> + * `off` and `len` must be non-negative integers. If `len` > 0,
> + * the queried range is [`off`, `off` + `len`]. If `len` == 0,
> + * we will query in the range from `off` to the end of the file.
> + *
> + * `cstat_version` is an unsigned integer indicating the specific version
> + * of the cachestat struct. It must be at least 1, and does not exceed the
> + * latest version number (which is currently 1). For now, user should
> + * just pass 1.
> + *
> + * The `flags` argument is unused for now, but is included for future
> + * extensibility. User should pass 0 (i.e no flag specified).
> + *
> + * Because the status of a page can change after cachestat() checks it
> + * but before it returns to the application, the returned values may
> + * contain stale information.
> + *
> + * return values:
> + *  zero    - success
> + *  -EFAULT - cstat points to an illegal address
> + *  -EINVAL - invalid arguments
> + *  -EBADF	- invalid file descriptor
> + */
> +SYSCALL_DEFINE6(cachestat, unsigned int, fd, off_t, off, size_t, len,
> +		unsigned int, cstat_version, struct cachestat __user *, cstat,
> +		unsigned int, flags)
> +{
> +	struct fd f = fdget(fd);
> +	struct address_space *mapping;
> +	struct cachestat cs;
> +	pgoff_t first_index = off >> PAGE_SHIFT;
> +	pgoff_t last_index =
> +		len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
> +
> +	if (!f.file)
> +		return -EBADF;
> +
> +	if (off < 0 || flags != 0 || cstat_version < 1 ||
> +			cstat_version > LATEST_CACHESTAT_VERSION) {
> +		fdput(f);
> +		return -EINVAL;
> +	}
> +
> +	memset(&cs, 0, sizeof(struct cachestat));
> +	mapping = f.file->f_mapping;
> +	filemap_cachestat(mapping, first_index, last_index, &cs);
> +	fdput(f);
> +
> +	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_CACHESTAT_SYSCALL */
> -- 
> 2.30.2
> 

