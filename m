Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1006F5CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjECRQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjECRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:16:48 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAED72A6
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:16:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33164ec77ccso120925ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683134199; x=1685726199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hTF/f5W7mfhVcIgHt1rtu4BQKXkWNpqlFd5KseezRg=;
        b=xPQ37BEIl/tb3mZYi/MgDlp7F++MBNnSq6R2tLfSlo+brHoyfTjpqdxqW7mXeAofUG
         iSSdKCaoSwmtDN2ovf/MQgupDgyBI6GpuDSKON5wCOvF8VHe+S3M1EbESa00FEhhlxUo
         J1ZSVWsu9hZ8aNT2VlbtLucMWuerP/WYoyIMevRlarweob6j2e3B+vU/1Rn7LHdESiaZ
         PyWfA3axGuabIJX68kYm4/9G894KYAWQXICg0z7CB06tNsOAiAxQRgIsvoYZtTT++XDQ
         7HbfBRjLVjzttHkJkHyP0y3oip+DWWq4Div9GpaYkQS2yyP/97AKVzjwxpiyhjupgSIU
         dm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683134199; x=1685726199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hTF/f5W7mfhVcIgHt1rtu4BQKXkWNpqlFd5KseezRg=;
        b=AOu9YZt2FDP+eYbJXxM1GcTtuOwYascRcKFeMwzE2tlgceL+wL15PBB2pepNnKmp9Z
         Azv/jpPdrz1BcWrz//EIsD30dnoqwk5avOeNQoL5VKla37XwpN+pF8IS7E3EsCq7P3la
         IhVTNFx2l6R0jqPypWCxSuZy2GWjr1PaLPuHrTm9xgyIShhbx4Q4HyFSP/P2VaOSZ+zn
         VgD+Nn1pC+REiLPl9lvNMbQm615qGmL1EcwZF1z6jfaq5cBgEdixus5N4GVB9Kj55Us5
         V26hzYR3Wyn3jMYuFLm7AALCPIRBy0876+l0WYnnHBTEqLXnxQpi8xmEPn9G4qb7Ahgw
         UF9Q==
X-Gm-Message-State: AC+VfDwEgVxYWaUsaAcPr+/0o+jg6CoqfY/hiP1EY7Rex2YNivbBNjuF
        CN4YRdnPtA7KDVB8Vs1b5c6b+bYCaaIM5SgSn4NqDsP9c+DJI3C/ba5bCQ==
X-Google-Smtp-Source: ACHHUZ5ArHdDqvETOAHPW/PSJlKZ2gSYno2r8SpqcRkHPNaNBE4NgclTgDUti4HHkkV3AOKuV7GsH+nNb/D8BBdigas=
X-Received: by 2002:a05:6e02:1569:b0:32a:db6c:d4f3 with SMTP id
 k9-20020a056e02156900b0032adb6cd4f3mr400922ilu.10.1683134198851; Wed, 03 May
 2023 10:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230502203135.24794-1-jinli.xiao@nyu.edu> <CAP-5=fV-RZGwcM8+dMCsqwK_1aFERrvQ1sLJfUCA+kBFMEdoDw@mail.gmail.com>
 <CAExMFzgmcQqnVSBj9+YVr2UAkUg8CHdpLjQJF6CuOaWdcMbqDQ@mail.gmail.com>
In-Reply-To: <CAExMFzgmcQqnVSBj9+YVr2UAkUg8CHdpLjQJF6CuOaWdcMbqDQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 May 2023 10:16:27 -0700
Message-ID: <CAP-5=fWy5AztcN3MZyiNcSkbpdNws0cevarfYwt0TWqhyf3eEw@mail.gmail.com>
Subject: Re: [PATCH] perf python: Set error messages on call failure
To:     Jinli Xiao <jinli.xiao@nyu.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 7:27=E2=80=AFPM Jinli Xiao <jinli.xiao@nyu.edu> wrot=
e:
>
> Thanks for the prompt response!
>
> On Tue, May 2, 2023 at 4:37=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Nice! Would it be possible to test this? We could do a shell test
>
> All my changes in this patch is just setting the error message that
> can be interpreted by Python just before the bindings return.
>
> I am not sure about shell test, but I can do something like
>
> [root@nyu-lexis linux]# export PYTHONPATH=3D~jinli/linux/tools/perf/pytho=
n/
> [root@nyu-lexis linux]# python3
> Python 3.11.2 (main, Feb  8 2023, 00:00:00) [GCC 12.2.1 20221121 (Red
> Hat 12.2.1-4)] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import perf
> >>> thread_map =3D perf.thread_map(9999)   # a non-existent pid in /proc
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> FileNotFoundError: [Errno 2] No such file or directory
>
> whereas the original output is
>
> >>> thread_map =3D perf.thread_map(9999)
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> SystemError: <class 'perf.thread_map'> returned NULL without setting
> an exception
>
> Upon testing I did find some of the changes unnecessary. I will submit
> a new patch to this.
>
> This is my first time contributing so please let me know if I did
> anything wrong :)

Everything is good with your patch. I'm keen that we try to make sure
we have coverage with tests. We have other shell tests that run
python:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/tests/shell/stat+json_output.sh?h=3Dperf-tools-next
So I wonder we can start doing what you did in your example and then
just assert we get a FileNotFoundError in the python. The shell script
is really just a way to run the python and can follow the example in
the link. Sound good?

Thanks,
Ian

> Best wishes,
> Jinli
