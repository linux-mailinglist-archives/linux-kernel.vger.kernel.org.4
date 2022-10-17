Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B08601DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiJQXsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiJQXrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:47:52 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B397985AB6;
        Mon, 17 Oct 2022 16:47:41 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-131dda37dddso15151926fac.0;
        Mon, 17 Oct 2022 16:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ei9+z+RKpmt1z7epHvqK2iTl22w3n8AvRxEPxMVR2Yw=;
        b=gkAHLUwd1zj/a9koGTnCFWcjNF1qX6IWoWFbU79t5Riv7abDt2VBFACRhdGjoBV1uB
         dVeImzN966FaP4j2IM0BQikcIb7pmpJbjzciVMNlc1+g7fdnz+0HpPHNpADF5Zrazq8L
         tylAM+1G4Rc/RJT3KKIwnhV39Af7yVTgOvRTketo+rRTbeSQ0zSIw3r5Cc4wJdFmnZxO
         hYlhT6bnDOBJgqDWXCHLxxhFdtvzPkA3VcAV0z+QRKDvowW5isK96euaoMKMjNmXPvDU
         yphcdcyHRUNKkI4e8HCM/E8Z6W1tYwTtXWdP+XZpvf5RmMmPGDgD4MCH2Gxi+C4Bj42h
         icmw==
X-Gm-Message-State: ACrzQf1E/l/2cEir3Ha5B1lGgKOmKiqYhHb30ILmE+FYsN7pAn6Lnd5I
        xsLjQeAjNarvqjbqvIykfyaL0b/V8qzigQzh0sk=
X-Google-Smtp-Source: AMsMyM4h2YuUzMJW/arD5fSPZY2RZMX2Nu9JsFskScaAAMM8s3z7KMnqpHyz7mJdJ7JCqg/XzoqJxavwpzv6vbekQ+Y=
X-Received: by 2002:a05:6870:4184:b0:136:5e73:b40e with SMTP id
 y4-20020a056870418400b001365e73b40emr72714oac.209.1666050461024; Mon, 17 Oct
 2022 16:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221012111025.30609-1-james.clark@arm.com> <62f485df-4f5e-64a2-1294-6e162de25556@arm.com>
 <CAM9d7cgNrZ6iwRQsGHWGLWCd7cJm+L6UOU9BiGGgTVPdJ0_GJQ@mail.gmail.com>
 <e0b47b51-87f0-42db-4a76-b240bf07cd41@arm.com> <CAM9d7cg+tTw5vTOycqRciQx8He-WLG0TSdcWa0tyzeu49DmgxA@mail.gmail.com>
 <912a4d0a-51b3-591b-8c8f-f078216d5b35@arm.com> <Y01Lnh5DqGUPuibf@kernel.org>
In-Reply-To: <Y01Lnh5DqGUPuibf@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 17 Oct 2022 16:47:29 -0700
Message-ID: <CAM9d7ci0B03fKHydrXXPEnJOVbWA3tpirxec_A3VE3NsPU2rRw@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix "Track with sched_switch" test by not printing
 warnings in quiet mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 5:33 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Oct 14, 2022 at 10:47:34AM +0100, James Clark escreveu:
> > On 13/10/2022 17:57, Namhyung Kim wrote:
> > > On Wed, Oct 12, 2022 at 10:12 AM James Clark <james.clark@arm.com> wrote:
> > >> On 12/10/2022 17:50, Namhyung Kim wrote:
> > >>> On Wed, Oct 12, 2022 at 4:13 AM James Clark <james.clark@arm.com> wrote:
> > >>>>> The test already supplies -q to run in quiet mode, so extend quiet mode
> > >>>>> to perf_stdio__warning() and also ui__warning() for consistency.
> > >>>
> > >>> I'm not sure if suppressing the warnings with -q is a good thing.
> > >>> Maybe we need to separate warning/debug messages from the output.
> > >>
> > >> I don't see the issue with warnings being suppressed in quiet mode as
> > >> long as errors are still printed. In other cases warnings have already
> > >> been suppressed by quiet mode and this site is the odd one out.
> > >>
> > >> What use case are you thinking of where someone explicitly adds -q but
> > >> wants to see non fatal warnings?
> > >
> > > I don't have any specific use case.  If it's already suppressed in other
> > > cases, I'm fine with it.
> > >
> >
> > Actually I may have been mistaken. Seems like quiet is only used for
> > "extra info" type messages rather than warnings. Although the commit
> > message does say:
> >
> >   The -q/--quiet option is to suppress any message. Sometimes users just
> >   want to see the numbers and it can be used for that case.
> >
> > With 'any' that I would take to include warnings as well. I could move
> > warnings to stderr, but this has a much greater chance of breaking
> > anyone's workflows that might be looking for warnings on stdout than
> > removing warnings when -q is provided.
> >
> > Also if warnings are moved to stderr and quiet isn't used, there would
> > be no way to suppress warnings in the TUI which might actually be a
> > useful feature.
> >
> > So I'm still leaning towards the original change, if you are ok with
> > that even though it's not done elsewhere?
>
> Namhyung? I tend to agree with James.

I think it's a matter of choice.  With this change, users won't see
warnings with -q anymore.  This MIGHT affect some users as they
can see low quality data silently due to missing data or something.

If you're ok with the behavior, I'm fine.  But then we need to update
the document to clarify the behavior.

Thanks,
Namhyung
