Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5341749CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGFNHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGFNHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:07:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF211986;
        Thu,  6 Jul 2023 06:07:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C60B767373; Thu,  6 Jul 2023 15:07:35 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:07:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 1/4] blk-mq: use percpu csd to remote complete
 instead of per-rq csd
Message-ID: <20230706130735.GA13089@lst.de>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev> <20230629110359.1111832-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629110359.1111832-2-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 07:03:56PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> If request need to be completed remotely, we insert it into percpu llist,
> and smp_call_function_single_async() if llist is empty previously.
> 
> We don't need to use per-rq csd, percpu csd is enough. And the size of
> struct request is decreased by 24 bytes.
> 
> This way is cleaner, and looks correct, given block softirq is guaranteed to be
> scheduled to consume the list if one new request is added to this percpu list,
> either smp_call_function_single_async() returns -EBUSY or 0.

Please trim your commit logs to 73 characters per line so that they
are readable in git log output.

>  static void blk_mq_request_bypass_insert(struct request *rq,
> @@ -1156,13 +1157,13 @@ static void blk_mq_complete_send_ipi(struct request *rq)
>  {
>  	struct llist_head *list;
>  	unsigned int cpu;
> +	call_single_data_t *csd;
>  
>  	cpu = rq->mq_ctx->cpu;
>  	list = &per_cpu(blk_cpu_done, cpu);
> -	if (llist_add(&rq->ipi_list, list)) {
> -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> -		smp_call_function_single_async(cpu, &rq->csd);
> -	}
> +	csd = &per_cpu(blk_cpu_csd, cpu);
> +	if (llist_add(&rq->ipi_list, list))
> +		smp_call_function_single_async(cpu, csd);
>  }

No need for the list and csd variables here as they are only used
once.

But I think this code has a rpboem when it is preemptd between
the llist_add and smp_call_function_single_async.  We either need a
get_cpu/put_cpu around them, or instroduce a structure with the list
and csd, and then you can use one pointer from per_cpu and still ensure
the list and csd are for the same CPU.

