Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0845FAD90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJKHdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJKHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:33:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDAE895F2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:33:39 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a5so2970134qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erh3u1DJISbHThgy03uL8WLaTCJNrKHHYJpWRqThcUo=;
        b=M5fYR8O4Qr/QRtEnMRht0DPNbiBhYDyQB2tQNS5m5SZ1AXH63f//jHTqiDOH7kAdRa
         WsU8j90MZGPd3PcxzXrsC/oJQpCVWrnInB/38EMu2tQCeeHvs8UlQ+KWgnFc4U+5F2Z8
         4osWC9CeDmfLD1J5wHyNvhjjmfXwWr62zrmPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erh3u1DJISbHThgy03uL8WLaTCJNrKHHYJpWRqThcUo=;
        b=BO+0KBEFkFEb2EiINMBFtD0j2PnMRogBw8oz2TFIGDbTYrYeG13Lc4lsfY+jWo2uc8
         F8dHuDmJ8B4/U1KiZNRVN/enqjSzhnxRSXOK+AN7SMhf3G+gOmVmuzvUpNkT3E3Flci2
         iNXGqiuSNFh9CTgZtCmLMpItnoZ5BjVj1MfJ5NF8hYMBY2F+oL1MRTDLIpW5JZ3SntT6
         WdPFSVjTlMBlLalv4Clvmq0TtuiOy8JfBP1OIu6IfThr0Ao3mN12LZqJDPp6GxR7/6/i
         XGMO+/FbFoZitgqfDSxfgM6KzeUI1B6EfahE5R8BLj/s99YvaYbyQsV6cIrQPs2an/7e
         z7qg==
X-Gm-Message-State: ACrzQf0nJgyjxb3OUjL1kMVXT8kOSPvjAGajdkW/wgx/jFMHuKea75Hp
        Ql+kJo8VG02u22c6+BdJiMQoSt4FLFeLGQ==
X-Google-Smtp-Source: AMsMyM6QwP+8ifGWb/6yVoty4btHjpReWMfdt6vD7H23S3oC4jCC95gfD6Rii7WDUWVmFw481ZXh8g==
X-Received: by 2002:a05:620a:1aa9:b0:6e7:2d75:1d00 with SMTP id bl41-20020a05620a1aa900b006e72d751d00mr15592372qkb.575.1665473618594;
        Tue, 11 Oct 2022 00:33:38 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id u1-20020a05620a0c4100b006cfc4744589sm12616106qki.128.2022.10.11.00.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 00:33:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] rcu: Fix missing nocb gp wake on rcu_barrier()
Date:   Tue, 11 Oct 2022 03:33:37 -0400
Message-Id: <73CCC477-83F0-45BD-B484-973F94C71C7F@joelfernandes.org>
References: <20221011072517.GB4221@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20221011072517.GB4221@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 11, 2022, at 3:25 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Oct 11, 2022 at 02:01:23AM +0000, Joel Fernandes wrote:
>>> On Tue, Oct 11, 2022 at 12:39:55AM +0200, Frederic Weisbecker wrote:
>>> Upon entraining a callback to a NOCB CPU, no further wake up is
>>> issued on the corresponding nocb_gp kthread. As a result, the callback
>>> and all the subsequent ones on that CPU may be ignored, at least until
>>> an RCU_NOCB_WAKE_FORCE timer is ever armed or another NOCB CPU belonging=

>>> to the same group enqueues a callback on an empty queue.
>>>=20
>>> Here is a possible bad scenario:
>>>=20
>>> 1) CPU 0 is NOCB unlike all other CPUs.
>>> 2) CPU 0 queues a callback
>>> 2) The grace period related to that callback elapses
>>> 3) The callback is moved to the done list (but is not invoked yet),
>>>   there are no more pending callbacks for CPU 0
>>> 4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
>>> 5) CPU 0 entrains the callback but doesn't wake up nocb_gp
>>> 6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
>>>   callbacks to arm an RCU_NOCB_WAKE_FORCE timer.
>>>=20
>>> Make sure the necessary wake up is produced whenever necessary.
>>>=20
>>> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>> Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>=20
>> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>=20
>> And if Paul is taking this, I'll rebase and drop this patch from the lazy=

>> series.
>=20
> Joel, could you please incorporate this into your series?  My internet
> access is likely to be a bit iffy over the next few days.  Likely no
> problem for email and the occasional test-systme access, but best not
> to take it for granted.  ;-)

Sure, I=E2=80=99ll do that. Thanks.

Fingers crossed on the internet ;-)

Thanks,

 - Joel


>=20
>                            Thanx, Paul
>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>=20
>>> ---
>>> kernel/rcu/tree.c      | 6 ++++++
>>> kernel/rcu/tree.h      | 1 +
>>> kernel/rcu/tree_nocb.h | 5 +++++
>>> 3 files changed, 12 insertions(+)
>>>=20
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 96d678c9cfb6..025f59f6f97f 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -3914,6 +3914,8 @@ static void rcu_barrier_entrain(struct rcu_data *r=
dp)
>>> {
>>>    unsigned long gseq =3D READ_ONCE(rcu_state.barrier_sequence);
>>>    unsigned long lseq =3D READ_ONCE(rdp->barrier_seq_snap);
>>> +    bool wake_nocb =3D false;
>>> +    bool was_alldone =3D false;
>>>=20
>>>    lockdep_assert_held(&rcu_state.barrier_lock);
>>>    if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) !=
=3D rcu_seq_ctr(gseq))
>>> @@ -3922,6 +3924,7 @@ static void rcu_barrier_entrain(struct rcu_data *r=
dp)
>>>    rdp->barrier_head.func =3D rcu_barrier_callback;
>>>    debug_rcu_head_queue(&rdp->barrier_head);
>>>    rcu_nocb_lock(rdp);
>>> +    was_alldone =3D rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cb=
s(&rdp->cblist);
>>>    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>>>    if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>>>        atomic_inc(&rcu_state.barrier_cpu_count);
>>> @@ -3929,7 +3932,10 @@ static void rcu_barrier_entrain(struct rcu_data *=
rdp)
>>>        debug_rcu_head_unqueue(&rdp->barrier_head);
>>>        rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>>>    }
>>> +    wake_nocb =3D was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
>>>    rcu_nocb_unlock(rdp);
>>> +    if (wake_nocb)
>>> +        wake_nocb_gp(rdp, false);
>>>    smp_store_release(&rdp->barrier_seq_snap, gseq);
>>> }
>>>=20
>>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>>> index d4a97e40ea9c..925dd98f8b23 100644
>>> --- a/kernel/rcu/tree.h
>>> +++ b/kernel/rcu/tree.h
>>> @@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rd=
p);
>>> static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>>> static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>>> static void rcu_init_one_nocb(struct rcu_node *rnp);
>>> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>>> static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *=
rhp,
>>>                  unsigned long j);
>>> static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *r=
hp,
>>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>>> index f77a6d7e1356..094fd454b6c3 100644
>>> --- a/kernel/rcu/tree_nocb.h
>>> +++ b/kernel/rcu/tree_nocb.h
>>> @@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rn=
p)
>>> {
>>> }
>>>=20
>>> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>>> +{
>>> +    return false;
>>> +}
>>> +
>>> static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *=
rhp,
>>>                  unsigned long j)
>>> {
>>> --=20
>>> 2.25.1
>>>=20
