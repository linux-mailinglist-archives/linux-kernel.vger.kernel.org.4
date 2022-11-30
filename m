Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0003E63E009
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiK3SxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiK3Sw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:52:57 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CF1B7B4;
        Wed, 30 Nov 2022 10:52:48 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so2158805wmb.2;
        Wed, 30 Nov 2022 10:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37mvhHvnN9tIEk/mahtS0ysu6GiJkb+pcUB5MovB1AQ=;
        b=aX+vm/hKec+Nn+3/ZFoZSBxAuQUl5qcRiZL2bP9Sdp8aSVnJz8+mrDGweN3nEN1LNc
         7f9qqrFy+0ICOOSd28jCm4uocYWOIoJaEysGnHFuXJ2Im4woMln1nyM/Xs0w7Wp6Woou
         ecmQq5ylHB5gK75Zf8tHhS50Vq3rhobiyCVqO5Pr6mW2senpKoDMaLqBVq1VF6DZzU4K
         zS4eX2KYEzDYctr87+hNKn0zb2adpYWItxxP5kJUurqgvjCYwAQQ+cDkDAGN+WrUC81z
         gkHfya3nQDHCJpfsKeLgYJ7F7ehYZ7bkR5u8ZQvpB0xOIJ8MdyXod8uYBv8qcLXWZDqR
         R90A==
X-Gm-Message-State: ANoB5pnitUjBredYQh9JGDG+5yhijMiDxD2YM93fefV23rf9//GXmasK
        YOFp5EyJ9eJVcqV3QQESYEEnB8OtJ7tFNOcoqYoljAJm
X-Google-Smtp-Source: AA0mqf6rzAiBNwGFzyYND35PgFg4ZA7Q1B5uIplVux3+ixP2BzDBLEbBYgU3y2ZfZ6ML9ZC0pldHMRthLYx13hrfiQQ=
X-Received: by 2002:a05:600c:5012:b0:3cf:486f:2700 with SMTP id
 n18-20020a05600c501200b003cf486f2700mr37490744wmr.83.1669834367131; Wed, 30
 Nov 2022 10:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com> <20221130062935.2219247-3-irogers@google.com>
In-Reply-To: <20221130062935.2219247-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Nov 2022 10:52:35 -0800
Message-ID: <CAM9d7cg1pmkMTFEoK7tNxQTmux7obr7KPr-5SPNDrB=S5Xp=vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf util: Add host_is_bigendian to util.h
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
>
> Avoid libtraceevent dependency for tep_is_bigendian or trace-event.h
> dependency for bigendian. Add a new host_is_bigendian to util.h, using
> the compiler defined __BYTE_ORDER__ when available.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

A nit below...

> ---
[SNIP]
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 63cdab0e5314..87d418cb6792 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -94,4 +94,23 @@ int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x,
>                 0;                                              \
>         })
>
> +static inline bool host_is_bigendian(void)
> +{
> +#ifdef __BYTE_ORDER__
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +       return false;
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +       return true;
> +#else
> +#error "Unrecognized __BYTE_ORDER__"
> +#endif
> +#else

It'd be nice if we could have a comment at least there's a nested
ifdef condition.  Like below?

#else  /* !__BYTE_ORDER__ */

Thanks,
Namhyung


> +       unsigned char str[] = { 0x1, 0x2, 0x3, 0x4, 0x0, 0x0, 0x0, 0x0};
> +       unsigned int *ptr;
> +
> +       ptr = (unsigned int *)(void *)str;
> +       return *ptr == 0x01020304;
> +#endif
> +}
> +
>  #endif /* __PERF_UTIL_H */
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
