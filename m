Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43DE73CB91
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjFXPYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFXPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:24:34 -0400
Received: from out-4.mta1.migadu.com (out-4.mta1.migadu.com [IPv6:2001:41d0:203:375::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FB81987
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 08:24:33 -0700 (PDT)
Message-ID: <70ade937-1f94-52a3-7add-b43d3b79e471@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687620269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L847Z/bfhdpzZCa7enwUjky+WHNRgKn/tnqWKrdAgwg=;
        b=ZBtcsnr7Gxhz9QxbSy4XAeGU/NKIsReDYjrRoLYMn/1nb+CmQYH/V/j0GK6kLMBb+ZeGka
        b+TVV6plYkNj6pmz3X3uG8GErqiU2WSVALvNU/SIUE7/+cd2u72uZ5U293j2tQ8Ko6d6vE
        apoxccqIOZK337h0cjTV6F0LlA3CbzE=
Date:   Sat, 24 Jun 2023 23:24:04 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] blk-mq: fix incorrect rq start_time_ns and alloc_time_ns
 after throttled
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230601053919.3639954-1-chengming.zhou@linux.dev>
 <ZH4p8tqFc57_OYoH@slm.duckdns.org>
 <c82d6bab-36d0-0403-9304-4415f6ffd972@linux.dev>
 <ZIJco7_jaVaxpxSR@slm.duckdns.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZIJco7_jaVaxpxSR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/6/9 06:56, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 06, 2023 at 06:22:28PM +0800, Chengming Zhou wrote:
> ...
>> But for plug batched allocation introduced by the commit 47c122e35d7e
>> ("block: pre-allocate requests if plug is started and is a batch"), we can
>> rq_qos_throttle() after the allocation of the request. This is what the
>> blk_mq_get_cached_request() does.
>>
>> In this case, the cached request alloc_time_ns or start_time_ns is much ahead
>> if block in any qos ->throttle().
> 
> Ah, okay, that's problematic.
> 

Thanks for your review!

Sorry for my delay, I was out of the office.

>>>> This patch add nr_flush counter in blk_plug, so we can tell if the task
>>>> has throttled in any qos ->throttle(), in which case we need to correct
>>>> the rq start_time_ns and alloc_time_ns.
>>>>
>>>> Another solution may be make rq_qos_throttle() return bool to indicate
>>>> if it has throttled in any qos ->throttle(). But this need more changes.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> Depending on the flush behavior and adjusting alloc_time_ns seems fragile to
>>> me and will likely confuse other users of alloc_time_ns too.
>>
>> I agree with you, this code is not good. My basic idea is to adjust the cached
>> request alloc_time_ns and start_time_ns when throttled.
> 
> Would it make sense to skip setting the alloc_time_ns during pre-allocation
> and set it later when the pre-allocated rq is actually used? That should
> jive better.
> 

Ok, I think it's much clearer that we set the alloc_time_ns and start_time_ns
to "now" when the pre-allocated rq is actually used.

I will send an updated version later.

Thanks.
