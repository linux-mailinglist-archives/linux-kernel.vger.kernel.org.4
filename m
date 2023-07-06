Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA874950E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjGFFnN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 01:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjGFFnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:43:08 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD34219BE;
        Wed,  5 Jul 2023 22:43:02 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso3149725e9.0;
        Wed, 05 Jul 2023 22:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622181; x=1691214181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnzeexXSmK7AT70dN/+hjgj/XoX6InpLd6Mxvfu8a2w=;
        b=XgEXfHw8KomdzGK6tzhv1nmrQmYTI7QIxNQxxqR6ySswc2LvFnBshMK+NA+o7uduIc
         g3wl4y5GGThFrBcnhKVoy4ngd1gIhX/U9ufJiEXPSlWXoGHtOVmcNYI7P8BS790DNRLK
         RZ4o2FazL1T/26U8PjFUQWsIouQpETzQqhIBIQFVPUK5ZgFIfa/edASqmwvwd/1aKXcE
         5DzJvVBL6nLgxERF47i0dTXXK86Xtslo+aX97ZaQWgG2VGkjtsQwxO6BFogUgpqmDi07
         d3nQyfj9FIcgP6aM3YyDluRGaoRTuHwUgduzEqjjZTFi+owP0jj+/X83b8rvwabMX0Bi
         XCrw==
X-Gm-Message-State: ABy/qLa6WcaWsPCfzhbQfBsuyMZRdIg5fII1NAbBhzcZp4xw3AhniAQv
        E/CoyS4Js+C+jhafKV4xGToXpJV0tFveRT10akA=
X-Google-Smtp-Source: APBJJlFIiYNUALwXj8APb2NFXotK0qI6XtqvuqKwAMy7fTc6NBr5x+9QIXhkCcv5YpE2iEc6voeuTKUbrogOE8XB2xI=
X-Received: by 2002:a05:600c:2143:b0:3fb:e58c:7758 with SMTP id
 v3-20020a05600c214300b003fbe58c7758mr534935wml.3.1688622180827; Wed, 05 Jul
 2023 22:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688585597.git.anupnewsmail@gmail.com> <df4773a4ebb43a6c855bad5a2bbc338bc2669ca7.1688585597.git.anupnewsmail@gmail.com>
In-Reply-To: <df4773a4ebb43a6c855bad5a2bbc338bc2669ca7.1688585597.git.anupnewsmail@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 22:42:47 -0700
Message-ID: <CAM9d7chNwcCD6J-twSTTxm6uLoNbMT8ZYKHcDiZxXjcfEVfDfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] scripts: python: Introduce thread sample
 processing to create thread
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 12:44 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>
> The _addThreadSample function is responsible for adding a sample to a specific
> thread. It first checks if the thread exists in the thread_map dictionary.
> If not, it creates a new thread using the _createtread function and assigns
> it to the thread_map. Finally, it calls the 'addSample' method of the thread,
> passing the thread name, stack, and timestamp.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../perf/scripts/python/firefox-gecko-converter.py  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> index ce663840d212..95b061a97cbc 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -18,7 +18,20 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
>  from perf_trace_context import *
>  from Core import *
>
> +thread_map = {}
> +start_time = None
> +
>  def process_event(param_dict):
> +       global start_time
> +       global thread_map
> +
> +       def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> +               thread = thread_map.get(tid)
> +               if not thread:
> +                       thread = _createtread(threadName, pid, tid)

Shouldn't it be '_createThread'?

> +                       thread_map[tid] = thread
> +               thread['addSample'](threadName, stack, time_stamp)

Why is it like this?  What do you intend with the thread['addSample']
method?  Can it be simpler like a direct function call?

And more importantly, you'd better make each patch work properly.
AFAICS it won't do the job because both _createtread() and
thread['addSample'] are not implemented yet.

You can either move those definitions to this commit or have the
commit implementing them before this one.

Thanks,
Namhyung


> +
>         time_stamp = (param_dict['sample']['time'] // 1000) / 1000
>         pid = param_dict['sample']['pid']
>         tid = param_dict['sample']['tid']
> --
> 2.34.1
>
