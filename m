Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BE873CD76
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFXXkd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 19:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFXXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:40:31 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED0B10F4;
        Sat, 24 Jun 2023 16:40:30 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-780d6e6b037so67617439f.3;
        Sat, 24 Jun 2023 16:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687650029; x=1690242029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RhwsWDmvx6SzMByyuYvUpq+XDWKDalDEbcfDL0veNQ=;
        b=ENupoQPqr3m07xkznz4oJ3hpHziwo9C8jD1rEVK/dMMMVM+D1xlsf4aLHhD1OHAKFe
         6f0Whu7FAqGHVzOr9jZDdoTI3H3n+0BLj3v5lyMvc39SJzwxXAHB5PrOD6/u7ntbEULm
         3KEpS4+fx+exiZniF8eFZ+oXJz/Q0vfVva7WpShKLts4Zd7P3IaeIOZzNeZ3kdrcRwep
         KJ1TGSDOKa0IpM4CH/oAUBn1QAYfuwSUJq+RdbrFR4/28cB0IydCr2gz8QLdFS3hnsKs
         4AGYpmEy3hNer+kK47sxGuftQ+m22SVjU42z0mAkkhU8OlL5eyudaUvT3SyAS6hhpF2h
         aEug==
X-Gm-Message-State: AC+VfDzUnzbuFk8Ox3gTETN5EsQx1tV2LTrFzh4HoiURpVWy9NQj+kMD
        RybNm8fK78gl+eBxyqAyNHNSLU9uj9KgX/sirxchjQqgQGoB+g==
X-Google-Smtp-Source: ACHHUZ5g3TBiclFkLRFubwe+D8GBodkdKxix4YwOEXXorv8NsalMFxvjUL4InD1CunZSQwXnAn8eptqwVP2v88mhDZ4=
X-Received: by 2002:a6b:fe0a:0:b0:774:8f64:82a8 with SMTP id
 x10-20020a6bfe0a000000b007748f6482a8mr17203376ioh.18.1687650028244; Sat, 24
 Jun 2023 16:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230623041405.4039475-1-irogers@google.com> <CAM9d7ch9MfCS02+-4FRDvrDVDK+f8qtqYr5m0abegg9PXJncHQ@mail.gmail.com>
In-Reply-To: <CAM9d7ch9MfCS02+-4FRDvrDVDK+f8qtqYr5m0abegg9PXJncHQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Jun 2023 16:40:15 -0700
Message-ID: <CAM9d7cj6WO-PVpis5361RBc6HXPExq+mCdPKo1Y2m8wtSsLN8w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Bring back vmlinux.h generation
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

On Fri, Jun 23, 2023 at 5:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, Jun 22, 2023 at 9:14 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> > satisfy libbpf 'runqueue' type verification") inadvertently created a
> > declaration of 'struct rq' that conflicted with a generated
> > vmlinux.h's:
> >
> > ```
> > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> > struct rq {};
> >        ^
> > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
> > struct rq {
> >        ^
> > 1 error generated.
> > ```
> >
> > Fix the issue by moving the declaration to vmlinux.h. So this can't
> > happen again, bring back build support for generating vmlinux.h then
> > add build tests.
> >
> > v4. Rebase and add Namhyung and Jiri's acked-by.
> > v3. Address Namhyung's comments on filtering ELF files with readelf.
> > v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
> >     filter out kernels that lack a .BTF section and cause the build to
> >     break.
> >
> > Ian Rogers (4):
> >   perf build: Add ability to build with a generated vmlinux.h
> >   perf bpf: Move the declaration of struct rq
> >   perf test: Add build tests for BUILD_BPF_SKEL
> >   perf build: Filter out BTF sources without a .BTF section
>
> Thanks,  I'll take them with the following change.

Applied to perf-tools-next with it, thanks!
