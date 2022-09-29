Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373425EFCF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiI2SW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI2SWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:22:53 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D24B13F2A3;
        Thu, 29 Sep 2022 11:22:53 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-131ea99262dso501063fac.9;
        Thu, 29 Sep 2022 11:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E06RJjVJwDfsRCMJJzAUnTq8HdXAS/JGLEHu5WJqKFE=;
        b=yXjb9jFr1o/d6yulUSLfjPfpVKPg8trlSbxg2GduH6UdgfdgWzXkoz9MLgsvbk/Z/f
         fgCwd1UgN4WspcoBtkFneKTyYiBcUVLT0jT6cIf6wBhOpbv0LOr6tiblWbO3ubBvtpGB
         35crnaUIHjpbBbOtRq52HcFjDC0hrMAqRjOpzmAlyzZWdWEUSZAjK87J+24hSIGgDtxQ
         0yYA5gaHHfi/Z2HEkdNCbPDUMIvWmPqjwWT1WF1nmpOfRV3lQHaXfwMIsHOxo1iKK6J5
         JYCbnsO3ofwsRYayGZYnlN0ese4xnyhhLH/TxTd8hf+LcD2J7csUFv9EBnM6MnvRiIk/
         W4qg==
X-Gm-Message-State: ACrzQf1H4jkcYOJYru8LjgGJa5eEUbBj0081289ZlXu2x2dnCl/TbSt5
        RLiInPmXE4IqmvcD3wHnoNJz/o4J1hgKatmMkyk=
X-Google-Smtp-Source: AMsMyM4+KvMwRAMqNfEGLoZVtQg8gfar61sl6HksSa62MA+8HQ7KxZRllxzLOoOlllo71Z7Ygfjn5xMFasVa9dWt3oE=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr2667179oam.218.1664475772506; Thu, 29
 Sep 2022 11:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220929140514.226807-1-jolsa@kernel.org> <YzXdjNNh+jbYDnYz@kernel.org>
In-Reply-To: <YzXdjNNh+jbYDnYz@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Sep 2022 11:22:41 -0700
Message-ID: <CAM9d7cia_Hsqsj=J4rSM68TQADMAt=at5SWRMYTGv4FJxNGpTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Fix bison object compilation with clang 15
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:01 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Sep 29, 2022 at 04:05:13PM +0200, Jiri Olsa escreveu:
> > Arnaldo reported compilation fail with clang 15:
> >
> >     CC      util/parse-events-bison.o
> >   util/parse-events-bison.c:1401:9: error: variable 'parse_events_nerrs'
> >   set but not used [-Werror,-Wunused-but-set-variable]
> >       int yynerrs = 0;
> >         ^
> >   util/parse-events-bison.c:72:25: note: expanded from macro 'yynerrs'
> >   #define yynerrs         parse_events_nerrs
> >                         ^
> >   1 error generated.
> >
> > Disabling -Wunused-but-set-variable check for bison object compilation.
>
> So we have to disable something else:
>
>   37    44.92 fedora:32                     : FAIL clang version 10.0.1 (Fedora 10.0.1-3.fc32)
>     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
>   38    61.77 fedora:33                     : FAIL clang version 11.0.0 (Fedora 11.0.0-3.fc33)
>     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
>   39    66.59 fedora:34                     : FAIL clang version 12.0.1 (Fedora 12.0.1-1.fc34)
>     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
>
>
> I'll try yours + -Wno-unknown-warning-option

Is `-Wno-unknown-warning-option` known to older versions? ;-)

Thanks,
Namhyung
