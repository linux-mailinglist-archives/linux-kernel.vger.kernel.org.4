Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033616448E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiLFQMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbiLFQMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:12:16 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E082FA63
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:07:03 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id 128so14580006vsz.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 08:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SveIS+m05kaV+NbQtltfznvpIIP4IsM4EDN+tmUWkHo=;
        b=s/jKPgf+wdM6ATiMmRYQDfR8HqB/tiiDbgeqtpYSAYCBJyUann/8KrcudBUHG4nn/C
         212x2309evhMirrP0wZIVge91I+4jdJx8msjZa0KML3qZjFkIS0VbnXu/qPIPaKyyBhi
         GYpQoyE/fBwW7Rpk9rGu+jVikw62UL1MMC5iJWxPy1BmmA6QUKC7hQ66n+1Le9YeQBCj
         gXQLGug8UhhudFkHy9CZNFKn4gx+I7ddkHBQLbQwL0QwQxTuLrsud/CZ/s5DDrGTgoRx
         4b00unath7f+q3jnTRQs9Dlc5yPZlqgtC+SefEpqngFssyJ3HSgXSHHLmL+uzmGGKOyu
         b5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SveIS+m05kaV+NbQtltfznvpIIP4IsM4EDN+tmUWkHo=;
        b=ynzzScqEqGUbAfUaty7FIb6cSxI6ze38+YFFZkbtKssCGVd+MnDkmBD4incU4xA4H7
         4OmiFBBQXtjpXlZTjjtrrnoyaKu6KryA01hLF3FNau2+2qYMOlzbuQp4zLauMnsl0tXM
         X7GrDU28W6Hxwn2Mdz5mh994L3G4vtTPTqlGpdNOL5I8uDHY9Nt9gP79PmkgAsH+zGb+
         NTAcN9CJEqQT36eRxmz+9xFh/T/fbBZljoEQ0QbAhTO3+2z1s2N8j1utsCeW+GoWUds0
         wa4F4ixo7B9D7LvDw0GlKgVNeoV/k9EZO0njpUxndyfd4ygAbEoPBvgpIEUwOWeyAruF
         JpFw==
X-Gm-Message-State: ANoB5pkOU83YT73oV+jm/NWHv0DJZAoP5Vf3F0xb5iPSWT0otYBkVqRx
        /EFg6CwUvnk/ACvRBShLmUL6TU8qK/p88TNe1qg2Yg==
X-Google-Smtp-Source: AA0mqf55CwThMkXhx/EbjlNleaeZzW2lhEIxFg0O9w8N8GoNL4gC/Of+PR4mM5T07cF6k01QovMXdfBLeawFKe/ka8Q=
X-Received: by 2002:a67:ea04:0:b0:3a7:d7bc:c2e9 with SMTP id
 g4-20020a67ea04000000b003a7d7bcc2e9mr39265477vso.61.1670342822835; Tue, 06
 Dec 2022 08:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20221206023406.3182800-1-almasrymina@google.com> <Y48zlaimOb/wr8qd@dhcp22.suse.cz>
In-Reply-To: <Y48zlaimOb/wr8qd@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 6 Dec 2022 08:06:51 -0800
Message-ID: <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 05-12-22 18:34:05, Mina Almasry wrote:
> > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > reclaim"") enabled demotion in memcg reclaim, which is the right thing
> > to do, however, it introduced a regression in the behavior of
> > try_to_free_mem_cgroup_pages().
> >
> > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> > of the cgroup should reduce by nr_pages. The callers expect
> > try_to_free_mem_cgroup_pages() to also return the number of pages
> > reclaimed, not demoted.
> >
> > However, what try_to_free_mem_cgroup_pages() actually does is it
> > unconditionally counts demoted pages as reclaimed pages. So in practice
> > when it is called it will often demote nr_pages and return the number of
> > demoted pages to the caller. Demoted pages don't lower the memcg usage,
> > and so try_to_free_mem_cgroup_pages() is not actually doing what the
> > callers want it to do.
> >
> > Various things work suboptimally on memory tiered systems or don't work
> > at all due to this:
> >
> > - memory.high enforcement likely doesn't work (it just demotes nr_pages
> >   instead of lowering the memcg usage by nr_pages).
> > - try_charge_memcg() will keep retrying the charge while
> >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
> >   making any room for the charge.
>
> This has been brought up during the review https://lore.kernel.org/all/YoYTEDD+c4GT0xYY@dhcp22.suse.cz/
>

Ah, I did indeed miss this. Thanks for the pointer. However I don't
understand this bit from your email (sorry I'm probably missing
something):

"I suspect this is rather unlikely situation, though. The last tear
(without any fallback) should have some memory to reclaim most of
the time."

Reading the code in try_charge_memcg(), I don't see the last retry for
try_to_free_mem_cgroup_pages() do anything special. My concern here is
that try_charge_memcg() calls try_to_free_mem_cgroup_pages()
MAX_RECLAIM_RETRIES times. Each time that call may demote pages and
report back that it was able to 'reclaim' memory, but the charge keeps
failing because the memcg reclaim didn't actually make room for the
charge. What happens in this case? My understanding is that the memcg
oom-killer gets wrongly invoked.

> > - memory.reclaim has a wonky interface. It advertises to the user it
> >   reclaims the provided amount but it will actually often demote that
> >   amount.
> >
> > There may be more effects to this issue.
> >
> > To fix these issues I propose shrink_folio_list() to only count pages
> > demoted from inside of sc->nodemask to outside of sc->nodemask as
> > 'reclaimed'.
>
> Could you expand on why the node mask matters? From the charge point of
> view it should be completely uninteresting as the charge remains.
>
> I suspect we really need to change to reclaim metrics for memcg reclaim.
> In the memory balancing reclaim we can indeed consider demotions as a
> reclaim because the memory is freed in the end but for the memcg reclaim
> we really should be counting discharges instead. No demotion/migration will
> free up charges.

I think what you're describing is exactly what this patch aims to do.
I'm proposing an interface change to shrink_folio_list() such that it
only counts demoted pages as reclaimed iff sc->nodemask is provided by
the caller and the demotion removed pages from inside sc->nodemask to
outside sc->nodemask. In this case:

1. memory balancing reclaim would pass sc->nodemask=nid to
shrink_folio_list() indicating that it should count pages demoted from
sc->nodemask as reclaimed.

2. memcg reclaim would pass sc->nodemask=NULL to shrink_folio_list()
indicating that it is looking for reclaim across all nodes and no
demoted pages should count as reclaimed.

Sorry if the commit message was not clear. I can try making it clearer
in the next version but it's already very long.

> --
> Michal Hocko
> SUSE Labs
