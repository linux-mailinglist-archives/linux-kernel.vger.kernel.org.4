Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118AA5B405C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiIIULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiIIULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C52FA6B0;
        Fri,  9 Sep 2022 13:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF6C6620D0;
        Fri,  9 Sep 2022 20:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B96CC43143;
        Fri,  9 Sep 2022 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662754293;
        bh=ZyQHJST4ZVIaWfwjlZdDoC0RmIGVsAQzzbsyYCsIjzY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NEYXGoAYq21lDKwDdvGnTwFocggaCXRncKksiBW0ElR+445tBAuHbCnFkys96WBgb
         n5g5mgyEX1MAe0RGuhsyhF9yJhyOSQP8tELw3ZFxzUgQg3Je6FQa4sJRQuAAfep6KO
         1yXtvXbjkYRtmIlO8I5XxyZVkkmkFZI0cE9e23klaHchrsmMBDlA+1MqaP8YhgEI/C
         /w0+c87iyajvS9Ktm1ic+uFyj70FLDGlXXax+zFF0TN2mojlx+2QLn+0ANjjyrzb/k
         cHZdlw2OO2xP5VTgG4xii4Py5cVVzD5Xh0yWWLWjCuTlbMSq4PLF6GHB5V8H/TwOKz
         3aaHgwUIO7GDQ==
Received: by mail-ua1-f52.google.com with SMTP id e3so1037240uax.4;
        Fri, 09 Sep 2022 13:11:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo232zhG8yVkUs9UvliDwul/NKwD+8+an/HVyTrP3xYK2lkjtVDQ
        YoCvMvmDmDcuW80SFyOvFIuMAxug9RCSCo5Gtw==
X-Google-Smtp-Source: AA6agR7L8BM4EqH0EFc6zhZyM8oNIMUSoBkdc9sv4+SucH0wffHiTzgWrqGNnHw0j7SWKRWe8l8KG5ubScvJYzwjCs8=
X-Received: by 2002:ab0:4467:0:b0:39f:52ec:46d7 with SMTP id
 m94-20020ab04467000000b0039f52ec46d7mr5492127uam.77.1662754292043; Fri, 09
 Sep 2022 13:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220901184709.2179309-1-robh@kernel.org> <CAM9d7chY6T-EAN3BT487MUK0LbfGp27X+2Dd_+S0azgh2GQn9w@mail.gmail.com>
 <CAL_JsqLmszK=NzD_2nYnZG1dD=tU1fKGUtYL-dUG2a497LkEcg@mail.gmail.com> <CAM9d7ci0Dn3hAX9dp1UMGK7SN-w1BoRqQz6hk8Oykfaa=LnWwg@mail.gmail.com>
In-Reply-To: <CAM9d7ci0Dn3hAX9dp1UMGK7SN-w1BoRqQz6hk8Oykfaa=LnWwg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 9 Sep 2022 15:11:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+CH13TASeAb5VMa=hXGyAT4bDdGeS2XJj9ym6_WM4HRw@mail.gmail.com>
Message-ID: <CAL_Jsq+CH13TASeAb5VMa=hXGyAT4bDdGeS2XJj9ym6_WM4HRw@mail.gmail.com>
Subject: Re: [PATCH] perf: Ignore format attributes with an unknown
 perf_event_attr field
To:     Namhyung Kim <namhyung@kernel.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 1:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Sep 2, 2022 at 8:25 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Sep 2, 2022 at 1:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Thu, Sep 1, 2022 at 11:55 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > > > will return an error stating the specified PMU can't be found. For
> > > > example, a format attr with 'config3:0-63' causes an error if config3 is
> > > > unknown to perf. This causes a compatibility issue between a newer
> > > > kernel and an older perf tool.
> > > >
> > > > The addition here makes any attr string up to the ':' ignored, but
> > > > still checks the 'bits' portion.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > > This is the YACC mud I threw and seems to stick. Maybe there's a better
> > > > way to handle this. It doesn't seem like there's a way to do wildcards
> > > > (i.e. config.*) in YACC.
> > > >
> > > > This is needed for this series[1]. Unfortunately the best we do to avoid
> > > > the issue is applying this to stable. I think there's some time before
> > > > v8.7 h/w is deployed, too.
> > >
> > > Maybe you could change the format_term rule to take an identifier instead
> > > of PP_CONFIG* directly and pass it to perf_pmu__new_format().  Then
> > > it could check the string and create an appropriate PERF_PMU_FORMAT_VALUE_*
> > > or ignore it according to the PERF_ATTR_SIZE_VER*.
> >
> > That only moves parsing of configN from YACC to strcmp in C. In doing
> > so, we'd be left with just the 'error' token case which seems a bit
> > odd (if there's another way to do it, I don't know. yacc is not my
> > thing). Is that really better?
>
> I thought we could do more flexible handling and detailed error reporting
> in the C code.  But it could be done in the lex/yacc as well..
>
> I think the general idea is that we want to run a more recent version of
> perf tools than the kernel.  So if it detects the tool is older, it can show
> a warning message like:
>
> "config3 is not in the perf_event_attr.. skipping.
>  Maybe you're running on a newer kernel. Please upgrade the perf tool."

I figured out how to simplify the yacc code and add a warning.
However, one thing to note is that we'll always get the warning if any
PMU has an unsupported format attr because all the PMUs are scanned.
For example, just this gives a warning even though the SPE PMU is not
used:

perf record -e cycles -- true

So the warning might be misleading. On the flip side, new additions are rare.

Rob
