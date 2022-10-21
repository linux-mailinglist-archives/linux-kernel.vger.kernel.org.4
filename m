Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29B606C53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJUAB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJUABu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:01:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B722B3A1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:01:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u10so2182342wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tVxqnzg2CQoXzM/FEJLJ4vB8d+PRNtldamw8EejWJiM=;
        b=WzRWLOfmifnX8e1gqHJc6StZxrr62W+fIUIanHn/GRcVFvbLOKPxXKA8HpBO+GwFym
         7Ze3y/pWGfhkDmBeUvkuliRZxVBYSpbH67b96ly9NBv3VKR+WJAEvLmhDEvt/LNpFLhA
         m/qoMViQr5IMTkt2rsnGEFSwDuLG9JtC3WjaUGacfgjUFwNAkgrQ+RwqSunVXAGaiS/p
         mFDIyKw6UuL8J3iezA5UlhxpiTDDtrUvT8/Dd/R+eBNjeO1AmBkctjFBcFmWm/QKCYXD
         ZcvyvVW3hObLcc7hmg6BiYJCuBGoasOmYUw7CcRhoGlsxB1tFHxM8f843FCe2qJsL6xF
         Zt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVxqnzg2CQoXzM/FEJLJ4vB8d+PRNtldamw8EejWJiM=;
        b=JJPzgp5ITow4JmxgACvVLFu8j1wfnRq1CBSu6YGti5NLjBz6QR9cYGLfqiFSMe7e9G
         CijymewZISj02qwfXKKaTv91cmopX3HLFpv+rYfvNiF2vcn9c/+VMC/kYzDsBPN7EOuO
         VZfaNEUYla/klqpJhougXog5lsjMJHNUvEHhXjyzEnLp92ZIGDeoFaTTODoC/SCGt1bO
         5WOWFfy1eLxY3VyV7ggmzoQ9YLi1rQJf8Ut2sWGqBGndmf2qyPX5DtIBNx6K+Dls4mjg
         Wrq2hQZxXftCOH2S71KfK6GHSQcYxq5dSoglWW4HRspwV4k39ssjW/XJsmGX0cSrCFso
         DMAQ==
X-Gm-Message-State: ACrzQf1EIeJWPl7VYg1WY8f8p2IGvVCCIw3xRg44WRpmdhxy12QVIWOf
        qH891GHx5VK7lyYt5yZ+2q/sE0OxOknicrwRYbQUjw==
X-Google-Smtp-Source: AMsMyM5DL6pO4cZtMef+uj1ttL5V4D6aZYbBxqgnivzV6zY32D4jZYX/yn6Zip7TVuA5pCjpQo6lab4jkRRtkd0kZV4=
X-Received: by 2002:a5d:4c92:0:b0:236:4b97:6828 with SMTP id
 z18-20020a5d4c92000000b002364b976828mr2255308wrs.300.1666310508197; Thu, 20
 Oct 2022 17:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-7-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 17:01:36 -0700
Message-ID: <CAP-5=fW0eS9C+K1DqXRJmU9nz02EpVxUSoJfWpYmMskBp8=gZQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf test: Add target workload test in perf record tests
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Add a subtest which profiles the given workload on the command line.
> As it's a minimal requirement, test should run ok so it doesn't skip
> the test even if it failed to run the perf record.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 345764afb745..c59d1459c960 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -174,11 +174,29 @@ test_system_wide() {
>    echo "Basic --system-wide mode test [Success]"
>  }
>
> +test_workload() {
> +  echo "Basic target workload test"
> +  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "Workload record [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "Workload record [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic target workload test [Success]"
> +}
> +
>  build_test_program
>
>  test_per_thread
>  test_register_capture
>  test_system_wide
> +test_workload
>
>  cleanup
>  exit $err
> --
> 2.38.0.135.g90850a2211-goog
>
