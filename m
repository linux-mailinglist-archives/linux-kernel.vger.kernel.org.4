Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE15B40B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiIIUbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiIIUaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:30:19 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC33CBC1;
        Fri,  9 Sep 2022 13:30:14 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id b16so4231735edd.4;
        Fri, 09 Sep 2022 13:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kpEcg4wYbPXSLUksqLgqfaDecUEI9K/L7cnxAiNm308=;
        b=0KvHL1XTK8Ip/MxFjGAxHWC5hwgC29eTgOwGiAP8ZoieD04DAeYCJ73Y7fJqZV8VIE
         pPSPP1Sze1JQx3uElCXNbJKipGq1eaP4J00z8GeM2bh8PlVRKFJ5CR+XJyKvtv1w2vfo
         yL/eaCqbwpVwbLPDEuvmIHyR9uqzyG4iE3x2d1k2r+p07xQqBF8P1f92izbbq3oUJe8q
         hERJcaRfeNKlrBo3A/ZM4vK9gfK0P4vwTHSNWyETk52MLZqNrx5UgWhs2way4TM+B8Km
         CCmNlf3kX6Itt6e1/IsSxqqTYIkTQBmMO4YN846nxUey6DyDLC4PqfJgelc/SHjkKWke
         9zqQ==
X-Gm-Message-State: ACgBeo3Y5PMaJ9jsedplmrukGj0wzV0WlyCVOTvZMdkeT0obcVWHAR1k
        E+t1/t/RQiliDS3+DJfM64CGnKgKF2RIFHm7GE14Nzu7
X-Google-Smtp-Source: AA6agR5k1e7Sf8b0Ne7PPtH0lpIFZpZ2n0V3pRe0lMeNNgLcoX3mjLwQkMGyX1uOFkhEXiiwavJRe6aSzpqWaIE+El4=
X-Received: by 2002:a05:6402:f07:b0:450:bf95:59e9 with SMTP id
 i7-20020a0564020f0700b00450bf9559e9mr7941898eda.46.1662755413210; Fri, 09 Sep
 2022 13:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220901184709.2179309-1-robh@kernel.org> <CAM9d7chY6T-EAN3BT487MUK0LbfGp27X+2Dd_+S0azgh2GQn9w@mail.gmail.com>
 <CAL_JsqLmszK=NzD_2nYnZG1dD=tU1fKGUtYL-dUG2a497LkEcg@mail.gmail.com>
 <CAM9d7ci0Dn3hAX9dp1UMGK7SN-w1BoRqQz6hk8Oykfaa=LnWwg@mail.gmail.com> <CAL_Jsq+CH13TASeAb5VMa=hXGyAT4bDdGeS2XJj9ym6_WM4HRw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+CH13TASeAb5VMa=hXGyAT4bDdGeS2XJj9ym6_WM4HRw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 9 Sep 2022 13:30:01 -0700
Message-ID: <CAM9d7ciFbgK8PfNmNFo37GPkXNhp=2es5StDEG+m+deLTP8Hpw@mail.gmail.com>
Subject: Re: [PATCH] perf: Ignore format attributes with an unknown
 perf_event_attr field
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 1:11 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 6, 2022 at 1:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Sep 2, 2022 at 8:25 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Sep 2, 2022 at 1:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Thu, Sep 1, 2022 at 11:55 AM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > > > > will return an error stating the specified PMU can't be found. For
> > > > > example, a format attr with 'config3:0-63' causes an error if config3 is
> > > > > unknown to perf. This causes a compatibility issue between a newer
> > > > > kernel and an older perf tool.
> > > > >
> > > > > The addition here makes any attr string up to the ':' ignored, but
> > > > > still checks the 'bits' portion.
> > > > >
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > > This is the YACC mud I threw and seems to stick. Maybe there's a better
> > > > > way to handle this. It doesn't seem like there's a way to do wildcards
> > > > > (i.e. config.*) in YACC.
> > > > >
> > > > > This is needed for this series[1]. Unfortunately the best we do to avoid
> > > > > the issue is applying this to stable. I think there's some time before
> > > > > v8.7 h/w is deployed, too.
> > > >
> > > > Maybe you could change the format_term rule to take an identifier instead
> > > > of PP_CONFIG* directly and pass it to perf_pmu__new_format().  Then
> > > > it could check the string and create an appropriate PERF_PMU_FORMAT_VALUE_*
> > > > or ignore it according to the PERF_ATTR_SIZE_VER*.
> > >
> > > That only moves parsing of configN from YACC to strcmp in C. In doing
> > > so, we'd be left with just the 'error' token case which seems a bit
> > > odd (if there's another way to do it, I don't know. yacc is not my
> > > thing). Is that really better?
> >
> > I thought we could do more flexible handling and detailed error reporting
> > in the C code.  But it could be done in the lex/yacc as well..
> >
> > I think the general idea is that we want to run a more recent version of
> > perf tools than the kernel.  So if it detects the tool is older, it can show
> > a warning message like:
> >
> > "config3 is not in the perf_event_attr.. skipping.
> >  Maybe you're running on a newer kernel. Please upgrade the perf tool."
>
> I figured out how to simplify the yacc code and add a warning.
> However, one thing to note is that we'll always get the warning if any
> PMU has an unsupported format attr because all the PMUs are scanned.

Right, I think we need to change this behavior.


> For example, just this gives a warning even though the SPE PMU is not
> used:
>
> perf record -e cycles -- true
>
> So the warning might be misleading. On the flip side, new additions are rare.

Yeah, we should not warn at parsing, do when it's actually used.

Thanks,
Namhyung
