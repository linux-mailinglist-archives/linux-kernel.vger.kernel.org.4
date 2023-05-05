Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA66F7AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEECBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEECBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825C120A9;
        Thu,  4 May 2023 19:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C05D263ABB;
        Fri,  5 May 2023 02:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A344C433D2;
        Fri,  5 May 2023 02:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683252078;
        bh=ZS3YDRfyUL+4s0HOmEwczt4nBL9aZThHgS9wOj3+vr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ffkyqnOKrju+rUXMKoV75RJb5s5sv55V0F42e5sa607EgsmfWuHCz0kl+oAIWye5L
         vhEgikIJO5LtPoitHQqyZ7wloDkpxS+pmfv3w+p86MiiwqLp1Ix4E4oxsf9rINM9YO
         ftqafPuSpWHWf2+efacxolKYFbzJbhlpR+RNQBf3tQO+EQmy+tKq9Q8ro8sdnAei6W
         dnf7FECjGRdGjyfQwRMkIqigAiDbuRJzAEoYEwepH24hAV7KDMOF+InF83NSxdUkKu
         w7GIng5kd+GtCAe2g/2zM9VJAkI/EFLSb9zNHJzJZnVsc1KuBMk1pqsTrikGHBaUZz
         5nvGQOIzpikOQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4eff055d4d3so1353192e87.3;
        Thu, 04 May 2023 19:01:17 -0700 (PDT)
X-Gm-Message-State: AC+VfDxXYFdxK39wkv6m71xQuxaE/KyUCvf66Wr2s9gQIlFtOTgBUrXo
        7qO+yTWEyPWZnzyFxy2gCyGFwblyOBshtNt7R8A=
X-Google-Smtp-Source: ACHHUZ5+kF7zfmLmcC+Z394neICuwx0R0RBjorv/3Pxl7o4b1qOgseYDPiOXspx6m7cCWCyvlV8h4cwMkUpIK83EQl0=
X-Received: by 2002:ac2:5963:0:b0:4ea:e799:59f9 with SMTP id
 h3-20020ac25963000000b004eae79959f9mr50823lfp.66.1683252076056; Thu, 04 May
 2023 19:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230412182316.11628-1-9erthalion6@gmail.com> <20230421205610.xawzzfy36iskcoyx@erthalion.local>
 <ZEx2gsEOWNxXaY/+@kernel.org>
In-Reply-To: <ZEx2gsEOWNxXaY/+@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 4 May 2023 19:01:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5e+2rjnbEsXXXuBO2bUvyx0mHquxb6a0a6MGqXdaodUw@mail.gmail.com>
Message-ID: <CAPhsuW5e+2rjnbEsXXXuBO2bUvyx0mHquxb6a0a6MGqXdaodUw@mail.gmail.com>
Subject: Re: [RFC PATCH] perf stat: Separate bperf from bpf_profiler
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Dmitry Dolgov <9erthalion6@gmail.com>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, jolsa@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 6:44=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Apr 21, 2023 at 10:56:10PM +0200, Dmitry Dolgov escreveu:
> > > On Wed, Apr 12, 2023 at 08:23:16PM +0200, Dmitrii Dolgov wrote:
> > > It seems that perf stat -b <prog id> doesn't produce any results:
> > >
> > >     $ perf stat -e cycles -b 4 -I 10000 -vvv
> > >     Control descriptor is not initialized
> > >     cycles: 0 0 0
> > >                 time        counts unit      events
> > >     10.007641640    <not supported>      cycles
> > >
> > > Looks like this happens because fentry/fexit progs are getting loaded=
, but the
> > > corresponding perf event is not enabled and not added into the events=
 bpf map.
> > > I think there is some mixing up between two type of bpf support, one =
for bperf
> > > and one for bpf_profiler. Both are identified via evsel__is_bpf, base=
d on which
> > > perf events are enabled, but for the latter (bpf_profiler) a perf eve=
nt is
> > > required. Using evsel__is_bperf to check only bperf produces expected=
 results:
> >
> > Any thoughts on this? I would appreciate clarifications if I'm missing
> > something.
>
> Namhyung, Song, can you please take a look at this?

Sorry for the late response. The fix looks good to me and worked well
in my test.

Reviewed-and-tested-by: Song Liu <song@kernel.org>

I guess we also need:

Fixes: 112cb56164bc2 ("perf stat: Introduce config stat.bpf-counter-events"=
)

Thanks for the fix!
Song
