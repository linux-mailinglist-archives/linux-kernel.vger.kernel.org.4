Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2BC7233D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjFEX5N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 19:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFEX5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:57:11 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4BF2;
        Mon,  5 Jun 2023 16:57:10 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ba8374001abso6042088276.2;
        Mon, 05 Jun 2023 16:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009430; x=1688601430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT1VLgcbU914AmCWBxVB8Uqq7gnS8nT0HPPcjgOhVqA=;
        b=AkXEPTzs2Ow/lRmO7T0kA4dNxsGqbM5gEQo6vZDx7pTP2Kzfbk4LztZ7bhzYYC0uZY
         VZZalosfTHwPsMiVkb/lNJ9xmWX20Lf56u+439wCWtEAWVqUr24QAQjsY3xMaMmUb+Am
         8qAHN0oHXGyBpyLZo6XR9EciJ4vHIq4JNYvD7rTnyIK/W3i9c/yVBD8ilwTDTOK7u6Ij
         5/iyKPj4ldFjBgaE0SiG0TFJccsHgLN4+/uVnirTmobK2orpxXzme/sre0Ii9ZyytH/v
         J0DD3ukCJnGC8w7S+SAD3HzZDeP2KhS7FXzGGp4QQ4b4Zzvc7GG6rkVc0edXQHDvyBjf
         cCcA==
X-Gm-Message-State: AC+VfDzVNs0URl2kVh5w5oF+BXXpg9+iqq6bFuEXA2tF9e0n2iuB7QCS
        5+uiipxXKp0ye0YQQBgfK09SVDFEm9ewPjzq0TgbdFXERhXAbQ==
X-Google-Smtp-Source: ACHHUZ6wxJN99gbp1wFCNM7foFqrCsQe1qe/8D+p4YucDPIiXBInk1KI8dw4snDZjTizyZbZiKZJAs78w3MQKcfhKLc=
X-Received: by 2002:a25:8b87:0:b0:ba7:9c6f:e2de with SMTP id
 j7-20020a258b87000000b00ba79c6fe2demr99896ybl.27.1686009429930; Mon, 05 Jun
 2023 16:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230524205054.3087004-1-namhyung@kernel.org> <d6ef6936-e885-46db-40d6-e3cfbd1b2c22@intel.com>
In-Reply-To: <d6ef6936-e885-46db-40d6-e3cfbd1b2c22@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 5 Jun 2023 16:56:58 -0700
Message-ID: <CAM9d7cjoJL1+aHpmc-menWzYk_rfPV_UsDcmP0mXy0K2h6TPRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf annotate: Handle x86 instruction suffix generally
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

Hi Arnaldo,

On Wed, May 24, 2023 at 10:21 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/05/23 23:50, Namhyung Kim wrote:
> > In AT&T asm syntax, most of x86 instructions can have size suffix like
> > b, w, l or q.  Instead of adding all these instructions in the table,
> > we can handle them in a general way.
> >
> > For example, it can try to find an instruction as is.  If not found,
> > assuming it has a suffix and it'd try again without the suffix if it's
> > one of the allowed suffixes.  This way, we can reduce the instruction
> > table size for duplicated entries of the same instructions with a
> > different suffix.
> >
> > If an instruction xyz and others like xyz<suffix> are completely
> > different ones, then they both need to be listed in the table so that
> > they can be found before the second attempt (without the suffix).
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Can you please pick this up?

Thanks,
Namhyung

>
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
