Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD0739667
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjFVE2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjFVE23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:28:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC5DE65
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 21:28:27 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40079620a83so101271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 21:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687408107; x=1690000107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYPH2WyrIzcETLuSO9SQRYjdko7/fZ6dC4eczqzPL1I=;
        b=TEwuqj7PZA05t9ftRqQIMyya/kh9LQ3+waawCxi+KYK6CqQ3UqqL74xcBf31a2YHch
         grePcwCzLRMRhTfPWpfOLhlvNnjRPrGFG+HxuKwzjkiNAZhSeBZlRlMgr3qOBffGWiko
         29BlxaQ7hEu8iVG9H+bJ/pt4XkNQYrAKUHGwxVuuw6JyfqcqVAuB+h5x4xmZTXHxQXsp
         LTCVa4Kalz8H2P07VeRE3HAL2JV+voYE4pGEREkFQBnhh3nQxMNJXCs5QZXkGEw16Vhf
         6WmF/jw6hU34lt6OkQqJZRcd5R2ULq4aKHxO38Iha4Ozio+ikSm/1cbQW/4hCp3p64uh
         9Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687408107; x=1690000107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYPH2WyrIzcETLuSO9SQRYjdko7/fZ6dC4eczqzPL1I=;
        b=fpGMzpOGRrup2HYUVK9PpqqRVU8ehGJiBTm5O3ogI7nbV2VsbAHzE8GKgLo0Ty14RH
         HphOl8bKWg2HZ/SaYj9/8rD3zwwskPjEnBvupLK3wSbDATlP/tJtDWT/xdEHZW86RClw
         6ofvxt9B6aJe/mNQQLFX0+13NGH5Nu53KwrWYLUx9F5WyipO8DiV6hVxEkwWxZBJe6+x
         GphfRaFsPZ/clx97n9OoDkaqZcnHBzVx43NlSDW5w7oh/EDWb08XblsheNzZxZTR7sQx
         nrnYR5bFdljfUMnrqYgc7Oy9ncgJckBwdFB45mOhmuNFy/zikXfrqWR71C7ud0prV6WV
         /cTQ==
X-Gm-Message-State: AC+VfDz6PtK5t/FkfSjOxIW0y3RVvz9jTazVClxkwy3JpCoZqS2isWG+
        Gv7zZ5wlNsOsRuD1/XoBFdzebkp++NYrAeWXHRoz1w==
X-Google-Smtp-Source: ACHHUZ5lzGs4uLskl2mh03JyO0IhyZ8IjKD6J4YBmH5FYd7n3kIrLO5bjc/3/RsM90YVDuZjbzT/EbEZqUQ8WIeAigY=
X-Received: by 2002:ac8:5911:0:b0:3fd:ad1b:4e8a with SMTP id
 17-20020ac85911000000b003fdad1b4e8amr1874956qty.22.1687408106689; Wed, 21 Jun
 2023 21:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063749.3358430-1-irogers@google.com> <CAM9d7cg-r7Nw807egNFVRBgEXwgBV=A2pVEb+MBS4gvFgnNynQ@mail.gmail.com>
In-Reply-To: <CAM9d7cg-r7Nw807egNFVRBgEXwgBV=A2pVEb+MBS4gvFgnNynQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Jun 2023 21:28:14 -0700
Message-ID: <CAP-5=fVBbXoGuNeaYADA1RgY4wfSN8CgAJVEBjmOQGZ=-OiOAQ@mail.gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 8:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Jun 20, 2023 at 11:37=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Most perf commands want to sort symbols by name and this is done via
> > an invasive rbtree that on 64-bit systems costs 24 bytes. Sorting the
> > symbols in a DSO by name is optional and not done by default, however,
> > if sorting is requested the 24 bytes is allocated for every
> > symbol.
> >
> > This change removes the rbtree and uses a sorted array of symbol
> > pointers instead (costing 8 bytes per symbol). As the array is created
> > on demand then there are further memory savings. The complexity of
> > sorting the array and using the rbtree are the same.
> >
> > To support going to the next symbol, the index of the current symbol
> > needs to be passed around as a pair with the current symbol. This
> > requires some API changes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > v2. map__find_symbol_by_name_idx so that map__find_symbol_by_name
> >     doesn't need an optional parameter. Separate out
> >     symbol_conf.sort_by_name removal.
> > ---
>
> [SNIP]
> >  void dso__sort_by_name(struct dso *dso)
> >  {
> > -       dso__set_sorted_by_name(dso);
> > -       return symbols__sort_by_name(&dso->symbol_names, &dso->symbols)=
;
> > +       mutex_lock(&dso->lock);
> > +       if (!dso__sorted_by_name(dso)) {
> > +               size_t len;
> > +
> > +               dso->symbol_names =3D symbols__sort_by_name(&dso->symbo=
ls, &len);
> > +               if (dso->symbol_names) {
> > +                       dso->symbol_names_len =3D len;
> > +                       dso__set_sorted_by_name(dso);
> > +               }
> > +       }
> > +       mutex_unlock(&dso->lock);
>
> I think this part deserves a separate commit.

Using the mutex or the use of sorted_by_name?

Thanks,
Ian

> Thanks,
> Namhyung
