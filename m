Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716546545B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLVRqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiLVRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:46:10 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB56F27DF8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:46:09 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so2735888pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qHhliKvzm4vvNuNaV6vctgEM0op2JmWBd1k5SQa+DWA=;
        b=PCjK9mhr6mkM+7AzwiJ9+cEGDS+4HvOaZwMcuzIGy9/otkpPwDDq59rVUcUuDaDr3s
         00bVDZUga+ItOMbXXyko76Dkl/eWUc4ovh5R6Df5HEHjVjGEAnZGGW8yOisP1wzVqH0R
         y89dtcWeGYZsjArvSpYajhEEfLe1+gGsdm3eW6T5NuTTYAXOqmz0Zd7Di3Eyd3PR6Pff
         sGd53TOIWIBKUczUC0t9v2IS8Q6c1G0T5z/6nPTfmSO3AYA31PfCQ/QICufupX3OhVnQ
         DDnw8dkdPqbP9/gGe/+bkSmsNRIKXdYSZCMdLykrRsTnog5kjF/BQ0a23U24Nj7tOQKI
         5zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHhliKvzm4vvNuNaV6vctgEM0op2JmWBd1k5SQa+DWA=;
        b=HGAWSQHWI5lkJSpMK+jDdSuULTzAa493bMw3a42KtLCLCEqenAAJPaw/UA9/aVq6q+
         1jgpT2/5oQiP/jyXKRgzpr0zN4M7hBGX/TmQx/dfTYzo63qTVrLtPSUu7JFGEyZD9PKg
         dQRembGoXSRVWY4rzxVH3oL3tA83WKCU3AKpOmUHxfrVV5nzIEav4hMUDu0nvbb/SZQI
         bCoMq2kp4o7rChh2YRDQrB5ufe6Eybut8UfeH/voD7ZvDO7t9OJtvoNSc5Gxm2aQth4l
         zsx7nIYd2nin+an/Bg4Zaxx6qkkRkfTLpev133r6BvyQlV6Nce7w69PpjvI1OURwy55G
         x49w==
X-Gm-Message-State: AFqh2kq+Wfvq2mHYF7pE3Xqs4LiPeeuLm2onzFpSo8L9fGif7HfRuJvk
        3kT2i+rQy204r7MOrPCTivl9T5FO2nE+Tb81g8cjpw==
X-Google-Smtp-Source: AMrXdXuy4ACgio1x1KqZVlOL0O79oGN73dqC6yIFFjP7ZFMlvpD5ZRD8r83fA7yeBSqf60g34AEcHdBCnlbkMgkIjUk=
X-Received: by 2002:a17:90a:2b46:b0:221:77b5:d6b8 with SMTP id
 y6-20020a17090a2b4600b0022177b5d6b8mr787642pjc.102.1671731168984; Thu, 22 Dec
 2022 09:46:08 -0800 (PST)
MIME-Version: 1.0
References: <Y6Rq5F5NI0v1QQHM@kernel.org>
In-Reply-To: <Y6Rq5F5NI0v1QQHM@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Dec 2022 09:45:57 -0800
Message-ID: <CAKwvOdkivaXffVPPTsceM_et4yOgYy3fuw9TmikcjRhDPyTqRA@mail.gmail.com>
Subject: Re: [PATCH 1/1 fyi] perf python: Fix splitting CC into compiler and options
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Khem Raj <raj.khem@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
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

On Thu, Dec 22, 2022 at 6:34 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Just fyi, I'm carrying this in the perf tools tree.
>
> - Arnaldo
>
> ----
>
> Noticed this build failure on archlinux:base when building with clang:
>
>   clang-14: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
>
> In tools/perf/util/setup.py we check if clang supports that option, but
> since commit 3cad53a6f9cdbafa ("perf python: Account for multiple words
> in CC") this got broken as in the common case where CC="clang":
>
>   >>> cc="clang"
>   >>> print(cc.split()[0])
>   clang
>   >>> option="-ffat-lto-objects"
>   >>> print(str(cc.split()[1:]) + option)
>   []-ffat-lto-objects
>   >>>
>
> And then the Popen will call clang with that bogus option name that in
> turn will not produce the b"unknown argument" or b"is not supported"
> that this function uses to detect if the option is not available and
> thus later on clang will be called with an unknown/unsupported option.
>
> Fix it by looking if really there are options in the provided CC
> variable, and if so override 'cc' with the first token and append the
> options to the 'option' variable.
>
> Fixes: 3cad53a6f9cdbafa ("perf python: Account for multiple words in CC")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Keeping <john@metanate.com>
> Cc: Khem Raj <raj.khem@gmail.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/setup.py | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 4f265d0222c454e2..c294db713677c0c2 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -3,11 +3,20 @@ from subprocess import Popen, PIPE
>  from re import sub
>
>  cc = getenv("CC")
> -cc_is_clang = b"clang version" in Popen([cc.split()[0], "-v"], stderr=PIPE).stderr.readline()
> +
> +# Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
> +cc_tokens = cc.split()
> +if len(cc_tokens) > 1:
> +    cc = cc_tokens[0]

What if someone is using `CC="cache clang"`? Then cc is set to `cache`
and the cc_is_clang check below will fail.

> +    cc_options = " ".join([str(e) for e in cc_tokens[1:]]) + " "
> +else:
> +    cc_options = ""
> +
> +cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
>  src_feature_tests  = getenv('srctree') + '/tools/build/feature'
>
>  def clang_has_option(option):
> -    cc_output = Popen([cc.split()[0], str(cc.split()[1:]) + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> +    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
>      return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
>
>  if cc_is_clang:
> --
> 2.38.1
>


-- 
Thanks,
~Nick Desaulniers
