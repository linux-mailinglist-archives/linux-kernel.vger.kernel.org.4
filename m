Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B625606C28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJTXog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJTXo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:44:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336E11A11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:44:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bv10so2099684wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l8+bpSsSM29uvKB9yhvqF2P3Y/EvB9KhDMV5DKiLMeg=;
        b=HwApiV25u97jgY5tcdykxHIALxKtfLwpzsTiSDbMD39DiW8gtNtbKSyHc+erK+uvy3
         IqyPwwWQ256XIjMC+5SVYpZD9RTKU1yzc4g1EvadMAi1gx9qiXrXGmKC/cNttHLkM/sw
         IVakHqctix9Y/tm80eZ/MOVgmCH2WKg/TF8KO9nfeVbomUTqmgDidUUxKcpa4dOFY4zp
         yjI7q6ct4nerpubjMvZk7BUBJTwNSRSStX9WM7KcmpsmiM+T/sjy+FqEkdckYEDF7XE6
         Qw5eJHpHN9bEBmAUceYA/XmKi+qYfmck4zb38TgX+25aDkLq6SVtfoRm/gKY+TlAzs2Z
         uYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8+bpSsSM29uvKB9yhvqF2P3Y/EvB9KhDMV5DKiLMeg=;
        b=wvGxwf7MOGdJPksLjivrw1FwkCp64pWV8E1uNTHPoR84GpddEi0TzVX9G7rId+x3KJ
         tLaSEmQdcqAtSV5Zw2PRmcF0idWKA0MDHEkTCfDa4zXAdNSdNgO1YFJX4/tRbJeN/WD2
         6CpUX6JQN09o/TcsWTH5M53VieSHWvTH1yh3HmuHmdguORQWSMRKlOk5YW/5L8VcB3l6
         aFxvQqZBHpWaKL1TkpAyUAJLWm5LYrN0CH2zelDSaZ5Y8Rk1Nc8gMmR9bCEkEX+zfUtr
         46el2or5TZJBe4GqMTdbDepZAgLAYwK7vKKBRXyGJAaYUTXvotbGMg8PhPeL8ZEDdDrI
         xzCQ==
X-Gm-Message-State: ACrzQf3DZmMkKgJzLKyzkqQWOVKipTJJPy2JhYjlfSVnuYkR5+pgf3AX
        iYkze/y6Wa9DmIvbU5aRPbEAl46YO25H+gLckLoHew==
X-Google-Smtp-Source: AMsMyM5kRkmtVfi1zNhkyd6DLtpbcmuur0WfSqDe4oDduAdiz2XDPaMp09Ruu8USgyt6pHhlG9q3y78T/Y0V2HH7O/I=
X-Received: by 2002:a5d:4c92:0:b0:236:4b97:6828 with SMTP id
 z18-20020a5d4c92000000b002364b976828mr2228410wrs.300.1666309464991; Thu, 20
 Oct 2022 16:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221020192917.3542757-1-namhyung@kernel.org>
In-Reply-To: <20221020192917.3542757-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:44:12 -0700
Message-ID: <CAP-5=fXxckG+-WK6_QSvrTZiczXdcc=42_42hE0DfK4_5wmXxw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Do not fail Intel-PT misc test w/o libpython
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The virtuall LBR test uses a python script to check the max size of
> branch stack in the Intel-PT generated LBR.  But it didn't check whether
> python scripting is available (as it's optional).
>
> Let's skip the test if the python support is not available.
>
> Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
> Cc: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 4c0aabbe33bd..e66b7d977462 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -526,6 +526,12 @@ test_kernel_trace()
>  test_virtual_lbr()
>  {
>         echo "--- Test virtual LBR ---"
> +       # Check if python script is supported
> +       libpython=$(ldd $(which perf) | grep -c python)
> +       if [ "${libpython}" != "1" ] ; then

Perhaps use -vv (taking care not to match "on" against "python"):

if perf -vv|grep libpython|grep -q " on"; then

Thanks,
Ian

> +               echo "SKIP: python scripting is not supported"
> +               return 2
> +       fi
>
>         # Python script to determine the maximum size of branch stacks
>         cat << "_end_of_file_" > "${maxbrstack}"
> --
> 2.38.0.135.g90850a2211-goog
>
