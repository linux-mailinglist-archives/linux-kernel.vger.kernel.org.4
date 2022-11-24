Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72573636F86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiKXA6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXA6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:58:07 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115022494C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:58:05 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id h206so299580iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vKAhmy3Js54RkUFkCFQDhybaQelynL8wunygu7WtJ7k=;
        b=lKtcr8wSxZPXVcAdQly6CwaGgbk9WSX9Rty8S/EEcr5/Ezv8lvvjehm1nmbjWDxyN+
         2qrCmaHcKJPXO5npXP1FRYDDvK1AHNvESB0BIsu7n4IVH+ZbxEYyTpkuqFXtsmTWH33m
         M6luOKfKeCtord9LZWurm0dC0w/U65kLkyz+02j1vBoKEVCDKQia9Ko2PQ26NpI9+DoJ
         RQFaAsGRC5bo7JE7lww1pahwzWQpuzuRp0Ner/zWplgSHz7DUs5qF6mtgBUcGq3shAAH
         Va7Q7h4aP/dw3ob2JUlCfCj6/Nys47uDcoHSmTskPPj0IEn9Su4VXcLn9QaodmTv2lcl
         jahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKAhmy3Js54RkUFkCFQDhybaQelynL8wunygu7WtJ7k=;
        b=BdnrRYDBe6DHB1zjWdmDiD7RoxSj8T1GEss26YKIrmFMIKKzkvlHkn4hc8AOP6lZoq
         UM0QxWG7m/c0YUmJoRTXeUS39PsA+l01I0Xv7LJwQGF9+xykooEXRP00ZkxdE1eGh5Qw
         lvC0dB+wmQMv4dIb0QhvAtsQrUxJhNHYBuEryeQtqiDT7RdHtJ4aC32elWAMtv3NN5Q1
         JLN3VsSSBAyH0KJygAsaTfsvXlCN9LmZyOGphdrjORSlwNxPfl0zXWcWNc/pFekZbleq
         +AczXDh5Qs3ApJmz8ZgoVyKFlUyavjOL5QWbY3lkpiQ5N1icHWEvaRy+G/yPoQe+d7ku
         nxfg==
X-Gm-Message-State: ANoB5pnvdJZUNQQ79oZgf89cVy3pr+twfe5uhzhMs3TuacwdSEFoh6ej
        EvJJYh2kyvl1rU7pZPPIu9JPyU7lzR+YHeMuQgoa5g==
X-Google-Smtp-Source: AA0mqf6AKDS0mcqu8CCznRX9jF/xLj+pT86SSfP7/+9zPH2e0CfnFxSYzmWpNEIVPhyVbDLdnAiWuNdZDxQUNsDrnJE=
X-Received: by 2002:a5d:9684:0:b0:6de:18b2:1025 with SMTP id
 m4-20020a5d9684000000b006de18b21025mr14206355ion.102.1669251484289; Wed, 23
 Nov 2022 16:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-2-yosryahmed@google.com> <Y369cNnRWkoymF1G@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y369cNnRWkoymF1G@P9FQF9L96D.corp.robot.car>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Nov 2022 16:57:28 -0800
Message-ID: <CAJD7tkY4QtVTJe5cxSKzKj0gOROD4a+o=Rt-wfvG1gcxSQC8Pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: memcg: fix stale protection of reclaim target memcg
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Nov 23, 2022 at 4:40 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Wed, Nov 23, 2022 at 09:21:30AM +0000, Yosry Ahmed wrote:
> > During reclaim, mem_cgroup_calculate_protection() is used to determine
> > the effective protection (emin and elow) values of a memcg. The
> > protection of the reclaim target is ignored, but we cannot set their
> > effective protection to 0 due to a limitation of the current
> > implementation (see comment in mem_cgroup_protection()). Instead,
> > we leave their effective protection values unchaged, and later ignore it
> > in mem_cgroup_protection().
> >
> > However, mem_cgroup_protection() is called later in
> > shrink_lruvec()->get_scan_count(), which is after the
> > mem_cgroup_below_{min/low}() checks in shrink_node_memcgs(). As a
> > result, the stale effective protection values of the target memcg may
> > lead us to skip reclaiming from the target memcg entirely, before
> > calling shrink_lruvec(). This can be even worse with recursive
> > protection, where the stale target memcg protection can be higher than
> > its standalone protection. See two examples below (a similar version of
> > example (a) is added to test_memcontrol in a later patch).
> >
> > (a) A simple example with proactive reclaim is as follows. Consider the
> > following hierarchy:
> > ROOT
> >  |
> >  A
> >  |
> >  B (memory.min = 10M)
> >
> > Consider the following scenario:
> > - B has memory.current = 10M.
> > - The system undergoes global reclaim (or memcg reclaim in A).
> > - In shrink_node_memcgs():
> >   - mem_cgroup_calculate_protection() calculates the effective min (emin)
> >     of B as 10M.
> >   - mem_cgroup_below_min() returns true for B, we do not reclaim from B.
> > - Now if we want to reclaim 5M from B using proactive reclaim
> >   (memory.reclaim), we should be able to, as the protection of the
> >   target memcg should be ignored.
> > - In shrink_node_memcgs():
> >   - mem_cgroup_calculate_protection() immediately returns for B without
> >     doing anything, as B is the target memcg, relying on
> >     mem_cgroup_protection() to ignore B's stale effective min (still 10M).
> >   - mem_cgroup_below_min() reads the stale effective min for B and we
> >     skip it instead of ignoring its protection as intended, as we never
> >     reach mem_cgroup_protection().
> >
> > (b) An more complex example with recursive protection is as follows.
> > Consider the following hierarchy with memory_recursiveprot:
> > ROOT
> >  |
> >  A (memory.min = 50M)
> >  |
> >  B (memory.min = 10M, memory.high = 40M)
> >
> > Consider the following scenario:
> > - B has memory.current = 35M.
> > - The system undergoes global reclaim (target memcg is NULL).
> > - B will have an effective min of 50M (all of A's unclaimed protection).
> > - B will not be reclaimed from.
> > - Now allocate 10M more memory in B, pushing it above it's high limit.
> > - The system undergoes memcg reclaim from B (target memcg is B).
> > - Like example (a), we do nothing in mem_cgroup_calculate_protection(),
> >   then call mem_cgroup_below_min(), which will read the stale effective
> >   min for B (50M) and skip it. In this case, it's even worse because we
> >   are not just considering B's standalone protection (10M), but we are
> >   reading a much higher stale protection (50M) which will cause us to not
> >   reclaim from B at all.
> >
> > This is an artifact of commit 45c7f7e1ef17 ("mm, memcg: decouple
> > e{low,min} state mutations from protection checks") which made
> > mem_cgroup_calculate_protection() only change the state without
> > returning any value. Before that commit, we used to return
> > MEMCG_PROT_NONE for the target memcg, which would cause us to skip the
> > mem_cgroup_below_{min/low}() checks. After that commit we do not return
> > anything and we end up checking the min & low effective protections for
> > the target memcg, which are stale.
> >
> > Update mem_cgroup_supports_protection() to also check if we are
> > reclaiming from the target, and rename it to mem_cgroup_unprotected()
> > (now returns true if we should not protect the memcg, much simpler logic).
> >
> > Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> Thank you!

Thanks for reviewing!

Do you think we need a CC to stable here?
