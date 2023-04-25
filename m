Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4F6EE0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjDYK7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjDYK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:59:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E280CC2E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:59:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fae5e9ec7so62981647b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682420380; x=1685012380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUg+wNP5+RlGjx++pGYBiKCIld1zQdbRIXNqep4/CZY=;
        b=xqweQ1xw0DS4HaLefbthJGpFnpdM1a5ar9XrlzaVPB2uYZ3keHM9+iJcpYs5jlGPYw
         GlojP/aOOysoc7fsoOwDPVYqcusgLhlQ+94hs5NyHKPzvEvtT/OWe6E9WG8WrnuCm6QA
         rK8TroW1KZrHvDEcrqTxBhiX+vahvoKpHXzX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420380; x=1685012380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUg+wNP5+RlGjx++pGYBiKCIld1zQdbRIXNqep4/CZY=;
        b=J5YCvtnkj4r3BtmJIUcRSw4MGL+5ufNMhSHhyC30dQy5Sai4kNKImcVaPmI8Xd6HNK
         yskf7M5Yx08/WzauT8dvtrbnYWLOkaaTZh3wkfiu90yRTHCmO1b7zUN9kx5Bkekc4NNO
         z89KqbW64Te7OUPQQKHUlJFMUiCcsHxwg6SkuNa120GN2aRVo9FcCqi2IlBZL+XA2tr1
         nN1paipw8oi+hgAfaZMRiRcqvTziUthd6SmNOhF6v3fE77XnizUek/BNvsorT7V23N6F
         SCbCNp3MdF0tJwHY1iaAh6ZQnKYsEUooJ1KHwP6RiaRsfP3be8MFm/I4ammWG6ZM3SV/
         CqcA==
X-Gm-Message-State: AAQBX9dRsMJsVe7YhmtA7N4QS1YufDrXKWsOAMi9L5W4HFYFjApJLk8t
        kARolb90eKOihoYpZTE1W9ORUnzT5d1IeCIe+3pJ6w==
X-Google-Smtp-Source: AKy350YaQoIpYpar+yrvSSOL9ToYRuxOYpny2c9JespRM7apZgHDEAqlXF+tX74BhnaJumdsvGm5n6jRBV8nLU+7V/w=
X-Received: by 2002:a81:8303:0:b0:54f:d233:d3b7 with SMTP id
 t3-20020a818303000000b0054fd233d3b7mr8858195ywf.21.1682420380486; Tue, 25 Apr
 2023 03:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com> <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
In-Reply-To: <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Apr 2023 06:59:29 -0400
Message-ID: <CAEXW_YRFZ3zDc0gJRHjJPRuNaBtnmUc+9RxSAHH48jkFw_b34g@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 6:13=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 24, 2023 at 02:55:11PM -0400, Joel Fernandes wrote:
> > This is amazing debugging Boqun, like a boss! One comment below:
> >
> > > > > Or something simple I haven't thought of? :)
> > > >
> > > > At what points can r13 change?  Only when some particular functions=
 are
> > > > called?
> > > >
> > >
> > > r13 is the local paca:
> > >
> > >         register struct paca_struct *local_paca asm("r13");
> > >
> > > , which is a pointer to percpu data.
> > >
> > > So if a task schedule from one CPU to anotehr CPU, the value gets
> > > changed.
> >
> > It appears the whole issue, per your analysis, is that the stack
> > checking code in gcc should not cache or alias r13, and must read its
> > most up-to-date value during stack checking, as its value may have
> > changed during a migration to a new CPU.
> >
> > Did I get that right?
> >
> > IMO, even without a reproducer, gcc on PPC should just not do that,
> > that feels terribly broken for the kernel. I wonder what clang does,
> > I'll go poke around with compilerexplorer after lunch.
> >
> > Adding +Peter Zijlstra as well to join the party as I have a feeling
> > he'll be interested. ;-)
>
> I'm a little confused; the way I understand the whole stack protector
> thing to work is that we push a canary on the stack at call and on
> return check it is still valid. Since in general tasks randomly migrate,
> the per-cpu validation canary should be the same on all CPUs.
>
> Additionally, the 'new' __srcu_read_{,un}lock_nmisafe() functions use
> raw_cpu_ptr() to get 'a' percpu sdp, preferably that of the local cpu,
> but no guarantees.
>
> Both cases use r13 (paca) in a racy manner, and in both cases it should
> be safe.

AFAICS, the canary is randomly chosen both in the kernel [1]. This
also appears to be the case in glibc. That makes sense because you
don't want the canary to be something that the attacker can easily
predict and store on the stack to bypass buffer overflow attacks:

[1] kernel :
/*
 * Initialize the stackprotector canary value.
 *
 * NOTE: this must only be called from functions that never return,
 * and it must always be inlined.
 */
static __always_inline void boot_init_stack_canary(void)
{
        unsigned long canary =3D get_random_canary();

        current->stack_canary =3D canary;
#ifdef CONFIG_PPC64
        get_paca()->canary =3D canary;
#endif
}

thanks,

 - Joel
