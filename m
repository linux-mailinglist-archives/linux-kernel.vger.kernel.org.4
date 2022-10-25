Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111BB60C28A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJYESo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJYESm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:18:42 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E8114DEA;
        Mon, 24 Oct 2022 21:18:41 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id w74so13033011oie.0;
        Mon, 24 Oct 2022 21:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuKtErmwTMB3MGyJPZnHpuyN/kqKJZTaCI4ZoUJtc8U=;
        b=dLwZKLfdm5z2O/nrx0K8LWse7kKf5PsrV8g+OZ5JX67YEd5dlcdPHOvgRVbmqW2gBq
         0Zzd030iF+ngWMoL+WsyFOVzXBRmeYZpVlfspsEXSb4qj8NeZGpIXKuD+fr64E/RS9hG
         tPkE6oP9emAf2jRj+IW5F6KDvRCQCtxNflKD628z+XD/m0ITcqhyqTfNDPc6Hbc2EoQl
         eC3c7tKF8I8KBSka4v0a5IW7J9CfGt+rLzP8zryEvAFAE24+WucwsFHbWTGyowxfkT7K
         uEAePxgIQAdqHiiCzJD6gaF3LK7CQoqVM4sWP53xtzWBeuQ5z0dltwsjLH3ZbOTPulVM
         hc5w==
X-Gm-Message-State: ACrzQf3oEKZn1YppaHfvr6ptl3PVoULdyuYyXozOyd71LHZKy5LhZ75V
        Rd6eucSlAaE4NQLJFNK2j9xXZAbkbTacLd9cj/Q=
X-Google-Smtp-Source: AMsMyM69D7dIuSmjo5ZSvAb4T70/wc5FjVNG3tftHJhcnJ3skyuPaktXEW1WQi5GMXltc6wtRpRCPQMfBwqq1xrKo/w=
X-Received: by 2002:a05:6808:20a0:b0:355:5533:d514 with SMTP id
 s32-20020a05680820a000b003555533d514mr16600328oiw.209.1666671521006; Mon, 24
 Oct 2022 21:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-4-namhyung@kernel.org>
 <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com> <Y1Z3/t4RtnB8r03t@kernel.org>
In-Reply-To: <Y1Z3/t4RtnB8r03t@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 24 Oct 2022 21:18:29 -0700
Message-ID: <CAM9d7chs_fJymdAR65rw8HM0JQaVAKAPJmsuTKCe75i-zLJSYg@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 4:33 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Oct 20, 2022 at 04:52:14PM -0700, Ian Rogers escreveu:
> > On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> > > If the system has cc it could build a test program with two threads
> > > and then use it for more detailed testing.  Also it accepts an option
> > > to run a thread forever to ensure multi-thread runs.
> > >
> > > If cc is not found, it falls back to use the default value 'true'.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> >
> > I wonder if these utilities should just be built into perf to avoid
> > the cc dependency. Perhaps we can have a hidden option built into perf
> > test.
>
> Agreed, not depending on a compiler makes 'perf test' usable in more
> systems, particularly production ones where we may want to check if perf
> is passing all tests applicable to that system.

Good idea.

I think we can add an option (like -w/--workload) to run the specified
workload rather than executing the tests.  Like below (assuming we
have a workload called 'noploop').  Thoughts?

  $ perf stat -- perf test -w noploop

Thanks,
Namhyung
