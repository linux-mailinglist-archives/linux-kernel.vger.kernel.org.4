Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43C636F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiKXBDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:03:48 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DE9D06CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:03:46 -0800 (PST)
Date:   Wed, 23 Nov 2022 17:03:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669251824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ybudtwMfrOEChaCHm/veUGjVUgd9li4v5+FEt3DuvAM=;
        b=pTarRRWK45RONZmknVKroXtsrcCWE3jKtM2/fSHNvSdWwUev8stYRSueY2nyn8bmvjMkKR
        SJNLV/DsV2Ku6LKy2xd3bb/BcTTKaVD7FB+Ntfh+qu/7aHOv1bBEupFrRMrHheIWcSHBHC
        nOgRwDiWla4t6f0l2ke/V/XuUBYNBw8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] selftests: cgroup: refactor proactive reclaim
 code to reclaim_until()
Message-ID: <Y37C68kUYakRQ2ZC@P9FQF9L96D.corp.robot.car>
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123092132.2521764-3-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:21:31AM +0000, Yosry Ahmed wrote:
> Refactor the code that drives writing to memory.reclaim (retrying, error
> handling, etc) from test_memcg_reclaim() to a helper called
> reclaim_until(), which proactively reclaims from a memcg until its
> usage reaches a certain value.
> 
> This will be used in a following patch in another test.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 85 +++++++++++--------
>  1 file changed, 49 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 8833359556f3..d4182e94945e 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -645,6 +645,53 @@ static int test_memcg_max(const char *root)
>  	return ret;


The code below looks correct, but can be simplified a bit.
And btw thank you for adding a test!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
(idk if you want invest your time in further simplication of this code,
it was this way before this patch, so up to you).

>  }
>  
> +/* Reclaim from @memcg until usage reaches @goal_usage */
> +static bool reclaim_until(const char *memcg, long goal_usage)
> +{
> +	char buf[64];
> +	int retries = 5;
> +	int err;
> +	long current, to_reclaim;
> +
> +	/* Nothing to do here */
> +	if (cg_read_long(memcg, "memory.current") <= goal_usage)
> +		return true;
> +
> +	while (true) {
> +		current = cg_read_long(memcg, "memory.current");
> +		to_reclaim = current - goal_usage;
> +
> +		/*
> +		 * We only keep looping if we get -EAGAIN, which means we could
> +		 * not reclaim the full amount. This means we got -EAGAIN when
> +		 * we actually reclaimed the requested amount, so fail.
> +		 */
> +		if (to_reclaim <= 0)
> +			break;
> +
> +		snprintf(buf, sizeof(buf), "%ld", to_reclaim);
> +		err = cg_write(memcg, "memory.reclaim", buf);
> +		if (!err) {
> +			/*
> +			 * If writing succeeds, then the written amount should have been
> +			 * fully reclaimed (and maybe more).
> +			 */
> +			current = cg_read_long(memcg, "memory.current");
> +			if (!values_close(current, goal_usage, 3) && current > goal_usage)
> +				break;

There are 3 places in this function where memory.current is read and compared
to goal_usage. I believe only one can be left.

> +			return true;
> +		}
> +
> +		/* The kernel could not reclaim the full amount, try again. */
> +		if (err == -EAGAIN && retries--)
> +			continue;
> +
> +		/* We got an unexpected error or ran out of retries. */
> +		break;

if (err != -EAGAIN || retries--)
	break;

Thanks!
