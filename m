Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA665479C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiLVVAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiLVVAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:00:20 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDACE00F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:00:19 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-144bd860fdbso3950952fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DpIlyE2bROjJUp2ppqvaIYPhWVpQkGqQ/42Yg+0+V60=;
        b=UMhu4hcewzYul4MoXoCP+cNDfOE2GW29qgISsqnZSvQM6yLP/VikQm3k9Nj8MCv1id
         6upYQ3sx45/luOMPH6EOiWuFyr0JfyzdtlPScONdNEEyt81KvFMxrwO8WINknohMrrA9
         RB56OLLmhmmeJN/oEem/TuXDvyLWLTvIg6/sorp5sxEZ1d9tHdYNj1tjKNoa91mwxgU7
         arBLendiE9Yqf8YnkJzFiTyAYl9G0C4ohPaTjnD6h2+X4zsVbHZE0bUIkKghVANoghid
         ZraAgUD8UDuIlPwz6Vd5LFfGgjBAF84hACNvRnURpplfDPe2iAmIgmFI79iYRoVQKgVa
         uRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpIlyE2bROjJUp2ppqvaIYPhWVpQkGqQ/42Yg+0+V60=;
        b=LjjwNYbs2HTqMYTkJSW0mbAjGa0XAS4De5JVfa5MnmdzWkDni1Pmu3D5qYjEJTVnS0
         i3IqfpXt9ManASKTmPgKKWFUtk6+lHaf6EQ+wIlYGYKYais6rPSBtkEne+DSlDCy86mo
         aSJaexsbJRn33fsl8wLzLKc3o1QPsyo3cJrhMaFQN4BN8yzAqYGHKdCbOVWc+0WJXggn
         L3G2uAmg9PcexjZ6WtxBJ4pegzUoY5Z/r030wE1VuEA52T4DJyTqpXWi2cszB7RRmVF4
         lK2JtBIBJTHMG1waseIYd5nA3wIs280nThvCTKm/7HrTrf8emnvJmN32rVptVo6isC5a
         AHqg==
X-Gm-Message-State: AFqh2kohSREy6Z5vW5koA0FB8iCH8OsRybf/1yeWN6Nije2Yc85Audve
        zRUeiWfHjFmcXPXUP3+7CeE=
X-Google-Smtp-Source: AMrXdXvMNp6mWcTrVtomelQrP8qc63abMy0Xx/FXX9Q86rq0rH514PLn9u97PKCklxNXeeItBZmoXw==
X-Received: by 2002:a05:6870:2a42:b0:14c:ff4b:85da with SMTP id jd2-20020a0568702a4200b0014cff4b85damr2057694oab.42.1671742818365;
        Thu, 22 Dec 2022 13:00:18 -0800 (PST)
Received: from [127.0.0.1] ([187.19.236.93])
        by smtp.gmail.com with ESMTPSA id be4-20020a056870588400b0014866eb34cesm695229oab.48.2022.12.22.13.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 13:00:17 -0800 (PST)
Date:   Thu, 22 Dec 2022 18:00:11 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Khem Raj <raj.khem@gmail.com>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/1_fyi=5D_perf_python=3A_Fix_?= =?US-ASCII?Q?splitting_CC_into_compiler_and_options?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdkivaXffVPPTsceM_et4yOgYy3fuw9TmikcjRhDPyTqRA@mail.gmail.com>
References: <Y6Rq5F5NI0v1QQHM@kernel.org> <CAKwvOdkivaXffVPPTsceM_et4yOgYy3fuw9TmikcjRhDPyTqRA@mail.gmail.com>
Message-ID: <0A5683A4-7838-4073-8CA4-1FAF2E7BE202@gmail.com>
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



On December 22, 2022 2:45:57 PM GMT-03:00, Nick Desaulniers <ndesaulniers@=
google=2Ecom> wrote:
>On Thu, Dec 22, 2022 at 6:34 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Just fyi, I'm carrying this in the perf tools tree=2E
>>
>> - Arnaldo
>>
>> ----
>>
>> Noticed this build failure on archlinux:base when building with clang:
>>
>>   clang-14: error: optimization flag '-ffat-lto-objects' is not support=
ed [-Werror,-Wignored-optimization-argument]
>>
>> In tools/perf/util/setup=2Epy we check if clang supports that option, b=
ut
>> since commit 3cad53a6f9cdbafa ("perf python: Account for multiple words
>> in CC") this got broken as in the common case where CC=3D"clang":
>>
>>   >>> cc=3D"clang"
>>   >>> print(cc=2Esplit()[0])
>>   clang
>>   >>> option=3D"-ffat-lto-objects"
>>   >>> print(str(cc=2Esplit()[1:]) + option)
>>   []-ffat-lto-objects
>>   >>>
>>
>> And then the Popen will call clang with that bogus option name that in
>> turn will not produce the b"unknown argument" or b"is not supported"
>> that this function uses to detect if the option is not available and
>> thus later on clang will be called with an unknown/unsupported option=
=2E
>>
>> Fix it by looking if really there are options in the provided CC
>> variable, and if so override 'cc' with the first token and append the
>> options to the 'option' variable=2E
>>
>> Fixes: 3cad53a6f9cdbafa ("perf python: Account for multiple words in CC=
")
>> Cc: Adrian Hunter <adrian=2Ehunter@intel=2Ecom>
>> Cc: Fangrui Song <maskray@google=2Ecom>
>> Cc: Florian Fainelli <f=2Efainelli@gmail=2Ecom>
>> Cc: Ian Rogers <irogers@google=2Ecom>
>> Cc: Jiri Olsa <jolsa@kernel=2Eorg>
>> Cc: John Keeping <john@metanate=2Ecom>
>> Cc: Khem Raj <raj=2Ekhem@gmail=2Ecom>
>> Cc: Leo Yan <leo=2Eyan@linaro=2Eorg>
>> Cc: Michael Petlan <mpetlan@redhat=2Ecom>
>> Cc: Namhyung Kim <namhyung@kernel=2Eorg>
>> Cc: Nathan Chancellor <nathan@kernel=2Eorg>
>> Cc: Nick Desaulniers <ndesaulniers@google=2Ecom>
>> Cc: Sedat Dilek <sedat=2Edilek@gmail=2Ecom>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>> ---
>>  tools/perf/util/setup=2Epy | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/setup=2Epy b/tools/perf/util/setup=2Epy
>> index 4f265d0222c454e2=2E=2Ec294db713677c0c2 100644
>> --- a/tools/perf/util/setup=2Epy
>> +++ b/tools/perf/util/setup=2Epy
>> @@ -3,11 +3,20 @@ from subprocess import Popen, PIPE
>>  from re import sub
>>
>>  cc =3D getenv("CC")
>> -cc_is_clang =3D b"clang version" in Popen([cc=2Esplit()[0], "-v"], std=
err=3DPIPE)=2Estderr=2Ereadline()
>> +
>> +# Check if CC has options, as is the case in yocto, where it uses CC=
=3D"cc --sysroot=2E=2E=2E"
>> +cc_tokens =3D cc=2Esplit()
>> +if len(cc_tokens) > 1:
>> +    cc =3D cc_tokens[0]
>
>What if someone is using `CC=3D"cache clang"`? Then cc is set to `cache`
>and the cc_is_clang check below will fail=2E

Agreed, but this is a preexisting bug, let's fix this with a follow-up pat=
ch,

- Arnaldo=20


>
>> +    cc_options =3D " "=2Ejoin([str(e) for e in cc_tokens[1:]]) + " "
>> +else:
>> +    cc_options =3D ""
>
>> +cc_is_clang =3D b"clang version" in Popen([cc, "-v"], stderr=3DPIPE)=
=2Estderr=2Ereadline()
>>  src_feature_tests  =3D getenv('srctree') + '/tools/build/feature'
>>
>>  def clang_has_option(option):
>> -    cc_output =3D Popen([cc=2Esplit()[0], str(cc=2Esplit()[1:]) + opti=
on, path=2Ejoin(src_feature_tests, "test-hello=2Ec") ], stderr=3DPIPE)=2Est=
derr=2Ereadlines()
>> +    cc_output =3D Popen([cc, cc_options + option, path=2Ejoin(src_feat=
ure_tests, "test-hello=2Ec") ], stderr=3DPIPE)=2Estderr=2Ereadlines()
>>      return [o for o in cc_output if ((b"unknown argument" in o) or (b"=
is not supported" in o))] =3D=3D [ ]
>>
>>  if cc_is_clang:
>> --
>> 2=2E38=2E1
>>
>
>
