Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA6260C0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJYBRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiJYBQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A74F3B5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666658105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGsqal3yawtP1okvtIaH5vVGgtlRu2D64gOPqImXnSU=;
        b=MJvShSz2BXcgU/N4W4mUSnRyPy/QU94wmH3tzYlk2BX7KKZmmfr8yWbH8rxNAwv53beSIy
        mxqxutpc30Wy0I4P+UlKhdPIUzUwghV+oCXUcNMTBl7GKq0guYFgyXksckIBWdTCVFji87
        iWF3BQqEY+fC4zDSNX/6mLJnpMoCn0c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-neb12vkCOBCxQ9aH5www-w-1; Mon, 24 Oct 2022 20:35:04 -0400
X-MC-Unique: neb12vkCOBCxQ9aH5www-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EED93C0D188;
        Tue, 25 Oct 2022 00:35:03 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E94740C6E16;
        Tue, 25 Oct 2022 00:34:54 +0000 (UTC)
Date:   Tue, 25 Oct 2022 08:34:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
Message-ID: <Y1cvJ4/uwUScAQq4@T590>
References: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
 <Y1U9zNZtZjRHQBww@T590>
 <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
 <Y1aS3vIbuQTNGWJL@T590>
 <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 05:56:15PM +0100, John Garry wrote:
> On 24/10/2022 14:27, Ming Lei wrote:
> > > > > -	rq->bio = rq->biotail = NULL;
> > > > This patch looks not good, why do you switch to initialize the three fields
> > > > twice in fast path?
> > > Can you please show me how these are initialized twice?
> > blk_mq_bio_to_request() is one which setup these fields, then you add
> > another one in blk_mq_rq_ctx_init().
> 
> ok, understood.
> 
> > 
> > > If there is a real concern with this then we go with my original idea, which
> > > was to copy the init method of blk_mq_alloc_request() (in
> > > blk_mq_alloc_request_hctx())
> > > 
> > > > BTW, we know blk_mq_alloc_request_hctx() has big trouble, so please
> > > > avoid to extend it to other use cases.
> > > Yeah, I know this,
> > Did you know the exact issue on nvme-tcp, nvme-rdma or nvme-fc maybe
> > with blk_mq_alloc_request_hctx()?
> 
> I thought that the original issue was an OoO bounds issue, fixed in
> 14dc7a18. Now there is still some issue in the following link, which is
> still unresolved as I understand:
> https://lore.kernel.org/linux-block/5bd886f1-a7c6-b765-da29-777be0328bc2@grimberg.me/#t
> 
> But I think that 14dc7a18 may still leave undesirable scenario:
> - all cpus in HW queue cpumask may go offline after cpu_online_mask read in
> blk_mq_alloc_request_hctx() and before we get the driver tag and set
> rq->hctx

Yeah.

> 
> > 
> > > but sometimes we just need to allocate for a specific HW
> > > queue...
> > > 
> > > For my usecase of interest, it should not impact if the cpumask of the HW
> > > queue goes offline after selecting the cpu in blk_mq_alloc_request_hctx(),
> > > so any race is ok ... I think.
> > > 
> > > However it should be still possible to make blk_mq_alloc_request_hctx() more
> > > robust. How about using something like work_on_cpu_safe() to allocate and
> > > execute the request with blk_mq_alloc_request() on a cpu associated with the
> > > HW queue, such that we know the cpu is online and stays online until we
> > > execute it? Or also extent to work_on_cpumask_safe() variant, so that we
> > > don't need to try all cpus in the mask (to see if online)?
> > But all cpus on this hctx->cpumask could become offline.
> 
> If all hctx->cpumask are offline then we should not allocate a request and
> this is acceptable. Maybe I am missing your point.

As you saw, this API has the above problem too, but any one of CPUs
may become online later, maybe just during blk_mq_alloc_request_hctx(),
and it is easy to cause inconsistence.

You didn't share your use case, but for nvme connection request, if it
is 1:1 mapping, if any one of CPU becomes offline, the controller
initialization could be failed, that isn't good from user viewpoint at
all.


Thanks,
Ming

