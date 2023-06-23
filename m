Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CB973BE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjFWSDV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjFWSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:03:19 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867DE41;
        Fri, 23 Jun 2023 11:03:18 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3942c6584f0so668647b6e.3;
        Fri, 23 Jun 2023 11:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543398; x=1690135398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kI5iLP7S5P3Y3xe8GWyhUA8TdqAPraOYiMtE/aW5NE=;
        b=bxOQU4jn/MMZv458LvuxbgTLxq64mKLMVXrBQqxk/1xYnGoOUN29rdq57+Rr2L76Xk
         hWcDjOt1JuVwlGZAOXvVZQsprW1y21fjiGGwtdkyxsQ5xFbLKdY6P/8tggjL+3V8cNnF
         2poPAkD6C3NNGY2/cnKo5KXV/UGrNeRs9kfd5z16iuQSapVRLRclOIHXomUq9skxvM+Y
         d052EugTOtTe0Di960j67j94+IYt07cQfYmZeukqCsfKf1eML0RdQA4vMghKwlX+DNzO
         3S5PIa1wGttLIhzjHpoBLO630m0CUJhPUaX99BP5LgAU2QjuH2ewPaSwj/r1XuGuEQ0L
         ZTRw==
X-Gm-Message-State: AC+VfDx1SEf+T/DgQoliP2JtKY2aGFJrBhgOeaaHzzLQUoR62TpsMR16
        1OAKvCXj6RPVqHGWxTxQ+bWls7jygcvb7Rty9tk=
X-Google-Smtp-Source: ACHHUZ4VAoUbqJeJb4RNroKTjcodARKQ06Ll3i1RXOFtc2PSsHvMB0/EiabaDOUyvLDAHHjPFHOkFAwJ9VTm6wiS8nQ=
X-Received: by 2002:a05:6359:67a0:b0:132:962d:b5d1 with SMTP id
 sq32-20020a05635967a000b00132962db5d1mr6469466rwb.22.1687543397637; Fri, 23
 Jun 2023 11:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230622235357.225190-1-namhyung@kernel.org> <CAP-5=fVxz--VxTrHwgyY4VudhpqPqUUp=gdMA+t15EnrmTpsGg@mail.gmail.com>
In-Reply-To: <CAP-5=fVxz--VxTrHwgyY4VudhpqPqUUp=gdMA+t15EnrmTpsGg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 11:03:06 -0700
Message-ID: <CAM9d7chdqpb5s8hqCJoDNHidGo5rrrdtOXf=FSv+XPU42MNzfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf script: Initialize buffer for regs_map()
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Aditya Gupta <adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 5:16 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Jun 22, 2023 at 4:54 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The buffer is used to save register mapping in a sample.  Normally
> > perf samples don't have any register so the string should be empty.
> > But it missed to initialize the buffer when the size is 0.  And it's
> > passed to PyUnicode_FromString() with a garbage data.
> >
> > So it returns NULL due to invalid input (instead of an empty unicode
> > string object) which causes a segfault like below:
> >
> >   Thread 2.1 "perf" received signal SIGSEGV, Segmentation fault.
> >   [Switching to Thread 0x7ffff7c83780 (LWP 193775)]
> >   0x00007ffff6dbca2e in PyDict_SetItem () from /lib/x86_64-linux-gnu/libpython3.11.so.1.0
> >   (gdb) bt
> >   #0  0x00007ffff6dbca2e in PyDict_SetItem () from /lib/x86_64-linux-gnu/libpython3.11.so.1.0
> >   #1  0x00007ffff6dbf848 in PyDict_SetItemString () from /lib/x86_64-linux-gnu/libpython3.11.so.1.0
> >   #2  0x000055555575824d in pydict_set_item_string_decref (val=0x0, key=0x5555557f96e3 "iregs", dict=0x7ffff5f7f780)
> >       at util/scripting-engines/trace-event-python.c:145
> >   #3  set_regs_in_dict (evsel=0x555555efc370, sample=0x7fffffffb870, dict=0x7ffff5f7f780)
> >       at util/scripting-engines/trace-event-python.c:776
> >   #4  get_perf_sample_dict (sample=sample@entry=0x7fffffffb870, evsel=evsel@entry=0x555555efc370, al=al@entry=0x7fffffffb2e0,
> >       addr_al=addr_al@entry=0x0, callchain=callchain@entry=0x7ffff63ef440) at util/scripting-engines/trace-event-python.c:923
> >   #5  0x0000555555758ec1 in python_process_tracepoint (sample=0x7fffffffb870, evsel=0x555555efc370, al=0x7fffffffb2e0, addr_al=0x0)
> >       at util/scripting-engines/trace-event-python.c:1044
> >   #6  0x00005555555c5db8 in process_sample_event (tool=<optimized out>, event=<optimized out>, sample=<optimized out>,
> >       evsel=0x555555efc370, machine=0x555555ef4d68) at builtin-script.c:2421
> >   #7  0x00005555556b7793 in perf_session__deliver_event (session=0x555555ef4b60, event=0x7ffff62ff7d0, tool=0x7fffffffc150,
> >       file_offset=30672, file_path=0x555555efb8a0 "perf.data") at util/session.c:1639
> >   #8  0x00005555556bc864 in do_flush (show_progress=true, oe=0x555555efb700) at util/ordered-events.c:245
> >   #9  __ordered_events__flush (oe=oe@entry=0x555555efb700, how=how@entry=OE_FLUSH__FINAL, timestamp=timestamp@entry=0)
> >       at util/ordered-events.c:324
> >   #10 0x00005555556bd06e in ordered_events__flush (oe=oe@entry=0x555555efb700, how=how@entry=OE_FLUSH__FINAL)
> >       at util/ordered-events.c:342
> >   #11 0x00005555556b9d63 in __perf_session__process_events (session=0x555555ef4b60) at util/session.c:2465
> >   #12 perf_session__process_events (session=0x555555ef4b60) at util/session.c:2627
> >   #13 0x00005555555cb1d0 in __cmd_script (script=0x7fffffffc150) at builtin-script.c:2839
> >   #14 cmd_script (argc=<optimized out>, argv=<optimized out>) at builtin-script.c:4365
> >   #15 0x0000555555650811 in run_builtin (p=p@entry=0x555555ed8948 <commands+456>, argc=argc@entry=4, argv=argv@entry=0x7fffffffe240)
> >       at perf.c:323
> >   #16 0x0000555555597eb3 in handle_internal_command (argv=0x7fffffffe240, argc=4) at perf.c:377
> >   #17 run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at perf.c:421
> >   #18 main (argc=4, argv=0x7fffffffe240) at perf.c:537
> >
> > Fixes: 51cfe7a3e87e ("perf python: Avoid 2 leak sanitizer issues")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Ian Rogers <irogers@google.com>

Applied both to perf-tools-next, thanks!
