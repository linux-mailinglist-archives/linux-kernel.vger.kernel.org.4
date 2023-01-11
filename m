Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D67E666534
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjAKVCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjAKVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1142E4103C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673470799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vyeWk/g1U/5f1iLhCpVaihKzjH0ul2CwdRypkF1kYS8=;
        b=CtwRWDBJCm1uqrKD2V5hGbGqP6MneD9rlIIH/Ee/W9wa4XF2BPVlMTCjUfWn2uOzBeGMyc
        cXgEqYVXXW4u79pOCMQPNTiKbgeBqmGtrOLmeN3KErfgwOadxKYjiqyfE0Yfq8w6X2lGYH
        lrtp3GWf3+usRHFbR9k1+5BsSfLXXXk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-yRaiAwI8NcW-UHfkYPxjUA-1; Wed, 11 Jan 2023 15:59:57 -0500
X-MC-Unique: yRaiAwI8NcW-UHfkYPxjUA-1
Received: by mail-qt1-f200.google.com with SMTP id hf20-20020a05622a609400b003abcad051d2so7752723qtb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyeWk/g1U/5f1iLhCpVaihKzjH0ul2CwdRypkF1kYS8=;
        b=8PCTaPbo56wBVTJafJa5Avlv2tGv+P6uIBLV0NO6iqs0Qc28qQ+O0z4dGriw/GNA3O
         3Rw96SzzBKT/y07HKnRkp+eszLNandDtBCFug+GyOCvEY6b931XKFUKrCqDU1LggPmN0
         niYsnUK26lKVnsuDCuLnoFBC29XIvWvtRPtoRE6Kd3x/uea08IdYrXIGB7iFfojAV6se
         rrCLKiuwPi3XBuIc2aRSMXqkM2hfqsAM8uNnYsVA5JGjGVmtbV6K/LtC7GUUM1nBRsn3
         QJGHZMeJ40I6vMqhlPwbSQhmZRw4dwOvk5u5UAnoi/cWdOFhkUWn9z3lX7Qbp5I8QzQf
         +e3g==
X-Gm-Message-State: AFqh2kpuJX/HETo5WQuEIW+K8pFfUP04+GAOzKalp6c5nxykqV6UMoU8
        xqnXdiaMb38nmYHotpX6nLR6E+CPRAgcAqcK9uiO7VkPx1VnPFysLbH2vSaqBFyEiA9VIJzod/5
        K2yu8MmP92P773K25wR97hsjq
X-Received: by 2002:ac8:6ecc:0:b0:3a9:8610:f9af with SMTP id f12-20020ac86ecc000000b003a98610f9afmr12912388qtv.14.1673470797376;
        Wed, 11 Jan 2023 12:59:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsf/x84OvHzvyq+EasSVRLK/UcluygSMehHQhcpW1VRFDRYjnEu4kxG1tw04v6SeltV3geD3Q==
X-Received: by 2002:ac8:6ecc:0:b0:3a9:8610:f9af with SMTP id f12-20020ac86ecc000000b003a98610f9afmr12912350qtv.14.1673470797004;
        Wed, 11 Jan 2023 12:59:57 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a454800b006fc7302cf89sm9707752qkp.28.2023.01.11.12.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:59:56 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:00:57 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@meta.com
Subject: Re: [PATCH v5 2/3] cachestat: implement cachestat syscall
Message-ID: <Y78jiQTtxOzBkbmE@bfoster>
References: <20230104231127.2634648-1-nphamcs@gmail.com>
 <20230104231127.2634648-3-nphamcs@gmail.com>
 <Y710pFYI8rBX9Eqe@bfoster>
 <CAKEwX=OjhHRrH9uS4d5XWfRU=UEpBVQ9n9+-f4hyvB5Rs+r0Og@mail.gmail.com>
 <Y76xXBxYR7MWcXyl@bfoster>
 <CAKEwX=MH2x1Uwjikc_L0EiPm5ptv4xkWhj2ZB9wLxxQQZ-0VuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MH2x1Uwjikc_L0EiPm5ptv4xkWhj2ZB9wLxxQQZ-0VuA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:39:38PM -0800, Nhat Pham wrote:
> On Wed, Jan 11, 2023 at 4:52 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Tue, Jan 10, 2023 at 01:16:27PM -0800, Nhat Pham wrote:
> > > On Tue, Jan 10, 2023 at 6:21 AM Brian Foster <bfoster@redhat.com> wrote:
> > > >
> > > > On Wed, Jan 04, 2023 at 03:11:26PM -0800, Nhat Pham wrote:
> > > > > Implement a new syscall that queries cache state of a file and
> > > > > summarizes the number of cached pages, number of dirty pages, number of
> > > > > pages marked for writeback, number of (recently) evicted pages, etc. in
> > > > > a given range.
> > > > >
> > > > > NAME
> > > > >     cachestat - query the page cache statistics of a file.
> > > > >
> > > > > SYNOPSIS
> > > > >     #include <sys/mman.h>
> > > > >
> > > > >     struct cachestat {
> > > > >         __u64 nr_cache;
> > > > >         __u64 nr_dirty;
> > > > >         __u64 nr_writeback;
> > > > >         __u64 nr_evicted;
> > > > >         __u64 nr_recently_evicted;
> > > > >     };
> > > > >
> > > > >     int cachestat(unsigned int fd, off_t off, size_t len,
> > > > >           size_t cstat_size, struct cachestat *cstat,
> > > > >           unsigned int flags);
> > > > >
> > > > > DESCRIPTION
> > > > >     cachestat() queries the number of cached pages, number of dirty
> > > > >     pages, number of pages marked for writeback, number of evicted
> > > > >     pages, number of recently evicted pages, in the bytes range given by
> > > > >     `off` and `len`.
> > > > >
> > > > >     An evicted page is a page that is previously in the page cache but
> > > > >     has been evicted since. A page is recently evicted if its last
> > > > >     eviction was recent enough that its reentry to the cache would
> > > > >     indicate that it is actively being used by the system, and that
> > > > >     there is memory pressure on the system.
> > > > >
> > > > >     These values are returned in a cachestat struct, whose address is
> > > > >     given by the `cstat` argument.
> > > > >
> > > > >     The `off` and `len` arguments must be non-negative integers. If
> > > > >     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
> > > > >     0, we will query in the range from `off` to the end of the file.
> > > > >
> > > > >     `cstat_size` allows users to obtain partial results. The syscall
> > > > >     will copy the first `csstat_size` bytes to the specified userspace
> > > > >     memory. `cstat_size` must be a non-negative value that is no larger
> > > > >     than the current size of the cachestat struct.
> > > > >
> > > > >     The `flags` argument is unused for now, but is included for future
> > > > >     extensibility. User should pass 0 (i.e no flag specified).
> > > > >
> > > > > RETURN VALUE
> > > > >     On success, cachestat returns 0. On error, -1 is returned, and errno
> > > > >     is set to indicate the error.
> > > > >
> > > > > ERRORS
> > > > >     EFAULT cstat points to an invalid address.
> > > > >
> > > > >     EINVAL invalid `cstat_size` or `flags`
> > > > >
> > > > >     EBADF  invalid file descriptor.
> > > > >
> > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > ---
> > > > >  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
> > > > >  arch/arm/tools/syscall.tbl                  |   1 +
> > > > >  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
> > > > >  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
> > > > >  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
> > > > >  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
> > > > >  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
> > > > >  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
> > > > >  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
> > > > >  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
> > > > >  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
> > > > >  arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
> > > > >  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
> > > > >  include/linux/fs.h                          |   3 +
> > > > >  include/linux/syscalls.h                    |   3 +
> > > > >  include/uapi/asm-generic/unistd.h           |   5 +-
> > > > >  include/uapi/linux/mman.h                   |   9 ++
> > > > >  init/Kconfig                                |  10 ++
> > > > >  kernel/sys_ni.c                             |   1 +
> > > > >  mm/filemap.c                                | 143 ++++++++++++++++++++
> > > > >  20 files changed, 186 insertions(+), 1 deletion(-)
> > > > >
> > > > ...
> > > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > index 08341616ae7a..d70d47b20700 100644
> > > > > --- a/mm/filemap.c
> > > > > +++ b/mm/filemap.c
> > > > ...
> > > > > @@ -3949,3 +3953,142 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
> > > > >       return try_to_free_buffers(folio);
> > > > >  }
> > > > >  EXPORT_SYMBOL(filemap_release_folio);
> > > > ...
> > > > > +#ifdef CONFIG_CACHESTAT_SYSCALL
> > > > > +/*
> > > > > + * The cachestat(5) system call.
> > > > > + *
> > > > > + * cachestat() returns the page cache statistics of a file in the
> > > > > + * bytes range specified by `off` and `len`: number of cached pages,
> > > > > + * number of dirty pages, number of pages marked for writeback,
> > > > > + * number of evicted pages, and number of recently evicted pages.
> > > > > + *
> > > > > + * An evicted page is a page that is previously in the page cache
> > > > > + * but has been evicted since. A page is recently evicted if its last
> > > > > + * eviction was recent enough that its reentry to the cache would
> > > > > + * indicate that it is actively being used by the system, and that
> > > > > + * there is memory pressure on the system.
> > > > > + *
> > > > > + * `off` and `len` must be non-negative integers. If `len` > 0,
> > > > > + * the queried range is [`off`, `off` + `len`]. If `len` == 0,
> > > > > + * we will query in the range from `off` to the end of the file.
> > > > > + *
> > > > > + * `cstat_size` allows users to obtain partial results. The syscall
> > > > > + * will copy the first `csstat_size` bytes to the specified userspace
> > > > > + * memory. It also makes the cachestat struct extensible - new fields
> > > > > + * can be added in the future without breaking existing usage.
> > > > > + * `cstat_size` must be a non-negative value that is no larger than
> > > > > + * the current size of the cachestat struct.
> > > > > + *
> > > > > + * The `flags` argument is unused for now, but is included for future
> > > > > + * extensibility. User should pass 0 (i.e no flag specified).
> > > > > + *
> > > > > + * Because the status of a page can change after cachestat() checks it
> > > > > + * but before it returns to the application, the returned values may
> > > > > + * contain stale information.
> > > > > + *
> > > > > + * return values:
> > > > > + *  zero    - success
> > > > > + *  -EFAULT - cstat points to an illegal address
> > > > > + *  -EINVAL - invalid arguments
> > > > > + *  -EBADF   - invalid file descriptor
> > > > > + */
> > > > > +SYSCALL_DEFINE6(cachestat, unsigned int, fd, off_t, off, size_t, len,
> > > > > +             size_t, cstat_size, struct cachestat __user *, cstat,
> > > > > +             unsigned int, flags)
> > > > > +{
> > > > > +     struct fd f = fdget(fd);
> > > > > +     struct address_space *mapping;
> > > > > +     struct cachestat cs;
> > > > > +     pgoff_t first_index = off >> PAGE_SHIFT;
> > > > > +     pgoff_t last_index =
> > > > > +             len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
> > > > > +
> > > > > +     if (off < 0 || cstat_size > sizeof(struct cachestat) || flags != 0)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     if (!f.file)
> > > > > +             return -EBADF;
> > > > > +
> > > >
> > > > It looks like we miss an fdput() before returning via the above error
> > > > checks.
> > >
> > > Ooops yeah I missed that. I'll fix it.
> > >
> > > >
> > > > The only other thing that stands out as a bit odd to me is the
> > > > cstat_size check and associated ability to return a partial cachestat
> > > > struct. Do other syscalls do anything like that? I'd think we'd want to
> > > > ensure we always at least return a fully populated cachestat struct,
> > > > even if it happened to be an old/compat version if the size does ever
> > > > increase. Hm?
> > >
> > > Not that I know of, but the idea is that the user might expect a smaller
> > > struct cachestat in their code (and allocate memory accordingly).
> > > With this cstat_size, we can make sure that the expansion of cachestat
> > > struct (with new fields) does not break existing user's code - we only
> > > copy part of the struct.
> > >
> >
> 
> I found a couple of syscalls doing something similar:
> 
> statfs64
> https://github.com/torvalds/linux/blob/master/fs/statfs.c#L168-L190
> 
> io_uring_enter:
> https://github.com/torvalds/linux/blob/master/io_uring/io_uring.c#L3232-L3243
> 
> It looks like these syscalls just error-out if the size argument does not match
> with the size of the kernel struct.
> 
> > Yup, I get the idea of supporting future expansion. The part that
> > doesn't make sense to me is allowing a partial copy of struct cachestat.
> > For example, what happens if the user passes a cstat_size of 2? We copy
> > out two bytes of the first field of the struct and return 0 for
> > "success?"
> >
> > The way I've commonly seen this sort of support for future expansion is
> > by versioning the structure and providing backwards compatibility for
> > old versions of the structure. I'd guess there are various ways to
> > implement that, but a simple example that comes to mind for me is
> > xfs_ioc_fsgeometry(). The caveat there is that it's an ioctl where IIRC
> > the command essentially changes when the structure size does, which
> > allows the kernel to determine what version is being used.
> 
> Hmm xfs_ioc_fsgeometry looks interesting. From my understanding,
> it basically has an argument that can take on a couple of values, each of
> which delineates a version, right? I can give that a try and see if it looks
> better (and maybe send a new version with this updated API).
> 

Yeah, though the difference is that the caller can determine the version
of struct to use based on the different ioctl command. We don't have
that luxury with the syscall, so I'm not sure the same kind of factoring
would make sense here.

From your examples above, I think it probably makes sense to enforce
that the size matches the actual structure. The question is if you want
to plan for future expansion and adding fields to the struct, what's the
accepted way to prepare for that now and design it into the api? If
nobody else can chime in with suggestions in the meantime, hopefully
linux-api can help. :)

Brian

> >
> > I'm not quite sure what the ideal way to do that for a syscall is. I
> > suppose the kernel could just check that the size param matches some
> > version of the structure it knows about and assume that. Or since you
> > have the flags field, you could require a flag to be passed in to return
> > values for any new fields. Or yet another option could be to pad out the
> > size of the userspace structure to support future expansion for the
> > foreseeable future without the need for such a flag.
> >
> > Perhaps this is something linux-api can help with?
> 
> I think I should definitely forward my patch series to linux-api. Thanks for
> the suggestion, Brian!
> 
> >
> > Brian
> >
> > > >
> > > > Brian
> > > >
> > > > > +     memset(&cs, 0, sizeof(struct cachestat));
> > > > > +     mapping = f.file->f_mapping;
> > > > > +     filemap_cachestat(mapping, first_index, last_index, &cs);
> > > > > +     fdput(f);
> > > > > +
> > > > > +     if (copy_to_user(cstat, &cs, cstat_size))
> > > > > +             return -EFAULT;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +#endif /* CONFIG_CACHESTAT_SYSCALL */
> > > > > --
> > > > > 2.30.2
> > > > >
> > > >
> > >
> >
> 

