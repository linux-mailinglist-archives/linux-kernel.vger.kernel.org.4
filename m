Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA13A5E8020
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiIWQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiIWQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:45:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D993118DC6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:45:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so5632594wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mOJBFjRRTQOLMhXeuWiEa3iVJxoMFGP8tXYc65hDHv4=;
        b=KI6qxW+rqSa88pnT9BHcMzTYQ/EPlGQMkmepwufMnKjb8Grb092QhNVKTREgMoHF0E
         P7Ik7btej3gGALjuaMQWArzO95vir14IXvpdNcv1xz8skHm2QXjJrQNKPGPEWoIGEAKd
         xy7+wjI1etv80s9EENeAbcPEV/r9aWfJ9LXdCmxp3gI1/aNq0NR5jQfGbA40Yc26l/Ku
         dNwDh2vY5boD9JqtqAuH708KBq+GBDWbXt147hWRI1kF9ARpcvk7DuCH3LPbjfrheF1l
         dOOFPypylFxe1f0fKBO+Vo9jtrzArO5bEC911Q7HsvzaIPIOm6vEdVQvKg1jbnQpWCl0
         CuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mOJBFjRRTQOLMhXeuWiEa3iVJxoMFGP8tXYc65hDHv4=;
        b=Pu1l2AktQm61XNxEpNuSWSQAZvaIi6kQAELUHSoiDX8moO/t9ymuYx2WhXJhPvUxLk
         Hy/d2Ar54y50rtmiAaFcTFZihtApFgKHUHQqKBaEbF206yqrfJ3dWT1ZQt0ylWjeka2Q
         3d8UP4Xet+/w8ZMj94LIofFHn9N4A8RbJOp7c9nLeDouPmO+22An6gOWKTyikz/mwbH4
         eeduhRqZpSwuHIFO8NkwZIoHwnTzeWyqZSNObX4U4lbGJ+S8eidh9+67lxNqM8IHTQtu
         NHbMTJPyQnQM333KL+AvJOfjIFvFRXXCLYZoUl96GyD3G/MFltTvmAJU2ogN/WbO4xJR
         Jwsg==
X-Gm-Message-State: ACrzQf0SaxNYNMDjBaUNbz9DbuMN6+CDwnAYvcW+QDwzB7KzKjss2eij
        co1NbsSVX3cVOFzvWB6YUQxxRAdtV/p8OZQUGW20Ag==
X-Google-Smtp-Source: AMsMyM5/YN20pETls7iMs8r2+NepnIOp044ol2iYCi6uj3oVv5XELolt3qWypHDMCWdVyZbTE4EhOYkJjAxzgEc8d5Q=
X-Received: by 2002:a05:600c:2181:b0:3b4:74e4:16f8 with SMTP id
 e1-20020a05600c218100b003b474e416f8mr6312587wme.174.1663951531528; Fri, 23
 Sep 2022 09:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220923063205.772936-1-namhyung@kernel.org>
In-Reply-To: <20220923063205.772936-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 09:45:19 -0700
Message-ID: <CAP-5=fWwNwtocMR3s1Su2k2vZAwL4yhX19UGZ4i0dMXFDFFBJA@mail.gmail.com>
Subject: Re: [PATCH v4] perf tools: Get a perf cgroup more portably in BPF
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The perf_event_cgrp_id can be different on other configurations.
> To be more portable as CO-RE, it needs to get the cgroup subsys id
> using the bpf_core_enum_value() helper.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Would be good to get this into perf/urgent, does it need Fixes tags for that?

Thanks,
Ian

> ---
> v4 changes)
>  * add a missing check in the off_cpu
>
> v3 changes)
>  * check compiler features for enum value
>
> v2 changes)
>  * fix off_cpu.bpf.c too
>  * get perf_subsys_id only once
>
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 11 ++++++++++-
>  tools/perf/util/bpf_skel/off_cpu.bpf.c      | 18 ++++++++++++++----
>  2 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index 292c430768b5..8e7520e273db 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -48,6 +48,7 @@ const volatile __u32 num_cpus = 1;
>
>  int enabled = 0;
>  int use_cgroup_v2 = 0;
> +int perf_subsys_id = -1;
>
>  static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>  {
> @@ -58,7 +59,15 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>         int level;
>         int cnt;
>
> -       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
> +       if (perf_subsys_id == -1) {
> +#if __has_builtin(__builtin_preserve_enum_value)
> +               perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
> +                                                    perf_event_cgrp_id);
> +#else
> +               perf_subsys_id = perf_event_cgrp_id;
> +#endif
> +       }
> +       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
>         level = BPF_CORE_READ(cgrp, level);
>
>         for (cnt = 0; i < MAX_LEVELS; i++) {
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index c4ba2bcf179f..38e3b287dbb2 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -94,6 +94,8 @@ const volatile bool has_prev_state = false;
>  const volatile bool needs_cgroup = false;
>  const volatile bool uses_cgroup_v1 = false;
>
> +int perf_subsys_id = -1;
> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> @@ -119,11 +121,19 @@ static inline __u64 get_cgroup_id(struct task_struct *t)
>  {
>         struct cgroup *cgrp;
>
> -       if (uses_cgroup_v1)
> -               cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
> -       else
> -               cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
> +       if (!uses_cgroup_v1)
> +               return BPF_CORE_READ(t, cgroups, dfl_cgrp, kn, id);
> +
> +       if (perf_subsys_id == -1) {
> +#if __has_builtin(__builtin_preserve_enum_value)
> +               perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
> +                                                    perf_event_cgrp_id);
> +#else
> +               perf_subsys_id = perf_event_cgrp_id;
> +#endif
> +       }
>
> +       cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_subsys_id], cgroup);
>         return BPF_CORE_READ(cgrp, kn, id);
>  }
>
> --
> 2.37.3.998.g577e59143f-goog
>
