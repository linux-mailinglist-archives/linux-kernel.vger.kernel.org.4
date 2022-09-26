Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77A5EA96E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiIZPCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiIZPCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:02:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957F1F9F6;
        Mon, 26 Sep 2022 06:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6584B80957;
        Mon, 26 Sep 2022 13:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768C1C43141;
        Mon, 26 Sep 2022 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664199153;
        bh=Jz6DP2qDtaOk9/0nqGYgsv7iJeTNNd7VbI6rvUbEtZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lmOkzmHbKb9NEFThf0uOdlwhhBO09Qyl+I8FarP8XjneRjoyj/Eeu22JUbATYCiGX
         6mk+lGWvrhOzpC1F6neTHGMKa45AP9sYAE6ZNZ2B0NVAAOoEHAXTaUUF9/njqjRY5q
         9DyXye5A4UmKCa7j7QTCspFCIPDJPESuj2iRkgEPYi2/rENGRMtU6OvZG43pW57f38
         Fvc7m97QaTggBEfCcYwyhe/Jil9oCbEbD2pOqEAZqFKEo85PIpDwjI1nWggWYyOhfI
         pSWVeO/UKKzhaMbloT6Dynino0Hz7rZvoJ7OlaJ2bV6x3zydopg2Fsvd+5rlFYf8n4
         gbNr4/zpW6H/Q==
Received: by mail-vs1-f41.google.com with SMTP id m66so6490782vsm.12;
        Mon, 26 Sep 2022 06:32:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf3dmaT8ECuUUojM9/g6WVdpXGdVPsr1+56DmKg9VOEAt94KW4g+
        tNK0zf+oWsWG1KijtzpKfNZqKR1nY4yAfQcikQ==
X-Google-Smtp-Source: AMsMyM4Zvo0h8Ur9ZYTvHGfcu0ge0lmxpjVtcKbAKW2ZKc4lKvrKvKTJjbemijDS8KVBrI9e5ZAp8VxbYvO5fKDQFY8=
X-Received: by 2002:a67:3c7:0:b0:39b:45c2:6875 with SMTP id
 190-20020a6703c7000000b0039b45c26875mr7717610vsd.6.1664199152365; Mon, 26 Sep
 2022 06:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org> <CAM9d7ciNwe1HaYXjau6hv8yUmnZvvQU0=bNdf=EA589frkjptg@mail.gmail.com>
In-Reply-To: <CAM9d7ciNwe1HaYXjau6hv8yUmnZvvQU0=bNdf=EA589frkjptg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Sep 2022 08:32:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ8nhmx4U8efE2_FuVkacMYxHys4OZXv9PmdTXjZP1x4A@mail.gmail.com>
Message-ID: <CAL_JsqJ8nhmx4U8efE2_FuVkacMYxHys4OZXv9PmdTXjZP1x4A@mail.gmail.com>
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

On Fri, Sep 16, 2022 at 1:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Sep 14, 2022 at 1:09 PM Rob Herring <robh@kernel.org> wrote:
> >
> > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > will return an error stating the specified PMU can't be found. For
> > example, a format attr with 'config3:0-63' causes an error as config3 is
> > unknown to perf. This causes a compatibility issue between a newer
> > kernel with older perf tool.
> >
> > Before this change with a kernel adding 'config3' I get:
> >
> > $ perf record -e arm_spe// -- true
> > event syntax error: 'arm_spe//'
> >                      \___ Cannot find PMU `arm_spe'. Missing kernel support?
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf record [<options>] [<command>]
> >     or: perf record [<options>] -- <command> [<options>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list
> > available events
> >
> > After this change, I get:
> >
> > $ perf record -e arm_spe// -- true
> > WARNING: 'arm_spe_0' format 'inv_event_filter' requires 'perf_event_attr::config3' which is not supported by this version of perf!
> > [ perf record: Woken up 2 times to write data ]
> > [ perf record: Captured and wrote 0.091 MB perf.data ]
> >
> > To support unknown configN formats, rework the YACC implementation to
> > pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
> > warning.
>
> It only handles configN formats but it might add a completely different
> name later, right?

Right. An unknown configN is a warning. An unknown name is still an
error as before. Given that sysfs format attrs are for mapping fields
which could be anything to "generic" perf_event_attr fields, how would
we ever have anything other than configN?

Rob
