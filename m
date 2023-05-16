Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3011704F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjEPNge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjEPNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:36:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEDB10DA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:36:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6436e004954so14602121b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684244190; x=1686836190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvxDOpYiF//cGspBa+1fpizQ2RWLkcOlF3ipks0JxBE=;
        b=W98DLUpwdS5IxGcULjG5nEyDeZv/RGvqltDgQc0RwC6c/at30wBtwyZXUHfYnKgxCH
         VS28lvasgBot1TUiBGyRiCEMiVamDkqHShfrUBb39UyOAZnJrOAgtrItVqLKiHpUH+cc
         cHrNRZNhtc4PW1NYGqI9WarnVq/e2FtcEZ05FNsqZWiB7UbPgvEopasJQWTrDQnIXiHF
         9koMjT05CRrxn4B+Mp0QQSXpPpK11A/Eo3e61trfBI+akB/VfsDsIfVbo1oAot/eVkGh
         nDmPS2ttR3tl2ICFkah15+J2vTXIBlG2sQsPLyC98BMxdttAgHBIFB/G96XH2FA6O8Qh
         3T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244190; x=1686836190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvxDOpYiF//cGspBa+1fpizQ2RWLkcOlF3ipks0JxBE=;
        b=U9lFhQuNmAK3DIqaeddiqjoWZfSI/fFAsA9JP4plSsnL4f96haFjtR4SsW57IVJIcx
         Pn2mRXvugVSPESv9fxe3SS3NW2cvAOmFHp2JYYnSMj/PeAPJCpUmEDargL/Us7bR3xd+
         6ohv0ugK2Uv2o+eu087xEeLszQULxihsaDE00hK9Ns8VFGqB3ZzUShBhBl1IZM2hrKUs
         dBVM6LLEBerM03iOMsnAKrxmk7dFm+E9VOZ17r0Az6HbLJo0jhyO96cb3HOX2yF3SOYJ
         QGfspWkSsOT3cxocJ065+6ox1lITaOsy5R5Dni40r7wPHNfyf1g+d1XviaiK8NUM8LGY
         Jlqg==
X-Gm-Message-State: AC+VfDx6FQtQPPx4rzHkfV6VjY0zb1utoVp0o2ZQliya+6SDamwEbS4i
        xRGaoFIVcE+9Oom8aqe9f4d+uEVE2CGrRcoCKp8jYw==
X-Google-Smtp-Source: ACHHUZ67OYhVQWqvwY/fYSo+nezhJ7nTGNONH6O7pFXRR1/UWQsoJ4KMAfOHHsbMUzKGEBBBaeN9eQty8JBl5SfDJmE=
X-Received: by 2002:a05:6a20:7f9d:b0:105:66a1:5d05 with SMTP id
 d29-20020a056a207f9d00b0010566a15d05mr13248261pzj.55.1684244190493; Tue, 16
 May 2023 06:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230515114601.12737-1-huschle@linux.ibm.com> <20230515114601.12737-2-huschle@linux.ibm.com>
In-Reply-To: <20230515114601.12737-2-huschle@linux.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 16 May 2023 15:36:19 +0200
Message-ID: <CAKfTPtC9050oY2EikUTAXTL8pAui3L+Sr4DBS0T-TccGNaA2hw@mail.gmail.com>
Subject: Re: [RFC 1/1] sched/fair: Consider asymmetric scheduler groups in
 load balancer
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 at 13:46, Tobias Huschle <huschle@linux.ibm.com> wrote:
>
> The current load balancer implementation implies that scheduler groups,
> within the same domain, all host the same number of CPUs. This is
> reflected in the condition, that a scheduler group, which is load
> balancing and classified as having spare capacity, should pull work
> from the busiest group, if the local group runs less processes than
> the busiest one. This implies that these two groups should run the
> same number of processes, which is problematic if the groups are not
> of the same size.
>
> The assumption that scheduler groups within the same scheduler domain
> host the same number of CPUs appears to be true for non-s390
> architectures. Nevertheless, s390 can have scheduler groups of unequal
> size.
>
> This introduces a performance degredation in the following scenario:
>
> Consider a system with 8 CPUs, 6 CPUs are located on one CPU socket,
> the remaining 2 are located on another socket:
>
> Socket   -----1-----    -2-
> CPU      1 2 3 4 5 6    7 8
>
> Placing some workload ( x = one task ) yields the following
> scenarios:
>
> The first 5 tasks are distributed evenly across the two groups.
>
> Socket   -----1-----    -2-
> CPU      1 2 3 4 5 6    7 8
>          x x x          x x
>
> Adding a 6th task yields the following distribution:
>
> Socket   -----1-----    -2-
> CPU      1 2 3 4 5 6    7 8
> SMT1     x x x          x x
> SMT2                    x

Your description is a bit confusing for me. What you name CPU above
should be named Core, doesn' it ?

Could you share with us your scheduler topology ?

>
> The task is added to the 2nd scheduler group, as the scheduler has the
> assumption that scheduler groups are of the same size, so they should
> also host the same number of tasks. This makes CPU 7 run into SMT
> thread, which comes with a performance penalty. This means, that in
> the window of 6-8 tasks, load balancing is done suboptimally, because
> SMT is used although there is no reason to do so as fully idle CPUs
> are still available.
>
> Taking the weight of the scheduler groups into account, ensures that
> a load balancing CPU within a smaller group will not try to pull tasks
> from a bigger group while the bigger group still has idle CPUs
> available.
>
> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0ca13ac..b1307d7e4065 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10426,7 +10426,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>          * group's child domain.
>          */
>         if (sds.prefer_sibling && local->group_type == group_has_spare &&
> -           busiest->sum_nr_running > local->sum_nr_running + 1)
> +           busiest->sum_nr_running * local->group_weight >
> +                       local->sum_nr_running * busiest->group_weight + 1)

This is the prefer_sibling path. Could it be that you should disable
prefer_siling between your sockets for such topology ? the default
path compares the number of idle CPUs when groups has spare capacity


>                 goto force_balance;
>
>         if (busiest->group_type != group_overloaded) {
> --
> 2.34.1
>
