Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5C660B10
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjAGAsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbjAGArs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:47:48 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A603477D3A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:47:47 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f3so2266880pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 16:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QFW92H7d7D7ZvSVCeIaMKx4PJdUdEPNPZlbjVt3QERY=;
        b=o7W7AnpBN1W2Y9yG141Sa7fnarH/Mlp7EyilJckdSZ6Nm694JQjIHXvCPBkUcVNt0l
         //oLUtp2fQFLEcPBLrXYsxS3rb78Oa6Ab843P5EETRutT624hO8faSoaRvKJs5Cn6Y+C
         8Tdh1jdLFESYSBquOUgt9ztzrCCvwGt3sC5iX4KrUC/s4Dkt6x5UNrsU9uAdYszsUXSh
         6WgJodI0wkKvQbNdKqpd+pV+mRxHyRLVK/P2+3TZYYOwuUIDFeHDct/hAQKCs7KeznYk
         SmvK1AaQrjBZpYDKh2GuiLREbK3i11CX4RUSD7A2zAVYyNnVh/VAcsk8SiN4I6GYH09v
         +IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFW92H7d7D7ZvSVCeIaMKx4PJdUdEPNPZlbjVt3QERY=;
        b=d31hxMAwuOYv0YoG/ofhEeuwqHfQx2IxbUV+iRcpszDl+i8uMl5+dyJfMeXaxEpXDo
         Cyq/vcBe4v/NdcCLDqqR6/HR1EY6AQazEyLqJWse604HgwAhpnr9rKxFG7Wae4Nto9NG
         D0RnnrSs2jeLfCNmQ1QWl5W9sKPoqZx9lwdNTDUOGbtqsl5mHAJvceqDCKJeODanSMcf
         Q5CQzEJwh4l3RcyX7qhwTbELbr96VzROBggT4whxxJ2kt3vwGSPDvBZilJsa8FAutY8C
         V/2L4SxMyavpQ+KAVnjSOdxynU/wRHb+qKPQuTYXj5ghxINt/q0+2xaEaZsJ9swaaevd
         tXwg==
X-Gm-Message-State: AFqh2krVI06/nmScHmXPvDy5GBPcqijrENTIQ4uYYvAo934t1JwRaRqL
        bFRdtf7jUvtaR++u0l3+BZhUeZCxTFzOOVOa48Dwsg==
X-Google-Smtp-Source: AMrXdXsnR+lqNbyQVmSGdYOuUHO14H/K3F929WHWsH2J2jTZlwLZq1/0vRoJubJeabBqZ8/qyyZ2ea4YLvQqqGSWKXs=
X-Received: by 2002:a63:9d0a:0:b0:49f:478d:a72c with SMTP id
 i10-20020a639d0a000000b0049f478da72cmr1787400pgd.250.1673052467026; Fri, 06
 Jan 2023 16:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20230106195130.1216841-1-void@manifault.com>
In-Reply-To: <20230106195130.1216841-1-void@manifault.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 6 Jan 2023 16:47:35 -0800
Message-ID: <CAKH8qBuakT6qtY5TZomWEAB=1ZJfdgXYt2A7WVOjtHAYsdbrVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Annotate kfuncs with new __bpf_kfunc macro
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
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

On Fri, Jan 6, 2023 at 11:51 AM David Vernet <void@manifault.com> wrote:
>
> BPF kfuncs are kernel functions that can be invoked by BPF programs.
> kfuncs can be kernel functions which are also called elsewhere in the
> main kernel (such as crash_kexec()), or may be functions that are only
> meant to be used by BPF programs, such as bpf_task_acquire(), and which
> are not called from anywhere else in the kernel.
>
> While thus far we haven't observed any issues such as kfuncs being
> elided by the compiler, at some point we could easily run into problems
> such as the following:
>
> - static kernel functions that are also used as kfuncs could be inlined
>   and/or elided by the compiler.
> - BPF-specific kfuncs with external linkage may at some point be elided
>   by the compiler in LTO builds, when it's determined that they aren't
>   called anywhere.
>
> To address this, this patch set introduces a new __bpf_kfunc macro which
> should be added to all kfuncs, and which will protect kfuncs from such
> problems. Note that some kfuncs kind of try to do this already by
> specifying noinline or __used. We are inconsistent in how this is
> applied. __bpf_kfunc should provide a uniform and more-future-proof way
> to do this.

The series looks reasonable to me. Would be nice if we can somehow
prevent (with a checkpatch?) adding new kfuncs without this new tag,
but I don't see an easy way.
I was waiting in case other would like to comment, but if nothing to discuss:

Acked-by: Stanislav Fomichev <sdf@google.com>




> David Vernet (3):
>   bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs
>   bpf: Document usage of the new __bpf_kfunc macro
>   bpf: Add __bpf_kfunc tag to all kfuncs
>
>  Documentation/bpf/kfuncs.rst                  | 18 +++++
>  Documentation/conf.py                         |  3 +
>  include/linux/btf.h                           |  9 +++
>  kernel/bpf/helpers.c                          | 19 +++++
>  kernel/cgroup/rstat.c                         |  2 +
>  kernel/kexec_core.c                           |  2 +
>  kernel/trace/bpf_trace.c                      |  4 +
>  net/bpf/test_run.c                            | 76 ++++++++++++-------
>  net/ipv4/tcp_bbr.c                            |  8 ++
>  net/ipv4/tcp_cong.c                           |  5 ++
>  net/ipv4/tcp_cubic.c                          |  6 ++
>  net/ipv4/tcp_dctcp.c                          |  6 ++
>  net/netfilter/nf_conntrack_bpf.c              | 14 +++-
>  net/netfilter/nf_nat_bpf.c                    |  1 +
>  net/xfrm/xfrm_interface_bpf.c                 |  4 +-
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +-
>  16 files changed, 146 insertions(+), 33 deletions(-)
>
> --
> 2.39.0
>
