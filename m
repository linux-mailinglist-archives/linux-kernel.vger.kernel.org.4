Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F896F8CDD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjEEXnf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 May 2023 19:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjEEXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:43:33 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E235FD9;
        Fri,  5 May 2023 16:43:32 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-55a8e9e2c53so22879967b3.1;
        Fri, 05 May 2023 16:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683330211; x=1685922211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2x1tn4ecL7a7PZyU0NHPKD9PY3vOquBlEMbobtDzvuM=;
        b=A93/FvJv1FYbG/nolYa/F7ktpbKhtwrzy43ROIM2WvMNzNaYAbTSGlGuo+IMhn+fmu
         exlEo5f6cuWHuMuz6gXO5w90LPDUmdxnEofjFVlAIxYqOZrScKNlqbv3cO688X0UYbL3
         SNbfcjxaIXq8CdThoe6qEoxHOch/WIebJt+7jeHfLveE5Vo6oJkXr6VUbsbgC1XT9tAa
         Zwjj/0tmQ3oMjw0yQ7w7HTIe7xf5/q+aRv+eaXbMxVlVQi6a2O6+xSdQliVR9k4QxQvk
         je7cgkzPi9FwnWQhiWH174rZ+CPCvmoOc/zKc+Yg2/keMEDsV5MBbeIMSjr3Rv0LZSMo
         wLrQ==
X-Gm-Message-State: AC+VfDwodK3gldGpq2IMIGn7Hqkd2A+NlTIvpDhtxSscY3qXcMqamKWl
        3us4X3V5slbPVfcjrJSdpfJ7VmBnD+SoU1yMjPg=
X-Google-Smtp-Source: ACHHUZ5rFc3wS54CsVRG1DPr2zu+nHGMWF8vD1d6hDpwm5zY0I+iBCvVecXDwuNv8KgEQmhzSLgOdWQGiSxuncnDSmA=
X-Received: by 2002:a25:abe5:0:b0:ba1:b539:a39a with SMTP id
 v92-20020a25abe5000000b00ba1b539a39amr3430513ybi.6.1683330211398; Fri, 05 May
 2023 16:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <83d6c6c05c54bf00c5a9df32ac160718efca0c7a.1683280603.git.sandipan.das@amd.com>
In-Reply-To: <83d6c6c05c54bf00c5a9df32ac160718efca0c7a.1683280603.git.sandipan.das@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 May 2023 16:43:20 -0700
Message-ID: <CAM9d7cgZLiRmUDnxW3NpN67Jvgj670FPBkwqncXmDEamYM6n3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf script: Skip aggregation for stat events
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        terrelln@fb.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
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

Hello,

On Fri, May 5, 2023 at 3:03 AM Sandipan Das <sandipan.das@amd.com> wrote:
>
> The script command does not support aggregation modes by itself although
> that can be achieved using post-processing scripts. Because of this, it
> does not allocate memory for aggregated event values.
>
> Upon running perf stat record, the aggregation mode is set in the perf
> data file. If the mode is AGGR_GLOBAL, the aggregated event values are
> accessed and this leads to a segmentation fault since these were never
> allocated to begin with. Set the mode to AGGR_NONE explicitly to avoid
> this.
>
> E.g.
>
>   $ perf stat record -e cycles true
>   $ perf script
>
> Before:
>   Segmentation fault (core dumped)
>
> After:
>   CPU   THREAD             VAL             ENA             RUN            TIME EVENT
>    -1   231919          162831          362069          362069          935289 cycles:u
>
> Fixes: 8b76a3188b85 ("perf stat: Remove unused perf_counts.aggr field")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Cc: stable@vger.kernel.org # v6.2+

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-script.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 006f522d0e7f..c57be48d65bb 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3647,6 +3647,13 @@ static int process_stat_config_event(struct perf_session *session __maybe_unused
>                                      union perf_event *event)
>  {
>         perf_event__read_stat_config(&stat_config, &event->stat_config);
> +
> +       /*
> +        * Aggregation modes are not used since post-processing scripts are
> +        * supposed to take care of such requirements
> +        */
> +       stat_config.aggr_mode = AGGR_NONE;
> +
>         return 0;
>  }
>
> --
> 2.34.1
>
