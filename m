Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4826B86CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCNAUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCNAUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:20:01 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705776F7C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:19:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id v10so5744855iox.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678753196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP4A0Z4pABC2At3GPv6v7mFtxTHBPUiFaznBu25M5GI=;
        b=eLIgDhMFdf29MK/EhIS/S96KCTQRjWqkcyTHw2uooQILj2JV0quSF+ZeG7D7pVFIs8
         3qjIvnFVln4YSgGMbaOlABVVQH4jutJzNzybot4rUF3gMlsZPCLRuH78MOPNkfZNsDS2
         3Ge0vLQ/T3EBegKdytK2xNPZS9HFUvXS79DUgTd8iDbvNU80qU+fkXDtCwGO1kQzxvAo
         fOh7nOCHhyjK0IY4iokqO0EgMCAKVBMOeV1pObNSncjFXPpF6glp2aFy7gOd+YKaMCdy
         XwlliBnKAHJykkz0hXfkYlFpNOo6433I8RJUScS4X8dmgLdyApHkrNVkfyZ9TyqQpzS6
         JOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678753196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP4A0Z4pABC2At3GPv6v7mFtxTHBPUiFaznBu25M5GI=;
        b=7GAdqCb8KLMQX+wfK2h0sKqPkqYqr27giL7oZGEjplQm/0VCdY6nsUNCACLDaYO1D7
         1Li/6QPHscovPL3JVdxMWEQCzLJUx9IHUyjaaHzZLlSUTBg2Cm/nk1vw44TiXDi38HER
         DIkToxOfPPHswvWoMeMev6aRxo194ha0bH7EQBgi2apngfKzNgsYiPCQ9LW9eomN8X+j
         knZ18/rtNFM6R0tlDOs4SOI6Oz0zu/jdOFPnODzlJpLjkZa62N5ddXk4z+MnKg9C9NSX
         kErFYdxOaKvh9HLqrQLLxeZODoj5Ys2Ce4vLo4YEs5fIY51Q86oCeUeQyQhpFkqo+L7C
         77KQ==
X-Gm-Message-State: AO0yUKX4X5P9FUvKbioPZndC6ilR554wnRPocVifkEVjRCPTc3P6gu5M
        HSMW6TPXQ7AY+INSEoyaKZKaSUSzxkmiexs5yFA6hw==
X-Google-Smtp-Source: AK7set+VOUg4+1LlW0+kyxZXp9m9/2x7QeNM7F7R1fKV57okCNje8/XDQaeJ8EuZ9TNUmmiW1KyVpOFeHetv6euhD2A=
X-Received: by 2002:a5d:960e:0:b0:74c:8ba9:290e with SMTP id
 w14-20020a5d960e000000b0074c8ba9290emr16317693iol.2.1678753196303; Mon, 13
 Mar 2023 17:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <20230116010115.490713-3-irogers@google.com>
 <ZA+RUCE4vAgBlQRh@kernel.org> <ZA+X14KllWXrlr7C@kernel.org>
In-Reply-To: <ZA+X14KllWXrlr7C@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 17:19:45 -0700
Message-ID: <CAP-5=fWFYVyCCH19XrFSk0hwPoxGkWKJ=vyjrWNroFWzBZ-S2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf build: Remove libbpf pre-1.0 feature tests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 13, 2023 at 2:38=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Mar 13, 2023 at 06:10:40PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Sun, Jan 15, 2023 at 05:01:14PM -0800, Ian Rogers escreveu:
> > > The feature tests were necessary for libbpf pre-1.0, but as the libbp=
f
> > > implies at least 1.0 we can remove these now.
> >
> > So I added this:
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 8b0bd3aa018ef166..b715cd4f43f4a014 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -580,7 +580,7 @@ ifndef NO_LIBELF
> >            EXTLIBS +=3D -lbpf
> >            $(call detected,CONFIG_LIBBPF_DYNAMIC)
> >          else
> > -          dummy :=3D $(error Error: No libbpf devel library found, ple=
ase install libbpf-devel);
> > +          dummy :=3D $(error Error: No libbpf devel library found or o=
lder than v1.0, please install/update libbpf-devel);
> >          endif
> >        else
> >          # Libbpf will be built as a static library from tools/lib/bpf.
> >
> > To better reflect the failure reason:
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next=
/feature/test-libbpf.make.output
> > test-libbpf.c:5:2: error: #error At least libbpf 1.0 is required for Li=
nux tools.
> >     5 | #error At least libbpf 1.0 is required for Linux tools.
> >       |  ^~~~~
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ rpm -q libbpf-devel
> > libbpf-devel-0.8.0-2.fc37.x86_64
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > I'll see if I can make the build test conditional on libbpf being >=3D =
1.0
>
> I'm trying with this:
>
> =E2=AC=A2[acme@toolbox libbpf]$ git log --oneline -1 9476dce6fe905a6bf1d4=
c483f7b2b8575c4ffb2d
> 9476dce6fe905a6b libbpf: remove deprecated low-level APIs
> =E2=AC=A2[acme@toolbox libbpf]$ git tag --contains 9476dce6fe905a6bf1d4c4=
83f7b2b8575c4ffb2d
> v1.0.0
> v1.0.1
> v1.1.0
> =E2=AC=A2[acme@toolbox libbpf]$
>
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 531324c3dab594e1..f866c58b916f4d7a 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -63,6 +63,7 @@ endif
>
>  has =3D $(shell which $1 2>/dev/null)
>  python_perf_so :=3D $(shell $(MAKE) python_perf_target|grep "Target is:"=
|awk '{print $$3}')
> +old_libbpf :=3D $(shell grep -q LIBBPF_DEPRECATED /usr/include/bpf/bpf.h=
)

I think this could also be:
old_libbpf :=3D $(shell grep MAJOR /usr/include/bpf/libbpf_version.h
2>&1 |grep -q  0)
Which may be a bit more intention revealing and future proof.

Thanks,
Ian

>  # standard single make variable specified
>  make_clean_all      :=3D clean all
> @@ -151,7 +152,9 @@ run +=3D make_no_libaudit
>  run +=3D make_no_libbionic
>  run +=3D make_no_auxtrace
>  run +=3D make_no_libbpf
> +ifneq ($(old_libbpf),)
>  run +=3D make_libbpf_dynamic
> +endif
>  run +=3D make_no_libbpf_DEBUG
>  run +=3D make_no_libcrypto
>  run +=3D make_no_sdt
