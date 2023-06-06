Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13648724DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjFFUAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbjFFUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FB410F2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686081562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7UrpOrQtg56crpEBvYaRSePkWzv3vUaAoezpCMlFFYA=;
        b=I1m2ksYOMc3aprvQe2ABCDZUyqlB3AgT1Bk0W5mIrhHdxeIr/7SuuX43Rzrr5MCFC5c4ml
        iXgSJ/DGQJk6ik1qIC7KcHf3zYmMJNeK7/j7K8JCD5ljcWq2omKJcUsEyya9IBvtOvBD1z
        M1fitx2wy/AUe8c/SJid/DMk9l8terY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Tby6d4B5NKeRbxYvS98HbA-1; Tue, 06 Jun 2023 15:59:21 -0400
X-MC-Unique: Tby6d4B5NKeRbxYvS98HbA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75e681229c5so63432285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686081561; x=1688673561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UrpOrQtg56crpEBvYaRSePkWzv3vUaAoezpCMlFFYA=;
        b=TuNpaAjIxg+AIUo6DHrs1X7YX3unuc1b0eKurpmLsW4lD6uSZzo3SsBdHIA820Es9M
         pg9ahHWZVd58b48By465MiwkrXTJxy65onO/JNkZUN2K5Y5rNmMzCAH+YJ87N653c2nk
         SoW8YhdJwv2kCgKcyEXVn+Mwm/4L6LflxvFq7XdYmZoobrG+qHrIRvD7ju4d6EEJj3pq
         XdmLABCh+pF/zRlqx1y0PelHmnT7tjM9NGvCxyXE7x3d3o7Xi4P03450h0iJldFc13N5
         GXcQJGg52Vzet7lGNazHz9HdE42W0ZDcnR5PqV6O2fQTbHMLurhA77mh2FpfdWAq3gKi
         almw==
X-Gm-Message-State: AC+VfDy6ULi4hAqWQYnc62O5YrtpVeNqalF4uAE4PWlND6jYfrKS0mFO
        gjMUYGMjz3Dc//iLRKrhk9kVMw/12tCFPtxzoOLlvBN+E7bs5n0/ph0ulfBwYLSd4kH6NUzD0Gs
        koMTzLya0KUoAcxhJylaOFMMA
X-Received: by 2002:a05:620a:950:b0:75b:23a1:69e9 with SMTP id w16-20020a05620a095000b0075b23a169e9mr2966964qkw.0.1686081560844;
        Tue, 06 Jun 2023 12:59:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BF0OXQlbyP+trA92coc66WCmRXcRkq82pLEgKOfgWrEmj9w4q8xBPweU77nPaiyb+F7D/og==
X-Received: by 2002:a05:620a:950:b0:75b:23a1:69e9 with SMTP id w16-20020a05620a095000b0075b23a169e9mr2966939qkw.0.1686081560557;
        Tue, 06 Jun 2023 12:59:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id n15-20020a05620a152f00b0075932cd3ca0sm5109347qkk.69.2023.06.06.12.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:59:19 -0700 (PDT)
Date:   Tue, 6 Jun 2023 15:59:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 4/4] mm: Make most walk page paths with
 pmd_trans_unstable() to retry
Message-ID: <ZH+QFvOuE0Egxsqi@x1n>
References: <20230602230552.350731-1-peterx@redhat.com>
 <20230602230552.350731-5-peterx@redhat.com>
 <CAHbLzkp_tzN8SZVeWTKxtMAnFSzUvk2064KFg3quj=raOSHPrA@mail.gmail.com>
 <ZH41YzZ0DBoF8csH@x1n>
 <CAHbLzkq-dE4B5k+4KV5YtSJRXf+x61V8iBte6Z=Afbh=_oCJtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkq-dE4B5k+4KV5YtSJRXf+x61V8iBte6Z=Afbh=_oCJtw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 12:12:03PM -0700, Yang Shi wrote:
> > > > @@ -1539,8 +1544,10 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
> > > >                 return err;
> > > >         }
> > > >
> > > > -       if (pmd_trans_unstable(pmdp))
> > > > +       if (pmd_trans_unstable(pmdp)) {
> > > > +               walk->action = ACTION_AGAIN;
> > > >                 return 0;
> > >
> > > Had a quick look at the pagemap code, I agree with your analysis,
> > > "returning 0" may mess up pagemap, retry should be fine. But I'm
> > > wondering whether we should just fill in empty entries. Anyway I don't
> > > have a  strong opinion on this, just a little bit concerned by
> > > potential indefinite retry.
> >
> > Yes, none pte is still an option.  But if we're going to fix this anyway,
> > it seems better to fix it with the accurate new thing that poped up, and
> > it's even less change (just apply walk->action rather than doing random
> > stuff in different call sites).
> >
> > I see that you have worry on deadloop over this, so I hope to discuss
> > altogether here.
> >
> > Unlike normal checks, pmd_trans_unstable() check means something must have
> > changed in the past very short period or it should just never if nothing
> > changed concurrently from under us, so it's not a "if (flag==true)" check
> > which is even more likely to loop.
> >
> > If we see the places that I didn't touch, most of them suggested a retry in
> > one form or another.  So if there's a worry this will also not the first
> > time to do a retry (and for such a "unstable" API, that's really the most
> > natural thing to do which is to retry until it's stable).
> 
> IIUC other than do_anonymous_page() suggests retry (retry page fault),
> others may not, for example:
>   - follow_pmd_mask: return -EBUSY

I assumed a -EBUSY would mean if the caller still needs the page it'll just
need to retry.

It's actually a very rare errno to return in follow page... e.g. some gup
callers may not even be able to handle -EBUSY afaiu, neither does the gup
core (__get_user_pages), afaiu it'll just forwarded upwards.

My bet is it's just so rare and only used with FOLL_SPLIT_PMD for now.  I
had a quick look, at least kvm handles -EBUSY as a real fault (hva_to_pfn,
where it should translate that -EBUSY into a KVM_PFN_ERR_FAULT), I think
it'll crash the hypervisor directly if returned from gup one day (not for
now if never with !FOLL_SPLIT_PMD)..

>   - wp_clean_pmd_entry: actually just retry for pmd_none case, but the
> pagewalk code does handle pmd_none by skipping it, so it basically
> just retry once

This one is very special IMHO, pmd_trans_unstable() should in most cases be
used after someone checked pmd value before walking ptes.  I had a feeling
it's kind of abused, to check whether it's a huge pmd in whatever format..
IMHO it should just use the other pmd_*() helpers but I won't touch it in
this series.

>   - min_core_pte_range: treated as unmapped range by calling
> __mincore_unmapped_range

Correct.

Also pmd_devmap_trans_unstable(), called in 3 call sites:

pmd_devmap_trans_unstable[1418] return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
    filemap_map_pmd[3423]          if (pmd_devmap_trans_unstable(vmf->pmd)) {
    finish_fault[4390]             if (pmd_devmap_trans_unstable(vmf->pmd))
    handle_pte_fault[4922]         if (pmd_devmap_trans_unstable(vmf->pmd))

They all suggest a retry on the page faults, afaiu.

So indeed not all of them retries, but I doubt those ones that are not and
whether that's the best we should have.  Again, I'll leave that out of this
series.

> 
> Anyway I really don't have a strong opinion on this. I may be just
> over-concerned. I just thought if nobody cares whether the result is
> accurate or not, why do we bother fixing those cases?

Because anyway we're already at it and it's easier and cleaner to do so? :)

I would say if to fix this I think the most important ones are pagemap and
memcg paths so far, but since I'm at it and anyway I checked all of them, I
figured maybe I should just make everywhere do right and in the same
pattern when handling unstable pmd. Especially, what this patch touched are
all using walk_page*() routines (I left special ones in first patches), so
it's quite straightforward IMHO to switch altogether using ACTION_AGAIN.

Thanks,

-- 
Peter Xu

