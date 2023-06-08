Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F7728771
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjFHSpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjFHSpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:45:00 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B07D193
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:44:58 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b13e2af122so10855a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1686249898; x=1688841898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt12+1+dARtKc3fRLQ7ivDg1sn89g+SY2IZ1KjaiaJs=;
        b=0sPZpYtCx2uIcWQN2SI/AEQ/WWZcXhOA/di7WAeDir9+IxajPlSiVl+Hm2Chzremmo
         dNc1GyBIQugOsTs0Op4y9GnHpYJA6Lk2SzxfAFqSh7gT18FVPy6ip84ibVOzTAH/UfUA
         ZvZjqPRxbDJ1qCdiplb3WeEslaA6HHFH8lOx/eE5silGncLGYYiL5xP/SkdO+VG6Dm5D
         1eFQ20JbZf12nZYUu92bxsTJf6ot+K12YXjoCdFGJuDefST2cgBxazwwt2XthTgYPA/o
         sHIPKcuZ2bM83dfwq5rhxfjHleCZJVwihFvLBLGwll/oJeiCqDdp3ptsYVl+seJdxQ30
         YSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686249898; x=1688841898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt12+1+dARtKc3fRLQ7ivDg1sn89g+SY2IZ1KjaiaJs=;
        b=WBcHH96ylf5kB+2IH5Z9xmBMH17REBirvfVX5PYtlrufoYw0C+/Rtku/+VdbBkqYUf
         2C/IePV1nKhJvylGdhFys9ETuVSVJqDW96dVUAjMFMu9ugjjgNxitcsWhzvw3rz/jKG8
         E7twc5GIgFZXxos1jqAD6xn2KAi7dT9ZhVhpVmoifR28IYNFEL1unzx4swOhoOxT1J6X
         RqsfCw5E3BpavykhgiL0n8r/UGicv1GNaGUlUaiL952B5lfZWqmTqKzCTLO5Zq3JsvzQ
         yTuaAzf0Kj7ji0y4VP/KSsm5S1wflX/wxAJg2hDfpzpc/k8+clhhkx6YafU3HI6/XazS
         yxZQ==
X-Gm-Message-State: AC+VfDxZE9F/t+/iMzIi43mTqVXJwd/rV9MfUnFBhFdQZy1FaUsCyFUX
        DCkPGAyPcdVB/7GxYMZgveC0U3OKX4qInZmM6Z/q6Q==
X-Google-Smtp-Source: ACHHUZ6qTt2rGt9wmZJ/SPf4KQOMj4ZBEd3BOO3j7B2iz3zwr55Kb1Y6wu4JUoLhK2C91muXfFqoZoIhgmucd8I7ZNU=
X-Received: by 2002:a05:6359:a9b:b0:129:b9a9:7858 with SMTP id
 em27-20020a0563590a9b00b00129b9a97858mr3725483rwb.3.1686249897389; Thu, 08
 Jun 2023 11:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230602103750.2290132-1-vladimir.oltean@nxp.com> <20230602103750.2290132-6-vladimir.oltean@nxp.com>
In-Reply-To: <20230602103750.2290132-6-vladimir.oltean@nxp.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Thu, 8 Jun 2023 14:44:46 -0400
Message-ID: <CAM0EoM=P9+wNnNQ=ky96rwCx1z20fR21EWEdx+Na39NCqqG=3A@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next 5/5] net/sched: taprio: dump class stats
 for the actual q->qdiscs[]
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 6:38=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> This makes a difference for the software scheduling mode, where
> dev_queue->qdisc_sleeping is the same as the taprio root Qdisc itself,
> but when we're talking about what Qdisc and stats get reported for a
> traffic class, the root taprio isn't what comes to mind, but q->qdiscs[]
> is.
>
> To understand the difference, I've attempted to send 100 packets in
> software mode through traffic class 0 (they are in the Qdisc's backlog),
> and recorded the stats before and after the change.
>

Other than the refcount issue i think the approach looks reasonable to
me. The stats before/after you are showing below though are
interesting; are you showing a transient phase where packets are
temporarily in the backlog. Typically the backlog is a transient phase
which lasts a very short period. Maybe it works differently for
taprio? I took a quick look at the code and do see to decrement the
backlog in the dequeue, so if it is not transient then some code path
is not being hit.

Aside: I realize you are busy - but if you get time and provide some
sample tc command lines for testing we could help create the tests for
you, at least the first time. The advantage of putting these tests in
tools/testing/selftests/tc-testing/ is that there are test tools out
there that run these tests and so regressions are easier to catch
sooner.

cheers,
jamal

> Here is before:
>
> $ tc -s class show dev eth0
> class taprio 8001:1 root leaf 8001:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
> class taprio 8001:2 root leaf 8001:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
> class taprio 8001:3 root leaf 8001:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
> class taprio 8001:4 root leaf 8001:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
> class taprio 8001:5 root leaf 8001:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
> class taprio 8001:6 root leaf 8001:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
> class taprio 8001:7 root leaf 8001:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
> class taprio 8001:8 root leaf 8001:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
>
> and here is after:
>
> class taprio 8001:1 root
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 9400b 100p requeues 0
>  Window drops: 0
> class taprio 8001:2 root
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>  Window drops: 0
> class taprio 8001:3 root
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>  Window drops: 0
> class taprio 8001:4 root
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>  Window drops: 0
> class taprio 8001:5 root
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>  Window drops: 0
> class taprio 8001:6 root
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>  Window drops: 0
> class taprio 8001:7 root leaf 8010:
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>  Window drops: 0
> class taprio 8001:8 root
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0
>  Window drops: 0
>
> The most glaring (and expected) difference is that before, all class
> stats reported the global stats, whereas now, they really report just
> the counters for that traffic class.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/sched/sch_taprio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index cc7ff98e5e86..23b98c3af8b2 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2452,11 +2452,11 @@ static unsigned long taprio_find(struct Qdisc *sc=
h, u32 classid)
>  static int taprio_dump_class(struct Qdisc *sch, unsigned long cl,
>                              struct sk_buff *skb, struct tcmsg *tcm)
>  {
> -       struct netdev_queue *dev_queue =3D taprio_queue_get(sch, cl);
> +       struct Qdisc *child =3D taprio_leaf(sch, cl);
>
>         tcm->tcm_parent =3D TC_H_ROOT;
>         tcm->tcm_handle |=3D TC_H_MIN(cl);
> -       tcm->tcm_info =3D dev_queue->qdisc_sleeping->handle;
> +       tcm->tcm_info =3D child->handle;
>
>         return 0;
>  }
> @@ -2466,8 +2466,7 @@ static int taprio_dump_class_stats(struct Qdisc *sc=
h, unsigned long cl,
>         __releases(d->lock)
>         __acquires(d->lock)
>  {
> -       struct netdev_queue *dev_queue =3D taprio_queue_get(sch, cl);
> -       struct Qdisc *child =3D dev_queue->qdisc_sleeping;
> +       struct Qdisc *child =3D taprio_leaf(sch, cl);
>         struct tc_taprio_qopt_offload offload =3D {
>                 .cmd =3D TAPRIO_CMD_TC_STATS,
>                 .tc_stats =3D {
> --
> 2.34.1
>
