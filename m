Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F2D7281D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjFHNwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbjFHNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01726BA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686232277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15Bc+umUOKHh/N1HmJDx8JlkqX8bRcwCEimhmYIDIhk=;
        b=hVAGC0MUrjllSPAhqdPYtIrcBmpWw6DFppfE9GGl8q/4TsVIaTV5QPeUZjJOsSyg/Gm92Z
        4H88t7qhWiUiEohfg2tLTNq3qAjoxBC52y93TR3hBzndDBZPKKEjIxI/LFofjev7G4GSG8
        LAAxDn/T0IqomDShWIZProKMu6TXDqE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-zqfJJjNxMVS5qpH6L4X22g-1; Thu, 08 Jun 2023 09:51:15 -0400
X-MC-Unique: zqfJJjNxMVS5qpH6L4X22g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFD8729ABA07;
        Thu,  8 Jun 2023 13:51:14 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6275D492B0A;
        Thu,  8 Jun 2023 13:51:08 +0000 (UTC)
Date:   Thu, 8 Jun 2023 21:51:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Message-ID: <ZIHcyBePwLQahkYI@ovpn-8-23.pek2.redhat.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
 <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
 <CADtkEeds0jCug7F9MymVOdEVBrkSdX6mnLz4kZGCJ7og9JCc7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEeds0jCug7F9MymVOdEVBrkSdX6mnLz4kZGCJ7og9JCc7A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:48:50AM +0800, 许春光 wrote:
> Ming Lei <ming.lei@redhat.com> 于2023年6月8日周四 08:56写道：
> >
> > On Wed, Jun 07, 2023 at 12:09:17PM +0800, 许春光 wrote:
> > > Hi Ming:
> > >
> > > Ming Lei <ming.lei@redhat.com> 于2023年6月6日周二 23:15写道：
> > > >
> > > > Hello Chunguang,
> > > >
> > > > On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
> > > > > From: Chunguang Xu <chunguang.xu@shopee.com>
> > > > >
> > > > > We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
> > > > > while removing ctrl. The root cause may due to the state of ctrl changed to
> > > > > NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
> > > > > nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is
> > > >
> > > > I didn't dig into ctrl state check in these error handler yet, but error
> > > > handling is supposed to provide forward progress for any controller state.
> > > >
> > > > Can you explain a bit how switching to DELETING interrupts the above
> > > > error handling and breaks the forward progress guarantee?
> > >
> > > Here we freezed ctrl, if ctrl state has changed to DELETING or
> > > DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
> > > freeze, so nvme_remove_namespaces() hang.
> > >
> > > static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > > {
> > >         ...
> > >         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> > >                 /* state change failure is ok if we started ctrl delete */
> > >                 WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
> > >                              ctrl->state != NVME_CTRL_DELETING_NOIO);
> > >                 return;
> > >         }
> > >
> > >         nvme_tcp_reconnect_or_remove(ctrl);
> > > }
> > >
> > >
> > > Another path, we will check ctrl state while reconnecting, if it changes to
> > > DELETING or DELETING_NIO, we will break up and lease ctrl freeze and
> > > queue quiescing (through reset path), as a result Hang occurs.
> > >
> > > static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> > > {
> > >         /* If we are resetting/deleting then do nothing */
> > >         if (ctrl->state != NVME_CTRL_CONNECTING) {
> > >                 WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
> > >                         ctrl->state == NVME_CTRL_LIVE);
> > >                 return;
> > >         }
> > >         ...
> > > }
> > >
> > > > > freezed and queue is quiescing . Since scan_work may continue to issue IOs to
> > > > > load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
> > > > > hang in flush_work(&ctrl->scan_work).
> > > > >
> > > > > After analyzation, we found that there are mainly two case:
> > > > > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
> > > > >    new IO to load partition table.
> > > >
> > > > Yeah, nvme freeze usage is fragile, and I suggested to move
> > > > nvme_start_freeze() from nvme_tcp_teardown_io_queues to
> > > > nvme_tcp_configure_io_queues(), such as the posted change on rdma:
> > > >
> > > > https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0
> > >
> > > While drive reconnecting, I think we should freeze ctrl or quiescing queue,
> > > otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
> > > and the IOs may retry frequently. So I think we may better freeze ctrl
> > > while entering
> > > error_recovery/reconnect, but need to unfreeze it while exit.
> >
> > quiescing is always done in error handling, and freeze is actually
> > not a must, and it is easier to cause race by calling freeze & unfreeze
> > from different contexts.
> 
> I think if we donot freeze ctrl, as the IO already submit (just queue
> to hctx->dispatch) and may
> pending for a long time,  it may trigger new hang task issue, but
> freeze ctrl may can avoid these
> hang task.

How can the freeze make the difference? If driver/device can't move on,
any request is stuck, so the IO path waits in either submit_bio() or
upper layer after returning from submit_bio().


Thanks,
Ming

