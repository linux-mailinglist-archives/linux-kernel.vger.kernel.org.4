Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8643360BB49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiJXUyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiJXUxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DBECD5E2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666637946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XUHdkSLn+zhCa5Ke4jI7G05nTKX0wDN8DWn8u2XkaU=;
        b=Lq/um5jFP98TcU6h9Kfn/1VlNap80wXJmAlPOQ9+DR7uiFJnIAYWXuYtF26FlUCqQoDy0V
        s5xI5u3XuBJ6I7SzLiUoX6amALsx6Tyke+9aDGhbZNDMQw/O6mcYj3LtYdQamiJ0Bts1uc
        uslxFY1posNUgCVQe1VrwAauJLMma7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-flVGeN7_MmKKO8sLFuo3nw-1; Mon, 24 Oct 2022 09:28:10 -0400
X-MC-Unique: flVGeN7_MmKKO8sLFuo3nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 607CA8027EB;
        Mon, 24 Oct 2022 13:28:09 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9C262166B35;
        Mon, 24 Oct 2022 13:28:03 +0000 (UTC)
Date:   Mon, 24 Oct 2022 21:27:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
Message-ID: <Y1aS3vIbuQTNGWJL@T590>
References: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
 <Y1U9zNZtZjRHQBww@T590>
 <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:56:21AM +0100, John Garry wrote:
> On 23/10/2022 14:12, Ming Lei wrote:
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 8070b6c10e8d..260adeb2e455 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -402,6 +402,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
> > >   		}
> > >   	}
> > > +	rq->__data_len = 0;
> > > +	rq->__sector = (sector_t) -1;
> > > +	rq->bio = rq->biotail = NULL;
> > > +
> > >   	return rq;
> > >   }
> > > @@ -591,9 +595,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
> > >   		if (!rq)
> > >   			goto out_queue_exit;
> > >   	}
> > > -	rq->__data_len = 0;
> > > -	rq->__sector = (sector_t) -1;
> > > -	rq->bio = rq->biotail = NULL;
> > This patch looks not good, why do you switch to initialize the three fields
> > twice in fast path?
> 
> Can you please show me how these are initialized twice?

blk_mq_bio_to_request() is one which setup these fields, then you add
another one in blk_mq_rq_ctx_init().

> 
> If there is a real concern with this then we go with my original idea, which
> was to copy the init method of blk_mq_alloc_request() (in
> blk_mq_alloc_request_hctx())
> 
> > 
> > BTW, we know blk_mq_alloc_request_hctx() has big trouble, so please
> > avoid to extend it to other use cases.
> 
> Yeah, I know this,

Did you know the exact issue on nvme-tcp, nvme-rdma or nvme-fc maybe
with blk_mq_alloc_request_hctx()?

> but sometimes we just need to allocate for a specific HW
> queue...
> 
> For my usecase of interest, it should not impact if the cpumask of the HW
> queue goes offline after selecting the cpu in blk_mq_alloc_request_hctx(),
> so any race is ok ... I think.
> 
> However it should be still possible to make blk_mq_alloc_request_hctx() more
> robust. How about using something like work_on_cpu_safe() to allocate and
> execute the request with blk_mq_alloc_request() on a cpu associated with the
> HW queue, such that we know the cpu is online and stays online until we
> execute it? Or also extent to work_on_cpumask_safe() variant, so that we
> don't need to try all cpus in the mask (to see if online)?

But all cpus on this hctx->cpumask could become offline.


Thanks,
Ming

