Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3271C654BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLWEn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWEnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:43:53 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F661DDC4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 20:43:51 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f16so3900620ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 20:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6ADJ2h5z8TSdQPkqKlezNJ1k2pSsiVVtLJbj/jfKTM=;
        b=ebxINr9jSAupNaYYR420TFcbxcHc/q2a9Kwh0oaBPVfOF2DpYKCqGKL6CyHrQikVAY
         lHEkPYNWtZifgMqztz2qcsuU2uJXO7GYUrOhFt81v7VzZLyso2KEDkwNdlzi5khkbhCN
         9/8UF5m1DCtcxPbexNA3PlNyvxoU7hWPAiVgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6ADJ2h5z8TSdQPkqKlezNJ1k2pSsiVVtLJbj/jfKTM=;
        b=w2z1xt1CieAc7U22dgWjZVvf3DkXBcBuRwlSIpYq24IJK7tDlwyniZ7/kYq8ne3pwv
         G64xqJ+mco1Ujy9CfXIjn0GBaEXycQhXcneSFgL4A8+lVMrB+jrTNxrnOGLc5a27U05K
         L1+L9wTDs+Bo49tAqC517Y9AWXRaZRW4T9fab7ASAdlkqTx2g7DqFo627f3n3CWH6PsD
         bGkd75l82DQ+g+7VPHtl7Dph/vp8wGvd7thk/jB+r6ojR9lv/2dK+gVtGOwTnZgHIoFo
         0IdyjwXg7V7CqLHh/rB2emQaRjgtvLQ7gZzPRyWitaNGiBwpSaShaN1P7/E1fLE4bSbJ
         qlJQ==
X-Gm-Message-State: AFqh2kpZhIC3QOqIZezje1tUj8m7i4epage3TmeJP+syAG55UDDza/iy
        6DpfZmdXf9SrzEgHEFkqFHiMseDluGJisI0Qb/+zsCXnMBxs74El
X-Google-Smtp-Source: AMrXdXueufRQmWBrqya2rX5PaCCo0glbhyWxp/Sg2XRlmV8d7Ak1Texyci5P48D7/HzoVBUOW6VEhWy/x7yyf9ya4mg=
X-Received: by 2002:a2e:908b:0:b0:279:1349:b2e2 with SMTP id
 l11-20020a2e908b000000b002791349b2e2mr401513ljg.382.1671770630034; Thu, 22
 Dec 2022 20:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20221222185314.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <F492F726-00AA-4FC8-A5E5-BBF006CE946C@joelfernandes.org> <20221222194511.GS4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221222194511.GS4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 22 Dec 2022 23:43:38 -0500
Message-ID: <CAEXW_YScrnuSuWx69oJK+-+9Rdncn5kOSw0-SaWwwABix-Tb+A@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 2:45 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Thu, Dec 22, 2022 at 01:56:17PM -0500, Joel Fernandes wrote:
> >
> >
> > > On Dec 22, 2022, at 1:53 PM, Paul E. McKenney <paulmck@kernel.org> wr=
ote:
> > >
> > > =EF=BB=BFOn Thu, Dec 22, 2022 at 01:19:06PM -0500, Joel Fernandes wro=
te:
> > >>
> > >>
> > >>>> On Dec 22, 2022, at 11:43 AM, Paul E. McKenney <paulmck@kernel.org=
> wrote:
> > >>>
> > >>> =EF=BB=BFOn Thu, Dec 22, 2022 at 01:40:10PM +0100, Frederic Weisbec=
ker wrote:
> > >>>>> On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wrote=
:
> > >>>>> On 2022-12-21 06:59, Frederic Weisbecker wrote:
> > >>>>>>> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wro=
te:
> > >>>>> [...]
> > >>>>>>>
> > >>>>>>> The memory ordering constraint I am concerned about here is:
> > >>>>>>>
> > >>>>>>> * [...] In addition,
> > >>>>>>> * each CPU having an SRCU read-side critical section that exten=
ds beyond
> > >>>>>>> * the return from synchronize_srcu() is guaranteed to have exec=
uted a
> > >>>>>>> * full memory barrier after the beginning of synchronize_srcu()=
 and before
> > >>>>>>> * the beginning of that SRCU read-side critical section. [...]
> > >>>>>>>
> > >>>>>>> So if we have a SRCU read-side critical section that begins aft=
er the beginning
> > >>>>>>> of synchronize_srcu, but before its first memory barrier, it wo=
uld miss the
> > >>>>>>> guarantee that the full memory barrier is issued before the beg=
inning of that
> > >>>>>>> SRCU read-side critical section. IOW, that memory barrier needs=
 to be at the
> > >>>>>>> very beginning of the grace period.
> > >>>>>>
> > >>>>>> I'm confused, what's wrong with this ?
> > >>>>>>
> > >>>>>> UPDATER                  READER
> > >>>>>> -------                  ------
> > >>>>>> STORE X =3D 1              STORE srcu_read_lock++
> > >>>>>> // rcu_seq_snap()        smp_mb()
> > >>>>>> smp_mb()                 READ X
> > >>>>>> // scans
> > >>>>>> READ srcu_read_lock
> > >>>>>
> > >>>>> What you refer to here is only memory ordering of the store to X =
and load
> > >>>>> from X wrt loading/increment of srcu_read_lock, which is internal=
 to the
> > >>>>> srcu implementation. If we really want to model the provided high=
-level
> > >>>>> memory ordering guarantees, we should consider a scenario where S=
RCU is used
> > >>>>> for its memory ordering properties to synchronize other variables=
.
> > >>>>>
> > >>>>> I'm concerned about the following Dekker scenario, where synchron=
ize_srcu()
> > >>>>> and srcu_read_lock/unlock would be used instead of memory barrier=
s:
> > >>>>>
> > >>>>> Initial state: X =3D 0, Y =3D 0
> > >>>>>
> > >>>>> Thread A                   Thread B
> > >>>>> ---------------------------------------------
> > >>>>> STORE X =3D 1                STORE Y =3D 1
> > >>>>> synchronize_srcu()
> > >>>>>                          srcu_read_lock()
> > >>>>>                          r1 =3D LOAD X
> > >>>>>                          srcu_read_unlock()
> > >>>>> r0 =3D LOAD Y
> > >>>>>
> > >>>>> BUG_ON(!r0 && !r1)
> > >>>>>
> > >>>>> So in the synchronize_srcu implementation, there appears to be tw=
o
> > >>>>> major scenarios: either srcu_gp_start_if_needed starts a gp or ex=
pedited gp,
> > >>>>> or it uses an already started gp/expedited gp. When snapshotting =
with
> > >>>>> rcu_seq_snap, the fact that the memory barrier is after the ssp->=
srcu_gp_seq
> > >>>>> load means that it does not order prior memory accesses before th=
at load.
> > >>>>> This sequence value is then used to identify which gp_seq to wait=
 for when
> > >>>>> piggy-backing on another already-started gp. I worry about reorde=
ring
> > >>>>> between STORE X =3D 1 and load of ssp->srcu_gp_seq, which is then=
 used to
> > >>>>> piggy-back on an already-started gp.
> > >>>>>
> > >>>>> I suspect that the implicit barrier in srcu_read_lock() invoked a=
t the
> > >>>>> beginning of srcu_gp_start_if_needed() is really the barrier that=
 makes
> > >>>>> all this behave as expected. But without documentation it's rathe=
r hard to
> > >>>>> follow.
> > >>>>
> > >>>> Oh ok I see now. It might be working that way by accident or on fo=
rgotten
> > >>>> purpose. In any case, we really want to add a comment above that
> > >>>> __srcu_read_lock_nmisafe() call.
> > >>>
> > >>> Another test for the safety (or not) of removing either D or E is
> > >>> to move that WRITE_ONCE() to follow (or, respectively, precede) the
> > >>> adjacent scans.
> > >>
> > >> Good idea, though I believe the MBs that the above talk about are no=
t the flip ones. They are the ones in synchronize_srcu() beginning and end,=
 that order with respect to grace period start and end.
> > >>
> > >> So that (flipping MBs) is unrelated, or did I miss something?
> > >
> > > The thought is to manually similate in the source code the maximum
> > > memory-reference reordering that a maximally hostile compiler and CPU
> > > would be permitted to carry out.  So yes, given that there are other
> > > memory barriers before and after, these other memory barriers limit h=
ow
> > > far the flip may be moved in the source code.
> > >
> > > Here I am talking about the memory barriers associated with the flip,
> > > but the same trick can of course be applied to other memory barriers.
> > > In general, remove a given memory barrier and (in the source code)
> > > maximally rearrange the memory references that were previously ordere=
d
> > > by the memory barrier in question.
> > >
> > > Again, the presence of other memory barriers will limit the permitted
> > > maximal source-code rearrangement.
> >
> >
> > Makes sense if the memory barrier is explicit. In this case, the memory=
 barriers are implicit apparently, with a srcu_read_lock() in the beginning=
 of synchronize_rcu() having the implicit / indirect memory barrier. So I a=
m not sure if that can be implemented without breaking SRCU readers.
>
> First, are we talking about the same barrier?  I am talking about E.

No, in the last part you replied to above, Mathieu and Frederic were
talking about the need for memory barriers in synchronize_srcu(). That
has nothing to do with E:
<quote>
 I suspect that the implicit barrier in srcu_read_lock() invoked at the
 beginning of srcu_gp_start_if_needed() is really the barrier that makes
 all this behave as expected.
</quote>

We need to order code prior to synchronize_srcu() wrt the start of the
grace period, so that readers that started after the grace period
started see those side-effects as they may not be waited on (they are
too late).

> Alternatively, remove E and hammer it on a weakly ordered system.

But E is useless, see below patch link with litmus test [1]. I don't
see what hammering it on a weakly ordered system buys if it does not
even execute for the cases when it is supposed to help because of
causality with the control dependency of the prior scan :-/

Thanks,

  -Joel
[1] https://lore.kernel.org/rcu/19A03A16-9F38-481F-824D-4C883AB8B105@joelfe=
rnandes.org/T/#m60e37d1277a8dd626bb95f92083e4e602c429704
