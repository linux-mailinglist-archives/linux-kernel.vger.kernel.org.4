Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C081D6D0457
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjC3MIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjC3MH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:07:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B39EE;
        Thu, 30 Mar 2023 05:07:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c29so24234682lfv.3;
        Thu, 30 Mar 2023 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680178075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77eD/0U7tmrrsL2IlUVcRT11FKcg6G9q9nX1G3oybCo=;
        b=jf74v6WeT1J5moyEO4ieQz2P34TWsBXj4PJAzrM18RSoYlJr9s88IKaadQEmDj6cQY
         BSTxVUrdxM482WBjv0dRUTKfH+Qji2prHSVK9P7BPJTpNC9b9vi3Ya96LG6SY3zXFiQt
         ksgg3qrwwNvaXBPDsBTmJsZ5DhJTJV3+cZRM3rGdzEX7mQotDe2p1mFQUUbtZB01yVDB
         /C0CxbY+KH72hGijcBbQw9lISP49C0oBMXm3+zn5DhIscChDpKJ47rIg3m60nx41kgzI
         osGMPzI11fV4266M1/jLc4HkBvxQVcFjHo/ojvKgowLcHxox7NXh+CW6NYH8zNM/TRxI
         cBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680178075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77eD/0U7tmrrsL2IlUVcRT11FKcg6G9q9nX1G3oybCo=;
        b=nX/dVAwdpke7QA6EsjciP3aL08oq1SVxBVAUPnbKbIas8lJTU4XcEjQaxZWGyE46Hx
         f210Zdqgdu4BABoEUZcOPiswdEybQp21bq737vU5ImK0pOUgYse7B0jhjpAN+B939c/j
         axC/8J8a9Mo2/lb/qeP1gf5E0kw2K8AM/p79YmajYePwq+oZ6ti8snAbHgYmzoHpC6EX
         fE3JLhGZeyzUfrxVJOksnNU0hzD0KYTE4oJV3zV5IaIiR/JDDhbkvGrbaU/bmW+Gw6oB
         22cli+IoicRwoe2X/mvqqvsN3an60A0cJ8aKaSbG+d/l5UzxtKIFoDhXBvk36FCOK5BJ
         AI6g==
X-Gm-Message-State: AAQBX9f26GII2En3/1W5BGwDtfxqAgNjIbylqMa50hivxhIyyljON3/K
        6Qklyc4pBZbWEGxOH/otsms=
X-Google-Smtp-Source: AKy350Zdm7zYCUoS/r5J9sXI2LuB/gLLXubQf0M/9J5hfqbWBilZ3Qk4NgCUaTJwrSz2aMOu08Bf1Q==
X-Received: by 2002:ac2:4153:0:b0:4e8:5576:98f4 with SMTP id c19-20020ac24153000000b004e8557698f4mr6435002lfi.45.1680178075333;
        Thu, 30 Mar 2023 05:07:55 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id u13-20020ac2518d000000b004cb45148027sm5280821lfi.203.2023.03.30.05.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:07:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 30 Mar 2023 14:07:52 +0200
To:     =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>,
        =?utf-8?B?6L6b5L6d5YehIChZaWZhbiBYaW4p?= <Yifan.Xin@unisoc.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        =?utf-8?B?6Zer5a2m5paHIChYdWV3ZW4gWWFuKQ==?= 
        <Xuewen.Yan@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= 
        <Zhiguo.Niu@unisoc.com>,
        =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHJjdTog?=
 =?utf-8?Q?Make_sure_new_krc?= =?utf-8?Q?p?= free business is handled after
 the wanted rcu grace period.
Message-ID: <ZCV7mPHkSUeFXDPP@pc636>
References: <1680168440-20511-1-git-send-email-ziwei.dai@unisoc.com>
 <76db405712174b20a1caef47acd1cda7@BJMBX01.spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76db405712174b20a1caef47acd1cda7@BJMBX01.spreadtrum.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ziwei Dai!

> Hi Uladzislau and all,
> 
> Sorry for the disclaimer in the original mail.
> Please help comment in this new thread.
> 
> We found this issue at K5.15. We try to fix this issue on K5.15.
> It seems mainline also has this issue.
> 
> Below is the first debug patch on k5.15 device, which is under stress test, issue not reproduce so far.
> ============================================================
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 66951e130c2fc..44759641f7234 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3342,15 +3342,21 @@ static void kfree_rcu_monitor(struct work_struct *work)
>         // Attempt to start a new batch.
>         for (i = 0; i < KFREE_N_BATCHES; i++) {
>                 struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
> +               bool rcu_work_pending;
> 
>                 // Try to detach bkvhead or head and attach it over any
>                 // available corresponding free channel. It can be that
>                 // a previous RCU batch is in progress, it means that
>                 // immediately to queue another one is not possible so
>                 // in that case the monitor work is rearmed.
> -               if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> -                       (krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> -                               (krcp->head && !krwp->head_free)) {
> +               rcu_work_pending = test_bit(
> +                       WORK_STRUCT_PENDING_BIT,
> +                       work_data_bits(&krwp->rcu_work.work));
> +               // If there is on-going rcu work, continue.
> +               if (rcu_work_pending || krwp->bkvhead_free[0] ||
> +                       krwp->bkvhead_free[1] || krwp->head_free)
> +                       continue;
> +               if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head) {
>                         // Channel 1 corresponds to the SLAB-pointer bulk path.
>                         // Channel 2 corresponds to vmalloc-pointer bulk path.
>                         for (j = 0; j < FREE_N_CHANNELS; j++) {
> 
> As " rcu_work_pending" judgement seems redundant, I made the second patch below on k5.15. We will make stress test.
> ============================================================
> Below is the first debug patch on k5.15 device, which is under stress test, issue not reproduce so far.
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 66951e130c2fc..f219c60a8ec30 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3343,14 +3343,13 @@ static void kfree_rcu_monitor(struct work_struct *work)
>         for (i = 0; i < KFREE_N_BATCHES; i++) {
>                 struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
> 
> -               // Try to detach bkvhead or head and attach it over any
> -               // available corresponding free channel. It can be that
> -               // a previous RCU batch is in progress, it means that
> -               // immediately to queue another one is not possible so
> -               // in that case the monitor work is rearmed.
> -               if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> -                       (krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> -                               (krcp->head && !krwp->head_free)) {
> +               // Try to detach bulk_head or head and attach it, only when
> +               // all channels are free.  Any channel is not free means at krwp
> +               // there is on-going rcu work to handle krwp's free business.
> +               if (krwp->bkvhead_free[0] || krwp->bkvhead_free[1] ||
> +                       krwp->head_free)
> +                       continue;
> +               if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head) {
>                         // Channel 1 corresponds to the SLAB-pointer bulk path.
>                         // Channel 2 corresponds to vmalloc-pointer bulk path.
>                         for (j = 0; j < FREE_N_CHANNELS; j++) {
> 
> 
> > -----邮件原件-----
> > 发件人: 代子为 (Ziwei Dai) <Ziwei.Dai@unisoc.com>
> > 发送时间: 2023年3月30日 17:27
> > 收件人: paulmck@kernel.org; frederic@kernel.org;
> > quic_neeraju@quicinc.com; josh@joshtriplett.org; rostedt@goodmis.org;
> > mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com;
> > joel@joelfernandes.org; rcu@vger.kernel.org
> > 抄送: linux-kernel@vger.kernel.org; 王双 (Shuang Wang)
> > <shuang.wang@unisoc.com>; 辛依凡 (Yifan Xin) <Yifan.Xin@unisoc.com>;
> > 王科 (Ke Wang) <Ke.Wang@unisoc.com>; 闫学文 (Xuewen Yan)
> > <Xuewen.Yan@unisoc.com>; 牛志国 (Zhiguo Niu) <Zhiguo.Niu@unisoc.com>;
> > 代子为 (Ziwei Dai) <Ziwei.Dai@unisoc.com>; 黄朝阳 (Zhaoyang Huang)
> > <zhaoyang.huang@unisoc.com>
> > 主题: [PATCH] rcu: Make sure new krcp free business is handled after the
> > wanted rcu grace period.
> > 
> > From: 代子为 (Ziwei Dai) <ziwei.dai@ziwei-lenovo.spreadtrum.com>
> > 
> > In kfree_rcu_monitor(), new free business at krcp is attached to any free
> > channel at krwp. kfree_rcu_monitor() is responsible to make sure new free
> > business is handled after the rcu grace period. But if there is any none-free
> > channel at krwp already, that means there is an on-going rcu work, which will
> > cause the kvfree_call_rcu()-triggered free business is done before the wanted
> > rcu grace period ends.
> > 
> > This commit ignores krwp which has non-free channel at kfree_rcu_monitor(),
> > to fix the issue that kvfree_call_rcu() loses effectiveness.
> > 
> > Below is the css_set obj "from_cset" use-after-free issue caused by
> > kvfree_call_rcu() losing effectiveness.
> > Core 0 calls rcu_read_lock(), then use "from_cset", then hard irq comes.
> > Core 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new
> > gp.
> > Core 2 frees "from_cset" after current gp end. "from_cset" is reallocated.
> > Core 0 references "from_cset"'s member, which causes crash.
> > 
> > Core 0					Core 1				       	Core 2
> > count_memcg_event_mm()
> > |rcu_read_lock()  <---
> > |mem_cgroup_from_task()
> >  |// <css_set ptr> is the "from_cset" mentioned on core 1  |<css_set ptr> =
> > rcu_dereference((task)->cgroups)  |// Hard irq comes, current task is
> > scheduled out.
> > 
> > 			Core 1:
> > 			cgroup_attach_task()
> > 			|cgroup_migrate()
> > 			 |cgroup_migrate_execute()
> > 			  |css_set_move_task(task, from_cset, to_cset, true)
> > 			  |cgroup_move_task(task, to_cset)
> > 			   |rcu_assign_pointer(.., to_cset)
> > 			   |...
> > 			|cgroup_migrate_finish()
> > 			 |put_css_set_locked(from_cset)
> > 			  |from_cset->refcount return 0
> > 			  |kfree_rcu(cset, rcu_head) <--- means to free from_cset
> > after new gp
> > 			   |add_ptr_to_bulk_krc_lock()
> > 			   |schedule_delayed_work(&krcp->monitor_work, ..)
> > 
> > 			kfree_rcu_monitor()
> > 			|krcp->bulk_head[0]'s work attached to
> > krwp->bulk_head_free[]
> > 			|queue_rcu_work(system_wq, &krwp->rcu_work)
> > 			 |if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT
> > state,
> > 			 |call_rcu(&rwork->rcu, rcu_work_rcufn) <--- request a new gp
> > 
> > 								// There is a perious call_rcu(..,
> > rcu_work_rcufn)
> > 								// gp end, rcu_work_rcufn() is called.
> > 								rcu_work_rcufn()
> > 								|__queue_work(.., rwork->wq,
> > &rwork->work);
> > 								Core 2：
> > 								// or there is a pending
> > kfree_rcu_work() work called.
> > 								|kfree_rcu_work()
> > 								|krwp->bulk_head_free[0] bulk is
> > freed before new gp end!!!
> > 								|The "from_cset" mentioned on core
> > 1 is freed before new gp end.
> > Core 0:
> > // the task is schedule in after many ms.
> >  |<css_set ptr>->subsys[(subsys_id) <--- caused kernel crash, because
> > <css_set ptr>="from_cset" is freed.
> > 
> > Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> > 
> > :#	modified:   tree.c
> > ---
> >  kernel/rcu/tree.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 8e880c0..f6451a8
> > 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3107,15 +3107,16 @@ static void kfree_rcu_monitor(struct
> > work_struct *work)
> >  	for (i = 0; i < KFREE_N_BATCHES; i++) {
> >  		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
> > 
> > -		// Try to detach bulk_head or head and attach it over any
> > -		// available corresponding free channel. It can be that
> > -		// a previous RCU batch is in progress, it means that
> > -		// immediately to queue another one is not possible so
> > -		// in that case the monitor work is rearmed.
> > -		if ((!list_empty(&krcp->bulk_head[0]) &&
> > list_empty(&krwp->bulk_head_free[0])) ||
> > -			(!list_empty(&krcp->bulk_head[1]) &&
> > list_empty(&krwp->bulk_head_free[1])) ||
> > -				(READ_ONCE(krcp->head) && !krwp->head_free)) {
> > -
> > +		// Try to detach bulk_head or head and attach it, only when
> > +		// all channels are free.  Any channel is not free means at krwp
> > +		// there is on-going rcu work to handle krwp's free business.
> > +		if (!list_empty(&krwp->bulk_head_free[0]) ||
> > +			!list_empty(&krwp->bulk_head_free[1]) ||
> > +				krwp->head_free)
> > +			continue;
Can we replace it with a new helper, for example: 

+static bool
+can_krcw_offload(struct kfree_rcu_cpu_work *krwp)
+{
+       int i;
+
+       for (i = 0; i < FREE_N_CHANNELS; i++)
+               if (!list_empty(&krwp->bulk_head_free[i]))
+                       return false;
+
+       return (READ_ONCE(krwp->head_free) == NULL);
+}

and then

+               if (!can_krcw_offload(krwp))
                        continue;

>
> > +		if (!list_empty(&krcp->bulk_head[0]) ||
> > +			!list_empty(&krcp->bulk_head[1]) ||
> > +			READ_ONCE(krcp->head)) {
>
Can we replace it with the:

+               // kvfree_rcu_drain_ready() might handle this krcp, if so give up.
+               if (need_offload_krc(krcp)) {

?
because we have a helper that is need_offload_krcp() that does the same.

> >  			// Channel 1 corresponds to the SLAB-pointer bulk path.
> >  			// Channel 2 corresponds to vmalloc-pointer bulk path.
> >  			for (j = 0; j < FREE_N_CHANNELS; j++) {
> > --
> > 1.9.1
> 

Also we need to add Fixes tag, you say you are on 5.15 kernel. So
something was added there. I will try to double check.

And thank you for fixing it!!!

--
Uladzislau Rezki
