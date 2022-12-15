Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58DE64D519
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLOBtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLOBti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:49:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B782A26D;
        Wed, 14 Dec 2022 17:49:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j4so13490773lfk.0;
        Wed, 14 Dec 2022 17:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uR0itTVt/FczCT3tTCUIz7rhFERW4XLAvwXhZxOOck=;
        b=H7ZRzaMERNL5e0UNCT3+KQPjY2LcFL9F9zkoihWkPRVjZfGwMFjsC9e2Qxu9AxAA1h
         uc/If3AusNjZs8BEvwR/Ww6d5AXy6Z9R8eGKgwIQqi6C1Gk/FyPv+eFhAmaho38J1I8b
         UIdoM9/1/v7zZNhAMWSs+nr1nFutrX+oDqDVRf7Miult/CzGhBvwBfDGxCv8leeohcCG
         wGBU3sgjPbmrPYtHQlOM+NUxghtIf3/II7mkyaaqBb7JsQ/v/maiyqKk1vW/mHYk4kCs
         NiUg1YCeagKUZ8Amy8C/KLm02VFvHCVyJQo4otMBTJnoanacgZcU1DwZE8BTp9crcIla
         bUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uR0itTVt/FczCT3tTCUIz7rhFERW4XLAvwXhZxOOck=;
        b=VAneozlRqbja/OMb/fEkyeEFLvWSC5k+tlOgKnyP/F1krgRzxvtbIXQUzsx2y3kszx
         xylcnOedDIotPAN7cYMQVSfVZ3DS/MKzcXKWhMFwO3zp3fWfQJqD+fNB0kimW+b2g/tr
         VHm6z2OEycTeFs3ultSbm/6duftXFGhpSc1IdTWjWOZkbfDmEkbDVQ888JQ/q+kKZK0V
         1xlDwVL9oQ2iUb+mGwU/9IQhI1yKJ8D6VkrjfZawup9s6u89TuSACYFiE0lgj8hAGAeX
         QTxN2tlbDT/tm2aMho1dsoEzJCLxqwsgyrSWW2Cxe5Wx+JTlDReJinJXhxcxoWvIU5Vv
         /xHQ==
X-Gm-Message-State: ANoB5plED8kWCB+4FfbgxhHCiYY9LJ2aVJfnW3d5cibMGQEVPj1g2UP1
        pt/fHAGYIbQ796xQOseqpFDSTp5YH25LpPIlVNo=
X-Google-Smtp-Source: AA0mqf5liwcVYnuCPTCNcyM6ilakhOG9gI5m3PiYoLX0ZL/wlDP38UbjqB7o4AkT/dwZPWZ5Y0fiC2BnhhPAAxuh7lY=
X-Received: by 2002:ac2:59c6:0:b0:4b5:721f:f32f with SMTP id
 x6-20020ac259c6000000b004b5721ff32fmr6830047lfn.383.1671068975395; Wed, 14
 Dec 2022 17:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20221110112622.389332-1-Yuwei.Guan@zeekrlife.com> <3153dcb3-dd9b-7a2b-a15a-8244d805f246@huaweicloud.com>
In-Reply-To: <3153dcb3-dd9b-7a2b-a15a-8244d805f246@huaweicloud.com>
From:   Yuwei Guan <ssawgyw@gmail.com>
Date:   Thu, 15 Dec 2022 09:48:59 +0800
Message-ID: <CALJQGLmOaEnHawYvNz5fk_MtGhz6DPpW+8E-hgvmWxF--8V4zA@mail.gmail.com>
Subject: Re: [PATCH v1] block, bfq: do the all counting of pending-request if
 CONFIG_BFQ_GROUP_IOSCHED is enabled
To:     Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Kuai <yukuai1@huaweicloud.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=B8=80 11:33=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> =E5=9C=A8 2022/11/10 19:26, Yuwei Guan =E5=86=99=E9=81=93:
> > The 'bfqd->num_groups_with_pending_reqs' is used when
> > CONFIG_BFQ_GROUP_IOSCHED is enabled, so let the variables and processes
> > take effect when ONFIG_BFQ_GROUP_IOSCHED is enabled.
> >
>
> This patch looks good to me, fell free to add:
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>
> BTW, this patch need to be reviewed by Jan or Paolo before it can be
> applied.
>
Hi Jan,

Could you help to review this patch.

Thanks.

> Thanks,
> Kuai
>
> > Cc: Yu Kuai <yukuai3@huawei.com>
> > Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> > ---
> >   block/bfq-iosched.c | 2 ++
> >   block/bfq-iosched.h | 4 ++++
> >   block/bfq-wf2q.c    | 8 ++++----
> >   3 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index 2381cf220ba2..5f54091e7fe9 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -7051,7 +7051,9 @@ static int bfq_init_queue(struct request_queue *q=
, struct elevator_type *e)
> >       bfqd->idle_slice_timer.function =3D bfq_idle_slice_timer;
> >
> >       bfqd->queue_weights_tree =3D RB_ROOT_CACHED;
> > +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> >       bfqd->num_groups_with_pending_reqs =3D 0;
> > +#endif
> >
> >       INIT_LIST_HEAD(&bfqd->active_list);
> >       INIT_LIST_HEAD(&bfqd->idle_list);
> > diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> > index 9fa89577322d..41aa151ccc22 100644
> > --- a/block/bfq-iosched.h
> > +++ b/block/bfq-iosched.h
> > @@ -197,8 +197,10 @@ struct bfq_entity {
> >       /* flag, set to request a weight, ioprio or ioprio_class change  =
*/
> >       int prio_changed;
> >
> > +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> >       /* flag, set if the entity is counted in groups_with_pending_reqs=
 */
> >       bool in_groups_with_pending_reqs;
> > +#endif
> >
> >       /* last child queue of entity created (for non-leaf entities) */
> >       struct bfq_queue *last_bfqq_created;
> > @@ -491,6 +493,7 @@ struct bfq_data {
> >        */
> >       struct rb_root_cached queue_weights_tree;
> >
> > +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> >       /*
> >        * Number of groups with at least one process that
> >        * has at least one request waiting for completion. Note that
> > @@ -538,6 +541,7 @@ struct bfq_data {
> >        * with no request waiting for completion.
> >        */
> >       unsigned int num_groups_with_pending_reqs;
> > +#endif
> >
> >       /*
> >        * Per-class (RT, BE, IDLE) number of bfq_queues containing
> > diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> > index b02b53658ed4..ea4c3d757fdd 100644
> > --- a/block/bfq-wf2q.c
> > +++ b/block/bfq-wf2q.c
> > @@ -1612,28 +1612,28 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, st=
ruct bfq_queue *bfqq,
> >
> >   void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
> >   {
> > +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> >       struct bfq_entity *entity =3D &bfqq->entity;
> >
> >       if (!entity->in_groups_with_pending_reqs) {
> >               entity->in_groups_with_pending_reqs =3D true;
> > -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> >               if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
> >                       bfqq->bfqd->num_groups_with_pending_reqs++;
> > -#endif
> >       }
> > +#endif
> >   }
> >
> >   void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
> >   {
> > +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> >       struct bfq_entity *entity =3D &bfqq->entity;
> >
> >       if (entity->in_groups_with_pending_reqs) {
> >               entity->in_groups_with_pending_reqs =3D false;
> > -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> >               if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
> >                       bfqq->bfqd->num_groups_with_pending_reqs--;
> > -#endif
> >       }
> > +#endif
> >   }
> >
> >   /*
> >
>
