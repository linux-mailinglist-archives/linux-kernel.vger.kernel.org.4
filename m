Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815F71EE78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjFAQPR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 12:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFAQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:15:09 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D512137;
        Thu,  1 Jun 2023 09:15:02 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bacf685150cso1086880276.3;
        Thu, 01 Jun 2023 09:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685636102; x=1688228102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/1NXA3g5vtQuuMeJDuAQWen5/UkCvVUOcN647Fy61M=;
        b=jGwbdx6f2hZ/cs/YDro3WmwSC66qLyR1R4V5uh34PqYkdvCP5b/bmt7NYdAQayqhwj
         HucUq0LMjgGrfwhPlCMKEdPjQKq4CLeS4N4/jMoN0Hv/NrH5j0BgejwcEJoZgvsdfOCS
         FrhSS/otIPwsOjS+TP2QorDFA4tp98RPede9PcyMz8WSCxfymMp8SErXtIXF0yg4Srrk
         mADNMSeCi189KS0/BxMnOU3SSNZm6fC14rKqiDMRlLyQ4PTs53zZD2JJZvlpkC/nDZOO
         QQYfyMxFXRsPjoS01XhDpF0AKJ9IVqKxWQ3mC1HdViSva86grJUt1/jsy5UTj7j2zU16
         60Xg==
X-Gm-Message-State: AC+VfDwjIYZ5PulRcDDsVYxXZ7g4k3Xk1lvP9ovsmXLcMvpClz0EVFv1
        IcV82i7gg3sShbC5H+wltqEgyQSEXsPqCICKafw=
X-Google-Smtp-Source: ACHHUZ5C6hpm7eeuqlLLRKZihFO+c28srM4A5ysTGbGIuNk3OUHNdIX1MA/PA16PAK8DiBuRTCLgiK7mXsTMv2xyF98=
X-Received: by 2002:a25:ad09:0:b0:ba6:984a:2814 with SMTP id
 y9-20020a25ad09000000b00ba6984a2814mr371424ybi.23.1685636101679; Thu, 01 Jun
 2023 09:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203236.1602054-1-namhyung@kernel.org> <dfef9c42-5b84-6720-656f-5d3ac1d8ccf5@intel.com>
In-Reply-To: <dfef9c42-5b84-6720-656f-5d3ac1d8ccf5@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jun 2023 09:14:50 -0700
Message-ID: <CAM9d7cjMLMExM_irC+ZXkDi65w95W6OpOihgrbB5X=jJgwyNeQ@mail.gmail.com>
Subject: Re: [PATCH] perf script: Increase PID/TID width for output
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

On Wed, May 31, 2023 at 9:54 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 31/05/23 23:32, Namhyung Kim wrote:
> > On large systems, it's common that PID/TID is bigger than 5-digit and it
> > makes the output unaligned.  Let's increase the width to 7.
>
> Might be worth noting that currently the biggest PID_MAX_LIMIT
> is 2^22 so pids don't get bigger than 7 digits presently.

Nice, will add that.

>
> >
> > Before:
> >
> >   $ perf script
> >   ...
> >            swapper     0 [006] 1540823.803935:    1369324 cycles:P:  ffffffff9c755588 ktime_get+0x18 ([kernel.kallsyms])
> >        gvfsd-dnssd 95114 [004] 1540823.804164:    1643871 cycles:P:  ffffffff9cfdca5c __get_user_8+0x1c ([kernel.kallsyms])
> >          perf-exec 1558582 [000] 1540823.804209:    1018714 cycles:P:  ffffffff9c924ab9 __slab_free+0x9 ([kernel.kallsyms])
> >              nmcli 1558589 [007] 1540823.804384:    1859212 cycles:P:      7f70537a8ad8 __strchrnul_evex+0x18 (/usr/lib/x86_64-linux-gnu/libc.so.6>
> >              sleep 1558582 [000] 1540823.804456:     987425 cycles:P:      7fd35bb27b30 _dl_init+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2>
> >        dbus-daemon  3043 [003] 1540823.804575:    1564465 cycles:P:  ffffffff9cb2bb70 llist_add_batch+0x0 ([kernel.kallsyms])
> >              gdbus 1558592 [001] 1540823.804766:    1315219 cycles:P:  ffffffff9c797b2e audit_filter_syscall+0x9e ([kernel.kallsyms])
> >     NetworkManager  3452 [005] 1540823.805301:    1558782 cycles:P:      7fa957737748 g_bit_lock+0x58 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.5>
> >
> > After:
> >
> >   $ perf script
> >   ...
> >            swapper       0 [006] 1540823.803935:    1369324 cycles:P:  ffffffff9c755588 ktime_get+0x18 ([kernel.kallsyms])
> >        gvfsd-dnssd   95114 [004] 1540823.804164:    1643871 cycles:P:  ffffffff9cfdca5c __get_user_8+0x1c ([kernel.kallsyms])
> >          perf-exec 1558582 [000] 1540823.804209:    1018714 cycles:P:  ffffffff9c924ab9 __slab_free+0x9 ([kernel.kallsyms])
> >              nmcli 1558589 [007] 1540823.804384:    1859212 cycles:P:      7f70537a8ad8 __strchrnul_evex+0x18 (/usr/lib/x86_64-linux-gnu/libc.so.6>
> >              sleep 1558582 [000] 1540823.804456:     987425 cycles:P:      7fd35bb27b30 _dl_init+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2>
> >        dbus-daemon    3043 [003] 1540823.804575:    1564465 cycles:P:  ffffffff9cb2bb70 llist_add_batch+0x0 ([kernel.kallsyms])
> >              gdbus 1558592 [001] 1540823.804766:    1315219 cycles:P:  ffffffff9c797b2e audit_filter_syscall+0x9e ([kernel.kallsyms])
> >     NetworkManager    3452 [005] 1540823.805301:    1558782 cycles:P:      7fa957737748 g_bit_lock+0x58 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.5>
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for your review!
Namhyung


>
> > ---
> >  tools/perf/builtin-script.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 029d5a597233..70549fc93b12 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -801,11 +801,11 @@ static int perf_sample__fprintf_start(struct perf_script *script,
> >       }
> >
> >       if (PRINT_FIELD(PID) && PRINT_FIELD(TID))
> > -             printed += fprintf(fp, "%5d/%-5d ", sample->pid, sample->tid);
> > +             printed += fprintf(fp, "%7d/%-7d ", sample->pid, sample->tid);
> >       else if (PRINT_FIELD(PID))
> > -             printed += fprintf(fp, "%5d ", sample->pid);
> > +             printed += fprintf(fp, "%7d ", sample->pid);
> >       else if (PRINT_FIELD(TID))
> > -             printed += fprintf(fp, "%5d ", sample->tid);
> > +             printed += fprintf(fp, "%7d ", sample->tid);
> >
> >       if (PRINT_FIELD(CPU)) {
> >               if (latency_format)
>
