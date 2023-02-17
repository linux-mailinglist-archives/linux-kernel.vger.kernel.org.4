Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9C69B1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjBQRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQRgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:36:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659576FF02
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676655364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtVPzPhu4Ul2QiH4Cq+Qr2IaY2er2+POQw31zFIVv4E=;
        b=iXLTf2F97QnmaDwwPBYuZ2ag+mjjoXUbtGJfQ7pdq2j7ZnK5RRz3ZO8tLD8lva9+H+aqoO
        R1fwycT00jOXi+1mU0t/Tb/RXAWsto8dJEPftvSX7vRLLMMk/RevqZOWyWW6+Z/J/5QnDx
        OqDdRet9DZtB4OkCOA6C4sjBFS9k/sU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-N9EJAyucN1-6XKaDeR5AIA-1; Fri, 17 Feb 2023 12:36:01 -0500
X-MC-Unique: N9EJAyucN1-6XKaDeR5AIA-1
Received: by mail-qk1-f197.google.com with SMTP id 127-20020a370785000000b007259083a3c8so287932qkh.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtVPzPhu4Ul2QiH4Cq+Qr2IaY2er2+POQw31zFIVv4E=;
        b=iDJE4pt2eEem38I+M1EhxEk111pWB3nybUWMevbWta7NZdVEGdohEtIK/cTYpJoPDQ
         r4q0o4stsppAv/5qsLcmr4GA1H81qNtp80o0xDG5f8k4kGvLUF8CZLm+95fRkaUKXLVi
         ZRlMoJjGN0HtQRP6kd/4+vA57gGiDT9ohjC4OwDvDzz0NxXqKGUtrOK6QrQBXN/8RUhj
         /saSgAGN1UniGvlFIzC9P3lKhgvp/zuDOLl/9B0DD5mtGBq//SHPlqGnvO9NLgehBHE2
         nB6/xI3642rpx8qbuzwg7uqa6p2nrlRm5g00wQBguaph7sfC3WQnPkHP5aOKkXgiYc0t
         W1KA==
X-Gm-Message-State: AO0yUKWrvWbrWsZD7wqk5UmbhkQAzE7TnVxioSbElWe7Dicet9tpOyB3
        VfZkuwfuoG55ZyCFPil0rHObwP+uVbuAIjlzq8fs+kvEkEkNQiFQt4qUQYre81aZKrTfrEYj66P
        uOuBtXWg6lOvbYfBsEWWn56j0
X-Received: by 2002:a0c:dd81:0:b0:56b:e73e:e925 with SMTP id v1-20020a0cdd81000000b0056be73ee925mr2673030qvk.0.1676655360380;
        Fri, 17 Feb 2023 09:36:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/8nf/4lX6QnE7xuq1ZCx56boZT4qEUHUTefLAuAgsOwvYJ74D42p4knfb8q7SabnCSSWtEaQ==
X-Received: by 2002:a0c:dd81:0:b0:56b:e73e:e925 with SMTP id v1-20020a0cdd81000000b0056be73ee925mr2673002qvk.0.1676655359990;
        Fri, 17 Feb 2023 09:35:59 -0800 (PST)
Received: from x1n ([70.30.145.63])
        by smtp.gmail.com with ESMTPSA id o62-20020a374141000000b0073b676274e7sm3618630qka.94.2023.02.17.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 09:35:59 -0800 (PST)
Date:   Fri, 17 Feb 2023 12:35:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/userfaultfd: Support WP on multiple VMAs
Message-ID: <Y++6+ihv/lzUgkWo@x1n>
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
 <f4b6cd03-28d7-b041-6dd4-46ac0812fc9b@redhat.com>
 <Y+6RUjv/K6RkwKQ7@x1n>
 <53dc6054-07eb-f97b-7b2f-558f02d1b90a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53dc6054-07eb-f97b-7b2f-558f02d1b90a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 09:53:47AM +0100, David Hildenbrand wrote:
> On 16.02.23 21:25, Peter Xu wrote:
> > On Thu, Feb 16, 2023 at 10:37:36AM +0100, David Hildenbrand wrote:
> > > On 16.02.23 10:16, Muhammad Usama Anjum wrote:
> > > > mwriteprotect_range() errors out if [start, end) doesn't fall in one
> > > > VMA. We are facing a use case where multiple VMAs are present in one
> > > > range of interest. For example, the following pseudocode reproduces the
> > > > error which we are trying to fix:
> > > > - Allocate memory of size 16 pages with PROT_NONE with mmap
> > > > - Register userfaultfd
> > > > - Change protection of the first half (1 to 8 pages) of memory to
> > > >     PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> > > > - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
> > > >     out.
> > > 
> > > I think, in QEMU, with partial madvise()/mmap(MAP_FIXED) while handling
> > > memory remapping during reboot to discard pages with memory errors, it would
> > > be possible that we get multiple VMAs and could not enable uffd-wp for
> > > background snapshots anymore. So this change makes sense to me.
> > 
> > Any pointer for this one?
> 
> In qemu, softmmu/physmem.c:qemu_ram_remap() is instructed on reboot to remap
> VMAs due to MCE pages. We apply QEMU_MADV_MERGEABLE (if configured for the
> machine) and QEMU_MADV_DONTDUMP (if configured for the machine), so the
> kernel could merge the VMAs again.
> 
> (a) From experiments (~2 years ago), I recall that some VMAs won't get
> merged again ever. I faintly remember that this was the case for hugetlb. It
> might have changed in the meantime, haven't tried it again. But looking at
> is_mergeable_vma(), we refuse to merge with vma->vm_ops->close. I think that
> might be set for hugetlb (hugetlb_vm_op_close).
> 
> (b) We don't consider memory-backend overrides, like toggling a backend
> QEMU_MADV_MERGEABLE or QEMU_MADV_DONTDUMP from backends/hostmem.c, resulting
> in multiple unmergable VMAs.
> 
> (c) We don't consider memory-backend  mbind() we don't re-apply the mbind()
> policy, resulting in unmergable VMAs.
> 
> 
> The correct way to handle (b) and (c) would be to notify the memory backend,
> to let it reapply the correct flags, and to reapply the mbind() policy (I
> once had patches for that, have to look them up again).

Makes sense.  There should be a single entry for reloading a RAM with the
specified properties rather than randomly applying when we noticed.

> 
> So in these rare setups with MCEs, we would be getting more VMAs and while
> the uffd-wp registration would succeed, uffd-wp protection would fail.
> 
> Not that this is purely theoretical, people don't heavily use background
> snapshots yet, so I am not aware of any reports. Further, I consider it only
> to happen very rarely (MCE+reboot+a/b/c).
> 
> So it's more of a "the app doesn't necessarily keep track of the exact
> VMAs".

Agree.

> 
> [I am not sure sure how helpful remapping !anon memory really is, we should
> be getting the same messed-up MCE pages from the fd again, but that's a
> different discussion I guess]

Yes it sounds like a bug to me.  I'm afraid what it really wanted here is
actually not remap but truncation in strict semantics.  I think the
hwpoison code in QEMU is just slightly buggy all around - e.g. I found that
qemu_ram_remap() probably wants to use host psize not the guest.

But let's not pollute the mailing lists anymore; thanks for the context!

-- 
Peter Xu

