Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6019D62A1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKOTNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKOTNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:13:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903C303F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:13:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z14so25849530wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVmIK2KbmJcILQt5r8JiDxSMthBbVHuraQkf2M+r6zU=;
        b=glxVraLDq6ErCS0YWPINbeqZZiQ1hA5c9A2gN06m1BOXrHnUSMdK9e2OvJty/UbiDB
         bHoNHG1ugIncwjk4bkc0mkhFtPEFIWItDdWxd8tN5gamuZfZH4zu8oJcJyLeeHq2KrT4
         LUNaPxVGvHzY3a5yuPIthrIgp5AXd31R/JQ98XWTvxorSP2y1ym421vOQnpmwgq2Fv5l
         N1RR9tK/aQrWqeDH7xKupWbtyUsS6yQpPC1XmOOCvxehqKnmwDQY4FeQlCmZmlF0CZt4
         yaHgYJUPrG5+KHlXYs6knDSJTQQ3XYX0fNfE/9pJkUwr0a5ztJGryqzVvcJTBvE1IZO2
         b7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVmIK2KbmJcILQt5r8JiDxSMthBbVHuraQkf2M+r6zU=;
        b=4Rv+c4tqN5BV0upkISrQ6ZW9okixfW166X1hrK+N5dgay/9llyCl9260LTjulvQiQR
         0M3fHN9Ldqj/JkgpmRs6cO8xCKXzszR+M9lRr5+k6JSFGgiYZWm7YGzWIhR+Bv1mTG/E
         7KO2YI44oD/R3FcMEbqB/Ufp4reUf6gO2RgvMtVakPlSWibs2Eh4HaYRE1Hi5oRIlLMx
         uR+bDWzTbK9dhZnZY0XWwsYNOIsvxqg7qjZbbQrhxyVQtRXYOlayd2PZ3Oz5QfuONNrb
         3HjIm47YoBoAxB9117aiYoQ82BRud1GL0XentL/pp2ZDF7vOolO0lapHwAyYOXLKx5Wx
         qU8g==
X-Gm-Message-State: ANoB5pnqMUKRTo8AHb0f+Lu9O/RjXtdYPXWlqSY3l1F1eqpTY7FfYVMF
        J5je2NWWpuDRB1CLbAAwcpodnfRRJ1MKuv+3QjM3vA==
X-Google-Smtp-Source: AA0mqf5rwMM4FiNjOSbh6rvc1Af5bUo/EbW3oitQGTe1Umpso6zA++OkrRp2d50BRAyXtPU4Fe66/Ls4Jf6XqmRMB6A=
X-Received: by 2002:a05:6000:1241:b0:236:d8f8:b87d with SMTP id
 j1-20020a056000124100b00236d8f8b87dmr11346690wrx.343.1668539587668; Tue, 15
 Nov 2022 11:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com> <Y247VY99skmc1wRk@leoy-huanghe.lan>
In-Reply-To: <Y247VY99skmc1wRk@leoy-huanghe.lan>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Nov 2022 11:12:55 -0800
Message-ID: <CAP-5=fX-Qa8y0yq5a2T=_=W59_4F-VPPHZpP4Vk3ZjnDRO8uOg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Fix perf trace libbpf 1.0+ compatibility
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Fri, Nov 11, 2022 at 4:09 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Ian, Arnaldo,
>
> On Wed, Nov 02, 2022 at 09:54:30PM -0700, Ian Rogers wrote:
> > Perf trace can augment system calls with a BPF program passed as an
> > event. The BPF code for this lives in examples. This patch fixes the
> > example code to not used deprecated/removed APIs in libbpf. As libbpf
> > has similar header files to tools/perf/include/bpf the code is
> > transitioned to use the more standard libbpf code and the perf BPF
> > header files removed.
>
> I think you missed to update the code examples/bpf/sys_enter_openat.c,
> either you could remove it (since it's duplicate with
> augmented_raw_syscalls.c), or we should apply below fixing:

Arnaldo, what do you think?

Thanks,
Ian

> From f30af3b43060e482c54e113cbe90223173c69abd Mon Sep 17 00:00:00 2001
> From: Leo Yan <leo.yan@linaro.org>
> Date: Fri, 11 Nov 2022 12:02:24 +0000
> Subject: [PATCH] perf trace: sys_enter_openat.c fix libbpf 1.0+ compatibility
>
> Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
> headers.
>
> With fixing:
>
>   # ./perf trace -e examples/bpf/sys_enter_openat.c
>   0.000 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
>   1.596 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
>   1.832 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
>   1.864 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/examples/bpf/sys_enter_openat.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
> index c4481c390d23..8edfa7c147d1 100644
> --- a/tools/perf/examples/bpf/sys_enter_openat.c
> +++ b/tools/perf/examples/bpf/sys_enter_openat.c
> @@ -14,7 +14,9 @@
>   * the return value.
>   */
>
> -#include <bpf/bpf.h>
> +#include <linux/bpf.h>
> +#include <linux/limits.h>
> +#include <bpf/bpf_helpers.h>
>
>  struct syscall_enter_openat_args {
>         unsigned long long unused;
> @@ -25,9 +27,10 @@ struct syscall_enter_openat_args {
>         long               mode;
>  };
>
> -int syscall_enter(openat)(struct syscall_enter_openat_args *args)
> +SEC("syscalls:sys_enter_openat")
> +int syscall_enter_openat(struct syscall_enter_openat_args *args)
>  {
>         return 1;
>  }
>
> -license(GPL);
> +char _license[] SEC("license") = "GPL";
