Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B45F0367
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiI3Dmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiI3Dma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:42:30 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54C31C7728;
        Thu, 29 Sep 2022 20:42:29 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1280590722dso4117986fac.1;
        Thu, 29 Sep 2022 20:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CmdwtcBzPlTMPdSBht12UDlPPX1lSgFvXWnPqCp6gNw=;
        b=3vSrB6+D2vaF0TaUjy3CdZVVF3lA7iL7f4wXIU1nWgwabMcoOXW2b+w10MmcVsN0wH
         Gm/A8eJ7zXNbsVdK7ApBvQX0iaeQg7a0yRiCZ2JHseUU6JJkZNLBnjJg+rbWYCgHdVKA
         UdVvEY0MLgvlCPV+y6J54w6D2p1h3SCbU+AJICaICdrVwxFKJsCilS8YCVXK46qsZKtf
         KSYSpO3f2hXQqXQjlSu27CFdZZLHhbHJmKkE+xReFOnCBSYbV2n5ftNccYQZdbahQe2r
         LfECZKegnX4TDHA1xB9JRgd5pDBmDyZDTAG6JuWGAa5P6jTHjOP/PsHp0YlU9PXKjkUO
         9alA==
X-Gm-Message-State: ACrzQf0YeIuuKg3oZO7Mg4KYSuEAOpRKET6CQd+mHuYPtjd4ZtPe/0yw
        Hk2b3/aVe4H0vievXpZqD6yQBz4/Qr01Hb2/xNA=
X-Google-Smtp-Source: AMsMyM54FCbn4vRbkhREI7Gb1vZrk7w8b+tIty0dQahH+B4mYO5OlhOgAWUsWxiBirWXzdXUvj+hBOXl33oawExzsvk=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr3808183oam.218.1664509349235; Thu, 29
 Sep 2022 20:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
 <CAM9d7ciNwe1HaYXjau6hv8yUmnZvvQU0=bNdf=EA589frkjptg@mail.gmail.com>
 <CAL_JsqJ8nhmx4U8efE2_FuVkacMYxHys4OZXv9PmdTXjZP1x4A@mail.gmail.com>
 <CAM9d7cjC0bB53mwjp7upcHQOYW_tejSCC0xw3nDjHygbUmuivw@mail.gmail.com> <CAL_JsqKqJRiLuhss8nwRfKchf3sopfTF49Xh1xq=s6JXAqFHmg@mail.gmail.com>
In-Reply-To: <CAL_JsqKqJRiLuhss8nwRfKchf3sopfTF49Xh1xq=s6JXAqFHmg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Sep 2022 20:42:20 -0700
Message-ID: <CAM9d7chddd0HjWck086LSV6VsBBDHtvOsh03_JK-yij8cormVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf: Skip and warn on unknown format 'configN' attrs
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Sep 29, 2022 at 1:55 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 29, 2022 at 1:54 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Sep 26, 2022 at 6:32 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Sep 16, 2022 at 1:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 14, 2022 at 1:09 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > > > > will return an error stating the specified PMU can't be found. For
> > > > > example, a format attr with 'config3:0-63' causes an error as config3 is
> > > > > unknown to perf. This causes a compatibility issue between a newer
> > > > > kernel with older perf tool.
> > > > >
> > > > > Before this change with a kernel adding 'config3' I get:
> > > > >
> > > > > $ perf record -e arm_spe// -- true
> > > > > event syntax error: 'arm_spe//'
> > > > >                      \___ Cannot find PMU `arm_spe'. Missing kernel support?
> > > > > Run 'perf list' for a list of valid events
> > > > >
> > > > >  Usage: perf record [<options>] [<command>]
> > > > >     or: perf record [<options>] -- <command> [<options>]
> > > > >
> > > > >     -e, --event <event>   event selector. use 'perf list' to list
> > > > > available events
> > > > >
> > > > > After this change, I get:
> > > > >
> > > > > $ perf record -e arm_spe// -- true
> > > > > WARNING: 'arm_spe_0' format 'inv_event_filter' requires 'perf_event_attr::config3' which is not supported by this version of perf!
> > > > > [ perf record: Woken up 2 times to write data ]
> > > > > [ perf record: Captured and wrote 0.091 MB perf.data ]
> > > > >
> > > > > To support unknown configN formats, rework the YACC implementation to
> > > > > pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
> > > > > warning.
> > > >
> > > > It only handles configN formats but it might add a completely different
> > > > name later, right?
> > >
> > > Right. An unknown configN is a warning. An unknown name is still an
> > > error as before. Given that sysfs format attrs are for mapping fields
> > > which could be anything to "generic" perf_event_attr fields, how would
> > > we ever have anything other than configN?
> >
> > I'm not sure I'm following.  It could be anything other than configN.
>
> It's possible, yes, but likely or necessary? Probably not.
>
> Let me try again. perf_event_attr:configX fields are pmu specific and
> sysfs format files provide the mapping of their specific usage to
> configX bits. If we add something to perf_event_attr that's not PMU
> specific, but common for perf, then it's going to have a specific name
> and no format entry. Right? If we add yet another PMU specific field,
> why would we ever have a name other than 'config'? Anything different
> has little benefit since format files provide the specific meaning and
> it's up to the PMU driver to handle them.
>
> Maybe someone comes up with something, but that seems a lot less
> likely than another configN.

Fair enough.

>
> > But I don't object to this particular change as it's needed for current
> > work.  Later, we can fix the issue if another name comes in.
>
> Is that an Acked/Reviewed-by?

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
