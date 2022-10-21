Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2260608149
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJUWAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:00:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3E157F4C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:00:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so6100699wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fhok6/NjJ3lgD3XSBtpHWBa7hONW7Sg42t3Fv6voOSo=;
        b=gBIUjVTnBXjaaKpxrLw94mlXTaYQ3ZH7oz/RzFj9itX/WbjkVcA64/mmNzzHVRB7lv
         RTV0y4Zm6OkRZV6cH9p/gwAZByZRqVK/BMK2NJLQknvk3yrDUOWybyk+XdPDxjsPRGbb
         +pzUFJlUgyL+UMYC65SQyqOBh7i2s090yJUmu6hXTod5qVAvFo+yvsXViLPyg4bdswtv
         VoeXkfYlE1jH9X9Uf73hSCiCXNSk8UMcGy4zC8Mwf7llo25/OMAHdBtoP/13KdynurKg
         ZoKYWnS1vStTZ547Mq+UY3aXfPDXbt/9D3asXA/eORYpkii4ElIck/wJ5Nis1kQzmTo8
         nA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhok6/NjJ3lgD3XSBtpHWBa7hONW7Sg42t3Fv6voOSo=;
        b=j3oqvMO0eks3UDGHH6LCacm4qxmdJKr9MVjKiY/Fts7quBI8MfKSy3wAvPUv7KPWam
         b+PcA39kAmCJx0Vm4PAex6A+uOqCzOC4JMDbkZvGUUcP+OGEDNScDmh4IatCuPrcoa8D
         LFToUbpSQuTkb5RryecFjEsqwjm8DsBXvn9jf2KXV+eWagVzCaSGBuIurYSFHAuawbny
         azdVc/jSVASd9/MagbehU3XKnXmW0Wo4oUZBzKd8qUGovaTyKdZ71zI/tyDc/+6JBGcw
         MUtqj09XeNe6bHTBneJYYJ6mQqt8IKqA/zm2QbPfkUCqGXvIuvOL0c93wxixqG0b4fJw
         3fjw==
X-Gm-Message-State: ACrzQf0rXURmoXfJdAm1CZPsj81zcGTePTIES2xiMQLdfNv+Yp/gh6B6
        rWOubYEZIS6OZnwtxxq5ah13zbRFFfKplA+Y3OBsWQ==
X-Google-Smtp-Source: AMsMyM5zNI8Ni6t5s+a+q7ics0RkH7FIO0TJeg+pf0/1RO1KQi9sA28ISvNDGkBgOnuYVaTgczyfkr7YTnFMQQ9DrSI=
X-Received: by 2002:a05:600c:19cc:b0:3c6:fbb9:caab with SMTP id
 u12-20020a05600c19cc00b003c6fbb9caabmr16233710wmq.182.1666389616002; Fri, 21
 Oct 2022 15:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221021181055.60183-1-namhyung@kernel.org>
In-Reply-To: <20221021181055.60183-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 21 Oct 2022 15:00:04 -0700
Message-ID: <CAP-5=fWaqhZu0sUTgBogpeOxF1gf=V0CZjQ=2NDJEbVB-Cvjew@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Do not fail Intel-PT misc test w/o libpython
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
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

On Fri, Oct 21, 2022 at 11:11 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The virtuall LBR test uses a python script to check the max size of

nit: virtual

> branch stack in the Intel-PT generated LBR.  But it didn't check whether
> python scripting is available (as it's optional).
>
> Let's skip the test if the python support is not available.
>
> Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
> Cc: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 4c0aabbe33bd..f5ed7b1af419 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -526,6 +526,12 @@ test_kernel_trace()
>  test_virtual_lbr()
>  {
>         echo "--- Test virtual LBR ---"
> +       # Check if python script is supported
> +       libpython=$(perf version --build-options | grep python | grep -cv OFF)
> +       if [ "${libpython}" != "1" ] ; then
> +               echo "SKIP: python scripting is not supported"
> +               return 2
> +       fi
>
>         # Python script to determine the maximum size of branch stacks
>         cat << "_end_of_file_" > "${maxbrstack}"
> --
> 2.38.0.135.g90850a2211-goog
>
