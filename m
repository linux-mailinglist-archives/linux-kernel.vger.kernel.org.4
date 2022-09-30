Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75555F1036
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiI3QpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiI3QpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:45:03 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E975B2C10A;
        Fri, 30 Sep 2022 09:45:01 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id l5so5283417oif.7;
        Fri, 30 Sep 2022 09:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DtR4aU0OkTAirqeF2H+2vc0hziMzTL5A3AhEGH5GIBs=;
        b=I61gpZ6G7oQSRhP4WEUKZXQalErmAmGJqwaOyLstLPIAdmhCLA0rsYTzDi2OFGecLJ
         ki58Q3pFxzLf39YIPt9uFLFMHImIUneVVYwMKDe/2nvL1eWKdJ0Z3SjmkvjpBhmdzK3e
         REEz0iXMg34nnOHZJ1q5iRiVa5NBUqq7f+gzCNLiHqyYCtaBF0Xn58/73ycExg6r36Ca
         I+myBQGYVCK165F9twnvIf4+yEMIe31lKPzLqBHe+0aBRn8VrmH5QejJgUYKORl2mpLV
         tLhCS1nF0hJ3Gho1GajWb/tmttZIdWS8L9O7xQvA2SGdnz/DOUIU6xxpxCvwdWiIVxCM
         /xvg==
X-Gm-Message-State: ACrzQf3ItnjLa/Cu2555NGtBBpptN7B7t/2savKUXyAcAVX9mWHcTmAA
        la7FHwcyQOZEtqi0lOEJWzEG19ekKuOpHJnE7z0=
X-Google-Smtp-Source: AMsMyM5wVx/GaT6jnDwOeM8zaMnB00+S4Jsj8ZtbmSe1d8rnPAWk9OxxwO6B59VGkyF3JGZwqQXUVks0jxtHsOcC0jM=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr4298209oib.218.1664556301207; Fri, 30
 Sep 2022 09:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220924165737.956428-1-namhyung@kernel.org> <20220924165737.956428-3-namhyung@kernel.org>
 <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com> <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
 <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com> <CAM9d7ciaOMOuJay5MzOYtg5paK_YmQskX1yqg=Oni1EzipPMwA@mail.gmail.com>
 <CAP-5=fX-as0WNCXMyzOwY=ek0gR9yNXbonXHAu1hsd5wOuX-Vg@mail.gmail.com>
 <CAM9d7ciDvCOsFE68NG6jRb02DdDEOmRf_h7XizdDLGBz0RX95Q@mail.gmail.com>
 <63905e96-55d5-1aa2-5dbe-167b9aecad8c@intel.com> <CAM9d7ciXESTPXZobir4KirSnh1NXHwENc4WpZTudgawUZOL71Q@mail.gmail.com>
 <37452f10-365d-f496-3cb2-b80481f5f079@intel.com>
In-Reply-To: <37452f10-365d-f496-3cb2-b80481f5f079@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Sep 2022 09:44:49 -0700
Message-ID: <CAM9d7chuK=QqmM=YVFZa9fO6RG7o2gJSrrTMZhegj3sFdLD3mQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
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

On Fri, Sep 30, 2022 at 5:50 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/09/22 23:42, Namhyung Kim wrote:
> > On Wed, Sep 28, 2022 at 10:19 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 29/09/22 08:09, Namhyung Kim wrote:
> >>> On Wed, Sep 28, 2022 at 7:08 PM Ian Rogers <irogers@google.com> wrote:
> >>>>
> >>>> On Wed, Sep 28, 2022 at 4:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>>>
> >>>>> On Wed, Sep 28, 2022 at 12:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>>
> >>>>>> On 27/09/22 20:28, Namhyung Kim wrote:
> >>>>>>> Hi Adrian,
> >>>>>>>
> >>>>>>> On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>>>>
> >>>>>>>> On 24/09/22 19:57, Namhyung Kim wrote:
> >>>>>>>>> The current code propagate evsel's cpu map settings to evlist when it's
> >>>>>>>>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> >>>>>>>>> be updated in perf_evlist__set_maps() later.  No need to do it before
> >>>>>>>>> evlist's cpus are set actually.
> >>>>>>>>>
> >>>>>>>>> Actually we discarded this intermediate all_cpus maps at the beginning
> >>>>>>>>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> >>>>>>>>> an evsel is added after the evlist cpu maps are set.
> >>>>>>>>
> >>>>>>>> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
> >>>>>>>> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
> >>>>>>>> added to the evlist.  It can also remove an evsel from the evlist.
> >>>>>>>
> >>>>>>> Thanks for your review.  I think it's fine to change evsel cpus or to remove
> >>>>>>> an evsel from evlist before calling evlist__create_maps().  The function
> >>>>>>> will take care of setting evlist's all_cpus from the evsels in the evlist.
> >>>>>>> So previous changes in evsel/cpus wouldn't be any special.
> >>>>>>>
> >>>>>>> After this point, adding a new evsel needs to update evlist all cpus by
> >>>>>>> propagating cpu maps.  So I think hybrid cpus should be fine.
> >>>>>>> Did I miss something?
> >>>>>>
> >>>>>> I wondered how it might play out if evlist__fix_hybrid_cpus() reduced the
> >>>>>> cpus from the target->cpu_list (using perf record -C) , since after this
> >>>>>> patch all_cpus always starts with the target->cpu_list instead of an empty
> >>>>>> list.  But then, in the hybrid case, it puts a dummy event that uses the
> >>>>>> target cpu list anyway, so the result is the same.
> >>>>>>
> >>>>>> I don't know if there are any cases where all_cpus would actually need to
> >>>>>> exclude some of the cpus from target->cpu_list.
> >>>>>
> >>>>> I'm not aware of other cases to reduce cpu list.  I think it'd be fine
> >>>>> if it has a cpu in the evlist->all_cpus even if it's not used.  The evsel
> >>>>> should have a correct list anyway and we mostly use the evsel cpus
> >>>>> to do the real work.
> >>>>>
> >>>>> Thanks,
> >>>>> Namhyung
> >>>>
> >>>> The affinity changes made it so that we use all_cpus probably more
> >>>> often than the evsel CPU maps for real work. The reason being we want
> >>>> to avoid IPIs so we do all the work on 1 CPU and then move to the next
> >>>> CPU in evlist all_cpus. evsel CPU maps are used to make sure the
> >>>> indices are kept accurate - for example, if an uncore event is
> >>>> measured with a CPU event:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.h?h=perf/core#n366
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n404
> >>>
> >>> Right, I meant it'd check the evsel cpus eventually even if it iterates
> >>> on the evlist all_cpus.  The evlist_cpu_iterator__next() will skip a
> >>> CPU if it's not in the evsel cpus.
> >>>
> >>> Thanks,
> >>> Namhyung
> >>
> >> Perhaps an alternative is to be explicit about deferring map
> >> propagation e.g.
> >
> > Thanks for your patch.  Yeah, we can use this.
> >
> > But I still think it'd be better doing it unconditionally
> > since any propagation before perf_evlist__set_maps
> > will be discarded anyway.  With this change, other
> > than perf record will collect all cpus before _set_maps
> > and then discard it.  It seems like a waste, no?
> >
> > Or else, we can have allow_map_propagation initialized
> > to false and set it to true in perf_evlist__set_maps().
> >
>
> That sounds fine.

Thanks!

Arnaldo, how do you want to handle it?  I can send v2 for the
whole series, but I think you already applied it.  Then do you
want me to send this change on top?

Namhyung
