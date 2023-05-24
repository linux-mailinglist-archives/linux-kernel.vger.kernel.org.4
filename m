Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7138870FEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjEXToe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjEXTob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:44:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03458186;
        Wed, 24 May 2023 12:44:30 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af318fa2b8so16106801fa.0;
        Wed, 24 May 2023 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684957468; x=1687549468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6uverP8/Z1wMx7w7sWuXWr6bokp1v2GsI7LJs+SC6E=;
        b=n6La81gzVPbxK8DJDhLSXGv+LeEXRvzarJw6pOplwcRusbFKnE5J5sTo6kmgF3n+mK
         IFGSPesaFO34YoOv8yx6iwV72idzsuJhfAjPOXWr//gLF4KTSeZOKnID/KcDHN3ZKl3V
         ZRfs9eiT7i3wHrSV6+CDt81XoSPJ4awrcR22mYJCUIwmpK37nU04v6K6t6ichVPalrOS
         wEMRQguRpPgtt2+q8PjqQUBpd1YBEOp3p2tINBxocVVD/ArwY6FFzqaoRCzowpnu3ml8
         9/fp4X1KHLdFyabsfp2EUrd0rd6VkCRdfAtznAj2jgYGSp9+n4ybHNubLLh8qGVLKPJ3
         nIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957468; x=1687549468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6uverP8/Z1wMx7w7sWuXWr6bokp1v2GsI7LJs+SC6E=;
        b=fpGH7RmalQ08vVPU2YMY/X3ISDCAFbbDQPWgYCRg1BDmUwwfmQyobfqCAiuMY53zNO
         xpL0VG/LhUP9dhF0Qwf4iXyGBrT0ZnZPMtn6Qp9s0vPWMw+SldozVKONspeJK62zYSP8
         eb2gut8FI3jeIvZ/2ZXkFcCJuvKIVRF0OWcQK87sA1RTXDsSoaA6A3Lq0y4PpNjaQ2ny
         VxjYEPYf3NeRwg0XvgS2Z5Qg0D/fxL4wDiOQkP3iZlgap81s14KXY7pIBnQpMTl6PaA4
         GknoneZCc7NXqApGfhHT/iLJCW01MJQnkPiJV/L1f83osOAINFmF3ONYoMSPFi20X8Kf
         ONgg==
X-Gm-Message-State: AC+VfDze125imYSQrGiL2gcTojoEtGdalw2BXQxBHpTu17eEqX91zg7b
        4ZQbU1deJ/8nbjV27c71atGvDa+HBF/OmBt4+XU=
X-Google-Smtp-Source: ACHHUZ4cvZY9lXmSSuPdEPM4CXOa3acqL/xeHhfDQSn/MeKIay24JWBYKQ79N3Q03rXmNLsyRdF2dIIypJ3EZR/OSxU=
X-Received: by 2002:a05:651c:210:b0:2aa:481b:b439 with SMTP id
 y16-20020a05651c021000b002aa481bb439mr285495ljn.21.1684957467942; Wed, 24 May
 2023 12:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230516111823.2103536-1-starmiku1207184332@gmail.com>
 <e37c0a65-a3f6-e2e6-c2ad-367db20253a0@meta.com> <CALyQVax8X63qekZVhvRTmZFFs+ucPKRkBB7UnRZk6Hu3ggi7Og@mail.gmail.com>
 <57dc6a0e-6ba9-e77c-80ac-6bb0a6e2650a@meta.com> <CALyQVazb=D1ejapiFdTnan6JbjFJA2q9ifhSsmF4OC9MDz3oAw@mail.gmail.com>
 <d027cb6b-e32c-36ad-3aba-9a7b1177f89f@meta.com> <CALyQVayW7e4FPbaMNNuOmYGYt5pcd47zsx2xVkrekEDaVm7H2g@mail.gmail.com>
 <113dc8c1-0840-9ee3-2840-28246731604c@meta.com>
In-Reply-To: <113dc8c1-0840-9ee3-2840-28246731604c@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 May 2023 12:44:16 -0700
Message-ID: <CAADnVQ+5GXu8Q1_awiHExhBB9_LmGrcPTvjQEjQU58pzX3WbQQ@mail.gmail.com>
Subject: Re: [bug] kernel: bpf: syscall: a possible sleep-in-atomic bug in __bpf_prog_put()
To:     Yonghong Song <yhs@meta.com>
Cc:     Teng Qi <starmiku1207184332@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 12:34=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 5/24/23 5:42 AM, Teng Qi wrote:
> > Thank you.
> >
> >> We cannot use rcu_read_lock_held() in the 'if' statement. The return
> >> value rcu_read_lock_held() could be 1 for some configurations regardle=
ss
> >> whether rcu_read_lock() is really held or not. In most cases,
> >> rcu_read_lock_held() is used in issuing potential warnings.
> >> Maybe there are other ways to record whether rcu_read_lock() is held o=
r not?
> >
> > Sorry. I was not aware of the dependency of configurations of
> > rcu_read_lock_held().
> >
> >> If we cannot resolve rcu_read_lock() presence issue, maybe the conditi=
on
> >> can be !in_interrupt(), so any process-context will go to a workqueue.
> >
> > I agree that using !in_interrupt() as a condition is an acceptable solu=
tion.
>
> This should work although it could be conservative.
>
> >
> >> Alternatively, we could have another solution. We could add another
> >> function e.g., bpf_prog_put_rcu(), which indicates that bpf_prog_put()
> >> will be done in rcu context.
> >
> > Implementing a new function like bpf_prog_put_rcu() is a solution that =
involves
> > more significant changes.
>
> Maybe we can change signature of bpf_prog_put instead? Like
>     void bpf_prog_put(struct bpf_prog *prog, bool in_rcu)
> and inside bpf_prog_put we can add
>     WARN_ON_ONCE(in_rcu && !bpf_rcu_lock_held());

bpf_rcu_lock_held() is used for different cases.

Here s/in_irq/in_interrupt/ inside bpf_prog_put() is enough
to address this theoretical issue.
