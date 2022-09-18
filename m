Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB0F5BBD9C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIRLgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIRLgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:36:38 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F8EE1D;
        Sun, 18 Sep 2022 04:36:37 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] md/raid10: convert resync_lock to use seqlock
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663500995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1+OGv4dFkBOVxp4OCIgge5yTXIRZosYR+jSx6W73rc=;
        b=G5FN5C8jAtDshvH1MV2Mrx/CW3u8FueyfS4Ure/+AfV2vocdKjXUmQEpPO4gz5CN4f9XSZ
        qxPQ1YFb3QjsTm4G1vTjrI3h0lkAyYyXU1GgjenX9xxUDvrQfNVF/UfBwCogqsIDw8yBcK
        ho1s6e21EsPpB3+fYL6h8v+vq7w9+ws=
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-6-yukuai1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <e73dc8e8-09a3-ecc8-3199-ac87e8b9ee55@linux.dev>
Date:   Sun, 18 Sep 2022 19:36:26 +0800
MIME-Version: 1.0
In-Reply-To: <20220916113428.774061-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 7:34 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently, wait_barrier() will hold 'resync_lock' to read 'conf->barrier',
> and io can't be dispatched until 'barrier' is dropped.
>
> Since holding the 'barrier' is not common, convert 'resync_lock' to use
> seqlock so that holding lock can be avoided in fast path.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 87 ++++++++++++++++++++++++++++++---------------
>   drivers/md/raid10.h |  2 +-
>   2 files changed, 59 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 9a28abd19709..2daa7d57034c 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -79,6 +79,21 @@ static void end_reshape(struct r10conf *conf);
>   
>   #include "raid1-10.c"
>   
> +#define NULL_CMD
> +#define cmd_before(conf, cmd) \
> +	do { \
> +		write_sequnlock_irq(&(conf)->resync_lock); \
> +		cmd; \
> +	} while (0)
> +#define cmd_after(conf) write_seqlock_irq(&(conf)->resync_lock)

The two is not paired well given only cmd_before needs the 'cmd'.

> +
> +#define wait_event_barrier_cmd(conf, cond, cmd) \
> +	wait_event_cmd((conf)->wait_barrier, cond, cmd_before(conf, cmd), \
> +		       cmd_after(conf))
> +
> +#define wait_event_barrier(conf, cond) \
> +	wait_event_barrier_cmd(conf, cond, NULL_CMD)

What is the issue without define NULL_CMD?

Thanks,
Guoqing
