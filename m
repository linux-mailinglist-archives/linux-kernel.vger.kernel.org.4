Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6243774E186
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjGJWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjGJWnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:43:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D40C4;
        Mon, 10 Jul 2023 15:43:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55779047021so3436975a12.3;
        Mon, 10 Jul 2023 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689028986; x=1691620986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cwD7qyMS4zLIWzJbsRd2HepNWRl3udEBk9Vr53sr8E4=;
        b=PaPL/06k+4GrOMHHCaCbdjwIKVleSAXLgWa7SkvcO9Lp+gZ3y/yz8tpPY2G4m0bzEM
         6Rbqn+T4WRjPkDOXH1IBTsCVGbm7dpiuhBq3PMMHq1+7HneP025c3O31c00y1mts1LUN
         6EwRA1DSzW1PoQl5p+BI08ofsyFBe1H+Na7PAsQxR3Da3XRDCB+H6GkRScm4FkYOIKxa
         PRFHoj78MV874qCTQX78MVA4Ek4VhU+rSB+vfkNOWPFTwmCnbWVLoED1EC6kePghV+Il
         arPUpu7L/INgipTXKWfw2/cbWsO8SMHckzrlY0cqhn8q4GGO7LvfMe2b4L9N/FuDv2rM
         0cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028986; x=1691620986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwD7qyMS4zLIWzJbsRd2HepNWRl3udEBk9Vr53sr8E4=;
        b=Q2prKppUVkKdso4zswpBV//oObiZPMtSia7g5P920PpA7wPFBBGeX4MHeUSUqAV/Zr
         LqU3VFM+gQjApOUnZ+K6G/CQd/RM7ZFI0qnuHk3BQMmrgqY72wfQj7DiH3dst3dGSy34
         xiUzCgEXFP8zOFhi3y0/eisQwdCyC41nbT21GFezYevcD60rnkvyyDF5QRIL6zFRTEEs
         NqYnpebXIHREQd+k3n9mq/Hc0aVWhmDmdtL5tigf7vRxwoh8scC7w/Y1C2OvjmgpyHiV
         B5eW7sGHY9khlnUxDka7KZlNglFff9v9MwvGlv80SCKUNfTH/x0SpFtzJVJgKZr2gMNM
         4P7w==
X-Gm-Message-State: ABy/qLZeqBHF+hGAXOojEEU44aXnJJt8foDnN54uZwXGcB6NaV8eo+oZ
        zZ0WlqGnfjqy2JSLk0UsmE73mxC196AsO7Oe
X-Google-Smtp-Source: APBJJlGwUgrHc2wuhWPLThj3IjY4kLhfCa8NTx6eo17us8NcHFBWq42lQ9RHbopdm6W6ntWK5jewnw==
X-Received: by 2002:a17:902:7b88:b0:1b7:e478:6bcd with SMTP id w8-20020a1709027b8800b001b7e4786bcdmr9531711pll.33.1689028986144;
        Mon, 10 Jul 2023 15:43:06 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:868d:bc7d:562b:a5bb])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090301c200b001a6d4ea7301sm377563plh.251.2023.07.10.15.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 15:43:05 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 11 Jul 2023 04:12:57 +0530
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
Subject: Re: [PATCH v2 5/7] scripts: python: implement get or create frame
 function
Message-ID: <ZKyJcbX89y5ziqNi@yoga>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
 <a5749b6a98928b2a8fa6c1dd1c54201334edb04b.1688585597.git.anupnewsmail@gmail.com>
 <CAM9d7ciZcO_kVwRhOoz0xt-hdguoTHUd8RPSpSOwiCFOTbYNKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciZcO_kVwRhOoz0xt-hdguoTHUd8RPSpSOwiCFOTbYNKw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 11:06:58PM -0700, Namhyung Kim wrote:
> On Wed, Jul 5, 2023 at 12:48 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The get_or_create_frame function is responsible for retrieving or
> > creating a frame based on the provided frameString. If the frame
> > corresponding to the frameString is found in the frameMap, it is
> > returned. Otherwise, a new frame is created by appending relevant
> > information to the frameTable's 'data' array and adding the
> > frameString to the stringTable.
> >
> > The index of the newly created frame is added to the frameMap.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index 6f69c083d3ff..d5b9fb16e520 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -77,6 +77,39 @@ def process_event(param_dict):
> >                                 stackMap[key] = stack
> >                         return stack
> >
> > +               frameMap = dict()
> > +               def get_or_create_frame(frameString):
> > +                       frame = frameMap.get(frameString)
> > +                       if frame is None:
> > +                               frame = len(frameTable['data'])
> > +                               location = len(stringTable)
> > +                               stringTable.append(frameString)
> 
> Looks like it just always appending a new string.
> Any deduplication work later?

Although this initially came to my mind and almost all stack frames
seem to be similar for a repeated call, but I am not sure if we can dedup
because some frames do differ as the call stack progresses. For example,
a process exits a function and then calls another function, resulting in
most of the stack frames being the same but the last one being different.

> > +                               category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 \
> > +                                               or frameString.find('/vmlinux') != -1 \
> > +                                               or frameString.endswith('.ko)') \
> > +                                               else USER_CATEGORY_INDEX
> 
> I think you can use param_dict['sample']['cpumode'].
> Please see include/uapi/linux/perf_event.h for cpumode
> values.

I am actively working on incorporating the use of param_dict
['sample']['cpumode'] to determine the category in the
upcoming v4 update. I saw in param_dict['sample']['cpumode']
values exist as 1 and 2. Can you point me to exact line in
include/uapi/linux/perf_event.h . I am not able to find it.

> > +                               implementation = None
> > +                               optimizations = None
> > +                               line = None
> > +                               relevantForJS = False
> > +                               subcategory = None
> > +                               innerWindowID = 0
> > +                               column = None
> > +
> > +                               frameTable['data'].append([
> > +                                       location,
> > +                                       relevantForJS,
> > +                                       innerWindowID,
> > +                                       implementation,
> > +                                       optimizations,
> > +                                       line,
> > +                                       column,
> > +                                       category,
> > +                                       subcategory,
> > +                               ])
> > +                               frameMap[frameString] = frame
> 
> I think it'd be better if you define the frameTable in this
> commit.

Certainly, my apologies for the disorder.

> Thanks,
> Namhyung
> 
> 
> > +                       return frame
> > +
> >         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> >                 thread = thread_map.get(tid)
> >                 if not thread:
> > --
> > 2.34.1
> >
