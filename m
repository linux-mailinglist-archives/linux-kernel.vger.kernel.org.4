Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF89B728E76
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbjFIDSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbjFIDRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:17:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F523595
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:17:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so1891098a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 20:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686280646; x=1688872646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5V9qZ8AZC0PAHEC53+NI5LvUl1Gq+MugoplADCUTyg=;
        b=qibJSy2FZo6I0IuOw+tFaJvgeYRVVgfN+6MyT16w6u6C6kzs8lbvzUYhrcpWBC5uZH
         d2tWoog6Z/PMvKF+vDIV6bLxct2SukzoZ+mbPamHdmnqJ/p3m0OOh41hbGOiFKsZhIqV
         EWgFIe/kyUDTpbrQ7lqfxetV0dWH0sHrXCgg1AAgLgKFkSTKkvaUGFlndp1Eqxupjbr6
         PmTDfuzoVbBtNwcHsQ8Av8RgenctjZ1HtPSAf7/4NhIz3KIQpSDYwNy9i24Ql3wan2a4
         rLM0eu8WM/LOIy2jwcbzU/R3a3Z+pX+LSxgWEGOaiIRQzYs+gM0mQ+5u22XBcqezoVzy
         ZcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686280646; x=1688872646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5V9qZ8AZC0PAHEC53+NI5LvUl1Gq+MugoplADCUTyg=;
        b=d36OHTLeOSsCPzJIYpONXhrQMzcTTRKFYYfXZVHDATpVURHz/Gn42naqoi/gXmHI3O
         +hrpPjMKLZUjFY90BB87vkNbigNklMI9QVB0RYEnMarcv55/X5N3jVnhtqRP2hwSyws/
         2sUbytqGNBIsptpdb8QfE75TfCj4d/sfs2owNo8NZiYQ+H4I0i+D+VLpVLV8AbempjZZ
         djhdvqi65fRjCp0We709P6HaEN9ptXD6sgqT6d6uch72yp0uEij0dtzq+Ejpt1+1oWog
         7GnjcxwN8knlQKUq2WwtU8a8w/ahzjPtE4QOeaPSFWLuB1NzbiSZ2hTE5ALtO15AlqRO
         Nd1Q==
X-Gm-Message-State: AC+VfDyQTw3FwiFg68RKTx96/BL985ZIwZL7SzjvESCplLebHfGcKcgm
        hRT/kOHsjjlsntGSLb29y3AT9wPxikjhskdif8w=
X-Google-Smtp-Source: ACHHUZ7mLy3OiMx6n9ct/UrLVAjy95gN7sZTQv4qQvMZK2O+39FDNVQLYYQjUuH2mFvo1tcWO33/ZGeMQF18aySPFsc=
X-Received: by 2002:a17:906:dac5:b0:974:6335:4239 with SMTP id
 xi5-20020a170906dac500b0097463354239mr348897ejb.34.1686280646072; Thu, 08 Jun
 2023 20:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com> <CADtkEeds0jCug7F9MymVOdEVBrkSdX6mnLz4kZGCJ7og9JCc7A@mail.gmail.com>
 <ZIHcyBePwLQahkYI@ovpn-8-23.pek2.redhat.com>
In-Reply-To: <ZIHcyBePwLQahkYI@ovpn-8-23.pek2.redhat.com>
From:   =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date:   Fri, 9 Jun 2023 11:17:14 +0800
Message-ID: <CADtkEeenw4UbkhstH0F-LTOj1zem8DB8zrSc7zTo_WDfaGFmDg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To:     Ming Lei <ming.lei@redhat.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=888=E6=97=A5=
=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 08, 2023 at 10:48:50AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=888=E6=97=
=A5=E5=91=A8=E5=9B=9B 08:56=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Jun 07, 2023 at 12:09:17PM +0800, =E8=AE=B8=E6=98=A5=E5=85=89=
 wrote:
> > > > Hi Ming:
> > > >
> > > > Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=8C 23:15=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hello Chunguang,
> > > > >
> > > > > On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
> > > > > > From: Chunguang Xu <chunguang.xu@shopee.com>
> > > > > >
> > > > > > We found that nvme_remove_namespaces() may hang in flush_work(&=
ctrl->scan_work)
> > > > > > while removing ctrl. The root cause may due to the state of ctr=
l changed to
> > > > > > NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_t=
cp_error_recovery_work()/
> > > > > > nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this=
 time, ctrl is
> > > > >
> > > > > I didn't dig into ctrl state check in these error handler yet, bu=
t error
> > > > > handling is supposed to provide forward progress for any controll=
er state.
> > > > >
> > > > > Can you explain a bit how switching to DELETING interrupts the ab=
ove
> > > > > error handling and breaks the forward progress guarantee?
> > > >
> > > > Here we freezed ctrl, if ctrl state has changed to DELETING or
> > > > DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
> > > > freeze, so nvme_remove_namespaces() hang.
> > > >
> > > > static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > > > {
> > > >         ...
> > > >         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> > > >                 /* state change failure is ok if we started ctrl de=
lete */
> > > >                 WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &&
> > > >                              ctrl->state !=3D NVME_CTRL_DELETING_NO=
IO);
> > > >                 return;
> > > >         }
> > > >
> > > >         nvme_tcp_reconnect_or_remove(ctrl);
> > > > }
> > > >
> > > >
> > > > Another path, we will check ctrl state while reconnecting, if it ch=
anges to
> > > > DELETING or DELETING_NIO, we will break up and lease ctrl freeze an=
d
> > > > queue quiescing (through reset path), as a result Hang occurs.
> > > >
> > > > static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> > > > {
> > > >         /* If we are resetting/deleting then do nothing */
> > > >         if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
> > > >                 WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
> > > >                         ctrl->state =3D=3D NVME_CTRL_LIVE);
> > > >                 return;
> > > >         }
> > > >         ...
> > > > }
> > > >
> > > > > > freezed and queue is quiescing . Since scan_work may continue t=
o issue IOs to
> > > > > > load partition table, make it blocked, and lead to nvme_tcp_err=
or_recovery_work()
> > > > > > hang in flush_work(&ctrl->scan_work).
> > > > > >
> > > > > > After analyzation, we found that there are mainly two case:
> > > > > > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() =
while it issue
> > > > > >    new IO to load partition table.
> > > > >
> > > > > Yeah, nvme freeze usage is fragile, and I suggested to move
> > > > > nvme_start_freeze() from nvme_tcp_teardown_io_queues to
> > > > > nvme_tcp_configure_io_queues(), such as the posted change on rdma=
:
> > > > >
> > > > > https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAc=
b6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf75=
82e06b0
> > > >
> > > > While drive reconnecting, I think we should freeze ctrl or quiescin=
g queue,
> > > > otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
> > > > and the IOs may retry frequently. So I think we may better freeze c=
trl
> > > > while entering
> > > > error_recovery/reconnect, but need to unfreeze it while exit.
> > >
> > > quiescing is always done in error handling, and freeze is actually
> > > not a must, and it is easier to cause race by calling freeze & unfree=
ze
> > > from different contexts.
> >
> > I think if we donot freeze ctrl, as the IO already submit (just queue
> > to hctx->dispatch) and may
> > pending for a long time,  it may trigger new hang task issue, but
> > freeze ctrl may can avoid these
> > hang task.
>
> How can the freeze make the difference? If driver/device can't move on,
> any request is stuck, so the IO path waits in either submit_bio() or
> upper layer after returning from submit_bio().
>

Now error_recovery and reset ctrl are handled somewhat differently:
1. error_recovery will freeze the controller, but it will unquiescing
queue to fast fail pending IO later,
otherwise this part of IO may cause task hang during the reconnection,
so while error_recovery work
interrupted, just leave ctrl freeze, queue is unquiescing.

Think carefully, the new IO will still hang in enter_queue, it seems
that this solution still not work fine,
so I think we may also need to refactor the logic of error_recovery.

2. Reset ctrl will freeze the controller and quiescing queue at the
same time, while reset interrupted,
ctrl is freeze and the queue is quiescing.

I may got the point of you, what
https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOG=
FiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0
proposal seems better.

> Thanks,
> Ming
>
