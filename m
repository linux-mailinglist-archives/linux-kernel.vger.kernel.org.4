Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE7750C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjGLPbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjGLPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:31:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D051D1BE2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:30:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso11612112e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689175852; x=1691767852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5FApRcAbKU3D+hMPXf1fqvobd8bBItL8xQBsYQGqYbg=;
        b=XiJpjGY/f2JchBKGpVyqD04K+WjJ6SQfb795/ayMXwBtsOl1D5pIHUY5VbOom9j3wg
         o2IIAa+kuwDtO7h6A5TaWel5Mi09Zb4yfqVks2p4ro5FbEpV9YZpLCZRKNBuUoc2aw0e
         NVfgtkMK2PMsKJuXjvaiRHTdybO9X8KNCCIAPKpboDXryOn59EsOg+XrGDZHANg5buJ0
         Y8vW+wYRfp5eB8t/h7id3YsrVCHCkehDP1FfGG3VU04rqpqnOIpIXcNmcAAUH+A6chbs
         6D6OnAloCCByl3zRVjwBYx97rYDu8k4dFICaSM363vRz0wAaj7N4SdeU3DIgWOvUONvS
         nxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175852; x=1691767852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FApRcAbKU3D+hMPXf1fqvobd8bBItL8xQBsYQGqYbg=;
        b=howkaVsqKxCwtmd7iYoS1O+55c7FSNr+CaU//kPsCQhCYtpOEb/SLWiCD+9PdwF4lU
         OdCHLRCMaE3GHJU8eccBLV1WOKopErKtKVIxl7dcUXeB9OrTV+d7uhAFEvIJLenlGGAA
         3IzUicE7rb9TUvQDDXOHy3T+nFgltRDSRDnd5hf4P1AFFJSbTNRaZbq8Wf27Ubeiif2Q
         Rfgagb4iorrZnzg2pXw5LQBVLt+j0+83iQzmemq7Rk79NgV2pLj8QoOpq873VLiM4pmz
         uex7Vn8eBBZRnyK7+as9Q8PyhtCZGmX2oIAVPsVGpGxVulIsbbGgNK05BMnIG/9oyr/k
         t7vg==
X-Gm-Message-State: ABy/qLbwo2yj4WjHWoeLfGwoz24pL17L6vGSwg5DVOpFP2nVIVdGUzOW
        qQIL4g9ix9vaQE/4m6/YVnCzqgNKhGdnGJl/IYl+Tw==
X-Google-Smtp-Source: APBJJlHURxrcGvzm9de9OQNp5GQvfExUmVyKnB0KwvjWfMufAHlivX2Wx5QN2BcQOBm2y6WovYKB+2pqxHJZ0S1b2+U=
X-Received: by 2002:a19:4f42:0:b0:4fb:7de4:c837 with SMTP id
 a2-20020a194f42000000b004fb7de4c837mr15457897lfk.68.1689175851897; Wed, 12
 Jul 2023 08:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230706135144.324311-1-vincent.guittot@linaro.org> <20230711154718.gudn32sru5opwvlw@airbuntu>
In-Reply-To: <20230711154718.gudn32sru5opwvlw@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Jul 2023 17:30:39 +0200
Message-ID: <CAKfTPtC2NyZcVukzsYAEdhyxv__AURVuJ1JUoh8NGBmq0mL1hQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: remove util_est boosting
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
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

On Tue, 11 Jul 2023 at 17:47, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 07/06/23 15:51, Vincent Guittot wrote:
> > There is no need to use runnable_avg when estimating util_est and that
> > even generates wrong behavior because one includes blocked tasks whereas
> > the other one doesn't. This can lead to accounting twice the waking task p,
> > once with the blocked runnable_avg and another one when adding its
> > util_est.
> >
> > cpu's runnable_avg is already used when computing util_avg which is then
> > compared with util_est.
> >
> > In some situation, feec will not select prev_cpu but another one on the
> > same performance domain because of higher max_util
> >
> > Fixes: 7d0583cf9ec7 ("sched/fair, cpufreq: Introduce 'runnable boosting'")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
>
> Can we verify the numbers that introduced this magic boost are still valid
> please?

TBH I don't expect it but I agree it's worth checking. Dietmar could
you rerun your tests with this change ?

>
> Otherwise LGTM.
>
>
> Thanks!
>
> --
>
> Qais Yousef
>
> >  kernel/sched/fair.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a80a73909dc2..77c9f5816c31 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7289,9 +7289,6 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
> >
> >               util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> >
> > -             if (boost)
> > -                     util_est = max(util_est, runnable);
> > -
> >               /*
> >                * During wake-up @p isn't enqueued yet and doesn't contribute
> >                * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
> > --
> > 2.34.1
> >
