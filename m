Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99A6F8A31
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjEEUcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjEEUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:32:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5F740FB;
        Fri,  5 May 2023 13:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 745C260FE1;
        Fri,  5 May 2023 20:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9131C433EF;
        Fri,  5 May 2023 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683318737;
        bh=fct4miS7THl0IRl6CPk0AuNGd4Gp/qV10BUwUPAtSqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1tN/DMaahewTwKwF+Bm37W+jHD8igWbS0PpBeMj6sp85N0PQvRPoEStVb3fCjD7b
         3W4y02HqmH2Nija1ImD/d6OoUvcB0Vc/rY6fx7CPPFmiLrscWkcclg3UYMXVE33iv2
         SBMwyMww9XeCLrz/tlClAmoZbVA6pdD5CYJkTDSLc7sZ+4yZwG30Jp+ryRnd6QREyG
         D+klYt2bAMtpPozT5qsoqIyBfYpD//bR437/bp/Nc6QA47NWludkSJChQ0bS2qtkq2
         uKVPNdyxN/4nvsGN1rpdLd+hbia8W15CIjmwcEuhOWe7MEnqTMewQRxnxxlfj/m317
         ExEpwwIfHvkjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88F79403B5; Fri,  5 May 2023 17:32:15 -0300 (-03)
Date:   Fri, 5 May 2023 17:32:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dmitry Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, jolsa@kernel.org, irogers@google.com
Subject: Re: [RFC PATCH] perf stat: Separate bperf from bpf_profiler
Message-ID: <ZFVnz1oJxXb7MSDY@kernel.org>
References: <20230412182316.11628-1-9erthalion6@gmail.com>
 <20230421205610.xawzzfy36iskcoyx@erthalion.local>
 <ZEx2gsEOWNxXaY/+@kernel.org>
 <CAPhsuW5e+2rjnbEsXXXuBO2bUvyx0mHquxb6a0a6MGqXdaodUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5e+2rjnbEsXXXuBO2bUvyx0mHquxb6a0a6MGqXdaodUw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 04, 2023 at 07:01:04PM -0700, Song Liu escreveu:
> On Fri, Apr 28, 2023 at 6:44 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > Em Fri, Apr 21, 2023 at 10:56:10PM +0200, Dmitry Dolgov escreveu:
> > > > On Wed, Apr 12, 2023 at 08:23:16PM +0200, Dmitrii Dolgov wrote:
> > > > It seems that perf stat -b <prog id> doesn't produce any results:

> > > >     $ perf stat -e cycles -b 4 -I 10000 -vvv
> > > >     Control descriptor is not initialized
> > > >     cycles: 0 0 0
> > > >                 time        counts unit      events
> > > >     10.007641640    <not supported>      cycles

> > > > Looks like this happens because fentry/fexit progs are getting loaded, but the
> > > > corresponding perf event is not enabled and not added into the events bpf map.
> > > > I think there is some mixing up between two type of bpf support, one for bperf
> > > > and one for bpf_profiler. Both are identified via evsel__is_bpf, based on which
> > > > perf events are enabled, but for the latter (bpf_profiler) a perf event is
> > > > required. Using evsel__is_bperf to check only bperf produces expected results:

> > > Any thoughts on this? I would appreciate clarifications if I'm missing
> > > something.

> > Namhyung, Song, can you please take a look at this?

> Sorry for the late response. The fix looks good to me and worked well
> in my test.

> Reviewed-and-tested-by: Song Liu <song@kernel.org>

> I guess we also need:

> Fixes: 112cb56164bc2 ("perf stat: Introduce config stat.bpf-counter-events")

Thanks a lot, applied, and this is relevant in the current situation,
where we're trying to have Linux v6.4 perf tools building BPF skels by
default.

- Arnaldo
