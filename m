Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0FC73725A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjFTRKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjFTRKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:10:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F3B10E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:09:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98802908fedso462485166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687280998; x=1689872998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAM0sBvpzZEwqFREqglt7fBVP3KBAl0Pj5ut5DkJTVc=;
        b=GH674CZqnHv6UJ/uYXCvREMDVNVYM3lkJoIk5srMdnyWccD09SbAP5wY6SldBjqbPt
         Fsf+FFBPPUdOX50H6HVn3tjn5BBbbyzXqm+r96MWat+wCq7hTc/E2v/DzDmNkUpSgWZK
         O20NUvf1kvN7nxT9qTLuHR3XpuJSR0Bc32TzhyapPJHCKeod9YhFLs/hKabDoPeY0T8a
         VMPiHl9Xmj+PlwWyW+lh1FESiHcsC5kNaSCKv/kSaFMOVljoR9LezMdGg17HAdUOLAWK
         3tXh1tGmCFEHo5OTgPr9OYsnOGmb4hHChBIzrww2yWj2yF4Vm0N7asO3qSNzj8WIxdnl
         AOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280998; x=1689872998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAM0sBvpzZEwqFREqglt7fBVP3KBAl0Pj5ut5DkJTVc=;
        b=WTrH9JTXsj684EO5hPx11lF6o2LhFttgFo3mhH12GfsWiA1fKsAwoPKT6+gTOPC91z
         f4TZwj9EY2M0bFS2wNGwLzscXs6Vez57dmWLBPy2gBtDiwYibQZI/mS86GftoOmqaeEj
         //iibRsbyMNizpNChaGuOJ8dM0UAM3PpaGx9x7k9ZLQWcGKuNytCIkXtorpe1A2bql7w
         TcmHeIzNg2fNc2J81uBQKUt/Ssb0v2bxpwayYGiSU7CDOQVg0326srCoXJ0wUj/8JnPM
         ztCp7R39lFEBa4X8RUdAGIv745J5378Z57LCZdw3bAsjLVDnJ9GQ1wM/DeY/nyVHylBr
         0C3g==
X-Gm-Message-State: AC+VfDwRH452fcfy5LGoiypKvgvsFTblgu9XMKgDsd8RUGkeCiH8RjS+
        ofr6wrVop8p5sKRMH4/EpTSNeXIZwMjaW9RwLEFrsA==
X-Google-Smtp-Source: ACHHUZ4v7wZTTFQc/GPvvICodoCpMwIi75DyIj3nJlwVeZ+PuyfGG6PZ122HytnNDB0tq+4Cu8ks/9Gs9RoXuO2gZJU=
X-Received: by 2002:a17:907:a429:b0:989:15f0:3180 with SMTP id
 sg41-20020a170907a42900b0098915f03180mr2703943ejc.76.1687280997572; Tue, 20
 Jun 2023 10:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230618065824.1365750-1-yosryahmed@google.com>
 <87ilbk8b89.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkaiMWVHfam-j8v2i+0c8+BqKT=h=hv16-Ngz3u+7qJmaA@mail.gmail.com>
 <9f53b80e-7083-705a-88d3-7f3f33dd9c4b@redhat.com> <de807972-92c5-8c6c-d2c7-9df07d1e8d37@redhat.com>
In-Reply-To: <de807972-92c5-8c6c-d2c7-9df07d1e8d37@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 20 Jun 2023 10:09:20 -0700
Message-ID: <CAJD7tkbs2UR-waAnUjBH_8GbVbpAyQz-yqHHOcS6PrTm1BzeUg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] Revert "mm/migrate: __unmap_and_move() push good
 newpage to LRU"
To:     David Hildenbrand <david@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 12:58=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 19.06.23 09:56, David Hildenbrand wrote:
> > On 19.06.23 05:59, Yosry Ahmed wrote:
> >> On Sun, Jun 18, 2023 at 7:00=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
> >>>
> >>> Hi, Yosry,
> >>>
> >>> Yosry Ahmed <yosryahmed@google.com> writes:
> >>>
> >>>> This reverts commit c3096e6782b733158bf34f6bbb4567808d4e0740.
> >>>>
> >>>> That commit made sure we immediately add the new page to the LRU bef=
ore
> >>>> remove_migration_ptes() is called in migrate_move_folio() (used to b=
e
> >>>> __unmap_and_move() back then), such that the rmap walk will rebuild =
the
> >>>> correct mlock_count for the page again. This was needed because the
> >>>> mlock_count was lost when the page is isolated. This is no longer th=
e
> >>>> case since mlock_count no longer overlays page->lru.
> >>>>
> >>>> Revert the commit (the code was foliated afterward the commit, so th=
e
> >>>> revert is updated as such).
> >>>>
> >>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>>> ---
> >>>>    mm/migrate.c | 24 +++++++++---------------
> >>>>    1 file changed, 9 insertions(+), 15 deletions(-)
> >>>>
> >>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>> index 01cac26a3127..68f693731865 100644
> >>>> --- a/mm/migrate.c
> >>>> +++ b/mm/migrate.c
> >>>> @@ -1279,19 +1279,6 @@ static int migrate_folio_move(free_page_t put=
_new_page, unsigned long private,
> >>>>         if (unlikely(!is_lru))
> >>>>                 goto out_unlock_both;
> >>>
> >>> The patch itself looks good to me!  Thanks!
> >>>
> >>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >>
> >> Thanks for taking a look!
> >>
> >>>
> >>> And, it seems that we can remove the above 2 lines and "out_unlock_bo=
th"
> >>> label now.  That can make the code simpler a little.  Right?
> >>
> >> I am not familiar with this code. If we remove the above condition
> >> then pages that have is_lru =3D=3D 0 (i.e __PageMovable(src) is true) =
and
> >> page_was_mapped =3D=3D 1 will call remove_migration_ptes(). This would=
n't
> >> happen without removing the above 2 lines. If this combination is
> >> impossible (is_lru =3D=3D 0 && page_was_mapped =3D=3D 1), then yeah we=
 can
> >> remove the above condition.
> >>
> >> It looks like __SetPageMovable() is only called by zsmalloc, z3fold,
> >> and balloon_page_insert(). The former 2 will never have those pages
> >> mapped into userspace. I am not familiar with balloon_page_insert(),
> >> but my gut feeling is that those are pages used by the driver and are
> >> also not mapped into userspace.
> >
> > On XEN, there is xen_alloc_ballooned_pages(), which ends up mapping
> > balloon-inflated pages into user space (for something like MMIO IIRC).
> > But the XEN balloon does not use the balloon compaction framework, so
> > __SetPageMovable() does not apply.
> >
> > The other balloon_page_insert() users (VMware balloon, CMM,
> > virtio-balloon) shouldn't be doing something like that.
>
> Ah, and I remember they even can't, because in balloon_page_insert() we
> also do a __SetPageOffline(). And such typed pages cannot be mapped into
> user space (because the type overlays the mapcount).

Thanks David, good to know! I will remove the condition as Ying
suggested in the next version then!

>
> --
> Cheers,
>
> David / dhildenb
>
