Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2982E6545B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiLVRqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVRqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:46:34 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5426428E0B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:46:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so2736777pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5a6MYzxLxJ9cZF4J+Y4/MrvHiFf7w3rJ2I+lZMCzt40=;
        b=ZH7Vaxv1FUJg18u7x7abRr7/FN22Dk+FYxHnEs1mPzKAGTp9W1NsFbNs1iOK9oMin/
         omj13uHbbyEbKobYMLfaomM+lvHlyAM6deebLNtC+LMvuWRenPb9Q7IgRhN/bea5wN2w
         2J/irWavBy26bHuSQBQ3y7r0dajbTU6m22p4Zk/qyCCrAvcepU7xc/flYyhn3kZ/Vqm7
         7M1fTimK1hFn8bmMrX+JVLertY/eRr+N0wFg78WJtk39ZbfHHvSw1wMZ842iaIohgTNY
         Hh7agcHlx/6FxjQODCqiVklhQDOflOXiYOHqg9RxpKFsDJ6doeHxXuP+1uHGvZyTfFQW
         V2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5a6MYzxLxJ9cZF4J+Y4/MrvHiFf7w3rJ2I+lZMCzt40=;
        b=q6eZipG2LjGSyz6DEF76LWYlC/qhiJRaK4O5+IouVTb+A5q4XcichgdZchdIp5L+hI
         20agfNhS+8DEZ0R9fyi8oIIjAo6WlqulDHkV1sTFT6jye5aOV2XCmVDLHLOzSQzSJpwc
         +Avz5nupv1AgSWJE60ybTBYhW+A9sz7seH4Ej7lWOyUeT9YmPBGWAdSROt48Tih5AB7K
         CAvYl0n8plxoQxRigyN/1tn2n0lnIu4MfnUsyTAaR9lyKlttxRV1gfTS0crBcdlguLuc
         63EtuATAPjhs9jbD+V10OcyvfdVsZwSR2SsYz3ouSSdwsBYnFKmWZSfjehXzUnufHeYx
         eW1Q==
X-Gm-Message-State: AFqh2kqrs83oaH73KDyG0DjgG4OQ2ygfZU+uK5C/wdzEJp56BsfDTJQW
        u9MUh8BeqW8CQ3bO6RVJgRFs+L4o5K5vQ12/Iq9sxQ==
X-Google-Smtp-Source: AMrXdXszh/yXBCJiK4N8HAEFYMC+mx1dQ4CfVBMfjHlqZ5QMmEHl0xlMIGnuJn9u9Si0oUXt74oyHJ6WIoPYtzZVMMk=
X-Received: by 2002:a17:902:a407:b0:189:f899:bc23 with SMTP id
 p7-20020a170902a40700b00189f899bc23mr359057plq.33.1671731192737; Thu, 22 Dec
 2022 09:46:32 -0800 (PST)
MIME-Version: 1.0
References: <Y6Rq5F5NI0v1QQHM@kernel.org> <CAKwvOdkivaXffVPPTsceM_et4yOgYy3fuw9TmikcjRhDPyTqRA@mail.gmail.com>
In-Reply-To: <CAKwvOdkivaXffVPPTsceM_et4yOgYy3fuw9TmikcjRhDPyTqRA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Dec 2022 09:46:21 -0800
Message-ID: <CAKwvOdm-6p0kDC9=4aLPG2VHhPFwYSFTO3W9-GgneoRw24jVpw@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 9:45 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Dec 22, 2022 at 6:34 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Just fyi, I'm carrying this in the perf tools tree.
> >
> > - Arnaldo
> >
> > ----
> >
> > Noticed this build failure on archlinux:base when building with clang:
> >
> >   clang-14: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> >
> > In tools/perf/util/setup.py we check if clang supports that option, but
> > since commit 3cad53a6f9cdbafa ("perf python: Account for multiple words
> > in CC") this got broken as in the common case where CC="clang":
> >
> >   >>> cc="clang"
> >   >>> print(cc.split()[0])
> >   clang
> >   >>> option="-ffat-lto-objects"
> >   >>> print(str(cc.split()[1:]) + option)
> >   []-ffat-lto-objects
> >   >>>
> >
> > And then the Popen will call clang with that bogus option name that in
> > turn will not produce the b"unknown argument" or b"is not supported"
> > that this function uses to detect if the option is not available and
> > thus later on clang will be called with an unknown/unsupported option.
> >
> > Fix it by looking if really there are options in the provided CC
> > variable, and if so override 'cc' with the first token and append the
> > options to the 'option' variable.
> >
> > Fixes: 3cad53a6f9cdbafa ("perf python: Account for multiple words in CC")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Fangrui Song <maskray@google.com>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: John Keeping <john@metanate.com>
> > Cc: Khem Raj <raj.khem@gmail.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/setup.py | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > index 4f265d0222c454e2..c294db713677c0c2 100644
> > --- a/tools/perf/util/setup.py
> > +++ b/tools/perf/util/setup.py
> > @@ -3,11 +3,20 @@ from subprocess import Popen, PIPE
> >  from re import sub
> >
> >  cc = getenv("CC")
> > -cc_is_clang = b"clang version" in Popen([cc.split()[0], "-v"], stderr=PIPE).stderr.readline()
> > +
> > +# Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
> > +cc_tokens = cc.split()
> > +if len(cc_tokens) > 1:
> > +    cc = cc_tokens[0]
>
> What if someone is using `CC="cache clang"`? Then cc is set to `cache`
> and the cc_is_clang check below will fail.

s/cache/ccache/g

>
> > +    cc_options = " ".join([str(e) for e in cc_tokens[1:]]) + " "
> > +else:
> > +    cc_options = ""
> > +
> > +cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
> >  src_feature_tests  = getenv('srctree') + '/tools/build/feature'
> >
> >  def clang_has_option(option):
> > -    cc_output = Popen([cc.split()[0], str(cc.split()[1:]) + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> > +    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> >      return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
> >
> >  if cc_is_clang:
> > --
> > 2.38.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
