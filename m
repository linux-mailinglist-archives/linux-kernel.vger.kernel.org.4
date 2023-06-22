Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B333E739716
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjFVFyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFVFyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:54:44 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A310F0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:54:42 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so84061cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687413281; x=1690005281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3YNCvHVBh6f5985fs1PM5llxz1wl3G7BMCoa8Ui5Y4=;
        b=jWAnJ3S40v/MJxJRmfuVpU9OaAQN2PgYBYv7/cd6zod/5Ict5iXkK8uPJ6ViEy7h/K
         NgGf8guh+Gkj1/e4t7WQSpfLX8V9u6QepA6BsTIKddtPnT+ueMeflAvSpVu/SSq5DeZS
         BYXDqVKycYzbkRodJG1mfHP84Qq3cR0JM1aEuHGn45m4iofCV+guz8VmR2vWoMINorCp
         E7HfvsVvzQJny96GLYkb+ALMzXcR0Y8nTBfToqwak6Hp8gNhgQ9nivnwud/1MFtYKitq
         zVFq7K72ZcARs8uznLNvuE0HqqurqhBm5Z8SmuSBnNQBjHUHIDVvSXgfzyqFQPEYmAKy
         te5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687413281; x=1690005281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3YNCvHVBh6f5985fs1PM5llxz1wl3G7BMCoa8Ui5Y4=;
        b=bBZ0QHZyB7S+7jM6ynbXCdWsahG8/TknhOWYOtnjknFkGyoh0t+JYp14VaZF2wGReh
         VwrnH4nEzsHT8KIDaDX7yUSQDXljUE0r02GN7/95uevCC7wo6ItoDXs2WYlZqi/cbTej
         wDxvEMnsnt358aB31oOtQ/8NOnEmIq5R+PGup2PXDac1oZ4HlzaOvxk+fuWd96i8IJ/N
         vBGUd16yf1NUOFJXdsZZRLD2Vut3ohNFIWEPBaZwGTI0uF4qLgelDCq8VD7ZUCpvS6hw
         FQxR/+jGxKNuep6sVN9htmFN1hVHk+MAheRtAfGgtagwyPF5i+SNfJAB0FJVikF/JNkk
         fPGw==
X-Gm-Message-State: AC+VfDzCjrAcyiy9r4W2E+dcZ+O7ctIc+JNXx4LBuL111X28aLDqoGPs
        qUHIUY0z9w2dWN4XFA+podqmx9QhYzEZKUNl2EsoeA==
X-Google-Smtp-Source: ACHHUZ6lWG1QBdONLxsl9IqvdM2Y3NOBZzdN7diFaTRUlr4FZoijuFDDcZLgqOuGKZVq3sY5vvUJVj0JwVEQs3rYoqY=
X-Received: by 2002:ac8:7fcf:0:b0:3f3:75c2:7466 with SMTP id
 b15-20020ac87fcf000000b003f375c27466mr724316qtk.8.1687413281285; Wed, 21 Jun
 2023 22:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063749.3358430-1-irogers@google.com> <CAM9d7cg-r7Nw807egNFVRBgEXwgBV=A2pVEb+MBS4gvFgnNynQ@mail.gmail.com>
 <CAP-5=fVBbXoGuNeaYADA1RgY4wfSN8CgAJVEBjmOQGZ=-OiOAQ@mail.gmail.com> <CAM9d7cixNAgxU58YNLHOpdZzDqk1t_ypOCQKEyo8+chFHd1HrQ@mail.gmail.com>
In-Reply-To: <CAM9d7cixNAgxU58YNLHOpdZzDqk1t_ypOCQKEyo8+chFHd1HrQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Jun 2023 22:54:30 -0700
Message-ID: <CAP-5=fXkjSEgFmKNYYBzh11+xVD=j_KCOS7eQf=sBAALpMWK-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf symbol: Remove symbol_name_rb_node
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URI_DOTEDU,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Jun 21, 2023 at 9:28=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Jun 21, 2023 at 8:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, Jun 20, 2023 at 11:37=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > Most perf commands want to sort symbols by name and this is done vi=
a
> > > > an invasive rbtree that on 64-bit systems costs 24 bytes. Sorting t=
he
> > > > symbols in a DSO by name is optional and not done by default, howev=
er,
> > > > if sorting is requested the 24 bytes is allocated for every
> > > > symbol.
> > > >
> > > > This change removes the rbtree and uses a sorted array of symbol
> > > > pointers instead (costing 8 bytes per symbol). As the array is crea=
ted
> > > > on demand then there are further memory savings. The complexity of
> > > > sorting the array and using the rbtree are the same.
> > > >
> > > > To support going to the next symbol, the index of the current symbo=
l
> > > > needs to be passed around as a pair with the current symbol. This
> > > > requires some API changes.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > v2. map__find_symbol_by_name_idx so that map__find_symbol_by_name
> > > >     doesn't need an optional parameter. Separate out
> > > >     symbol_conf.sort_by_name removal.
> > > > ---
> > >
> > > [SNIP]
> > > >  void dso__sort_by_name(struct dso *dso)
> > > >  {
> > > > -       dso__set_sorted_by_name(dso);
> > > > -       return symbols__sort_by_name(&dso->symbol_names, &dso->symb=
ols);
> > > > +       mutex_lock(&dso->lock);
> > > > +       if (!dso__sorted_by_name(dso)) {
> > > > +               size_t len;
> > > > +
> > > > +               dso->symbol_names =3D symbols__sort_by_name(&dso->s=
ymbols, &len);
> > > > +               if (dso->symbol_names) {
> > > > +                       dso->symbol_names_len =3D len;
> > > > +                       dso__set_sorted_by_name(dso);
> > > > +               }
> > > > +       }
> > > > +       mutex_unlock(&dso->lock);
> > >
> > > I think this part deserves a separate commit.
> >
> > Using the mutex or the use of sorted_by_name?
>
> For the mutex originally, but might be better to split further. :)

I can add the locks first. There's an obvious leak with the array
approach if two threads are sorting. With the invasive rbtree a leak
isn't possible but corruption could be.

> And now it grabs the mutex unconditionally, I think
> we can check the condition without the mutex first
> and again with the mutex if not sorted.

Is there a kernel pattern for double checked locking that isn't broken
in the normal ways double checked locking is broken?
https://www.cs.umd.edu/~pugh/java/memoryModel/DoubleCheckedLocking.html

Thanks,
Ian

> Thanks,
> Namhyung
