Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3E6B2DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCITgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCITfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:35:39 -0500
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC38E9CC6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:34:59 -0800 (PST)
Received: from vla1-2f6a8787997a.qloud-c.yandex.net (vla1-2f6a8787997a.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:35a1:0:640:2f6a:8787])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id 30F8C5E63A;
        Thu,  9 Mar 2023 22:34:57 +0300 (MSK)
Received: by vla1-2f6a8787997a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id rYjOo16bFa61-EkIfarrO;
        Thu, 09 Mar 2023 22:34:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1678390496;
        bh=x5Mdnjs936NhBEC2nIU/NZu/xsSl+ksx91PQmbqwdfc=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=FU+zF845p+MAA1XGsusfa7cQjbs1o3BtyoFg31pI4vh7iPKxOf4WggV+M6nLRL0W/
         aMCVDWLWfWO3sV5xAxRHrhb3OFXZde63RiwSzhRry58oMYHkJ7mAXeU1/XCpYSMFMV
         +cuV0iL7RcLGEjH+bQZpmDmvMuuxghXcADAwMuJY=
Authentication-Results: vla1-2f6a8787997a.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <853a2f87-7b00-a44a-04f9-53443069156b@ya.ru>
Date:   Thu, 9 Mar 2023 22:34:52 +0300
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Kirill Tkhai <tkhai@ya.ru>

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

