Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E017666A59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjALEeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjALEeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:34:37 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878F8DF47
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:34:34 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VZPZhea_1673498070;
Received: from 30.221.131.229(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZPZhea_1673498070)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 12:34:31 +0800
Message-ID: <8b0af045-25c1-9848-3c8c-de7da94d06da@linux.alibaba.com>
Date:   Thu, 12 Jan 2023 12:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] fscache: Add the missing smp_mb__after_atomic()
 before wake_up_bit()
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com
References: <20221226103309.953112-1-houtao@huaweicloud.com>
 <20221226103309.953112-3-houtao@huaweicloud.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221226103309.953112-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/26/22 6:33 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> fscache_create_volume_work() uses wake_up_bit() to wake up the processes
> which are waiting for the completion of volume creation. According to
> comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
> needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
> flag and waitqueue_active() before invoking wake_up_bit().
> 
> Considering clear_bit_unlock() before wake_up_bit() is an atomic
> operation, use smp_mb__after_atomic() instead of smp_mb() to provide
> such guarantee.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fscache/volume.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index fc3dd3bc851d..734d17f404e7 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -281,6 +281,11 @@ static void fscache_create_volume_work(struct work_struct *work)
>  				 fscache_access_acquire_volume_end);
>  
>  	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
> +	/*
> +	 * Paired with barrier in wait_on_bit(). Check wake_up_bit() and
> +	 * waitqueue_active() for details.
> +	 */
> +	smp_mb__after_atomic();
>  	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
>  	fscache_put_volume(volume, fscache_volume_put_create_work);
>  }

LGTM.

Actually I'm thinking if clear_and_wake_up_bit() could be used here.
Ditto for patch 1.

-- 
Thanks,
Jingbo
