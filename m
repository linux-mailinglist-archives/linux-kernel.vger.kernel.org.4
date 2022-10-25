Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCA60D0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiJYPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJYPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:37:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC4D8EF5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:37:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l14so14517377wrw.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23SsZSw/1NrmKAtnYWodEwVyGyRFfxdjumQj+Wu9VNY=;
        b=ogpTgLJ4JQp4OHIInETJFxtlRExrjwqfExrmFhu1LaywnFQTxRzobA3DaKg8Zh3o0f
         HJ6k60NPtz7jQcbLvmJ68jGcrWJ0EhR7HUcC6duCcz4paT3ipvYtme4Q00Mes3KHcFAr
         IpFTi2O9Lh6hOLMNp2LNZn/nDXxcjvVtrn+Qjek1Aj6ey9bz1ufN3G6wHC3Aq8w2APDc
         yNIBDBSn7PEB5rlxuoWNXem2VIS3PyNFFwATFOJoJWko9dqIcaZEOdhdX/zIMIcBamch
         A+0aTmmdT0IyiwitjDU91iL8w/7EnLerSKQI1ND0L4JLxNkSegZtBNz2m8y+JFHgHTSA
         pfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23SsZSw/1NrmKAtnYWodEwVyGyRFfxdjumQj+Wu9VNY=;
        b=CRTcx/APgu8mXNL5RqJn/DgGtm7VALYtO6i8Tn/ZQuDI9qNzgd0g/oE1IgXsRyo/8Z
         evc+71lRxi1oQt5jcUHlMJNEUvveweVfsQHP1xFAGhXO0KgNWYiPXxHOCF7UF3sXy8Sn
         05sOTqN7rF8g1/C7QKTjpj1kUz6z2x3sog1jaRfjlj7p7/L1gAl/Bfw8+3zOvqV4MfAy
         xRiMoRzzl2bEogX7YGfVXgqED57YTxu+gCIIdhLJ26XA08QqT6D28N7CxfKBN8Zbn+N6
         roVSerzsm6jplzO1j2GkdI/HicnO5Ot0FWStsK2exXCwkkaiKSpbXGBrvOEbmtTHmrls
         T94g==
X-Gm-Message-State: ACrzQf1+Zp/U0Mh85s6HSVJhSUurQJvGoTd7/c7wp5APpRhDquP4QU6v
        qEgsBkdwfk6p2JZLyySEWQSmtQ/h6fXxvj/ApW7oPhTEjPc=
X-Google-Smtp-Source: AMsMyM5W8Cq6h9vgTQGgpQM/5JYgS6JaXSFfVf7jDbfc1dru083NbUO2kiHaA4FBT/E0+bGF0vVZnzOGRe+BYbkPWNg=
X-Received: by 2002:a5d:47a9:0:b0:22e:3beb:dc3a with SMTP id
 9-20020a5d47a9000000b0022e3bebdc3amr26057264wrb.654.1666712241029; Tue, 25
 Oct 2022 08:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <1665042130-15786-1-git-send-email-yangtiezhu@loongson.cn> <1665042130-15786-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1665042130-15786-3-git-send-email-yangtiezhu@loongson.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 25 Oct 2022 08:37:09 -0700
Message-ID: <CAP-5=fX8_Q3EujmfBXF_66y=n+VUyeBZtzjZU9WGj4QBN2TZ5w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf bench syscall: Add close syscall benchmark
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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

On Thu, Oct 6, 2022 at 12:42 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> This commit adds a simple close syscall benchmark, more syscall
> benchmarks can be added in the future.
>
> Here are the test results:
>
>   [loongson@linux perf]$ ./perf bench syscall
>
>           # List of available benchmarks for collection 'syscall':
>
>            basic: Benchmark for basic getppid(2) calls
>            close: Benchmark for close(2) calls
>              all: Run all syscall benchmarks
>
>   [loongson@linux perf]$ ./perf bench syscall basic
>   # Running 'syscall/basic' benchmark:
>   # Executed 10000000 getppid() calls
>        Total time: 1.956 [sec]
>
>          0.195687 usecs/op
>           5110201 ops/sec
>   [loongson@linux perf]$ ./perf bench syscall close
>   # Running 'syscall/close' benchmark:
>   # Executed 10000000 close() calls
>        Total time: 6.302 [sec]
>
>          0.630297 usecs/op
>           1586553 ops/sec
>   [loongson@linux perf]$ ./perf bench syscall all
>   # Running syscall/basic benchmark...
>   # Executed 10000000 getppid() calls
>        Total time: 1.956 [sec]
>
>          0.195686 usecs/op
>           5110232 ops/sec
>
>   # Running syscall/close benchmark...
>   # Executed 10000000 close() calls
>        Total time: 6.302 [sec]
>
>          0.630271 usecs/op
>           1586619 ops/sec
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
>  tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
>  tools/perf/bench/bench.h                    |  1 +
>  tools/perf/bench/syscall.c                  | 11 +++++++++++
>  tools/perf/builtin-bench.c                  |  1 +
>  5 files changed, 19 insertions(+)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
> index 4a480a0..2f24b0eb 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> @@ -2,6 +2,9 @@
>  #ifndef __NR_perf_event_open
>  # define __NR_perf_event_open 336
>  #endif
> +#ifndef __NR_close
> +# define __NR_close 6
> +#endif
>  #ifndef __NR_futex
>  # define __NR_futex 240
>  #endif
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
> index 860257f..8eb32b2 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> @@ -2,6 +2,9 @@
>  #ifndef __NR_perf_event_open
>  # define __NR_perf_event_open 298
>  #endif
> +#ifndef __NR_close
> +# define __NR_close 3
> +#endif
>  #ifndef __NR_futex
>  # define __NR_futex 202
>  #endif
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 6cefb43..916cd47 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -34,6 +34,7 @@ int bench_numa(int argc, const char **argv);
>  int bench_sched_messaging(int argc, const char **argv);
>  int bench_sched_pipe(int argc, const char **argv);
>  int bench_syscall_basic(int argc, const char **argv);
> +int bench_syscall_close(int argc, const char **argv);
>  int bench_mem_memcpy(int argc, const char **argv);
>  int bench_mem_memset(int argc, const char **argv);
>  int bench_mem_find_bit(int argc, const char **argv);
> diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
> index 746fd71..058394b 100644
> --- a/tools/perf/bench/syscall.c
> +++ b/tools/perf/bench/syscall.c
> @@ -46,6 +46,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
>                 case __NR_getppid:
>                         getppid();
>                         break;
> +               case __NR_close:
> +                       close(dup(0));

Thanks for contributing! This benchmark will compute the cost of close
and dup, naively dup could perform memory allocation and be slow.
Perhaps a number of file descriptors could be made outside of the
timed region?

Thanks,
Ian
> +                       break;
>                 default:
>                         break;
>                 }
> @@ -58,6 +61,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
>         case __NR_getppid:
>                 name = "getppid()";
>                 break;
> +       case __NR_close:
> +               name = "close()";
> +               break;
>         default:
>                 break;
>         }
> @@ -100,3 +106,8 @@ int bench_syscall_basic(int argc, const char **argv)
>  {
>         return bench_syscall_common(argc, argv, __NR_getppid);
>  }
> +
> +int bench_syscall_close(int argc, const char **argv)
> +{
> +       return bench_syscall_common(argc, argv, __NR_close);
> +}
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 334ab89..b63c711 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -52,6 +52,7 @@ static struct bench sched_benchmarks[] = {
>
>  static struct bench syscall_benchmarks[] = {
>         { "basic",      "Benchmark for basic getppid(2) calls",         bench_syscall_basic     },
> +       { "close",      "Benchmark for close(2) calls",                 bench_syscall_close     },
>         { "all",        "Run all syscall benchmarks",                   NULL                    },
>         { NULL,         NULL,                                           NULL                    },
>  };
> --
> 2.1.0
>
