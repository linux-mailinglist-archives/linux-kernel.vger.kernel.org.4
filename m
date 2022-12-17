Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7675264FC3D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 21:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLQUhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 15:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 15:37:36 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694A10FC5;
        Sat, 17 Dec 2022 12:37:35 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so7304084fac.2;
        Sat, 17 Dec 2022 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GV309XhbxYSSeC2+ZqrvzrEW3HmvEW82ggRkd0o8EA4=;
        b=Q/3uiWxOsAbl/aTUptwN1WZuHTmIEqU9gfwAZFUDkmDsqIkfDkKGR7AIumTMGnVT1i
         /TPLUihUmqsSEdhHnkh7thr8XYa820zrJXNx4CIJuiPbVvHE65BjRVVHVrpyA99lVwpa
         JvLiJQslzNdFhFxDIkZR4sJIOo2X05t+FMsJkcdLVYQ6bVuDbjS9QeRykwrIhcTDhtoR
         7bUh/kGWy90H4yNfr8+Y7NElrulGXbsAMPIRVVQjPnIpUzzDNoDCn0O7h39Mtmfl7Hb3
         gegClJtXL1zN2KwZz7aOa9X8ss26pYmd8Zieg0nYxtniFLQ+MbfErqB7RgM3yg6m6U8M
         DTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GV309XhbxYSSeC2+ZqrvzrEW3HmvEW82ggRkd0o8EA4=;
        b=E2y7F7ba2G3tJrtx1AzGCx3x042ReDsUOZUhVDiBxdp8LSv7BG35yKBAa1NSA93nHR
         CoKIzK846j+F7ME3QpinORLX33l5upMXVfNS+2Z55GAoMhq49rFMWgXWrQR+I5UwDOXX
         fwfTFUE51V6nGi+naAPhQLdmqiWjQ19ldQR+b/E3Ua+6vuqr01bsw1enmEv/7acHORhZ
         BwJK1242I22kmFwd1X9zne4FS8XaeYLqd0Fr8z8bRz1aeG1IYdPmuuIp0QeS+2PyENFu
         vHyP3GsEf9/dCebg+6gnqMZUDJLmeE3Vd9y6uX3UZeX506njb4Afo/HuOdUAFqL+0rm9
         PieA==
X-Gm-Message-State: AFqh2kpI9Upf+hBEVUQVg4P4BUCZaJXQwHox2qA8IR5/mk53jpBwaRkU
        5S+HA+uZoMBw/6LSgsPtXAM=
X-Google-Smtp-Source: AMrXdXsNTTrT6TNzi4vJWDcbqEpMwQ2wGeFK2Ddn2yzVQcLIRTgM9q/ayZSFZp4KN0/qb8+0vI9IvQ==
X-Received: by 2002:a05:6870:1ec5:b0:144:830f:9dac with SMTP id pc5-20020a0568701ec500b00144830f9dacmr1527900oab.31.1671309454165;
        Sat, 17 Dec 2022 12:37:34 -0800 (PST)
Received: from [127.0.0.1] (187-24-192-125.3g.claro.net.br. [187.24.192.125])
        by smtp.gmail.com with ESMTPSA id t23-20020a0568080b3700b00359ba124b07sm2400158oij.36.2022.12.17.12.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 12:37:33 -0800 (PST)
Date:   Sat, 17 Dec 2022 17:37:28 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [GIT PULL] perf tools changes for v6.2: 1st batch
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjpO5LBx-mVD8+GBj3u7iNJHXn5y4OreKxsoRGi+4vMCQ@mail.gmail.com>
References: <20221216143609.186415-1-acme@kernel.org> <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com> <Y53XHw3rlsaaUgOs@kernel.org> <CAHk-=wjpO5LBx-mVD8+GBj3u7iNJHXn5y4OreKxsoRGi+4vMCQ@mail.gmail.com>
Message-ID: <67193F2E-ED6B-4EE3-A69E-A09DBC73AF69@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On December 17, 2022 4:55:25 PM GMT-03:00, Linus Torvalds <torvalds@linux-=
foundation=2Eorg> wrote:
>On Sat, Dec 17, 2022 at 8:50 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> The python3-setuptools package is needed to build the python binding, s=
o
>> that one can use things like:
>
>So this fixes the error, but there's some other reason for it=2E
>
>I have
>
>  Package python3-setuptools-59=2E6=2E0-3=2Efc36=2Enoarch is already inst=
alled=2E
>
>and with that patch the 'perf' build now works for me, but it says:
>
>    Makefile=2Econfig:898: Missing python setuptools, the python binding
>won't be built, please install python3-setuptools or equivalent
>
>and then (pre-existing)
>
>    Makefile=2Econfig:921: Python interpreter too old (older than 3=2E6)
>disabling jevent generation
>
>but I have
>
>    python3-3=2E10=2E8-3=2Efc36=2Ex86_64
>
>Now, for some reason I *also* have python2 installed, but that one is
>called "python2"=2E
>
>[ Me trying to figure things out ]
>
>Ok, so if I uninstall my old python2 install, I now get
>
>  Makefile=2Econfig:880: No python interpreter was found: disables
>Python support - please install python-devel/python-dev
>  Makefile=2Econfig:915: No python interpreter disabling jevent generatio=
n
>
>ok, so I didn't have 'python3-devel' installed=2E Installing that fixes
>some things, but then I get
>
>  Makefile=2Econfig:889: No 'Python=2Eh' (for Python 2=2Ex support) was
>found: disables Python support - please install
>python-devel/python-dev
>
>so apparently perf really wants *both* python2 and python3 installed=2E
>Isn't that a bit excessive?

Well, perf used python2, then python3 became and option, had to be explici=
tly selected, then the default moved to python3=2E

Now probably the sensible thing is to get rid of all things related to pyt=
hon2, I'll spend some time on this=2E=2E=2E

>Anyway, it's clearly something about the install on this laptop, but
>the error messages and the "this package is missing" things are
>clearly not entirely right=2E
>
>Whatever=2E It does build cleanly now for me, and I'll ignore that "No
>'Python=2Eh' (for Python 2=2Ex support)" thing=2E

Ok, thanks for testing it=2E

- Arnaldo=20
