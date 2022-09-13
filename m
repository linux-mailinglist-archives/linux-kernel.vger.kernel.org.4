Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB715B6575
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIMCRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIMCRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:17:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1CE52DCB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:17:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c198so10357350pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mNIi18X3rLwN7bNjOQgmycw3pgOrOB3gKZL4IhqTm0Y=;
        b=pkf7liHixkCnKG6153BxNwx5r85qeEvrfDd8Xv+ijxHa4yEP2+nSqEAm+zJ//bD2OL
         yndpzP6KpxqtWMYB1az234Slh8fmKt3zQBakDMewxqyeujWb0FJlyWaQRjtvFoQFun7B
         CZ6dNKTWcOa0eC+kjcUj+u6ZjVbd0TJ7y1DQIOfsdtCaeFdlmjyspsQZ92eRhyKd6xOv
         maOy0LG7ed0vfwMUZ/+pD/5STBRw/Dr7Ew+MIqrimco/pZKKJXAN5lI2V9fObnAI8upu
         dZHJETVz/Z+rTDcuW9zo06M3xNx2DA5fxpHLkqTpuEYSNBmxG4Whb3X7ESqviPmTqjMP
         q1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mNIi18X3rLwN7bNjOQgmycw3pgOrOB3gKZL4IhqTm0Y=;
        b=6JDDwLDHjil22E5iqQbT4jmrzd9ZQMrd2XxWrwa215WVnUSH4SMTpBo/sjaYxt7otR
         aXlaUxAlvkHm7/QkscnP+tgEkJnV/ZU1+vp3Nayucnx+19/8YwkdEwV2ursbq9fMWDP/
         st38SMaYSTHB951+so/Yvih925bfeVG7PiYqH0qwshDVcnWEX8I9XAAbl2la5qddELlb
         NyZRc5TbnRITVIOZ6t++YLH8Hz4ONQczM3bC4Ht5LvVjrYhQw9I17qwc6DTczo7BBB7b
         z0awlO1ybX6qGBp1w97q6XEv3W+rcXWExzNxjlHX4PrkF4Xkxj9bwR0E7L3eKeWa17Qe
         Kchg==
X-Gm-Message-State: ACgBeo1srseHPXYbX7kBmnDf0G+/uZgT8M3mSNrptpjA6SR7vPoH6oL5
        b/jE5W+RBbFGvTsR+ucqmRSn0A==
X-Google-Smtp-Source: AA6agR6RX1U2gyW4RI0OqD6Leu4mPHYm5EFqoUfispvjgEYXh5UtA+Lxmd57WzWFCVFmNmtyreHuFw==
X-Received: by 2002:a63:4816:0:b0:438:aece:3738 with SMTP id v22-20020a634816000000b00438aece3738mr13381201pga.279.1663035433786;
        Mon, 12 Sep 2022 19:17:13 -0700 (PDT)
Received: from leoy-yangtze.lan (173.242.123.178.16clouds.com. [173.242.123.178])
        by smtp.gmail.com with ESMTPSA id u16-20020a62d450000000b0053e66f57334sm6341291pfl.112.2022.09.12.19.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 19:17:13 -0700 (PDT)
Date:   Tue, 13 Sep 2022 10:17:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v2] perf: Skip and warn on unknown format 'configN' attrs
Message-ID: <Yx/oJDvan6ctGYtX@leoy-yangtze.lan>
References: <20220909204509.2169512-1-robh@kernel.org>
 <Yx8LgqUtDh5TwWmV@leoy-huanghe.lan>
 <CAL_JsqJGrUrahj-T+k7T9GAF+T8=y03YUTG2V+v52styFFDW_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJGrUrahj-T+k7T9GAF+T8=y03YUTG2V+v52styFFDW_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 08:55:32AM -0500, Rob Herring wrote:

[...]

> > If this is the case,
> > it's good to add a fixes tag like below?
> >
> > Fixes: cd82a32e9924 ("perf tools: Add perf pmu object to access pmu format definition")
> 
> Probably not too important given this is from 2012.

Which means since 2012 there have no requirement for config3 :)

AFAICT, perf tool should be forward compatible, so I think it's good
for this patch to be landed on (old) LTS kernels.

> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v2:
> > >  - Rework YACC code to handle configN formats in C code
> > >  - Add a warning when an unknown configN attr is found
> > >
> > > v1: https://lore.kernel.org/all/20220901184709.2179309-1-robh@kernel.org/
> > > ---
> > >  tools/perf/util/pmu.c |  6 ++++++
> > >  tools/perf/util/pmu.l |  2 --
> > >  tools/perf/util/pmu.y | 15 ++++-----------
> > >  3 files changed, 10 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index 89655d53117a..6757db7d559c 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -1475,6 +1475,12 @@ int perf_pmu__new_format(struct list_head *list, char *name,
> > >  {
> > >       struct perf_pmu_format *format;
> > >
> > > +     if (config > PERF_PMU_FORMAT_VALUE_CONFIG2) {
> >
> > It's good to add a new macro PERF_PMU_FORMAT_VALUE_CONFIG_END in
> > util/pmu.h. Then at here we can check the condition:
> 
> Sure.
> 
> >
> >        if (config >= PERF_PMU_FORMAT_VALUE_CONFIG_END) {
> >
> > > +             pr_warning("WARNING: format '%s' requires 'config%d' which is not supported by this version of perf!\n",
> > > +                        name, config);
> >
> > ... so at here we can print log like:
> >
> >        pr_warning("WARNING: format '%s' requires 'config%d' which is not "
> >                   "supported by this version of perf (maximum config%d)!\n",
> >                   name, config, PERF_PMU_FORMAT_VALUE_CONFIG_END - 1);
> 
> I was trying to keep it to one line and given configN isn't expanded
> frequently it should be simple enough to figure out what version you
> need.

It's fine for me.

> > The rest of this patch is fine for me.
> >
> > As a side topic, I know you want to support the SPEv1.2 feature with
> > config3, seems to me a complete patch set series should include the
> > changes for supporting config3 as well.  This can give more clear view
> > for how to fix incompatibility issue between old and new kernels, and
> > how to support config3 in the latest kernel, but it's fine for me if
> > you want to split into two patch sets.
> 
> I've sent out the SPE kernel support separately. I was told by Arnaldo
> to split perf tool and kernel side changes.

To be clear, it's right to split kernel and userspace parts into two
patch set, but for userspace change I cannot find you sent patch
to support config3 in perf tool, something in the [1] is missed,
otherwise I don't think you provide complete support for config3 (and
thus we have no chance to use new event format).

Thanks,
Leo

[1] https://termbin.com/vdph
