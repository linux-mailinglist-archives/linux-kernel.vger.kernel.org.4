Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43B73C6CD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 06:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjFXEmk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 00:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXEme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 00:42:34 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3B272A;
        Fri, 23 Jun 2023 21:42:33 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bfee679b7efso1236366276.0;
        Fri, 23 Jun 2023 21:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687581752; x=1690173752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Tv5ByRnQQhhggbvCJr723rJIzg87T8KQ+iXR0Dgcjo=;
        b=hU2Jj1rnmW5pvtHnzwU509/kwKPaX7NG0dpp7J9IZFuCdkf7wMH+iNV1ibVzqaDmrD
         b0u63vjEg+gKajyuTD3/4RmpPNZES6DLZKsrsBQzp44I+KG47yPm5x+9VJtee33LkJTU
         PlS9y+t7+P4AYwAdbCoY/mFy7lxghvlVg7ydd8QjV2dQ/zNFccqMS1PcCXNw57h68UsU
         NDLnn4WFkmkaSeZbiAcHLNcJ7gGdr+RuA6e/BQ6/Ug+NGcZzFLH2DnQh5olTSOTsXufk
         kwQAAHUuLrh9uH21clUIdUVaJ2UaLn23dfZGtSTkN/dOK10T9+9RvK7n+xcfV/W4v+D1
         sHyQ==
X-Gm-Message-State: AC+VfDxrw4mWssc0yOIDyAXuP7vRJuh5fm2RBPYVaVQnGoUpCcZyp+RE
        6Ti+ZyxB0YubU8a83RJwB9ISJDmPAynSxo1Pj3M=
X-Google-Smtp-Source: ACHHUZ6qxoESbPdBUUNaOdqSRaNdYzQRZlGQYnFcJUvH14u+6U1ACmqw4PR8SlDinMukdcSHykpS7iUX5DdKB250YXo=
X-Received: by 2002:a25:ac43:0:b0:bc4:41ce:c633 with SMTP id
 r3-20020a25ac43000000b00bc441cec633mr18437278ybd.31.1687581752560; Fri, 23
 Jun 2023 21:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230623054520.4118442-1-irogers@google.com>
In-Reply-To: <20230623054520.4118442-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 21:42:20 -0700
Message-ID: <CAM9d7ciLAUc+0pxeLU91RCxi-oWmV5q=Nb0BQ_tP_4U=PGCtmA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove symbol_name_rb_node
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

On Thu, Jun 22, 2023 at 10:45 PM Ian Rogers <irogers@google.com> wrote:
>
> Use a sorted array of symbol pointers to avoid the potentially
> unnecessary 3 pointers (rb_node) for the name sorted symbols. Saves
> been 24 and 16 bytes per symbol.
>
> v3. Move sort by name dso lock into its own patch.
> v2. map__find_symbol_by_name_idx so that map__find_symbol_by_name
>     doesn't need an optional parameter. Separate out
>     symbol_conf.sort_by_name removal.
>
> Ian Rogers (3):
>   perf dso: Sort symbols under lock
>   perf symbol: Remove symbol_name_rb_node
>   perf symbol_conf: Remove now unused sort_by_name

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/builtin-kallsyms.c    |   1 -
>  tools/perf/builtin-lock.c        |   2 -
>  tools/perf/builtin-report.c      |   1 -
>  tools/perf/tests/builtin-test.c  |   1 -
>  tools/perf/util/dso.c            |   7 +-
>  tools/perf/util/dso.h            |   3 +-
>  tools/perf/util/map.c            |  14 +++-
>  tools/perf/util/map.h            |  12 +--
>  tools/perf/util/probe-event.c    |  16 ++--
>  tools/perf/util/symbol.c         | 131 ++++++++++++++++---------------
>  tools/perf/util/symbol.h         |  12 +--
>  tools/perf/util/symbol_conf.h    |   1 -
>  tools/perf/util/symbol_fprintf.c |  10 +--
>  13 files changed, 106 insertions(+), 105 deletions(-)
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
