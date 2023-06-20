Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AFA737752
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFTWPp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 18:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTWPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:15:43 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F748E7E;
        Tue, 20 Jun 2023 15:15:42 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77de67139ccso240477239f.0;
        Tue, 20 Jun 2023 15:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687299342; x=1689891342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rY6PVpR7o3TFuP4JziuKWXeauOK+7yv/dqaW2WujMlQ=;
        b=RVFTB68I0OCD+ik9HykqtOdbTVBU7rlfJPsS/QNMhBE36xS84JALBMrOtHJYp6US86
         GgWB2NS5U+N29t5d4HeeNMbNcUxzamAHwaqJ/33yjTkoD02t5Dv5g/om0DjCfMLGtzs8
         +XvDG+EYy2GmJN7bV10x4Hk3N4n6h0k4W8g9dbdTPWoCaSrq5br8WKHx315l8gIGYgrE
         TQzAd/+Q6ggaVmUPbQolI0cCWd0zQBry5BjlWDsnFn/YXdnFJwxoxOr4pAIVoEZblUbz
         d/ijjt7f4fVDuBICRmO5OZq8xfWmmQd4NBikSPcIb1rWLhLGAn62fdD6wI5IfgCjIFWl
         90Xg==
X-Gm-Message-State: AC+VfDzjAW0/cOyOEGM6AK1VQ0advMl3L+bk1n6mV8qRLclVa/z1zy2c
        F7qc8ilLrG3NVBLlQsNLIttLusQ8CbkcJyxJ2c4=
X-Google-Smtp-Source: ACHHUZ6ziGrl9UymvMjiNr+y7FEEsmOAbX3YI/mMsoMzNZugV0E9oDvPANZk09oH8Iexocth05lLNZG2rXbkM1w8uxI=
X-Received: by 2002:a5e:dd08:0:b0:76c:595a:6b5f with SMTP id
 t8-20020a5edd08000000b0076c595a6b5fmr9023687iop.20.1687299341696; Tue, 20 Jun
 2023 15:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230615040715.2064350-1-irogers@google.com>
In-Reply-To: <20230615040715.2064350-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 15:15:30 -0700
Message-ID: <CAM9d7cigCUz4i-t2rHaz9Ch0oWxjYWmvnVB73uV1cm+47DtpXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf sharded_mutex: Introduce sharded_mutex
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yuan Can <yuancan@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 9:07 PM Ian Rogers <irogers@google.com> wrote:
>
> Per object mutexes may come with significant memory cost while a
> global mutex can suffer from unnecessary contention. A sharded mutex
> is a compromise where objects are hashed and then a particular mutex
> for the hash of the object used. Contention can be controlled by the
> number of shards.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
> v2. Use hashmap.h's hash_bits in case of contention from alignment of
>     objects.
> ---
>  tools/perf/util/Build           |  1 +
>  tools/perf/util/sharded_mutex.c | 33 +++++++++++++++++++++++++++++++++
>  tools/perf/util/sharded_mutex.h | 29 +++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 tools/perf/util/sharded_mutex.c
>  create mode 100644 tools/perf/util/sharded_mutex.h
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index ff2fd1a36bb8..96f4ea1d45c5 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -145,6 +145,7 @@ perf-y += mem2node.o
>  perf-y += clockid.o
>  perf-y += list_sort.o
>  perf-y += mutex.o
> +perf-y += sharded_mutex.o
>
>  perf-$(CONFIG_LIBBPF) += bpf-loader.o
>  perf-$(CONFIG_LIBBPF) += bpf_map.o
> diff --git a/tools/perf/util/sharded_mutex.c b/tools/perf/util/sharded_mutex.c
> new file mode 100644
> index 000000000000..e11e8d0945a7
> --- /dev/null
> +++ b/tools/perf/util/sharded_mutex.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "sharded_mutex.h"
> +
> +#include <stdlib.h>
> +
> +struct sharded_mutex *sharded_mutex__new(size_t num_shards)
> +{
> +       struct sharded_mutex *result;
> +       size_t size;
> +       unsigned int bits;
> +
> +       for (bits = 0; ((size_t)1 << bits) < num_shards; bits++)
> +               ;
> +
> +       size = sizeof(*result) + sizeof(struct mutex) * (1 << bits);
> +       result = malloc(size);
> +       if (!result)
> +               return NULL;
> +
> +       result->cap_bits = bits;
> +       for (size_t i = 0; i < ((size_t)1 << bits); i++)
> +               mutex_init(&result->mutexes[i]);
> +
> +       return result;
> +}
> +
> +void sharded_mutex__delete(struct sharded_mutex *sm)
> +{
> +       for (size_t i = 0; i < ((size_t)1 << sm->cap_bits); i++)
> +               mutex_destroy(&sm->mutexes[i]);
> +
> +       free(sm);
> +}
> diff --git a/tools/perf/util/sharded_mutex.h b/tools/perf/util/sharded_mutex.h
> new file mode 100644
> index 000000000000..7325e969eee3
> --- /dev/null
> +++ b/tools/perf/util/sharded_mutex.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef PERF_SHARDED_MUTEX_H
> +#define PERF_SHARDED_MUTEX_H
> +
> +#include "mutex.h"
> +#include "hashmap.h"
> +
> +/*
> + * In a situation where a lock is needed per object, having a mutex can be
> + * relatively memory expensive (40 bytes on x86-64). If the object can be
> + * constantly hashed, a sharded mutex is an alternative global pool of mutexes
> + * where the mutex is looked up from a hash value. This can lead to collisions
> + * if the number of shards isn't large enough.
> + */
> +struct sharded_mutex {
> +       /* mutexes array is 1<<cap_bits in size. */
> +       unsigned int cap_bits;
> +       struct mutex mutexes[];
> +};
> +
> +struct sharded_mutex *sharded_mutex__new(size_t num_shards);
> +void sharded_mutex__delete(struct sharded_mutex *sm);
> +
> +static inline struct mutex *sharded_mutex__get_mutex(struct sharded_mutex *sm, size_t hash)
> +{
> +       return &sm->mutexes[hash_bits(hash, sm->cap_bits)];
> +}
> +
> +#endif  /* PERF_SHARDED_MUTEX_H */
> --
> 2.41.0.162.gfafddb0af9-goog
>
