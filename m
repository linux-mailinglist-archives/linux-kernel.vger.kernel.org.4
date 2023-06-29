Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7796474209D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjF2GqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjF2GpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:45:11 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B96630F1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:42:33 -0700 (PDT)
Message-ID: <9ad5f93f-b566-03ec-dba4-1f7777489e29@linux.dev>
Date:   Thu, 29 Jun 2023 14:42:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        ming.lei@redhat.com
References: <20230628124546.1056698-1-chengming.zhou@linux.dev>
 <20230628124546.1056698-4-chengming.zhou@linux.dev>
 <20230629053201.GF16819@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230629053201.GF16819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/29 13:32, Christoph Hellwig wrote:
>> +/* Set rq alloc and start time when pre-allocated rq is actually used */
>> +static inline void blk_mq_rq_time_init(struct request_queue *q, struct request *rq)
>> +{
>> +	if (blk_mq_need_time_stamp(rq->rq_flags)) {
>> +		u64 now = ktime_get_ns();
>> +
>> +#ifdef CONFIG_BLK_RQ_ALLOC_TIME
>> +		/*
>> +		 * alloc time is only used by iocost for now,
>> +		 * only possible when blk_mq_need_time_stamp().
>> +		 */
>> +		if (blk_queue_rq_alloc_time(q))
>> +			rq->alloc_time_ns = now;
>> +#endif
>> +		rq->start_time_ns = now;
>> +	}
>> +}
> 
> No need to pass q separately here, you can just use rq->q.
> 
> While you're at it please capitalize the first letter of block comments.
> 

Ok, I will use rq->q and fix the comments in the next version.

Thanks.

