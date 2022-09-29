Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5E5EFEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiI2UzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiI2UzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:55:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF07331D;
        Thu, 29 Sep 2022 13:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36BB7B824C2;
        Thu, 29 Sep 2022 20:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0407C43140;
        Thu, 29 Sep 2022 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664484908;
        bh=AFe0hdqgLts246RkPFDdqRIlABvfeWn4Ci75CxT266k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OfMJsSKACxROwXt/SQlCZImZVMzC3HqF1Y+F38wc2IAb0KyiU21QbCq1e09KBNVk7
         5iPkoUhK/B7I6nGTwHL1RlaxNCOi/PpwiUWiKFGTIvk1p+XBwZRFdM1WyPzGuO/lng
         UnnrJk7F+EDgU4xQmn2M0EouH8hAIYGTGw9kf9MhqF70mvsOdSpilH7CXPC3lQ0YbZ
         MAeHpGVdQFjEj/86C49/Dw52REXZVIRPufamfGMZ5ZuZJYHtOx2rjrRXaE7kv+qmvR
         V8tviFXxus3H9F10Zz5Re3NTakfanpPt5OCraLNxlSuEcxlLYIubaHFJmHSBcOJzYA
         nn9F5x7LHhQJw==
Received: by mail-vs1-f45.google.com with SMTP id j7so2851620vsr.13;
        Thu, 29 Sep 2022 13:55:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf0aUfnQK6cxgFslLHvS0v8MDiVqOY8ozxuS2qavYHYHqs7DzUTE
        KclkhE5KuRrM9UpP3QGGmhvfElZenE4+q9uT5Q==
X-Google-Smtp-Source: AMsMyM4aHUlkg1wFlpekd/GWHMxpkdkeKqf0n7vN0Lwoc+vFuU3AX7A7pM86KUlHvIM7n2l20tjz7NjSyb93yekEqFI=
X-Received: by 2002:a67:c088:0:b0:39b:1bb3:bdd1 with SMTP id
 x8-20020a67c088000000b0039b1bb3bdd1mr2522903vsi.85.1664484907534; Thu, 29 Sep
 2022 13:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
 <CAM9d7ciNwe1HaYXjau6hv8yUmnZvvQU0=bNdf=EA589frkjptg@mail.gmail.com>
 <CAL_JsqJ8nhmx4U8efE2_FuVkacMYxHys4OZXv9PmdTXjZP1x4A@mail.gmail.com> <CAM9d7cjC0bB53mwjp7upcHQOYW_tejSCC0xw3nDjHygbUmuivw@mail.gmail.com>
In-Reply-To: <CAM9d7cjC0bB53mwjp7upcHQOYW_tejSCC0xw3nDjHygbUmuivw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Sep 2022 15:54:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKqJRiLuhss8nwRfKchf3sopfTF49Xh1xq=s6JXAqFHmg@mail.gmail.com>
Message-ID: <CAL_JsqKqJRiLuhss8nwRfKchf3sopfTF49Xh1xq=s6JXAqFHmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf: Skip and warn on unknown format 'configN' attrs
To:     Namhyung Kim <namhyung@kernel.org>
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
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 1:54 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Sep 26, 2022 at 6:32 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Sep 16, 2022 at 1:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Wed, Sep 14, 2022 at 1:09 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > > > will return an error stating the specified PMU can't be found. For
> > > > example, a format attr with 'config3:0-63' causes an error as config3 is
> > > > unknown to perf. This causes a compatibility issue between a newer
> > > > kernel with older perf tool.
> > > >
> > > > Before this change with a kernel adding 'config3' I get:
> > > >
> > > > $ perf record -e arm_spe// -- true
> > > > event syntax error: 'arm_spe//'
> > > >                      \___ Cannot find PMU `arm_spe'. Missing kernel support?
> > > > Run 'perf list' for a list of valid events
> > > >
> > > >  Usage: perf record [<options>] [<command>]
> > > >     or: perf record [<options>] -- <command> [<options>]
> > > >
> > > >     -e, --event <event>   event selector. use 'perf list' to list
> > > > available events
> > > >
> > > > After this change, I get:
> > > >
> > > > $ perf record -e arm_spe// -- true
> > > > WARNING: 'arm_spe_0' format 'inv_event_filter' requires 'perf_event_attr::config3' which is not supported by this version of perf!
> > > > [ perf record: Woken up 2 times to write data ]
> > > > [ perf record: Captured and wrote 0.091 MB perf.data ]
> > > >
> > > > To support unknown configN formats, rework the YACC implementation to
> > > > pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
> > > > warning.
> > >
> > > It only handles configN formats but it might add a completely different
> > > name later, right?
> >
> > Right. An unknown configN is a warning. An unknown name is still an
> > error as before. Given that sysfs format attrs are for mapping fields
> > which could be anything to "generic" perf_event_attr fields, how would
> > we ever have anything other than configN?
>
> I'm not sure I'm following.  It could be anything other than configN.

It's possible, yes, but likely or necessary? Probably not.

Let me try again. perf_event_attr:configX fields are pmu specific and
sysfs format files provide the mapping of their specific usage to
configX bits. If we add something to perf_event_attr that's not PMU
specific, but common for perf, then it's going to have a specific name
and no format entry. Right? If we add yet another PMU specific field,
why would we ever have a name other than 'config'? Anything different
has little benefit since format files provide the specific meaning and
it's up to the PMU driver to handle them.

Maybe someone comes up with something, but that seems a lot less
likely than another configN.

> But I don't object to this particular change as it's needed for current
> work.  Later, we can fix the issue if another name comes in.

Is that an Acked/Reviewed-by?

Rob
