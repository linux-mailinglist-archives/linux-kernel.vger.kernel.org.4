Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FED7273EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 02:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjFHA5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 20:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjFHA5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 20:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326B426A2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686185808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7nfolqv8yAle0E/PIi3ZpSr/4JeqqFt1ziCI//3vVM=;
        b=iwNSY6mMUZ+y6hK0U8coZW6UbnmhoVRAmD1xtLk8vwXoKyaGpVEZWMQnBFoLy7V+92fi3D
        mp1xzAEK0EuTlZUuS8CtTB4ebMdD3G6Te1pdzLXDZGPgMM2pGca7WPsQ1mrn9MFm8eLgLR
        Z/2Idq5ka8k0tB8PIlyZZ+GcjiKLUOc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-kyxEhIFDOr6b8ZUQenr8rA-1; Wed, 07 Jun 2023 20:56:45 -0400
X-MC-Unique: kyxEhIFDOr6b8ZUQenr8rA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FA098007D9;
        Thu,  8 Jun 2023 00:56:44 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BC602026D49;
        Thu,  8 Jun 2023 00:56:39 +0000 (UTC)
Date:   Thu, 8 Jun 2023 08:56:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Message-ID: <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
 <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:09:17PM +0800, 许春光 wrote:
> Hi Ming:
> 
> Ming Lei <ming.lei@redhat.com> 于2023年6月6日周二 23:15写道：
> >
> > Hello Chunguang,
> >
> > On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
> > > From: Chunguang Xu <chunguang.xu@shopee.com>
> > >
> > > We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
> > > while removing ctrl. The root cause may due to the state of ctrl changed to
> > > NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
> > > nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is
> >
> > I didn't dig into ctrl state check in these error handler yet, but error
> > handling is supposed to provide forward progress for any controller state.
> >
> > Can you explain a bit how switching to DELETING interrupts the above
> > error handling and breaks the forward progress guarantee?
> 
> Here we freezed ctrl, if ctrl state has changed to DELETING or
> DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
> freeze, so nvme_remove_namespaces() hang.
> 
> static void nvme_tcp_error_recovery_work(struct work_struct *work)
> {
>         ...
>         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
>                 /* state change failure is ok if we started ctrl delete */
>                 WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
>                              ctrl->state != NVME_CTRL_DELETING_NOIO);
>                 return;
>         }
> 
>         nvme_tcp_reconnect_or_remove(ctrl);
> }
> 
> 
> Another path, we will check ctrl state while reconnecting, if it changes to
> DELETING or DELETING_NIO, we will break up and lease ctrl freeze and
> queue quiescing (through reset path), as a result Hang occurs.
> 
> static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> {
>         /* If we are resetting/deleting then do nothing */
>         if (ctrl->state != NVME_CTRL_CONNECTING) {
>                 WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
>                         ctrl->state == NVME_CTRL_LIVE);
>                 return;
>         }
>         ...
> }
> 
> > > freezed and queue is quiescing . Since scan_work may continue to issue IOs to
> > > load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
> > > hang in flush_work(&ctrl->scan_work).
> > >
> > > After analyzation, we found that there are mainly two case:
> > > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
> > >    new IO to load partition table.
> >
> > Yeah, nvme freeze usage is fragile, and I suggested to move
> > nvme_start_freeze() from nvme_tcp_teardown_io_queues to
> > nvme_tcp_configure_io_queues(), such as the posted change on rdma:
> >
> > https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0
> 
> While drive reconnecting, I think we should freeze ctrl or quiescing queue,
> otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
> and the IOs may retry frequently. So I think we may better freeze ctrl
> while entering
> error_recovery/reconnect, but need to unfreeze it while exit.

quiescing is always done in error handling, and freeze is actually
not a must, and it is easier to cause race by calling freeze & unfreeze
from different contexts.

But yes, unquiesce should have been done after exiting error handling, or
simply do it in nvme_unquiesce_io_queues().

And the following patch should cover all these hangs:


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ec38e2b9173..83d3818fc60b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4692,6 +4692,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/* unquiesce io queues so scan work won't hang */
+	nvme_unquiesce_io_queues(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
@@ -4701,10 +4704,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD) {
+	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_mark_namespaces_dead(ctrl);
-		nvme_unquiesce_io_queues(ctrl);
-	}
 
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf3..5d775b76baca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2578,14 +2578,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	dead = nvme_pci_ctrl_is_dead(dev);
 	if (dev->ctrl.state == NVME_CTRL_LIVE ||
 	    dev->ctrl.state == NVME_CTRL_RESETTING) {
-		if (pci_is_enabled(pdev))
-			nvme_start_freeze(&dev->ctrl);
 		/*
 		 * Give the controller a chance to complete all entered requests
 		 * if doing a safe shutdown.
 		 */
-		if (!dead && shutdown)
+		if (!dead && shutdown & pci_is_enabled(pdev)) {
+			nvme_start_freeze(&dev->ctrl);
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+			nvme_unfreeze(&dev->ctrl);
+		}
 	}
 
 	nvme_quiesce_io_queues(&dev->ctrl);
@@ -2740,6 +2741,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * controller around but remove all namespaces.
 	 */
 	if (dev->online_queues > 1) {
+		nvme_start_freeze(&dev->ctrl);
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
 		nvme_pci_update_nr_queues(dev);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..354cce8853c1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_tagset;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_unquiesce_io_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -975,7 +977,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..5ae08e9cb16d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1909,6 +1909,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1917,6 +1918,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -2021,7 +2023,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_quiesce_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);




Thanks
Ming

