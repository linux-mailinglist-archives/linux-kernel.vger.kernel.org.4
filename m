Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6060CACD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJYLVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiJYLVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE5123465
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666696905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BaqceJ7rtioV7Hk4RXPbSv2vv4HBnmL/vQtFf809lKU=;
        b=GDjIR4ei8BLDmU6YvcXvpnxUMxwydLlbPyJKH9QsoX8/TakwOFXpjwoB3PvRbVFPSPOk5w
        dC5mEEQ7Tr8NOiGeK74rPCcSGo+x4xw4fAB3NDfbjFh4LwaSaO1nWlbOD1za+OlUYPv7jM
        Yuprbt+SgDF9V/o0XmWw9HnIi70idaw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-MDje6bPONCib0KQ6WMl_Bw-1; Tue, 25 Oct 2022 07:21:31 -0400
X-MC-Unique: MDje6bPONCib0KQ6WMl_Bw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 576E5811E75;
        Tue, 25 Oct 2022 11:21:30 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70E2C492B0A;
        Tue, 25 Oct 2022 11:21:23 +0000 (UTC)
Date:   Tue, 25 Oct 2022 19:21:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
Message-ID: <Y1fGrfHqbha6l+hz@T590>
References: <Y1U9zNZtZjRHQBww@T590>
 <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
 <Y1aS3vIbuQTNGWJL@T590>
 <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
 <Y1cvJ4/uwUScAQq4@T590>
 <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
 <CAFj5m9JnSBBVGrp5CqeH99-+VOGRuroUAi3c-3=6XKa891Sfmw@mail.gmail.com>
 <cf7f8f88-7d3e-8818-8584-e2276e7a1f30@huawei.com>
 <Y1epeuwonmjQhrXW@T590>
 <399a2c2d-0b56-e4e7-c309-a6b9537d8939@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399a2c2d-0b56-e4e7-c309-a6b9537d8939@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:32:28AM +0100, John Garry wrote:
> On 25/10/2022 10:16, Ming Lei wrote:
> > > > > I mentioned before that if no hctx->cpumask is online then we don't need
> > > > > to allocate a request. That is because if no hctx->cpumask is online,
> > > > > this means that original erroneous IO must be completed due to nature of
> > > > > how blk-mq cpu hotplug handler works, i.e. drained, and then we don't
> > > > > actually need to abort it any longer, so ok to not get a request.
> > > > No, it is really not OK, if all cpus in hctx->cpumask are offline, you
> > > > can't allocate
> > > > request on the specified hw queue, then the erroneous IO can't be handled,
> > > > then cpu hotplug handler may hang for ever.
> > > If the erroneous IO is still in-flight from blk-mq perspective, then how can
> > > hctx->cpumask still be offline? I thought that we guarantee that
> > > hctx->cpumask cannot go offline until drained.
> > Yeah, the draining is done before the cpu is offline. But the drain is
> > simply waiting for the inflight IO to be completed. If the IO is failed
> > during the waiting, you can't allocate such reserved request for error
> > handling, then hang ever in blk_mq_hctx_notify_offline().
> 
> Actually if final cpu in hctx->cpumask is going offline, then hctx won't
> queue any more requests, right? In this case I don't think we can queue on
> that hctx anyway. I need to think about this more.

It can be queued actually, but interrupt may not be delivered if managed
irq is used.

> 
> > 
> > If you just make it one driver private command, there can't be such
> > issue.
> 
> Well we're trying to use reserved requests for EH commands, which that goes
> against.
> 
> > Block layer is supposed for handling common case(normal io and pt io),
> > I'd suggest to not put such special cases into block layer.
> 
> It also supports reserved commands, which I would assume would be suitable
> for EH scenarios.

Then you have to be careful, as I mentioned, EH has to provide forward
progress, if you let blk-mq allocate & submit EH request, the implied
dependency from blk-mq has to be payed attention.


Thanks,
Ming

