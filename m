Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF146F4BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEBVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjEBVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:08:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954E10DE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:08:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-959a3e2dd27so846994266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683061704; x=1685653704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wExq1azF4GftMmcHTSy6kxlx9hSn4o3sgJc6Bo+y6xM=;
        b=U9etvfHaprHGpalhp2To0JER9EVuFoJeXDxLlidFVE+rYxzGpfYhbpSYE9dib3Q++m
         yd0vxeCTKNnzubvxFITlaARgWI2rJaTdgE1XSRFFE+yP7q+n7EbqS3vcY9i95LtbMMzB
         /yrrYB6e7Lk3d1Vd1WB/UgHUcJe+3jzfDjGHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683061704; x=1685653704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wExq1azF4GftMmcHTSy6kxlx9hSn4o3sgJc6Bo+y6xM=;
        b=Fq3+dIkJ7jlFz5VQyp8RBdDYJrTrmfCTK5YqgUED3YYhsXV4XN+NNAfBcnLlCreP+O
         7h41xZJgb6NzoSOIn2b66zLqNg6y7Zvc99SoTBBtZpd5K2VPtX+3OuW11IBSJgrvtX4R
         xMVswVMU1YkmGd6Qx974jObEtjk1fw0b94OJadtJCFWV7hd9KouQJiF/CMIQKTFR+0GW
         xkuN4r362gWhraEIozX3BozxvYPVKCQtJsGJsTRFoRP01BND6PNrIZAoM7y9IUP014Jx
         DvGJOO35lxbSyqBLGrOAdjuX2Y+qRbko8NvEYGQg21VYYxNZ0vRpK5qJ92ow+EpQR32u
         mC9Q==
X-Gm-Message-State: AC+VfDzYbVGuVYIM0cKGtj+ols8Doh2EunsCQW5BmpqD3n6J1d31UkBs
        6V0zC+gitqHr4vC5ZNspZphtv61Eh15rus29RbfrwQ==
X-Google-Smtp-Source: ACHHUZ71ZP2Aryg7I3rIjMWtHGueHghNqeOgMku7GSuAxcjxvWEt0JdFY3pHVvYpNUtzKRVTXcjaKA==
X-Received: by 2002:a17:907:9496:b0:94f:1a11:e08b with SMTP id dm22-20020a170907949600b0094f1a11e08bmr1204826ejc.20.1683061704453;
        Tue, 02 May 2023 14:08:24 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170907934d00b009584c5bcbc7sm13505451ejc.49.2023.05.02.14.08.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 14:08:23 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f2548256d0so58665e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:08:23 -0700 (PDT)
X-Received: by 2002:a05:600c:1e20:b0:3f1:70d1:21a6 with SMTP id
 ay32-20020a05600c1e2000b003f170d121a6mr63861wmb.0.1683061703233; Tue, 02 May
 2023 14:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230428135414.v3.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <20230429101345.2769-1-hdanton@sina.com>
In-Reply-To: <20230429101345.2769-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 May 2023 14:08:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8m-mpJsFntCciqtq7xnvhmnvPdTvxNuBGBT3-cDdabQ@mail.gmail.com>
Message-ID: <CAD=FV=V8m-mpJsFntCciqtq7xnvhmnvPdTvxNuBGBT3-cDdabQ@mail.gmail.com>
Subject: Re: [PATCH v3] migrate_pages: Avoid blocking for IO in MIGRATE_SYNC_LIGHT
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 29, 2023 at 3:14=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On 28 Apr 2023 13:54:38 -0700 Douglas Anderson <dianders@chromium.org>
> > The MIGRATE_SYNC_LIGHT mode is intended to block for things that will
> > finish quickly but not for things that will take a long time. Exactly
> > how long is too long is not well defined, but waits of tens of
> > milliseconds is likely non-ideal.
> >
> > When putting a Chromebook under memory pressure (opening over 90 tabs
> > on a 4GB machine) it was fairly easy to see delays waiting for some
> > locks in the kcompactd code path of > 100 ms. While the laptop wasn't
> > amazingly usable in this state, it was still limping along and this
> > state isn't something artificial. Sometimes we simply end up with a
> > lot of memory pressure.
>
> Was kcompactd waken up for PAGE_ALLOC_COSTLY_ORDER?

I put some more traces in and reproduced it again. I saw something
that looked like this:

1. balance_pgdat() called wakeup_kcompactd() with order=3D10 and that
caused us to get all the way to the end and wakeup kcompactd (there
were previous calls to wakeup_kcompactd() that returned early).

2. kcompactd started and completed kcompactd_do_work() without blocking.

3. kcompactd called proactive_compact_node() and there blocked for
~92ms in one case, ~120ms in another case, ~131ms in another case.


> > Putting the same Chromebook under memory pressure while it was running
> > Android apps (though not stressing them) showed a much worse result
> > (NOTE: this was on a older kernel but the codepaths here are similar).
> > Android apps on ChromeOS currently run from a 128K-block,
> > zlib-compressed, loopback-mounted squashfs disk. If we get a page
> > fault from something backed by the squashfs filesystem we could end up
> > holding a folio lock while reading enough from disk to decompress 128K
> > (and then decompressing it using the somewhat slow zlib algorithms).
> > That reading goes through the ext4 subsystem (because it's a loopback
> > mount) before eventually ending up in the block subsystem. This extra
> > jaunt adds extra overhead. Without much work I could see cases where
> > we ended up blocked on a folio lock for over a second. With more
> > extreme memory pressure I could see up to 25 seconds.
>
> In the same kcompactd code path above?

It was definitely in kcompactd. I can go back and trace through this
too, if it's useful, but I suspect it's the same.


> > We considered adding a timeout in the case of MIGRATE_SYNC_LIGHT for
> > the two locks that were seen to be slow [1] and that generated much
> > discussion. After discussion, it was decided that we should avoid
> > waiting for the two locks during MIGRATE_SYNC_LIGHT if they were being
> > held for IO. We'll continue with the unbounded wait for the more full
> > SYNC modes.
> >
> > With this change, I couldn't see any slow waits on these locks with my
> > previous testcases.
>
> Well this is the upside after this change, but given the win, what is
> the lose/cost paid? For example the changes in compact fail and success [=
1].
>
> [1] https://lore.kernel.org/lkml/20230418191313.268131-1-hannes@cmpxchg.o=
rg/

That looks like an interesting series. Obviously it would need to be
tested, but my hunch is that ${SUBJECT} patch would work well with
that series. Specifically with Johannes's series it seems more
important for the kcompactd thread to be working fruitfully. Having it
blocked for a long time when there is other useful work it could be
doing still seems wrong. With ${SUBJECT} patch it's not that we'll
never come back and try again, but we'll just wait until a future
iteration when (hopefully) the locks are easier to acquire. In the
meantime, we're looking for other pages to migrate.

-Doug
