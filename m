Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200356186B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKCR5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKCR5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599B1DA53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667498165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJJR4iR5+ugKjLbbYIb6Y9N5cv7dB2LX1UeXmZJCzLg=;
        b=F2WPrHEBlEtxXycesFomP1/XXdJJQtFegWeUnPGAKSqGLYUrTeAoKUIrufJzShWlWRBXHg
        LgUluSdVcTbvOtqRyAjgEQHmCPpKmi24OvpbL+2VaORm6MfHpLDkcF8Qx7i8ohCt4w4wxl
        W2jP1zxVvqfOXUK6wkGS6PmVeYHA3dQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-163-eLYlH0zlMhqKqSs8Y6B6eQ-1; Thu, 03 Nov 2022 13:56:04 -0400
X-MC-Unique: eLYlH0zlMhqKqSs8Y6B6eQ-1
Received: by mail-qt1-f197.google.com with SMTP id cp8-20020a05622a420800b003a4f4f7b621so2322919qtb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJJR4iR5+ugKjLbbYIb6Y9N5cv7dB2LX1UeXmZJCzLg=;
        b=P/NB4CDKGO8m0PPntWESPhCPzU0zj1bKuraadMKFzfRneu9/13wX7l1LlvxACUTieb
         fE4Tvs+Kivj9BbVWUCaEKTYMnb5PI6nMFRNDAy9S1eqWkM0wCQHJ19MBTu9daDp3K/Vq
         9Q5EwKhAmCqzppXtxC1hv6TRf7CNKybm4nBDazeJZeO4XG/8RK+Sy77j/o3Iji3dbNH/
         ZdBuwmieSluVGJnQ31DcfFGbzf0zsL6VWysl7OCS3imisE0TksaG5GfEhk2FeIZWsfxw
         js2bP/I5+HU+powIYTmHa0MgLiqPQuC5o10enlMAxNkngH0mu0Wrtj0bjd+FlcYtLZ6O
         l5kw==
X-Gm-Message-State: ACrzQf1aRBjpyks85jm3XNKXqJwJ7r/5HvTxI+hZHMox6ipSMKzJml7C
        eM/FNxxWfKVi2NJmnrZAP81v8YKwraMShaQCWAFkzflV2sU2CsMjzCnj8XmWW5bzVC7rEsyqZ/D
        xUquGIzBujYtzkqbMWr/vfgLJ
X-Received: by 2002:ae9:ec19:0:b0:6ea:d0cd:a4ed with SMTP id h25-20020ae9ec19000000b006ead0cda4edmr22930153qkg.472.1667498164238;
        Thu, 03 Nov 2022 10:56:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7iPvcgAu3eL/1xePl7SgFmQ4Hn6DrpgbAeo3IVHTl3ixTcvbJc/N/GDydkySQ5WUcCJFrC6w==
X-Received: by 2002:ae9:ec19:0:b0:6ea:d0cd:a4ed with SMTP id h25-20020ae9ec19000000b006ead0cda4edmr22930137qkg.472.1667498163990;
        Thu, 03 Nov 2022 10:56:03 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a450a00b006cbc6e1478csm1230727qkp.57.2022.11.03.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:56:03 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:56:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
Message-ID: <Y2QAsrDRBAg6bJet@x1n>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-4-vishal.moola@gmail.com>
 <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
 <Y2K+y7wnhC4vbnP2@x1n>
 <Y2LDL8zjgxDPCzH9@casper.infradead.org>
 <Y2LWonzCdWkDwyyr@x1n>
 <CAJHvVcj-j6EWm5vQ74Uv1YWHbmg6-BP0hOEO2L9jRADJPEwb1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcj-j6EWm5vQ74Uv1YWHbmg6-BP0hOEO2L9jRADJPEwb1A@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:34:38AM -0700, Axel Rasmussen wrote:
> On Wed, Nov 2, 2022 at 1:44 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Nov 02, 2022 at 07:21:19PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 02, 2022 at 03:02:35PM -0400, Peter Xu wrote:
> > > > Does the patch attached look reasonable to you?
> > >
> > > Mmm, no.  If the page is in the swap cache, this will be "true".
> >
> > It will not happen in practise, right?
> >
> > I mean, shmem_get_folio() should have done the swap-in, and we should have
> > the page lock held at the meantime.
> >
> > For anon, mcopy_atomic_pte() is the only user and it's passing in a newly
> > allocated page here.
> >
> > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index 3d0fef3980b3..650ab6cfd5f4 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -64,7 +64,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > > >     pte_t _dst_pte, *dst_pte;
> > > >     bool writable = dst_vma->vm_flags & VM_WRITE;
> > > >     bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > > > -   bool page_in_cache = page->mapping;
> > > > +   bool page_in_cache = page_mapping(page);
> > >
> > > We could do:
> > >
> > >       struct page *head = compound_head(page);
> > >       bool page_in_cache = head->mapping && !PageMappingFlags(head);
> >
> > Sounds good to me, but it just gets a bit complicated.
> >
> > If page_mapping() doesn't sound good, how about we just pass that over from
> > callers?  We only have three, so quite doable too.
> 
> For what it's worth, I think I like Matthew's version better than the
> original patch. This is because, although page_mapping() looks simpler
> here, looking into the definition of page_mapping() I feel it's
> handling several cases, not all of which are relevant here (or, as
> Matthew points out, would actually be wrong if it were possible to
> reach those cases here).
> 
> It's not clear to me what is meant by "pass that over from callers"?
> Do you mean, have callers pass in true/false for page_in_cache
> directly?

Yes.

> 
> That could work, but I still think I prefer Matthew's version slightly
> better, if only because this function already takes a lot of
> arguments.

IMHO that's not an issue, we can merge them into flags, cleaning things
alongside.

The simplest so far is still just to use page_mapping() to me, but no
strong opinion here.

If to go with Matthew's patch, it'll be great if we can add a comment
showing what we're doing (something like "Unwrapped page_mapping() but
avoid looking into swap cache" would be good enough to me).

Thanks,

-- 
Peter Xu

