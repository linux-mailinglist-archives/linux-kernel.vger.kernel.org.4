Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087DF744110
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjF3RVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjF3RU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:20:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71116DF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:20:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5577900c06bso1576316a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688145654; x=1690737654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV7/sLg349eokKjgGeuSM9/ZV1UE8ivQcMtOAnbPrqw=;
        b=EKHriceWsg2HZvo8PghBS3Ofrh+OEFTr7NjFM9CLkufL6Y/MVmZ/3RKyov06VBefQ7
         2GdjHA7ipHZIQm15JL5uMoXrHxBvdApJpV8jOHTpJh/qr8tOpAfxp6buw6zZLlxsCFaG
         mfScYRv4WVHYkJou5DxnaHBk+/QrPjBzCUdCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688145654; x=1690737654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LV7/sLg349eokKjgGeuSM9/ZV1UE8ivQcMtOAnbPrqw=;
        b=bcN9xq23S6coP+po9RbEFHQcDvJ69M+KCZIk1B3Utge5hOfrOkNXy43hvQOJPYdhGu
         Bi7WS1F+8WlKizmmS2MqcYe+kn7Zv6gZEeRBlCcWiEoDCoqejOUU9XxOw+AUV9WF2ZGi
         pDFjC6sqd67syUKvptAUbao/P194Lkq42g1u6G/6lc2cPMrXVTrBzUXWkneJ61v6aPTb
         Nb5ncCnKJI4x6m36qUDwEgppYzSwEpHw80KG921teLC/r+s8j+QnOTA8iuj4kPcccNht
         kXd7YmraWqtIGiFo8xGwzjdbGQZZVKCvNt0nWmDilQk1YG2nVT8dpaFeqOHsZlqhkBz1
         s55g==
X-Gm-Message-State: ABy/qLbx7GnWjzoB62WTL/+X6X72SuFvNUofaD85v+LoiFL1i59Lxcu9
        eEsMjdw9/Cu4ut9IO76P7OExwd0ioWkyJoOfy5MemQ==
X-Google-Smtp-Source: APBJJlELe9Sr6W2gcX9b8TurViBTVN5V3IAn8j9OfdxanrE7yxoLeIwOGidzV3Dui9rGCVA1+j50bMO9VIV9jDdfLXE=
X-Received: by 2002:a05:6a20:729b:b0:12d:c4fb:4884 with SMTP id
 o27-20020a056a20729b00b0012dc4fb4884mr74019pzk.20.1688145653906; Fri, 30 Jun
 2023 10:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230626085811.3192402-1-puranjay12@gmail.com>
In-Reply-To: <20230626085811.3192402-1-puranjay12@gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 30 Jun 2023 19:20:42 +0200
Message-ID: <CABRcYmLAzhG=o2wcBNBtFP34Aj3+eYsEMtMREDT7SqNzBc9-qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:58=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> BPF programs currently consume a page each on ARM64. For systems with man=
y BPF
> programs, this adds significant pressure to instruction TLB. High iTLB pr=
essure
> usually causes slow down for the whole system.
>
> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above =
issue.
> It packs multiple BPF programs into a single huge page. It is currently o=
nly
> enabled for the x86_64 BPF JIT.
>
> This patch series enables the BPF prog pack allocator for the ARM64 BPF J=
IT.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> Performance Analysis of prog pack allocator on ARM64
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> To test the performance of the BPF prog pack allocator on ARM64, a stress=
er
> tool[2] was built. This tool loads 8 BPF programs on the system and trigg=
ers
> 5 of them in an infinite loop by doing system calls.
>
> The runner script starts 20 instances of the above which loads 8*20=3D160=
 BPF
> programs on the system, 5*20=3D100 of which are being constantly triggere=
d.
>
> In the above environment we try to build Python-3.8.4 and try to find dif=
ferent
> iTLB metrics for the compilation done by gcc-12.2.0.
>
> The source code[3] is  configured with the following command:
> ./configure --enable-optimizations --with-ensurepip=3Dinstall
>
> Then the runner script is executed with the following command:
> ./run.sh "perf stat -e ITLB_WALK,L1I_TLB,INST_RETIRED,iTLB-load-misses -a=
 make -j32"
>
> This builds Python while 160 BPF programs are loaded and 100 are being co=
nstantly
> triggered and measures iTLB related metrics.
>
> The output of the above command is discussed below before and after enabl=
ing the
> BPF prog pack allocator.
>
> The tests were run on qemu-system-aarch64 with 32 cpus, 4G memory, -machi=
ne virt,
> -cpu host, and -enable-kvm.
>
> Results
> -------
>
> Before enabling prog pack allocator:
> ------------------------------------
>
> Performance counter stats for 'system wide':
>
>          333278635      ITLB_WALK
>      6762692976558      L1I_TLB
>     25359571423901      INST_RETIRED
>        15824054789      iTLB-load-misses
>
>      189.029769053 seconds time elapsed
>
> After enabling prog pack allocator:
> -----------------------------------
>
> Performance counter stats for 'system wide':
>
>          190333544      ITLB_WALK
>      6712712386528      L1I_TLB
>     25278233304411      INST_RETIRED
>         5716757866      iTLB-load-misses
>
>      185.392650561 seconds time elapsed
>
> Improvements in metrics
> -----------------------
>
> Compilation time                             ---> 1.92% faster
> iTLB-load-misses/Sec (Less is better)        ---> 63.16% decrease
> ITLB_WALK/1000 INST_RETIRED (Less is better) ---> 42.71% decrease
> ITLB_Walk/L1I_TLB (Less is better)           ---> 42.47% decrease
>
> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
> [2] https://github.com/puranjaymohan/BPF-Allocator-Bench
> [3] https://www.python.org/ftp/python/3.8.4/Python-3.8.4.tgz
>
> Chanes in V3 =3D> V4: Changes only in 3rd patch
> 1. Fix the I-cache maintenance: Clean the data cache and invalidate the i=
-Cache
>    only *after* the instructions have been copied to the ROX region.
>
> Chanes in V2 =3D> V3: Changes only in 3rd patch
> 1. Set prog =3D orig_prog; in the failure path of bpf_jit_binary_pack_fin=
alize()
> call.
> 2. Add comments explaining the usage of the offsets in the exception tabl=
e.
>
> Changes in v1 =3D> v2:
> 1. Make the naming consistent in the 3rd patch:
>    ro_image and image
>    ro_header and header
>    ro_image_ptr and image_ptr
> 2. Use names dst/src in place of addr/opcode in second patch.
> 3. Add Acked-by: Song Liu <song@kernel.org> in 1st and 2nd patch.
>
> Puranjay Mohan (3):
>   bpf: make bpf_prog_pack allocator portable
>   arm64: patching: Add aarch64_insn_copy()
>   bpf, arm64: use bpf_jit_binary_pack_alloc
>
>  arch/arm64/include/asm/patching.h |   1 +
>  arch/arm64/kernel/patching.c      |  39 ++++++++
>  arch/arm64/net/bpf_jit_comp.c     | 145 +++++++++++++++++++++++++-----
>  kernel/bpf/core.c                 |   8 +-
>  4 files changed, 165 insertions(+), 28 deletions(-)
>
> --
> 2.40.1
>
>

FWIW

Acked-by: Florent Revest <revest@chromium.org>

Thanks for this Puranjay!
