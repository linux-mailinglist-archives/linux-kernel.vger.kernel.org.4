Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A97738D13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjFUR3N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFUR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:29:12 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1EE2;
        Wed, 21 Jun 2023 10:29:11 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so5942527276.0;
        Wed, 21 Jun 2023 10:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368550; x=1689960550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHKJ5E4QyaneB9JDT8DwEZgyuTNCEA7MDDSg1wRoMEI=;
        b=EF02C/IqTEdWvGevmILr5zJtLS27nm5s3cGXmsx1zeBnWpqby5fXoDRb8UVWZNwR5N
         L9B54+su2lQ2ojI7er/qQ585bbS3DGpIpZV92qZQztUInbcuDnSPMhNMtqT9EcAvSkxW
         agok7YmSnYMTHSQEznQjaPok1nniOHgGWGy9FFBPipCajH5BAiII3oK0iiXlJZ4ARPXy
         Yp7422E0F2teNauvOIjQqo2TpeAMOJQg643iRtPcQb6Pds241VBPEI69iwMPelEU7XZO
         zIWwhv2SqejzNY4PDrCMw29J+OLixJMkheStNOfWsFj19JuaYqUbP1ii0FvDlpkb52YJ
         szOg==
X-Gm-Message-State: AC+VfDzCeDmrvDYASfsptTK4WluQ2OibL5Xt51JyZ3y3UlK+ENH+gEX3
        PxYV2X4DpAIlAt9gchi6dzO/By47VpvBYm6qO64=
X-Google-Smtp-Source: ACHHUZ7hMGvTxVYM7j06iuh48J3sQevUoI3xiFZJa4qO0+XgMX1X2u/VYFsp7hO0BhArpajGcDMuvE2Xa8xasyBdtao=
X-Received: by 2002:a25:b1a3:0:b0:bca:531d:dcde with SMTP id
 h35-20020a25b1a3000000b00bca531ddcdemr11934138ybj.30.1687368550410; Wed, 21
 Jun 2023 10:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230620132025.105563-1-wangrui@loongson.cn>
In-Reply-To: <20230620132025.105563-1-wangrui@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 10:28:59 -0700
Message-ID: <CAM9d7cgpm+Uz4JOh9vW60OQkCOjpbNvrrDy-KefALVak1EXQxQ@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix instruction association and parsing
 for LoongArch
To:     WANG Rui <wangrui@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
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

On Tue, Jun 20, 2023 at 6:21 AM WANG Rui <wangrui@loongson.cn> wrote:
>
> In the perf annotate view for LoongArch, there is no arrowed line
> pointing to the target from the branch instruction. This issue is
> caused by incorrect instruction association and parsing.
>
> $ perf record alloc-6276705c94ad1398 # rust benchmark
> $ perf report
>
>   0.28 │       ori        $a1, $zero, 0x63
>        │       move       $a2, $zero
>  10.55 │       addi.d     $a3, $a2, 1(0x1)
>        │       sltu       $a4, $a3, $s7
>   9.53 │       masknez    $a4, $s7, $a4
>        │       sub.d      $a3, $a3, $a4
>  12.12 │       st.d       $a1, $fp, 24(0x18)
>        │       st.d       $a3, $fp, 16(0x10)
>  16.29 │       slli.d     $a2, $a2, 0x2
>        │       ldx.w      $a2, $s8, $a2
>  12.77 │       st.w       $a2, $sp, 724(0x2d4)
>        │       st.w       $s0, $sp, 720(0x2d0)
>   7.03 │       addi.d     $a2, $sp, 720(0x2d0)
>        │       addi.d     $a1, $a1, -1(0xfff)
>  12.03 │       move       $a2, $a3
>        │     → bne        $a1, $s3, -52(0x3ffcc)  # 82ce8 <test::bench::Bencher::iter+0x3f4>
>   2.50 │       addi.d     $a0, $a0, 1(0x1)
>
> This patch fixes instruction association issues, such as associating
> branch instructions with jump_ops instead of call_ops, and corrects
> false instruction matches. It also implements branch instruction parsing
> specifically for LoongArch. With this patch, we will be able to see the
> arrowed line.
>
>   0.79 │3ec:   ori        $a1, $zero, 0x63
>        │       move       $a2, $zero
>  10.32 │3f4:┌─→addi.d     $a3, $a2, 1(0x1)
>        │    │  sltu       $a4, $a3, $s7
>  10.44 │    │  masknez    $a4, $s7, $a4
>        │    │  sub.d      $a3, $a3, $a4
>  14.17 │    │  st.d       $a1, $fp, 24(0x18)
>        │    │  st.d       $a3, $fp, 16(0x10)
>  13.15 │    │  slli.d     $a2, $a2, 0x2
>        │    │  ldx.w      $a2, $s8, $a2
>  11.00 │    │  st.w       $a2, $sp, 724(0x2d4)
>        │    │  st.w       $s0, $sp, 720(0x2d0)
>   8.00 │    │  addi.d     $a2, $sp, 720(0x2d0)
>        │    │  addi.d     $a1, $a1, -1(0xfff)
>  11.99 │    │  move       $a2, $a3
>        │    └──bne        $a1, $s3, 3f4
>   3.17 │       addi.d     $a0, $a0, 1(0x1)
>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

Applied to perf-tools-next, thanks!
