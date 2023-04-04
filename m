Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2176D6AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjDDRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjDDRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:36:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFCD49D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:35:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3e390e23f83so144291cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680629741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcdTIvf1ol3LOKzrQoRhCMtc6+U0OZw7eVy/3P4JBok=;
        b=HpHCjIi2abLI3b7CjtQLNY3/4JDrR8/bMlkvvpuCp3TS/Bd671GsM4/z4LppQsdhHz
         Lb+tsYVM2v7Q9EubDqOK3jLJCRPNbVVKIhUgP/1U9RjGgffd9uud/llg3NTQgQBY4lD6
         1MKPUOaQjieI1pqInfYb3evmz64Hgt19Q9juC03REmYu0dwF7aKoRd/I6rMAhyY2PSN3
         PmQLI/H29tI7I+h90M3X30hdrhVX7fv00DlycG1PT51nN0gfAxeSwL3Ri1v7VZts08JJ
         c4SLSVdHNGy7N/O+p22ixzorAsEhuz95AOa3cqxWDhjo058Aw+ozSIkAvfaFe5RsHuhP
         sgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680629741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcdTIvf1ol3LOKzrQoRhCMtc6+U0OZw7eVy/3P4JBok=;
        b=4zOM4GD7K9YUMAoLo//ZEdOps+lN1OwsyARX6GBEcJZ4zgDu5tgSbGkluC6pJv2Hcf
         oOlVK4AoA9JVe3mltwyYjO8i5BSt2EfEwWxFFFlsOLCYIwvgvj5A4CMwauGYZA/7+chD
         IoRzolX9shL4h3kMf0/M+kDk0NrkfPO790dCJi9+V73RoO0z3iFuo2icaItGegoZpQIS
         Pgh4i93zHNNqsN/qO7PQlKE4EnqKW0nyISod2fY7V1sINFHO5+M2xrCjRXuUMSBizicj
         xKsuYk/gxKA+CuxoMojO/Dj6Jkya/ErfqizBOsgcRaDbO8ph965mPkxONu2gjR9O/pgR
         qGyQ==
X-Gm-Message-State: AAQBX9fXJp+8U1sUv7BIYnHJELrxU4XvlEx3spedUwANZEkcfiRXjNES
        E88P5v//5UveMOC1G5OeYRgay+ZPcnoI5D1HmDEsTg==
X-Google-Smtp-Source: AKy350YCvemBsrW0G/0og46bba+S5pe6mMWOlg/kbyy3/gd2ZKrX0ESS7v+XyJsScmMXcOhYhiZ3/vxbPTyTxcUAn5w=
X-Received: by 2002:a05:622a:1a8e:b0:3d3:3cc:6f70 with SMTP id
 s14-20020a05622a1a8e00b003d303cc6f70mr400595qtc.17.1680629740578; Tue, 04 Apr
 2023 10:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com> <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
In-Reply-To: <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Apr 2023 10:35:27 -0700
Message-ID: <CAP-5=fUvCYHLaecCKMnFwMEcbqj=UcfgHSKAtmYEtk+sJT26nQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 10:26=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 4/04/23 18:58, Ian Rogers wrote:
> > Ping. It would be nice to have this landed or at least the first 10
> > patches that refactor the map API and are the bulk of the
> > lines-of-code changed. Having those landed would make it easier to
> > rebase in the future, but I also think the whole series is ready to
> > go.
>
> I was wondering if the handling of dynamic data like struct map makes
> any sense at present.  Perhaps someone can reassure me.
>
> A struct map can be updated when an MMAP event is processed.  So it
> seems like anything racing with event processing is already broken, and
> reference counting / locking cannot help - unless there is also
> copy-on-write (which there isn't at present)?
>
> For struct maps, referencing it while simultaneously processing
> events seems to make even less sense?

Agreed. The point of this work isn't to reimplement the maps/map APIs
but to add a layer of reference count checking. A refactor to change
the implementation without reference counts can delete the reference
count checking and I think that is great! I'm trying to get the code
base, in its current shape, to be more correct guided by sanitizers.
Unfortunately the sanitizers come from a C++ RAII world where
maintaining reference counts is somewhat trivial, we have to work
harder as done here.

A similar thing to refactoring maps is changing symbol. The rb_node
there accounts for 3*8 bytes of pointer, but is just to sort the
symbol by address. A sorted array would suffice as well complexity
wise, freeing 16-bytes per symbol, and is already done for symbols
sorted by name.

Thanks,
Ian
