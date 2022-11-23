Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D656351D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiKWIDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiKWIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:03:19 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD1B27B16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:03:16 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e189so12665611iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yrgVTuwsXkscA3+VtXLuTliGRixNsRKkWRsNwU7X2p4=;
        b=i1kX17R+uKgbofM7MLonIyalnpSR1toKzj7fUfY2r0c+PyQAjJleF3Hp+femsIhAMG
         P+BPIPmgRc5GKhNna8CjMc0j/lS7HE0SWw40wjOSvXB/zociltAux2JVtBDD8T1o5vUh
         DiIWJtoAWJPzrcJLTLS2IxCSsQ3BgsWiwVuCf0CVxnWJdYRELwo+TKg+bvC/D8rqi6uO
         bzD7gxkulxet9Giji3lG05t5ARHY94a/51vRtFDysLS1EqAsgyj7ENneP+e9KoyrnqJP
         iUwzp0ZC0iH1ENf5G0LVrtBXfM3fBpDYEn8InEVQjFGQcVj3MV1EX8SRRCvhiu0ZZp2l
         6CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrgVTuwsXkscA3+VtXLuTliGRixNsRKkWRsNwU7X2p4=;
        b=ZZmV9wv+vEeUlU/0IrQ6Nwx/eKw0d0+DaOUt8AYzfcD7EhJNbUBu4UYcZY23soxLsw
         cwyygI2vw2HwED8cH6MleE+/vvkTNIeA1MltBoN1bVx478dRdU+pV85RCgAYwsJhndIz
         hUiWIoYnUo36udJkeI+xHTzctcBsTsjKo1eeifBRRWqYWCb2N/Lcr/ZQrcjoPqRlj3LE
         yU/PR9iUYyFX5+8tD2Hv7ctDDn0AVxn3b47vCFw20URx1tZUsyHlF4fZOB18uQ6phNrH
         dIpzf3xDjj559y6vm8OSZKIYkxZMMvs4748a90s+krGdq5IZqvbCH/J0G7/TgkZgxlnE
         E1aQ==
X-Gm-Message-State: ANoB5pmAzOoQtNrsQGvxgKxzctQQkTv7yO9uiUaPSndgnP85QN0ZzP9g
        OreyHO808lbqG+CMkT5HZPkVoGOGJ8HabkTeyNH23bhDZOCeJQ==
X-Google-Smtp-Source: AA0mqf4KtXPzkWjM8kMQLpT/zQZKPOQpLSaYzqyJyi1RigEWEUAjrJPxLzpOp7qX/h4OUfWABWFqQaU6NfBy8CdzekA=
X-Received: by 2002:a02:9422:0:b0:373:2c18:a37e with SMTP id
 a31-20020a029422000000b003732c18a37emr12332210jai.51.1669190595486; Wed, 23
 Nov 2022 00:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20221119001536.2086599-1-nphamcs@gmail.com> <20221119001536.2086599-5-nphamcs@gmail.com>
 <Y3wreqR1IRWFtSUz@google.com> <Y30KIbewtg+b5JTq@cmpxchg.org> <Y32Yl/Emcw/2a51t@google.com>
In-Reply-To: <Y32Yl/Emcw/2a51t@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Nov 2022 00:02:39 -0800
Message-ID: <CAJD7tkZM1KwQpkS5fTaL0A4=VLv=HEWxCc1kd45s49-s4__e1Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
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

On Tue, Nov 22, 2022 at 7:50 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/11/22 12:42), Johannes Weiner wrote:
> > On Tue, Nov 22, 2022 at 10:52:58AM +0900, Sergey Senozhatsky wrote:
> > > On (22/11/18 16:15), Nhat Pham wrote:
> > > [..]
> > > > @@ -1249,6 +1267,15 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
> > > >   obj_to_location(obj, &page, &obj_idx);
> > > >   zspage = get_zspage(page);
> > > >
> > > > +#ifdef CONFIG_ZPOOL
> > > > + /* Move the zspage to front of pool's LRU */
> > > > + if (mm == ZS_MM_WO) {
> > > > +         if (!list_empty(&zspage->lru))
> > > > +                 list_del(&zspage->lru);
> > > > +         list_add(&zspage->lru, &pool->lru);
> > > > + }
> > > > +#endif
> > >
> > > Do we consider pages that were mapped for MM_RO/MM_RW as cold?
> > > I wonder why, we use them, so technically they are not exactly
> > > "least recently used".
> >
> > This is a swap LRU. Per definition there are no ongoing accesses to
> > the memory while the page is swapped out that would make it "hot".
>
> Hmm. Not arguing, just trying to understand some things.
>
> There are no accesses to swapped out pages yes, but zspage holds multiple
> objects, which are compressed swapped out pages in this particular case.
> For example, zspage in class size 176 (bytes) can hold 93 objects per-zspage,
> that is 93 compressed swapped out pages. Consider ZS_FULL zspages which
> is at the tail of the LRU list. Suppose that we page-faulted 20 times and
> read 20 objects from that zspage, IOW zspage has been in use 20 times very
> recently, while writeback still considers it to be "not-used" and will
> evict it.
>
> So if this works for you then I'm fine. But we probably, like you suggested,
> can document a couple of things here - namely why WRITE access to zspage
> counts as "zspage is in use" but READ access to the same zspage does not
> count as "zspage is in use".
>

I guess the key here is that we have an LRU of zspages, when we really
want an LRU of compressed objects. In some cases, we may end up
reclaiming the wrong pages.

Assuming we have 2 zspages, Z1 and Z2, and 4 physical pages that we
compress over time, P1 -> P4.

Let's assume P1 -> P4 get compressed in order (P4 is the hottest
page), and they get assigned to zspages as follows:
Z1: P1, P3
Z2: P2, P4

In this case, the zspages LRU would be Z2->Z1, because Z2 was touched
last when we compressed P4. Now if we want to writeback, we will look
at Z1, and we might end up reclaiming P3, depending on the order the
pages are stored in.

A worst case scenario of this would be if we have a large number of
pages, maybe 1000, P1->P1000 (where P1000 is the hottest), and they
all go into Z1 and Z2 in this way:
Z1: P1 -> P499, P1000
Z2: P500 -> P999

In this case, Z1 contains 499 cold pages, but it got P1000 at the end
which caused us to put it on the front of the LRU. Now writeback will
consistently use Z2. This is bad. Now I have no idea how practical
this is, but it seems fairly random, based on the compression size of
pages and access patterns.

Does this mean we should move zspages to the front of the LRU when we
writeback from them? No, I wouldn't say so. The same exact scenario
can happen because of this. Imagine the following assignment of the
1000 pages:
Z1: P<odd> (P1, P3, .., P999)
Z2: P<even> (P2, P4, .., P1000)

Z2 is at the front of the LRU because it has P1000, so the first time
we do writeback we will start at Z1. Once we reclaim one object from
Z1, we will start writeback from Z2 next time, and we will keep
alternating. Now if we are really unlucky, we can end up reclaiming in
this order P999, P1000, P997, P998, ... . So yeah I don't think
putting zspages in the front of the LRU when we writeback is the
answer. I would even say it's completely orthogonal to the problem,
because writing back an object from the zspage at the end of the LRU
gives us 0 information about the state of other objects on the same
zspage.

Ideally, we would have an LRU of objects instead, but this would be
very complicated with the current form of writeback. It would be much
easier if we have an LRU for zswap entries instead, which is something
I am looking into, and is a much bigger surgery, and should be
separate from this work. Today zswap inverts LRU priorities anyway by
sending hot pages to the swapfile when zswap is full, when colder
pages are in zswap, so I wouldn't really worry about this now :)
