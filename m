Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860357411D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF1M5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:57:32 -0400
Received: from out-27.mta1.migadu.com ([95.215.58.27]:54859 "EHLO
        out-27.mta1.migadu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjF1M4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:56:00 -0400
Message-ID: <d53c9aa4-84c5-a7be-76fe-cde80da1749f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687956959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2T8W8o0K5DGJb97RUC5TjsMkkgzorpjMD0zx6EXUAk=;
        b=wTH7p1w7IsCMPIr7lbDes2EzF4lhh6rgDzSMMz9aLRcEPE6JyOZcp/I/EKfi5Qve56xviS
        ajVfOD+n/WvKEYnedxvWjAMtWK35w67FuZPY2QP8Vr6zyjrV+Qj0jDsE/O4RSk0anzfq11
        68uyhupQc8qKm75uOFbyepZ2ls90c0w=
Date:   Wed, 28 Jun 2023 20:55:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] blk-flush: count inflight flush_data requests
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
 <20230627120854.971475-3-chengming.zhou@linux.dev>
 <ZJuzYMeVhP5cthbC@ovpn-8-21.pek2.redhat.com>
 <490fd0d8-c0b3-cc26-c658-da35d52b6b56@linux.dev>
 <ZJvfr345L9krt371@ovpn-8-21.pek2.redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZJvfr345L9krt371@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 15:22, Ming Lei wrote:
> On Wed, Jun 28, 2023 at 12:55:49PM +0800, Chengming Zhou wrote:
>> On 2023/6/28 12:13, Ming Lei wrote:
>>> On Tue, Jun 27, 2023 at 08:08:52PM +0800, chengming.zhou@linux.dev wrote:
>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>
>>>> The flush state machine use a double list to link all inflight
>>>> flush_data requests, to avoid issuing separate post-flushes for
>>>> these flush_data requests which shared PREFLUSH.
>>>>
>>>> So we can't reuse rq->queuelist, this is why we need rq->flush.list
>>>>
>>>> In preparation of the next patch that reuse rq->queuelist for flush
>>>> state machine, we change the double linked list to a u64 counter,
>>>> which count all inflight flush_data requests.
>>>>
>>>> This is ok since we only need to know if there is any inflight
>>>> flush_data request, so a u64 counter is good. The only problem I can
>>>> think of is that u64 counter may overflow, which should be unlikely happen.
>>>
>>> It won't overflow, q->nr_requests is 'unsigned long', which should have
>>> been limited to one more reasonable value, such as 2 * BLK_MQ_MAX_DEPTH, so
>>> u16 should be big enough in theory.
>>
>> Ah, right. q->nr_requests is 'unsigned long' and q->queue_depth is 'unsigned int',
>> so 'unsigned long' counter here won't overflow.
> 
> Not like q->nr_requests, q->queue_depth usually means the whole queue's depth,
> which may cover all hw queue's depth. And it is only used by scsi, but it
> should be held in "unsigned short" too.
> 
>>
>> Should I change it to smaller 'unsigned short' or just leave it as 'unsigned long' ?
>> (Now the size of struct blk_flush_queue is exactly 64 bytes)
> 
> You have to limit q->nr_requests first, which may need a bit more work for avoiding
> compiling warning or sort of thing. And 64k is big enough for holding per-queue
> scheduler request.
> 
> Once it is done, it is fine to define this counter as 'unsigned short'.
> 

Ok, I looked around these related code, found it maybe subtle to me for now.
So I'd better just leave it 'unsigned long' here. :)

Thanks.

