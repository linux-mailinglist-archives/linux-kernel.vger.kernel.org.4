Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC0270FB73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjEXQLP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEXQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:11:12 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329C510B;
        Wed, 24 May 2023 09:10:59 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-55db055b412so21117b3.0;
        Wed, 24 May 2023 09:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944658; x=1687536658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hliVnTwHwWho3tFIzV1PGbhYXsG4KcvdaSdTP6Kzvoc=;
        b=NpSiIhbRB35clt5PBN3+ovlcOV0PyISYv+TCeAEFzaYh7h2jl/Zl4zjhoGOd1Ru+id
         sRPBJZOHo8GpRC6ZMMvfEMRF2BH6Ls/wrMxtBH3klFnHYxQjUDc2Z82OTdntmqiVtA+Y
         MD71CA86GtRFKy3tjxMR5j2CiHjbNDEPVV5eIfaQ/Ubnf5p427UvduQZJ70lj8eS4N2N
         dO6N30cBJc0syNhM+djXQXctA39Y0epaqz1mH+587xs+iw3HFprC8c26JHEJiq6l1L3/
         sMHJ0F++ixVGMX2eYro/P35ot+9526d0df5p6BV7INuI44v5mNVI8mAd9bKZYx3nrtZ1
         MdCw==
X-Gm-Message-State: AC+VfDxfSfxbhITBV6lNYU/TrYqV/EqwK7tpbLCrBrN1qxauIbFRvcDw
        rFK0zbkIGc81byy6yf4FIyUzkre0IcQis6Wro5I=
X-Google-Smtp-Source: ACHHUZ5g+ls2IF2C+H7eW2idqDF3yaLitnovJ0Icwq+/Ht0XmYhcCiWyrbAUuK7YKN5MWaY0UWKQcxPIva9dGHfMc3s=
X-Received: by 2002:a25:208:0:b0:bab:b12c:b665 with SMTP id
 8-20020a250208000000b00babb12cb665mr402930ybc.7.1684944658133; Wed, 24 May
 2023 09:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230524052834.1041418-1-namhyung@kernel.org> <b054012a-94ee-fb86-da35-d3359b8b4683@intel.com>
In-Reply-To: <b054012a-94ee-fb86-da35-d3359b8b4683@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 May 2023 09:10:47 -0700
Message-ID: <CAM9d7cif9PPBWPEZx6MA6E4FHaAQLbi-0pEGwLrtLxiEASog9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf annotate: Handle x86 instruction suffix generally
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

Hi Adrian,

On Tue, May 23, 2023 at 11:11 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/05/23 08:28, Namhyung Kim wrote:
> > Most of x86 instructions can have size suffix like b, w, l or q.
>
> (AT&T mnemonics)

Right, will update.

>
> > Instead of adding all these instructions in the table, we can handle
> > them in a general way.  For example, it can try to find an instruction
> > as is.  If not found, it'd try again without the suffix if it's one of
> > the allowed suffixes.
>
> I guess it might be possible that xyz is in the table but xyz<suffix>
> is a completely different instruction?

Then xyz<suffix> should be in the table too.  The match without
suffix is a fallback so it should find the correct instruction first.

Thanks,
Namhyung


>
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index b708bbc49c9e..7f05f2a2aa83 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -70,6 +70,7 @@ struct arch {
> >       struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
> >       bool            sorted_instructions;
> >       bool            initialized;
> > +     const char      *insn_suffix;
> >       void            *priv;
> >       unsigned int    model;
> >       unsigned int    family;
> > @@ -179,6 +180,7 @@ static struct arch architectures[] = {
> >               .init = x86__annotate_init,
> >               .instructions = x86__instructions,
> >               .nr_instructions = ARRAY_SIZE(x86__instructions),
> > +             .insn_suffix = "bwlq",
> >               .objdump =  {
> >                       .comment_char = '#',
> >               },
> > @@ -720,6 +722,26 @@ static struct ins_ops *__ins__find(struct arch *arch, const char *name)
> >       }
> >
> >       ins = bsearch(name, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
> > +     if (ins)
> > +             return ins->ops;
> > +
> > +     if (arch->insn_suffix) {
> > +             char tmp[32];
> > +             char suffix;
> > +             size_t len = strlen(name);
> > +
> > +             if (len == 0 || len >= sizeof(tmp))
> > +                     return NULL;
> > +
> > +             suffix = name[len - 1];
> > +             if (strchr(arch->insn_suffix, suffix) == NULL)
> > +                     return NULL;
> > +
> > +             strcpy(tmp, name);
> > +             tmp[len - 1] = '\0'; /* remove the suffix and check again */
> > +
> > +             ins = bsearch(tmp, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
> > +     }
> >       return ins ? ins->ops : NULL;
> >  }
> >
>
