Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25C45E8644
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 01:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiIWXU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 19:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiIWXUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 19:20:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70293109625
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:20:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id cc5so2103533wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HVq49c8Bz/d6Qe5JwhLqq2RMMl1nsvDssCJbwBMkwcs=;
        b=Cz7Qsoc9gVTOuAYUVB9jrLnxFG/zjR/xFnG9Pzvlyp4bV2vgNNRVUqk7ulF/w4v4s+
         gZ6KGix0/2dEvm68NLrsceLD9AsQfpjtTQ3s4N6JklT7p6HNsSd8CySpx0ncx0U6IReq
         ix1xjmGjyn1tGzm3+nRRkCcAAs2/eK6Oovzr1Tg2SMU4FOS89uQ57DkwjLizfLajGXQf
         MoGG2giz3V4F21YJFEH/NNMcgmgc9J4HhZua89xJO91hWrCOQs1TkCPqk+a3QklxAGEC
         ogcuPMnhnR4naM4/XneuBCjTN7HQfvgQeJsowh9EmFN5Kj/SgZUWGwzk8lxCMO2pTdcL
         nXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HVq49c8Bz/d6Qe5JwhLqq2RMMl1nsvDssCJbwBMkwcs=;
        b=kDZb27+uEQ/LTFQ3R+ZRMhqcexvtkLmBRkGon/MZASyA2guKZdxovc7Wu2GY+b98sl
         zVsqyq8NtvAVdDP3PrvXVVa+SaqE7xCNh/lNsDSXF2CvrV8MPW/tUlOMnUJBX+erZh4G
         mi+8DBHhwt0l6OYtsqxrelqy2o1SfrIV4L5Ln0JWXNZJZnkcs+Eo+k/tpdU7lk686N2S
         R25Pp8C+SLZi7+niI6TsGdLo/vthA1RYh3kekpsj5md2BxpDGGZgT/K/Z8Y83V/Rx0JO
         /8MG35GDwtB2HoqPm+SEaYWBX35IeIiyXhh98cXG1qsnVw4eUtUWD9S9QmdM8eypDYwM
         0dPw==
X-Gm-Message-State: ACrzQf3OQaEUI8wZoWEKVVCPgOJvLA2qFGUUkbOR4pfF4qJSWgszhxf5
        WrZA64BLCEgXeQhb7DfrvkT6pPqNDecQA7+qi41F3Q==
X-Google-Smtp-Source: AMsMyM7VS92WtGY2ztj9QRObW3zg+6/faUZ+WC04qvHcF6My7Bx1jTAzwsmhUcJnsPza5ugvrUFTQ8vC7ykM2hEXdyQ=
X-Received: by 2002:adf:bc13:0:b0:228:6d28:d2cb with SMTP id
 s19-20020adfbc13000000b002286d28d2cbmr6565920wrg.375.1663975245850; Fri, 23
 Sep 2022 16:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220923173142.805896-1-namhyung@kernel.org> <20220923173142.805896-2-namhyung@kernel.org>
In-Reply-To: <20220923173142.805896-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 16:20:33 -0700
Message-ID: <CAP-5=fUhCL1GFeS-YVYG=cQ-q891BHCkkpcEKbY3+u8ukPZbcg@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf record: Fix a segfault in record__read_lost_samples()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Fri, Sep 23, 2022 at 10:32 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When it fails to open events record__open() returns without setting the
> session->evlist.  Then it gets a segfault in the function trying to read
> lost sample counts.  You can easily reproduce it as a normal user like:
>
>   $ perf record -p 1 true
>   ...
>   perf: Segmentation fault
>   ...
>
> Skip the function if it has no evlist.  And add more protection for evsels
> which are not properly initialized.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 741e763436ca..f4f1619199e5 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1888,6 +1888,10 @@ static void record__read_lost_samples(struct record *rec)
>         struct perf_record_lost_samples *lost;
>         struct evsel *evsel;
>
> +       /* there was an error during record__open */
> +       if (session->evlist == NULL)
> +               return;
> +
>         lost = zalloc(PERF_SAMPLE_MAX_SIZE);
>         if (lost == NULL) {
>                 pr_debug("Memory allocation failed\n");
> @@ -1899,6 +1903,8 @@ static void record__read_lost_samples(struct record *rec)
>         evlist__for_each_entry(session->evlist, evsel) {
>                 struct xyarray *xy = evsel->core.sample_id;
>
> +               if (xy == NULL || evsel->core.fd == NULL)
> +                       continue;
>                 if (xyarray__max_x(evsel->core.fd) != xyarray__max_x(xy) ||
>                     xyarray__max_y(evsel->core.fd) != xyarray__max_y(xy)) {
>                         pr_debug("Unmatched FD vs. sample ID: skip reading LOST count\n");
> --
> 2.37.3.998.g577e59143f-goog
>
