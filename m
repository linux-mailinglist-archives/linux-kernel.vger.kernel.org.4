Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0D665BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjAKMyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbjAKMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:53:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E40DF47
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673441569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ai5priIlF3jLKtBB0hlO6hYc9ZVkmV7mOhvE1Zn4rE=;
        b=Y2XgBZVvC/iz5E66l6NHJPZKjmoV31joKZlHXoaWD2lk4oYKm3qbBCXjhc7cryqx/+9yUf
        GvIqD9amd5vGC9Rq85ya/rTLx5J2CwUVHv9YaEoNey1pqZRVDKZmDg4z+2rPaHqon5TBUr
        idAJV8lqGAijrTVjXTWHhHO60mcmuu4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-LWBHtXcpNcCU7eeSRLGNTQ-1; Wed, 11 Jan 2023 07:52:48 -0500
X-MC-Unique: LWBHtXcpNcCU7eeSRLGNTQ-1
Received: by mail-ua1-f69.google.com with SMTP id y11-20020ab05b8b000000b005cb593d2d40so6823394uae.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ai5priIlF3jLKtBB0hlO6hYc9ZVkmV7mOhvE1Zn4rE=;
        b=ZE5I1YV4GHCdOLURs6k1UthyWYyzmYNzeveK0dfqcUVLUzF0J4UT56s6UqLC5iRvez
         bayrlyRumSZfngqxC8E2cccdCmMKLlbBRLB2iU+u/vfcpIxVtWb/0MrEOlCpI0YlsgJE
         j4S410oNj48fDGEkeZ0jBm0gsifDEZcDyZzDMnRCRMc514IzzwdJtAlAhiY/CuOkdUsU
         XeYyIFC6imM4uOND20L2HwThhMtZrHBeTTlO+63De6VQFh8N3t3sfCwiKwyHpx8eYBI3
         Twv5sgkjA7jGgG9YHXaP79zT1hlfPyiGhJQb/k5/Qlsj7jU9WJ/1+hwuss22EFMDiIHB
         Qc4A==
X-Gm-Message-State: AFqh2kpFyHFKzWTtTVBeIqC0KiWKXAyGGZBnZTHaEEDKAep1cLvD3gN+
        GkBsjMhIC56uNypb+LwaiZREp0PPF0vtvVpBYfXoqcyaVCoU9WEizu+7z1R+7XiInf/Q6+YP2Dp
        6L4Kw1OKmQiNf6haNieJJ8IWB
X-Received: by 2002:a67:e2c3:0:b0:3ce:e9bd:aa0f with SMTP id i3-20020a67e2c3000000b003cee9bdaa0fmr10621635vsm.32.1673441567938;
        Wed, 11 Jan 2023 04:52:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvQaryx8x1AiOUADAxBgk+2e/cvaMXQdfn1FRaAY2h5sWu4sa5+bZtWUdTDnsWwGYlp8Vk+hQ==
X-Received: by 2002:a67:e2c3:0:b0:3ce:e9bd:aa0f with SMTP id i3-20020a67e2c3000000b003cee9bdaa0fmr10621624vsm.32.1673441567611;
        Wed, 11 Jan 2023 04:52:47 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a269700b006fb11eee465sm9068639qkp.64.2023.01.11.04.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:52:46 -0800 (PST)
Date:   Wed, 11 Jan 2023 07:53:48 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@meta.com
Subject: Re: [PATCH v5 2/3] cachestat: implement cachestat syscall
Message-ID: <Y76xXBxYR7MWcXyl@bfoster>
References: <20230104231127.2634648-1-nphamcs@gmail.com>
 <20230104231127.2634648-3-nphamcs@gmail.com>
 <Y710pFYI8rBX9Eqe@bfoster>
 <CAKEwX=OjhHRrH9uS4d5XWfRU=UEpBVQ9n9+-f4hyvB5Rs+r0Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=OjhHRrH9uS4d5XWfRU=UEpBVQ9n9+-f4hyvB5Rs+r0Og@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:16:27PM -0800, Nhat Pham wrote:
> On Tue, Jan 10, 2023 at 6:21 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Wed, Jan 04, 2023 at 03:11:26PM -0800, Nhat Pham wrote:
> > > Implement a new syscall that queries cache state of a file and
> > > summarizes the number of cached pages, number of dirty pages, number of
> > > pages marked for writeback, number of (recently) evicted pages, etc. in
> > > a given range.
> > >
> > > NAME
> > >     cachestat - query the page cache statistics of a file.
> > >
> > > SYNOPSIS
> > >     #include <sys/mman.h>
> > >
> > >     struct cachestat {
> > >         __u64 nr_cache;
> > >         __u64 nr_dirty;
> > >         __u64 nr_writeback;
> > >         __u64 nr_evicted;
> > >         __u64 nr_recently_evicted;
> > >     };
> > >
> > >     int cachestat(unsigned int fd, off_t off, size_t len,
> > >           size_t cstat_size, struct cachestat *cstat,
> > >           unsigned int flags);
> > >
> > > DESCRIPTION
> > >     cachestat() queries the number of cached pages, number of dirty
> > >     pages, number of pages marked for writeback, number of evicted
> > >     pages, number of recently evicted pages, in the bytes range given by
> > >     `off` and `len`.
> > >
> > >     An evicted page is a page that is previously in the page cache but
> > >     has been evicted since. A page is recently evicted if its last
> > >     eviction was recent enough that its reentry to the cache would
> > >     indicate that it is actively being used by the system, and that
> > >     there is memory pressure on the system.
> > >
> > >     These values are returned in a cachestat struct, whose address is
> > >     given by the `cstat` argument.
> > >
> > >     The `off` and `len` arguments must be non-negative integers. If
> > >     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
> > >     0, we will query in the range from `off` to the end of the file.
> > >
> > >     `cstat_size` allows users to obtain partial results. The syscall
> > >     will copy the first `csstat_size` bytes to the specified userspace
> > >     memory. `cstat_size` must be a non-negative value that is no larger
> > >     than the current size of the cachestat struct.
> > >
> > >     The `flags` argument is unused for now, but is included for future
> > >     extensibility. User should pass 0 (i.e no flag specified).
> > >
> > > RETURN VALUE
> > >     On success, cachestat returns 0. On error, -1 is returned, and errno
> > >     is set to indicate the error.
> > >
> > > ERRORS
> > >     EFAULT cstat points to an invalid address.
> > >
> > >     EINVAL invalid `cstat_size` or `flags`
> > >
> > >     EBADF  invalid file descriptor.
> > >
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
> > >  arch/arm/tools/syscall.tbl                  |   1 +
> > >  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
> > >  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
> > >  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
> > >  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
> > >  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
> > >  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
> > >  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
> > >  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
> > >  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
> > >  arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
> > >  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
> > >  include/linux/fs.h                          |   3 +
> > >  include/linux/syscalls.h                    |   3 +
> > >  include/uapi/asm-generic/unistd.h           |   5 +-
> > >  include/uapi/linux/mman.h                   |   9 ++
> > >  init/Kconfig                                |  10 ++
> > >  kernel/sys_ni.c                             |   1 +
> > >  mm/filemap.c                                | 143 ++++++++++++++++++++
> > >  20 files changed, 186 insertions(+), 1 deletion(-)
> > >
> > ...
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 08341616ae7a..d70d47b20700 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > ...
> > > @@ -3949,3 +3953,142 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
> > >       return try_to_free_buffers(folio);
> > >  }
> > >  EXPORT_SYMBOL(filemap_release_folio);
> > ...
> > > +#ifdef CONFIG_CACHESTAT_SYSCALL
> > > +/*
> > > + * The cachestat(5) system call.
> > > + *
> > > + * cachestat() returns the page cache statistics of a file in the
> > > + * bytes range specified by `off` and `len`: number of cached pages,
> > > + * number of dirty pages, number of pages marked for writeback,
> > > + * number of evicted pages, and number of recently evicted pages.
> > > + *
> > > + * An evicted page is a page that is previously in the page cache
> > > + * but has been evicted since. A page is recently evicted if its last
> > > + * eviction was recent enough that its reentry to the cache would
> > > + * indicate that it is actively being used by the system, and that
> > > + * there is memory pressure on the system.
> > > + *
> > > + * `off` and `len` must be non-negative integers. If `len` > 0,
> > > + * the queried range is [`off`, `off` + `len`]. If `len` == 0,
> > > + * we will query in the range from `off` to the end of the file.
> > > + *
> > > + * `cstat_size` allows users to obtain partial results. The syscall
> > > + * will copy the first `csstat_size` bytes to the specified userspace
> > > + * memory. It also makes the cachestat struct extensible - new fields
> > > + * can be added in the future without breaking existing usage.
> > > + * `cstat_size` must be a non-negative value that is no larger than
> > > + * the current size of the cachestat struct.
> > > + *
> > > + * The `flags` argument is unused for now, but is included for future
> > > + * extensibility. User should pass 0 (i.e no flag specified).
> > > + *
> > > + * Because the status of a page can change after cachestat() checks it
> > > + * but before it returns to the application, the returned values may
> > > + * contain stale information.
> > > + *
> > > + * return values:
> > > + *  zero    - success
> > > + *  -EFAULT - cstat points to an illegal address
> > > + *  -EINVAL - invalid arguments
> > > + *  -EBADF   - invalid file descriptor
> > > + */
> > > +SYSCALL_DEFINE6(cachestat, unsigned int, fd, off_t, off, size_t, len,
> > > +             size_t, cstat_size, struct cachestat __user *, cstat,
> > > +             unsigned int, flags)
> > > +{
> > > +     struct fd f = fdget(fd);
> > > +     struct address_space *mapping;
> > > +     struct cachestat cs;
> > > +     pgoff_t first_index = off >> PAGE_SHIFT;
> > > +     pgoff_t last_index =
> > > +             len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
> > > +
> > > +     if (off < 0 || cstat_size > sizeof(struct cachestat) || flags != 0)
> > > +             return -EINVAL;
> > > +
> > > +     if (!f.file)
> > > +             return -EBADF;
> > > +
> >
> > It looks like we miss an fdput() before returning via the above error
> > checks.
> 
> Ooops yeah I missed that. I'll fix it.
> 
> >
> > The only other thing that stands out as a bit odd to me is the
> > cstat_size check and associated ability to return a partial cachestat
> > struct. Do other syscalls do anything like that? I'd think we'd want to
> > ensure we always at least return a fully populated cachestat struct,
> > even if it happened to be an old/compat version if the size does ever
> > increase. Hm?
> 
> Not that I know of, but the idea is that the user might expect a smaller
> struct cachestat in their code (and allocate memory accordingly).
> With this cstat_size, we can make sure that the expansion of cachestat
> struct (with new fields) does not break existing user's code - we only
> copy part of the struct.
> 

Yup, I get the idea of supporting future expansion. The part that
doesn't make sense to me is allowing a partial copy of struct cachestat.
For example, what happens if the user passes a cstat_size of 2? We copy
out two bytes of the first field of the struct and return 0 for
"success?"

The way I've commonly seen this sort of support for future expansion is
by versioning the structure and providing backwards compatibility for
old versions of the structure. I'd guess there are various ways to
implement that, but a simple example that comes to mind for me is
xfs_ioc_fsgeometry(). The caveat there is that it's an ioctl where IIRC
the command essentially changes when the structure size does, which
allows the kernel to determine what version is being used.

I'm not quite sure what the ideal way to do that for a syscall is. I
suppose the kernel could just check that the size param matches some
version of the structure it knows about and assume that. Or since you
have the flags field, you could require a flag to be passed in to return
values for any new fields. Or yet another option could be to pad out the
size of the userspace structure to support future expansion for the
foreseeable future without the need for such a flag.

Perhaps this is something linux-api can help with?

Brian

> >
> > Brian
> >
> > > +     memset(&cs, 0, sizeof(struct cachestat));
> > > +     mapping = f.file->f_mapping;
> > > +     filemap_cachestat(mapping, first_index, last_index, &cs);
> > > +     fdput(f);
> > > +
> > > +     if (copy_to_user(cstat, &cs, cstat_size))
> > > +             return -EFAULT;
> > > +
> > > +     return 0;
> > > +}
> > > +#endif /* CONFIG_CACHESTAT_SYSCALL */
> > > --
> > > 2.30.2
> > >
> >
> 

