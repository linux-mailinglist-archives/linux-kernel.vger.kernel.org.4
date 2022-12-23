Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3E65528F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiLWQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLWQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:12:23 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACE6A45D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:12:21 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 36so3570045pgp.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfvGTuV+oQwVxGu8lGbzwvtkC4UG7004rGFY5ugSgsA=;
        b=wBaiYFrn6NXg461E/pVzWZo2mgWwc89layG5Cp1neSGiN/m++8dYdDu46IQupioIKd
         v7WpJ8iq/x/u/XolqVapi/bHvxygIdUtyNjo8yl9zQaU9T0l4lkiCHrIUEelzdEf/YgC
         7cTuVmug2gR9jmCJauAsFMMzRFJvcTlXy9nU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfvGTuV+oQwVxGu8lGbzwvtkC4UG7004rGFY5ugSgsA=;
        b=0Zh1bcbPV9yosDkKBPdhwz6YTkSCKe9lRRSfrVdLX3GfUl27MNMF5NjR0mPr2Fbkv+
         9O9NiFMz02IXhtpAwh9Hypew+Kf08swkj/cV/YIzZcQTABjtngLPk2Zwa2i549S+RPpP
         5I8Cy2l2lOyIcO/BaobkYD7by0QMkDFOXEaORHxnq5Ezic/iYIba7IVbP/tESixYrYZY
         5GOAOvWREnrnxyQt4Z7izSLaMz5WiYUBkbZzL68lFU+P7BACSfr9QO6e3ALTWf3b3Xg3
         Eg7cFjHbLySfWn8nabDDtiawskcEF4KdapbIUW3uD9QFk3TMJYkVYOwh02bcy5DDiuwv
         25SQ==
X-Gm-Message-State: AFqh2kqGlmvr1xVk/RseDoeosWnh+FTH93guf43WmmR3Fhz7OqbKV9gY
        tX9JJE75Mwquu5WcIbHhPhHUaQTOajPMNTuvuAWcrQ==
X-Google-Smtp-Source: AMrXdXswBu3kOsDdjFr1o/Bg1J8szBevzgnUZH+lxtjUJJVwy5Bv/scdFjV72hb/438m1EDa/OLoKpu6m+zlMD4n2KU=
X-Received: by 2002:a63:c147:0:b0:478:e6d6:b71b with SMTP id
 p7-20020a63c147000000b00478e6d6b71bmr501284pgi.146.1671811941169; Fri, 23 Dec
 2022 08:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20221222185314.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <F492F726-00AA-4FC8-A5E5-BBF006CE946C@joelfernandes.org> <20221222194511.GS4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YScrnuSuWx69oJK+-+9Rdncn5kOSw0-SaWwwABix-Tb+A@mail.gmail.com>
In-Reply-To: <CAEXW_YScrnuSuWx69oJK+-+9Rdncn5kOSw0-SaWwwABix-Tb+A@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 23 Dec 2022 11:12:06 -0500
Message-ID: <CAEXW_YR=sx58kKRgvypduejx8jCGyDhMRBmZQNxtH3s0PS4u2g@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:43 PM Joel Fernandes <joel@joelfernandes.org> wr=
ote:
[...]
> > > >>>> On Dec 22, 2022, at 11:43 AM, Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
> > > >>>
> > > >>> =EF=BB=BFOn Thu, Dec 22, 2022 at 01:40:10PM +0100, Frederic Weisb=
ecker wrote:
> > > >>>>> On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wro=
te:
> > > >>>>> On 2022-12-21 06:59, Frederic Weisbecker wrote:
> > > >>>>>>> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers w=
rote:
> > > >>>>> [...]
> > > >>>>>>>
> > > >>>>>>> The memory ordering constraint I am concerned about here is:
> > > >>>>>>>
> > > >>>>>>> * [...] In addition,
> > > >>>>>>> * each CPU having an SRCU read-side critical section that ext=
ends beyond
> > > >>>>>>> * the return from synchronize_srcu() is guaranteed to have ex=
ecuted a
> > > >>>>>>> * full memory barrier after the beginning of synchronize_srcu=
() and before
> > > >>>>>>> * the beginning of that SRCU read-side critical section. [...=
]
> > > >>>>>>>
> > > >>>>>>> So if we have a SRCU read-side critical section that begins a=
fter the beginning
> > > >>>>>>> of synchronize_srcu, but before its first memory barrier, it =
would miss the
> > > >>>>>>> guarantee that the full memory barrier is issued before the b=
eginning of that
> > > >>>>>>> SRCU read-side critical section. IOW, that memory barrier nee=
ds to be at the
> > > >>>>>>> very beginning of the grace period.
> > > >>>>>>
> > > >>>>>> I'm confused, what's wrong with this ?
> > > >>>>>>
> > > >>>>>> UPDATER                  READER
> > > >>>>>> -------                  ------
> > > >>>>>> STORE X =3D 1              STORE srcu_read_lock++
> > > >>>>>> // rcu_seq_snap()        smp_mb()
> > > >>>>>> smp_mb()                 READ X
> > > >>>>>> // scans
> > > >>>>>> READ srcu_read_lock
> > > >>>>>
> > > >>>>> What you refer to here is only memory ordering of the store to =
X and load
> > > >>>>> from X wrt loading/increment of srcu_read_lock, which is intern=
al to the
> > > >>>>> srcu implementation. If we really want to model the provided hi=
gh-level
> > > >>>>> memory ordering guarantees, we should consider a scenario where=
 SRCU is used
> > > >>>>> for its memory ordering properties to synchronize other variabl=
es.
> > > >>>>>
> > > >>>>> I'm concerned about the following Dekker scenario, where synchr=
onize_srcu()
> > > >>>>> and srcu_read_lock/unlock would be used instead of memory barri=
ers:
> > > >>>>>
> > > >>>>> Initial state: X =3D 0, Y =3D 0
> > > >>>>>
> > > >>>>> Thread A                   Thread B
> > > >>>>> ---------------------------------------------
> > > >>>>> STORE X =3D 1                STORE Y =3D 1
> > > >>>>> synchronize_srcu()
> > > >>>>>                          srcu_read_lock()
> > > >>>>>                          r1 =3D LOAD X
> > > >>>>>                          srcu_read_unlock()
> > > >>>>> r0 =3D LOAD Y
> > > >>>>>
> > > >>>>> BUG_ON(!r0 && !r1)
> > > >>>>>
> > > >>>>> So in the synchronize_srcu implementation, there appears to be =
two
> > > >>>>> major scenarios: either srcu_gp_start_if_needed starts a gp or =
expedited gp,
> > > >>>>> or it uses an already started gp/expedited gp. When snapshottin=
g with
> > > >>>>> rcu_seq_snap, the fact that the memory barrier is after the ssp=
->srcu_gp_seq
> > > >>>>> load means that it does not order prior memory accesses before =
that load.
> > > >>>>> This sequence value is then used to identify which gp_seq to wa=
it for when
> > > >>>>> piggy-backing on another already-started gp. I worry about reor=
dering
> > > >>>>> between STORE X =3D 1 and load of ssp->srcu_gp_seq, which is th=
en used to
> > > >>>>> piggy-back on an already-started gp.
> > > >>>>>
> > > >>>>> I suspect that the implicit barrier in srcu_read_lock() invoked=
 at the
> > > >>>>> beginning of srcu_gp_start_if_needed() is really the barrier th=
at makes
> > > >>>>> all this behave as expected. But without documentation it's rat=
her hard to
> > > >>>>> follow.
> > > >>>>
> > > >>>> Oh ok I see now. It might be working that way by accident or on =
forgotten
> > > >>>> purpose. In any case, we really want to add a comment above that
> > > >>>> __srcu_read_lock_nmisafe() call.
> > > >>>
> > > >>> Another test for the safety (or not) of removing either D or E is
> > > >>> to move that WRITE_ONCE() to follow (or, respectively, precede) t=
he
> > > >>> adjacent scans.
> > > >>
> > > >> Good idea, though I believe the MBs that the above talk about are =
not the flip ones. They are the ones in synchronize_srcu() beginning and en=
d, that order with respect to grace period start and end.
> > > >>
> > > >> So that (flipping MBs) is unrelated, or did I miss something?
> > > >
> > > > The thought is to manually similate in the source code the maximum
> > > > memory-reference reordering that a maximally hostile compiler and C=
PU
> > > > would be permitted to carry out.  So yes, given that there are othe=
r
> > > > memory barriers before and after, these other memory barriers limit=
 how
> > > > far the flip may be moved in the source code.
> > > >
> > > > Here I am talking about the memory barriers associated with the fli=
p,
> > > > but the same trick can of course be applied to other memory barrier=
s.
> > > > In general, remove a given memory barrier and (in the source code)
> > > > maximally rearrange the memory references that were previously orde=
red
> > > > by the memory barrier in question.
> > > >
> > > > Again, the presence of other memory barriers will limit the permitt=
ed
> > > > maximal source-code rearrangement.
> > >
> > >
> > > Makes sense if the memory barrier is explicit. In this case, the memo=
ry barriers are implicit apparently, with a srcu_read_lock() in the beginni=
ng of synchronize_rcu() having the implicit / indirect memory barrier. So I=
 am not sure if that can be implemented without breaking SRCU readers.
> >
> > First, are we talking about the same barrier?  I am talking about E.
>
> No, in the last part you replied to above, Mathieu and Frederic were
> talking about the need for memory barriers in synchronize_srcu(). That
> has nothing to do with E:
> <quote>
>  I suspect that the implicit barrier in srcu_read_lock() invoked at the
>  beginning of srcu_gp_start_if_needed() is really the barrier that makes
>  all this behave as expected.
> </quote>
>
> We need to order code prior to synchronize_srcu() wrt the start of the
> grace period, so that readers that started after the grace period
> started see those side-effects as they may not be waited on (they are
> too late).

My thought is this is achieved by the srcu_read_lock() before the
grace period is started, and the start of the grace period (which is
basically the smp_mb() in the first scan).

So from memory ordering PoV, if synchronize_rcu() spans the GP, and
readers don't span the GP, that means the reader does not span the
synchronize_rcu() which is the GP guarantee.

But I could be missing something. I will dig more on my side. Thanks.
