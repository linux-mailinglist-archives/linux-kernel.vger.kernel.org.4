Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4F74F73F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGKRab convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGKRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:30:29 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3745A1;
        Tue, 11 Jul 2023 10:30:28 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-47e793ccdc7so1898391e0c.1;
        Tue, 11 Jul 2023 10:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096628; x=1691688628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwVGOGhzlbrDjjqXvCrudYlu5CQ3HrJeIcRNYeurvBA=;
        b=jVN0i7sdojVfBpaC77C2ko7XARkadAI2BCQ9JWHid2qyixU48RojXaq/wwKTyS/1lL
         ljaJZ35Wtrp3fuWKISW8+MyGL5ubMZQmX0Y7By6w3/v6uT0QpJjZC4bl7GK7y916+H0B
         vL1jUPYPXu4neUZe1yiqxWqtvgQU05vO9BbeHFyInA5S19nk0XwW7pS9STqBud10cAq4
         bgjN+Yg508QTM9iGRqtAYKceO2mKwyVayNYwvVbU8oT7PdUNLPtJ6O//rxCIEvLE1oVV
         6aPo2kXC3zU+bdvGBBhFKe7+hz89JoE9rEfA3A8+tb8cz2vYjYZrPxam5iCPsSSJSc70
         MDNw==
X-Gm-Message-State: ABy/qLYlYOiBPe4dPVtWMeNpKOblRyYHOSGxiV/aNCDtx4cIcjFEQa3g
        WN/YyjhPO3OeymRPzDApDaaAHvPemcZRRP6KjalIQ7Yk
X-Google-Smtp-Source: APBJJlHPDIiWNNx7gZC4xz1m3OvYDtp2Gk5/Hxi2GnB6KjNqUTH93hQtcSVpZuvx05JkEUxapJ84ljJrDB5ZTLwrioM=
X-Received: by 2002:a1f:4544:0:b0:47e:a218:86b2 with SMTP id
 s65-20020a1f4544000000b0047ea21886b2mr5481714vka.15.1689096627914; Tue, 11
 Jul 2023 10:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230620201818.1670753-1-namhyung@kernel.org> <20230620201818.1670753-3-namhyung@kernel.org>
 <a791e982-ada3-7f26-e105-bc7fa9c7d346@intel.com>
In-Reply-To: <a791e982-ada3-7f26-e105-bc7fa9c7d346@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Jul 2023 10:30:16 -0700
Message-ID: <CAM9d7cjZA9JD_bxkaRyJxgt4sirCvwdyCARVTGMPOGHsip+MHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf machine: Include data symbols in the kernel map
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
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

Hi Adrian,

On Tue, Jul 11, 2023 at 8:19 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/06/23 23:18, Namhyung Kim wrote:
> > When perf record -d is used, it needs data mmaps to symbolize global data.
> > But it missed to collect kernel data maps so it cannot symbolize them.
> > Instead of having a separate map, just increase the kernel map size to
> > include the data section.
> >
> > Probably we can have a separate kernel map for data, but the current
> > code assumes a single kernel map.  So it'd require more changes in other
> > places and looks error-prone.  I decided not to go that way for now.
> >
> > Also it seems the kernel module size already includes the data section.
> >
> > For example, my system has the following.
> >
> >   $ grep -e _stext -e _etext -e _edata /proc/kallsyms
> >   ffffffff99800000 T _stext
> >   ffffffff9a601ac8 T _etext
> >   ffffffff9b446a00 D _edata
> >
> > Size of the text section is (0x9a601ac8 - 0x99800000 = 0xe01ac8) and
> > size of the data section is (0x9b446a00 - 0x99800000 = 0x1c46a00).
> >
> > Before:
> >   $ perf record -d true
> >
> >   $ perf report -D | grep MMAP | head -1
> >   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0xe01ac8) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
> >                                                                ^^^^^^^^
> >                                                                  here
> > After:
> >   $ perf report -D | grep MMAP | head -1
> >   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0x1c46a00) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
> >                                                                ^^^^^^^^^
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/machine.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index ddc0a2130caf..e93a66f6e0b3 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1218,7 +1218,10 @@ static int machine__get_running_kernel_start(struct machine *machine,
> >
> >       *start = addr;
> >
> > -     err = kallsyms__get_function_start(filename, "_etext", &addr);
> > +     if (machine->has_data_mmap)
> > +             err = kallsyms__get_symbol_start(filename, "_edata", &addr);
> > +     else
> > +             err = kallsyms__get_function_start(filename, "_etext", &addr);
>
> What is the downside of just extending it unconditionally?

I don't know.. maybe some people would argue it needs the
proper protection bits other than 'x' but this patch also breaks it.
But as I said, I'm not sure if we really want to change that now.

That said, we can make it unconditional. :)

Thanks,
Namhyung

>
> >       if (!err)
> >               *end = addr;
> >
>
