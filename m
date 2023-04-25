Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8264D6EE0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjDYK7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjDYK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:59:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D840E49EA;
        Tue, 25 Apr 2023 03:58:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-246fa478d45so5083110a91.3;
        Tue, 25 Apr 2023 03:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682420337; x=1685012337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0JHWtYitmYVTIJ2+ge4uzqOjTVMwrngSNO6Xtd2pjU=;
        b=NR2WE+PgVRsWds0vo3wWvFtwGWABl8CrGItfKViXFhxsyUrBL04N2S1PfkqPdJ4LzQ
         JMMcQhwSiJpZgUPGMTBbIefeNfDHW5eErS7Lns22Z58bi3BvLFRPO1Fs0oYJp/vjzZT7
         l/aLkHxy0BV1OmBS3/ZugkuCMGUU6dSmaNG9DD3eN1sbDYCZfEhebaktBnf9xnX+J8ks
         l94ijmRjnxW+X0k5/QT75NHMuWJxQ/Y1zSaRiBFHWzbpwd4AjdZu6e4vfwce4ApmhKpn
         MAvbcqnrMtyJ42eG0Yr1klG/IXpJW6ouZK8m6oOpU8z9Pl0Xqt8Hg75CBu/MQVNAVEjH
         smQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420337; x=1685012337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0JHWtYitmYVTIJ2+ge4uzqOjTVMwrngSNO6Xtd2pjU=;
        b=hKDa67+Z1u95df1QC1u/aC3mR05v6dd3eiQoJW4EYxpya9yW5LSp1asWPIfS2jyUih
         aOYCGRHQLYvtb/QDiGCxo55NyuLICm45DtiU1m0Jbolik/6ByDagPwAhxrtGZv+NAc4h
         n/ROE3OR2EGnIYERe9yAaeCkjqO7/ODHniMwAw7I6z8teACDopYv4TBO9nezGHDzeWC7
         cECn6fyumbKLOGU0IS9ju+abef/N1i0ZfSXPf/NndqVUColHAvm2fJaGXaNu4rfld25n
         qvkCSqIS25Up6urm9K/XLLGulB7251ElKKbliEgUNj/5EbGX/7m1RsjkNXhgQige0k4+
         /vrw==
X-Gm-Message-State: AAQBX9fuTxtjymi7hoOVrobLaEwb32D/fZ8D5Wo1SGOP+3Xkccu/bsL8
        VbPZN5el39oSv4OPFAzpFGNbu1VpkKxT+4L8xww=
X-Google-Smtp-Source: AKy350b7YsHwI9f/5O7hIJgsJ7JJuWFqCPTNPXWlJ3/jyxBC4CZMH+4+sI+BWs8iKzjP1J9OdMb6AQjkhCoerfWOPJY=
X-Received: by 2002:a17:90a:950e:b0:24b:2ef6:64d5 with SMTP id
 t14-20020a17090a950e00b0024b2ef664d5mr16225496pjo.47.1682420337231; Tue, 25
 Apr 2023 03:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com> <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
In-Reply-To: <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 25 Apr 2023 18:58:46 +0800
Message-ID: <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On Tue, Apr 25, 2023 at 6:13=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
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
New test results today: both gcc build from git (git clone
git://gcc.gnu.org/git/gcc.git) and Ubuntu 22.04 gcc-12.1.0
are immune from the above issue. We can see the assembly code on
http://140.211.169.189/0425/srcu_gp_start_if_needed-gcc-12.txt

while
Both native gcc on PPC vm (gcc version 9.4.0), and gcc cross compiler
on my x86 laptop (gcc version 10.4.0) will reproduce the bug.
