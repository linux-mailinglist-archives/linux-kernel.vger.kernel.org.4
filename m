Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315E8628826
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiKNSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbiKNSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:18:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9392DA9B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:17:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z14so19662572wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ReBzsBimdpveLsy+Lkg8Fji3O2Fl/6cfbARc8AiQfvs=;
        b=NMN/xH8R+SLKUOKCqztbFprqD4QQFBZBIMsn2qSQwp5gh0JsF10UlcY1OBJC4qgOlW
         7ximjAX4ZJ6Gj3x9e/4ZiPRTdZteuQiDYVTKAPoRSJO5XhpPfT626xd3g1n5IOx29b5G
         V16b2eg/y3XsLMUg53LRs8XdHewdUHf5ujP23Dt2kscw4jNXyTBimpkdCIdGUC+IF3sW
         z76Zt86/kfvLdSld/bSODvQbEnDL+6WEm5YCP1QdfBEyNj4hxsglk82oU0B3cpRRX9UW
         Ytipd0OsoPd+NuUHeMKLd2xmztnyptsPnSkC18B0ZMYosLJcWXTYo+yI9FHGXZJ/jxaZ
         rkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReBzsBimdpveLsy+Lkg8Fji3O2Fl/6cfbARc8AiQfvs=;
        b=rEI1QcOWtfOwSvXnnnXr9mLkqgF94QMpIMUYYoNGg5ujSUfNZCgmD37/q5IGbSACzU
         Lx4up6lyYNCEYjGSi2hVAWDbOAdQyAP3Wp5fjAQtZNIHmVqRN1QpN2+j30yEpUGd9y9F
         6CMuk/3e9Fo5OrGE/IaeNrTGr2cZSiPhfQ3BvumO2mfUOhGe8Qx5SGbAhYRhQmaomZ7m
         IX683mCLXa8mlLUSBd7i1O9Z9vPDrkhSylzpV0T02AB1Aw1Ne0thlpFdvOTyxXuNyrTR
         ITNQnMwLiM1GCDD7nUyJ5619wlRmOWepoubZssaJblQxOyTOsIyhumnXm7vGuwU/uhGk
         ourQ==
X-Gm-Message-State: ANoB5pmar9h0WrGytIsPOJtH2n4+OKQRBt7JXL9O+dCN0+A7K6OWmX26
        oJrG4BJF+1btLr7pFk6CbAQgSXqrxq791qZMnT7TdA==
X-Google-Smtp-Source: AA0mqf4j2XZu4W7wXvD7hTiCUa5tk5anNfQoyv5Q23/o/kY8GrZvi3Lo4Tpw1PP0IkdLpHg/OlFk8Nyg865KgGd6n1k=
X-Received: by 2002:adf:a492:0:b0:22d:d4c:e99c with SMTP id
 g18-20020adfa492000000b0022d0d4ce99cmr8270139wrb.582.1668449854955; Mon, 14
 Nov 2022 10:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20221112032244.1077370-1-namhyung@kernel.org> <20221112032244.1077370-2-namhyung@kernel.org>
In-Reply-To: <20221112032244.1077370-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 10:17:22 -0800
Message-ID: <CAP-5=fWwnnRDDyf+DknFYU4aYeagXeemXOK9X-yP9Tax+bVnNA@mail.gmail.com>
Subject: Re: [PATCH 01/11] perf stat: Fix crash with --per-node --metric-only
 in CSV mode
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 7:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The following command will get segfault due to missing aggr_header_csv
> for AGGR_NODE:
>
>   $ sudo perf stat -a --per-node -x, --metric-only true
>
> Fixes: 86895b480a2f ("perf stat: Add --per-node agregation support")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 657434cd29ee..ea41e6308c50 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -534,7 +534,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                         [AGGR_CORE] = 2,
>                         [AGGR_THREAD] = 1,
>                         [AGGR_UNSET] = 0,
> -                       [AGGR_NODE] = 0,
> +                       [AGGR_NODE] = 1,
>                 };
>
>                 pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
> @@ -819,6 +819,7 @@ static int aggr_header_lens[] = {
>         [AGGR_SOCKET] = 12,
>         [AGGR_NONE] = 6,
>         [AGGR_THREAD] = 24,
> +       [AGGR_NODE] = 6,
>         [AGGR_GLOBAL] = 0,
>  };
>
> @@ -828,6 +829,7 @@ static const char *aggr_header_csv[] = {
>         [AGGR_SOCKET]   =       "socket,cpus",
>         [AGGR_NONE]     =       "cpu,",
>         [AGGR_THREAD]   =       "comm-pid,",
> +       [AGGR_NODE]     =       "node,",
>         [AGGR_GLOBAL]   =       ""
>  };
>
> --
> 2.38.1.493.g58b659f92b-goog
>
