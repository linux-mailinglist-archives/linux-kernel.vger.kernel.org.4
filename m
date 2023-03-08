Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA86B13E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCHVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCHVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:32:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6DB7190
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:32:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so71177400edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678311131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OhNm7hskoArX04v3EQdnCMnOrwCqQ4hcIfVS+5XDUY=;
        b=YQF4b6dt4aLwWSuXkDgEvXikFlVV+90s3I+XXIMWStA2i4jcpOulmSAOGy9o01joWU
         eL5GVdJG3seI5X51K6vv+G6AfAWp7XYsJr0NPP9UIB/JhzfpRVyS1joOlyUKZA9ua0CV
         0AlwdGzA81Xmx4twweFoOeHWYIkUmS4Y/0DCxzaNjWAm4mPp1uM4ruAlBxbkDfxb7915
         BVF7TCTAcPcYih2XWDnXE9gwH0C9Y/e2VXwl0sm6xLDChFUTZ6mE8zX34y2NKUF+0+2n
         M3KWjt3lfciV48/K8q1G5gzqPKRNjToIYqyRjNGhrcCWKi8EMmg0cEd7pb1q4yHnkI7p
         SGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OhNm7hskoArX04v3EQdnCMnOrwCqQ4hcIfVS+5XDUY=;
        b=EckDeRhwH0guDbxX9Oc7o8//EgAwMqMmVxUNBENKDQr/xxiY3Ztw/i0XoKTQVvP1Ed
         sAaLrgAmeRbwGyeyHMnX43TcSf3M92BdkdXnkC+LzSbB1tnelX2g9FVNgyrK/xapSTqD
         Xbr5azms5TpE3Nk65tXiSJ3XRIl11FtvoMxwQqDuzibc5I4iCRNI0gwT08cG7Yqxvyqh
         TMBj0mno2ISGQ3lzztsXxeRodJ+esoMvs0dBkYUQfi79gJSeqtUeehXPrdlMTHVHkxza
         +inldMce38GBWr7MHJ/fKK1mtRwMe7HdfZHsQUNhqcR4bXK5NaqSy+zty/wqSLIj7o9v
         Kp3Q==
X-Gm-Message-State: AO0yUKVsNuHfRaUZivRKzYgvJ+VKz/AKbRazXV/gbMXYAmZQ+12kX8se
        xvnxjVumJCkH9yIzElB76qy4ZRNXAk0F0bdAmIakbA==
X-Google-Smtp-Source: AK7set/PzfqhJ3GbqSiCxOuRaMNXqhDvbTag8Kp4p5tLkGOC6kLRGrUY5OGxaaNPJqqxdTrX1oWnqGTKOPNp73maa0k=
X-Received: by 2002:a17:906:d7a6:b0:914:373:14de with SMTP id
 pk6-20020a170906d7a600b00914037314demr5329825ejb.10.1678311131118; Wed, 08
 Mar 2023 13:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20230228085002.2592473-1-yosryahmed@google.com>
 <20230308160056.GA414058@cmpxchg.org> <CAJD7tka=6b-U3m0FdMoP=9nC8sYuJ9thghb9muqN5hQ5ZMrDag@mail.gmail.com>
 <20230308201629.GB476158@cmpxchg.org> <CAJD7tkbDN2LUG_EZHV8VZd3M4-wtY9TCO5uS2c5qvqEWpoMvoA@mail.gmail.com>
 <20230308212529.GL360264@dread.disaster.area>
In-Reply-To: <20230308212529.GL360264@dread.disaster.area>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Mar 2023 13:31:34 -0800
Message-ID: <CAJD7tkbu97JWOEvRJDYBKzy5qOJ8LYK6ZXBJSDhUw0+8br_Dqg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
To:     Dave Chinner <david@fromorbit.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 1:25=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Wed, Mar 08, 2023 at 12:24:08PM -0800, Yosry Ahmed wrote:
> > > I tried to come up with something better, but wasn't happy with any o=
f
> > > the options, either. So I defaulted to just leaving it alone :-)
> > >
> > > It's part of the shrinker API and the name hasn't changed since the
> > > initial git import of the kernel tree. It should be fine, churn-wise.
> >
> > Last attempt, just update_reclaim_state() (corresponding to
> > flush_reclaim_state() below). It doesn't tell a story, but neither
> > does incrementing a counter in current->reclaim_state. If that doesn't
> > make you happy I'll give up now and leave it as-is :)
>
> This is used in different subsystem shrinkers outside mm/, so the
> name needs to be correctly namespaced. Please prefix it with the
> subsystem the function belongs to, at minimum.
>
> mm_account_reclaimed_pages() is what is actually being done here.
> It is self describing  and leaves behind no ambiguity as to what is
> being accounted and why, nor which subsystem the accounting belongs
> to.
>
> It doesn't matter what the internal mm/vmscan structures are called,
> all we care about is telling the mm infrastructure how many extra
> pages were freed by the shrinker....

mm_account_reclaimed_pages() sounds good to me. We can also do
something more specific if Johannes has any ideas. I do not have a
strong opinion here at all, I just prefer having a helper to leaving
it open-coded.

Thanks!

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
