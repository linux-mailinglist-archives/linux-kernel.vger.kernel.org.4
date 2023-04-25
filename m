Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5B6EE0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjDYLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjDYLG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:06:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B4314445
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:06:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b992e28c141so7008207276.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682420779; x=1685012779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxnh6Hi9HqlHGEwie6ZZICYaa0bP7KY/+WuMwYNYTmY=;
        b=VdR3wwmAEjxfeujbEcL+VAXT+xd04RRZcqXvF6U5icWhnGsOEohwg7vARx9yoOTROC
         hbiMXGNFSBxAXxwprIgOE8Xq0QItgGv02in+lMvVZuq8Klm4WI0CUFQ2Hrac/yWECqi4
         md5KxCiyVN7a9X+oAjBZ3b9rrFEPZpDwnbm2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420779; x=1685012779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxnh6Hi9HqlHGEwie6ZZICYaa0bP7KY/+WuMwYNYTmY=;
        b=G8cGF5pkTzmdxqtPcTvpvP5HLV6SlW1SGXWywSXebjDOCV23ycElgnLhCKPsh7Np1q
         DiF8zz7BYHNpanuMrji7wLidLQ/X3O9g/bcWWzfaWvse3FdZRmICRo2zHWXdKS0fGSlN
         fOsaDWiTzOejWH59ax7fThOSBqcBJqzXw7KRfmZb3nKNLd81gdwPxkf2isxH+eRvtGo2
         xhkBejcMja0gPP3UNOogXjWCAn6Eu9TQ+0KVzk8R4Nim6xZOT/i7rmwza+I/N7zNgl+2
         g/JQSGi+jAlMfNNhVjqPn1zYJjxHjCwo4G1Gf/tYzzVsfKuJtPEVcpkJoSe9FMXAgqH5
         gu1Q==
X-Gm-Message-State: AAQBX9fidV1jL6SRxuZZoR/4k2Kz88E7y1FvK3WiX4jxBkS49iwF9QuA
        +8Nw1eNPortatl8DzHt2YMw+ljRRPc/TJviG2ExGsQ==
X-Google-Smtp-Source: AKy350Z2MMGY9lUYIgZ/RTFuuaAQUwutf3WfAlP93ocKcWEfXzN5niDO7fXLYWQHI48oJKslRzKoaFZSHENDyb2u5I0=
X-Received: by 2002:a81:5288:0:b0:54f:ba9d:c9c4 with SMTP id
 g130-20020a815288000000b0054fba9dc9c4mr9756341ywb.16.1682420779531; Tue, 25
 Apr 2023 04:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net> <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
In-Reply-To: <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Apr 2023 07:06:08 -0400
Message-ID: <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 6:58=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
>
> hi
>
> On Tue, Apr 25, 2023 at 6:13=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Mon, Apr 24, 2023 at 02:55:11PM -0400, Joel Fernandes wrote:
> > > This is amazing debugging Boqun, like a boss! One comment below:
> > >
> > > > > > Or something simple I haven't thought of? :)
> > > > >
> > > > > At what points can r13 change?  Only when some particular functio=
ns are
> > > > > called?
> > > > >
> > > >
> > > > r13 is the local paca:
> > > >
> > > >         register struct paca_struct *local_paca asm("r13");
> > > >
> > > > , which is a pointer to percpu data.
> > > >
> > > > So if a task schedule from one CPU to anotehr CPU, the value gets
> > > > changed.
> > >
> > > It appears the whole issue, per your analysis, is that the stack
> > > checking code in gcc should not cache or alias r13, and must read its
> > > most up-to-date value during stack checking, as its value may have
> > > changed during a migration to a new CPU.
> > >
> > > Did I get that right?
> > >
> > > IMO, even without a reproducer, gcc on PPC should just not do that,
> > > that feels terribly broken for the kernel. I wonder what clang does,
> > > I'll go poke around with compilerexplorer after lunch.
> > >
> > > Adding +Peter Zijlstra as well to join the party as I have a feeling
> > > he'll be interested. ;-)
> >
> > I'm a little confused; the way I understand the whole stack protector
> > thing to work is that we push a canary on the stack at call and on
> > return check it is still valid. Since in general tasks randomly migrate=
,
> > the per-cpu validation canary should be the same on all CPUs.
> >
> > Additionally, the 'new' __srcu_read_{,un}lock_nmisafe() functions use
> > raw_cpu_ptr() to get 'a' percpu sdp, preferably that of the local cpu,
> > but no guarantees.
> >
> > Both cases use r13 (paca) in a racy manner, and in both cases it should
> > be safe.
> New test results today: both gcc build from git (git clone
> git://gcc.gnu.org/git/gcc.git) and Ubuntu 22.04 gcc-12.1.0
> are immune from the above issue. We can see the assembly code on
> http://140.211.169.189/0425/srcu_gp_start_if_needed-gcc-12.txt
>
> while
> Both native gcc on PPC vm (gcc version 9.4.0), and gcc cross compiler
> on my x86 laptop (gcc version 10.4.0) will reproduce the bug.

Do you know what fixes the issue? I would not declare victory yet. My
feeling is something changes in timing, or compiler codegen which
hides the issue. So the issue is still there but it is just a matter
of time before someone else reports it.

Out of curiosity for PPC folks, why cannot 64-bit PPC use per-task
canary? Michael, is this an optimization? Adding Christophe as well
since it came in a few years ago via the following commit:

commit 06ec27aea9fc84d9c6d879eb64b5bcf28a8a1eb7
Author: Christophe Leroy <christophe.leroy@c-s.fr>
Date:   Thu Sep 27 07:05:55 2018 +0000

    powerpc/64: add stack protector support

    On PPC64, as register r13 points to the paca_struct at all time,
    this patch adds a copy of the canary there, which is copied at
    task_switch.
    That new canary is then used by using the following GCC options:
    -mstack-protector-guard=3Dtls
    -mstack-protector-guard-reg=3Dr13
    -mstack-protector-guard-offset=3Doffsetof(struct paca_struct, canary))

    Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

 - Joel
