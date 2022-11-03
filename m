Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8876617E07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKCNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiKCNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:38:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9765E3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:38:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y72so2185744yby.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irdq3O1lb1JnKN7Ou++KN+Z8sVxUlbpeb3a7cIB0eQQ=;
        b=o/fMkgQ5UYq51vh/qMdPxWEylbuwGtGO/YZZmj7l6K7HWDaO2vAMIlxHaHYZVOSx71
         XhtxKINlPZFwcduDZm6t/CdGqB9Hk/LRDOq4uVVvF6mmIrYd+Nb17CCcrs6UDerMZKfL
         m0uodRGlqLEf46jV9v0CUxfxOMZiAabKxBUQtorTofUVILUa6Y95+CI8bf7y+i2qWjVw
         BSi7Da8u13851yldVhJAQCuo1zQl7jlN4QAaLNRMvp+PltM4CrtOlHOm2Ml038ez46zn
         am52kuM+sOnBufTnZ8QJ/wnSgwheaxjhpmQGIHjefqnTYeW27Uay3voojkfRsHqH1VoS
         O22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irdq3O1lb1JnKN7Ou++KN+Z8sVxUlbpeb3a7cIB0eQQ=;
        b=nMyEARN4PO4pykkHQ0/vtLhRtvOKr4lEtSX3vKSfQv8I4xxaKzRWVsWijBNaQ0wzhL
         a+kqmqPfwEoVzxNA+O5vsmZlrVS/DaPGldRYf2AV0OF98BZtCI9xjiSS5i6gsaMOGdK4
         1bbgKroM+dBcBfvQrhPg7m2rOpm/Hd2SmA245Z7NR0kh/ku4qfWqFG/sFSPlsVUCvB+U
         MueOMw0HsS7jTrdruxeUrzlotHlf9RfYyDhLU8x67huYPLxbFoGuu2w9NUmEmYfeMcA5
         Opi5r5LYjyzQJ1fSRxK5GNH607MaL4B8O2fJ8h+1v3dOYrbX6TxB5QKu0Z/XxdlwWf8M
         DoPQ==
X-Gm-Message-State: ACrzQf2Crouh4qshWXYeX3shyovp/YLVYBXNdE6eO7qEQFX7U02D8cE2
        zwSpdl1WPkdwtZ8XkNqvhWtDJhLb1RDp8i1hVl+Nsh1DQeY=
X-Google-Smtp-Source: AMsMyM58vRP0lD9InvZgsRnxnxos4pYpKQEt9T/N5pRVGgAoKqBnao816pHO1xNlOTvHlMrnubbYyhc0OXPhkni2qM8=
X-Received: by 2002:a25:e80d:0:b0:6cb:a59c:541b with SMTP id
 k13-20020a25e80d000000b006cba59c541bmr27765396ybd.388.1667482684769; Thu, 03
 Nov 2022 06:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221102110611.1085175-1-glider@google.com> <20221102110611.1085175-5-glider@google.com>
 <Y2OjdsGCEfTQuqJP@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2OjdsGCEfTQuqJP@hirez.programming.kicks-ass.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 3 Nov 2022 14:37:28 +0100
Message-ID: <CAG_fn=XmODMP6rocAoCUGsOhDZmxr09PG_1WZewNg+-tcLhoWg@mail.gmail.com>
Subject: Re: [PATCH 5/5] x86/traps: avoid KMSAN bugs originating from handle_bug()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 12:18 PM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Wed, Nov 02, 2022 at 12:06:11PM +0100, Alexander Potapenko wrote:
>
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 178015a820f08..d3fdec706f1d2 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/context_tracking.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kallsyms.h>
> > +#include <linux/kmsan.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/kprobes.h>
> >  #include <linux/uaccess.h>
> > @@ -301,6 +302,12 @@ static noinstr bool handle_bug(struct pt_regs *reg=
s)
> >  {
> >       bool handled =3D false;
> >
> > +     /*
> > +      * Normally @regs are unpoisoned by irqentry_enter(), but handle_=
bug()
> > +      * is a rare case that uses @regs without passing them to
> > +      * irqentry_enter().
> > +      */
> > +     kmsan_unpoison_entry_regs(regs);
> >       if (!is_valid_bugaddr(regs->ip))
> >               return handled;
> >
>
> Should we place this kmsan_unpoison_entry_regs() after the
> instrumentation_begin() ?

Agreed, let me send an update.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
