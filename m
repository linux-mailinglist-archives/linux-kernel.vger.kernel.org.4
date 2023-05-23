Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF3B70D0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjEWBsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjEWBsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:48:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA5C93
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684806510; x=1716342510;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=pC1qgCUA4kll5pSGP8kAgZmxkcD7TSslSEEJcM/0PRo=;
  b=bWl/jbzMjTMEGkPqUujr4h8jrYenwSvRVaqwJSjdcsLOPhOdumhwfJ26
   Ar+r4QPKucfHFRj+1tlGZNytaQYrSaZimtNNBgFBLOdfT3+mzFi0VMbBH
   EevUsRhYaXgRHYq4T/Wh/nT/hqm9AcqMFZM0X6QltpX68KU0Z+R804WY9
   NktoiNActrtlG90YE2z3MiV2t/Xis2eXqPy10t+UYE6plKf4FYCCyN0RK
   foy6SNiaFgTkqJhErPEivQFz7xADoVPaC1TMGKETTNnt+yaKQ43B+hysb
   RyZmm7CR3qx+wFoYLKofE6R5Zzy3RBbQEhxN5JKYkHYsTqt01+ESCfmJU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="355447382"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="355447382"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 18:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="768778546"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="768778546"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 18:48:16 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH -V2 1/5] swap: Remove get/put_swap_device() in
 __swap_count()
References: <20230522070905.16773-1-ying.huang@intel.com>
        <20230522070905.16773-2-ying.huang@intel.com>
        <CAJD7tkYUOHWFOTouv6WsGnzsBhJzm7OHi--RgujWH0ZabZwqHw@mail.gmail.com>
Date:   Tue, 23 May 2023 09:47:13 +0800
In-Reply-To: <CAJD7tkYUOHWFOTouv6WsGnzsBhJzm7OHi--RgujWH0ZabZwqHw@mail.gmail.com>
        (Yosry Ahmed's message of "Mon, 22 May 2023 18:22:19 -0700")
Message-ID: <877cszyg2m.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Mon, May 22, 2023 at 12:09=E2=80=AFAM Huang Ying <ying.huang@intel.com=
> wrote:
>>
>> __swap_count() is called in do_swap_page() only, which encloses the
>> call site with get/put_swap_device() already.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> ---
>>  mm/swapfile.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 274bbf797480..8419cba9c192 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1432,16 +1432,10 @@ void swapcache_free_entries(swp_entry_t *entries=
, int n)
>>
>
> nit: I would add a comment here that the caller needs get/put_swap_device=
().

It's default behavior to call get/put_swap_device() in the caller for
all almost all swap functions.  I would rather comment the swap
functions needn't to do that, as the comments for
read_swap_cache_async() in [2/5].

> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

>>  int __swap_count(swp_entry_t entry)
>>  {
>> -       struct swap_info_struct *si;
>> +       struct swap_info_struct *si =3D swp_swap_info(entry);
>>         pgoff_t offset =3D swp_offset(entry);
>> -       int count =3D 0;
>>
>> -       si =3D get_swap_device(entry);
>> -       if (si) {
>> -               count =3D swap_count(si->swap_map[offset]);
>> -               put_swap_device(si);
>> -       }
>> -       return count;
>> +       return swap_count(si->swap_map[offset]);
>>  }
>>
>>  /*

Best Regards,
Huang, Ying
