Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2B622034
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKHXQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKHXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:16:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4A1ADA7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:16:16 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so23257345wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o6bbEVkp/O+6HFBPQrcPCeDrxXI7++0ZLl8zYzUmUHM=;
        b=Ei6BncYhV7jPMWsfnUvXvoN1cQzVOrERH3xmvYSdqOjTjsEKwUA/JKPZqLCiHD9uvh
         mR1/quI0l6SKPQc6aa+ZYv9jM2FUgaNXeN7MnXOOp6HqT7I2dgAqYctcqQQ+DwCG69qo
         e/R70p2aoxRAITBvw3NzrWfn2/Bm/Uhh/0zddIV7oul3dmM9iUrI8XysszGqwPVsaq8i
         Bhf9/5Y4Bra5+07VBR4sb55TTawMazg02qZIp+nBy8PeNwBZsmsOT9gAwU2HYGocl1l3
         KNNdCqRJIHw7mY8poaZYgmh7iN1Xa+Q2/vCZUIn1obYIG6/PL18j614Xv/s5JyFb3UfN
         qpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6bbEVkp/O+6HFBPQrcPCeDrxXI7++0ZLl8zYzUmUHM=;
        b=hEciL0N4eO67KOXqoc+88DgS/BomWo3CxL7TDOOtnFQKebdUQeNGsxqR7P9jUCBD7E
         LaCGG9fyP9U2iaVhSgtglpBo6QaUJh4tzfOUeJjdt7DZ7EK5JixeDIr9sYpZ0YbR9KlV
         8nW0WlPh26XdgpnVAYDtPHsPhJS+aXbCmP3s3TcQA2K7KTOM5PWv41NFTaxxUMpZsOnZ
         rTSty95pR/7WEpv5WW/vyvxgwW1eCbAIvg2mzo5ukIoEcSMfKnm+G+BQbnVeMSbekxdQ
         P8uCqDOom51itPatE2GTxcqlQfoGGN43ieScogZ1ofricMTkbKMI3mlJH8zSmahRgk9S
         as1A==
X-Gm-Message-State: ACrzQf0SiXvzCGIsUNTblb9TKEqpQ/ydEtGoMBWoilr9KoZ10ZTZpcwm
        GJHMlbLIWsj38L28bI3HggqUWZKCfuxifF+eQ4iCPvUbj9U=
X-Google-Smtp-Source: AMsMyM7/dic9/JyfUZsBFtA+TVNm7iuSTlgQA63H+lcm7Cyf1EqEGKz313B+P6eYpjNVycKyB4IaETcGY5BjeXP0We8=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr36320076wrb.300.1667949374614; Tue, 08
 Nov 2022 15:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-4-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:16:02 -0800
Message-ID: <CAP-5=fWXAjWd-dbVXCVfRzP9iw5RzXo+cPWWPpOmTw-1xBECqg@mail.gmail.com>
Subject: Re: [PATCH 3/9] perf stat: Clear screen only if output file is a tty
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
> The --interval-clear option makes perf stat to clear the terminal at
> each interval.  But it doesn't need to clear the screen when it saves
> to a file.

Would it be more intuitive to warn if interval-clear is specified with a file?

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 17d656566cd9..d4936a502560 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -892,7 +892,7 @@ static void print_interval(struct perf_stat_config *config,
>         FILE *output = config->output;
>         static int num_print_interval;
>
> -       if (config->interval_clear)
> +       if (config->interval_clear && isatty(fileno(output)))
>                 puts(CONSOLE_CLEAR);
>
>         if (!config->iostat_run && !config->json_output)
> --
> 2.38.1.431.g37b22c650d-goog
>
