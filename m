Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F806547A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiLVVHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLVVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:07:36 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4369E1A227
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:07:35 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g1so2050643pfk.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m78Bmb8IpoJvV4YSSPRGPYFC1Hrykgq9tZS9kYrf59Q=;
        b=MjcgJ/26efbTA9FPZCX99pXawJ0Y5vMfyrSlCmLNXPfbepEWAQf/YX9C6DVt+jaCNi
         za6obwavGz64xAbCBLb+sESRVKd//OPYHGpAc4w3oJ7K91wxuihERB4H50e5DdTxrn+y
         VfOolxQ3lnh9eby6p75MTyXGZ7OdWVS/eN8fgyarM63ZDeM5PcsZdRbaJFJp+25QtbC+
         J/5Bv5BdmsxNjsO+EKq+0xLz5YYRGJXeYNB5MM2FkgqLAm6kkCHe2rYIxCIOBPYi6qAT
         JX8AGAwUBYxFcAVc2mAoY4j0VJfRJJn4PCStMfe1II6p0l0+5398BPErXU6+Ccbn+zYh
         rLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m78Bmb8IpoJvV4YSSPRGPYFC1Hrykgq9tZS9kYrf59Q=;
        b=onW0oYCcp+9Vgedsknm9mKd2LoYDCeG4VPGlARyDCYTj58bIWftBw1/u/g8abs6VCe
         NV9g0MSgxJ++dta2k2uHpbUcjmCAorvV0ARHbjCXl9E3DQMI/ChBBEVRpsul36lmgzvM
         YXXmxzL7e2g1jH5th1RLN+Uvkm1eg5Z9XaPbZ9aK8bMZrvoRj76/vpITyzo1+/L2Y/wi
         0lO+pGbu8EQQ6/xiZ5h48brLSZcKuF9vigXZa9i1B9rOEjnvkJDf3xpIot0zzxFPO73K
         48Et9KobLRuXvYN+JCbJr2BcwalzNVpXiv8cPD441yyP4EZU8BYsUENXfVzsiZAUL9S4
         hqOg==
X-Gm-Message-State: AFqh2kr9A/4/yh8PL6qrjh4etFbOqU5UOQhmGqEtrWs+bqEZlOJqjHO2
        qSaYCadx7Csno+puykJHrfl7nD6NhlpyocVwWt6BTA==
X-Google-Smtp-Source: AMrXdXtOfDWL//sZFv/yy65/Vz7QNtyJaL0xFGOlbKS9ALmPJJu4nA2UHv+QGa+XMTVerd2AWv2epUvwgt9OlmVKSFU=
X-Received: by 2002:a62:6c5:0:b0:57f:f2a8:7868 with SMTP id
 188-20020a6206c5000000b0057ff2a87868mr496209pfg.66.1671743254251; Thu, 22 Dec
 2022 13:07:34 -0800 (PST)
MIME-Version: 1.0
References: <Y6Rq5F5NI0v1QQHM@kernel.org> <CAKwvOdkivaXffVPPTsceM_et4yOgYy3fuw9TmikcjRhDPyTqRA@mail.gmail.com>
 <0A5683A4-7838-4073-8CA4-1FAF2E7BE202@gmail.com>
In-Reply-To: <0A5683A4-7838-4073-8CA4-1FAF2E7BE202@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Dec 2022 13:07:22 -0800
Message-ID: <CAKwvOd=-CoG-POOEARghQurJSYtciCOAQ2duR7X=Lfaj4LWW5g@mail.gmail.com>
Subject: Re: [PATCH 1/1 fyi] perf python: Fix splitting CC into compiler and options
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Khem Raj <raj.khem@gmail.com>,
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

On Thu, Dec 22, 2022 at 1:00 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On December 22, 2022 2:45:57 PM GMT-03:00, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >On Thu, Dec 22, 2022 at 6:34 AM Arnaldo Carvalho de Melo
> ><acme@kernel.org> wrote:
> >>
> >> Just fyi, I'm carrying this in the perf tools tree.
> >>
> >> - Arnaldo
> >>
> >> ----
> >>
> >> Noticed this build failure on archlinux:base when building with clang:
> >>
> >>   clang-14: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> >>
> >> In tools/perf/util/setup.py we check if clang supports that option, but
> >> since commit 3cad53a6f9cdbafa ("perf python: Account for multiple words
> >> in CC") this got broken as in the common case where CC="clang":
> >>
> >>   >>> cc="clang"
> >>   >>> print(cc.split()[0])
> >>   clang
> >>   >>> option="-ffat-lto-objects"
> >>   >>> print(str(cc.split()[1:]) + option)
> >>   []-ffat-lto-objects
> >>   >>>
> >>
> >> And then the Popen will call clang with that bogus option name that in
> >> turn will not produce the b"unknown argument" or b"is not supported"
> >> that this function uses to detect if the option is not available and
> >> thus later on clang will be called with an unknown/unsupported option.
> >>
> >> Fix it by looking if really there are options in the provided CC
> >> variable, and if so override 'cc' with the first token and append the
> >> options to the 'option' variable.
> >>
> >> Fixes: 3cad53a6f9cdbafa ("perf python: Account for multiple words in CC")
> >> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >> Cc: Fangrui Song <maskray@google.com>
> >> Cc: Florian Fainelli <f.fainelli@gmail.com>
> >> Cc: Ian Rogers <irogers@google.com>
> >> Cc: Jiri Olsa <jolsa@kernel.org>
> >> Cc: John Keeping <john@metanate.com>
> >> Cc: Khem Raj <raj.khem@gmail.com>
> >> Cc: Leo Yan <leo.yan@linaro.org>
> >> Cc: Michael Petlan <mpetlan@redhat.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: Nathan Chancellor <nathan@kernel.org>
> >> Cc: Nick Desaulniers <ndesaulniers@google.com>
> >> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> >> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> ---
> >>  tools/perf/util/setup.py | 13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> >> index 4f265d0222c454e2..c294db713677c0c2 100644
> >> --- a/tools/perf/util/setup.py
> >> +++ b/tools/perf/util/setup.py
> >> @@ -3,11 +3,20 @@ from subprocess import Popen, PIPE
> >>  from re import sub
> >>
> >>  cc = getenv("CC")
> >> -cc_is_clang = b"clang version" in Popen([cc.split()[0], "-v"], stderr=PIPE).stderr.readline()
> >> +
> >> +# Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
> >> +cc_tokens = cc.split()
> >> +if len(cc_tokens) > 1:
> >> +    cc = cc_tokens[0]
> >
> >What if someone is using `CC="cache clang"`? Then cc is set to `cache`
> >and the cc_is_clang check below will fail.
>
> Agreed, but this is a preexisting bug, let's fix this with a follow-up patch,

Ack; it is.

>
> - Arnaldo
>
>
> >
> >> +    cc_options = " ".join([str(e) for e in cc_tokens[1:]]) + " "
> >> +else:
> >> +    cc_options = ""
> >
> >> +cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
> >>  src_feature_tests  = getenv('srctree') + '/tools/build/feature'
> >>
> >>  def clang_has_option(option):
> >> -    cc_output = Popen([cc.split()[0], str(cc.split()[1:]) + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> >> +    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> >>      return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
> >>
> >>  if cc_is_clang:
> >> --
> >> 2.38.1
> >>
> >
> >



-- 
Thanks,
~Nick Desaulniers
