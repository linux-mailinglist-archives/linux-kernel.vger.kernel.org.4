Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD47606C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJTXsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJTXsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:48:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED440229E40
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:47:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v1so2042987wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fp06+6mQjxwkMOGbcbdaLiXXdLiLH/d1YiaDFPBTsk=;
        b=Y2VSj6x6IJpx1oqTEKHu91HFrj44s8bfYZ4CAqIUdG2CXcI8H27Eh07nG7oyg+oDX3
         xiseJW/kIQVTP+eBV8EtqJNihbz5aMe19JneF8NBdeLKnKcF2sFSuhU4UiKr28+Oc+Y9
         MUkaRzqhBXJiMAk/Zuadj1LR8x9EFZSb5Sw3qTji9Yn3FNEZcLkFAeHqHmXdswaJhcHM
         WHgnS9MwaNEhiAPcucV0XOHraJ+SkDK8YL3KtXYIFZ+TKhsurS6BRMcGhytM7KDIfGCL
         OvBZz/w4VQI+vWyTvJ3C/6PQDFhhdy0MlZdMjUr50x0xHrbOD5XpxXcE8JrrvTIrWvgK
         sZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fp06+6mQjxwkMOGbcbdaLiXXdLiLH/d1YiaDFPBTsk=;
        b=y3p8xVMBhxkERQZRCiYotftqBK1zKEUzOodn+N94kSca3rosBki0gEhv6NpK1NYNgu
         zNJ0nji8SA8K1+ITXGmlqdQUMg1KHE6BkTWQ5FUoQKIJS0uZ2EE7RoptfrFbwD9V9N39
         8aMJQ8vE2Pouk3ODZQzO/UhbrQyp1cOZWZViPtYyaYtqLkTPawVNGRX6b+x6gGpJoYjs
         6io08BBWZR24uOvplkZgGlF+aD5FykwVs6uY2ZXKLrqouERzhSN2HDifpvs5EWp+Ec87
         9m4TqE4yQDMkF8Nr+/6tzPr4YTOZNTYgyqO2xaoCbQYpeTPAvFImmC69QGQgY/4V3WX6
         SIew==
X-Gm-Message-State: ACrzQf0/PHtsRVIgMeRPgbr8p3G02FEkgeqNfu5iomwZfWpxNI5JoEju
        KVm75S1SFFN6yTb0xABVp1ABJefllHanM98+cZfX8Q==
X-Google-Smtp-Source: AMsMyM7jL1WZO39lKYVxbhe71wEvZ0SK44dVy3hW0rkt1uiFYayLRWNYCd1UjSgrwj4e9WIBD+sAfmtPvFytMOOgSbU=
X-Received: by 2002:a5d:47a9:0:b0:22e:3beb:dc3a with SMTP id
 9-20020a5d47a9000000b0022e3bebdc3amr10418490wrb.654.1666309677281; Thu, 20
 Oct 2022 16:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-2-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:47:45 -0700
Message-ID: <CAP-5=fXpwnX1mhaV7gcycn7O4D+TSSJqQqt2Wmh-DusD1qT66g@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf test: Do not use instructions:u explicitly
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
> I think it's to support non-root user tests.  But perf record can handle
> the case and fall back to a software event (cpu-clock).  Practically this
> would affect when it's run on a VM, but it seems no reason to prevent running
> the test in the guest.
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 301f95427159..747c33a1ec45 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -21,18 +21,18 @@ trap trap_cleanup exit term int
>
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  if ! perf record -e instructions:u -o ${perfdata} --quiet true 2> /dev/null
> +  if ! perf record -o /dev/null --quiet true 2> /dev/null
>    then
> -    echo "Per-thread record [Skipped instructions:u not supported]"
> +    echo "Per-thread record [Skipped event not supported]"
>      if [ $err -ne 1 ]
>      then
>        err=2
>      fi
>      return
>    fi
> -  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
> +  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
>    then
> -    echo "Per-thread record of instructions:u [Failed]"
> +    echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> @@ -49,7 +49,7 @@ test_register_capture() {
>    echo "Register capture test"
>    if ! perf list | egrep -q 'br_inst_retired.near_call'
>    then
> -    echo "Register capture test [Skipped missing instruction]"
> +    echo "Register capture test [Skipped missing event]"
>      if [ $err -ne 1 ]
>      then
>        err=2
> --
> 2.38.0.135.g90850a2211-goog
>
