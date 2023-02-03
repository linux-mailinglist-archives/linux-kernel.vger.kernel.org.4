Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E437688F81
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjBCGKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjBCGKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:10:40 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E18C1F8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:10:09 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u27so4225191ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 22:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VqL0SQ3sFdYoa5P5qE3J+IqmzxCHfdLil4//qOukaOY=;
        b=Ug0du6ZsUuXTJu6b3g/CGY8kqC4yyxZB4v/TH0a89VeM3IhOpSyX55eq8qEs/jU1OC
         lISjBlt0MuhKlmyU8/vzTW3o0VULRH0LDGyH814Tn92cJLfR6LZj1HxF7Tcmn0YNfW3+
         s+IvXr32+m0vKdefX5RYLBPOpwCRp/xQNrA+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqL0SQ3sFdYoa5P5qE3J+IqmzxCHfdLil4//qOukaOY=;
        b=SCoiVKN5eq+3Z4maZy7GW6247pXpaVfXHj56+CC9NTafrzXQvE2ou0Uk+rh6tj/trn
         OBOV3/lqsDPhaUHzpNgPCsHBwFzuHIYn81golhLZNvNlL6Y8LISenM+ZZF4Y5Izs6DBz
         otRixvgrM4sA2zsEmwGTw6dr9a2q0847wUsDTQR+71OY4hNaH7xbY14yu8EbGFRQmOcI
         CP6+Ck0f1SNVXqqQzh5DgYFthOR0G2Dyei7GHApB1Ow882SKPH8+UBIv7GrtZNcz3DyQ
         9CwGcOebTY8zVo3m0orWXKQTbMGG2bTK5Lb88vO0v0SLbQRdD78r0CRpRPZBeVMytVU8
         pS8g==
X-Gm-Message-State: AO0yUKXfbs1dvWFsfrtt+b/0rRK4ZQ3aOmCQ8GX/f4BOSl7PslNHUq4m
        fjN91A3Ho+UQeuTpW5fzyHcItDCDKZwtXk0lJNNw2g==
X-Google-Smtp-Source: AK7set9VpFMQa1cflzV+xHjqLU7Pbdkzpmn80Ts81v7rzpqniWrtnJHa39GjAeGUKP5DTjFoa3kLC/wUf05URmhGwtY=
X-Received: by 2002:a2e:8781:0:b0:290:5b7c:4838 with SMTP id
 n1-20020a2e8781000000b002905b7c4838mr1659971lji.51.1675404607785; Thu, 02 Feb
 2023 22:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20230201034137.2463113-1-stevensd@google.com> <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
 <Y9rRCN9EfqzwYnDG@x1n> <CAD=HUj4FjuLpihQLGLzUu82vr5fdFFxfnyKNhApC6L67F5iV4g@mail.gmail.com>
 <CAHbLzko_cXrOQCsQC3g_id06Jkcg3=9dsVe+MwuzAh+iC9dDDA@mail.gmail.com> <Y9wbmuEq0QjZATE6@x1n>
In-Reply-To: <Y9wbmuEq0QjZATE6@x1n>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 3 Feb 2023 15:09:55 +0900
Message-ID: <CAD=HUj6E8e4QFPHgADQ2Rspr6BnAa8n08WtyqZhsJ5iQ9qR1+w@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I don't know if it's necessary to go that far. Userfaultfd plus shmem
> > > is inherently brittle. It's possible for userspace to bypass
> > > userfaultfd on a shmem mapping by accessing the shmem through a
> > > different mapping or simply by using the write syscall.
>
> Yes this is possible, but this is user-visible operation - no matter it was
> a read()/write() from another process, or mmap()ed memory accesses.
> Khugepaged merges ptes in a way that is out of control of users.  That's
> something the user can hardly control.
>
> AFAICT currently file-based uffd missing mode all works in that way.  IOW
> the user should have full control of the file/inode under the hood to make
> sure there will be nothing surprising.  Otherwise I don't really see how
> the missing mode can work solidly since it's page cache based.
>
> > > It might be sufficient to say that the kernel won't directly bypass a
> > > VMA's userfaultfd to collapse the underlying shmem's pages. Although on
> > > the other hand, I guess it's not great for the presence of an unused
> > > shmem mapping lying around to cause khugepaged to have user-visible
> > > side effects.
>
> Maybe it works for your use case already, for example, if in your app the
> shmem is only and always be mapped once?  However that doesn't seem like a
> complete solution to me.

We're using userfaultfd for guest memory for a VM. We do have
sandboxed device processes. However, thinking about it a bit more,
this approach would probably cause issues with device hotplug.

> There's nothing that will prevent another mapping being established, and
> right after that happens it'll stop working, because khugepaged can notice
> that new mm/vma which doesn't register with uffd at all, and thinks it a
> good idea to collapse the shmem page cache again.  Uffd will silently fail
> in another case even if not immediately in your current app/reproducer.
>
> Again, I don't think what I propose above is anything close to good.. It'll
> literally disable any collapsing possibility for a shmem node as long as
> any small portion of the inode mapping address space got registered by any
> process with uffd.  I just don't see any easier approach so far.

Maybe we can make things easier by being more precise about what bug
we're trying to fix. Strictly speaking, I don't think what we're
concerned about is whether or not userfaultfd is registered on a
particular VMA at a particular point in time. I think what we're
actually concerned about is that when userspace has a page with an
armed userfaultfd that it knows is missing, that page should not be
filled by khugepaged. If userspace doesn't know that a userfaultfd
armed page is missing, then even if khugepaged fills that page, as far
as userspace is concerned, the page was filled by khugepaged before
userfaultfd was armed.

If that's a valid way to look at it, then I think the fact that
collapse_file locks hpage provides most of the necessary locking. From
there, we need to check whether there are any VMAs with armed
userfaultfds that might have observed a missing page. I think that can
be done while iterating over VMAs in retract_page_tables without
acquiring any mmap_lock by adding some memory barriers to
userfaultfd_set_vm_flags and userfaultfd_armed. It is possible that a
userfaultfd gets registered on a particular VMA after we check its
flags but before the collapse finishes. I think the only observability
hole left would be operations on the shmem file descriptor that don't
actually lock pages (e.g. SEEK_DATA/SEEK_HOLE), which are hopefully
solvable with some more thought.

-David

> Thanks,
>
> --
> Peter Xu
>
