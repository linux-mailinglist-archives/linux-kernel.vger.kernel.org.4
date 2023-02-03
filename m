Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2FD689C60
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBCO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBCO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:57:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CAC9EE01
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675436185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1i7X5PzCBbRsJjDeQvGRkONq09RnZNi3b/olrwD/UP0=;
        b=YttA7QJGyA3opiXWl1sHDSJ4GbyxPOjCuzj63s18ovPbhrZYuFXLPqNdW1qRic/kn6DwGS
        079PGF4aEnIefWiOdgKmRMN5Qgbqmxx9NufOnUju1H/lIQbCF7zK9VgFFBsm9UvYIpjvxX
        AwYLLaYyZNLsYUgu86EKYsdRMxcHFmA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-vbM-x8fRM6mXLSI5p5R3Gg-1; Fri, 03 Feb 2023 09:56:24 -0500
X-MC-Unique: vbM-x8fRM6mXLSI5p5R3Gg-1
Received: by mail-qt1-f198.google.com with SMTP id u11-20020ac8050b000000b003ba115c1b72so219861qtg.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i7X5PzCBbRsJjDeQvGRkONq09RnZNi3b/olrwD/UP0=;
        b=Nlff6c018mNesEoMCLN7eUMbfgLOJqyffakBkB4I3AxaGrw3VGDiFZmXNwtp3mRlwO
         wep+E92MaT+UUhiVzPi6m+jUNPF5RZEj32j8ci2irwTTMmAmYL8Iqis+R3sxYe80qopx
         wEYIze729WAkxkMnAuunPsqauoG4eWx3odjumeCeOGpeGh93jJXYysMmFp8jxD5rtRbV
         RgaFBf6MchcBj4XQs5CkTPG1qKfc71h5T2YHvG3bbe7Qg3JcWuLHhPJbTw7mkQFii5zb
         HPUiPXAJAcl0PtXOxgu6SGUQWvIHqALuDvoldWe9AVP+/XaeyzclRJDq+4dOvsraFPMH
         xJUg==
X-Gm-Message-State: AO0yUKUJ4VIPTQoXqspe8WDkQbsSz7mK76YYe5wiE4F8773AOzjPSxRc
        zqpMHF4pDrGQTgu5RrKRpXUFCCA8AFo3Pi6kiIsZ9mNgQDVsUn7adqkhBroradFfRGIvGacGst1
        Y+tjyiQTVmWlZLPy+inomJfUs
X-Received: by 2002:a05:622a:a15:b0:3b8:695b:aad1 with SMTP id bv21-20020a05622a0a1500b003b8695baad1mr17767763qtb.1.1675436183657;
        Fri, 03 Feb 2023 06:56:23 -0800 (PST)
X-Google-Smtp-Source: AK7set+zyBMgYG3jpeNczzlTJfUDlZXixdNcX7huiAdKK4p5M4hddFKCUFkWqcjtL35shPysL6E0fg==
X-Received: by 2002:a05:622a:a15:b0:3b8:695b:aad1 with SMTP id bv21-20020a05622a0a1500b003b8695baad1mr17767736qtb.1.1675436183360;
        Fri, 03 Feb 2023 06:56:23 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a27cf00b006fba0a389a4sm1881958qkp.88.2023.02.03.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:56:22 -0800 (PST)
Date:   Fri, 3 Feb 2023 09:56:21 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
Message-ID: <Y90gleGzaqD6jJ8n@x1n>
References: <20230201034137.2463113-1-stevensd@google.com>
 <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
 <Y9rRCN9EfqzwYnDG@x1n>
 <CAD=HUj4FjuLpihQLGLzUu82vr5fdFFxfnyKNhApC6L67F5iV4g@mail.gmail.com>
 <CAHbLzko_cXrOQCsQC3g_id06Jkcg3=9dsVe+MwuzAh+iC9dDDA@mail.gmail.com>
 <Y9wbmuEq0QjZATE6@x1n>
 <CAD=HUj6E8e4QFPHgADQ2Rspr6BnAa8n08WtyqZhsJ5iQ9qR1+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=HUj6E8e4QFPHgADQ2Rspr6BnAa8n08WtyqZhsJ5iQ9qR1+w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 03:09:55PM +0900, David Stevens wrote:
> > > > I don't know if it's necessary to go that far. Userfaultfd plus shmem
> > > > is inherently brittle. It's possible for userspace to bypass
> > > > userfaultfd on a shmem mapping by accessing the shmem through a
> > > > different mapping or simply by using the write syscall.
> >
> > Yes this is possible, but this is user-visible operation - no matter it was
> > a read()/write() from another process, or mmap()ed memory accesses.
> > Khugepaged merges ptes in a way that is out of control of users.  That's
> > something the user can hardly control.
> >
> > AFAICT currently file-based uffd missing mode all works in that way.  IOW
> > the user should have full control of the file/inode under the hood to make
> > sure there will be nothing surprising.  Otherwise I don't really see how
> > the missing mode can work solidly since it's page cache based.
> >
> > > > It might be sufficient to say that the kernel won't directly bypass a
> > > > VMA's userfaultfd to collapse the underlying shmem's pages. Although on
> > > > the other hand, I guess it's not great for the presence of an unused
> > > > shmem mapping lying around to cause khugepaged to have user-visible
> > > > side effects.
> >
> > Maybe it works for your use case already, for example, if in your app the
> > shmem is only and always be mapped once?  However that doesn't seem like a
> > complete solution to me.
> 
> We're using userfaultfd for guest memory for a VM. We do have
> sandboxed device processes. However, thinking about it a bit more,
> this approach would probably cause issues with device hotplug.
> 
> > There's nothing that will prevent another mapping being established, and
> > right after that happens it'll stop working, because khugepaged can notice
> > that new mm/vma which doesn't register with uffd at all, and thinks it a
> > good idea to collapse the shmem page cache again.  Uffd will silently fail
> > in another case even if not immediately in your current app/reproducer.
> >
> > Again, I don't think what I propose above is anything close to good.. It'll
> > literally disable any collapsing possibility for a shmem node as long as
> > any small portion of the inode mapping address space got registered by any
> > process with uffd.  I just don't see any easier approach so far.
>
> Maybe we can make things easier by being more precise about what bug
> we're trying to fix. Strictly speaking, I don't think what we're
> concerned about is whether or not userfaultfd is registered on a
> particular VMA at a particular point in time. I think what we're actually
> concerned about is that when userspace has a page with an armed
> userfaultfd that it knows is missing, that page should not be filled by
> khugepaged. If userspace doesn't know that a userfaultfd armed page is
> missing, then even if khugepaged fills that page, as far as userspace is
> concerned, the page was filled by khugepaged before userfaultfd was
> armed.

IMHO that's a common issue to solve with registrations on uffd missing
mode, and what I'm aware of as a common solution to it is, for shmem,
punching holes where we do hope to receive a message.  It should only
happen _after_ the missing mode registration is successful.

At least that's what we do with QEMU's postcopy.

> 
> If that's a valid way to look at it, then I think the fact that
> collapse_file locks hpage provides most of the necessary locking.

The hpage is still not visible to the page cache at all, not until it is
used to replace the small pages, right?  Do you mean "when holding the page
lock of the existing small pages"?

> From there, we need to check whether there are any VMAs with armed
> userfaultfds that might have observed a missing page. I think that can be
> done while iterating over VMAs in retract_page_tables without acquiring

I am not 100% sure how this works.  AFAICT we retract pgtables only if we
have already collapsed the page.  I don't see how it can be undone?

> any mmap_lock by adding some memory barriers to userfaultfd_set_vm_flags
> and userfaultfd_armed. It is possible that a userfaultfd gets registered
> on a particular VMA after we check its flags but before the collapse
> finishes. I think the only observability hole left would be operations on
> the shmem file descriptor that don't actually lock pages
> (e.g. SEEK_DATA/SEEK_HOLE), which are hopefully solvable with some more
> thought.

So it's possible that I just didn't grasp the fundamental idea of the new
proposal on how it works at all.  If you're confident with the idea I'd be
also glad to read the patch directly; maybe that'll help to explain stuff.

Thanks,

-- 
Peter Xu

