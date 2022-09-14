Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068025B88DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiINNMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiINNMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:12:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755994F3A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:12:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so34668957ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ib5mswjR1x7cIBGgOeaYy3ofTlgkjtf1YQmH317wwYc=;
        b=EyGvls+PPR5gSq51ImovQ9Aykw+f1UwYvKrRnvXUiUMLmdsoj3OZKautZPAbv6yI4S
         c05fPCDH/izs82miJZsc7xYU6USh/RTsgrfHyuphN64PJYH3IwytNrBNkVgofyZ4MDix
         +DVuyNg81rdHSCkfrAzOD4MJbUQ6lT2C4FvAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ib5mswjR1x7cIBGgOeaYy3ofTlgkjtf1YQmH317wwYc=;
        b=DFquBvawVJJ2zJjBxl2BAzars3Nz5jTS5NF4dhPFQ3CpS400/ZGwl3OIsusvjbBBpC
         ov+xrz+Tm0nZb2zscPwfGOhfIm5qQbmumdvjGvWeMHEsFZKz8wLNX936LMvwqg9K+J0J
         sY2i+mY9x7j0CKBKrDBge51qBiBGWqTbX6DGrpFhb6WnOlcNVTrAkHFGrX3SRC3uKQCi
         DUHKLbcIyCU0aO1MzrJvhQJi8MUeIzZZX3aSGDmO6Ij5r+m6hH+SKN4xaqUshnZuDltV
         xmC4arCNfRIpqeFbAF4jX1e840X7L1GkezMR7NOK4CXOnFMHvUNEoYR0mQcbm6daFpZy
         G7jg==
X-Gm-Message-State: ACgBeo1qwtFhnlRtjzarvh2M4tmzLJzs1uHTRqHaINQNaHwvd4fJ8Ffh
        Ruq2SdTutCCmT6uY5lum/Fh71bLYzq52Y9aSiWa3jw==
X-Google-Smtp-Source: AA6agR7HbQRqYLgqzMyg41PD/aaS4tbp5xqGmUix+XS3s2ihXKF7L99Xf7M2vZLQ4r9NymjcYSMHaJ+RBBpZ6aWhRRE=
X-Received: by 2002:a17:907:c23:b0:779:237a:4218 with SMTP id
 ga35-20020a1709070c2300b00779237a4218mr19917347ejc.277.1663161159807; Wed, 14
 Sep 2022 06:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220914122429.8770-1-adrian.hunter@intel.com>
In-Reply-To: <20220914122429.8770-1-adrian.hunter@intel.com>
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Wed, 14 Sep 2022 14:12:29 +0100
Message-ID: <CA+wXwBRN3kJLVxVupLLXTBC_GbSzvmDch4ry2jWW2aqZXJgp2w@mail.gmail.com>
Subject: Re: [PATCH] perf kcore_copy: Do not check /proc/modules is unchanged
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 1:24 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
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
Thanks Adrian,

Tested-by: Daniel Dao <dqminh@cloudflare.com>
