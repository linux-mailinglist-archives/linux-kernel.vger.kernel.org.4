Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232EE73781E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFUAOu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 20:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUAOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:14:48 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4BA1728;
        Tue, 20 Jun 2023 17:14:48 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-be49e41a3d6so4001721276.1;
        Tue, 20 Jun 2023 17:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687306487; x=1689898487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdaemvy4g+Ow1TCPlIj5575MvTTVkMVKcieHGjAGxiQ=;
        b=gnoPwNjJCuQ03JYVjTXmhrFpkO5Vs6U5NH8OzuWlmDLQfxQJtfkpq9Rn2Sc9TaR31C
         zsG0g16fbSaAkQKXGaKnPK04t2kRGqC0i/Uf/hnb3mGB+vR+HP3uIxVfcNfGiNc9a0b8
         hEQOj4wnwfCD+qcKwYRkcs7aeJmchsEKTRjQ2ekmr9y+NDGZqHIW1ElQi8H0F2mpou7y
         ukUm/dRH68eLdTFYo6AiV6Fj8VG4+l51a+BcI6wIncKIiI4ij55H8tvT9u4mQdWy7flB
         2IySouyn6mu+QqiF7XiCANgbO9dv7ykdW+lRbiv/CVJMwYnsLLgD1JzqTF/pjMYvnE0j
         J+BQ==
X-Gm-Message-State: AC+VfDy7USqRa4XbRxBQ8NcdY8okOjAFrLxCUTDp39SenBRXCAAhKTjb
        9BytcWzVn4yyhBGhpw8S4diTF5QAg3yOjMzEnNVf9W+V
X-Google-Smtp-Source: ACHHUZ7FJc5uQkKWVzSJpK94FSSY3e/H3R3f17lt1f7kIG9M9ORtS1gGKg03JDx9EHnCR4dzXX3SpCaOAZPxNMxX1r8=
X-Received: by 2002:a25:9289:0:b0:bc3:cc17:6250 with SMTP id
 y9-20020a259289000000b00bc3cc176250mr4068812ybl.1.1687306487063; Tue, 20 Jun
 2023 17:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230615200843.2459645-1-irogers@google.com> <CAM9d7cg2RbasQLHVzhBjJbpLnx7Sf79PQQuNTdWRuH+mbp9Y5A@mail.gmail.com>
 <CAP-5=fW5ET9S=bOA2RX0YNds+V-B5VUeYC_AB-bFr9DHKKnvjQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW5ET9S=bOA2RX0YNds+V-B5VUeYC_AB-bFr9DHKKnvjQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 17:14:35 -0700
Message-ID: <CAM9d7chMS5b=CUSAZS7g8-GO09sf578nx6yUJH7_niqwux8jYw@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Remove symbol_name_rb_node
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

On Tue, Jun 20, 2023 at 3:55 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Jun 20, 2023 at 2:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Jun 15, 2023 at 1:08 PM Ian Rogers <irogers@google.com> wrote:
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
> >
> > Nice, I like the savings and lazy allocation.
> >
> > >
> > > To support going to the next symbol, the index of the current symbol
> > > needs to be passed around as a pair with the current symbol. This
> > > requires some API changes.
> >
> > But I'm not sure if we need the index for the normal use cases.
> > IIUC only one place to require it: map__for_each_symbol_by_name.
> > Maybe we can have a separate API for it?
> >
> > In general, I'd like to split the commit to have on-demand part and
> > array changes separately.
>
> Thanks Namhyung! The current code is on-demand but the space for the
> rbnode must be reserved in the symbol_name_rb_node. We could on-demand
> resize symbols, but I don't think it makes sense.

Ok, but I think we can split the symbol_conf changes at least.

>
> If the worry is the patch set size, maybe as you suggest, we keep
> find_symbol_by_name to not take the optional index output parameter
> and introduce a find_symbol_by_name_idx function that takes a required
> index parameter. If that's good I'll send a v2.

Right, the patch size is a concern.  But IIUC the find-by-name API
has two different use cases.  So better splitting them for clarity.

Thanks,
Namhyung
