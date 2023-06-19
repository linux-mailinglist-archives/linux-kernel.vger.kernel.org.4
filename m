Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A56734B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFSE3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFSE3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:29:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA351BB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687148942; x=1718684942;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=Nm2PU+XrA/C9g13+5/DoFJAy+VRzHa5O8+Yy7/+ZiL0=;
  b=Rs4fgvAfOIw+0/H1ozXWV7g/5ktUvBgLx/NrEl4OR0/0+BVN8Bi/8MiT
   aKsMn/OlxHuJ5lZ7ly2GIvfw5T0jxKIIJDUdC9G00SzlWwsuU8HYZ0mdu
   I4QaikTiC3mKwcpOCGU6cxk1NkCdSxqDBSTAa67qe0WQ7c91mBDJVB24B
   uGZ/jfZ3nQYva4J0dpuE/tIHVaWU88zHcZFFROEgmq8Kr4+HOePc1fhGp
   S5GDFqro0+I2PlGToH3CJdfXcXOBY/r4qtUG7gI1vPEpSycVrqWXYxUgf
   phsP9B9Dq2Kj94qvytcQ7OhAiU54JZo2l0ReQzh36JVeMWYYnbFqAzcBX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="425491643"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="425491643"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 21:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="743295957"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="743295957"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 21:28:56 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] Revert "mm/migrate: __unmap_and_move() push
 good newpage to LRU"
References: <20230618065824.1365750-1-yosryahmed@google.com>
        <87ilbk8b89.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAJD7tkaiMWVHfam-j8v2i+0c8+BqKT=h=hv16-Ngz3u+7qJmaA@mail.gmail.com>
Date:   Mon, 19 Jun 2023 12:27:22 +0800
In-Reply-To: <CAJD7tkaiMWVHfam-j8v2i+0c8+BqKT=h=hv16-Ngz3u+7qJmaA@mail.gmail.com>
        (Yosry Ahmed's message of "Sun, 18 Jun 2023 20:59:52 -0700")
Message-ID: <87a5ww84b9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Sun, Jun 18, 2023 at 7:00=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Hi, Yosry,
>>
>> Yosry Ahmed <yosryahmed@google.com> writes:
>>
>> > This reverts commit c3096e6782b733158bf34f6bbb4567808d4e0740.
>> >
>> > That commit made sure we immediately add the new page to the LRU before
>> > remove_migration_ptes() is called in migrate_move_folio() (used to be
>> > __unmap_and_move() back then), such that the rmap walk will rebuild the
>> > correct mlock_count for the page again. This was needed because the
>> > mlock_count was lost when the page is isolated. This is no longer the
>> > case since mlock_count no longer overlays page->lru.
>> >
>> > Revert the commit (the code was foliated afterward the commit, so the
>> > revert is updated as such).
>> >
>> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>> > ---
>> >  mm/migrate.c | 24 +++++++++---------------
>> >  1 file changed, 9 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/mm/migrate.c b/mm/migrate.c
>> > index 01cac26a3127..68f693731865 100644
>> > --- a/mm/migrate.c
>> > +++ b/mm/migrate.c
>> > @@ -1279,19 +1279,6 @@ static int migrate_folio_move(free_page_t put_n=
ew_page, unsigned long private,
>> >       if (unlikely(!is_lru))
>> >               goto out_unlock_both;
>>
>> The patch itself looks good to me!  Thanks!
>>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> Thanks for taking a look!
>
>>
>> And, it seems that we can remove the above 2 lines and "out_unlock_both"
>> label now.  That can make the code simpler a little.  Right?
>
> I am not familiar with this code. If we remove the above condition
> then pages that have is_lru =3D=3D 0 (i.e __PageMovable(src) is true) and
> page_was_mapped =3D=3D 1 will call remove_migration_ptes(). This wouldn't
> happen without removing the above 2 lines. If this combination is
> impossible (is_lru =3D=3D 0 && page_was_mapped =3D=3D 1), then yeah we can
> remove the above condition.
>
> It looks like __SetPageMovable() is only called by zsmalloc, z3fold,
> and balloon_page_insert(). The former 2 will never have those pages
> mapped into userspace. I am not familiar with balloon_page_insert(),
> but my gut feeling is that those are pages used by the driver and are
> also not mapped into userspace.

You can take a look at migrate_folio_unmap(), where "page_was_mapped"
will not be set to 1 if !is_lru.

Best Regards,
Huang, Ying

> So I guess we can just remove the condition, but a confirmation for
> the above would be reassuring :)
>
>>
>> Best Regards,
>> Huang, Ying
>>
>> > -     /*
>> > -      * When successful, push dst to LRU immediately: so that if it
>> > -      * turns out to be an mlocked page, remove_migration_ptes() will
>> > -      * automatically build up the correct dst->mlock_count for it.
>> > -      *
>> > -      * We would like to do something similar for the old page, when
>> > -      * unsuccessful, and other cases when a page has been temporarily
>> > -      * isolated from the unevictable LRU: but this case is the easie=
st.
>> > -      */
>> > -     folio_add_lru(dst);
>> > -     if (page_was_mapped)
>> > -             lru_add_drain();
>> > -
>> >       if (page_was_mapped)
>> >               remove_migration_ptes(src, dst, false);
>> >
>> > @@ -1301,9 +1288,16 @@ static int migrate_folio_move(free_page_t put_n=
ew_page, unsigned long private,
>> >       /*
>> >        * If migration is successful, decrease refcount of dst,
>> >        * which will not free the page because new page owner increased
>> > -      * refcounter.
>> > +      * refcounter. As well, if it is LRU folio, add the folio to LRU
>> > +      * list in here. Use the old state of the isolated source folio =
to
>> > +      * determine if we migrated a LRU folio. dst was already unlocked
>> > +      * and possibly modified by its owner - don't rely on the folio
>> > +      * state.
>> >        */
>> > -     folio_put(dst);
>> > +     if (unlikely(!is_lru))
>> > +             folio_put(dst);
>> > +     else
>> > +             folio_putback_lru(dst);
>> >
>> >       /*
>> >        * A folio that has been migrated has all references removed
>>
