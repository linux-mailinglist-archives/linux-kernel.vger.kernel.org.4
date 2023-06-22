Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E874373A7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjFVRwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjFVRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:52:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC42126
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:51:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40079b6fc56so17121cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456319; x=1690048319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ifv1YUPmw1rjpLUO+8aVeXi33WHx57kQP10Eiyc8BEA=;
        b=pGzyPDsoR6Nbo7+IzntkkjGoXkt81sNnpQwcP3ovN6BKmelaTC1JjasVAivbsJHzaE
         C+aZurEqMUzrl0bXKj12AifXNNgcsl+LiltItThomF+er0kfWKRuFtaGRbj5AznKHq9a
         2W6rcyhOz1E4wUjUZhVoPemF4VvcSwBnJrpDF6J7tUX6GPONK2k36ghPfCeFs6er5YrE
         1w3KA0T96jOu9XktG6kdRT6EV98M+F2TmnVhjfowpUP4GNDCBQgwSAsKa03fDOAu8fbo
         Pyq2bvBvdaKXoUVwgTylOO0ZK8fqV4zwLbGQTbrlsJv62t5H3YXrXCUycjsQRxdCHGkr
         cu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456319; x=1690048319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ifv1YUPmw1rjpLUO+8aVeXi33WHx57kQP10Eiyc8BEA=;
        b=OLDTjdLZHGZ/bSm4dKO+xgmFHsB0a1Co5poBA9ehRNtgK10EEu2cKxVYk9JBzhu3XJ
         5L3bo6l9U35auHtUhuyX2+qZ+nSJoMiWPOP8NpCJfE5RDFac1ewxA++3bgXvl/SgsHb1
         bq1iGfd/gd3IAdadgfGKnDdgcWrImkEUYG6GbX7DyM6TClmbxRlzjZQknUQs63r4H9YC
         vIh/bvFz0pLfwQHnF3tGaHPZtvagwvU9Fab4audVUgkcXkU98CMIvmlGiqUEwEp0jxvv
         dnhJX+uDt/DUkN7oOQiH9lYXjPHk+6y/adqadevUV3S3jRHGeEBAo3aWCbq3GbRsWjWa
         tGEg==
X-Gm-Message-State: AC+VfDw+XWaqsHpV0NaOOiHksYtJXLyoPNM44Nf4HQ7mLJDFZ/It5art
        3POZ1Sk/wB2vylVXlJJ8LE6L3yJoUGvqydwMZKGg9UCPZm0R652659Y=
X-Google-Smtp-Source: ACHHUZ71FvU230Se7n3GVJjL4GWx8zZOuTGUI5jfFA0uvZhPg6EGRRNpWDeLiJfUVTmaj8xi9mhdtTj2G86YUV9Sq3o=
X-Received: by 2002:a05:622a:1212:b0:3ef:302c:319e with SMTP id
 y18-20020a05622a121200b003ef302c319emr986668qtx.8.1687456318813; Thu, 22 Jun
 2023 10:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230622055832.83476-1-namhyung@kernel.org>
In-Reply-To: <20230622055832.83476-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 10:51:47 -0700
Message-ID: <CAP-5=fULkA2G7xWVH9okqEmYMFW_HhjFvtkoxid0YLngBZP4Dg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Remove x permission from lib/stat_output.sh
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
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

On Wed, Jun 21, 2023 at 10:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The commit fc51fc87b1b8 factored out the helper functions to a library
> but the new file had execute permission.  Due to the way it detects
> the shell test scripts, it showed up in the perf test list unexpectedly.
>
>   $ ./perf test list 2>&1 | grep 86
>    76: x86 bp modify
>    77: x86 Sample parsing
>    78: x86 hybrid
>    86:                        <---- (here)
>
>   $ ./perf test -v 86
>    86:                                                                 :
>   --- start ---
>   test child forked, pid 1932207
>   test child finished with 0
>   ---- end ----
>   : Ok
>
> As it's a collection of library functions, it should not run as is.
> Let's remove the execute permission.
>
> Fixes: fc51fc87b1b8 ("perf test: Move all the check functions of stat CSV=
 output to lib")
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/stat_output.sh | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 =3D> 100644 tools/perf/tests/shell/lib/stat_output.sh
>
> diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests=
/shell/lib/stat_output.sh
> old mode 100755
> new mode 100644
> --
> 2.41.0.162.gfafddb0af9-goog
>
