Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FDF6C2FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCULJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCULIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:08:44 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FBD3E08B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:08:40 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c10so5885500vsh.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679396919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkY36efev75olXTgASXSrDXJvbFbYvncoigSCIDA+tk=;
        b=kZ7YYOQ/Z4vEsQHK3UH5xp/MDV26EXrvhXhlAtZrgy0gOSfp+tOZv+LKZ+o+ARgEU7
         yKxJO17yOibLCxOq09napoiOZntvTvTITOpD00a4BGoavXJb1QqtTiJI3XD9QZytnp3f
         YxCBj9K+ss2fheOT2XTB5LpkcxmPqvAmwkQQv4PCByjDbxRh76uoRoxJQx/uetF5wLha
         6HEMKGlAM0NW1lteSqFS7nydzSHhXViUruA3JISpQbbroeIIiHWNNtLu0Tb0xQsotQI+
         uWrdAx7O4CFasbAaOqDrnktEjOUv6clRVUB3y+jBGX/hdx8UqrxNmSjBbt7dEWaRA2Hs
         /Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679396919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkY36efev75olXTgASXSrDXJvbFbYvncoigSCIDA+tk=;
        b=r9HBzooW4QtmM6EKOnfw14efUexdeGpRXEYNJmZ99+Do6n09mqpMAiZMazbnOgzCJy
         d+9DWj4Do2TG47o233lw45o7nVrypjqHPSPFixefG8UszYNYWAQQSHx5sCvr5ynwzjgv
         QiyYyPr/rs4hnR8fPebP4lO/Q50ljsnB/VCPC6bTEdBAgTm10ulrEq0CyqEL3AhBcDTk
         Tl87POdcl/yqP7XQQa1iTA6KET7fpVBgMjUe5psIyI02JabkUPuvGuYnyl0uL5xZ20JN
         QVuJX38kXPUlNk3/RtXjUVFxY6qqQ+Ua/mwzAYJQnYZmPheascwnliykqvGdaSjbFVGX
         qXgg==
X-Gm-Message-State: AO0yUKV29JBt9F2sjKnAjZ6+KBMIb5ybhZWqaStPvPE9yZTZ7jdRepJI
        uhgF7EqZHgfGPXl6JgTiy5WVJ2oI1Ke6kDP+C29DOg==
X-Google-Smtp-Source: AK7set/g/Slv+mbINeBhgLGsle7PgsGbYuRTcG0kcRTYJMnHXRn7NfYpZ6eL996oS8V7iLpdP+fwiXyjEwl8R6DeKHA=
X-Received: by 2002:a67:c809:0:b0:420:10e:14e8 with SMTP id
 u9-20020a67c809000000b00420010e14e8mr913320vsk.1.1679396919240; Tue, 21 Mar
 2023 04:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230315183408.2723-1-praveen.kannoju@oracle.com> <SA1PR10MB6445AE5B65A9C85838142CE08C819@SA1PR10MB6445.namprd10.prod.outlook.com>
In-Reply-To: <SA1PR10MB6445AE5B65A9C85838142CE08C819@SA1PR10MB6445.namprd10.prod.outlook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Mar 2023 04:08:27 -0700
Message-ID: <CANn89iLmC8Wd6PcBeN899c_pp0VKNP2S=gctBS8cP8+spknL1A@mail.gmail.com>
Subject: Re: [PATCH RFC] net/sched: use real_num_tx_queues in dev_watchdog()
To:     Praveen Kannoju <praveen.kannoju@oracle.com>
Cc:     "jhs@mojatatu.com" <jhs@mojatatu.com>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 3:05=E2=80=AFAM Praveen Kannoju
<praveen.kannoju@oracle.com> wrote:
>
> Ping.
>

I do not think dev_watchdog() needs to be efficient ?

In any case, reading dev->real_num_tx_queues from a timer handler
could be racy vs RTNL.

While reading dev->num_tx_queues is not racy.

I think you should describe what problem you are trying to solve.

> > -----Original Message-----
> > From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> > Sent: 16 March 2023 12:04 AM
> > To: jhs@mojatatu.com; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem=
@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org
> > Cc: Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>;=
 Rama Nichanamatlu
> > <rama.nichanamatlu@oracle.com>; Manjunath Patil <manjunath.b.patil@orac=
le.com>; Praveen Kannoju
> > <praveen.kannoju@oracle.com>
> > Subject: [PATCH RFC] net/sched: use real_num_tx_queues in dev_watchdog(=
)
> >
> > Currently dev_watchdog() loops through num_tx_queues[Number of TX queue=
s allocated at alloc_netdev_mq() time] instead of
> > real_num_tx_queues [Number of TX queues currently active in device] to =
detect transmit queue time out. Make this efficient by
> > using real_num_tx_queues.
> >
> > Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> > ---
> > PS: Please let me know if I am missing something obvious here.
> >  net/sched/sch_generic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c index a9=
aadc4e6858..e7d41a25f0e8 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -506,7 +506,7 @@ static void dev_watchdog(struct timer_list *t)
> >                       unsigned int i;
> >                       unsigned long trans_start;
> >
> > -                     for (i =3D 0; i < dev->num_tx_queues; i++) {
> > +                     for (i =3D 0; i < dev->real_num_tx_queues; i++) {
> >                               struct netdev_queue *txq;
> >
> >                               txq =3D netdev_get_tx_queue(dev, i);
> > --
> > 2.31.1
>
