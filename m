Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21D25BCC04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiISMkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiISMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E7632A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663591183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7pheDU3szOAwwbK9OaACzET2BRlTQOVXynwN58u5LXI=;
        b=NJHktj0BS1ygSJdGFWPDsRcDMrl7y/MaN3Hf8SnvKVJ0hAg6DuoiUz1KxDnYxDnTaZpXPT
        3SSkvxJhHnMz1kC08mjTAkC7FuTw/XXCH60vXed46QbSDvPPdngL6WI6tAPggjxw27OCU7
        Z1ywZiGbuoFOdOJGujBLJ6Qz/jNObT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-8b79cf2cOZ6tLOl4h0tvKA-1; Mon, 19 Sep 2022 08:39:37 -0400
X-MC-Unique: 8b79cf2cOZ6tLOl4h0tvKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4B5485A59D;
        Mon, 19 Sep 2022 12:39:36 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A0EF40C2064;
        Mon, 19 Sep 2022 12:39:31 +0000 (UTC)
Date:   Mon, 19 Sep 2022 20:39:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [PATCH V3 4/7] ublk_drv: requeue rqs with recovery feature
 enabled
Message-ID: <Yyhi/kavaq1aLAQY@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
 <YyfoQuw18kOynxcC@T590>
 <ff61718d-da2d-f754-5e56-b58a3e57820f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff61718d-da2d-f754-5e56-b58a3e57820f@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 05:12:21PM +0800, Ziyang Zhang wrote:
> On 2022/9/19 11:55, Ming Lei wrote:
> > On Tue, Sep 13, 2022 at 12:17:04PM +0800, ZiyangZhang wrote:
> >> With recovery feature enabled, in ublk_queue_rq or task work
> >> (in exit_task_work or fallback wq), we requeue rqs instead of
> >> ending(aborting) them. Besides, No matter recovery feature is enabled
> >> or disabled, we schedule monitor_work immediately.
> >>
> >> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> >> ---
> >>  drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++--
> >>  1 file changed, 32 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >> index 23337bd7c105..b067f33a1913 100644
> >> --- a/drivers/block/ublk_drv.c
> >> +++ b/drivers/block/ublk_drv.c
> >> @@ -682,6 +682,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
> >>  
> >>  #define UBLK_REQUEUE_DELAY_MS	3
> >>  
> >> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
> >> +		struct request *rq)
> >> +{
> >> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
> >> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
> >> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
> >> +	/* We cannot process this rq so just requeue it. */
> >> +	if (ublk_queue_can_use_recovery(ubq)) {
> >> +		blk_mq_requeue_request(rq, false);
> >> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);
> > 
> > Here you needn't to kick requeue list since we know it can't make
> > progress. And you can do that once before deleting gendisk
> > or the queue is recovered.
> 
> No, kicking rq here is necessary.
> 
> Consider USER_RECOVERY is enabled and everything goes well.
> User sends STOP_DEV, and we have kicked requeue list in
> ublk_stop_dev() and are going to call del_gendisk().
> However, a crash happens now. Then rqs may be still requeued
> by ublk_queue_rq() because ublk_queue_rq() sees a dying
> ubq_daemon. So del_gendisk() will hang because there are
> rqs leaving in requeue list and no one kicks them.

Why can't you kick requeue list before calling del_gendisk().

> 
> BTW, kicking requeue list after requeue rqs is really harmless
> since we schedule quiesce_work immediately after finding a
> dying ubq_daemon. So few rqs have chance to be re-dispatched.

Do you think it makes sense to kick requeue list when the queue
can't handle any request?


Thanks,
Ming

