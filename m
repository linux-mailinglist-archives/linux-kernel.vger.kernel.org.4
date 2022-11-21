Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1373632C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKUSwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKUSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:52:00 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A83AD0DE7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:51:59 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id k2so8657499qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AU9IGUZSk0DTVRsNQzhBBdP7igKqLtnqNm+OtNdCI+8=;
        b=n4CMVsAEvirHNRJzZgWy0d0EEJZKO83tj63ZhvOPbX0vbQImsU3U8AK6cc2IEpKXVV
         wJbuGkhCPN+RccMbc2h5ko2Bf5SqjtTwi+PRFQXas492osu7EhF65F/Cm7hevl+hHZRu
         PovR5OgdtiOfbemLhCcey47+k30x+2MA495dsCMDZnZvMmisP6A2WFY4q8wZIVI/l3cs
         MbOikPqGfoB/nu87OIH3DL5O40Nc0AQHy/83vTFTcHUt4jgXtBEJygfg/TP0D/tA0yrW
         aFeKH5ou08WzlbiFNI6Uxopq7DL/NeTqMtgnFlw2YEHSu5DNjn+tDJupJ7D/jpRKSvKu
         dm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU9IGUZSk0DTVRsNQzhBBdP7igKqLtnqNm+OtNdCI+8=;
        b=V0syzS67WHW/bNqhjkLltVt/Lz+rXdtqbvgdD2oDY7dAm5ghhPHnHDMQEFUWkGYsOr
         sPvymi8m4mO7lhXoQx6DdlSxTu/Ptl0fxTBjiUzxeBWt6UO6/wyD4Gys/4QXp6h+5pFX
         MDU2pfYzdabeFCLUZU0bca9XzTvdfLlCl0AWZjDmjd186RZU2n5Jwfd8uIC3aiS3cKvs
         +0V0gmlj9eFrrIyfzU+Sw5ee1dKzB/ximrNjge2zByPBra28t2YLDSctD3MAzLBWamvP
         NdRJnzs8xxvdhiKwOgg9qFbx9hi+CJzlL+9a2lF7bKLUZHExwGSdRgq+7FSWGpvLUob1
         pG9Q==
X-Gm-Message-State: ANoB5pnyIm7qvdRnK3xvYqOQ6f/n3IAFGXxs004ofH77Ojvy0RTvX2M8
        b1CUa0OibQtYCeCDbyiedioTaA==
X-Google-Smtp-Source: AA0mqf6OsOUZqeWSnhqWKMHf5VPW5a4RVMbvgU/3+25Ie1HN1BA1OXUplLGUzgKGEliGB5hEKHsrig==
X-Received: by 2002:ae9:e901:0:b0:6fa:165:131c with SMTP id x1-20020ae9e901000000b006fa0165131cmr2507495qkf.389.1669056718422;
        Mon, 21 Nov 2022 10:51:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id z63-20020a37b042000000b006fafaac72a6sm8510696qke.84.2022.11.21.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 10:51:58 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:52:23 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
Message-ID: <Y3vI58VtjiAkorUX@cmpxchg.org>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
 <20221121165938.oid3pemsfkaeq3ws@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121165938.oid3pemsfkaeq3ws@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 04:59:38PM +0000, Shakeel Butt wrote:
> On Fri, Nov 18, 2022 at 01:08:13AM -0800, Hugh Dickins wrote:
> > Linus was underwhelmed by the earlier compound mapcounts series:
> > this series builds on top of it (as in next-20221117) to follow
> > up on his suggestions - except rmap.c still using lock_page_memcg(),
> > since I hesitate to steal the pleasure of deletion from Johannes.
> 
> Is there a plan to remove lock_page_memcg() altogether which I missed? I
> am planning to make lock_page_memcg() a nop for cgroup-v2 (as it shows
> up in the perf profile on exit path) but if we are removing it then I
> should just wait.

We can remove it for rmap at least, but we might be able to do more.

Besides rmap, we're left with the dirty and writeback page transitions
that wrt cgroups need to be atomic with NR_FILE_DIRTY and NR_WRITEBACK.

Looking through the various callsites, I think we can delete it from
setting and clearing dirty state, as we always hold the page lock (or
the pte lock in some instances of folio_mark_dirty). Both of these are
taken from the cgroup side, so we're good there.

I think we can also remove it when setting writeback, because those
sites have the page locked as well.

That leaves clearing writeback. This can't hold the page lock due to
the atomic context, so currently we need to take lock_page_memcg() as
the lock of last resort.

I wonder if we can have cgroup take the xalock instead: writeback
ending on file pages always acquires the xarray lock. Swap writeback
currently doesn't, but we could make it so (swap_address_space).

The only thing that gives me pause is the !mapping check in
__folio_end_writeback. File and swapcache pages usually have mappings,
and truncation waits for writeback to finish before axing
page->mapping. So AFAICS this can only happen if we call end_writeback
on something that isn't under writeback - in which case the test_clear
will fail and we don't update the stats anyway. But I want to be sure.

Does anybody know from the top of their heads if a page under
writeback could be without a mapping in some weird cornercase?

If we could ensure that the NR_WRITEBACK decs are always protected by
the xalock, we could grab it from mem_cgroup_move_account(), and then
kill lock_page_memcg() altogether.
