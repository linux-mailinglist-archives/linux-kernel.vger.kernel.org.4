Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB816C6ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjCWR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjCWR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:29:56 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F7D9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:29:55 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17ebba88c60so1742262fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679592594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/Cvh6M1r+8t9YmN0xsnFRU8Cu+NaJyAtAc6yU9dLYU=;
        b=ITEGXpfXQYlwF1ZlUJqNVbyn5oz3Unj5kCXCIUKV9FtlDKgj/MKt8yqd4wGFjuDGE6
         umYSxCBhrSaovhC+Q1KH84l8P4DpDmlKG1poNllSF8PUyChV2Iq77B+U8xCMOfRRMfRD
         uypL2yUxgPh/cL0NT5BoKqju6JFL8+pJJywJdsxVsTLZxn/kdrxwyTbnbZudK4+2ZLoh
         mwroSbbB5HAZRdHAJ3Vm/sZ9JSRnGJIhHRwpYkVSMURH5BccLWrCpjCsejlDESDALnFS
         sEKW6QM4gClq1vLuZF/+eRH9oJDhjlIm5TJQUrBrsy3Qg2hTNNjYpOB1g3WFjoejNJCh
         8tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/Cvh6M1r+8t9YmN0xsnFRU8Cu+NaJyAtAc6yU9dLYU=;
        b=cUrPOCjQQpzMzeyuaStHWkCJAm2xcAA7zhTWMdMdJbqFHsXQ4TFAFnF+HYzwiFZLEs
         NOjE8AsyKAFZFRhlxJYwnY+JdktxUoIa3mCcaQX2/Io2k0t/ds0BBNaOePTG1LeF1TPw
         CoxRaIcOigLJ/gjl6/9RuPcUkI1JDLKtPXtSdVUrO4t4PfuM/bsC8tvo5EcgRnXek4FF
         ei9GBmgSvD99jM2pWN4DnEXtOWbUOBvOIWaQu/oKvDAJd7qOYWIGXtcHqT7jyffixfF1
         C9CgsVkJqFJBY1rTK4YM99ZijF2MuQkvqVUnUzd02X29BKV+vmI4ecRxygAVKz3006cx
         iAlQ==
X-Gm-Message-State: AAQBX9d1TVvePq1Sqlfazgmg4/F5hIeUw1grH/f/FVIvshNlTynT+h0X
        Zb+z2uulYmxNStauoCvNhb/NPB3nbEt/GYhuimkVgA==
X-Google-Smtp-Source: AKy350Zy/cokVvM0uGfHQy9c8KeBEWsqK7Ev8r8j7/PJ+j9WCYex3Jlo91uy/qg8+X8wpllAbT1829ggwBNmNoxIMIA=
X-Received: by 2002:a05:6871:8e9c:b0:177:b393:4009 with SMTP id
 zq28-20020a0568718e9c00b00177b3934009mr50638oab.4.1679592594300; Thu, 23 Mar
 2023 10:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230308100414.37114-1-jiahao.os@bytedance.com>
 <4972a8be-d300-a66e-7fac-a83f11b56fbf@bytedance.com> <CAEXW_YRG0Bw4U1+zOPpjRPQEeKNDMrs7x-ZE-W00aifn7heG4g@mail.gmail.com>
 <CA+HDTgT0sjt38E4-2uQs_2t1GSsYFDqz3porOx-WQbt8x9hhXw@mail.gmail.com> <0e569d64-ce35-2176-5d41-faa6997480ef@bytedance.com>
In-Reply-To: <0e569d64-ce35-2176-5d41-faa6997480ef@bytedance.com>
From:   Vineeth Pillai <vineethrp@google.com>
Date:   Thu, 23 Mar 2023 13:29:43 -0400
Message-ID: <CA+HDTgSg+LTCTGu2_TeJwahNk3fO50Zj1DMuJmBTxPGe1RRQgA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] sched/core: Minor optimize
 pick_next_task() when core-sched enable
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, mingo@redhat.com,
        peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 3:03=E2=80=AFAM Hao Jia <jiahao.os@bytedance.com> w=
rote:

> > The other issue was - we don't update core rbtree when vruntime changes=
 and
> > this can cause starvation of cookied task if there are more than one ta=
sk with
> > the same cookie on an rq.
> >
>
> If I understand correctly, when a cookied task is enqueued, the
> difference delta1 between its vruntime and min_vruntime is very large.
>
> Another task with the same cookie is very actively dequeuing and
> enqueuing, and the difference delta2 between its vruntime and
> min_vruntime is always smaller than delta1?
> I'm not sure if this is the case?

This case I was mentioning is about tasks that are continuously running
and hence always in the runqueue. sched_core_enqueue/dequeue is
not called and hence their position in the core rbtree is static while cfs
rbtree positions change as vruntime progresses.

BTW, this is a separate issue than the one you are targeting with this
fix. I just thought of mentioning it here as well..

> >> Yeah, this is an absolute no-no, it makes the overhead of the second r=
b
> >> tree unconditional.
> >
> > I agree. Could we keep it conditional by enqueuing 0-cookied tasks only=
 when
> > coresched is enabled, just like what we do for cookied tasks? This is s=
till an
> > overhead where we have two trees storing all the runnable tasks but in
> > different order. We would also need to populate core rbtree from cfs rb=
tree
> > on coresched enable and empty the tree on coresched disable.
> >
>
> I'm not sure if the other way is reasonable, I'm trying to provide a
> function for each scheduling class to find a highest priority non-cookie
> task.
>
> For example fair_sched_class, we can use rq->cfs_tasks to traverse the
> search. But this search may take a long time, maybe we need to limit the
> number of searches.

Yes, it can be time consuming based on the number of cgroups and tasks
that are runnable. You could probably take some performance numbers to
see how worse it is.

We could also have some optimization like marking a runqueue having
non-cookied tasks and then do the search only if it is marked. I haven't
thought much about it, but search could be optimized hopefully.

Thanks,
Vineeth
