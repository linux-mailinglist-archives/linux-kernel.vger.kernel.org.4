Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1F60C401
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJYGsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJYGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:48:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4EC148FE1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:48:44 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id m125so304633ybb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=52Ackc+HIaGbbEoFOOYpWlvR8CA50d8AxFJw/tKl/6o=;
        b=NaYQSyho5xlX02NRoH9tbD+t+kKtnlqtqMXq5Ed43u5oNQu94haBkDyUViIk6HGKYh
         XMV2Q36m3/TVoduSMKWQ3xdPW/hGah60R1EdncGCUnUeuTn4WNyl3H/cM/8INSifyHRs
         CXEVqiaozScxXpXRyq/HNKNYVX0PCLSEP9W62KfSqYfuJHuwzrYjziaCk0Wz5b+y+dAv
         W7nQQ23hG2BVLPIYV8szZ8kah2yr+d24dF7ZLwxrOpo6F+Q/n+QXkVhWVH/xc2kumZsd
         UO3IRB3HRtmddGJgFzy5cQ4cCwIZv+yloKpSGIrGozuGth3FwuI++loODE/glk9X0mny
         ayyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52Ackc+HIaGbbEoFOOYpWlvR8CA50d8AxFJw/tKl/6o=;
        b=N23KiHm+P1xwtK2Z2t3BDL1BNHphuOZyBUygSnZIUcbjRJ+NGRU6wZp8bLPafsY0Ww
         rVskHw7JpwepePqgbbL59Iu+pFPZAObKwxwb8mWiRWAPEFFwZvjwlWSOazbQweASeE6l
         D5OfSnk1O3sq5B7/bMlxZRcfWq02GrhO5NB8FYvyU6DBtGYOqvAQO6S8VI7RGTTGOSTF
         1EYkf49sCvIOot65ZocAO/QhYVbca4SMnwa7J5y9RoOJnK3Aj3tiGDoBu9hVj7nxO8Fm
         WZFqg4NxtFW8ZoIaMx67fRMucHPAaVS+6q0diFbpeLr8XHzgdoaSKzAjP/ZvkSA55sde
         4kdg==
X-Gm-Message-State: ACrzQf2T2rAxjEqJfchZn9F9nB043wvF7Z+RrKDOGUuIi1ffcaRsAi0k
        m7tpshpV42ZerjTY+KeKPd7ZkQjdiGw/SCYM7jY=
X-Google-Smtp-Source: AMsMyM6N2d3bGnAQ60fHXYouIPFSZAw7PsPqTB7GyUKOQbzpn0oo0j9C4p3mNh1T1x9QLKuHr2hTmayyPBJrjLRaUpQ=
X-Received: by 2002:a25:81d2:0:b0:6ca:1fc9:de7c with SMTP id
 n18-20020a2581d2000000b006ca1fc9de7cmr23655368ybm.13.1666680524020; Mon, 24
 Oct 2022 23:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221020153540.8226-1-ubizjak@gmail.com> <220dabe6-dac1-8ca7-0134-e6e89c923d81@nvidia.com>
In-Reply-To: <220dabe6-dac1-8ca7-0134-e6e89c923d81@nvidia.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 25 Oct 2022 08:48:32 +0200
Message-ID: <CAFULd4besRPEWJ1C2otAs3CaPnNJqVkcKD0sn4vQ9gD1a-RvtQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet: use try_cmpxchg in nvmet_update_sq_head
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 2:47 AM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 10/20/22 08:35, Uros Bizjak wrote:
> > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > nvmet_update_sq_head.  x86 CMPXCHG instruction returns success in ZF flag, so
> > this change saves a compare after cmpxchg (and related move instruction in
> > front of cmpxchg).
> >
>
> Is it worth a share delts of assembly instructions of the changes above?
> as developers on block mailing list are sharing the delta between before
> and after patch including the assembly.

The difference in the assembly of nvmet_update_sq_head function is:

before:

0000000000001d30 <nvmet_update_sq_head>:
    1d30:    48 8b 4f 10              mov    0x10(%rdi),%rcx
    1d34:    49 89 f8                 mov    %rdi,%r8
    1d37:    0f b7 71 1a              movzwl 0x1a(%rcx),%esi
    1d3b:    66 85 f6                 test   %si,%si
    1d3e:    75 14                    jne    1d54 <nvmet_update_sq_head+0x24>
    1d40:    49 8b 40 08              mov    0x8(%r8),%rax
    1d44:    8b 51 1c                 mov    0x1c(%rcx),%edx
    1d47:    66 89 50 08              mov    %dx,0x8(%rax)
    1d4b:    e9 00 00 00 00           jmpq   1d50 <nvmet_update_sq_head+0x20>
            1d4c: R_X86_64_PLT32    __x86_return_thunk-0x4
    1d50:    0f b7 71 1a              movzwl 0x1a(%rcx),%esi
    1d54:    8b 79 1c                 mov    0x1c(%rcx),%edi
    1d57:    31 d2                    xor    %edx,%edx
    1d59:    8d 47 01                 lea    0x1(%rdi),%eax
    1d5c:    f7 f6                    div    %esi
    1d5e:    89 f8                    mov    %edi,%eax
    1d60:    f0 0f b1 51 1c           lock cmpxchg %edx,0x1c(%rcx)
    1d65:    49 8b 48 10              mov    0x10(%r8),%rcx
    1d69:    39 c7                    cmp    %eax,%edi
    1d6b:    75 e3                    jne    1d50 <nvmet_update_sq_head+0x20>
    1d6d:    49 8b 40 08              mov    0x8(%r8),%rax
    1d71:    8b 51 1c                 mov    0x1c(%rcx),%edx
    1d74:    66 89 50 08              mov    %dx,0x8(%rax)
    1d78:    e9 00 00 00 00           jmpq   1d7d <nvmet_update_sq_head+0x4d>
            1d79: R_X86_64_PLT32    __x86_return_thunk-0x4
    1d7d:

after:

0000000000001d30 <nvmet_update_sq_head>:
    1d30:    48 8b 4f 10              mov    0x10(%rdi),%rcx
    1d34:    0f b7 51 1a              movzwl 0x1a(%rcx),%edx
    1d38:    66 85 d2                 test   %dx,%dx
    1d3b:    74 1e                    je     1d5b <nvmet_update_sq_head+0x2b>
    1d3d:    8b 71 1c                 mov    0x1c(%rcx),%esi
    1d40:    44 0f b7 c2              movzwl %dx,%r8d
    1d44:    8d 46 01                 lea    0x1(%rsi),%eax
    1d47:    31 d2                    xor    %edx,%edx
    1d49:    41 f7 f0                 div    %r8d
    1d4c:    89 f0                    mov    %esi,%eax
    1d4e:    f0 0f b1 51 1c           lock cmpxchg %edx,0x1c(%rcx)
    1d53:    48 8b 4f 10              mov    0x10(%rdi),%rcx
    1d57:    89 c6                    mov    %eax,%esi
    1d59:    75 10                    jne    1d6b <nvmet_update_sq_head+0x3b>
    1d5b:    48 8b 47 08              mov    0x8(%rdi),%rax
    1d5f:    8b 51 1c                 mov    0x1c(%rcx),%edx
    1d62:    66 89 50 08              mov    %dx,0x8(%rax)
    1d66:    e9 00 00 00 00           jmpq   1d6b <nvmet_update_sq_head+0x3b>
            1d67: R_X86_64_PLT32    __x86_return_thunk-0x4
    1d6b:    0f b7 51 1a              movzwl 0x1a(%rcx),%edx
    1d6f:    eb cf                    jmp    1d40 <nvmet_update_sq_head+0x10>
    1d71:

You can see that in addition to the smaller size of the function, the
load of req->sq->size at 1d6b got moved to a cold path. As the main
benefit, the load at 1d3d is now out of the loop, and the value in
%esi is now provided by cmpxchg insn itself at 1d4e (plus move at
1d57). Unfortunately, the division clobbers %eax, so some reg-reg
moves are necessary. Note also that the compare at 1d69 is now gone.

> I also hope that you have tested this change with blktests nvme.

No, I didn't test the patch that thoroughly, but the change is the
same as some similar recent changes in the generic code, so I
confirmed the patch by inspecting asm code. OTOH, the kernel booted
from a NVME SSD.

> Either way:-
>
> Reviewed-by: ChaItanya Kulkarni <kch@nvidia.com>

Thanks!

Uros.
