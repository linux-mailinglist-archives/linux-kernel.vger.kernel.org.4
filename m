Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9446821EE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjAaCNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAaCNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:13:47 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1EE2F79A;
        Mon, 30 Jan 2023 18:13:46 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so11419579wma.1;
        Mon, 30 Jan 2023 18:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9pRDoiS5AR3g6YwrAuc/Yjjp7F1D+mNr/yQup2Qmh0=;
        b=M50QAdnil0fuf2dpP7I1PUWzZ7WL4VyzZJa1sOHtWq6EoDBHjCaI/4+yxXkLrvsX6b
         r/x38WA5APdNpQ040JJszfPlJz2VcHOP7x8SuEQ07NC1saXds77p6y+7I9dOl6OCl50z
         b0B+5dML3Q0LOj8e+oulVwqn5YwOVNNL0lauuD5sbYedrz0KJF/GwX2hRtFBG0cPA8yB
         o/KNNNTNJR4pyjIDjE+eWZrV/9NZoG0ng/VDCpp0bV/u0MQbpSUN+egFKcjvbSrhYTEF
         q/iTZwtzHU0pWAo7+U/u/eJDRFoa0547YL0kJxtiPYvN4doCQ3BcRR8p7BUH7kc25i7z
         3PaA==
X-Gm-Message-State: AFqh2kpd8PpedzWpAad5jHQoscNbag8JvgzmAkMt+obcl/ciw9/0eIkI
        VOT7Gzh97natCQKbnS4ecx6Et48W5kRtoYgpxHw=
X-Google-Smtp-Source: AMrXdXtyZe/SUBPmb3AbkrfmeHyqkCfWDG8LGaxhGnCCaQwspwbUktIL2RmxPn7fOp/5FYv0C6etUZJsOi4WXgjsYkU=
X-Received: by 2002:a05:600c:538e:b0:3db:1a:3490 with SMTP id
 hg14-20020a05600c538e00b003db001a3490mr2110585wmb.158.1675131224803; Mon, 30
 Jan 2023 18:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20230127001951.3432374-1-namhyung@kernel.org> <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
 <317a91ff-70c5-57a5-8447-7543057e4055@arm.com> <CAM9d7chU6kTdG0y65_UaD_hW75GezzNJF1ZwjNWq8BUpACAGTA@mail.gmail.com>
 <43ff6d3d-2047-1b2f-12ab-849a915a6e2f@arm.com>
In-Reply-To: <43ff6d3d-2047-1b2f-12ab-849a915a6e2f@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Jan 2023 18:13:32 -0800
Message-ID: <CAM9d7cju5-Zvb19wmzUHpMKL_Hzf8+vOvaAx4Ob2dDhwbJ5ynA@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
To:     James Clark <james.clark@arm.com>
Cc:     Denis Nikitin <denik@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 2:56 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 27/01/2023 23:08, Namhyung Kim wrote:
> > Hi James,
> >
> > On Fri, Jan 27, 2023 at 6:42 AM James Clark <james.clark@arm.com> wrote:
> >>
> >>
> >>
> >> On 27/01/2023 07:22, Adrian Hunter wrote:
> >>> On 27/01/23 02:19, Namhyung Kim wrote:
> >>>> Hello,
> >>>>
> >>>> I found some problems in Intel-PT and auxtrace in general with pipe.
> >>>> In the past it used to work with pipe, but recent code fails.
> >>>
> >>> Pipe mode is a problem for Intel PT and possibly other auxtrace users.
> >>
> >> Just some info from my side: For Arm Coresight we ended up deprecating
> >> pipe mode, then not supporting it altogether. First was when we added an
> >> optional step to peek through all of the data to help with an edge case.
> >> Then we added a requirement to receive a HW_ID packet before decoding
> >> which necessitated the peek. You can't peek in pipe mode because you
> >> need to be able to seek, so it's not supported at all anymore.
> >>
> >> For Arm SPE I never tested it with piped data. I suppose I could add a
> >> test at some point, but I don't really see the usecase.
> >
> > Yeah, it'd be great if we can have a test for Arm SPE.
> >
>
> Ok thanks I will put it on the list of things to do.
>
> > Anyway, my work env (Google) requires the pipe mode due to the
> > restriction in disk usage.  Without the pipe support, it's not possible
> > to run `perf record` in production.
> >
>
> Makes sense. Unfortunately at the moment with Coresight, because of the
> lack of appropriate timestamps we're waiting for the end of the file
> before starting decoding. So you're not really any better off using
> piped mode, unless you have a lot more memory than disk space?
>
> Since this commit [1] and Arm v8.4 we can actually start making use of
> the timestamps and do a streaming decode again. So I will also add it to
> the list to look into that for Coresight again. Are you using an old
> version of Perf or not using Coresight at all? I know Denis at Google is
> using Coresight, but only with files rather than pipes.

I'm not aware of usage of Coresight yet in my boundary, but others
may be using it.

>
> One other thing, have you used the --switch-output mode to perf record
> before? I would have said it would give you some of the benefits of
> piped mode, but is more likely to work with Coresight. But last time I
> checked it's not working either. Not very helpful I know, but something
> to keep in mind.

I don't think it'd work because it still occupies the same space.
So far, the pipe mode worked well but I think it needs some
more improvements.

Anyway, thanks for your suggestion and review!

Thanks,
Namhyung
