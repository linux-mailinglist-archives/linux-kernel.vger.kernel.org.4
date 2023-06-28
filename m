Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AED740C25
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjF1JBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233081AbjF1IxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687942321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mr4UHt+/RbSvUJAMDZepZ17hHPabLIHQ8DU05mT//V0=;
        b=PwRci8ElvbWmo2P7jGTXtqyvibbEaiohNFQ5BKL1ht6VOBN6ZXF5I1lyh1ooyl4AcDC3xc
        iDSXUFMJ5JtfEBFkt7/6Galtmgmgtt7vXFbAnog9HAtCXVxgucAqB5CxbCcu7Xz/c3lW+u
        wyIkAcbsXwr1DyMAeUahw5p/Rblx6Dc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-sYkB_o7oPfOkH5IYyEF-iA-1; Wed, 28 Jun 2023 00:50:31 -0400
X-MC-Unique: sYkB_o7oPfOkH5IYyEF-iA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B35C41C07557;
        Wed, 28 Jun 2023 04:50:30 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F9E340C2063;
        Wed, 28 Jun 2023 04:50:25 +0000 (UTC)
Date:   Wed, 28 Jun 2023 12:50:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 1/4] blk-mq: use percpu csd to remote complete instead of
 per-rq csd
Message-ID: <ZJu8DQgug3/UjpUJ@ovpn-8-21.pek2.redhat.com>
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
 <20230627120854.971475-2-chengming.zhou@linux.dev>
 <ZJuY0OZu42H0oBa7@ovpn-8-21.pek2.redhat.com>
 <9c038fe8-0361-c6fb-9b4e-7b74e0591ae9@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c038fe8-0361-c6fb-9b4e-7b74e0591ae9@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:28:20AM +0800, Chengming Zhou wrote:
> On 2023/6/28 10:20, Ming Lei wrote:
> > On Tue, Jun 27, 2023 at 08:08:51PM +0800, chengming.zhou@linux.dev wrote:
> >> From: Chengming Zhou <zhouchengming@bytedance.com>
> >>
> >> If request need to be completed remotely, we insert it into percpu llist,
> >> and smp_call_function_single_async() if llist is empty previously.
> >>
> >> We don't need to use per-rq csd, percpu csd is enough. And the size of
> >> struct request is decreased by 24 bytes.
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> ---
> >>  block/blk-mq.c         | 12 ++++++++----
> >>  include/linux/blk-mq.h |  5 +----
> >>  2 files changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index decb6ab2d508..a36822479b94 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -43,6 +43,7 @@
> >>  #include "blk-ioprio.h"
> >>  
> >>  static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
> >> +static DEFINE_PER_CPU(struct __call_single_data, blk_cpu_csd);
> > 
> > It might be better to use call_single_data, given:
> > 
> > /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
> >   typedef struct __call_single_data call_single_data_t
> >   	__aligned(sizeof(struct __call_single_data));
> > 
> 
> Good, I will change to use this.
> 
> >>  
> >>  static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
> >>  static void blk_mq_request_bypass_insert(struct request *rq,
> >> @@ -1156,13 +1157,13 @@ static void blk_mq_complete_send_ipi(struct request *rq)
> >>  {
> >>  	struct llist_head *list;
> >>  	unsigned int cpu;
> >> +	struct __call_single_data *csd;
> >>  
> >>  	cpu = rq->mq_ctx->cpu;
> >>  	list = &per_cpu(blk_cpu_done, cpu);
> >> -	if (llist_add(&rq->ipi_list, list)) {
> >> -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> >> -		smp_call_function_single_async(cpu, &rq->csd);
> >> -	}
> >> +	csd = &per_cpu(blk_cpu_csd, cpu);
> >> +	if (llist_add(&rq->ipi_list, list))
> >> +		smp_call_function_single_async(cpu, csd);
> >>  }
> > 
> > This way is cleaner, and looks correct, given block softirq is guaranteed to be
> > scheduled to consume the list if one new request is added to this percpu list,
> > either smp_call_function_single_async() returns -EBUSY or 0.
> > 
> 
> If this llist_add() see the llist is empty, the consumer function in the softirq
> on the remote CPU must have consumed the llist, so smp_call_function_single_async()
> won't return -EBUSY ?

block softirq can be scheduled from other code path, such as blk_mq_raise_softirq()
for single queue's remote completion, where no percpu csd schedule is needed, so
two smp_call_function_single_async() could be called, and the 2nd one
may return -EBUSY.

Not mention csd_unlock() could be called after the callback returns, see
__flush_smp_call_function_queue().

But that is fine, if there is pending block softirq, the llist is
guaranteed to be consumed because the csd callback just raises block
softirq, and request/llist is consumed in softirq handler.

Thanks,
Ming

