Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B2F73AFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFWFCR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 01:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFWFCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:02:15 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC37E4B;
        Thu, 22 Jun 2023 22:02:12 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so211427276.3;
        Thu, 22 Jun 2023 22:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687496532; x=1690088532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lbYvnRG7m7BdPVBK4RGAv7DA18uMbVSHdxUyBaBHkc=;
        b=eKMEtxuG++jUx3UjilDm/wbGYewuEPxhmOauXLayCsxA2gVmoZx0Z7KnWTu7Afwyqo
         B3IryYuZcQt2ZXIa6TltkpM0zkQVK1vaoByWhP52cFk5EhqdBNgm3Fv1X2qTtm0f2dXB
         BeF1cz3zuSlPk8gnH3u/SkB6hM2gxwKTr5XwIXoKi3NXFdC0fqdAoHoV1d/dIOdXqJfi
         IBqQJ8SlC+PB+hWECIxVkQmn/Ksa4qIL1jYhUtorGwVUvwkyKoMQMrn9AEI/Z7KUmZcu
         v2+K9BcE6tG/ROqsKiIKGXuRFrR1BBlJ5sxoteyP/RMw1Vv/H3uaz3AoDtdeYMim7M2p
         svZA==
X-Gm-Message-State: AC+VfDzvicyzbaK9IeRgerBS5/WaYqf7vDTSEQ8UhNmRevrCbA09mvUA
        pqjkPytxmYU0vXDMwKlGZ2YfXq75U4gx1yppQ3g=
X-Google-Smtp-Source: ACHHUZ6Jvx1MXttMGAHUtbiTSGNCYk5AuiSj+eSNJj2TOLtRAYIMaxfyU8aVJiX8LxbQN8O2IlW2DwyLtz4Md0o0eI0=
X-Received: by 2002:a25:5f4d:0:b0:bcb:caf8:7aae with SMTP id
 h13-20020a255f4d000000b00bcbcaf87aaemr16378378ybm.44.1687496531735; Thu, 22
 Jun 2023 22:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230623043107.4077510-1-irogers@google.com>
In-Reply-To: <20230623043107.4077510-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 22:01:59 -0700
Message-ID: <CAM9d7cj_TAQb5phBmo1R5OSS-DGQimszqb8PhQqoFYjw6sRgaA@mail.gmail.com>
Subject: Re: [PATCH v2] perf unwind: Fix map reference counts
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

On Thu, Jun 22, 2023 at 9:31 PM Ian Rogers <irogers@google.com> wrote:
>
> The result of thread__find_map is the map in the passed in
> addr_location. Calling addr_location__exit puts that map and so copies
> need to do a map__get. Add in the corresponding map__puts.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
> v2. Add missing map__put when dso is missing.
> ---
>  tools/perf/util/unwind-libunwind-local.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 36bf5100bad2..ebfde537b99b 100644
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
> @@ -440,8 +441,10 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
>                 return -EINVAL;
>
>         dso = map__dso(map);
> -       if (!dso)
> +       if (!dso) {
> +               map__put(map);
>                 return -EINVAL;
> +       }
>
>         pr_debug("unwind: find_proc_info dso %s\n", dso->name);
>
> @@ -476,11 +479,11 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
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
> @@ -534,12 +537,14 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
>
>         dso = map__dso(map);
>
> -       if (!dso)
> +       if (!dso) {
> +               map__put(map);
>                 return -1;
> +       }
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
