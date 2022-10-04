Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F15F4981
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJDSyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJDSyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:54:32 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA66171E;
        Tue,  4 Oct 2022 11:54:31 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-12c8312131fso17523763fac.4;
        Tue, 04 Oct 2022 11:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WfJuZ1MM9ixd59GolRTFlqGWI5xVHjnnKws4m3pXDM8=;
        b=utMFa5s1KCp1FMcUFSua5OqZRBIwR6vBpftDbL7IDmM7+CDM6HX1csya4dGZK5NPvN
         J1UhzK0+8RnwwlICsU+fv0MugekE6DyGH0/EA7CXZQASaqhi8S0BkbKImOeu+FCmfrbf
         8g9FbtnW91LyU2jApTkcJ9NtNhzgpWxrVJgPtLeCUzJZaOSvDZQXF6yZ1/hayEHEzHAI
         3MBUSRxIya+9x8P8lYrpoIxJrw+XtqT9unn9A28msZGrBIq1dNFlA4sX39qd9vy5s3dL
         gl64jHNEDH5FJ10yOlcsGp8K+rfDECaWq/b9tmrcDqaeux4c82ykN3qewpfN0QvILpc2
         D5dA==
X-Gm-Message-State: ACrzQf2v79T1xuDlEv8oxKAGhl0IibCAntnQi8k6B41pLTtTjE3RAw/X
        nJjeEPe8J8pyWmRH0LoIACrfrnI0GAAXuJ41IP8=
X-Google-Smtp-Source: AMsMyM6qaozBxMUyRSWoDksYAePx6dhRasIIxYqTnv9UckhWhnpwLvwRNx8jYoTwukl9EM9CTp1wofXegnmgJFRtdQE=
X-Received: by 2002:a05:6870:34c:b0:132:8ef2:b6b2 with SMTP id
 n12-20020a056870034c00b001328ef2b6b2mr600631oaf.209.1664909670924; Tue, 04
 Oct 2022 11:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221003181040.4822-1-hcvcastro@gmail.com>
In-Reply-To: <20221003181040.4822-1-hcvcastro@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 4 Oct 2022 11:54:19 -0700
Message-ID: <CAM9d7cgMjZPa9qwuzpG3usGJvKiAQCOvN8_W0RuakNqcZ2t8-g@mail.gmail.com>
Subject: Re: [PATCH v2] perf: fix the probe finder location (.dwo files)
To:     Henry Castro <hcvcastro@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc + Masami

On Mon, Oct 3, 2022 at 11:10 AM Henry Castro <hcvcastro@gmail.com> wrote:
>
> If the file object is compiled using -gsplit-dwarf,
> the probe finder location will fail.
>
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
>
> > Anyway I think it'd be safer to do
> >
> >    if (dwarf_cu_info() == 0 && unit_type == skeleton)
> >        pf->cu_die = subdie;
>
> Thank you, I have modifed the patch :)
>
>
>  tools/perf/util/probe-finder.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 50d861a80f57..b27039f5f04b 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1161,7 +1161,8 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>         struct perf_probe_point *pp = &pf->pev->point;
>         Dwarf_Off off, noff;
>         size_t cuhl;
> -       Dwarf_Die *diep;
> +       Dwarf_Die *diep, cudie, subdie;
> +       uint8_t unit_type;

They will be unused for earlier elfutils.

>         int ret = 0;
>
>         off = 0;
> @@ -1200,6 +1201,14 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>                         continue;
>                 }
>
> +#if _ELFUTILS_VERSION >= 171

Nit, I think we use _ELFUTILS_PREREQ(0, 171).

> +               /* Check separate debug information file. */
> +               if (dwarf_cu_info(pf->cu_die.cu, NULL, &unit_type,
> +                                 &cudie, &subdie, NULL, NULL, NULL) == 0
> +                   && unit_type == DW_UT_skeleton)
> +                       pf->cu_die = subdie;
> +#endif

How about making it a separate function with 2 versions
depending on the elfutils?  Then you can have the variables
only if they are used.

Something like get_source_from_debuginfod() in the same
file.

Thanks,
Namhyung


> +
>                 /* Check if target file is included. */
>                 if (pp->file)
>                         pf->fname = cu_find_realpath(&pf->cu_die, pp->file);
> --
> 2.20.1
>
