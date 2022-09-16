Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A15BB1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiIPSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIPSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:02:37 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705DB6D21;
        Fri, 16 Sep 2022 11:02:37 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-127dca21a7dso53147552fac.12;
        Fri, 16 Sep 2022 11:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Suhd8y7qr16vgZ/mrX8LMlHAfVu2gygWJS3j6CdOblY=;
        b=4YVhrgoY9qucGkAYyFE3sEibg0vbL1p7a7spgSgwuWZf2MAYcYQtoDWWSeEUQ0qHqr
         6cb9zq+QwGlUVmRmgHilpUXowVHsDuECszYLIFnz8SqDvURklGSi56wNgvo9NtaLGRvt
         MznoQ1TWKbKx/8t0bqoc6pjLhfpY46G8+lIPgSBIsE9IuwMHXf74IZjUI788FF6h0Sf0
         v49wyGtfSAPeG1djqxkwUWVWLFMYTS/ySUG305XOtAECgrexdoERdpax7ZC15zoWHfB6
         MmX9aBWkCl8wZp3YdRVlK4PfJ1zOiQuEHUz2HHqq8aCGplNzM6G/jNYkN/DV6+9jg78m
         o2kg==
X-Gm-Message-State: ACrzQf0xcnBjNdnv8RxHFgGN673OIYkwwRplISU+m75tLlnSNoVqGL0i
        QaKnOU/+YWISF89tYwvlnV3egRKpy1RC0eSlVw8=
X-Google-Smtp-Source: AMsMyM5uFIknlqd+rJtK0f9cQUwW8kuyFP8xycdbM1zD1YDvpjYh+XwoPZSUOEF6MSpBjBMI1jZpIk2NB8B/x2oAzl4=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr3564175oam.218.1663351356429; Fri, 16
 Sep 2022 11:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220914122429.8770-1-adrian.hunter@intel.com>
In-Reply-To: <20220914122429.8770-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Sep 2022 11:02:25 -0700
Message-ID: <CAM9d7chgWF_iCFeSN0ovoiq=c+JCmD16VVopKzFjjr5En9Eqaw@mail.gmail.com>
Subject: Re: [PATCH] perf kcore_copy: Do not check /proc/modules is unchanged
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Daniel Dao <dqminh@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 5:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> /proc/kallsyms and /proc/modules are compared before and after the copy
> in order to ensure no changes during the copy. However /proc/modules
> also might change due to reference counts changing even though that
> does not make any difference. Any modules loaded or unloaded should be
> visible in changes to kallsyms, so it is not necessary to check
> /proc/modules also anyway.
>
> Remove the comparison checking that /proc/modules is unchanged.
>
> Reported-by: Daniel Dao <dqminh@cloudflare.com>
> Fixes: fc1b691d7651 ("perf buildid-cache: Add ability to add kcore to the cache")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/symbol-elf.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 75bec32d4f57..647b7dff8ef3 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -2102,8 +2102,8 @@ static int kcore_copy__compare_file(const char *from_dir, const char *to_dir,
>   * unusual.  One significant peculiarity is that the mapping (start -> pgoff)
>   * is not the same for the kernel map and the modules map.  That happens because
>   * the data is copied adjacently whereas the original kcore has gaps.  Finally,
> - * kallsyms and modules files are compared with their copies to check that
> - * modules have not been loaded or unloaded while the copies were taking place.
> + * kallsyms file is compared with its copy to check that modules have not been
> + * loaded or unloaded while the copies were taking place.
>   *
>   * Return: %0 on success, %-1 on failure.
>   */
> @@ -2166,9 +2166,6 @@ int kcore_copy(const char *from_dir, const char *to_dir)
>                         goto out_extract_close;
>         }
>
> -       if (kcore_copy__compare_file(from_dir, to_dir, "modules"))
> -               goto out_extract_close;
> -
>         if (kcore_copy__compare_file(from_dir, to_dir, "kallsyms"))
>                 goto out_extract_close;
>
> --
> 2.25.1
>
