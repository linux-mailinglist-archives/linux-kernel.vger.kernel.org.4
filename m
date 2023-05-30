Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16567716F96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjE3VUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjE3VUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:20:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B2C0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:20:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f683e8855so716397466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685481638; x=1688073638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMgiLGfQY4K8q8It6kJThVSmE1j01dNv8Q5A098cJZg=;
        b=OLK4N2ZVIECTEdD542qtMV4UeyeOcMLKuxHtrmbJLAN09hdUPkJjgO/Om1wh+36n78
         reU0DbmtM0Skg20UOwEKxmrMHMGhw3M4Qj1jbiuzaJUGhAmpkzaRLaFgl4MCOB5h7Ltu
         CNOcR0i+gkVIiSX2mZ3zxTP6yVS7OTi77hTo1nxYTzvXKBFXpTed7QXmVqbh9ZkAp2+q
         5mw18/wxpdL7ZiZydH/hY4WCD78hUg67Qm1PwaaGEkkBsM04p8NNpt8QAmtdZxKrxJW1
         5BSTIbAR9Fj7sJkcEWTqhWSRtjhBFI3vUCostXcEa2ZrsFBZJ5KZcbc9nYgl2hvFgxRX
         29UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685481638; x=1688073638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMgiLGfQY4K8q8It6kJThVSmE1j01dNv8Q5A098cJZg=;
        b=Ym6BqqUEjSr+Zf9vKPP2up/UF6rhaniBbudCGHpLlPPyu9KjwSJYfSWL9o8wYQNy+6
         FbAthHHiyLU02ypEPJfVeEi5INGy7GvA77MBrPWg3UaCeu3keZqUtw+jvqklrEXBVeP8
         Dm/RHSagYyO0icwVj64M3zvMGbznXNvh5DR5ePKw1+nhUmIGwh7z/cQDEkQ6RCDnpqjE
         WALClVY0b8ElioM/tAcof6LM+vY6pci0UqN9ZGSYa20vmsXnvihhU/75DOmnnUqgeGjr
         TkpgO5BxDaXRV2gjmZFHYu+631MW+dxLi6f08a7spCYHOvzX9NWXXPbrq5Ov5eyI+Ot0
         +jHg==
X-Gm-Message-State: AC+VfDxcaELSIXL/3hPfIPtH69YOJ2JcFYQVhuyr4jlFU8xLXHoJr898
        LP4OLdEYo0KUVIyqDo9A95mU6seGVBxmh3KIZkr+pA==
X-Google-Smtp-Source: ACHHUZ67GOY7kKYCgiNWjTC19+TLUBNL/QCaivt1MXil5qIddaAYtxcvL4i/gEoXq+hYlFCPot6GKoKeYdwedhr6d0I=
X-Received: by 2002:a17:907:9813:b0:965:6cb9:b768 with SMTP id
 ji19-20020a170907981300b009656cb9b768mr2770998ejc.31.1685481638228; Tue, 30
 May 2023 14:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230530210251.493194-1-yosryahmed@google.com> <20230530141547.609c4a434470c3fbf7570ff8@linux-foundation.org>
In-Reply-To: <20230530141547.609c4a434470c3fbf7570ff8@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 30 May 2023 14:20:01 -0700
Message-ID: <CAJD7tkYwHufwgzBkyycjW=LXYUKB9cS74uDaUseaLDe5mpQ+VA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: support exclusive loads
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 2:15=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 30 May 2023 21:02:51 +0000 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > Commit 71024cb4a0bf ("frontswap: remove frontswap_tmem_exclusive_gets")
> > removed support for exclusive loads from frontswap as it was not used.
> >
> > Bring back exclusive loads support to frontswap by adding an
> > exclusive_loads argument to frontswap_ops. Add support for exclusive
> > loads to zswap behind CONFIG_ZSWAP_EXCLUSIVE_LOADS.
>
> Why is this Kconfigurable?  Why not just enable the feature for all
> builds?

I assumed that some users want the current behavior, where reclaiming
clean pages that were once in zswap would be faster. If no one cares,
I can remove the config option and have it always on.

>
> > Refactor zswap entry invalidation in zswap_frontswap_invalidate_page()
> > into zswap_invalidate_entry() to reuse it in zswap_frontswap_load().
> >
> > With exclusive loads, we avoid having two copies of the same page in
> > memory (compressed & uncompressed) after faulting it in from zswap. On
> > the other hand, if the page is to be reclaimed again without being
> > dirtied, it will be re-compressed. Compression is not usually slow, and
> > a page that was just faulted in is less likely to be reclaimed again
> > soon.
> >
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -46,6 +46,19 @@ config ZSWAP_DEFAULT_ON
> >         The selection made here can be overridden by using the kernel
> >         command line 'zswap.enabled=3D' option.
> >
> > +config ZSWAP_EXCLUSIVE_LOADS
> > +     bool "Invalidate zswap entries when pages are loaded"
> > +     depends on ZSWAP
> > +     help
> > +       If selected, when a page is loaded from zswap, the zswap entry =
is
> > +       invalidated at once, as opposed to leaving it in zswap until th=
e
> > +       swap entry is freed.
> > +
> > +       This avoids having two copies of the same page in memory
> > +       (compressed and uncompressed) after faulting in a page from zsw=
ap.
> > +       The cost is that if the page was never dirtied and needs to be
> > +       swapped out again, it will be re-compressed.
>
> So it's a speed-vs-space tradeoff?  I'm not sure how users are to
> decide whether they want this.  Did we help them as much as possible?

Yes, it is a reclaim speed vs. space tradeoff.

My intuition is that it should be more useful to have this enabled, as
the memory savings should be more important than having reclaim be a
little bit faster in some specific situations. We can make the
configuration on by default if others agree.

I would imagine users would turn this configuration on and observe
memory usage of zswap vs. reclaim speed, and decide based on the
numbers.

>
>
