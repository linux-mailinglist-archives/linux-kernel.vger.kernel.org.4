Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C870C6B2DC9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCITeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCITd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:33:58 -0500
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3562B9DA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:32:52 -0800 (PST)
Received: from iva3-dd2bb2ff2b5f.qloud-c.yandex.net (iva3-dd2bb2ff2b5f.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7611:0:640:dd2b:b2ff])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 28BCD5E750;
        Thu,  9 Mar 2023 22:32:51 +0300 (MSK)
Received: by iva3-dd2bb2ff2b5f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id lWjqAj5bkKo1-8yYOAvmG;
        Thu, 09 Mar 2023 22:32:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1678390369;
        bh=tgtI2/RlCD9djsgvrZqiy8N+uhdHyEkt3pmCPepHBzE=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=pnD69qT/eo7zvpqUWo/aku9PXqlWjeL59YMtZzVQQqtWquEJxiaJvLj/F89FRg0N3
         N8B0tx3X7xLZi75GUTN4X9Mmeo8Ekn6k8y1fzkjLpfAwp8SZBRw0NJSpBBdUWCXpRy
         /onfKcePRECJNAcIp5x4hDjKSNKtTIA1ucCYoX5c=
Authentication-Results: iva3-dd2bb2ff2b5f.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <c245ab8e-8801-a202-76f1-72965effe09a@ya.ru>
Date:   Thu, 9 Mar 2023 22:32:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 6/8] mm: vmscan: hold write lock to reparent shrinker
 nr_deferred
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-7-zhengqi.arch@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <20230307065605.58209-7-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2023 09:56, Qi Zheng wrote:
> For now, reparent_shrinker_deferred() is the only holder
> of read lock of shrinker_rwsem. And it already holds the
> global cgroup_mutex, so it will not be called in parallel.
> 
> Therefore, in order to convert shrinker_rwsem to shrinker_mutex
> later, here we change to hold the write lock of shrinker_rwsem
> to reparent.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Kirill Tkhai <tkhai@ya.ru>

> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9a5a3da5c8b5..7aaf6f94ac1b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -451,7 +451,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  		parent = root_mem_cgroup;
>  
>  	/* Prevent from concurrent shrinker_info expand */
> -	down_read(&shrinker_rwsem);
> +	down_write(&shrinker_rwsem);
>  	for_each_node(nid) {
>  		child_info = shrinker_info_protected(memcg, nid);
>  		parent_info = shrinker_info_protected(parent, nid);
> @@ -460,7 +460,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>  		}
>  	}
> -	up_read(&shrinker_rwsem);
> +	up_write(&shrinker_rwsem);
>  }
>  
>  static bool cgroup_reclaim(struct scan_control *sc)

