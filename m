Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0A73AC77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFVWXk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 18:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFVWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:23:38 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D451BE7;
        Thu, 22 Jun 2023 15:23:37 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-440b31263f5so2032228137.0;
        Thu, 22 Jun 2023 15:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687472616; x=1690064616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqELWV0ctLE2v1qRE62B46rrBP0uVJy647v7XCR5BuI=;
        b=NAE2sq4iBv6oPwQb0LFotkVjDFDM3Cui6y7vaE+DOICHnoiZ1VhzkmDSSkhvvuomVD
         hQpEwXqzmpnery1OwroJZkSoDbTVepMSONca0g4XhKa/QXkgOOZaseEAyWzKc3t0x+Su
         aaBGz5aWt2K2m/JprD4EkyRwabWKY8GD8xa32km0FhkQmsCrjFoli+YSHws+U/Ua+W38
         UaK/7GErBu7yR5aMv6w/uPVxZ0z6KGvT46Rvti1MsFTkWR2rzf+fnbeQgxwwy8J6o4HF
         fdWopVgdUcj/hHXLhvjGSebRYVgVfhIlZijzjRIwlsHZDrru0NIs/L70jdbvuEb8jJiu
         Y1GQ==
X-Gm-Message-State: AC+VfDxUjL8jXLnFuNCh7b61vvNTBVTII06GZWscbb6n2fcPOaN7NWwg
        KcgFEYAKYQtYWVigAcJN7Cn0JHzFbGUSyAgHz3s=
X-Google-Smtp-Source: ACHHUZ5FMH/hyNsMK3aSQKgCF/Ttwfkosx+nN11MXZp9KlBdm+Qiy88Nix4MlVEuTkwWHexiOGLdTbANqtzlHcm2Sz8=
X-Received: by 2002:a67:fc82:0:b0:440:afe5:ac1b with SMTP id
 x2-20020a67fc82000000b00440afe5ac1bmr6227366vsp.35.1687472615964; Thu, 22 Jun
 2023 15:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230622051029.3733815-1-irogers@google.com>
In-Reply-To: <20230622051029.3733815-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 15:23:24 -0700
Message-ID: <CAM9d7ci_C27tPHWro7Qqa2sVUkkdWSJOMGLzc9irbCnszwtJjg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] perf unwind: Fix map reference counts
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ivan Babrou <ivan@cloudflare.com>,
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

On Wed, Jun 21, 2023 at 10:10 PM Ian Rogers <irogers@google.com> wrote:
>
> The result of thread__find_map is the map in the passed in
> addr_location. Calling addr_location__exit puts that map and so copies
> need to do a map__get. Add in the corresponding map__puts.

It also needs map__put() when map__dso() returns NULL.

Thanks,
Namhyung


>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/unwind-libunwind-local.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 36bf5100bad2..9cb82d7c7dc7 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -419,7 +419,8 @@ static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
>         struct map *ret;
>
>         addr_location__init(&al);
> -       ret = thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
> +       thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
> +       ret = map__get(al.map);
>         addr_location__exit(&al);
>         return ret;
>  }
> @@ -476,11 +477,11 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
>
>                 memset(&di, 0, sizeof(di));
>                 if (dwarf_find_debug_frame(0, &di, ip, base, symfile, start, map__end(map)))
> -                       return dwarf_search_unwind_table(as, ip, &di, pi,
> -                                                        need_unwind_info, arg);
> +                       ret = dwarf_search_unwind_table(as, ip, &di, pi,
> +                                                       need_unwind_info, arg);
>         }
>  #endif
> -
> +       map__put(map);
>         return ret;
>  }
>
> @@ -539,7 +540,7 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
>
>         size = dso__data_read_addr(dso, map, ui->machine,
>                                    addr, (u8 *) data, sizeof(*data));
> -
> +       map__put(map);
>         return !(size == sizeof(*data));
>  }
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
