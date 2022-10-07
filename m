Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C471E5F782D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJGMqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJGMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:46:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92C0DED2E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 05:46:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s19so685563qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+/H21/fojiFZt1ynWhrdISCKwI50a6w9LtpOUymtG4=;
        b=rjb4KU1dXYiKXDtMogjfh2C5kIOMEN9BRNSBveoY8uIvZ4dEZaSCCq+fCcwzFQO5wf
         xR64v2KEN2HVaSNes2PzRLGlAn40VmeSh1ZmjG16K7B9/2YMrYqire9e1r8CXYzUKP8m
         BeCdz+zw1kgZoUE6ieQ2ajazBII8pL+CJ0AzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+/H21/fojiFZt1ynWhrdISCKwI50a6w9LtpOUymtG4=;
        b=tOzl6is11Pna2C193Bmart5Fiyaj9hVAD8KOr60UBkKNRlOwnf78tGXo/J2uCuYyAb
         NIGAbdkJGm4KLKapOc+w0b32kwQ1PY7O5oDX7du5kTpO2HhDEwtYQ1HX+yXwJSpQs3A3
         kc84OlG3Q6ET3FT3CBlREQWe4LN2EBw5lNvHtM0xWrKny5SCCe7DNwrUIWmKev10e1pv
         5Pmv0DLgbDAqJ8UER9y1kqnFCheRBrjwroH5xBAax89HvetG039WhVopydeBNBqtGz7I
         hauBjOYfRpgGxsvT8YJyqRsp2t4TXrtKJy+Zr6zFYnkx0DlG4Qs6y1BmxZNpYSSfQRKi
         laLA==
X-Gm-Message-State: ACrzQf1vhmdXdrEhIFLIYLsujkihXQdgrYOluxkC9mO68UL9xRbyrOFb
        36tR5rniRiZYZWfHmiziGN3dBg==
X-Google-Smtp-Source: AMsMyM6oBSrGKasH01Nloln3A1RmEGsPFZiTpFHZ2emN0HQlpIqlINFbLyrKuN/GWXxnbBhn0Ft8nQ==
X-Received: by 2002:a05:620a:2951:b0:6ce:c55e:102a with SMTP id n17-20020a05620a295100b006cec55e102amr3412296qkp.134.1665146775601;
        Fri, 07 Oct 2022 05:46:15 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a290e00b006cf19068261sm1987320qkp.116.2022.10.07.05.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:46:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 01/11] rcu: Wake up nocb gp thread on rcu_barrier_entrain()
Date:   Fri, 7 Oct 2022 08:46:14 -0400
Message-Id: <21ECDA9F-81B1-4D22-8B03-020FB5DADA4F@joelfernandes.org>
References: <20221007112628.GA871854@lothringen>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
In-Reply-To: <20221007112628.GA871854@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 7, 2022, at 7:26 AM, Frederic Weisbecker <frederic@kernel.org> wrot=
e:
>=20
> =EF=BB=BFOn Fri, Oct 07, 2022 at 02:47:52AM +0000, Joel Fernandes wrote:
>> On Tue, Oct 04, 2022 at 06:57:59PM -0400, Joel Fernandes wrote:
>>=20
>> From: Frederic Weisbecker <frederic@kernel.org>
>> Subject: [PATCH] rcu: Wake up nocb gp thread on rcu_barrier_entrain()
>>=20
>> In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
>> needed after an entrain. Otherwise, the RCU barrier callback can wait in
>> the queue for several seconds before the lazy callbacks in front of it
>> are serviced.
>>=20
>> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>> kernel/rcu/tree.c      | 11 +++++++++++
>> kernel/rcu/tree.h      |  1 +
>> kernel/rcu/tree_nocb.h |  4 ++++
>> 3 files changed, 16 insertions(+)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 5ec97e3f7468..04f33191e5ed 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rd=
p)
>> {
>>    unsigned long gseq =3D READ_ONCE(rcu_state.barrier_sequence);
>>    unsigned long lseq =3D READ_ONCE(rdp->barrier_seq_snap);
>> +    bool wake_nocb =3D false;
>> +    bool was_done =3D false;
>>=20
>>    lockdep_assert_held(&rcu_state.barrier_lock);
>>    if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) !=
=3D rcu_seq_ctr(gseq))
>> @@ -3902,6 +3904,7 @@ static void rcu_barrier_entrain(struct rcu_data *rd=
p)
>>    rdp->barrier_head.func =3D rcu_barrier_callback;
>>    debug_rcu_head_queue(&rdp->barrier_head);
>>    rcu_nocb_lock(rdp);
>> +    was_done =3D rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&r=
dp->cblist);
>>    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>>    if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>>        atomic_inc(&rcu_state.barrier_cpu_count);
>> @@ -3909,7 +3912,15 @@ static void rcu_barrier_entrain(struct rcu_data *r=
dp)
>>        debug_rcu_head_unqueue(&rdp->barrier_head);
>>        rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>>    }
>> +
>> +    /*
>> +     * If bypass list was non-empty, wake up the nocb GP thread otherwis=
e
>> +     * bypass/lazy CBs may not be noticed, and can cause real long delay=
s!
>> +     */
>> +    wake_nocb =3D was_done && rcu_segcblist_pend_cbs(&rdp->cblist);
>>    rcu_nocb_unlock(rdp);
>> +    if (wake_nocb)
>> +        wake_nocb_gp(rdp, false);
>>    smp_store_release(&rdp->barrier_seq_snap, gseq);
>> }
>>=20
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index d4a97e40ea9c..41faaf8eb872 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -443,6 +443,7 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rd=
p, struct rcu_head *rhp,
>>                  unsigned long j);
>> static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rh=
p,
>>                bool *was_alldone, unsigned long flags);
>> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>> static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
>>                 unsigned long flags);
>> static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level)=
;
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index f77a6d7e1356..6caade0683dd 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -1558,6 +1558,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp=
)
>> {
>> }
>>=20
>> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>> +{
>=20
> It misses a return value...

Ah, true. I had the return in my tree but not in the posting, sigh.

>> +}
>=20
> So I planned to post an updated version (please find below) but I triggere=
d
> a rare TREE01 stall related to rcu_barrier(). I just can't remember if it w=
as
> before or after the patch :-s

Weird.

Thanks,

- Joel




> Anyway I'm holding it off until I get more clues.
>=20
> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Tue, 4 Oct 2022 02:41:47 +0000
> Subject: [PATCH] rcu: Fix missing nocb gp wake on rcu_barrier()
>=20
> Upon entraining a callback to a NOCB CPU, no further wake up is
> performed on the corresponding nocb_gp kthread. As a result, the callback
> and all the subsequent ones on that CPU may be ignored, at least until
> an RCU_NOCB_WAKE_FORCE timer is ever armed.
>=20
> Here is a possible bad scenario:
>=20
> 1) CPU 0 is NOCB unlike all other CPUs.
> 2) CPU 0 queues a callback
> 2) The grace period related to that callback elapses
> 3) The callback is moved to the done list (but is not invoked yet),
>   there are no more pending callbacks for CPU 0
> 4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
> 5) CPU 0 entrains the callback but doesn't wake up nocb_gp
> 6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
>   callbacks to arm an RCU_NOCB_WAKE_FORCE timer.
>=20
> Make sure the necessary wake up is issued if necessary.
>=20
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
> kernel/rcu/tree.c      | 6 ++++++
> kernel/rcu/tree.h      | 1 +
> kernel/rcu/tree_nocb.h | 5 +++++
> 3 files changed, 12 insertions(+)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96d678c9cfb6..025f59f6f97f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3914,6 +3914,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp=
)
> {
>    unsigned long gseq =3D READ_ONCE(rcu_state.barrier_sequence);
>    unsigned long lseq =3D READ_ONCE(rdp->barrier_seq_snap);
> +    bool wake_nocb =3D false;
> +    bool was_alldone =3D false;
>=20
>    lockdep_assert_held(&rcu_state.barrier_lock);
>    if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) !=3D=
 rcu_seq_ctr(gseq))
> @@ -3922,6 +3924,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp=
)
>    rdp->barrier_head.func =3D rcu_barrier_callback;
>    debug_rcu_head_queue(&rdp->barrier_head);
>    rcu_nocb_lock(rdp);
> +    was_alldone =3D rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(=
&rdp->cblist);
>    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>    if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>        atomic_inc(&rcu_state.barrier_cpu_count);
> @@ -3929,7 +3932,10 @@ static void rcu_barrier_entrain(struct rcu_data *rd=
p)
>        debug_rcu_head_unqueue(&rdp->barrier_head);
>        rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>    }
> +    wake_nocb =3D was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
>    rcu_nocb_unlock(rdp);
> +    if (wake_nocb)
> +        wake_nocb_gp(rdp, false);
>    smp_store_release(&rdp->barrier_seq_snap, gseq);
> }
>=20
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c..925dd98f8b23 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp)=
;
> static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
> static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
> static void rcu_init_one_nocb(struct rcu_node *rnp);
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
> static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *r=
hp,
>                  unsigned long j);
> static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp=
,
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f77a6d7e1356..094fd454b6c3 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)=

> {
> }
>=20
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> +{
> +    return false;
> +}
> +
> static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *r=
hp,
>                  unsigned long j)
> {
> --=20
> 2.25.1
>=20
>=20
>=20
