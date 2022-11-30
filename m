Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9263DE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiK3SdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiK3SdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:33:07 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF63C6D5;
        Wed, 30 Nov 2022 10:33:07 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso2107253wme.5;
        Wed, 30 Nov 2022 10:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHFO1Vh9Yf2ESgFYlacjCmy9NCqybWbhGa/1BkXDPeE=;
        b=yIzvbujaXL6G51fJDK6/WVsdZlckKJWTX9jX1wSDPgA8zGDtAwbMIAtZc/x1yMnx+6
         hjM+OtArzX++ei/tHfg3y3qzp70Egv6DyetQJKEm2FsVELECNRgdt54oiUWR2V3Mqj2C
         SzmRAg3JMA2J0zFoJ4qSvGJGdAyD7K4r/owgbn77uatoeCqZ/mnjRC5qIE+C16W2dgZZ
         LdZb+Bl8WducnEY+HVTAHjgzJCucs6Phpe2dWQ7QAvulhTZ8y5Nc2qY1PKPiNuf7pmxT
         0Wr/nTprxbrxiosKPPS/uXH+7Cr97Arccp8d7YUM54hZUwvA4u4OaAE6fy/pvQ1uifj3
         HC0Q==
X-Gm-Message-State: ANoB5pnWZ8ThmA4HdQIBH6xccTPcprGzhGlAGSbnPjRbZTaKn8ZqUkhm
        xqeUmYbjWoKwUXxs9VqU6A0tf6ve2sR/ZF9PDdE=
X-Google-Smtp-Source: AA0mqf4PYg0wYUZF1TQANN+p9hw4ktMUuJ7Yf2TnJaiwLHvTzwZFg/D7M8ucJ3q56QXaMO5f8uj1YcK58NSk4wwj79o=
X-Received: by 2002:a05:600c:6885:b0:3cf:a80d:59cd with SMTP id
 fn5-20020a05600c688500b003cfa80d59cdmr39440561wmb.5.1669833185626; Wed, 30
 Nov 2022 10:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20221130111521.334152-1-james.clark@arm.com> <20221130111521.334152-2-james.clark@arm.com>
In-Reply-To: <20221130111521.334152-2-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Nov 2022 10:32:54 -0800
Message-ID: <CAM9d7cj0Zrv32CgJ7jSjCY=CsOcF40zC2kxE+NSixG4qZDpXqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf stat: Fix invalid output handle
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 3:15 AM James Clark <james.clark@arm.com> wrote:
>
> In this context, 'os' is already a pointer so the extra dereference
> isn't required. This fixes the following test failure on aarch64:
>
>   $ ./perf test "json output" -vvv
>   92: perf stat JSON output linter                                    :
>   --- start ---
>   Checking json output: no args Test failed for input:
>   ...
>   Fatal error: glibc detected an invalid stdio handle
>   ---- end ----
>   perf stat JSON output linter: FAILED!
>
> Fixes: e7f4da312259 ("perf stat: Pass struct outstate to printout()")
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks for fixing this.  I'm not sure how I missed it.. :(

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 847acdb5dc40..eac5ac3a734c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -741,7 +741,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
>                 perf_stat__print_shadow_stats(config, counter, uval, map_idx,
>                                               &out, &config->metric_events, &rt_stat);
>         } else {
> -               pm(config, &os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
> +               pm(config, os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
>         }
>
>         if (!config->metric_only) {
> --
> 2.25.1
>
