Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879F25EFD76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiI2Sya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiI2Sy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:54:27 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E71449DB;
        Thu, 29 Sep 2022 11:54:26 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id o64so2502737oib.12;
        Thu, 29 Sep 2022 11:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=u/LkYHvYR+btps55yDhNvqai2AlFnIqwkDLQGyvkZiA=;
        b=AfJZK4b1xSewAt0LhAIiWgbqxzQjkPUHV26A7sEprPbceGLdKN9euewPkxLjINbcmK
         x+JXuD1u+sD0jrQskrTGH0Gn1TJzv7pYyzdjwtDrYD9MhLouitHhw5Bqsftyx1Ra6954
         6jDs2mCvf2h5wAugVipioDsCB6EzGEVujPoO2gCBm0cEYj825NgQgdZlpmVRqmQfiGf9
         nawCi1YjtrPj2pbwhePTlAuoZNGQnKJ6noSyM5Cc729Nf9W80KM4H5GPGtfuSv+9aAym
         How3peOn10d/TwsFGTian3NoPPmPCTIH7EzGORxidOg7gAYbVFOq5YEoYjTXGVjpFU//
         QnUg==
X-Gm-Message-State: ACrzQf0u0JPoS//BA1EITY85oDRnFETlS8Lbp6HtJbEIGb9S1LNJKz3B
        E2aetq8hjeq+SKms0dT6l6hdWch9HeXvv0V7TOI=
X-Google-Smtp-Source: AMsMyM6erVnoONuNBkVi0YaF3+arwnhUw2NtLkwVkJQzfYCn/k3LhVGeCu1QBDwIlsKqQ8y2j9XEOPMrFFR8qp7zWhk=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr2195276oib.209.1664477665895; Thu, 29
 Sep 2022 11:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
 <CAM9d7ciNwe1HaYXjau6hv8yUmnZvvQU0=bNdf=EA589frkjptg@mail.gmail.com> <CAL_JsqJ8nhmx4U8efE2_FuVkacMYxHys4OZXv9PmdTXjZP1x4A@mail.gmail.com>
In-Reply-To: <CAL_JsqJ8nhmx4U8efE2_FuVkacMYxHys4OZXv9PmdTXjZP1x4A@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Sep 2022 11:54:14 -0700
Message-ID: <CAM9d7cjC0bB53mwjp7upcHQOYW_tejSCC0xw3nDjHygbUmuivw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 6:32 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 16, 2022 at 1:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Sep 14, 2022 at 1:09 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > > will return an error stating the specified PMU can't be found. For
> > > example, a format attr with 'config3:0-63' causes an error as config3 is
> > > unknown to perf. This causes a compatibility issue between a newer
> > > kernel with older perf tool.
> > >
> > > Before this change with a kernel adding 'config3' I get:
> > >
> > > $ perf record -e arm_spe// -- true
> > > event syntax error: 'arm_spe//'
> > >                      \___ Cannot find PMU `arm_spe'. Missing kernel support?
> > > Run 'perf list' for a list of valid events
> > >
> > >  Usage: perf record [<options>] [<command>]
> > >     or: perf record [<options>] -- <command> [<options>]
> > >
> > >     -e, --event <event>   event selector. use 'perf list' to list
> > > available events
> > >
> > > After this change, I get:
> > >
> > > $ perf record -e arm_spe// -- true
> > > WARNING: 'arm_spe_0' format 'inv_event_filter' requires 'perf_event_attr::config3' which is not supported by this version of perf!
> > > [ perf record: Woken up 2 times to write data ]
> > > [ perf record: Captured and wrote 0.091 MB perf.data ]
> > >
> > > To support unknown configN formats, rework the YACC implementation to
> > > pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
> > > warning.
> >
> > It only handles configN formats but it might add a completely different
> > name later, right?
>
> Right. An unknown configN is a warning. An unknown name is still an
> error as before. Given that sysfs format attrs are for mapping fields
> which could be anything to "generic" perf_event_attr fields, how would
> we ever have anything other than configN?

I'm not sure I'm following.  It could be anything other than configN.

But I don't object to this particular change as it's needed for current
work.  Later, we can fix the issue if another name comes in.

Thanks,
Namhyung
