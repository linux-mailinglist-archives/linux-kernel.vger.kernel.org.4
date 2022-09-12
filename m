Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30185B5BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiILNzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiILNzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7BA1A816;
        Mon, 12 Sep 2022 06:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90382611EA;
        Mon, 12 Sep 2022 13:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DB5C4347C;
        Mon, 12 Sep 2022 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662990944;
        bh=Dy2EbJ5ni9M55FI7K6zj6jzmJK0ch5Evbutzxm1MYz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UU4oaQoNj99lkBihNfx9r1I1X9ZAOkYcG6NeqjUQmLi1Jsbt4Au7ojaeI8X6mpVZS
         D2HMG4++0QPh+8ZZ7rzBhXiKj1hNPDre971B6cZUb4q6SKmMszQf/5ofQ7BPffnxwZ
         JkJmlvPlgDnuh2g33or6/HgVHfaKnqIgnHccAgoxxVnGwaw6VQDsSMkuVQRHbc/5OI
         Ivn2XnYU39e1oYuZKsfMi29Zq8TspNOExXCLq+Rzp2dHMc062B1N2WGOZ886RNsfhj
         oqV3ga/fahafMeSwLrrLyd9wtKA4+Y3dGhdd7qPqavcF+PT0tKQZGzW/f5UT8bgB9E
         ZfETrCGSBagGw==
Received: by mail-ua1-f54.google.com with SMTP id r17so3166986uat.8;
        Mon, 12 Sep 2022 06:55:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo1kMUyrI6T/ZAZBtGwRzmv272n1c0FRZgUMltW2ZHSPlZws6JfB
        FUZI56LNHmlxYcswspvTDAYUDbSNYV00M9XSEA==
X-Google-Smtp-Source: AA6agR52m9u/aPYhTJ7g7+9jJJHlszALmFaQiQKVK8jFXXqKZfz55U4iBk969LFKfa7El3bj8dp49U0d6GckxMhnwWQ=
X-Received: by 2002:ab0:32d1:0:b0:3ab:7f86:2121 with SMTP id
 f17-20020ab032d1000000b003ab7f862121mr8410006uao.86.1662990943721; Mon, 12
 Sep 2022 06:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220909204509.2169512-1-robh@kernel.org> <Yx8LgqUtDh5TwWmV@leoy-huanghe.lan>
In-Reply-To: <Yx8LgqUtDh5TwWmV@leoy-huanghe.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 12 Sep 2022 08:55:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGrUrahj-T+k7T9GAF+T8=y03YUTG2V+v52styFFDW_Q@mail.gmail.com>
Message-ID: <CAL_JsqJGrUrahj-T+k7T9GAF+T8=y03YUTG2V+v52styFFDW_Q@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Skip and warn on unknown format 'configN' attrs
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 5:35 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Rob,
>
> On Fri, Sep 09, 2022 at 03:45:09PM -0500, Rob Herring wrote:
> > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > will return an error stating the specified PMU can't be found. For
> > example, a format attr with 'config3:0-63' causes an error as config3 is
> > unknown to perf. This causes a compatibility issue between a newer
> > kernel with older perf tool.
> >
> > Before this change with a kernel adding 'config3' I get:
> >
> > $ perf record -e arm_spe// -- true
> > event syntax error: 'arm_spe//'
> >                      \___ Cannot find PMU `arm_spe'. Missing kernel support?
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf record [<options>] [<command>]
> >     or: perf record [<options>] -- <command> [<options>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list
> > available events
> >
> > After this change, I get:
> >
> > $ perf record -e arm_spe// -- true
> > WARNING: format 'inv_event_filter' requires 'config3' which is not supported by this version of perf!
> > [ perf record: Woken up 2 times to write data ]
> > [ perf record: Captured and wrote 0.091 MB perf.data ]
> >
> > To support unknown configN formats, rework the YACC implementation to
> > pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
> > warning.
> >
> > Note that the user will get the warning if *any* PMU has an unsupported
> > format attr even if that PMU isn't used. This is because perf tool scans
> > all the PMUs.
>
> I think essentially you want to provide a bug fixing and the fixing can
> be back ported on long term supported kernels?

Yes, certainly. I forgot to note that on this version.

> If this is the case,
> it's good to add a fixes tag like below?
>
> Fixes: cd82a32e9924 ("perf tools: Add perf pmu object to access pmu format definition")

Probably not too important given this is from 2012.

>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> >  - Rework YACC code to handle configN formats in C code
> >  - Add a warning when an unknown configN attr is found
> >
> > v1: https://lore.kernel.org/all/20220901184709.2179309-1-robh@kernel.org/
> > ---
> >  tools/perf/util/pmu.c |  6 ++++++
> >  tools/perf/util/pmu.l |  2 --
> >  tools/perf/util/pmu.y | 15 ++++-----------
> >  3 files changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 89655d53117a..6757db7d559c 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1475,6 +1475,12 @@ int perf_pmu__new_format(struct list_head *list, char *name,
> >  {
> >       struct perf_pmu_format *format;
> >
> > +     if (config > PERF_PMU_FORMAT_VALUE_CONFIG2) {
>
> It's good to add a new macro PERF_PMU_FORMAT_VALUE_CONFIG_END in
> util/pmu.h. Then at here we can check the condition:

Sure.

>
>        if (config >= PERF_PMU_FORMAT_VALUE_CONFIG_END) {
>
> > +             pr_warning("WARNING: format '%s' requires 'config%d' which is not supported by this version of perf!\n",
> > +                        name, config);
>
> ... so at here we can print log like:
>
>        pr_warning("WARNING: format '%s' requires 'config%d' which is not "
>                   "supported by this version of perf (maximum config%d)!\n",
>                   name, config, PERF_PMU_FORMAT_VALUE_CONFIG_END - 1);

I was trying to keep it to one line and given configN isn't expanded
frequently it should be simple enough to figure out what version you
need.

>
> The rest of this patch is fine for me.
>
> As a side topic, I know you want to support the SPEv1.2 feature with
> config3, seems to me a complete patch set series should include the
> changes for supporting config3 as well.  This can give more clear view
> for how to fix incompatibility issue between old and new kernels, and
> how to support config3 in the latest kernel, but it's fine for me if
> you want to split into two patch sets.

I've sent out the SPE kernel support separately. I was told by Arnaldo
to split perf tool and kernel side changes.

Rob
