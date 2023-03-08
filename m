Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A876B155C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCHWkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:40:00 -0500
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CDE144B1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:39:58 -0800 (PST)
Received: from sas2-ee8a69bedcfd.qloud-c.yandex.net (sas2-ee8a69bedcfd.qloud-c.yandex.net [IPv6:2a02:6b8:c14:252d:0:640:ee8a:69be])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id A5E6C5F425;
        Thu,  9 Mar 2023 01:39:56 +0300 (MSK)
Received: by sas2-ee8a69bedcfd.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id qdlK4ADc3mI1-YobY5zlJ;
        Thu, 09 Mar 2023 01:39:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1678315195;
        bh=jtp2l4lNFJPAxiRvDYywOQOC6WaE6pPy91DLgHdQQhI=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=AItsOs1tUQbS7iAuk2AT3NjB2XQBUNKQspE0WlDkhD+jJT1LG0nOLzhGV0oCoyS/A
         LOTbtus5nWHPWBaW0X3g7s+eLhJCCWUHcE6qAEU6NBRUkM1BZsYWCz/VmZLV9JwWSA
         a4xjilBcji57Mbv5zrKn1AeWxqphWGgIONs/6HjU=
Authentication-Results: sas2-ee8a69bedcfd.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <bc829246-4606-cc8d-4a4f-da285255f5a3@ya.ru>
Date:   Thu, 9 Mar 2023 01:39:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 7/8] mm: vmscan: remove shrinker_rwsem from
 synchronize_shrinkers()
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-8-zhengqi.arch@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <20230307065605.58209-8-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2023 09:56, Qi Zheng wrote:
> Now there are no readers of shrinker_rwsem, so
> synchronize_shrinkers() does not need to hold the
> writer of shrinker_rwsem to wait for all running
> shinkers to complete, synchronize_srcu() is enough.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/vmscan.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7aaf6f94ac1b..ac7ab4aa344f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -796,15 +796,11 @@ EXPORT_SYMBOL(unregister_shrinker);
>  /**
>   * synchronize_shrinkers - Wait for all running shrinkers to complete.
>   *
> - * This is equivalent to calling unregister_shrink() and register_shrinker(),
> - * but atomically and with less overhead. This is useful to guarantee that all
> - * shrinker invocations have seen an update, before freeing memory, similar to
> - * rcu.
> + * This is useful to guarantee that all shrinker invocations have seen an
> + * update, before freeing memory.
>   */
>  void synchronize_shrinkers(void)
>  {
> -	down_write(&shrinker_rwsem);
> -	up_write(&shrinker_rwsem);
>  	atomic_inc(&shrinker_srcu_generation);
>  	synchronize_srcu(&shrinker_srcu);
>  }

Just curious, callers of synchronize_shrinkers() don't want to have parallel register_shrinker() and unregister_shrink() are completed?
Here we only should wait for parallel shrink_slab(), correct?
