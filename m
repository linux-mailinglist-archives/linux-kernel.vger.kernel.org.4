Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B5673E23
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjASQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjASQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:01:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFF87659
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:01:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j17so1941517wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WynGWnW5qVucB0blBxbhDAXE7aIVvANuEOwmRMtSfIA=;
        b=ohuuPGolSvT3cmLDofUMGeNX4+ZxakYEEZ5oxD30c3Hc5JzM9AA5MfnougdhtnlVmO
         AQlTr1C0jS15wbO/E4RyR6Gav8i9L8Huw7Rc6RJZAAef2FP/sQGeLSxisDtK0w4I3xJu
         OneVQoMyDJRqRcJr6U67FUPFVTIY7gQYNwzLefMFeSgdlzqSsO2Dsd9FoZHZR0azRgAL
         1f79gc654FvpML63VjSiizrLiKGiUTutwuKvRpbZwGSgXIUcvp6Xq5WdKTnzoZOVGmwA
         fS1DfTxzTdkHcjCQ6Rtj+2m0poC4V5HBBtu2Y7NwSc7vA9H8pCZYewNQNKOkw63n42AN
         G9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WynGWnW5qVucB0blBxbhDAXE7aIVvANuEOwmRMtSfIA=;
        b=koldO81wX4CUK9TLYBeRLr4QCR0URDpK2TRyzy2xQuphOkMAPjA97HzMdVJflz4PWL
         Ztuf1eP0RaNXyxGxmCUy9fNGGtJO07oK+y7paGUmlr4HiD0vT2ycE+zh8F3lbWZOvuYf
         rF90ti/QaqHw0RHR6uHu+6Qa5ZwhF0LGf49LqSGcfTsPdLCF+kV/OGGBS/gfuzpOiw2v
         pBE0BxRnANkIcKGqluR4ypSR3lGgNna2ML5LmWI6ZfUpG068cB0U/TcP3CEa9wJlpXrh
         TfA2nM0sddbZ/+EDuVvdfUDTa3DjzIARreXDVTuETPSSTbjBWYm5LfRQPvafkYldNjXE
         2n3Q==
X-Gm-Message-State: AFqh2kqiTASOJPbiJGg7W++jCwMueTvQ66tBUR+ra89rIsCHUKn7S2hA
        Wd/0Sd/FL0JLpwCvIy4F2jdPG2n8gpfcvLyg9xsVlA==
X-Google-Smtp-Source: AMrXdXs45iev/CXuqYsmXoCmnvRpYQUBLQyoA8fTRNgNYbopkP1j4xVPEO5FIOdgcGzaG/U3/DqcDvBTrYIQRaDQkC8=
X-Received: by 2002:a05:600c:1c9a:b0:3d9:ee45:8a9e with SMTP id
 k26-20020a05600c1c9a00b003d9ee458a9emr536790wms.174.1674144104725; Thu, 19
 Jan 2023 08:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20230111070641.1728726-1-irogers@google.com>
In-Reply-To: <20230111070641.1728726-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 08:01:32 -0800
Message-ID: <CAP-5=fXPg1FDdtRgKtar+x3U91RNpPdYFJUP6XHvK1y10y=O2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf tools: Remove HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jan 10, 2023 at 11:06 PM Ian Rogers <irogers@google.com> wrote:
>
> Switch HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE to be a version number
> test on libtraceevent being >= to version 1.5.0. This also corrects a
> greater-than test to be greater-than-or-equal.
>
> Discussed here:
> https://lore.kernel.org/lkml/20221205225940.3079667-3-irogers@google.com/
>
> Fixes: b9a49f8cb02f ("perf tools: Check if libtracevent has TEP_FIELD_IS_RELATIVE")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Remove one ifdef in favor of a consistent version check, gets
debug logging from libtraceevent going.

Thanks,
Ian

> ---
>  tools/perf/Makefile.config                             | 4 ----
>  tools/perf/builtin-trace.c                             | 2 +-
>  tools/perf/util/data-convert-bt.c                      | 2 +-
>  tools/perf/util/evsel.c                                | 2 +-
>  tools/perf/util/python.c                               | 2 +-
>  tools/perf/util/scripting-engines/trace-event-perl.c   | 2 +-
>  tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
>  tools/perf/util/sort.c                                 | 3 ++-
>  tools/perf/util/trace-event.h                          | 3 +++
>  9 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c2504c39bdcb..f67ba8060162 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1204,10 +1204,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
>      CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
>      $(call detected,CONFIG_LIBTRACEEVENT)
> -    LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE := $(shell expr 1 \* 255 \* 255 + 5 \* 255 + 0) # 1.5.0
> -    ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt $(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
> -      CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> -    endif
>    else
>      dummy := $(warning Warning: libtraceevent is missing limiting functionality, please install libtraceevent-dev/libtraceevent-devel)
>    endif
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 86e06f136f40..927622ecc42e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2729,7 +2729,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>                                 offset = format_field__intval(field, sample, evsel->needs_swap);
>                                 syscall_arg.len = offset >> 16;
>                                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index b842273458b8..98454f7a820c 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -322,7 +322,7 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
>                 offset = tmp_val;
>                 len = offset >> 16;
>                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                 if (flags & TEP_FIELD_IS_RELATIVE)
>                         offset += fmtf->offset + fmtf->size;
>  #endif
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 999dd1700502..296292fa2c04 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2784,7 +2784,7 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
>         if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>                 offset = *(int *)(sample->raw_data + field->offset);
>                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 212031b97910..25a276710dfb 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -442,7 +442,7 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
>                         offset  = val;
>                         len     = offset >> 16;
>                         offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                         if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                 offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> index c097b7934fd4..5bcec514f697 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -393,7 +393,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
>                         if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>                                 offset = *(int *)(data + field->offset);
>                                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index e930f5f1f36d..759ed6eafa3c 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -994,7 +994,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
>                                 offset  = val;
>                                 len     = offset >> 16;
>                                 offset &= 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index e188f74698dd..cfcc253239f0 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -28,6 +28,7 @@
>  #include "time-utils.h"
>  #include "cgroup.h"
>  #include "machine.h"
> +#include "trace-event.h"
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>
> @@ -2667,7 +2668,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
>                 tep_read_number_field(field, a->raw_data, &dyn);
>                 offset = dyn & 0xffff;
>                 size = (dyn >> 16) & 0xffff;
> -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                         offset += field->offset + field->size;
>  #endif
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index add6c5d9531c..1a1a2e6b24fb 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -20,6 +20,9 @@ struct trace_event {
>         struct tep_plugin_list  *plugin_list;
>  };
>
> +/* Computes a version number comparable with LIBTRACEEVENT_VERSION from Makefile.config. */
> +#define MAKE_LIBTRACEEVENT_VERSION(a, b, c) ((a)*255*255+(b)*255+(c))
> +
>  typedef char *(tep_func_resolver_t)(void *priv,
>                                     unsigned long long *addrp, char **modp);
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
