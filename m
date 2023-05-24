Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86EA70FB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjEXQMM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjEXQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:12:05 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0282B0;
        Wed, 24 May 2023 09:12:03 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so2338359276.0;
        Wed, 24 May 2023 09:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944723; x=1687536723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6UQgi5xvFzEPSAlz8yP98XntMjzg5orOqUjts2WmdY=;
        b=lBfPbLpAezD1iX+BkVyRHr0PbtTnz2eW51w4ArA03vAscTTLOZJTV3N+UZiIQOJRXT
         NGu0+/UhY7aRqWkRz4PGXryKqR7YV9js2xNeNpqHHMbioPcmX6lzHiAkhBS0z0XVrbzu
         tt5Jbvz4B1Pll6YzaLX3TmbRfa7CBC1cIpx97EnUpuYSsSQ8S0p/dbMOJN5MCtkzfHAl
         shCneg2F3ZcOnrl2zPfvp5wj9CodWtOb0QzV8qsc6odxeWZTl0IHcTF7LQsS5FoJeFbX
         7geSLuFq+F/2Pdkh71ZTUB2gmXsGzpB/SQ2zhZEPGrih8zZsqpPPn5M8/QuCQiuGze9h
         riaw==
X-Gm-Message-State: AC+VfDzY8j0IG3YZwSloej6nQ+O0DfOpUSvqXv8soOJ6zSW+aZfqCe+C
        5zda3OwDrYo06Jl+gb+4lIlqJoqTOgaygywijjM=
X-Google-Smtp-Source: ACHHUZ461r5Ng3ZvO+Gs0hH6gRBjPlqvVSHcjas7Du8ZO3e3ggAkUjW0N+leGkL4Sai9YPuFKL+flKVJ/Wv/7uksaJg=
X-Received: by 2002:a25:bc47:0:b0:b9e:6d83:7bcf with SMTP id
 d7-20020a25bc47000000b00b9e6d837bcfmr367272ybk.27.1684944722741; Wed, 24 May
 2023 09:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230524052834.1041418-1-namhyung@kernel.org> <20230524052834.1041418-2-namhyung@kernel.org>
 <a51d79b3-6ba4-e85f-0f47-a9a180ea057c@intel.com>
In-Reply-To: <a51d79b3-6ba4-e85f-0f47-a9a180ea057c@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 May 2023 09:11:51 -0700
Message-ID: <CAM9d7cjpXj235c+6M6k6z41AmEwHuw7RP_oQ54VXwTopp8ui9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf annotate: Remove x86 instructions with suffix
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
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

On Tue, May 23, 2023 at 11:15 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/05/23 08:28, Namhyung Kim wrote:
> > Not the suffix is handled in the general code.  Let's get rid of them.
>
> Not -> Now ?

Correct, will fix.

>
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/arch/x86/annotate/instructions.c | 44 +--------------------
> >  1 file changed, 2 insertions(+), 42 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> > index 5c7bec25fee4..714fd8784d99 100644
> > --- a/tools/perf/arch/x86/annotate/instructions.c
> > +++ b/tools/perf/arch/x86/annotate/instructions.c
> > @@ -1,48 +1,29 @@
> >  // SPDX-License-Identifier: GPL-2.0
>
> Could probably use a comment about how the table works
> with suffixes.

Ok, I will add a comment.

Thanks for your review!
Namhyung


>
> >  static struct ins x86__instructions[] = {
> >       { .name = "adc",        .ops = &mov_ops,  },
> > -     { .name = "adcb",       .ops = &mov_ops,  },
> > -     { .name = "adcl",       .ops = &mov_ops,  },
> >       { .name = "add",        .ops = &mov_ops,  },
> > -     { .name = "addl",       .ops = &mov_ops,  },
> > -     { .name = "addq",       .ops = &mov_ops,  },
> >       { .name = "addsd",      .ops = &mov_ops,  },
> > -     { .name = "addw",       .ops = &mov_ops,  },
> >       { .name = "and",        .ops = &mov_ops,  },
> > -     { .name = "andb",       .ops = &mov_ops,  },
> > -     { .name = "andl",       .ops = &mov_ops,  },
> >       { .name = "andpd",      .ops = &mov_ops,  },
> >       { .name = "andps",      .ops = &mov_ops,  },
> > -     { .name = "andq",       .ops = &mov_ops,  },
> > -     { .name = "andw",       .ops = &mov_ops,  },
> >       { .name = "bsr",        .ops = &mov_ops,  },
> >       { .name = "bt",         .ops = &mov_ops,  },
> >       { .name = "btr",        .ops = &mov_ops,  },
> >       { .name = "bts",        .ops = &mov_ops,  },
> > -     { .name = "btsq",       .ops = &mov_ops,  },
> >       { .name = "call",       .ops = &call_ops, },
> > -     { .name = "callq",      .ops = &call_ops, },
> >       { .name = "cmovbe",     .ops = &mov_ops,  },
> >       { .name = "cmove",      .ops = &mov_ops,  },
> >       { .name = "cmovae",     .ops = &mov_ops,  },
> >       { .name = "cmp",        .ops = &mov_ops,  },
> > -     { .name = "cmpb",       .ops = &mov_ops,  },
> > -     { .name = "cmpl",       .ops = &mov_ops,  },
> > -     { .name = "cmpq",       .ops = &mov_ops,  },
> > -     { .name = "cmpw",       .ops = &mov_ops,  },
> >       { .name = "cmpxch",     .ops = &mov_ops,  },
> >       { .name = "cmpxchg",    .ops = &mov_ops,  },
> >       { .name = "cs",         .ops = &mov_ops,  },
> >       { .name = "dec",        .ops = &dec_ops,  },
> > -     { .name = "decl",       .ops = &dec_ops,  },
> > -     { .name = "decq",       .ops = &dec_ops,  },
> >       { .name = "divsd",      .ops = &mov_ops,  },
> >       { .name = "divss",      .ops = &mov_ops,  },
> >       { .name = "gs",         .ops = &mov_ops,  },
> >       { .name = "imul",       .ops = &mov_ops,  },
> >       { .name = "inc",        .ops = &dec_ops,  },
> > -     { .name = "incl",       .ops = &dec_ops,  },
> > -     { .name = "incq",       .ops = &dec_ops,  },
> >       { .name = "ja",         .ops = &jump_ops, },
> >       { .name = "jae",        .ops = &jump_ops, },
> >       { .name = "jb",         .ops = &jump_ops, },
> > @@ -56,7 +37,6 @@ static struct ins x86__instructions[] = {
> >       { .name = "jl",         .ops = &jump_ops, },
> >       { .name = "jle",        .ops = &jump_ops, },
> >       { .name = "jmp",        .ops = &jump_ops, },
> > -     { .name = "jmpq",       .ops = &jump_ops, },
> >       { .name = "jna",        .ops = &jump_ops, },
> >       { .name = "jnae",       .ops = &jump_ops, },
> >       { .name = "jnb",        .ops = &jump_ops, },
> > @@ -83,49 +63,31 @@ static struct ins x86__instructions[] = {
> >       { .name = "mov",        .ops = &mov_ops,  },
> >       { .name = "movapd",     .ops = &mov_ops,  },
> >       { .name = "movaps",     .ops = &mov_ops,  },
> > -     { .name = "movb",       .ops = &mov_ops,  },
> >       { .name = "movdqa",     .ops = &mov_ops,  },
> >       { .name = "movdqu",     .ops = &mov_ops,  },
> > -     { .name = "movl",       .ops = &mov_ops,  },
> > -     { .name = "movq",       .ops = &mov_ops,  },
> >       { .name = "movsd",      .ops = &mov_ops,  },
> >       { .name = "movslq",     .ops = &mov_ops,  },
> >       { .name = "movss",      .ops = &mov_ops,  },
> >       { .name = "movupd",     .ops = &mov_ops,  },
> >       { .name = "movups",     .ops = &mov_ops,  },
> > -     { .name = "movw",       .ops = &mov_ops,  },
> >       { .name = "movzbl",     .ops = &mov_ops,  },
> >       { .name = "movzwl",     .ops = &mov_ops,  },
> >       { .name = "mulsd",      .ops = &mov_ops,  },
> >       { .name = "mulss",      .ops = &mov_ops,  },
> >       { .name = "nop",        .ops = &nop_ops,  },
> > -     { .name = "nopl",       .ops = &nop_ops,  },
> > -     { .name = "nopw",       .ops = &nop_ops,  },
> >       { .name = "or",         .ops = &mov_ops,  },
> > -     { .name = "orb",        .ops = &mov_ops,  },
> > -     { .name = "orl",        .ops = &mov_ops,  },
> >       { .name = "orps",       .ops = &mov_ops,  },
> > -     { .name = "orq",        .ops = &mov_ops,  },
> >       { .name = "pand",       .ops = &mov_ops,  },
> >       { .name = "paddq",      .ops = &mov_ops,  },
> >       { .name = "pcmpeqb",    .ops = &mov_ops,  },
> >       { .name = "por",        .ops = &mov_ops,  },
> > -     { .name = "rclb",       .ops = &mov_ops,  },
> > -     { .name = "rcll",       .ops = &mov_ops,  },
> > +     { .name = "rcl",        .ops = &mov_ops,  },
> >       { .name = "ret",        .ops = &ret_ops,  },
> > -     { .name = "retq",       .ops = &ret_ops,  },
> >       { .name = "sbb",        .ops = &mov_ops,  },
> > -     { .name = "sbbl",       .ops = &mov_ops,  },
> >       { .name = "sete",       .ops = &mov_ops,  },
> >       { .name = "sub",        .ops = &mov_ops,  },
> > -     { .name = "subl",       .ops = &mov_ops,  },
> > -     { .name = "subq",       .ops = &mov_ops,  },
> >       { .name = "subsd",      .ops = &mov_ops,  },
> > -     { .name = "subw",       .ops = &mov_ops,  },
> >       { .name = "test",       .ops = &mov_ops,  },
> > -     { .name = "testb",      .ops = &mov_ops,  },
> > -     { .name = "testl",      .ops = &mov_ops,  },
> > -     { .name = "testq",      .ops = &mov_ops,  },
> >       { .name = "tzcnt",      .ops = &mov_ops,  },
> >       { .name = "ucomisd",    .ops = &mov_ops,  },
> >       { .name = "ucomiss",    .ops = &mov_ops,  },
> > @@ -139,11 +101,9 @@ static struct ins x86__instructions[] = {
> >       { .name = "vsubsd",     .ops = &mov_ops,  },
> >       { .name = "vucomisd",   .ops = &mov_ops,  },
> >       { .name = "xadd",       .ops = &mov_ops,  },
> > -     { .name = "xbeginl",    .ops = &jump_ops, },
> > -     { .name = "xbeginq",    .ops = &jump_ops, },
> > +     { .name = "xbegin",     .ops = &jump_ops, },
> >       { .name = "xchg",       .ops = &mov_ops,  },
> >       { .name = "xor",        .ops = &mov_ops, },
> > -     { .name = "xorb",       .ops = &mov_ops, },
> >       { .name = "xorpd",      .ops = &mov_ops, },
> >       { .name = "xorps",      .ops = &mov_ops, },
> >  };
>
