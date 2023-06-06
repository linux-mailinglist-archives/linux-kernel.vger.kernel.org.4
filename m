Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D3723F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjFFKXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjFFKWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:22:46 -0400
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [IPv6:2001:41d0:203:375::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3757210C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:22:45 -0700 (PDT)
Message-ID: <c82d6bab-36d0-0403-9304-4415f6ffd972@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686046961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFk0zdNlKOCUf25Ig5Wq1urmJN+0zpOyY9aDUoSpYr0=;
        b=gPy6Td94BVZ7oznWfnLp9FzPJbWp7ePOqDC6PbqskvRb1S+ZzMXui4UnpXFrpIqOXrEmFM
        0QDCauz0o7TwRBB04YchcW/fvoTNradxOEB76quiU/hqJM402LazsfT4azN6uyTV+UQgcV
        dDaLXME8iQ5ozJm4fsyda9J+O0RSg0A=
Date:   Tue, 6 Jun 2023 18:22:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] blk-mq: fix incorrect rq start_time_ns and alloc_time_ns
 after throttled
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230601053919.3639954-1-chengming.zhou@linux.dev>
 <ZH4p8tqFc57_OYoH@slm.duckdns.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZH4p8tqFc57_OYoH@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/6 02:31, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jun 01, 2023 at 01:39:19PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> iocost rely on rq start_time_ns and alloc_time_ns to tell the saturation
>> state of the block device.
>>
>> If any qos ->throttle() end up blocking, the cached rq start_time_ns and
>> alloc_time_ns will include its throtted time, which can confuse its user.
> 
> I don't follow. rq_qos_throttle() happens before a request is allocated, so
> whether ->throttle() blocks or not doesn't affect alloc_time_ns or
> start_time_ns.
Yes, most of the time request is allocated after rq_qos_throttle() and its
alloc_time_ns or start_time_ns won't be affected clearly.

But for plug batched allocation introduced by the commit 47c122e35d7e
("block: pre-allocate requests if plug is started and is a batch"), we can
rq_qos_throttle() after the allocation of the request. This is what the
blk_mq_get_cached_request() does.

In this case, the cached request alloc_time_ns or start_time_ns is much ahead
if block in any qos ->throttle().

> 
>> This patch add nr_flush counter in blk_plug, so we can tell if the task
>> has throttled in any qos ->throttle(), in which case we need to correct
>> the rq start_time_ns and alloc_time_ns.
>>
>> Another solution may be make rq_qos_throttle() return bool to indicate
>> if it has throttled in any qos ->throttle(). But this need more changes.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Depending on the flush behavior and adjusting alloc_time_ns seems fragile to
> me and will likely confuse other users of alloc_time_ns too.

I agree with you, this code is not good. My basic idea is to adjust the cached
request alloc_time_ns and start_time_ns when throttled.

> 
> Maybe I'm misunderstanding the problem you're describing. Can you give a
> concrete example of how the current code would misbehave?
> 

I tried using fio to reproduce it:

1. set the iocost qos (a bit strict qos setting to reproduce throttle)

echo "259:0 enable=1 rpct=5 rlat=500 wpct=5 wlat=500" > io.cost.qos

2. run fio using io_uring ioengine (for now only io_uring used batched allocation)

fio --name global --runtime 30 --time_based --size 10G --ioengine io_uring \
--iodepth 256 --buffered 0 --sqthread_poll \
--name job1 --rw read --cgroup job1 --numjobs 10 \
--name job2 --rw write --cgroup job2 --numjobs 10

3. run bpftrace to check request start_time_ns

bpftrace -e 'kprobe:__rq_qos_track { $rq = (struct request *)arg1; if ($rq->start_time_ns) { @delta = hist((nsecs - $rq->start_time_ns)/1000); } }'


If we go blk_mq_get_cached_request() -> throttle() and throttled for some time,
then the returned cached request start_time_ns will be much ahead.

Like below: (delta value is us)

@delta:
[0]               170090 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                  898 |                                                    |
[2, 4)               418 |                                                    |
[4, 8)               284 |                                                    |
[8, 16)               54 |                                                    |
[16, 32)             198 |                                                    |
[32, 64)            5416 |@                                                   |
[64, 128)           5082 |@                                                   |
[128, 256)          1296 |                                                    |
[256, 512)            23 |                                                    |
[512, 1K)           2632 |                                                    |
[1K, 2K)           21143 |@@@@@@                                              |
[2K, 4K)           26349 |@@@@@@@@                                            |
[4K, 8K)            4559 |@                                                   |
[8K, 16K)           4273 |@                                                   |
[16K, 32K)            14 |                                                    |

