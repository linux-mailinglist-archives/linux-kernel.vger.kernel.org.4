Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307E6EEC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbjDZCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDZCh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:37:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B0185;
        Tue, 25 Apr 2023 19:37:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b50a02bffso5433783b3a.2;
        Tue, 25 Apr 2023 19:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682476676; x=1685068676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfQf0Jiq6X/CERIYJD0dYWjMRKdECYu2KJD2RoQUN1A=;
        b=GQ92gMFYuO32gPskobDC7LKjddLGuQpCOezV6OfQ0rXCKiC/Vysxgt8tEnuAHTSIUY
         eoQqnAzbYadUr2sP/69pt3JFZ4yx7QvNwnP7uvutjwDuJqEzMAtPCDF6jbuDH1u3YpK6
         Pjgs9KYJXAuneDuy7wkLtsZZEaaBWi4eh5IHSMozfk72bDm8Dq62nmcr8tr39xYMoB/N
         YkF5EMvyKDipxFqlNC5u8QrXkhnwjVvzEoFWUGxEkx1oNOyv8YE/5KJvL9oMCZZrA2rD
         /I9p79t6MMlFrc/gUoZ18gC9zxlSuEhUQzQPqQOhLJd3CR8/0AvRCwqCST6Dnk9bqAKN
         2W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682476676; x=1685068676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfQf0Jiq6X/CERIYJD0dYWjMRKdECYu2KJD2RoQUN1A=;
        b=d8/sL16R6WiaOn7F2Rf1Ags/sJkgdJK3Gx9FelNp24K7lK60YxOJEb9zC6nyk7zGxn
         uR5spgN6LM3UTJcZqEIDUPti0TvsNmSVnCFVp2p8tK/gB9uM2A1cArJwIMpPAroRxzto
         nylRAMNSU7WiJ7y/MJ60CQUwXPyf58VL+HEmx3FmWXS5QDQhB8nPELh4oNqgfoYgobGQ
         p3rQoeJunPF+H9zFkFR4I/y+9oaD7l5WcIBxB4/mUDn4z5iVfyG9S4UD2M7aUci3J3GC
         RC5VGrTXQLFg/BFv/eGM71oIb30eZUhrCdjEFOb1XIvf7Q5YzIEV+MGIKiEnB6m5qX3Z
         Ltnw==
X-Gm-Message-State: AC+VfDxsufwYYBF32akc0and0curw4gysAGCcSNbZBePMymbcnhBUd3x
        wUyWPSMh0FSekn7UmSmhQnAsCHDp8DAL1YOawEoP31YnE3hcrDiJ
X-Google-Smtp-Source: ACHHUZ4IR8CoJOS6oK95WrG9GmHIoQpEmg3s9C4z6TqevPOwRefuUdrCkZobGGq7KBW0hcQOC9s19lORl2TB46CmKSs=
X-Received: by 2002:a05:6a20:3c90:b0:f3:6406:9b0e with SMTP id
 b16-20020a056a203c9000b000f364069b0emr3546163pzj.23.1682476675740; Tue, 25
 Apr 2023 19:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
 <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
 <528b2adc-9955-5545-9e9d-affd1f935838@csgroup.eu> <CAABZP2zW7aTPChjvZMA1bECdOdFUdTd-q+vEJXJnH2zPU+uR8A@mail.gmail.com>
 <CAEXW_YQJowYrF2A=f2NOKNNjL6qZH6LzghBxt7VnJFgg-i1zgg@mail.gmail.com>
 <CAABZP2w8eDSRXCoLiWGjGtz6VifPfaaF=Mje7Y8aXjugy-vNkA@mail.gmail.com> <20230426021525.GA2171827@google.com>
In-Reply-To: <20230426021525.GA2171827@google.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 26 Apr 2023 10:37:44 +0800
Message-ID: <CAABZP2z-ny8ruzTc7snthzpgs6aEi93e8a19pLRK-Aw74FToMA@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "lance@osuosl.org" <lance@osuosl.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Wed, Apr 26, 2023 at 10:15=E2=80=AFAM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> Hi Zhouyi,
>
> On Wed, Apr 26, 2023 at 09:31:17AM +0800, Zhouyi Zhou wrote:
> [..]
> > Joel makes the learning process easier for me, indeed!
>
> I know that feeling being a learner myself ;-)
>
> > One question I have tried very hard to understand, but still confused.
> > for now, I know
> > r13 is fixed, but r1 is not, why "r9,40(r1)"'s 40(r1) can be assumed
> > to be equal to 3192(r10).
>
> First you have to I guess read up a bit about stack canaries. Google for
> "gcc stack protector" and "gcc stack canaries", and the look for basics o=
f
> "buffer overflow attacks". That'll explain the concept of stack guards et=
c
> (Sorry if this is too obvious but I did not know how much you knew about =
it
> already).
>
> 40(r1) is where the canary was stored. In the beginning of the function, =
you
> have this:
>
> c000000000226d58:       78 0c 2d e9     ld      r9,3192(r13)
> c000000000226d5c:       28 00 21 f9     std     r9,40(r1)
>
> r1 is your stack pointer. 3192(r13) is the canary value.
>
> 40(r1) is where the canary is stored for later comparison.
>
> r1 should not change through out the function I believe, because otherwis=
e
> you don't know where the stack frame is, right?
Thanks Joel's awesome explanation. I can understand the mechanics
behind our situation now!!
40(r1) is where the canary is stored for later comparison, this is
located on the stack.
while 3192(r13) is inside the cpu's PACA.
I quote Christophe's note here
"in order to be able to
have the canary as an offset of a fixed register as expected by GCC, we
copy the task canary into the cpu's PACA struct during _switch():
        addi    r6,r4,-THREAD   /* Convert THREAD to 'current' */
        std     r6,PACACURRENT(r13)     /* Set new 'current' */
#if defined(CONFIG_STACKPROTECTOR)
        ld      r6, TASK_CANARY(r6)
        std     r6, PACA_CANARY(r13)
#endif
"
>
> Later you have this stuff before the function returns which gcc presumabl=
y
> did due to optimization. That mr means move register and is where the cac=
hing
> of r13 to r10 happens that Boqun pointed.
Thank Boqun and all others' wonderful debugging! Your work confirmed
my bug report ;-)
>
> c000000000226eb4:       78 6b aa 7d     mr      r10,r13
> [...]
> and then the canary comparison happens:
>
> c000000000226ed8:       28 00 21 e9     ld      r9,40(r1)
> c000000000226edc:       78 0c 4a e9     ld      r10,3192(r10)
3192(r13) is correct because "we copy the task canary into the cpu's
PACA struct during _switch():"
but 3192(r10) is not correct, because r10 is the old value of r13.
> c000000000226ee0:       79 52 29 7d     xor.    r9,r9,r10
> c000000000226ee4:       00 00 40 39     li      r10,0
> c000000000226ee8:       b8 03 82 40     bne     c0000000002272a0 <srcu_gp=
_start_if_needed+0x5a0>
>
> So looks like for this to blow up, the preemption/migration has to happen
> precisely between the mr doing the caching, and the xor doing the compari=
son,
> since that's when the r10 will be stale.
Thank Joel and all others for your time ;-)
I benefit a lot, and am very glad to do more good work to the
community in return ;-)

Cheers
Zhouyi
>
> thanks,
>
>  - Joel
>
