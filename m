Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB4D6B2DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCITco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCITbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:31:51 -0500
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB45F145F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:30:55 -0800 (PST)
Received: from myt6-1289f562e823.qloud-c.yandex.net (myt6-1289f562e823.qloud-c.yandex.net [IPv6:2a02:6b8:c12:259d:0:640:1289:f562])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id CB5205F160;
        Thu,  9 Mar 2023 22:30:53 +0300 (MSK)
Received: by myt6-1289f562e823.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id nUjIpn5cqqM1-QSnoMwXQ;
        Thu, 09 Mar 2023 22:30:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1678390252;
        bh=Rn8tghGHUTM9dandsa5usgJEtLmCOIcUjMwrL2X2BkA=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=nF0kJfIrIEr2X2nKPL6I7u4RhJzT7lZdLEjR8N28TPWLl2pz7+JBQC2l0MdvZ5fxk
         SKj1hV09CPYtChHIiKzoU7YU057tAMK7W06o1rJLaigVrL7fCi9iOQqzEwd4bjMviJ
         9xOqIYvzwboE7CaXrxQBLqsXB0QN0NpedzbjpYnQ=
Authentication-Results: myt6-1289f562e823.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <56ce6c8c-a7ab-29d3-c781-2efa57f10be7@ya.ru>
Date:   Thu, 9 Mar 2023 22:30:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 5/8] mm: shrinkers: make count and scan in shrinker
 debugfs lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-6-zhengqi.arch@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <20230307065605.58209-6-zhengqi.arch@bytedance.com>
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
> Like global and memcg slab shrink, also use SRCU to
> make count and scan operations in memory shrinker
> debugfs lockless.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Kirill Tkhai <tkhai@ya.ru>

> ---
>  mm/shrinker_debug.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> index 39c3491e28a3..6aa7a7ec69da 100644
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c
> @@ -9,6 +9,7 @@
>  /* defined in vmscan.c */
>  extern struct rw_semaphore shrinker_rwsem;
>  extern struct list_head shrinker_list;
> +extern struct srcu_struct shrinker_srcu;
>  
>  static DEFINE_IDA(shrinker_debugfs_ida);
>  static struct dentry *shrinker_debugfs_root;
> @@ -49,18 +50,13 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
>  	struct mem_cgroup *memcg;
>  	unsigned long total;
>  	bool memcg_aware;
> -	int ret, nid;
> +	int ret = 0, nid, srcu_idx;
>  
>  	count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
>  	if (!count_per_node)
>  		return -ENOMEM;
>  
> -	ret = down_read_killable(&shrinker_rwsem);
> -	if (ret) {
> -		kfree(count_per_node);
> -		return ret;
> -	}
> -	rcu_read_lock();
> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
>  
>  	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
>  
> @@ -91,8 +87,7 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
>  		}
>  	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>  
> -	rcu_read_unlock();
> -	up_read(&shrinker_rwsem);
> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  
>  	kfree(count_per_node);
>  	return ret;
> @@ -115,9 +110,8 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
>  		.gfp_mask = GFP_KERNEL,
>  	};
>  	struct mem_cgroup *memcg = NULL;
> -	int nid;
> +	int nid, srcu_idx;
>  	char kbuf[72];
> -	ssize_t ret;
>  
>  	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
>  	if (copy_from_user(kbuf, buf, read_len))
> @@ -146,11 +140,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
>  		return -EINVAL;
>  	}
>  
> -	ret = down_read_killable(&shrinker_rwsem);
> -	if (ret) {
> -		mem_cgroup_put(memcg);
> -		return ret;
> -	}
> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
>  
>  	sc.nid = nid;
>  	sc.memcg = memcg;
> @@ -159,7 +149,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
>  
>  	shrinker->scan_objects(shrinker, &sc);
>  
> -	up_read(&shrinker_rwsem);
> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  	mem_cgroup_put(memcg);
>  
>  	return size;

