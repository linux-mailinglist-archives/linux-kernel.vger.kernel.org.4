Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A773FB26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjF0Lcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjF0Lcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:32:54 -0400
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [IPv6:2001:41d0:203:375::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A9626B7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:32:52 -0700 (PDT)
Message-ID: <e1da325b-8f16-f4d2-d6bf-65976a4239b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687865568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AAMGnil1vus66xTAIuI1lIxfQX8aaFDX8sQDFraqX0=;
        b=eS1vGYD3pvIWNwfllqk4fByrGt+RqENGbMduaSfT6deiKtjk2Gw54VnY/s0C1RbCfKcq9Q
        phktX+iq9LmCjNOB1IPbCB18N4sM/abS27c7xSewD0hTrHMjZO356eNtdhAUx2jKMYkZgS
        dbDkSVh8MSGCTEWSYtSznAzZdPh9pDs=
Date:   Tue, 27 Jun 2023 19:32:42 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230626050405.781253-1-chengming.zhou@linux.dev>
 <20230626050405.781253-4-chengming.zhou@linux.dev>
 <ZJn5F4xb6gln0653@slm.duckdns.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZJn5F4xb6gln0653@slm.duckdns.org>
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

On 2023/6/27 04:46, Tejun Heo wrote:
> Hello,
> 
> I only glanced the blk-mq core part but in general this looks a lot better
> than the previous one.

Thanks for your review!

> 
> On Mon, Jun 26, 2023 at 01:04:05PM +0800, chengming.zhou@linux.dev wrote:
>> Note we don't skip setting alloc_time_ns and start_time_ns for all
>> pre-allocated rq, since the first returned rq still need to be set.
> 
> This part is a bit curious for me tho. Why do we need to set it at batch
> allocation time and then at actual dispensing from the bat later? Who uses
> the alloc time stamp inbetween?
> 

Yes, this part should need more explanation, and my explanation is not clear.

Now the batched pre-allocation code looks like this:

```
if (!rq_list_empty(plug->cached_rq))

  get pre-allocated rq from plug cache

  // we set alloc and start time here
  return rq

else
  rq = __blk_mq_alloc_requests_batch() do batched allocation (1)
  (2)
  return rq
```

In (1) we alloc some requests and push them in plug list, and pop one request
to return to use. So this popped one request need to be set time at batch allocation time.

Yes, we can also set this popped request time in (2), just before return it to use.


Since all requests in batch allocation use the same alloc and start time, so this patch
just leave it as it is, and reset it at actual used time.

I think both way is ok, do you think it's better to just set the popped one request, leave
other requests time to 0 ? If so, I can update to do it.

Thanks.

