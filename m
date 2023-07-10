Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCDF74E079
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGJVye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:54:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372F6D2;
        Mon, 10 Jul 2023 14:54:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a37909a64eso3509939b6e.1;
        Mon, 10 Jul 2023 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689026071; x=1691618071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wAXPxa/RDqFZNFzx61BX77fiuh/LBlF7GHH1ZCbLe6M=;
        b=CGb/8WvyMPZioIJXpd90X2vl1g5tU4PFKL/ScjppDPHr8k9nq28FczvfWuCvDQAsGa
         WsFMa7blA2WwJrg09Doal4PY9iCPSV1m9rSJzq/Ub9R5s9KsYnLWahC5hhz9/mIq4Sh6
         6PkLuA2tteg2PzRMjuVyYcy6eYG3cGhBgtl02/+9zBAUCDT/sW3PU9HCJ8qL0v3w5Gvi
         U3EBTSLRUyEtvSE228jnMU7G3a0zIXvNaHreGedHNTddbhjZUYE/xtCPfLcXHZ/ymgwi
         hII6+Qx6V77+XfqWYgQIcPxFw46k8u7K+AmSq3TPAx4znbkebkCbPT0q3BYUg7d/e/cF
         sANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689026071; x=1691618071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAXPxa/RDqFZNFzx61BX77fiuh/LBlF7GHH1ZCbLe6M=;
        b=Wmlwl+syU+201tLGn2q3/p4IUkpT44vAgC37zhMQYQpg9z73ULfFyhFJO3owcwTTSr
         UJQPMeCpm+jwlnh5qWHmoES26nJT+WGmFj304t9C95iPZhhCZ2H3oMPEGnkw2y1tuJIn
         FJZIMYeFpjN1GunppHRslFDYZy8C5i5gjdTO8D3nGvVsd/RaXUeHwAaxVjfWzNQjIaAC
         viTzIk6ZUO8e3SSuJPC7OOMSlmUv2hkygl5DGBIAJphG6YmQ+hGsn/UE0hyDEsTyExxV
         EGUVHfS+nHrld4KdN6dpjXpA3szpwXvcujuELxya9r5Biw74GKS9eC9LRGt6cgnd7Us/
         JRRA==
X-Gm-Message-State: ABy/qLbdv37CKmOmo/pO7Jt72uakEoSnH5QrZP7fv0AkaH0PU+GK3UXZ
        FRV+0zgMa9njJA4ez60vJtw=
X-Google-Smtp-Source: APBJJlHoikWHi+iuM6pajXo60jF7rpw43Cl2ca1HUf+vyNvzp6BT9eOwZnVnUDwu4ES1UPNsH+nirQ==
X-Received: by 2002:a05:6808:1383:b0:3a1:b9d7:3821 with SMTP id c3-20020a056808138300b003a1b9d73821mr14688686oiw.37.1689026071261;
        Mon, 10 Jul 2023 14:54:31 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:d743:45e6:d02:e038])
        by smtp.gmail.com with ESMTPSA id n20-20020aa78a54000000b0067f2413bf6dsm252228pfa.106.2023.07.10.14.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:54:30 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 11 Jul 2023 03:24:23 +0530
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] scripts: python: create threads with schemas
Message-ID: <ZKx+D0TzKRoCB5Sa@yoga>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
 <d56fd5874314728e79c084e9d6ce805a24d61707.1688585597.git.anupnewsmail@gmail.com>
 <CAM9d7chnbr6LpLdv0AEaxu9kCL=tGB9PgdDgzatAawaKoPDimw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chnbr6LpLdv0AEaxu9kCL=tGB9PgdDgzatAawaKoPDimw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:46:51PM -0700, Namhyung Kim wrote:
> On Wed, Jul 5, 2023 at 12:47 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The markers structure defines the schema and data for
> > thread markers, including fields such as 'name',
> > 'startTime', 'endTime', 'phase', 'category', and 'data'.
> >
> > The samples structure defines the schema and data for thread
> > samples, including fields such as 'stack', 'time', and
> > 'responsiveness'.
> >
> > The frameTable structure defines the schema and data for frame
> > information, including fields such as 'location', 'relevantForJS',
> > 'innerWindowID', 'implementation', 'optimizations', 'line',
> > 'column', 'category', and 'subcategory'.
> >
> > The purpose of this function is to create a new thread structure
> > These structures provide a framework for storing and organizing
> > information related to thread markers, samples, frame details,
> > and stack information.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index 95b061a97cbc..e56864e78dc1 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -24,6 +24,47 @@ start_time = None
> >  def process_event(param_dict):
> >         global start_time
> >         global thread_map
> > +       def _createtread(name, pid, tid):
> > +               markers = {
> > +                       'schema': {
> > +                               'name': 0,
> > +                               'startTime': 1,
> > +                               'endTime': 2,
> > +                               'phase': 3,
> > +                               'category': 4,
> > +                               'data': 5,
> > +                       },
> > +                       'data': [],
> > +               }
> > +               samples = {
> > +                       'schema': {
> > +                               'stack': 0,
> > +                               'time': 1,
> > +                               'responsiveness': 2,
> > +                               },
> > +                       'data': [],
> > +               }
> > +               frameTable = {
> > +                       'schema': {
> > +                               'location': 0,
> > +                               'relevantForJS': 1,
> > +                               'innerWindowID': 2,
> > +                               'implementation': 3,
> > +                               'optimizations': 4,
> > +                               'line': 5,
> > +                               'column': 6,
> > +                               'category': 7,
> > +                               'subcategory': 8,
> > +                       },
> > +                       'data': [],
> > +               }
> > +               stackTable = {
> > +                       'schema': {
> > +                               'prefix': 0,
> > +                               'frame': 1,
> > +                       },
> > +                       'data': [],
> > +               }
> 
> It seems this function doesn't return anything.
> Can we have a complete definition?  Otherwise it's hard to
> know how these tables are used.

I will add the complete definition in the next version.

> Thanks,
> Namhyung
> 
> 
> >
> >         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> >                 thread = thread_map.get(tid)
> > --
> > 2.34.1
> >
