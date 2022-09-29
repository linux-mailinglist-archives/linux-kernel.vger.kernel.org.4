Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8875A5EFDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiI2TZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiI2TZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:25:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D54F69D;
        Thu, 29 Sep 2022 12:25:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f11so966401wrm.6;
        Thu, 29 Sep 2022 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=ii4b+vX/LA1G0UWoyF/9mZxmvXgIagI0VUsrAspvbXM=;
        b=lbku42ms1JQIitvP2/FFYQI/0Acg3ErOKtCobNRNWutkYtBnoYxWwII/T31V2aBN8p
         TTYGDYDXzSsqENgK3tAkBWOesEtYyXKk8WKJCsvSfxDU0mv+Lx02Yvb4dAQtYINwkF3h
         yX9Dmsv45FyOFZcAgPq6mgPqIzVUHJ58QR9wSXBtZqZDGSgwviJ+otTX4pj1hHUb347V
         z2ZFKdPzddJNaqPdTp1UeNUemeAZRavXpOOmggDYOeIfrYE6ZFnqLvxXW4lJLxBVGtPp
         lCFTtR+fcJkKRQwN2rUYKY5FaNDcdRN8BvhBCxrW4M4/TxPcnrE3z9TRYir4U0KISFQw
         avdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ii4b+vX/LA1G0UWoyF/9mZxmvXgIagI0VUsrAspvbXM=;
        b=nymyM4BzhBFyKCOLaq6Cqk1SG0MBolwWh3poA5MOrB4wgoWKMF0zWlY2Br8txkzmNH
         noaXPkxJFOxjKaOZAmJDvPdJVMXW5fxgicVqo4SOpkElUUAfQEy09kgKrTcxCQC610h+
         yfvhw8Oldqz3a1xi297fI1EGPUK/4Y6ZkuUskTa9GLo1iJ0dvtkLuZfwf4s43/tT8MOn
         48YjgqSKq2n8vFjkcQGYCkziM8WGpO76wYtgTTRQU1j6FrK7mxzC0JBuBcxMHFOQRE62
         m4V6HN/qqR713eCeH9F6XC/8Bmwt8vNVoqCuS+vYJYzTJljPKDmGRCcrrOxMat51zyOm
         cdSQ==
X-Gm-Message-State: ACrzQf3H+P6v7r1s1lZ7NQ64LL17e1KWoQjPTVe26nejyuarv2UF+vuI
        QDaROsIvxqVUaskExbQ2QCI=
X-Google-Smtp-Source: AMsMyM5DKkJXj+0pKMdnawd/jM7F80jNCjqlfBAspUrirHVR0iDBvTsH+wKMPxXIWEPl2WevuXw37Q==
X-Received: by 2002:adf:f342:0:b0:22c:c3ea:c6da with SMTP id e2-20020adff342000000b0022cc3eac6damr3558019wrp.567.1664479499458;
        Thu, 29 Sep 2022 12:24:59 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c431100b003b571601e4fsm267536wme.16.2022.09.29.12.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:24:59 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 29 Sep 2022 21:24:56 +0200
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf tools: Fix bison object compilation with clang
 15
Message-ID: <YzXxCFgPs7s59Cjf@krava>
References: <20220929140514.226807-1-jolsa@kernel.org>
 <YzXdjNNh+jbYDnYz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXdjNNh+jbYDnYz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:01:48PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 29, 2022 at 04:05:13PM +0200, Jiri Olsa escreveu:
> > Arnaldo reported compilation fail with clang 15:
> > 
> >     CC      util/parse-events-bison.o
> >   util/parse-events-bison.c:1401:9: error: variable 'parse_events_nerrs'
> >   set but not used [-Werror,-Wunused-but-set-variable]
> >       int yynerrs = 0;
> >         ^
> >   util/parse-events-bison.c:72:25: note: expanded from macro 'yynerrs'
> >   #define yynerrs         parse_events_nerrs
> >                         ^
> >   1 error generated.
> > 
> > Disabling -Wunused-but-set-variable check for bison object compilation.
> 
> So we have to disable something else:
> 
>   37    44.92 fedora:32                     : FAIL clang version 10.0.1 (Fedora 10.0.1-3.fc32)
>     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
>   38    61.77 fedora:33                     : FAIL clang version 11.0.0 (Fedora 11.0.0-3.fc33)
>     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
>   39    66.59 fedora:34                     : FAIL clang version 12.0.1 (Fedora 12.0.1-1.fc34)
>     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
> 
> 
> I'll try yours + -Wno-unknown-warning-option

ugh, of course... thanks ;-)

jirka

> 
> ;-)
> 
> - Arnaldo
>  
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/Build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 8fd6dc8de521..d559c80559e3 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -270,7 +270,7 @@ CFLAGS_expr-flex.o          += $(flex_flags)
> >  bison_flags := -DYYENABLE_NLS=0
> >  BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
> >  ifeq ($(BISON_GE_35),1)
> > -  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum
> > +  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable
> >  else
> >    bison_flags += -w
> >  endif
> > -- 
> > 2.37.3
> 
> -- 
> 
> - Arnaldo
