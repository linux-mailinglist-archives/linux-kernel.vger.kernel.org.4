Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878C268602A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjBAHCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBAHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:02:03 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CCC5D11B;
        Tue, 31 Jan 2023 23:01:19 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id t18so16340701wro.1;
        Tue, 31 Jan 2023 23:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8STmvBfPr23bdzh45qdAmwOg/RvjxSEAXZUe6gbnfdg=;
        b=DLN+lN9hEQqBsreGEeaD2noU9Sh5faSj39UDPYj3mnwcYYeh4lAtDLCiRqvPHu8jvG
         lDSXBW4Xq3f/LBH7vZUqqr5hluwL6Qui5pMwzzVCB+Og3NG/3C07myMm21Alf7QhZeYU
         e/BeQ1ZuusDa1bqbbPAU+zdiWd9LLNwt6M8Dqp7ZR1vn8SXwcB6+X/9SQrBLK/3HA73T
         3ElY5/PNPEB35wdCX+Xsuq4qgU9q2JLSr1fKRVldvyAJtzaNYO/Wf/fEW6CVfXZDdw4w
         ZBeNw6IjLS7CHY67SMAKsOHfGNaF/J9uo/XyqeCdH3qxsHFhHtSC1+h6yeDMH3ntXk4E
         ttOA==
X-Gm-Message-State: AO0yUKW134RlR8EaxQ9+4x5xqDFgO6ipD0sUJVULH7ToaF8NNXQqbrom
        pTiOjCyFBH1hUB6FNwkf2EdzUotpgx7UlJVmzXk=
X-Google-Smtp-Source: AK7set9ha0vI1s+wyzZ/CbTUcR6jsT9KVSBTGwIysIY49wyhVDaC7wOffM9vODDPGOXvyIrmAW4rcodNeGP9KteB1iE=
X-Received: by 2002:adf:db8e:0:b0:2be:5372:20f5 with SMTP id
 u14-20020adfdb8e000000b002be537220f5mr48726wri.101.1675234808508; Tue, 31 Jan
 2023 23:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20230131131625.6964-1-adrian.hunter@intel.com>
In-Reply-To: <20230131131625.6964-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 31 Jan 2023 22:59:58 -0800
Message-ID: <CAM9d7cj=8YQEnaqwxNpvPjPpcF2d0cyvb=jq6fM20U0de5tO+w@mail.gmail.com>
Subject: Re: [PATCH V2 0/9] perf symbols: Improve dso__synthesize_plt_symbols()
 for x86
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Hi Adrian,

On Tue, Jan 31, 2023 at 5:16 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> This is version 2 of the second of 2 patchsets to improve
> dso__synthesize_plt_symbols().
> This patchset focuses on getting rid of unknown symbols that show up in
> Intel PT traces.
>
> x86 has 2 more plt's, namely .plt.sec and .plt.got, so support is added for
> synthesizing symbols for them.  Special handing is needed for IFUNC symbols,
> and it is also possible to have a .plt for static executables, so support is
> added for that.
>
>
> Changes in V2:
>
>     perf symbols: Add support for x86 .plt.sec
>         Amend commit message and example about -z plt
>
>     perf symbols: Get symbols for .plt.got for x86-64
>         Fix get_plt_got_name() not to segfault with EM_386
>
>
> Adrian Hunter (9):
>       perf symbols: Correct plt entry sizes for x86
>       perf symbols: Add support for x86 .plt.sec
>       perf symbols: Sort plt relocations for x86
>       perf symbols: Record whether a symbol is an alias for an IFUNC symbol
>       perf symbols: Add support for IFUNC symbols for x86_64
>       perf symbols: Allow for .plt without header
>       perf symbols: Allow for static executables with .plt
>       perf symbols: Start adding support for .plt.got for x86
>       perf symbols: Get symbols for .plt.got for x86-64

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/util/symbol-elf.c | 365 ++++++++++++++++++++++++++++++++++++++++---
>  tools/perf/util/symbol.c     |   4 +
>  tools/perf/util/symbol.h     |   2 +
>  tools/perf/util/symsrc.h     |   1 +
>  4 files changed, 350 insertions(+), 22 deletions(-)
>
>
> Regards
> Adrian
