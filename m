Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4173ADB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjFWASC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFWAR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:17:56 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3422128
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:17:55 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4007b5bafceso52101cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687479475; x=1690071475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHoAe9cIDc1QJuWRtysL5UB6OfB9G0bH9MDuVg4W10k=;
        b=MbvhppHtjitG1PHoBVIsJl9V7O55xbc93l3YrjeBUBnHDttRI0JfDMreVgCAlaMvIy
         rMgXtEHooNwzOFO2gbGFrgm3LFYlj4aBYYbl8nKTcE6g2GgoYnRjSyz9gijrSyAcJh4m
         ayRDeasTifPGsDSgBUaNZI91qdiXhHaDKkK5jToyVWuCJhrys9pJysT5DWwQk3JEM4hr
         /zSCQd3uuvxA5mGE/NmZXx3as7PLIOBiN5vfexImULSR/vhpuKdULr9BldN9NhcEooDL
         a+G6rAlmCDG9pehdwTTWUzPu7sWa1nKxnvIkFoG5BHc4h3Rhu5r5ozp+UEaTACpvLsD3
         89yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687479475; x=1690071475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHoAe9cIDc1QJuWRtysL5UB6OfB9G0bH9MDuVg4W10k=;
        b=eX1utYSvppAKucPPnxhZOxT0WOOF9uav11b+u8gmE/9z2vHmY43pvnevoot7WRMjWZ
         ycrkZS8Ksf7tgkIOQN3iPOh5+jbcSrUie/HJGejLODrHm5OBgILkctzVEoLkoY5+7Kre
         +EXTHC1Ut7qe36T1B2r8Ens1JTC9GrQ0nDHD47vP8F1lcOhkTKysx1EATvUnZtl1Hkzb
         SCaGzRM04J6z2+ZK3QlobnGrNgDxbk0htNO4m0STEXjriJ0aum5cNNVu+gDjRs433hNT
         t4pyECVD8PstVjkFHE+dLbm6HEcrRW3gk/4qRUsUimmY1atfX3Uf3DRef0G6bi+UdfKN
         goTg==
X-Gm-Message-State: AC+VfDyGfLaXJ+sZ3bofVqhLyWoDMjIeH3DnhmJ0wTECf2GPv4dMF2XG
        VJ+Cu2gsBq52uMQ/LEN+6TvMAT+UyZwS44Uz/fjR8Q==
X-Google-Smtp-Source: ACHHUZ5gEBL3gZineWBwKnYJQZCyd+5F5WfEERGV7oaGZj4IT5RZkTPMcCF7wS/OPxxkaXsZXnJ98+uL/TIccxv9xAU=
X-Received: by 2002:a05:622a:1309:b0:3ed:6bde:9681 with SMTP id
 v9-20020a05622a130900b003ed6bde9681mr23282qtk.0.1687479474878; Thu, 22 Jun
 2023 17:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230622235357.225190-1-namhyung@kernel.org> <20230622235357.225190-2-namhyung@kernel.org>
In-Reply-To: <20230622235357.225190-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 17:17:43 -0700
Message-ID: <CAP-5=fVAsy5GWmvys6+EyeLPcDdbFpJD+EnzPUgh-P_jtnvsdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Set PERF_EXEC_PATH for script execution
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Aditya Gupta <adityag@linux.ibm.com>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>
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

On Thu, Jun 22, 2023 at 4:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The task-analyzer.py script (actually every other scripts too) requires
> PERF_EXEC_PATH env to find dependent libraries and scripts. For scripts
> test to run correctly, it needs to set PERF_EXEC_PATH to the perf tool
> source directory.
>
> Instead of blindly update the env, let's check the directory structure
> to make sure it points to the correct location.
>
> Fixes: e8478b84d6ba ("perf test: add new task-analyzer tests")
> Cc: Petar Gligoric <petar.gligoric@rohde-schwarz.com>
> Cc: Hagen Paul Pfeifer <hagen@jauu.net>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_task_analyzer.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/te=
sts/shell/test_task_analyzer.sh
> index 59785dfc11f8..0095abbe20ca 100755
> --- a/tools/perf/tests/shell/test_task_analyzer.sh
> +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> @@ -5,6 +5,12 @@
>  tmpdir=3D$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
>  err=3D0
>
> +# set PERF_EXEC_PATH to find scripts in the source directory
> +perfdir=3D$(dirname "$0")/../..
> +if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
> +  export PERF_EXEC_PATH=3D$perfdir
> +fi
> +
>  cleanup() {
>    rm -f perf.data
>    rm -f perf.data.old
> --
> 2.41.0.162.gfafddb0af9-goog
>
