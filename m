Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F745EFED0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiI2UnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiI2UnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:43:00 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BD613A95B;
        Thu, 29 Sep 2022 13:42:57 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so918771oom.1;
        Thu, 29 Sep 2022 13:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O9Elc+fXrtU70giAIr9cfbUQSWuZTEh4YaT4EgA+lHg=;
        b=PKQuZuCAv7urBpR/+1eD0bw2YfSNdc7ogKeopvqUv7ZCpGwEddH3dTKOobtDPGWbcY
         BFZe+RGS3ZInM24+MN2+GrjrilxhgIYK+y3+Vi9EnR6jvf6FaMqN0YQJpUEE/4WyiSrP
         10zG9yKnKQxuJdz4KVrVYcfFE2DHlb++g49Pr/PVu8IMOt5YlHV4xQy3yBLtaSFpAtIi
         G+8s0fpExq8atYowAQ2h00cNgvOvCQhTD6pMawrnNP9CAWPf6JgtLyipDqkPREnWQ+Ae
         6sg8vOmPIjzY5uQbz0WAhv3CochNoGLGbzkapJEBtGHOV5ldKsIR5AqmBWCTnmgL/pBv
         ZPPQ==
X-Gm-Message-State: ACrzQf3TKflmKYX7KOqv7prmTmE4qtMXTUT6AJFw17BI4HfMIAJ+HqTj
        8qNEpM8MRkBQauEIGwPGhOzPflRPLLr4Yiyn6/k=
X-Google-Smtp-Source: AMsMyM7TM1twdhiU6jtKNC9Xrh01km1IDfJDmSXCcHMplLzhiIiQOt+JsPFC3LbCv7qbaJw4c0mkv3zdbkoxk/7AxxM=
X-Received: by 2002:a05:6830:1351:b0:65b:e0a8:d0e8 with SMTP id
 r17-20020a056830135100b0065be0a8d0e8mr2243633otq.190.1664484176583; Thu, 29
 Sep 2022 13:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220924165737.956428-1-namhyung@kernel.org> <20220924165737.956428-3-namhyung@kernel.org>
 <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com> <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
 <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com> <CAM9d7ciaOMOuJay5MzOYtg5paK_YmQskX1yqg=Oni1EzipPMwA@mail.gmail.com>
 <CAP-5=fX-as0WNCXMyzOwY=ek0gR9yNXbonXHAu1hsd5wOuX-Vg@mail.gmail.com>
 <CAM9d7ciDvCOsFE68NG6jRb02DdDEOmRf_h7XizdDLGBz0RX95Q@mail.gmail.com> <63905e96-55d5-1aa2-5dbe-167b9aecad8c@intel.com>
In-Reply-To: <63905e96-55d5-1aa2-5dbe-167b9aecad8c@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Sep 2022 13:42:45 -0700
Message-ID: <CAM9d7ciXESTPXZobir4KirSnh1NXHwENc4WpZTudgawUZOL71Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
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

On Wed, Sep 28, 2022 at 10:19 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/09/22 08:09, Namhyung Kim wrote:
> > On Wed, Sep 28, 2022 at 7:08 PM Ian Rogers <irogers@google.com> wrote:
> >>
> >> On Wed, Sep 28, 2022 at 4:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>
> >>> On Wed, Sep 28, 2022 at 12:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> On 27/09/22 20:28, Namhyung Kim wrote:
> >>>>> Hi Adrian,
> >>>>>
> >>>>> On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>>
> >>>>>> On 24/09/22 19:57, Namhyung Kim wrote:
> >>>>>>> The current code propagate evsel's cpu map settings to evlist when it's
> >>>>>>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> >>>>>>> be updated in perf_evlist__set_maps() later.  No need to do it before
> >>>>>>> evlist's cpus are set actually.
> >>>>>>>
> >>>>>>> Actually we discarded this intermediate all_cpus maps at the beginning
> >>>>>>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> >>>>>>> an evsel is added after the evlist cpu maps are set.
> >>>>>>
> >>>>>> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
> >>>>>> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
> >>>>>> added to the evlist.  It can also remove an evsel from the evlist.
> >>>>>
> >>>>> Thanks for your review.  I think it's fine to change evsel cpus or to remove
> >>>>> an evsel from evlist before calling evlist__create_maps().  The function
> >>>>> will take care of setting evlist's all_cpus from the evsels in the evlist.
> >>>>> So previous changes in evsel/cpus wouldn't be any special.
> >>>>>
> >>>>> After this point, adding a new evsel needs to update evlist all cpus by
> >>>>> propagating cpu maps.  So I think hybrid cpus should be fine.
> >>>>> Did I miss something?
> >>>>
> >>>> I wondered how it might play out if evlist__fix_hybrid_cpus() reduced the
> >>>> cpus from the target->cpu_list (using perf record -C) , since after this
> >>>> patch all_cpus always starts with the target->cpu_list instead of an empty
> >>>> list.  But then, in the hybrid case, it puts a dummy event that uses the
> >>>> target cpu list anyway, so the result is the same.
> >>>>
> >>>> I don't know if there are any cases where all_cpus would actually need to
> >>>> exclude some of the cpus from target->cpu_list.
> >>>
> >>> I'm not aware of other cases to reduce cpu list.  I think it'd be fine
> >>> if it has a cpu in the evlist->all_cpus even if it's not used.  The evsel
> >>> should have a correct list anyway and we mostly use the evsel cpus
> >>> to do the real work.
> >>>
> >>> Thanks,
> >>> Namhyung
> >>
> >> The affinity changes made it so that we use all_cpus probably more
> >> often than the evsel CPU maps for real work. The reason being we want
> >> to avoid IPIs so we do all the work on 1 CPU and then move to the next
> >> CPU in evlist all_cpus. evsel CPU maps are used to make sure the
> >> indices are kept accurate - for example, if an uncore event is
> >> measured with a CPU event:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.h?h=perf/core#n366
> >> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n404
> >
> > Right, I meant it'd check the evsel cpus eventually even if it iterates
> > on the evlist all_cpus.  The evlist_cpu_iterator__next() will skip a
> > CPU if it's not in the evsel cpus.
> >
> > Thanks,
> > Namhyung
>
> Perhaps an alternative is to be explicit about deferring map
> propagation e.g.

Thanks for your patch.  Yeah, we can use this.

But I still think it'd be better doing it unconditionally
since any propagation before perf_evlist__set_maps
will be discarded anyway.  With this change, other
than perf record will collect all cpus before _set_maps
and then discard it.  It seems like a waste, no?

Or else, we can have allow_map_propagation initialized
to false and set it to true in perf_evlist__set_maps().

Thanks,
Namhyung


>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 19eaea99aa4f..5ce19e62397d 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -70,6 +70,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>         /* Recomputing all_cpus, so start with a blank slate. */
>         perf_cpu_map__put(evlist->all_cpus);
>         evlist->all_cpus = NULL;
> +       evlist->defer_map_propagation = false;
>
>         perf_evlist__for_each_evsel(evlist, evsel)
>                 __perf_evlist__propagate_maps(evlist, evsel);
> @@ -81,7 +82,8 @@ void perf_evlist__add(struct perf_evlist *evlist,
>         evsel->idx = evlist->nr_entries;
>         list_add_tail(&evsel->node, &evlist->entries);
>         evlist->nr_entries += 1;
> -       __perf_evlist__propagate_maps(evlist, evsel);
> +       if (!evlist->defer_map_propagation)
> +               __perf_evlist__propagate_maps(evlist, evsel);
>  }
>
>  void perf_evlist__remove(struct perf_evlist *evlist,
> @@ -177,9 +179,6 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
>                 evlist->threads = perf_thread_map__get(threads);
>         }
>
> -       if (!evlist->all_cpus && cpus)
> -               evlist->all_cpus = perf_cpu_map__get(cpus);
> -
>         perf_evlist__propagate_maps(evlist);
>  }
>
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 6f89aec3e608..dbe0b763f597 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -19,6 +19,7 @@ struct perf_evlist {
>         int                      nr_entries;
>         int                      nr_groups;
>         bool                     has_user_cpus;
> +       bool                     defer_map_propagation;
>         /**
>          * The cpus passed from the command line or all online CPUs by
>          * default.
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 52d254b1530c..1c2523d66a14 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3975,6 +3975,7 @@ int cmd_record(int argc, const char **argv)
>         rec->evlist = evlist__new();
>         if (rec->evlist == NULL)
>                 return -ENOMEM;
> +       rec->evlist->core.defer_map_propagation = true;
>
>         err = perf_config(perf_record_config, rec);
>         if (err)
>
