Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CDB60C7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiJYJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiJYJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779FB164BE3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666689416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oq++8R+yG1tYmGpBo5Lz36iS61FkQn11vUhbczNKyoQ=;
        b=ZWf2NMNkgjBMyQH0YqyJpaehIznxWv6N6xYAtNxhRHB0SJhK6c/XYik3v2UMYJFZ2bO7Lq
        FN6AcSlFZYLoDZi1m9Zx2WU7UzbvAWfw0446cgfkMBzyLwfrDh852brioP+xzS+Feh7hEy
        TpK+xqFCIdvXFAo+Qt9cqT1V4d/6gkM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-VW3_SLqlNwOAqV77y8qO9w-1; Tue, 25 Oct 2022 05:16:53 -0400
X-MC-Unique: VW3_SLqlNwOAqV77y8qO9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC44F101A52A;
        Tue, 25 Oct 2022 09:16:52 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB87D2028E98;
        Tue, 25 Oct 2022 09:16:48 +0000 (UTC)
Date:   Tue, 25 Oct 2022 17:16:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
Message-ID: <Y1epeuwonmjQhrXW@T590>
References: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
 <Y1U9zNZtZjRHQBww@T590>
 <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
 <Y1aS3vIbuQTNGWJL@T590>
 <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
 <Y1cvJ4/uwUScAQq4@T590>
 <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
 <CAFj5m9JnSBBVGrp5CqeH99-+VOGRuroUAi3c-3=6XKa891Sfmw@mail.gmail.com>
 <cf7f8f88-7d3e-8818-8584-e2276e7a1f30@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7f8f88-7d3e-8818-8584-e2276e7a1f30@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:08:10AM +0100, John Garry wrote:
> On 25/10/2022 10:00, Ming Lei wrote:
> > > My use case is in SCSI EH domain. For my HBA controller of interest, to
> > > abort an erroneous IO we must send a controller proprietary abort
> > > command on same HW queue as original command. So we would need to
> > > allocate this abort request for a specific HW queue.
> > IMO, it is one bad hw/sw interface.
> > 
> > First such request has to be reserved, since all inflight IOs can be in error.
> 
> Right
> 
> > 
> > Second error handling needs to provide forward-progress, and it is supposed
> > to not require external dependency, otherwise easy to cause deadlock, but
> > here request from specific HW queue just depends on this queue's cpumask.
> > 
> > Also if it has to be reserved, it can be done as one device/driver private
> > command, so why bother blk-mq for this special use case?
> 
> I have a series for reserved request support, which I will send later.
> Please have a look. And as I mentioned, I would prob not end up using
> blk_mq_alloc_request_hctx() anyway.
> 
> > 
> > > I mentioned before that if no hctx->cpumask is online then we don't need
> > > to allocate a request. That is because if no hctx->cpumask is online,
> > > this means that original erroneous IO must be completed due to nature of
> > > how blk-mq cpu hotplug handler works, i.e. drained, and then we don't
> > > actually need to abort it any longer, so ok to not get a request.
> > No, it is really not OK, if all cpus in hctx->cpumask are offline, you
> > can't allocate
> > request on the specified hw queue, then the erroneous IO can't be handled,
> > then cpu hotplug handler may hang for ever.
> 
> If the erroneous IO is still in-flight from blk-mq perspective, then how can
> hctx->cpumask still be offline? I thought that we guarantee that
> hctx->cpumask cannot go offline until drained.

Yeah, the draining is done before the cpu is offline. But the drain is
simply waiting for the inflight IO to be completed. If the IO is failed
during the waiting, you can't allocate such reserved request for error
handling, then hang ever in blk_mq_hctx_notify_offline().

If you just make it one driver private command, there can't be such
issue. Block layer is supposed for handling common case(normal io and pt io),
I'd suggest to not put such special cases into block layer.

thanks,
Ming

