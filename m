Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3A71F4F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjFAVoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFAVow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:44:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F745D1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:44:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f60b3f32b4so13299395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685655889; x=1688247889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CV50tpPLXis1GlgJKl2TEoKhLRvf1nVlZ80Fuqk0QiY=;
        b=ARn/uG+JPfHQtjFRGkGjmUfS8LM7aZ8ldg1my/5FruqK8eYJEdcDGezm+2LoEZt4kd
         dyiEOvMbGkH7Tkr04Dj2a3j2nQrVS9io2CT34bsReFfisIBeRFfLh4KhuSwhWpKeEqLB
         5ywOU5lGmuE6oVOrbQdafCflXURIEGY83xK/HGpDbUlFQwk+2xpcl+cvXpEuP2ii6dXG
         c+/TzXnG+3hGclidaylc/QOuysEG3+9EqEsvQj6Gy2Nhw/CI/t5WpGKnM0Wutyu9zQHP
         TiQ/6rNYpiffWQhqnYFdlTlKLqeRUK0tFrGUwn2gSqOOmKP1wIUEUClWs0ZRs/lcSRJQ
         O56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655889; x=1688247889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV50tpPLXis1GlgJKl2TEoKhLRvf1nVlZ80Fuqk0QiY=;
        b=H3YqYjae5Fu6qWSSETOMaO9NELFzAKKE83+4ajAG6EicpEeH15JWAg1Gqv3lrVgW+J
         CpIoEcivDPfb/RJmMfIqpzi4sMmdLqMoINYgmJQHVPkhOtPiG78zxnlxwmTH1YCkHbz5
         6TJaaxIxFQ2xUQ2t/LXGdnUjAoBd3hVaFJh51kD0Zp4EpYIjIViukcV9Y7PzoLD2W6Lz
         NyWr38//kIPwVVw9p2nMSLEFrgL+SxSO/FJCzq4U0MQpL9WBerZqIal4ZPWr/Ni6fjgA
         ys35TlEMjNEII5pLo1mOSpvAXoKJ2Bzd7dPeNQYT9WrwDBCR2qhqsyC6LTSnOHOIjs3D
         p4jw==
X-Gm-Message-State: AC+VfDyEIZKT7Jd4bMgP8VvI9V31t7snwlR20YD/VtxUT0MWVwxbgGDC
        W27z3nAeWGmcCkQMNJvpUR0=
X-Google-Smtp-Source: ACHHUZ6QrKJRv/x60FVZk1zpbjZw2Gu+3x2HIc0NdbUmNphsBz+GBdUsQPb0xM/XYxjnzyBTcPbxZw==
X-Received: by 2002:a05:600c:b47:b0:3f6:5169:1ad5 with SMTP id k7-20020a05600c0b4700b003f651691ad5mr539645wmr.38.1685655889326;
        Thu, 01 Jun 2023 14:44:49 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id s19-20020a7bc393000000b003f4248dcfcbsm3552762wmj.30.2023.06.01.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:44:48 -0700 (PDT)
Date:   Thu, 1 Jun 2023 22:44:47 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
Message-ID: <8bfa7124-4306-4220-b0c6-81f318203fea@lucifer.local>
References: <20221217001554.554913-1-lstoakes@gmail.com>
 <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y51/Mt70d++6Zzzq@lucifer>
 <20221219100734.jag6zejp4tug77yq@techsingularity.net>
 <CAA5enKbsmy99-GCNuVcDRbjESZaLuE4=s8+6PzWP8J-wmOZwEg@mail.gmail.com>
 <CAHbLzkoSC7Q+xAMaSoNihn2eww-+5RZADxe5h7_FidGHELE3BQ@mail.gmail.com>
 <20230601091002.zl3udcqxmb3tjtri@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601091002.zl3udcqxmb3tjtri@techsingularity.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:10:02AM +0100, Mel Gorman wrote:
> On Wed, May 31, 2023 at 02:29:01PM -0700, Yang Shi wrote:
> > On Wed, May 31, 2023 at 8:24???AM Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> > >
> > > On Mon, 19 Dec 2022 at 10:07, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > >
> > > > On Sat, Dec 17, 2022 at 08:34:58AM +0000, Lorenzo Stoakes wrote:
> > > > I reckon we should give it another few months until May. There has been
> > > > one user recently that tried to use list but it turned out arrays were
> > > > more appropriate.
> > > >
> > >
> > > It being May 31st, it feels appropriate to chase this up :)
> > >
> > > David's series at [0] did initially use this function, before
> > > switching to the _array() variant. Other than that it seems that it
> > > remains unused.
> >
> > Thanks for following this up. My patchset (use bulk allocator for
> > dm-crypt) also switched from list API to a new callback API suggested
> > by Mel. But I haven't heard anything back from Mel about it yet. I
> > forgot to follow up due to too many distractions.
> >
>
> It needs a follow-up. My various inboxes that I get cc'd on currently exceed
> 1000 mails due to being offline a lot during the last few months so there
> could be a lot hiding in there. Conceptually at least I don't recall having
> any problem with the callback patches as long as the dm-crypt people are
> happy. I vaguely recall a review disappeared off into the weeds talking
> about maybe using physically contiguous pages (missing the point of using
> the bulk allocator at all and ignoring fragmentation concerns affecting
> allocation success rates) but I'm not certain.

Entirely understandable re: this (rather trivial) removal, and obviously
this is far from high priority so no rush.

However, if you feel Yang's series ought to use a different interface and
given no other users of alloc_pages_bulk_list() have emerged, I am happy to
go ahead and respin the patch. If you want to wait absolutely no problem
either! :)

Cheers, Lorenzo

>
> --
> Mel Gorman
> SUSE Labs
