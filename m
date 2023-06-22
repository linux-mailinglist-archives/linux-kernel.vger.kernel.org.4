Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14777396C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjFVFV2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 01:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFVFV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:21:26 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90EE9;
        Wed, 21 Jun 2023 22:21:24 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-570282233ceso59821637b3.1;
        Wed, 21 Jun 2023 22:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687411283; x=1690003283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rR044SSxl+eWg+1CcC42Rlvbeb6U3eDYtmxpB+2refo=;
        b=Vz/ss28OWVFefWWyZy9KFIXb8GtIkSr5BByeyTImni5Wk2G0kq/9PvtTOz//dDm1Pg
         kT2rCVJago1CqTaY+nKf8ey7ae3kW0UgPY25otg2FkoIa+Y33c3tWX9k1OLwFXoTv0ce
         p28uIZ0wZmSa8o1q36OAN0s/YwkRwuGKJR/Kv4LpIM8elLpdFldXbM86bPYJLQbaZrxR
         IoVLdqPMS8HT/ZwQCRko2vk2fYTsFCnHXuv9ZeQkSKf8x6IutaDOj9aSBxsOu825t8Hy
         pehVDGuim/+ZxBpMUXQ1RcRuz+iB2sOlYxM/UFZO9gwEfeLc2DiLhxcQucfueR0jQHES
         gguA==
X-Gm-Message-State: AC+VfDw5v7I0HwMnCQd/lNKlwVjBpX/Xuy/rEahGbRfw6jm8btMmvoPi
        PiMK8cIl664He+eMBDclUbCCOsN/LTQIZRxdbP0=
X-Google-Smtp-Source: ACHHUZ6bk0+MENj7s8Ifi8SwBQnayePFnImewkbVOuCy/I88WBv01pXwvMgVrR5yp/wF8yWxTOI55WUoNtruvrJ943s=
X-Received: by 2002:a25:df48:0:b0:be6:2ac8:f84b with SMTP id
 w69-20020a25df48000000b00be62ac8f84bmr10889261ybg.44.1687411283451; Wed, 21
 Jun 2023 22:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063749.3358430-1-irogers@google.com> <CAM9d7cg-r7Nw807egNFVRBgEXwgBV=A2pVEb+MBS4gvFgnNynQ@mail.gmail.com>
 <CAP-5=fVBbXoGuNeaYADA1RgY4wfSN8CgAJVEBjmOQGZ=-OiOAQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVBbXoGuNeaYADA1RgY4wfSN8CgAJVEBjmOQGZ=-OiOAQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 22:21:12 -0700
Message-ID: <CAM9d7cixNAgxU58YNLHOpdZzDqk1t_ypOCQKEyo8+chFHd1HrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf symbol: Remove symbol_name_rb_node
To:     Ian Rogers <irogers@google.com>
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

On Wed, Jun 21, 2023 at 9:28 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jun 21, 2023 at 8:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, Jun 20, 2023 at 11:37 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Most perf commands want to sort symbols by name and this is done via
> > > an invasive rbtree that on 64-bit systems costs 24 bytes. Sorting the
> > > symbols in a DSO by name is optional and not done by default, however,
> > > if sorting is requested the 24 bytes is allocated for every
> > > symbol.
> > >
> > > This change removes the rbtree and uses a sorted array of symbol
> > > pointers instead (costing 8 bytes per symbol). As the array is created
> > > on demand then there are further memory savings. The complexity of
> > > sorting the array and using the rbtree are the same.
> > >
> > > To support going to the next symbol, the index of the current symbol
> > > needs to be passed around as a pair with the current symbol. This
> > > requires some API changes.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > v2. map__find_symbol_by_name_idx so that map__find_symbol_by_name
> > >     doesn't need an optional parameter. Separate out
> > >     symbol_conf.sort_by_name removal.
> > > ---
> >
> > [SNIP]
> > >  void dso__sort_by_name(struct dso *dso)
> > >  {
> > > -       dso__set_sorted_by_name(dso);
> > > -       return symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
> > > +       mutex_lock(&dso->lock);
> > > +       if (!dso__sorted_by_name(dso)) {
> > > +               size_t len;
> > > +
> > > +               dso->symbol_names = symbols__sort_by_name(&dso->symbols, &len);
> > > +               if (dso->symbol_names) {
> > > +                       dso->symbol_names_len = len;
> > > +                       dso__set_sorted_by_name(dso);
> > > +               }
> > > +       }
> > > +       mutex_unlock(&dso->lock);
> >
> > I think this part deserves a separate commit.
>
> Using the mutex or the use of sorted_by_name?

For the mutex originally, but might be better to split further. :)

And now it grabs the mutex unconditionally, I think
we can check the condition without the mutex first
and again with the mutex if not sorted.

Thanks,
Namhyung
