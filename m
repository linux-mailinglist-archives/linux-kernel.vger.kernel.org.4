Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51CD5EE20B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiI1Qln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiI1Qlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:41:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCDFD6938
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:41:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so2546148wmr.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qvhfEryHJEqIw5SG9tmPjUpJgca65hQC/5fM7raFR1c=;
        b=Htj+QMFSMszwgpJNBXNKvBAmr0Eda/nIIhFbht76EXkcj+xBgStjzPza83YPo/xZ9x
         t0d4OTsNobgLmMiZoM5nPDFTgIubYHA66Sp8NIKxfPpFqMML8K46zwhe1QSy8T/TXfDe
         XK3j4T6IKqLWz39EclqsjskCKKY+gu76xvF6RihowVSLd8S/8adqpJbwFFG0oSE7E1Xw
         3a/VV1TBUnssm7ik1fL99fA/a/+9dAVCT2AOJrotXFKQCImDkuHfA6WcXPP65462owdL
         0Mm2yQmOKQBHXiM7wEiowyqw+U/5wN2s7Jm+5zAxSsqiz7IymNirdUqTEYBFc209UqAx
         Ja1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qvhfEryHJEqIw5SG9tmPjUpJgca65hQC/5fM7raFR1c=;
        b=aPzdW9NB9u8BwIzRwWvlVSFqHTdD1fXkYLfhTZbvoL4VnFcCpPBVQ2VjRo3RVK+sDC
         jAB+ciur+SlbgY/Y2dCARBdVWri8Hb1ZFnP62Apzmf6KSCroT0Ta2LSh9XJX/ucNpUWi
         PbmuCH3yyZdSFm8oUhahyb7NF4ToP8666m7qQ0y4rS1U9PYocKts3fYcBcwCmn8lb84u
         L8iZ/c6/DSL3SaeHee0TH21CZ9niieOjM1HCOi37RdkIwY2VNflZLSYe9IeiFIgJIsRJ
         GdUBa8RjmACxhtseOQ06qfMHQUuZhqED65iOB3mMrcT4SG5brZhZZUMu4xeSEUvX5c67
         0fBA==
X-Gm-Message-State: ACrzQf223s+I2Ke86c+GBDg5aesgTk/PhncVQmAjDOgOCdS+aCI51hrb
        vE114/2M+QKqNBzshfJwNkFj18l6Nkd4c8VJx6KgjA==
X-Google-Smtp-Source: AMsMyM6AD+2QwbjsstSzuSDkUQJCCaJdNDXEHuz1LjIab47xS6pZLoM6o5OzSuygLSIvYqgIIEqpjAoIJdYsw5c+5I4=
X-Received: by 2002:a05:600c:2181:b0:3b4:74e4:16f8 with SMTP id
 e1-20020a05600c218100b003b474e416f8mr7326089wme.174.1664383291776; Wed, 28
 Sep 2022 09:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <YzR0n5QhsH9VyYB0@kernel.org>
In-Reply-To: <YzR0n5QhsH9VyYB0@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 09:41:16 -0700
Message-ID: <CAP-5=fUbxhcATmqWBU8fDeuLB7qWhnrZH=kBP=pVBUrw_wTXgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests record: Fail the test if the errs counter
 is not zero
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Sep 28, 2022 at 9:22 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> We were just checking for the 'err' variable, when we should really see
> if there was some of the many checked errors that don't stop the test
> right away.
>
> Detected with clang 15.0.0:
>
>   44    75.23 fedora:37                     : FAIL clang version 15.0.0 (Fedora 15.0.0-2.fc37)
>
>     tests/perf-record.c:68:16: error: variable 'errs' set but not used [-Werror,-Wunused-but-set-variable]
>             int err = -1, errs = 0, i, wakeups = 0;
>                           ^
>     1 error generated.
>
> The patch introducing this 'perf test' entry had that check:
>
>   +       return (err < 0 || errs > 0) ? -1 : 0;
>
> But at some point we lost that:
>
>   -       return (err < 0 || errs > 0) ? -1 : 0;
>   +       if (err == -EACCES)
>   +               return TEST_SKIP;
>   +       if (err < 0)
>   +               return TEST_FAIL;
>   +       return TEST_OK
>
> Put it back.
>
> Fixes: 2cf88f4614c996e5 ("perf test: Use skip in PERF_RECORD_*")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Apologies for that.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/perf-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index 6a001fcfed68e517..4952abe716f318b0 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -332,7 +332,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  out:
>         if (err == -EACCES)
>                 return TEST_SKIP;
> -       if (err < 0)
> +       if (err < 0 || errs != 0)
>                 return TEST_FAIL;
>         return TEST_OK;
>  }
> --
> 2.37.3
>
>
> ----- End forwarded message -----
>
> --
>
> - Arnaldo
