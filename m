Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2F6478D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiLHWa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiLHWaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:30:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4814481D82
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:30:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d1so3380701wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 14:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W3+Qj3Z1EpYHiSVXxwGcgKDLgiIj4S+N6flwpWCOBqQ=;
        b=cOohwJm68+mDY7Qcfi4m4JtnV75FjQ9UATy3VYZUvqNLqE/DFim8pQFfPm62DKNSrg
         P0ykv4vvMW4a6ga7TGysusry7zPpZ/f/z+SERvNz31BhJlGVtZa5AqPVhPz9X6k4B8Bt
         ZWK7ELW7Pc8uBc9EU2KQ8KFb/csdmaIA0A+lwwZ7vR3KC6ltKZX7AA8kEDhoOGtRO1LS
         L6emM/I4TYifeogm61M+7E2RF5DaCsQj9BQr3DCCA0RczdizgTubcR1+wlrUQGW9ZOgl
         TNjbHIClX9G+rU0RoV7u4WNIIHsRt6XQ4gaUARD7DIF1e3wXxFb1l+b81jTnmiUHFObg
         KCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3+Qj3Z1EpYHiSVXxwGcgKDLgiIj4S+N6flwpWCOBqQ=;
        b=seIRHc0nMBFmyCayKPTXfUwEvxWGJlskw28hVIxMvjxsaV8yLbcsHBmiNhSndc8p3M
         Maz5k8aGChDKhJ9HmIzNTu0XKcamMB0KCG4ec9Y/DrZojAeA7N2swcXaTiettYmflL6z
         SfrZxWKRytzY9mOO42URfpd9VhP3VuvPV6/r4USZ7ST2IN9aEe3xnVShEqre/rnsv9C3
         RQAfP0kYExwoSSUQfebvMOfEmCDHkEXObRP0jVXRx+auEfU6oHvPYimKTeKI+ttyeiub
         Y5xE8lze9hwBrj/qKwmGomjMJ2qXWYXWtKHXR+93P9MGDXvz5dxJZIBavfUKrdZUAn8o
         sFTg==
X-Gm-Message-State: ANoB5pmqwwTSlSaldstLkHftZvGLAqY7r5NFAyHKDPOByhDS+bVNRCb8
        N/eLxYE8yX3hSoB2q+wHbxxTBYtOG6oMl9pcq9E=
X-Google-Smtp-Source: AA0mqf7NS7LDwGcCn8bjppcWn6iSXebj0YNyyf21Ghc8vdn244IZz9qXPf39AKvPjxK2BjWAC3ozdXz/oPheh9IkCwQ=
X-Received: by 2002:a5d:6210:0:b0:22e:6a6f:3416 with SMTP id
 y16-20020a5d6210000000b0022e6a6f3416mr56226977wru.60.1670538618594; Thu, 08
 Dec 2022 14:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20221208202808.908690-1-nphamcs@gmail.com> <20221208202808.908690-4-nphamcs@gmail.com>
In-Reply-To: <20221208202808.908690-4-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 8 Dec 2022 14:30:07 -0800
Message-ID: <CAKEwX=Pzr5yyyv8FbwAOPzGs4N-nMWMsCiRy5ToswVAk6RX6Jg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cachestat: implement cachestat syscall
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 12:28 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Implement a new syscall that queries cache state of a file and
> summarizes the number of cached pages, number of dirty pages, number of
> pages marked for writeback, number of (recently) evicted pages, etc. in
> a given range.
>
> NAME
>     cachestat - query the page cache status of a file.
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
>           size_t cstat_size, struct cachestat *cstat,
>           unsigned int flags);
>
> DESCRIPTION
>     cachestat() queries the number of cached pages, number of dirty
>     pages, number of pages marked for writeback, number of (recently)
>     evicted pages, in the bytes range given by `off` and `len`.
>
>     These values are returned in a cachestat struct, whose address is
>     given by the `cstat` argument.
>
>     The `off` and `len` arguments must be non-negative integers. If
>     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
>     0, we will query in the range from `off` to the end of the file.
>
>     `cstat_size` allows users to obtain partial results. The syscall
>     will copy the first `csstat_size` bytes to the specified userspace
>     memory. `cstat_size` must be a non-negative value that is no larger
>     than the current size of the cachestat struct.
>
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
>     EINVAL invalid `cstat_size` or `flags`
>
>     EBADF  invalid file descriptor.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  MAINTAINERS                                 |   7 ++
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
>  include/linux/syscalls.h                    |   3 +
>  include/uapi/asm-generic/unistd.h           |   5 +-
>  include/uapi/linux/mman.h                   |   9 ++
>  init/Kconfig                                |  10 ++
>  kernel/sys_ni.c                             |   1 +
>  mm/Makefile                                 |   1 +
>  mm/cachestat.c                              | 117 ++++++++++++++++++++
>  21 files changed, 165 insertions(+), 1 deletion(-)
>  create mode 100644 mm/cachestat.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a198da986146..baa081a1fe52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4552,6 +4552,13 @@ S:       Supported
>  F:     Documentation/filesystems/caching/cachefiles.rst
>  F:     fs/cachefiles/
>
> +CACHESTAT: PAGE CACHE STATS FOR A FILE
> +M:     Nhat Pham <nphamcs@gmail.com>
> +M:     Johannes Weiner <hannes@cmpxchg.org>
> +L:     linux-mm@kvack.org
> +S:     Maintained
> +F:     mm/cachestat.c
> +
>  CADENCE MIPI-CSI2 BRIDGES
>  M:     Maxime Ripard <mripard@kernel.org>
>  L:     linux-media@vger.kernel.org
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 8ebacf37a8cf..1f13995d00d7 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -490,3 +490,4 @@
>  558    common  process_mrelease                sys_process_mrelease
>  559    common  futex_waitv                     sys_futex_waitv
>  560    common  set_mempolicy_home_node         sys_ni_syscall
> +561    common  cachestat                       sys_cachestat
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index ac964612d8b0..8ebed8a13874 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -464,3 +464,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 72c929d9902b..f8c74ffeeefb 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -371,3 +371,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index b1f3940bc298..4f504783371f 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -450,3 +450,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 820145e47350..858d22bf275c 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -456,3 +456,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 8a99c998da9b..7c84a72306d1 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -448,3 +448,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 2bca64f96164..937460f0a8ec 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -530,3 +530,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    nospu   set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 799147658dee..7df0329d46cb 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -453,3 +453,4 @@
>  448  common    process_mrelease        sys_process_mrelease            sys_process_mrelease
>  449  common    futex_waitv             sys_futex_waitv                 sys_futex_waitv
>  450  common    set_mempolicy_home_node sys_set_mempolicy_home_node     sys_set_mempolicy_home_node
> +451  common    cachestat               sys_cachestat                   sys_cachestat
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 2de85c977f54..97377e8c5025 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -453,3 +453,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 4398cc6fb68d..faa835f3c54a 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -496,3 +496,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 320480a8db4f..bc0a3c941b35 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -455,3 +455,4 @@
>  448    i386    process_mrelease        sys_process_mrelease
>  449    i386    futex_waitv             sys_futex_waitv
>  450    i386    set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    i386    cachestat               sys_cachestat
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..8eed4cdc7965 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>  448    common  process_mrelease        sys_process_mrelease
>  449    common  futex_waitv             sys_futex_waitv
>  450    common  set_mempolicy_home_node sys_set_mempolicy_home_node
> +451    common  cachestat       sys_cachestat
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 52c94ab5c205..2b69c3c035b6 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -421,3 +421,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +451    common  cachestat                       sys_cachestat
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a34b0f9a9972..50f8c6999d99 100644
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
> @@ -1056,6 +1057,8 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>                                             unsigned long home_node,
>                                             unsigned long flags);
> +asmlinkage long sys_cachestat(unsigned int fd, off_t off, size_t len,
> +               size_t cstat_size, struct cachestat __user *cstat, unsigned int flags);
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
>  #define MREMAP_MAYMOVE         1
>  #define MREMAP_FIXED           2
> @@ -41,4 +42,12 @@
>  #define MAP_HUGE_2GB   HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB  HUGETLB_FLAG_ENCODE_16GB
>
> +struct cachestat {
> +       __u64 nr_cache;
> +       __u64 nr_dirty;
> +       __u64 nr_writeback;
> +       __u64 nr_evicted;
> +       __u64 nr_recently_evicted;
> +};
> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 694f7c160c9c..ecc4f781dd6c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1798,6 +1798,16 @@ config RSEQ
>
>           If unsure, say Y.
>
> +config CACHESTAT
> +       bool "Enable cachestat() system call" if EXPERT
> +       default y
> +       help
> +         Enable the cachestat system call, which queries the page cache
> +         statistics of a file (number of cached pages, dirty pages,
> +         pages marked for writeback, (recently) evicted pages).
> +
> +         If unsure say Y here.
> +
>  config DEBUG_RSEQ
>         default n
>         bool "Enabled debugging of rseq() system call" if EXPERT
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
> diff --git a/mm/Makefile b/mm/Makefile
> index 8e105e5b3e29..61c9c3f81cef 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
> +obj-$(CONFIG_CACHESTAT) += cachestat.o
> diff --git a/mm/cachestat.c b/mm/cachestat.c
> new file mode 100644
> index 000000000000..931f5e37326b
> --- /dev/null
> +++ b/mm/cachestat.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * The cachestat() system call.
> + */
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/syscalls.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
> +#include <uapi/linux/mman.h>
> +
> +#include "swap.h"
> +
> +/*
> + * The cachestat(5) system call.
> + *
> + * cachestat() returns the page cache status of a file in the
> + * bytes specified by `off` and `len`: number of cached pages,
> + * number of dirty pages, number of pages marked for writeback,
> + * number of (recently) evicted pages.
> + *
> + * `off` and `len` must be non-negative integers. If `len` > 0,
> + * the queried range is [`off`, `off` + `len`]. If `len` == 0,
> + * we will query in the range from `off` to the end of the file.
> + *
> + * `cstat_size` allows users to obtain partial results. The syscall
> + * will copy the first `csstat_size` bytes to the specified userspace
> + * memory. It also makes the cachestat struct extensible - new fields
> + * can be added in the future without breaking existing usage.
> + * `cstat_size` must be a non-negative value that is no larger than
> + * the current size of the cachestat struct.
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
> + *  -EBADF     - invalid file descriptor
> + */
> +SYSCALL_DEFINE6(cachestat, unsigned int, fd, off_t, off, size_t, len,
> +               size_t, cstat_size, struct cachestat __user *, cstat,
> +               unsigned int, flags)
> +{
> +       struct fd f;
> +       struct cachestat cs;
> +
> +       memset(&cs, 0, sizeof(struct cachestat));
> +
> +       if (off < 0 || cstat_size > sizeof(struct cachestat) || flags != 0)
> +               return -EINVAL;
> +
> +       if (!access_ok(cstat, sizeof(struct cachestat)))
> +               return -EFAULT;

Oops, this part should really be:

if (!access_ok(cstat, cstat_size))

I'll send a new version of patch 3/4 to fix this...
