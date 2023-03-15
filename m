Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C156BBA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjCOQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCOQoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:44:09 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A15244AB;
        Wed, 15 Mar 2023 09:43:06 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id bf15so8081125iob.7;
        Wed, 15 Mar 2023 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678898578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSBft//WrRtBDPJzOXFEZFPYTgfp7+pd/pM3cYW2zzg=;
        b=C7UhDTCkyOeNsbk8wuwOqxRXVkEVftD3qV1lyzZhsnAgBZ6aeLtDzPKrcrOfNeNaZg
         WIVrPwKNJcXhpYIik6F29DWrIUOscxwuZh4vk3fC6bNnAlJUNXZWUPCWCfhkcs+KjWAm
         JONsHbscuk5XhFWWehnAtr8lirPY/FpWPnRaA55F5Z1ag58WnJLquVh4zNpNnX2UI+4g
         hdY3X0uGK6gzQgx7tCl4XEoiiu8oC4WCs1fGjI4CCprRaQAo2/46/TTFtXr3f6KuLF6R
         BhV7fg3plA4aewJg5ZR499Lp5pa2axR/e7KIpO42am914C/yoO31gnN2DcFsJ6Vkekfe
         gpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSBft//WrRtBDPJzOXFEZFPYTgfp7+pd/pM3cYW2zzg=;
        b=2rz/PnEFlCTnSqLxT4CudU6m6jlfDo/TRgrtUZlID8bUamfqRuKs+nvzOzZ8qVJS11
         kMRuvz+BBh4A9EYJf0kiv4NB1C1046xgLdoDCStZjUJcoCBczeO5KwzSyzfQwQbu4ovJ
         lw4iYM6Vo+4ZrZf8mt96KbNKrSgxNd/diFgb6WgMLTJD9qA8exhWhGUqiZTwTMTf0koG
         1aPmfzzzyrcgDscgaQaH/b/EfA4Qw1wshiqn5CWez+5MzRERq+9I0F3xYa7F875mN84c
         VGP/mEMJKYD/vBSOQPeCRVReg4EACCw/bL3oRkA1GMwDk19gGNQRxTjXSRDxrSzIN5li
         Q7lg==
X-Gm-Message-State: AO0yUKXO0R4vWBYm9Lgek5pTuP3GyGQWxgYDQv9OnmbR0/x83aKM8lEY
        yL/IFUkeuFhfD57NTuGqskyhV1QODSI2C+4iaEg=
X-Google-Smtp-Source: AK7set9f6ZSV9BGDELF2DOHaZFHc8n3HszWFD7jzL581KtDLytWxbsbANNsvVi8VUiKpUjvFskq+Ey/kw9qlMGZ7eZc=
X-Received: by 2002:a02:84c6:0:b0:405:8be:eaaa with SMTP id
 f64-20020a0284c6000000b0040508beeaaamr4224696jai.5.1678898578430; Wed, 15 Mar
 2023 09:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230315121303.3358416-1-tmricht@linux.ibm.com>
In-Reply-To: <20230315121303.3358416-1-tmricht@linux.ibm.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 15 Mar 2023 09:42:47 -0700
Message-ID: <CAM9d7cg8FJP+P57-reTFjp7t_YX-zS_8_txjx2EuZjmxO7EULg@mail.gmail.com>
Subject: Re: [PATCH] perf/test: Fix wrong size for perf test Setup struct perf_event_attr
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, robh@kernel.org, jolsa@kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 15, 2023 at 5:15=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> The test case ./perf test 'Setup struct perf_event_attr' fails.
> On s390 this output is observed:
>
>  # ./perf test -Fvvvv 17
>  17: Setup struct perf_event_attr                                    :
>  --- start ---
>  running './tests/attr/test-stat-C0'
>  Using CPUID IBM,8561,703,T01,3.6,002f
>  .....
>  Event event:base-stat
>       fd =3D 1
>       group_fd =3D -1
>       flags =3D 0|8
>       cpu =3D *
>       type =3D 0
>       size =3D 128     <<<--- wrong, specified in file base-stat
>       config =3D 0
>       sample_period =3D 0
>       sample_type =3D 65536
>       ...
>  'PERF_TEST_ATTR=3D/tmp/tmpgw574wvg ./perf stat -o \
>         /tmp/tmpgw574wvg/perf.data -e cycles -C 0 kill >/dev/null \
>         2>&1 ret '1', expected '1'
>   loading result events
>     Event event-0-0-4
>       fd =3D 4
>       group_fd =3D -1
>       cpu =3D 0
>       pid =3D -1
>       flags =3D 8
>       type =3D 0
>       size =3D 136     <<<--- actual size used in system call
>       .....
>   compare
>     matching [event-0-0-4]
>       to [event:base-stat]
>       [cpu] 0 *
>       [flags] 8 0|8
>       [type] 0 0
>       [size] 136 128
>     ->FAIL
>     match: [event-0-0-4] matches []
>   expected size=3D136, got 128
>   FAILED './tests/attr/test-stat-C0' - match failure
>
> This mismatch is caused by
> commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
> which enlarges the structure perf_event_attr by 8 bytes.
>
> Fix this by adjusting the expected value of size.
>
> Output after:
>  # ./perf test -Fvvvv 17
>  17: Setup struct perf_event_attr                                    :
>  --- start ---
>  running './tests/attr/test-stat-C0'
>  Using CPUID IBM,8561,703,T01,3.6,002f
>  ...
>   matched
>   compare
>     matching [event-0-0-4]
>       to [event:base-stat]
>       [cpu] 0 *
>       [flags] 8 0|8
>       [type] 0 0
>       [size] 136 136
>       ....
>    ->OK
>    match: [event-0-0-4] matches ['event:base-stat']
>  matched
>
> Fixes: 09519ec3b19e ("perf: Add perf_event_attr::config3")
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/attr/base-record       | 2 +-
>  tools/perf/tests/attr/base-stat         | 2 +-
>  tools/perf/tests/attr/system-wide-dummy | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/ba=
se-record
> index 3ef07a12aa14..27c21271a16c 100644
> --- a/tools/perf/tests/attr/base-record
> +++ b/tools/perf/tests/attr/base-record
> @@ -5,7 +5,7 @@ group_fd=3D-1
>  flags=3D0|8
>  cpu=3D*
>  type=3D0|1
> -size=3D128
> +size=3D136
>  config=3D0
>  sample_period=3D*
>  sample_type=3D263
> diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base=
-stat
> index 408164456530..a21fb65bc012 100644
> --- a/tools/perf/tests/attr/base-stat
> +++ b/tools/perf/tests/attr/base-stat
> @@ -5,7 +5,7 @@ group_fd=3D-1
>  flags=3D0|8
>  cpu=3D*
>  type=3D0
> -size=3D128
> +size=3D136
>  config=3D0
>  sample_period=3D0
>  sample_type=3D65536
> diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/a=
ttr/system-wide-dummy
> index 8fec06eda5f9..2f3e3eb728eb 100644
> --- a/tools/perf/tests/attr/system-wide-dummy
> +++ b/tools/perf/tests/attr/system-wide-dummy
> @@ -7,7 +7,7 @@ cpu=3D*
>  pid=3D-1
>  flags=3D8
>  type=3D1
> -size=3D128
> +size=3D136
>  config=3D9
>  sample_period=3D4000
>  sample_type=3D455
> --
> 2.39.1
>
