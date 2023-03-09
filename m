Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD686B2038
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCIJgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCIJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:36:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F92C3E19
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:36:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F7391F8B0;
        Thu,  9 Mar 2023 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678354594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UfrF/Vwc/LNYi2Rk9oLuWT5JiYHKO2T81orHmbB0Ww=;
        b=r1EsnW50oD6DnaMBtnnfjqwosKY7Ll9UtsLN5ySTV+18xm98dix5+7u0DT1X5YjpABnWwL
        HecmR1vIFbWQrlTYxGJAcKBuNRoD+ZpNHZk4WMb/cXh/OcpiapF/w8W2J60G1ueSUFNhEJ
        yniPTuFjiBqCBvNXrtI+Sb6SX8EZNw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678354594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UfrF/Vwc/LNYi2Rk9oLuWT5JiYHKO2T81orHmbB0Ww=;
        b=chsZFGv2Amfumh7LD54uoE1TAnrxkIvZCtlsQ9ghg68OY06O+EKSA+qE68tY1V/f9TyDoj
        opcwtOXjkNYxwDBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FCA01391B;
        Thu,  9 Mar 2023 09:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SNrYEqKoCWQmEwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 09:36:34 +0000
Message-ID: <cf16ed18-00ea-c1e9-befc-16e28b61da66@suse.cz>
Date:   Thu, 9 Mar 2023 10:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 5/8] mm: shrinkers: make count and scan in shrinker
 debugfs lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-6-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307065605.58209-6-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 07:56, Qi Zheng wrote:
> Like global and memcg slab shrink, also use SRCU to
> make count and scan operations in memory shrinker
> debugfs lockless.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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

