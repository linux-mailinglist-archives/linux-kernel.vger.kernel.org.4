Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5015BDBCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiITEtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiITEtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0BB5757C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663649356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwdSkv0sWoOjtp387EHQdNyYtM07L5RAmGXXTLqT48E=;
        b=S3h4gqaPrSwreemXTj8WEgNhlPEUZGsz4TFdasnVbkw/nNgrzwd0AKfc2/APIotiaBNtqv
        47nZEkteQ0CCPSFIATotg77MuxtsFtBAanO2LLio5m0TgLmZOzYSXIPLwIJdLxTWrY1xFN
        QyqHJTR5TJZHyI0bU8d/8zhBKmTXugY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-iCwgt507PWiyC0fi5fl-qQ-1; Tue, 20 Sep 2022 00:49:13 -0400
X-MC-Unique: iCwgt507PWiyC0fi5fl-qQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9063B85A5B6;
        Tue, 20 Sep 2022 04:49:12 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24DF4201F402;
        Tue, 20 Sep 2022 04:49:06 +0000 (UTC)
Date:   Tue, 20 Sep 2022 12:49:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V3 5/7] ublk_drv: consider recovery feature in aborting
 mechanism
Message-ID: <YylGPHg+hvY8f9+U@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-6-ZiyangZhang@linux.alibaba.com>
 <Yyg3KLfQaxbS1miq@T590>
 <9a682fac-f022-1f4d-5c2c-e1f0a84746d8@linux.alibaba.com>
 <YyhhnbrHTJpW4Xcm@T590>
 <dbc78e92-ede7-fc63-1bee-83794bf1e33b@linux.alibaba.com>
 <Yyktx/xz0qTNxnT4@T590>
 <64492fad-e14a-c647-b490-cd1f53a475a8@linux.alibaba.com>
 <Yyk7LnH9lj303DTj@T590>
 <5af80188-c904-635a-242e-4bb1cd7f2e01@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af80188-c904-635a-242e-4bb1cd7f2e01@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:39:31PM +0800, Ziyang Zhang wrote:
> On 2022/9/20 12:01, Ming Lei wrote:
> > On Tue, Sep 20, 2022 at 11:24:12AM +0800, Ziyang Zhang wrote:
> >> On 2022/9/20 11:04, Ming Lei wrote:
> >>> On Tue, Sep 20, 2022 at 09:49:33AM +0800, Ziyang Zhang wrote:
> >>>
> >>> Follows the delta patch against patch 5 for showing the idea:
> >>>
> >>>
> >>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >>> index 4409a130d0b6..60c5786c4711 100644
> >>> --- a/drivers/block/ublk_drv.c
> >>> +++ b/drivers/block/ublk_drv.c
> >>> @@ -656,7 +656,8 @@ static void ublk_complete_rq(struct request *req)
> >>>   * Also aborting may not be started yet, keep in mind that one failed
> >>>   * request may be issued by block layer again.
> >>>   */
> >>> -static void __ublk_fail_req(struct ublk_io *io, struct request *req)
> >>> +static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
> >>> +		struct request *req)
> >>>  {
> >>>  	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> >>>  
> >>> @@ -667,7 +668,10 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
> >>>  				req->tag,
> >>>  				io->flags);
> >>>  		io->flags |= UBLK_IO_FLAG_ABORTED;
> >>> -		blk_mq_end_request(req, BLK_STS_IOERR);
> >>> +		if (ublk_queue_can_use_recovery_reissue(ubq))
> >>> +			blk_mq_requeue_request(req, false);
> >>
> >> Here is one problem:
> >> We reset io->flags to 0 in ublk_queue_reinit() and it is called before new
> > 
> > As we agreed, ublk_queue_reinit() will be moved to ublk_ch_release(), when there isn't
> > any inflight request, which is completed by either ublk server or __ublk_fail_req().
> > 
> > So clearing io->flags isn't related with quisceing device.
> > 
> >> ubq_daemon with FETCH_REQ is accepted. ublk_abort_queue() is not protected with
> >> ub_mutex and it is called many times in monitor_work. So same rq may be requeued
> >> multiple times.
> > 
> > UBLK_IO_FLAG_ABORTED is set for the slot, so one req is only ended or
> > requeued just once.
> 
> Yes, we can move ublk_queue_reinit() into ublk_ch_release(), but monitor_work is scheduled
> periodically so ublk_abort_queue() is called multiple times. As ublk_queue_reinit() clear
> io->flags, ublk_abort_queue() can requeue the same rq twice. Note that monitor_work can be
> scheduled after ublk_ch_release().

No, monitor work is supposed to be shutdown after in-flight requests are
drained.

>  
> > 
> >>
> >> With recovery disabled, there is no such problem since io->flags does not change
> >> until ublk_dev is released.
> > 
> > But we have agreed that ublk_queue_reinit() can be moved to release
> > handler of /dev/ublkcN.
> > 
> >>
> >> In my patch 5 I only requeue the same rq once. So re-using ublk_abort_queue() is
> >> hard for recovery feature.
> > 
> > No, the same rq is just requeued once. Here the point is:
> > 
> > 1) reuse previous pattern in ublk_stop_dev(), which is proved as
> > workable reliably
> > 
> > 2) avoid to stay in half-working state forever
> > 
> > 3) the behind idea is more simpler.
> 
> Ming, your patch requeue rqs with ACTVE unset. these rqs have been issued to the
> dying ubq_daemon. What I concern about is inflight rqs with ACTIVE set.

My patch drains all inflight requests no matter if ACTIVE is set or not,
and that is the reason why it is simpler.

Thanks,
Ming

