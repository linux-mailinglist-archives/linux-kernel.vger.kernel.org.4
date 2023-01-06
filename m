Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53266031E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjAFP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjAFP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:28:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7EE6C283
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:28:14 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p24so1956855plw.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bocA/TqNTCY9bT9BZNYWdlMWVOJ5TWiEJMmeL4GDHfk=;
        b=U2FKuo7KGrbeB/2tfcv6s3Jn/qkHx1JmAW2EiEWH11Or4Q0M9LRUFbT9bc7NsYacya
         Lh9rtCyQ4ztWc+xspZDiRRb52YI/tvqb8+U9uxJAnl2sVvjLwtmiNyrlkTZtgFEnBVUq
         o8QeXSVOGQP2EPZNpakp4qrbEz7FtjZ34VudTgOMz4tYUdJzHbX4OqvVNArawjYe04hN
         hBeH9n+1la3DmDg+8A3N5zGXbSvuHhMRQXsu5cJmgJKNmwc3KPOiQV9KEeTa8NeYb/s2
         gm2PETvYQmcpryz/z4SL3eaDDUU2IsO0mPAc/EOhm1r1VBUEn1+xsbCQgLNkrJ5uxOvw
         XXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bocA/TqNTCY9bT9BZNYWdlMWVOJ5TWiEJMmeL4GDHfk=;
        b=LKTfmh6zv+ux17SzvxdM7r1q0YhSpdd286r5Q965VEK7+ZGw02I2HYFtlxKrIvMeKJ
         xOAGuynU3oRtKqejyjN3hDbpb2anCzw1C4DHXrjfXEGwA1fxSlKjLkyWlLYEkEWUSQ/m
         UJ7qxUUgBpjFeIuBs13FVA8Z7QoAOO7hMBQcGp+fX8ei/twKas7XoIvHFQVmn6OTMq/g
         z2wnyRYeWSYafPfvbvuXUd83ZZ8A3+HbrSfEAhdvWQ1Q8yOelZxF2AzaD5E3jJDlM8o7
         MbUPt7nRjiBDrY4qZ+tv03ZxAAO0RSjBMudsLEAOAnNPu9/yhQ6lYEbTCCc/22QXnyud
         5tIg==
X-Gm-Message-State: AFqh2koP8FvmANqAfsjC92rC2aliliFw/bfMRMt30e+zgjL++TXk9Rlf
        Ytzgo6mA/rXymcgreDLx+O+tzuyi3C9PY1UBIfPKCA==
X-Google-Smtp-Source: AMrXdXt3aAQLn/49mU5FJAziQWZ84p9K0urbQeNMtQloyn1Vu8hBaUgWRpehschFJPekjnNzjPM/DAn5qBavwYl4QAM=
X-Received: by 2002:a17:90a:bd12:b0:225:b164:8874 with SMTP id
 y18-20020a17090abd1200b00225b1648874mr4192893pjr.87.1673018894418; Fri, 06
 Jan 2023 07:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20230106151320.619514-1-irogers@google.com>
In-Reply-To: <20230106151320.619514-1-irogers@google.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 6 Jan 2023 15:28:03 +0000
Message-ID: <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2023 at 15:13, Ian Rogers <irogers@google.com> wrote:
>
> Including libbpf header files should be guarded by
> HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
> under HAVE_BPF_SKEL.
>
> Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
> Reported-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c    | 2 ++
>  tools/perf/util/bpf_counter.h | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 86e06f136f40..d21fe0f32a6d 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -16,7 +16,9 @@
>
>  #include "util/record.h"
>  #include <api/fs/tracing_path.h>
> +#ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/bpf.h>
> +#endif
>  #include "util/bpf_map.h"
>  #include "util/rlimit.h"
>  #include "builtin.h"
> diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> index 4dbf26408b69..c6d21c07b14c 100644
> --- a/tools/perf/util/bpf_counter.h
> +++ b/tools/perf/util/bpf_counter.h
> @@ -4,9 +4,12 @@
>
>  #include <linux/list.h>
>  #include <sys/resource.h>
> +
> +#ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/bpf.h>
>  #include <bpf/btf.h>
>  #include <bpf/libbpf.h>
> +#endif
>
>  struct evsel;
>  struct target;
> @@ -87,6 +90,8 @@ static inline void set_max_rlimit(void)
>         setrlimit(RLIMIT_MEMLOCK, &rinf);
>  }
>
> +#ifdef HAVE_BPF_SKEL
> +
>  static inline __u32 bpf_link_get_id(int fd)
>  {
>         struct bpf_link_info link_info = { .id = 0, };
> @@ -127,5 +132,6 @@ static inline int bperf_trigger_reading(int prog_fd, int cpu)
>
>         return bpf_prog_test_run_opts(prog_fd, &opts);
>  }
> +#endif /* HAVE_BPF_SKEL */
>
>  #endif /* __PERF_BPF_COUNTER_H */
> --
> 2.39.0.314.g84b9a713c41-goog
>


This version builds fine too.

Mike
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
