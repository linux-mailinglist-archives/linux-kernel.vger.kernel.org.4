Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA362204D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKHXZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKHXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:24:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285165E9EE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:23:47 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 187-20020a1c02c4000000b003cf9c3f3b80so185380wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYzYIHx1Op6tzMYXV1iOaDxLub/Ky2q3uqnqfSLOYNQ=;
        b=ZkHCkbkWnyL6p+AGwP+Z56AIV1BIFP0S7wVkLSIv6XwezdkX6vnGaTrhPXr1yqLkRj
         0pED4Kn3zKtghU1jCryiITatYJ/rE2SowM6M8BPJwiqi0FJb3qXBcNtgBiXsOLTlqtW6
         t2ONRwPwMems+fqLoLgAikay1XZdfKI6fJq3czM0aXDHbPdB/KihMCmsEHOl9/s4D4a5
         lB0mh/uZeTcc46ArxsZZO7/7hyKr0KyPC7LT8PJJFFH1rxhHtVb6y51rRqSedNXqQGmN
         2Jx/BmV3DK0BxlRXfATZ0y3+h2slZZQGpHSn1QWGMgFszL25UsQlIibPsIfs58ROuXIZ
         AkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYzYIHx1Op6tzMYXV1iOaDxLub/Ky2q3uqnqfSLOYNQ=;
        b=okX+PRxZHhq7FuLgEf9EkRs7MzumjdktyQmm/42piJNxMOHHYrR1ENOuy8KxbwSKCn
         VKTpXBNmW2ptuIJiU9xm44QVK7XZvEQ7RwB0PXo6mRPCTcRci9iuVgvWZNQ9jBABsace
         DZmovB9sFVov8CifIrDmYa8tEoYxp81wissZg0SuSWmCLk1Sy4yrWddTSoG4mN0EIwil
         n7Fk/nkWbBy6zZhWZT1tyA1GzwU2DVzT1RZLIQDIpwNTQMOUUKOEzSas2VnsoLBwl3UY
         x+UItWJ5dpwxwdZqjIt6B+2Pv4amFV63FGqdc/1KJzal8iNSwHcN/DNF96Hz2hMosJ6f
         isLg==
X-Gm-Message-State: ANoB5pnM+2SxwIEqVKHYfYd7yDH/l+LJcL6CDl1o5OE06liEa/38iWJy
        D5Mo6FfK6i1QYGZ0QaONjMg/c7L9nht8nDQRuSN5uw==
X-Google-Smtp-Source: AA0mqf4egsVftnJH6GjOe3fMxvtPPnq+8LeaHikbJMGonz6uaHDuvXImRXfoNTogl+49/1QhyGUaInQOE74bsYVM44k=
X-Received: by 2002:a05:600c:3ba1:b0:3cf:a511:320c with SMTP id
 n33-20020a05600c3ba100b003cfa511320cmr11282515wms.182.1667949826008; Tue, 08
 Nov 2022 15:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-10-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-10-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:23:34 -0800
Message-ID: <CAP-5=fU+Xeqt6sn5ESkNnCHQNTYjbrv-qiZBpbtMRu3ayGL7pA@mail.gmail.com>
Subject: Re: [PATCH 9/9] perf stat: Consolidate condition to print metrics
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The pm variable holds an appropriate function to print metrics for CSV
> anf JSON already.  So we can combine the if statement to simplify the
> code a little bit.  This also matches to the above condition for non-CSV
> and non-JSON case.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index a10af26c26ab..4d3999673dde 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -600,9 +600,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                         pm(config, &os, NULL, NULL, "", 0);
>                 print_noise(config, counter, noise);
>                 print_running(config, run, ena);
> -               if (config->csv_output)
> -                       pm(config, &os, NULL, NULL, "", 0);
> -               else if (config->json_output)
> +               if (config->csv_output || config->json_output)
>                         pm(config, &os, NULL, NULL, "", 0);
>                 return;
>         }
> --
> 2.38.1.431.g37b22c650d-goog
>
