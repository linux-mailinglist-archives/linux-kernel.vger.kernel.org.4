Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF33864F1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiLPTsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLPTsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:48:42 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE95B597
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:48:41 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a16so3518621qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Luy/wNHt1Hg1pZl82RzrJodI7FyVTRjaZqUGskFzU=;
        b=MSzZWLgJ53XwhZtIq0MTi70LPyjmXvp7FhdpKITVjpS0Vfz4wNGU7XZzECwIubnFFw
         6F67UPDh5GsGAfGSFLtda6gl7J3V5/GBD92Q0ILDjGerrenKTCkpjjD+qvvNZPQnuQas
         S+Z8qwSJ1k8EJgC8m/Gx01Y/e5IvFUwotMVA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9Luy/wNHt1Hg1pZl82RzrJodI7FyVTRjaZqUGskFzU=;
        b=4FEWXjhqaSO34qDl21gGAGyEAL/PmSp7f/69GdtcMhsF0MNfvOy2FoXQ7CXrH7EYpW
         AugKVO7AOq/XEgPUyn5Uy5qLisUuL80yu+aQytnS10wzEd39he1cFAM9cHsCSxmDYFhV
         ioea/dqoUOPG1yk0JC9S/I0GO9V/LikY/KF30ca5Y6rRj5sYmjrHaA1cvHxDr8fFa12/
         RoWjJrDYqUCbNhp1csp6Rx8qoJxoWJFq/EJ88sK/wEtVAfevOg6ByOQS0OZaPx0boLkP
         n2F+0Qn2EIV1je9gJEpShK/LkOagt9EAe3CgCNfGI/zsRpav3NII4mOe5c9n5sndJfVI
         SyVQ==
X-Gm-Message-State: ANoB5pmwPuaITScgeJaHBY+S0Mdl2672UUa4kg4EhgYAmsgf05tBvJAT
        L7ZWmlogmq8W5ys7h+zJJgpfuBDmA0bZ/yI9
X-Google-Smtp-Source: AA0mqf5ZTckH7tkRZzytc1V0fLyjVY+bODj2j/fRRcXiflJWHca677j+NmmlzHtzEpmk7Tk5fwXOVw==
X-Received: by 2002:ac8:4514:0:b0:3a8:ef7:f29c with SMTP id q20-20020ac84514000000b003a80ef7f29cmr31971964qtn.46.1671220120236;
        Fri, 16 Dec 2022 11:48:40 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id bk5-20020a05620a1a0500b006ee77f1ecc3sm2102526qkb.31.2022.12.16.11.48.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 11:48:40 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id i20so3527229qtw.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:48:39 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr8036938qtq.436.1671219699886; Fri, 16
 Dec 2022 11:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20221216143609.186415-1-acme@kernel.org>
In-Reply-To: <20221216143609.186415-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Dec 2022 13:41:24 -0600
X-Gmail-Original-Message-ID: <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
Message-ID: <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.2: 1st batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 8:36 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>         This time there is a trivial resolution of a merge conflict
> related to commit c302378bc157f6a7 ("libbpf: Hashmap interface update to
> allow both long and void* keys/values"), that touched tools/perf/ files.

Normally I'd ask you very sternly to please not resolve merge
conflicts for me, but since I just screwed up another merge due to
being on the road and not having done a full build test, I guess I
will just be quiet this time.

So the real reason for this email is that I get an error like this on
my laptop when trying to build the perf tools:

    INSTALL libbpf_headers
  Traceback (most recent call last):
    File "util/setup.py", line 31, in <module>
      from setuptools import setup, Extension
  ImportError: No module named setuptools
  cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
  make[2]: *** [Makefile.perf:651: python/perf] Error 1
  make[2]: *** Waiting for unfinished jobs....
  make[1]: *** [Makefile.perf:236: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2

and it's not new to this pull - I've seen it before and it's something
stupid I've done.

I think it's a missing package dependency that this laptop then hits.
But considering my previous merge failure, I'm not super-happy about
traveling with a laptop that then can't do this build test.

It would be lovely to have that package dependency - whatever it may
be - tested for explicitly. Hint hint.

           Linus
