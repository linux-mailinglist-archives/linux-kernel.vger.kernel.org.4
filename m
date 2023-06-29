Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96189741FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjF2FcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjF2FcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:32:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B129C1BE8;
        Wed, 28 Jun 2023 22:32:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2102F67373; Thu, 29 Jun 2023 07:32:02 +0200 (CEST)
Date:   Thu, 29 Jun 2023 07:32:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH v3 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <20230629053201.GF16819@lst.de>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev> <20230628124546.1056698-4-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124546.1056698-4-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Set rq alloc and start time when pre-allocated rq is actually used */
> +static inline void blk_mq_rq_time_init(struct request_queue *q, struct request *rq)
> +{
> +	if (blk_mq_need_time_stamp(rq->rq_flags)) {
> +		u64 now = ktime_get_ns();
> +
> +#ifdef CONFIG_BLK_RQ_ALLOC_TIME
> +		/*
> +		 * alloc time is only used by iocost for now,
> +		 * only possible when blk_mq_need_time_stamp().
> +		 */
> +		if (blk_queue_rq_alloc_time(q))
> +			rq->alloc_time_ns = now;
> +#endif
> +		rq->start_time_ns = now;
> +	}
> +}

No need to pass q separately here, you can just use rq->q.

While you're at it please capitalize the first letter of block comments.

