Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF966089A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbjAFVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAFVE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:04:58 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664063FC;
        Fri,  6 Jan 2023 13:04:56 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id bn26so2444976wrb.0;
        Fri, 06 Jan 2023 13:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bU5WrWki6y78vjWxBUsXFui7/QgP/v4Ob6/7UBGO4uk=;
        b=ZqFO2A1U+uXTSxPNAwP6EiAI+zSbidKDSmqQrb8mGvjEeU2qfE/PT2BO0geKXHp19b
         pM+lY8SEmf8gARq9YrP3TJGBgn6x8++g2/hZuwNHszJ0rtRGmNU3bjC2rUKt1gw9SqK8
         7Bs/1JYnEOG3WRPcqQsrdhufd94z6uKKd/b1jBHgze6Dee6iCzgp2X0dqotLSXDsGDEA
         wbz25uxOZaKtTAvRV3dHwSJ0MmHcqX92rL+3SRd9wMc0X7EZXiME2e86ZO+gSFdJyh0p
         gEEbdHFfjYzcD9/j56evl/rsuTbruGXkgnIxA6CdDYlDrjoLWa2aRHWcSigbpNgdc1Nx
         AteQ==
X-Gm-Message-State: AFqh2kp3aPwmck/z0lwWKy7TsFxDc66WUClFD+1yXGs65Rpkje8F5a0l
        6MqMjQKJnDgyHk3poc9LYvWoFLxHAP65ZfmGZQQ=
X-Google-Smtp-Source: AMrXdXu5yY8uRNnuPGF1u/Qv+JWdy6yPnFLq17NSk7NiUJcPmk4qHz1S9xkIw4hXtYyIg18XubWh/Y4S6+hg+LwZbb4=
X-Received: by 2002:adf:efce:0:b0:2bb:1e37:7b8b with SMTP id
 i14-20020adfefce000000b002bb1e377b8bmr55632wrp.364.1673039094606; Fri, 06 Jan
 2023 13:04:54 -0800 (PST)
MIME-Version: 1.0
References: <1668052208-14047-1-git-send-email-yangtiezhu@loongson.cn>
 <c71e9666-c62a-83ae-0d7b-580dc717e9f1@loongson.cn> <dbf82707-df17-466b-f882-aa4e25d4f629@loongson.cn>
In-Reply-To: <dbf82707-df17-466b-f882-aa4e25d4f629@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Jan 2023 13:04:42 -0800
Message-ID: <CAM9d7cgH0zK-DUmUV7yw1BJBvgyxWys9zPuB5Q7dQQwta=XcGA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] perf: Add more syscalls to benchmark
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 5, 2023 at 5:23 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 12/03/2022 05:19 PM, Tiezhu Yang wrote:
> >
> >
> > On 11/10/2022 11:50 AM, Tiezhu Yang wrote:
> >> Tested on x86_64, arm64, mips64 and loongarch64.
> >>
> >> Tiezhu Yang (4):
> >>   tools x86: Keep list sorted by number in unistd_{32,64}.h
> >>   perf bench syscall: Introduce bench_syscall_common()
> >>   perf bench syscall: Add getpgid syscall benchmark
> >>   perf bench syscall: Add execve syscall benchmark
> >>
> >>  tools/arch/x86/include/uapi/asm/unistd_32.h | 23 ++++++---
> >>  tools/arch/x86/include/uapi/asm/unistd_64.h | 23 ++++++---
> >>  tools/perf/bench/bench.h                    |  2 +
> >>  tools/perf/bench/syscall.c                  | 76
> >> +++++++++++++++++++++++++++--
> >>  tools/perf/builtin-bench.c                  |  2 +
> >>  5 files changed, 108 insertions(+), 18 deletions(-)
> >>
> >
> > Ping, any more comments?
> >
> > Thanks,
> > Tiezhu
>
> Hi all,
>
> If this patch series has no value and is not acceptable,
> or what should I do to update, please let me know.

I'm so sorry about being late a lot.
I don't have any objection to this series.

For the execve bench, I think it's actually fork + execve
then maybe it makes sense to have a fork only bench
to compare the execve part precisely.

But it can be added later, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
