Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27905E59C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIVDyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIVDyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:54:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD965E30E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:54:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t7so13359442wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+nbxYVavq3q0TaenlbyH+UzQrM3Ew+mNggt9HV7GoWQ=;
        b=BBophp3vKNv4mylG+nTeJbkyALHALfC0PlcDcV7svV3o9I/G1H2kaMG9wC3qr/rAIk
         W+DWUVLCT/+WFE1CkFXPNg4gzSM8qUujV+sO1jNz3aQcAPnO6hoT3bGcIuxh1CPoL3Cs
         eZQIk6gQ0E2j1QN+DGCmEWLY1kCN/Cm1wMCns5YFzrBGmdQWbhV42KISd7myBeKqlhlc
         +9oGQjndz3JYUI5MM6gG0+keMwuElHlUunnYvSU1K3k1kKs6EfQwiu9lYkexE4cHgX1r
         RZJaqBHfSIZhA6QHjGOu0I9t4TKun8vTFRoA6tEL2kv2pMQdWNHqTwWfB0kmNUH7BmGi
         uVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+nbxYVavq3q0TaenlbyH+UzQrM3Ew+mNggt9HV7GoWQ=;
        b=udnEcg1DaPrBq3e897oQnXWp9THA0J8h5ZIL+DbzGGqgB928jgOPrkvXFz8jkYoVq2
         moACcqXz/Lk/i68LwkomwYXkTjhx2VrjSV9r8NdckpnbtxNcAU9xk2SQHiVlq3D1brX5
         qzTTDtRjjuk6iodHuwEJ9NthxISH8RBQwoyAEivhnQZNCMlFkiW2IArRKp3/0FKaRHlx
         HDoG0wnl//WRB/krJDRGIK2eJxCNkFnUFZASjiDta0iZXQASq9LExNSJ+blqj8B24rX8
         S8Ki8+xFiV1eDdcGTwW/2vME0B7XN2qUypeWcD5z+50XHNtQse9gOCikNreGUCuSHxC+
         qekw==
X-Gm-Message-State: ACrzQf0+aPHuHebIgYxLqXdJcxh4D65Rq21tOo/54oFucIUyI5FQJF7P
        hp80Usf9WyNxt+dcyfIlRvZhztxIm8WQLayNcbDAag==
X-Google-Smtp-Source: AMsMyM6+2oNmhqB6l1T5dW11lXxbEjX88sqnKjMa+25f7jDeWsujYJY6akonH3mCiOxgutMRbjBil7Kjr3aP7RYiSsI=
X-Received: by 2002:adf:bc13:0:b0:228:6d28:d2cb with SMTP id
 s19-20020adfbc13000000b002286d28d2cbmr596093wrg.375.1663818841677; Wed, 21
 Sep 2022 20:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220922033349.2908447-1-namhyung@kernel.org>
In-Reply-To: <20220922033349.2908447-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Sep 2022 20:53:49 -0700
Message-ID: <CAP-5=fW5aDW0_t-u9tOy_-AgDQdz5ybOjMVUXqA-Hm0R8sSSSg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Get a perf cgroup more portably in BPF
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 21, 2022 at 8:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The perf_event_cgrp_id can be different on other configurations.
> To be more portable as CO-RE, it needs to get the cgroup subsys id
> using the bpf_core_enum_value() helper.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index c72f8ad96f75..35a8e38d3ee3 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -57,8 +57,10 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>         __u32 *elem;
>         int level;
>         int cnt;
> +       int perf_id;
>
> -       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
> +       perf_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);
> +       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_id], cgroup);

LGTM, do we need the same fix in off cpu?
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/bpf_skel/off_cpu.bpf.c?h=perf/core#n123

Thanks,
Ian

>         level = BPF_CORE_READ(cgrp, level);
>
>         for (cnt = 0; i < MAX_LEVELS; i++) {
> --
> 2.37.3.968.ga6b4b080e4-goog
>
