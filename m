Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D096FCCDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjEIRfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjEIRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:35:04 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05640D9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:35:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef34c49cb9so216061cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683653700; x=1686245700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csNU28K6rUC3GBBOB5I2ycRIc++uPT38vtALpeyUntw=;
        b=Ht1Xabs0Np29rRJEyiO346NY3VzYMvsfn8zbpdKY45vpVKVsw7EKNC0BHJhOX1rkwE
         Vb5BR4o5YMK+3tPJ97REpy/dxm4LVtTEgijRlbmco1WLGrA3XJXqoP6a0GHhxZ+ngkSA
         ln0Fu4gc3WK/nJ78NX+LkYFJndbtQMVLSGMrZ7ZS5S5pkiljwO4Q8yU2XYVPCBQjv6uX
         Isp08txP69dedR/wmMX0rO5ibCYGgC0cZfCp2+4glwa4W6WzZHBnrLl12Rxovof/qZXP
         plgP5fIvoH06E9PPiOCfWfzbAPclZdDlupDWRRUI+OraVC/DmAl5Vpcu+1a7stY/Hb4/
         wswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683653700; x=1686245700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csNU28K6rUC3GBBOB5I2ycRIc++uPT38vtALpeyUntw=;
        b=UFniBQHL0iWlTWlUs/A31aj+cH2NLwlu33jZomW1WbzMFHArhis0eYDhlnPPF0dJfV
         2LTtiofNxWySM1LWlVBDLvmMMdTRhisJnf1pxTLkqD5crsZ804HHx/WkRZouLxC4ryJT
         6bWNIpfzCdJaUcmv2znUIkHH1tusLBCI17IAvv5CDMCvyEgvIuVQZzNyz4lx5yEwzAWs
         NCvhbHn+ZI+tumHMHbj1CEn+xl67GFRvTLuaBSYuyYVv0jg3v5hCZmhCTOzldOmL/e9O
         SM6kR5vAiteUIwEymDJTas9gapA11M4femb++ZdA0kNwJWOM8oLGoEqWHUOyT9LF6EYp
         lrsw==
X-Gm-Message-State: AC+VfDxPUewA2ReQVBYypwDWhY+GwScQt2j4zLNs5Dy6YdlqlvInCNfF
        R4dof67fIVGOC4Pwb1PAnmeq7xoxpqbSHnXGBBWSJg==
X-Google-Smtp-Source: ACHHUZ5kf0WSUEBGIBAIC3WC2jvVqNs+vPOsUyL4pyKkzOzOL69ZR2+a2pEcT3v2CRSJPxg+AeMza6pDZUX6DLUuVOQ=
X-Received: by 2002:a05:622a:201:b0:3ef:19fe:230d with SMTP id
 b1-20020a05622a020100b003ef19fe230dmr312590qtx.17.1683653700195; Tue, 09 May
 2023 10:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230509131847.835974-1-tmricht@linux.ibm.com>
In-Reply-To: <20230509131847.835974-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 9 May 2023 10:34:44 -0700
Message-ID: <CAP-5=fVC1bAMk5gOGSXi0sHdetdLHGT2tqW43dxTTyJ3jRz8QA@mail.gmail.com>
Subject: Re: [PATCH] perf/test: reduce run time of perf test Test java symbol
To:     Thomas Richter <tmricht@linux.ibm.com>, jolsa@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, leo.yan@linaro.org, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 6:19=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Test case Test java symbol might run a long time. On Fedora 38 the
> run time is very, very long:
>
>  Output before:
>  # time ./perf test 108
>  108: Test java symbol                  : Ok
>  real   22m15.775s
>  user   3m42.584s
>  sys    4m30.685s
>  #
>
> The reason is a lookup for the server for debug symbols as shown in
>  # cat /etc/debuginfod/elfutils.urls
>  https://debuginfod.fedoraproject.org/
>  #
> This lookup is done for every symbol/sample, so about 3500 lookups
> will take place.
> To omit this lookup, which is not needed, unset environment variable
> DEBUGINFOD_URLS=3D''.
>
>  Output after:
>  # time ./perf test 108
>  108: Test java symbol                  : Ok
>
>  real   0m6.242s
>  user   0m4.982s
>  sys    0m3.243s
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: leo.yan@linaro.org
> Cc: irogers@google.com
> ---
>  tools/perf/tests/shell/test_java_symbol.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/test=
s/shell/test_java_symbol.sh
> index 90cea8811926..499539d1c479 100755
> --- a/tools/perf/tests/shell/test_java_symbol.sh
> +++ b/tools/perf/tests/shell/test_java_symbol.sh
> @@ -56,7 +56,7 @@ if [ $? -ne 0 ]; then
>         exit 1
>  fi
>
> -if ! perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
> +if ! DEBUGINFOD_URLS=3D'' perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j=
; then

Jiri, is this the best way to workaround a debuginfod slowness?

Thanks,
Ian

>         echo "Fail to inject samples"
>         exit 1
>  fi
> --
> 2.40.0
>
