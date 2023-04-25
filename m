Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89A36EDE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjDYIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDYIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:31:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76059BB96
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:30:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso804713966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1682411420; x=1685003420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88Xr0yx58XqZJmxu4bMMhXYH0sWThF6GMrgw+s7HUak=;
        b=F0IISRr4sT3y7mi4tVPSLZr3osIYsuNdqnruDnQVwYBhuw1h6u975I178mVxu7vdJJ
         CxYOrM7fpGC8yyNmXo+0chvXJKJ8VVR7YDV33KfBo6o9QhK352xX62uCfaEu76F8ndMO
         rki4xStOT/wZC3rLUxC4AAFw+iKDh4Crue/vCGfpASVf40SYA38T3jT7stkU+1cot3Pa
         55QuHcALpf38tmbItkd/US1Y8TIERWm2X3n8oQN1EcWKPGMKtAOXNvRm0J6PYLcX04hE
         x1EP2Awqfq9FYlT2f3hj0GuHx39UEnTV8TwIQDnVLVew1Jvxw+UNGAiQI2BEBVrX8bg0
         tPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682411420; x=1685003420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88Xr0yx58XqZJmxu4bMMhXYH0sWThF6GMrgw+s7HUak=;
        b=lCB1EM5urT4LOxZDUS3y8V0jbK4As16L0sMACMDNoBq75qy8qk0qutNOkRwuhfV30g
         yR+nq7AWVkwDQkUFLKKzXPyoCjfabAfVBZU+PTbqayYwoO2CkHItKDGgMCLvrP1ona5F
         YufIpEumQtd/XRk7R2Z6to4Q85TlPOjZD6/RKZWrcujHQIgolv4UqADK4wq9GDPyHDkK
         KnhRLfv1zhVuOnzb/VlnH8Zs8WA+vDlmwtJXwYuxu87QPxbGgG+bd8WzaYewVSQvCE4I
         dmEiX5ZUtQr06EXvLQWnPRbLVkvpwwtcJNF3h4mZWdj4AhXoevp34+uyEzXN9kYvofj7
         zypw==
X-Gm-Message-State: AAQBX9ez4U/ZjzgF7TOmWNIU4iaC80Kz+O/zZc/wybMfLBUG0TcB55Nu
        J6weoQvWCibrJUGjcMepzOwKyOg++/Vcq6mSzkcF6i7CNV3utJKY0abOzw==
X-Google-Smtp-Source: AKy350b2xeDumbZI/sk+mZ3Iqh02vZiQKW45K/czWanvQ2RB7nqZ/s96EkyakZ8ek80+JNlhxEQHIpWFTd/zFdHITFM=
X-Received: by 2002:a17:907:a042:b0:94e:cbfb:5fab with SMTP id
 gz2-20020a170907a04200b0094ecbfb5fabmr12155022ejc.75.1682411419899; Tue, 25
 Apr 2023 01:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230413062339.2454616-1-fengli@smartx.com> <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me> <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
In-Reply-To: <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
From:   Li Feng <fengli@smartx.com>
Date:   Tue, 25 Apr 2023 16:32:27 +0800
Message-ID: <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

On Wed, Apr 19, 2023 at 5:32=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
> >> Hey Li,
> >>
> >>> The default worker affinity policy is using all online cpus, e.g. fro=
m 0
> >>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp=
 will
> >>> have a bad performance.
> >>> This patch adds a module parameter to set the cpu affinity for the nv=
me-tcp
> >>> socket worker threads.  The parameter is a comma separated list of CP=
U
> >>> numbers.  The list is parsed and the resulting cpumask is used to set=
 the
> >>> affinity of the socket worker threads.  If the list is empty or the
> >>> parsing fails, the default affinity is used.
> >>
> >> I can see how this may benefit a specific set of workloads, but I have=
 a
> >> few issues with this.
> >>
> >> - This is exposing a user interface for something that is really
> >> internal to the driver.
> >>
> >> - This is something that can be misleading and could be tricky to get
> >> right, my concern is that this would only benefit a very niche case.
> > Our storage products needs this feature~
> > If the user doesn=E2=80=99t know what this is, they can keep it default=
, so I thinks this is
> > not unacceptable.
>
> It doesn't work like that. A user interface is not something exposed to
> a specific consumer.
>
> >> - If the setting should exist, it should not be global.
> > V2 has fixed it.
> >>
> >> - I prefer not to introduce new modparams.
> >>
> >> - I'd prefer to find a way to support your use-case without introducin=
g
> >> a config knob for it.
> >>
> > I=E2=80=99m looking forward to it.
>
> If you change queue_work_on to queue_work, ignoring the io_cpu, does it
> address your problem?
Sorry for the late response, I just got my machine back.
Replace the queue_work_on to queue_work, looks like it has a little
good performance.
The  busy worker is `kworker/56:1H+nvme_tcp_wq`, and fio binds to
90('cpus_allowed=3D90'),
I don't know why the worker 56 is selected.
The performance of 256k read up from 1.15GB/s to 1.35GB/s.

>
> Not saying that this should be a solution though.
>
> How many queues does your controller support that you happen to use
> queue 0 ?
Our controller only support one io queue currently.
>
> Also, what happens if you don't pin your process to a specific cpu, does
> that change anything?
If I don't pin the cpu, the performance has no effect.

Thanks,
Li
