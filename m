Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B4B645E42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLGQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLGQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4DD3D913
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670428778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ds86l2H1ZNflWHy4/S2aLn7l+F5D9ot2q/ERt4zH3Q=;
        b=JEch1RRBNO0MdgE3G6aWp9YkG9SmLeZjc7dDKcjN9Kz3kCzPALAbz1seYx/5HqEtsfiUG1
        uyZFl1rT3hBTw1ysUrD93V/O+lM2d3o7fEks02Loa5du8jTz60tzHEn8gr6G2kVNoDimOm
        4USBtNd3ye9UItro4IptAX4NRXBr8uM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-_zLY8_C2NAKxvZkofUuyPA-1; Wed, 07 Dec 2022 10:59:36 -0500
X-MC-Unique: _zLY8_C2NAKxvZkofUuyPA-1
Received: by mail-qv1-f69.google.com with SMTP id o13-20020a056214108d00b004c6fb4f16dcso35757311qvr.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ds86l2H1ZNflWHy4/S2aLn7l+F5D9ot2q/ERt4zH3Q=;
        b=2xVVFcLdb/guVl/cfXHSFbDXxj5JdivYSja/PAHrESBICm6m/M05Bk4IYjS4cudH+6
         SqdPtOS22LCEbZsMSvHTK02j2D0NII1mXf1awYRRsGPQ4ADhvlpVsuFcfotnFCmuW6m0
         NRLYMB8CK4CJ5/NRCJQLrl//CqtYsC0q0v8zhbxZQQvLFijXoFymlX7rXzuKJYteEThC
         JP5F69qf74rxXer1Lg9uQiA0yCEakcT15zw2jlFDhXtszhrUaU2JZ6On2an/JlI202Yi
         MlAA5l6rixFWWQoWPRdqDsKHE7PQefOAJlpg47yNb3EN9hPfzUd0wH4OLBz/qirXVrGS
         LC3w==
X-Gm-Message-State: ANoB5pntgNB58Z9LEWpoVC+PakwD0BYkk+XtM4/Q0iFp4uXaVySyZqEV
        7pkMUB5CLbSpPBwWH7hE5gzO84IEWpIhyVGIakzsWxKkV1O5jYnnFyPIt/2aZSATJPWzJDjRyim
        dEYxmMEjDf3lbZz4H/qNY5XXz
X-Received: by 2002:a05:6214:2b97:b0:4c7:734a:9047 with SMTP id kr23-20020a0562142b9700b004c7734a9047mr1202638qvb.50.1670428776079;
        Wed, 07 Dec 2022 07:59:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf56ieISDBHezYDAzZ+VpWdZ5V6o2u1bx+Hff3p4ac7yFjt3BUL6MXewhOVSKr+NI9MhWdKWhA==
X-Received: by 2002:a05:6214:2b97:b0:4c7:734a:9047 with SMTP id kr23-20020a0562142b9700b004c7734a9047mr1202631qvb.50.1670428775800;
        Wed, 07 Dec 2022 07:59:35 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bj7-20020a05620a190700b006cfc1d827cbsm17170597qkb.9.2022.12.07.07.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:59:35 -0800 (PST)
Date:   Wed, 7 Dec 2022 10:59:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ives van Hoorne <ives@codesandbox.io>,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hugh@veritas.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH RFC] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
Message-ID: <Y5C4Zu9sDvZ7KiCk@x1n>
References: <20221202122748.113774-1-david@redhat.com>
 <Y4oo6cN1a4Yz5prh@x1n>
 <690afe0f-c9a0-9631-b365-d11d98fdf56f@redhat.com>
 <19800718-9cb6-9355-da1c-c7961b01e922@redhat.com>
 <Y45duzmGGUT0+u8t@x1n>
 <92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com>
 <Y4+zw4JU7JMlDHbM@x1n>
 <5a626d30-ccc9-6be3-29f7-78f83afbe5c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a626d30-ccc9-6be3-29f7-78f83afbe5c4@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 02:33:58PM +0100, David Hildenbrand wrote:
> On 06.12.22 22:27, Peter Xu wrote:
> > On Tue, Dec 06, 2022 at 05:28:07PM +0100, David Hildenbrand wrote:
> > > > If no one is using mprotect() with uffd-wp like that, then the reproducer
> > > > may not be valid - the reproducer is defining how it should work, but does
> > > > that really stand?  That's why I said it's ambiguous, because the
> > > > definition in this case is unclear.
> > > 
> > > There are interesting variations like:
> > > 
> > > mmap(PROT_READ, MAP_POPULATE|MAP_SHARED)
> > > uffd_wp()
> > > mprotect(PROT_READ|PROT_WRITE)
> > > 
> > > Where we start out with all-write permissions before we enable selective
> > > write permissions.
> > 
> > Could you elaborate what's the difference of above comparing to:
> > 
> > mmap(PROT_READ|PROT_WRITE, MAP_POPULATE|MAP_SHARED)
> > uffd_wp()
> > 
> > ?
> 
> That mapping would temporarily allow write access. I'd imagine that
> something like that might be useful when atomically replacing an existing
> mapping (MAP_FIXED), and the VMA might already be in use by other threads.
> or when you really want to catch any possible write access.
> 
> For example, libvhost-user.c in QEMU uses for ordinary postcopy:
> 
>         /*
>          * In postcopy we're using PROT_NONE here to catch anyone
>          * accessing it before we userfault.
>          */
>         mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
>                          PROT_NONE, MAP_SHARED | MAP_NORESERVE,
>                          vmsg->fds[0], 0);

I assume this is for missing mode only.  More on wr-protect mode below.

Personally I don't see immediately on whether this is needed.  If the
process itself is trusted then it should be under control of anyone who
will be accessing the pages..  If the other threads are not trusted, then
there's no way to stop anyone from mprotect(RW) after mprotect(NONE)
anyway..

So I may not really get the gut of it.

Another way to make sure no one access it is right after receiving the
memory range from QEMU (VhostUserMemoryRegion), if VuDev.postcopy_listening
is set, then we register the range with UFFD missing immediately.  After
all if postcopy_listening is set it means we passed the advise phase
already (VHOST_USER_POSTCOPY_ADVISE). Any potential access will be blocked
until QEMU starts to read on that uffd.

> 
> I'd imagine, when using uffd-wp (VM snapshotting with shmem?) one might use
> PROT_READ instead before the write-protection is properly set. Because read
> access would be fine in the meantime.

It'll be different for wr-protect IIUC, because unlike missing protections,
we don't worry about writes happening before UFFDIO_WRITEPROTECT.

IMHO the solo thing the vhost-user proc needs to do is one
UFFDIO_WRITEPROTECT for each of the range when QEMU tells it to, then it'll
be fine.  Pre-writes are fine.

Sorry I probably went a bit off-topic.  I just want to make sure I don't
miss any real use case of having mprotect being useful for uffd-wp being
there, because that used to be a grey area for me.

> 
> But I'm just pulling use cases out of my magic hat ;) Nothing stops user
> space from doing things that are not clearly forbidden (well, even then
> users might complain, but that's a different story).

Yes, I think those are always fine but the user just cannot assume it'll
work as they assumed how it will work.

If "doing things that are not clearly forbidden" triggers a host warning or
crash that's a bug, OTOH if the outcome is limited to the process itself
then from kernel pov I think we're good.  I used to even thought about
forbid mprotect() on uffd-wp but I'm not sure whether it's good idea either.

Let's see whether I missed something above, if so I'll rethink.

Thanks,

-- 
Peter Xu

