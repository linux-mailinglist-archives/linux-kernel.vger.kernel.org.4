Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C3B74AEBA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjGGK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGGK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:28:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAC10B;
        Fri,  7 Jul 2023 03:28:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26304be177fso961759a91.1;
        Fri, 07 Jul 2023 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688725721; x=1691317721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLLYKihCnqonBva0uK0MK1UGblIUXGyxKDZM3oPQ2D4=;
        b=D+vTiZXLec1XkE8ggtB6vOc60n/W6Z7GtUcmGAUuqfr95CKMbSTD+7EzYQTABQMkJm
         biWKiQPTEXYpAMn7Kha0wSs9Wbh9kGLQ/o+6Cy2h4xVwm0dAAZ69E88iSvdRsArktABz
         4/m84yP4TqFUpRa1OWG+9lzg9Rw4d8LtIG+a9oCUEek5sGs9Ygmze5ojDbl3/E9qEtE/
         g2YBp1cfjMdiqzhNI3WDbQ006UpJfbj8sxLiMrbdNxDABRsP5mH5H9wRS3sgsPHxiwjY
         0T9ezz7aDz6NQtaWPmOu46vg2UtTpBjt1OwWyW08ZnxeXd1ub2KewxOKpEYewArplt4E
         HAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688725721; x=1691317721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLLYKihCnqonBva0uK0MK1UGblIUXGyxKDZM3oPQ2D4=;
        b=d0PA2RjW9r6dhCpaH4D9Rl9aYZN94hWDpaHMy5tvMO/GmdOXpDm1YTMK5iN5uNBbhf
         NA5wzLCCK2WySFpSrHxdngVIC2oayx83QDo5NM3JEGOIY9gdZCyy3PAHxQQhExb++zZ+
         +x20cTwSaFUqwsWuBDSCyrvJxPrOtITVH72laSb+TKoVIw8/JEumUnYUYrIpSBFwjw+M
         3PeYQYWBZvk0nnaZXhP/LR1xWXOyJaxACLYpl6FcR1FdyuWbO0MQ3ZuHLVKqOcPNQu4S
         KueGUeJZR6iXBdCWY3vS6/vrY/WemqiXDgeQtKPcjfwViYLo5i94ZrAMSuE7GGlxLLPh
         5zjA==
X-Gm-Message-State: ABy/qLbJsJanGjxp7eitNC58Or8tPHDDCgHg3Wjmg20oE5zJlkQBKod+
        ioXFhoa0eI95iLUfecLyaGZTU1rqA6kSHnIHjkj2nFaK4MM=
X-Google-Smtp-Source: APBJJlH2U3NiUmDB0oo2SWsnmGpWcPkdi6P/joEHI/qqzGclZG1vCN04xPiuZTiRy5OF0XabY2sR0MAbTr67ay3J18U=
X-Received: by 2002:a17:90b:292:b0:263:528:144a with SMTP id
 az18-20020a17090b029200b002630528144amr3817073pjb.28.1688725721516; Fri, 07
 Jul 2023 03:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230704082615.7415-1-qiang.zhang1211@gmail.com> <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop>
In-Reply-To: <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 7 Jul 2023 18:28:29 +0800
Message-ID: <CALm+0cW6DojcxSnzf2mMXhXP-MHJ0aEvSqyh1TbtvBC4bzfsOw@mail.gmail.com>
Subject: Re: [PATCH] srcu: Make srcu_might_be_idle() take early return if
 rcu_gp_is_normal() return true
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Tue, Jul 04, 2023 at 04:26:15PM +0800, Zqiang wrote:
> > When invoke synchronize_srcu(), in the srcu_might_be_idle(), the current
> > CPU's sdp->lock will be acquired to check whether there are pending
> > callbacks in the sdp->srcu_cblist, if there are no pending callbacks,
> > probabilistically probe global state to decide whether to convert to
> > synchronize_srcu_expedited() call. however, for the rcupdate.rcu_normal=1
> > kernels and after the rcu_set_runtime_mode() is called, invoke the
> > rcu_gp_is_normal() is always return true, this mean that invoke the
> > synchronize_srcu_expedited() always fall back to synchronize_srcu(),
> > so there is no need to acquire sdp->lock to check sdp->srcu_cblist and
> > probe global state in srcu_might_be_idle().
> >
> > This commit therefore make srcu_might_be_idle() return immediately if the
> > rcu_gp_is_normal() return true.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/srcutree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 20d7a238d675..aea49cb60a45 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> >       unsigned long tlast;
> >
> >       check_init_srcu_struct(ssp);
> > +     if (rcu_gp_is_normal())
> > +             return false;
>
> Again, thank you for looking into SRCU!
>
> I am not at all enthusiastic about this one.  With this change, the name
> srcu_might_be_idle() is no longer accurate.  Yes, the name could change,
> but any name would be longer and more confusing.
>
> So unless there is a measureable benefit to this one on a production
> workload, I cannot justify taking it.
>
> Is there a measureable benefit?
>


Hi, Paul

I only find that for Preempt-RT kernel,  the rcu_normal_after_boot is
set by default:
static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
This affects only rcu but also srcu, this make the synchronize_srcu() and
synchronize_srcu_expedited() always fall back to __synchronize_srcu(ssp, true),
this means that call the srcu_might_be_idle() is meaningless.

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> >       /* If the local srcu_data structure has callbacks, not idle.  */
> >       sdp = raw_cpu_ptr(ssp->sda);
> >       spin_lock_irqsave_rcu_node(sdp, flags);
> > --
> > 2.17.1
> >
