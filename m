Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168C655424
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiLWUKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:10:49 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DE71098
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 12:10:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so8265952lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 12:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0vQrF2AVYSps54z1z5wZO/1oZ3nHmXeByZ++MFxVFc=;
        b=LeYloWDaVdzgaE3Surr1ToVW0RQpzWj1nU7UnXvxVg3ULuRD9VuMD8XZ0Uw//uBGZN
         4ldu19VOuQ225mStF/OJ+Goo/ALRBwQ/oTNoqZLDZycLv3eIMQxRHR4OyiJBpIcdPO63
         x2HD+fcZ3ItYlKULp1LUfDI7zqg6mfi08RTkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0vQrF2AVYSps54z1z5wZO/1oZ3nHmXeByZ++MFxVFc=;
        b=WxowhzYuUyK75QHrfl3IddVUM2N9tPsj/Sdtf/jSNvzt/k33U2RrQhwBQrRukDeSLD
         G60mx0U8pPr0ZXfa6TScHeXrzE+HV/EZZqyjiwP3RB2HpNzBtnoEC4B8Aj3kUvXInvgb
         nZyAte+MQALWHgOgoBSEWIJ/QFwKpFSuJ1xHDJGgPG2p0Wze0cS11XicoJLc9hKkjWdC
         pcxe1gwBumchPHLfB9gK1QA/BRResmsUL8tnU7f5E2z5ZeGbyidd5gCu5qZvsetYjkUj
         Rk8rCL17XuJ/miR+DWPX915h+TPSqgjXLZnZxYjFlAj/OO5iOjd6KhvXmSdZRw/8xVbU
         rSTg==
X-Gm-Message-State: AFqh2koRKB73pehLfv6FJrCYIfWT1g1ODpb8tzaqm4vQhDUReRWYzmhX
        /5EhkQlwEVZBsYtqUY9xwsQYFqXXsOUKvnaAu5xwqA==
X-Google-Smtp-Source: AMrXdXsDXQlps/MQhxoWZBc44ov6/TC1OXhB4vlOwwbn2O2Sb69ys67mS9+WY+SDHVh4k2nzAmUXw9NoHidWNs5wI6w=
X-Received: by 2002:ac2:5dcb:0:b0:4b4:f7aa:4e4 with SMTP id
 x11-20020ac25dcb000000b004b4f7aa04e4mr464357lfq.128.1671826245526; Fri, 23
 Dec 2022 12:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20221222185314.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <F492F726-00AA-4FC8-A5E5-BBF006CE946C@joelfernandes.org> <20221222194511.GS4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YScrnuSuWx69oJK+-+9Rdncn5kOSw0-SaWwwABix-Tb+A@mail.gmail.com>
 <CAEXW_YR=sx58kKRgvypduejx8jCGyDhMRBmZQNxtH3s0PS4u2g@mail.gmail.com> <20221223181514.GZ4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221223181514.GZ4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 23 Dec 2022 15:10:40 -0500
Message-ID: <CAEXW_YQ5ZfpFmMcsiyenK9XePz3jLiDYYUMdpuxbyNbnaH2Xhg@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 1:15 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Fri, Dec 23, 2022 at 11:12:06AM -0500, Joel Fernandes wrote:
> > On Thu, Dec 22, 2022 at 11:43 PM Joel Fernandes <joel@joelfernandes.org=
> wrote:
> > [...]
> > > > > >>>> On Dec 22, 2022, at 11:43 AM, Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > > > > >>>
> > > > > >>> =EF=BB=BFOn Thu, Dec 22, 2022 at 01:40:10PM +0100, Frederic W=
eisbecker wrote:
> > > > > >>>>> On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers=
 wrote:
> > > > > >>>>> On 2022-12-21 06:59, Frederic Weisbecker wrote:
> > > > > >>>>>>> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoye=
rs wrote:
> > > > > >>>>> [...]
> > > > > >>>>>>>
> > > > > >>>>>>> The memory ordering constraint I am concerned about here =
is:
> > > > > >>>>>>>
> > > > > >>>>>>> * [...] In addition,
> > > > > >>>>>>> * each CPU having an SRCU read-side critical section that=
 extends beyond
> > > > > >>>>>>> * the return from synchronize_srcu() is guaranteed to hav=
e executed a
> > > > > >>>>>>> * full memory barrier after the beginning of synchronize_=
srcu() and before
> > > > > >>>>>>> * the beginning of that SRCU read-side critical section. =
[...]
> > > > > >>>>>>>
> > > > > >>>>>>> So if we have a SRCU read-side critical section that begi=
ns after the beginning
> > > > > >>>>>>> of synchronize_srcu, but before its first memory barrier,=
 it would miss the
> > > > > >>>>>>> guarantee that the full memory barrier is issued before t=
he beginning of that
> > > > > >>>>>>> SRCU read-side critical section. IOW, that memory barrier=
 needs to be at the
> > > > > >>>>>>> very beginning of the grace period.
> > > > > >>>>>>
> > > > > >>>>>> I'm confused, what's wrong with this ?
> > > > > >>>>>>
> > > > > >>>>>> UPDATER                  READER
> > > > > >>>>>> -------                  ------
> > > > > >>>>>> STORE X =3D 1              STORE srcu_read_lock++
> > > > > >>>>>> // rcu_seq_snap()        smp_mb()
> > > > > >>>>>> smp_mb()                 READ X
> > > > > >>>>>> // scans
> > > > > >>>>>> READ srcu_read_lock
> > > > > >>>>>
> > > > > >>>>> What you refer to here is only memory ordering of the store=
 to X and load
> > > > > >>>>> from X wrt loading/increment of srcu_read_lock, which is in=
ternal to the
> > > > > >>>>> srcu implementation. If we really want to model the provide=
d high-level
> > > > > >>>>> memory ordering guarantees, we should consider a scenario w=
here SRCU is used
> > > > > >>>>> for its memory ordering properties to synchronize other var=
iables.
> > > > > >>>>>
> > > > > >>>>> I'm concerned about the following Dekker scenario, where sy=
nchronize_srcu()
> > > > > >>>>> and srcu_read_lock/unlock would be used instead of memory b=
arriers:
> > > > > >>>>>
> > > > > >>>>> Initial state: X =3D 0, Y =3D 0
> > > > > >>>>>
> > > > > >>>>> Thread A                   Thread B
> > > > > >>>>> ---------------------------------------------
> > > > > >>>>> STORE X =3D 1                STORE Y =3D 1
> > > > > >>>>> synchronize_srcu()
> > > > > >>>>>                          srcu_read_lock()
> > > > > >>>>>                          r1 =3D LOAD X
> > > > > >>>>>                          srcu_read_unlock()
> > > > > >>>>> r0 =3D LOAD Y
> > > > > >>>>>
> > > > > >>>>> BUG_ON(!r0 && !r1)
> > > > > >>>>>
> > > > > >>>>> So in the synchronize_srcu implementation, there appears to=
 be two
> > > > > >>>>> major scenarios: either srcu_gp_start_if_needed starts a gp=
 or expedited gp,
> > > > > >>>>> or it uses an already started gp/expedited gp. When snapsho=
tting with
> > > > > >>>>> rcu_seq_snap, the fact that the memory barrier is after the=
 ssp->srcu_gp_seq
> > > > > >>>>> load means that it does not order prior memory accesses bef=
ore that load.
> > > > > >>>>> This sequence value is then used to identify which gp_seq t=
o wait for when
> > > > > >>>>> piggy-backing on another already-started gp. I worry about =
reordering
> > > > > >>>>> between STORE X =3D 1 and load of ssp->srcu_gp_seq, which i=
s then used to
> > > > > >>>>> piggy-back on an already-started gp.
> > > > > >>>>>
> > > > > >>>>> I suspect that the implicit barrier in srcu_read_lock() inv=
oked at the
> > > > > >>>>> beginning of srcu_gp_start_if_needed() is really the barrie=
r that makes
> > > > > >>>>> all this behave as expected. But without documentation it's=
 rather hard to
> > > > > >>>>> follow.
> > > > > >>>>
> > > > > >>>> Oh ok I see now. It might be working that way by accident or=
 on forgotten
> > > > > >>>> purpose. In any case, we really want to add a comment above =
that
> > > > > >>>> __srcu_read_lock_nmisafe() call.
> > > > > >>>
> > > > > >>> Another test for the safety (or not) of removing either D or =
E is
> > > > > >>> to move that WRITE_ONCE() to follow (or, respectively, preced=
e) the
> > > > > >>> adjacent scans.
> > > > > >>
> > > > > >> Good idea, though I believe the MBs that the above talk about =
are not the flip ones. They are the ones in synchronize_srcu() beginning an=
d end, that order with respect to grace period start and end.
> > > > > >>
> > > > > >> So that (flipping MBs) is unrelated, or did I miss something?
> > > > > >
> > > > > > The thought is to manually similate in the source code the maxi=
mum
> > > > > > memory-reference reordering that a maximally hostile compiler a=
nd CPU
> > > > > > would be permitted to carry out.  So yes, given that there are =
other
> > > > > > memory barriers before and after, these other memory barriers l=
imit how
> > > > > > far the flip may be moved in the source code.
> > > > > >
> > > > > > Here I am talking about the memory barriers associated with the=
 flip,
> > > > > > but the same trick can of course be applied to other memory bar=
riers.
> > > > > > In general, remove a given memory barrier and (in the source co=
de)
> > > > > > maximally rearrange the memory references that were previously =
ordered
> > > > > > by the memory barrier in question.
> > > > > >
> > > > > > Again, the presence of other memory barriers will limit the per=
mitted
> > > > > > maximal source-code rearrangement.
> > > > >
> > > > >
> > > > > Makes sense if the memory barrier is explicit. In this case, the =
memory barriers are implicit apparently, with a srcu_read_lock() in the beg=
inning of synchronize_rcu() having the implicit / indirect memory barrier. =
So I am not sure if that can be implemented without breaking SRCU readers.
> > > >
> > > > First, are we talking about the same barrier?  I am talking about E=
.
>
> Apologies.  I am a bit fixated on E because it is the one you guys
> proposed eliminating.  ;-)

Ah ok, no worries. :-)

> > > No, in the last part you replied to above, Mathieu and Frederic were
> > > talking about the need for memory barriers in synchronize_srcu(). Tha=
t
> > > has nothing to do with E:
> > > <quote>
> > >  I suspect that the implicit barrier in srcu_read_lock() invoked at t=
he
> > >  beginning of srcu_gp_start_if_needed() is really the barrier that ma=
kes
> > >  all this behave as expected.
> > > </quote>
> > >
> > > We need to order code prior to synchronize_srcu() wrt the start of th=
e
> > > grace period, so that readers that started after the grace period
> > > started see those side-effects as they may not be waited on (they are
> > > too late).
> >
> > My thought is this is achieved by the srcu_read_lock() before the
> > grace period is started, and the start of the grace period (which is
> > basically the smp_mb() in the first scan).
> >
> > So from memory ordering PoV, if synchronize_rcu() spans the GP, and
> > readers don't span the GP, that means the reader does not span the
> > synchronize_rcu() which is the GP guarantee.
> >
> > But I could be missing something. I will dig more on my side. Thanks.
>
> Could you please specifically identify that srcu_read_lock()?
>
> Also which version you are looking at.  ;-)

Should be this one in current -rcu:
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/=
kernel/rcu/srcutree.c#n1669

Thanks,

 - Joel
