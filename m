Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5827E6E5882
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDRFZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDRFZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:25:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E14699
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681795518; x=1713331518;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=seD/963AMpffNLu32Ham67dB9tIbhEdstnTXX27xLCo=;
  b=GMw6N38KEl5HOgGZ9owDUjchKYu9HSPc45v5Lhg9MJzmbGiRl2TMq+VA
   uWXmFkxzwqnyH4ZITvroDCl3FCVUAs3v9YBYiIzqESl7abv9UuEeIUInv
   bXUtcwSz/m6y1cdjXotkM31E5QdXx+qka5GnfM7rC4j62fpxhDB0o1c8X
   yVIzhE1YCYok+eLBV6SC+DYlCeGxneD3a1S87vAM8MyrvsACiWu65Xmn6
   e/Ci7Qr23QIALdf4sW5zC+8wjhn4nHrU2ut54UoCxvIIdsnI0ApbPeaGD
   Nd3ed4TquCwM86BuEggflhKqtO1eygyw2LtuDHIfLgi9Zv3SfDiXo9NZr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="431367795"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="431367795"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 22:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="865247232"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="865247232"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 22:25:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Timur Tabi <timur@kernel.org>
Subject: Re: [PATCH] mm: fix printk format within cma
References: <1681788789-19679-1-git-send-email-zhaoyang.huang@unisoc.com>
        <ZD4QsGd0DwHa83K1@casper.infradead.org>
        <CAGWkznHHMSWpEJ1xjfgnA7k04AeO2hNpa=BRgCmKop0sJMTbsw@mail.gmail.com>
Date:   Tue, 18 Apr 2023 13:24:06 +0800
In-Reply-To: <CAGWkznHHMSWpEJ1xjfgnA7k04AeO2hNpa=BRgCmKop0sJMTbsw@mail.gmail.com>
        (Zhaoyang Huang's message of "Tue, 18 Apr 2023 12:16:19 +0800")
Message-ID: <875y9tvk3t.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Tue, Apr 18, 2023 at 11:38=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
>>
>> On Tue, Apr 18, 2023 at 11:33:09AM +0800, zhaoyang.huang wrote:
>> > cma and page pointer printed via %p are hash value which make debug to=
 be hard.
>> > change them to %px.
>>
>> Why does printing the page pointer make any sense at all?  Surely the
>> PFN makes much more sense.
> either pfn or a correct page pointer makes sense for debugging, while
> page could be more safe than pfn which expose the paddr directly

You can specify "no_hash_pointers" in kernel command line to print
pointer value for debug.  IIUC, this take care of both security and
debuggability.

Best Regards,
Huang, Ying

>>
>> > [63321.482751] [c7] cma: cma_alloc(): memory range at 000000000b5e462c=
 is busy, retrying
>> > [63321.482786] [c7] cma: cma_alloc(): memory range at 000000000f7d6fae=
 is busy, retrying
>> > [63321.482823] [c7] cma: cma_alloc(): memory range at 00000000e653b59b=
 is busy, retrying
>> > [63322.378890] [c7] cma: cma_release(page 00000000dd53cf48)
>> > [63322.378913] [c7] cma: cma_release(page 00000000315f703d)
>> > [63322.378925] [c7] cma: cma_release(page 00000000791e3a5f)
>> >
>> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> > ---
>> >  mm/cma.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/mm/cma.c b/mm/cma.c
>> > index 4a978e0..dfe9813 100644
>> > --- a/mm/cma.c
>> > +++ b/mm/cma.c
>> > @@ -435,7 +435,7 @@ struct page *cma_alloc(struct cma *cma, unsigned l=
ong count,
>> >       if (!cma || !cma->count || !cma->bitmap)
>> >               goto out;
>> >
>> > -     pr_debug("%s(cma %p, count %lu, align %d)\n", __func__, (void *)=
cma,
>> > +     pr_debug("%s(cma %px, count %lu, align %d)\n", __func__, (void *=
)cma,
>> >                count, align);
>> >
>> >       if (!count)
>> > @@ -534,7 +534,7 @@ bool cma_pages_valid(struct cma *cma, const struct=
 page *pages,
>> >       pfn =3D page_to_pfn(pages);
>> >
>> >       if (pfn < cma->base_pfn || pfn >=3D cma->base_pfn + cma->count) {
>> > -             pr_debug("%s(page %p, count %lu)\n", __func__,
>> > +             pr_debug("%s(page %px, count %lu)\n", __func__,
>> >                                               (void *)pages, count);
>> >               return false;
>> >       }
>> > @@ -560,7 +560,7 @@ bool cma_release(struct cma *cma, const struct pag=
e *pages,
>> >       if (!cma_pages_valid(cma, pages, count))
>> >               return false;
>> >
>> > -     pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, co=
unt);
>> > +     pr_debug("%s(page %px, count %lu)\n", __func__, (void *)pages, c=
ount);
>> >
>> >       pfn =3D page_to_pfn(pages);
>> >
>> > --
>> > 1.9.1
>> >
>> >
