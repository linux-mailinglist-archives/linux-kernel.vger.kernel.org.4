Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDC16E741A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjDSHgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjDSHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:36:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E2883C9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681889763; x=1713425763;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=cosCSvixFG4nqLM0sYs5BtHEk7blKuZWq8ieOTeDVso=;
  b=mhQlvfA6FmoV8ztrL2GhAurL4uqA95rXWF2XBcNoIE48NgC9e080EAhk
   KcGMPZoGGlHSWs6VXMuK1WRAfbL+u2meHMbQM6J/m4ZNG2rdv9nBge2oE
   YbpqcQoKPRsDNedlXcnPOSIPa+tNSThjgeCKznEG6u+bl+ykK12hIgI3I
   8KKsdFww/Lfbn8Fzgj8byFSybfhJ34wy9XyeFipnYPqKOzRWTUeWFsB1i
   YVZzD9qz9xOxsV7yA7mT6JzRx0XFk9kZGtG3A4obWQumQw8AEhlaeB6/H
   YXqoXp2WnLTfhNTnufjwM1p5xknN5y8jeQydVmBHjWXnf9aiLnwilXQLQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="408287443"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="408287443"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 00:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937558800"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937558800"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 00:36:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: skip CMA pages when they are not available
References: <1681882824-17532-1-git-send-email-zhaoyang.huang@unisoc.com>
        <87pm80tnhu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAGWkznFbQARfoDpdUXbR6BOO9TU_-pkHtm7Q9M0x2=4KWcAqpg@mail.gmail.com>
Date:   Wed, 19 Apr 2023 15:34:55 +0800
In-Reply-To: <CAGWkznFbQARfoDpdUXbR6BOO9TU_-pkHtm7Q9M0x2=4KWcAqpg@mail.gmail.com>
        (Zhaoyang Huang's message of "Wed, 19 Apr 2023 14:52:25 +0800")
Message-ID: <87leiotjds.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoyang Huang <huangzhaoyang@gmail.com> writes:

> On Wed, Apr 19, 2023 at 2:07=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> "zhaoyang.huang" <zhaoyang.huang@unisoc.com> writes:
>>
>> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> >
>> > It is wasting of effort to reclaim CMA pages if they are not availabe
>> > for current context during direct reclaim. Skip them when under corres=
ponding
>> > circumstance.
>>
>> Do you have any performance number for this change?
> Sorry, No. This patch arised from bellowing OOM issue which is caused
> by MIGRATE_CMA occupying almost 100 percent of zones free pages and
> solved by "168676649 mm,page_alloc,cma: conditionally prefer cma
> pageblocks for movable allocations". This could be a common scenario
> for a zone that has a large proportion of CMA reserved page blocks
> which need to be considered in both allocation and reclaiming
> perspective.

IIUC, your patch is inspired by the OOM issue and the commit 168676649?

Anyway, I think it's better for you to describe the issues you want to
address in the patch description, and show how your patch addresses it
with some tests if possible.  Performance number is just one way to show
it.

Best Regards,
Huang, Ying

> 04166 < 4> [   36.172486] [03-19 10:05:52.172] ActivityManager: page
> allocation failure: order:0, mode:0xc00(GFP_NOIO),
> nodemask=3D(null),cpuset=3Dforeground,mems_allowed=3D0
> 0419C < 4> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB
> (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C)
> 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB =3D 35848kB
> 0419D < 4> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH)
> 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB
> 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB =3D 3236kB
> ......
> 041EA < 4> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to
> allocate memory on node -1, gfp=3D0xa20(GFP_ATOMIC)
> 041EB < 4> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end,
> object size: 64, buffer size: 64, default order: 0, min order: 0
> 041EC < 4> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,
> objs: 3392, free: 0
>>
>> Best Regards,
>> Huang, Ying
>>
>> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> > ---
>> >  mm/vmscan.c | 11 ++++++++++-
>> >  1 file changed, 10 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > index bd6637f..04424d9 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsign=
ed long nr_to_scan,
>> >       unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
>> >       unsigned long skipped =3D 0;
>> >       unsigned long scan, total_scan, nr_pages;
>> > +     bool cma_cap =3D true;
>> > +     struct page *page;
>> >       LIST_HEAD(folios_skipped);
>> >
>> >       total_scan =3D 0;
>> >       scan =3D 0;
>> > +     if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
>> > +             && (gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABLE))
>> > +             cma_cap =3D false;
>> > +
>> >       while (scan < nr_to_scan && !list_empty(src)) {
>> >               struct list_head *move_to =3D src;
>> >               struct folio *folio;
>> > @@ -2239,7 +2245,10 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
>> >               nr_pages =3D folio_nr_pages(folio);
>> >               total_scan +=3D nr_pages;
>> >
>> > -             if (folio_zonenum(folio) > sc->reclaim_idx) {
>> > +             page =3D &folio->page;
>> > +
>> > +             if (folio_zonenum(folio) > sc->reclaim_idx ||
>> > +                     (get_pageblock_migratetype(page) =3D=3D MIGRATE_=
CMA && !cma_cap)) {
>> >                       nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
>> >                       move_to =3D &folios_skipped;
>> >                       goto move;
