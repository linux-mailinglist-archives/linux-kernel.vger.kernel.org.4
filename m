Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B618864B9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiLMQkr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Dec 2022 11:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiLMQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:40:44 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E93E3F;
        Tue, 13 Dec 2022 08:40:43 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id h11so16225669wrw.13;
        Tue, 13 Dec 2022 08:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F6Co5g0HJu8PhXSFObDaybergLnWCfKZDoB5ZDhG3Q=;
        b=eCxGXZLa3sVxIyXAkNErluuOgcRVRZ00PSLFWEhVPkhApLCMcdDyFLcdsLWDkU/KuD
         uF2n3p2a7o/Mx1sV17jeu2EfItcHKJ3AFz6BWnsgAFDaygBdhghwSNTJqCDJH8j1Zj+P
         WLk+3fJvKwWNGPM+pJVw0U/tz0OKUvDvxk4svLQ9TrjRMZokAnaEkXwkHGeAdxbjeWKo
         LPM42HxLudrVyYDWk6/LHo33d8W+IaNV7EUHY86O6K3/ibeq1h2z3QgEkgKqvlwnI8z4
         ij8B2n9ywQId5AjMW806eaHs8rHSyg5Qln5Ctnjr5FDsqEzj8kDg3b1yr/vuM0i53I9t
         iR6Q==
X-Gm-Message-State: ANoB5pmUxs3deR0WIUX90yxF4IUZT+CAq5a7vRlN3DdVrPdxlGNS45RF
        6sXae6DkNEvhjR23o6v2YbHiWxKAihbiLJuoyXk=
X-Google-Smtp-Source: AA0mqf7UN3ZVN8sgqMJf56eMQQKmcmbQrP0Dtm+uIEySSUo8URwHqE1Xm/cPFTx1fF4j4DQMuqczt/M6XlNDCLi7H3E=
X-Received: by 2002:adf:dec2:0:b0:242:6f04:93a9 with SMTP id
 i2-20020adfdec2000000b002426f0493a9mr9406130wrn.685.1670949641783; Tue, 13
 Dec 2022 08:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com> <e3e123db-5321-c96e-1753-27059c729640@arm.com>
 <Y5iPsjF/lEsEldU8@kernel.org>
In-Reply-To: <Y5iPsjF/lEsEldU8@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 13 Dec 2022 08:40:31 -0800
Message-ID: <CAM9d7cj=Pu2QAONzd2JSVzd_X9DakeV=khcFGD_d-ES5zrx+KQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        =?UTF-8?Q?Adri=C3=A1n_Herrera_Arcila?= <adrian.herrera@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, songliubraving@fb.com, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 13, 2022 at 6:44 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Aug 01, 2022 at 09:20:37AM +0100, James Clark escreveu:
> >
> >
> > On 29/07/2022 17:12, Adrián Herrera Arcila wrote:
> > > The described --delay behaviour is to delay the enablement of events, but
> > > not the execution of the command, if one is passed, which is incorrectly
> > > the current behaviour.
> > >
> > > This patch decouples the enablement from the delay, and enables events
> > > before or after launching the workload dependent on the options passed
> > > by the user. This code structure is inspired by that in perf-record, and
> > > tries to be consistent with it.
> > >
> > > Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
> > > Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> > > Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>
> > > ---
> > >  tools/perf/builtin-stat.c | 56 ++++++++++++++++++++++-----------------
> > >  1 file changed, 32 insertions(+), 24 deletions(-)
> >
> > Looks good to me. Fixes the counter delay issue and the code is pretty
> > similar to perf record now. Although I would wait for Leo's or Song's
> > comment as well because they were involved.
>
> I think I didn't notice Leo's ack, it still applies, so I'm doing it
> now.

I think the BPF counters should be enabled/disabled together.

Thanks,
Namhyung
