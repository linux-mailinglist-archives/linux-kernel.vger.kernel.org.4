Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D666B79B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCMN7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCMN7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:59:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5D1EFF3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:58:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso11761798pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678715925;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eneYNU+nUmxOh8t+MF9m5KBckGw7QMn0ZWgboiFr43c=;
        b=DduqQKirrtiP/8odRJmxLlH6WM1LkBuiNjuvGz9FSUN7fLw5HAUD6uc19foxRVmbLY
         o3FZGAlklijqnbA28sMX92rD569rN4q4eQGx2Gwpp3ylwQaViVJxU7gs5Dq0nAF5aMuY
         49mLcRlR8U5YHkI08IbJcgaxh/a727XUpVJAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715925;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eneYNU+nUmxOh8t+MF9m5KBckGw7QMn0ZWgboiFr43c=;
        b=jXzJh0i5Chy1Ee0XDz+7HpySatFuzNzZpyM5rbeBHOysQ8AWOIwLAxfT6KfO7lcYBa
         qYiDIGgsVI/VDWO9veto9Kr5yI22D7cjusmKuAEb/D5PW1LsNySejO80O/wYKyOlL+sD
         WeRGUk5G/+HbcmVGKfyVoGJ2EzguEwMilLUjqM1WM/M6JYUqCJrz99q+LbxmMZiauWyj
         G6EEHk86Z5KQ5WyreGb1aKzqMVanPT0x4C9r6fI4FAAXX0OoBsUOdACJs5fHnFpjo7yS
         /tzepC07Bc5bcd2LEcUsiTetRBU4ntoVu+t/S9Cho2PApo0mHU/IaYNfZO34oquiUQTX
         mWOw==
X-Gm-Message-State: AO0yUKUQ88WVeNtHpvJeAQORYZkDm9duanoqYQZ9dyZjucnNv+2q13ld
        vMbQxF+ORbGEzrSiK7D+eY1E0bGlxfcuC3IUbHM=
X-Google-Smtp-Source: AK7set8GqexXi9aOzjtjlYy/A2z6Eb7VJELOikOO1SEArvaYtW2BESXlMuKLO1EX78+C4TFAKMv8aw==
X-Received: by 2002:a17:902:8688:b0:19c:d23e:52a0 with SMTP id g8-20020a170902868800b0019cd23e52a0mr28355194plo.14.1678715925149;
        Mon, 13 Mar 2023 06:58:45 -0700 (PDT)
Received: from smtpclient.apple (071-095-008-132.biz.spectrum.com. [71.95.8.132])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709026b4100b0019a96d3b456sm4864641plt.44.2023.03.13.06.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:58:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Date:   Mon, 13 Mar 2023 06:58:30 -0700
Message-Id: <01559085-EB77-4962-B5EF-FF767F5A7353@joelfernandes.org>
References: <ZA7yK6iznHqiBu5i@pc636>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
In-Reply-To: <ZA7yK6iznHqiBu5i@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 13, 2023, at 2:51 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Fri, Mar 10, 2023 at 10:24:34PM -0800, Paul E. McKenney wrote:=

>>> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
>>> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
>>>> On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
>>>> [..]
>>>>>>>>>> See this commit:
>>>>>>>>>>=20
>>>>>>>>>> 3705b88db0d7cc ("rcu: Add a module parameter to force use of
>>>>>>>>>> expedited RCU primitives")
>>>>>>>>>>=20
>>>>>>>>>> Antti provided this commit precisely in order to allow Android
>>>>>>>>>> devices to expedite the boot process and to shut off the
>>>>>>>>>> expediting at a time of Android userspace's choosing.  So Android=

>>>>>>>>>> has been making this work for about ten years, which strikes me
>>>>>>>>>> as an adequate proof of concept.  ;-)
>>>>>>>>>=20
>>>>>>>>> Thanks for the pointer. That's true. Looking at Android sources, I=

>>>>>>>>> find that Android Mediatek devices at least are setting
>>>>>>>>> rcu_expedited to 1 at late stage of their userspace boot (which is=

>>>>>>>>> weird, it should be set to 1 as early as possible), and
>>>>>>>>> interestingly I cannot find them resetting it back to 0!.  Maybe
>>>>>>>>> they set rcu_normal to 1? But I cannot find that either. Vlad? :P
>>>>>>>>=20
>>>>>>>> Interesting.  Though this is consistent with Antti's commit log,
>>>>>>>> where he talks about expediting grace periods but not unexpediting
>>>>>>>> them.
>>>>>>>>=20
>>>>>>> Do you think we need to unexpedite it? :))))
>>>>>>=20
>>>>>> Android runs on smallish systems, so quite possibly not!
>>>>>>=20
>>>>> We keep it enabled and never unexpedite it. The reason is a performanc=
e.  I
>>>>> have done some app-launch time analysis with enabling and disabling of=
 it.
>>>>>=20
>>>>> An expedited case is much better when it comes to app launch time. It
>>>>> requires ~25% less time to run an app comparing with unexpedited varia=
nt.
>>>>> So we have a big gain here.
>>>>=20
>>>> Wow, that's huge. I wonder if you can dig deeper and find out why that i=
s so
>>>> as the callbacks may need to be synchronize_rcu_expedited() then, as it=
 could
>>>> be slowing down other usecases! I find it hard to believe, real-time
>>>> workloads will run better without those callbacks being always-expedite=
d if
>>>> it actually gives back 25% in performance!
>>>>=20
>>> I can dig further, but on a high level i think there are some spots
>>> which show better performance if expedited is set. I mean synchronize_rc=
u()
>>> becomes as "less blocking a context" from a time point of view.
>>>=20
>>> The problem of a regular synchronize_rcu() is - it can trigger a big lat=
ency
>>> delays for a caller. For example for nocb case we do not know where in a=
 list
>>> our callback is located and when it is invoked to unblock a caller.
>>=20
>> True, expedited RCU grace periods do not have this callback-invocation
>> delay that normal RCU does.
>>=20
>>> I have already mentioned somewhere. Probably it makes sense to directly w=
ake-up
>>> callers from the GP kthread instead and not via nocb-kthread that invoke=
s our callbacks
>>> one by one.
>>=20
>> Makes sense, but it is necessary to be careful.  Wakeups are not fast,
>> so making the RCU grace-period kthread do them all sequentially is not
>> a strategy to win.  For example, note that the next expedited grace
>> period can start before the previous expedited grace period has finished
>> its wakeups.
>>=20
> I hove done a small and quick prototype:
>=20
> <snip>
> diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h=

> index 699b938358bf..e1a4cca9a208 100644
> --- a/include/linux/rcupdate_wait.h
> +++ b/include/linux/rcupdate_wait.h
> @@ -9,6 +9,8 @@
> #include <linux/rcupdate.h>
> #include <linux/completion.h>
>=20
> +extern struct llist_head gp_wait_llist;
> +
> /*
>  * Structure allowing asynchronous waiting on RCU.
>  */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ee27a03d7576..50b81ca54104 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly =3D RCU_NUM_LVLS;
> int num_rcu_lvl[] =3D NUM_RCU_LVL_INIT;
> int rcu_num_nodes __read_mostly =3D NUM_RCU_NODES; /* Total # rcu_nodes in=
 use. */
>=20
> +/* Waiters for a GP kthread. */
> +LLIST_HEAD(gp_wait_llist);
> +
> /*
>  * The rcu_scheduler_active variable is initialized to the value
>  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just before t=
he
> @@ -1776,6 +1779,14 @@ static noinline void rcu_gp_cleanup(void)
>                on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> }
>=20
> +static void rcu_notify_gp_end(struct llist_node *llist)
> +{
> +       struct llist_node *rcu, *next;
> +
> +       llist_for_each_safe(rcu, next, llist)
> +               complete(&((struct rcu_synchronize *) rcu)->completion);

This looks broken to me, so the synchronize will complete even
if it was called in the middle of an ongoing GP?

Thanks,

 - Joel



> +}
> +
> /*
>  * Body of kthread that handles grace periods.
>  */
> @@ -1811,6 +1822,9 @@ static int __noreturn rcu_gp_kthread(void *unused)
>                WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
>                rcu_gp_cleanup();
>                WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
> +
> +               /* Wake-app all users. */
> +               rcu_notify_gp_end(llist_del_all(&gp_wait_llist));
>        }
> }
>=20
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 19bf6fa3ee6a..1de7c328a3e5 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -426,7 +426,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_fu=
nc_t *crcu_array,
>                if (j =3D=3D i) {
>                        init_rcu_head_on_stack(&rs_array[i].head);
>                        init_completion(&rs_array[i].completion);
> -                       (crcu_array[i])(&rs_array[i].head, wakeme_after_rc=
u);
> +
> +                       /* Kick a grace period if needed. */
> +                       (void) start_poll_synchronize_rcu();
> +                       llist_add((struct llist_node *) &rs_array[i].head,=
 &gp_wait_llist);
>                }
>        }
> <snip>
>=20
> and did some experiments in terms of performance and comparison. A test ca=
se is:
>=20
> thread_X:
>  synchronize_rcu();
>  kfree(ptr);
>=20
> below are results with running 10 parallel workers running 1000 times of m=
entioned
> test scenario:
>=20
> # default(NOCB)
> [   29.322944] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 172=
86604 usec
> [   29.325759] All test took worker0=3D63964052068 cycles
> [   29.327255] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 234=
14575 usec
> [   29.329974] All test took worker1=3D86638822563 cycles
> [   29.331460] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 233=
57988 usec
> [   29.334205] All test took worker2=3D86429439193 cycles
> [   29.350808] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 171=
74001 usec
> [   29.353553] All test took worker3=3D63547397954 cycles
> [   29.355039] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 171=
41904 usec
> [   29.357770] All test took worker4=3D63428630877 cycles
> [   29.374831] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 233=
97952 usec
> [   29.377577] All test took worker5=3D86577316353 cycles
> [   29.398809] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 171=
42038 usec
> [   29.401549] All test took worker6=3D63429124938 cycles
> [   29.414828] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 171=
58248 usec
> [   29.417574] All test took worker7=3D63489107118 cycles
> [   29.438811] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 181=
02109 usec
> [   29.441550] All test took worker8=3D66981588881 cycles
> [   29.462826] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 234=
46042 usec
> [   29.465561] All test took worker9=3D86755258455 cycles
>=20
> # patch(NOCB)
> [   14.720986] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7883 usec
> [   14.723753] All test took worker0=3D32702015768 cycles
> [   14.740386] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7750 usec
> [   14.743076] All test took worker1=3D32701525814 cycles
> [   14.760350] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7734 usec
> [   14.763036] All test took worker2=3D32701466281 cycles
> [   14.780369] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7707 usec
> [   14.783057] All test took worker3=3D32701364901 cycles
> [   14.800352] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7730 usec
> [   14.803041] All test took worker4=3D32701449927 cycles
> [   14.820355] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7724 usec
> [   14.823048] All test took worker5=3D32701428134 cycles
> [   14.840359] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7705 usec
> [   14.843052] All test took worker6=3D32701356465 cycles
> [   14.860322] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7742 usec
> [   14.863005] All test took worker7=3D32701494475 cycles
> [   14.880363] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7750 usec
> [   14.883081] All test took worker8=3D32701525074 cycles
> [   14.900362] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 883=
7918 usec
> [   14.903065] All test took worker9=3D32702145379 cycles
>=20
> --
> Uladzislau Rezki
