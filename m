Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84E1606C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJUABB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJUAA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:00:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670F81B156D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:00:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so2137399wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YQQJkg60oghXSe/DrgO7qxfVakPexmBFZ+wduZFMSNE=;
        b=RvKG6jn8CWGKhvUZj1+9JIzmzrPaBYa3lhYcENLdUjBpLPvvH4geUs/PFkowG56lBS
         nhrA70qNuqq3E9KHjCoreILTevAWF/s9deCbmPcLl7JUXIE/QxilMLFuAOB/t1xxJO9y
         eYyFW5NzT7sYhWs2MfZOdjU9aDOmN/jBz1rgw7Zd78KXumgVikmOghmTCSgkPs4cjbK0
         t0sy6dSXng3G7SRlyYG6+Lde6QOC8ph8jRu9k8SFyXS9D7nT4sxxFDwyzxhaCws4SSES
         1L9W2YQAwqSU0TykuyY5JCgKWqjuWPHAh9x1O2o8IxDpkQjbZkUphoB56DbU/08H69kh
         bf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQQJkg60oghXSe/DrgO7qxfVakPexmBFZ+wduZFMSNE=;
        b=mMmjflTaJWATxNK2zepXbHWy+FGk9ed2tafk5gGclt+ZnBaP3Tp517RB0NW4p0mwPw
         bAgmXqRYiuH0Ho1mpIhS7E+kBEGQgP4sAGaFgPQM04P0sB/MlZ9YOdAW8aU75qNIm2Cg
         yfQinJVZ4/6qGHM+jNmh8ckt50xrKdWg2nH35H7hpTLLnZke7KwWVu+LKzjWkVxPWzP8
         CzCRYXFLVd9PyJuYjd634WcvhGkckC19NpJ1RdIEmS0A64rSUPny2mh6p7BFiy1JNPii
         RDdk97EK33QggfRXWRiCoPNlhvFY/ANTxE6LhiFmFeKhLOL3tOBBRGkY+W6Pgjmp3RK9
         5PEg==
X-Gm-Message-State: ACrzQf26oQPrI1e880RLcZs/Xh5REfUmIstfH5ooZY4pL4YNQLpuCjww
        7T8Nu7HlhfNUSweE4N2edEcX3ffjhADTSwTac8fI+w==
X-Google-Smtp-Source: AMsMyM4oOV8iAIORQYnZNfTbnlYqMEikA42HTHo8wzozxrVDsUxUruZbG6NSxhTbSRfs4fT7rYRucW5pG9L6Vtm1Ho0=
X-Received: by 2002:adf:e711:0:b0:236:2f7f:4f08 with SMTP id
 c17-20020adfe711000000b002362f7f4f08mr3386434wrm.375.1666310451094; Thu, 20
 Oct 2022 17:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-6-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 17:00:39 -0700
Message-ID: <CAP-5=fVDi8Cj2XenWDB_rENJPYj_Nafo7BE2c7XiOGYUh1QqLw@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf test: Add system-wide mode in perf record tests
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
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Add system wide recording test with the same pattern.  It'd skip the
> test when it failes to run perf record.  For system-wide mode, it needs

nit: s/failes/fails/

> to avoid build-id collection and synthesis because the test only cares
> about the test program and kernel would generates necessary events as

nit: s/generates/generate the/

> the process starts.
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index d1640d1daf2e..345764afb745 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -154,10 +154,31 @@ test_register_capture() {
>    echo "Register capture test [Success]"
>  }
>
> +test_system_wide() {
> +  echo "Basic --system-wide mode test"
> +  if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "System-wide record [Skipped not supported]"
> +    if [ $err -ne 1 ]
> +    then
> +      err=2
> +    fi
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "System-wide record [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic --system-wide mode test [Success]"
> +}
> +
>  build_test_program
>
>  test_per_thread
>  test_register_capture
> +test_system_wide
>
>  cleanup
>  exit $err
> --
> 2.38.0.135.g90850a2211-goog
>
