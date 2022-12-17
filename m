Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3264FC2B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 20:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLQTzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 14:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLQTzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 14:55:46 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CFD50
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 11:55:44 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bw27so3255699qtb.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 11:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hEYc0QE7ZD1TAxxoapZp+W9lHOSvsVlKejfIzQTWxVE=;
        b=ZPZZfrznc83pjOzvWQt4ilzCrQNAwVEj92xcbWzsjnssjnmIgxbAEz367jD784kfSa
         OpMrkmPrgFZKsiNPD2Hu6r/qDj9CIg6GNPS1wJVcjxHEqNIlPrwf51FA/fdp5uWRwGY0
         QGo3J7TSXFHIUSJgiZx34DqmYlDI3JDBT/ATk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEYc0QE7ZD1TAxxoapZp+W9lHOSvsVlKejfIzQTWxVE=;
        b=aXDbTmMZfo4+yZp4jlPCAA6d2g8YpotLKofPfnZ+KV5dEUhg5Vi408kUyFnPeT8+sg
         YEuKW5+9jX4mANiUx+36nLAsMDKAGqz0JFD1l+JwsW7ps5wQl21b3Cj3Dr+PxlFuQ1NN
         /W2D82F3ukpecfvslHsivKLtoJPGJr7NXPA2wO4ltNBhb88O2SX7TgJqWfd1HUAzAIxa
         8V24J7U6qzLC5+3nGSITyqUqZ51rHGBK/p+4UuKsCXmEXkCOlVtzTo/jkXOWKs9R1Idl
         cFDvhMtLljeU8RbQ98ednQ6e2vNCs6QLNEKH1ca6Zm8KepvThWIZWBJSjtWPTe0FUkuz
         iZLQ==
X-Gm-Message-State: ANoB5pluLiAexEeGrdJzPpYx4LEt+2mlU5KdtSXiq9W1nYZBBIkt7DxN
        fuNctI35RgT9h5g61URf40v3Ad8jhemFJ6qm
X-Google-Smtp-Source: AA0mqf6sOZZqKfzYUwDN1DBeqIztMcsJNO/4MbouRcXn6Dv+i/KY5C6rEb/Nfso3QFabN5Cn0i8ypA==
X-Received: by 2002:ac8:488e:0:b0:3a8:1793:76d6 with SMTP id i14-20020ac8488e000000b003a8179376d6mr29454318qtq.68.1671306943403;
        Sat, 17 Dec 2022 11:55:43 -0800 (PST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id n21-20020ac86755000000b0039cc944ebdasm3422161qtp.54.2022.12.17.11.55.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 11:55:42 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id a17so3864417qvt.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 11:55:42 -0800 (PST)
X-Received: by 2002:a05:6214:390c:b0:4c7:7282:5817 with SMTP id
 nh12-20020a056214390c00b004c772825817mr15407004qvb.94.1671306941737; Sat, 17
 Dec 2022 11:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20221216143609.186415-1-acme@kernel.org> <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
 <Y53XHw3rlsaaUgOs@kernel.org>
In-Reply-To: <Y53XHw3rlsaaUgOs@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Dec 2022 13:55:25 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjpO5LBx-mVD8+GBj3u7iNJHXn5y4OreKxsoRGi+4vMCQ@mail.gmail.com>
Message-ID: <CAHk-=wjpO5LBx-mVD8+GBj3u7iNJHXn5y4OreKxsoRGi+4vMCQ@mail.gmail.com>
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

On Sat, Dec 17, 2022 at 8:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> The python3-setuptools package is needed to build the python binding, so
> that one can use things like:

So this fixes the error, but there's some other reason for it.

I have

  Package python3-setuptools-59.6.0-3.fc36.noarch is already installed.

and with that patch the 'perf' build now works for me, but it says:

    Makefile.config:898: Missing python setuptools, the python binding
won't be built, please install python3-setuptools or equivalent

and then (pre-existing)

    Makefile.config:921: Python interpreter too old (older than 3.6)
disabling jevent generation

but I have

    python3-3.10.8-3.fc36.x86_64

Now, for some reason I *also* have python2 installed, but that one is
called "python2".

[ Me trying to figure things out ]

Ok, so if I uninstall my old python2 install, I now get

  Makefile.config:880: No python interpreter was found: disables
Python support - please install python-devel/python-dev
  Makefile.config:915: No python interpreter disabling jevent generation

ok, so I didn't have 'python3-devel' installed. Installing that fixes
some things, but then I get

  Makefile.config:889: No 'Python.h' (for Python 2.x support) was
found: disables Python support - please install
python-devel/python-dev

so apparently perf really wants *both* python2 and python3 installed.
Isn't that a bit excessive?

Anyway, it's clearly something about the install on this laptop, but
the error messages and the "this package is missing" things are
clearly not entirely right.

Whatever. It does build cleanly now for me, and I'll ignore that "No
'Python.h' (for Python 2.x support)" thing.

              Linus
