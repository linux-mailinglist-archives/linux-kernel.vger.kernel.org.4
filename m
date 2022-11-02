Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1060F6162C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKBMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:35:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC9201A3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:35:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5CB001F8F3;
        Wed,  2 Nov 2022 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667392505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+53gR8/zAG0Ej93K6uYzuEPJOENV3OYiZXpUxl2Kft4=;
        b=EpmELpBF+lXlD9vyyPDyMZqCkJv6hUdrolXiE9tp0uftUdwD/XYQX9CdNLHQbfI/B4PKDm
        Xc5PxZ73+aNbBfuX69Wf3BCCJvOoKb8ml2alnRUSPvuoGTn51jCyRgJO6mrNfDxvrim0Pd
        Ckps4eccY07EzCp4aCcjqtGylYZmDXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667392505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+53gR8/zAG0Ej93K6uYzuEPJOENV3OYiZXpUxl2Kft4=;
        b=Oo7dLFT1/CX9Dq53BnnrA87yJ26PTvaucFhJu6bKSR5oicWpZu7sGlUA5KuZTJL3PbOMBQ
        YPmTIDvFGjhhHOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 362F513AE0;
        Wed,  2 Nov 2022 12:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id imsUDPljYmMeGgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Nov 2022 12:35:05 +0000
Message-ID: <ad5e7f08-5211-0885-04d9-96fd741ccbe2@suse.cz>
Date:   Wed, 2 Nov 2022 13:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH] mm: introduce accounting of page_owner via backtrace
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
References: <1667390781-17515-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1667390781-17515-1-git-send-email-zhaoyang.huang@unisoc.com>
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

On 11/2/22 13:06, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Page_owner could be accounted and sort via its backtrace, which could
> simplify the output.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

At first glance this looks like the same goal as Oscar's (CC'd) patchset:
https://lore.kernel.org/linux-mm/20220905031012.4450-1-osalvador@suse.de/


> ---
>  include/linux/page_owner.h |   7 +++
>  mm/page_owner.c            | 113 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 119a0c9..c86a342 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -3,6 +3,13 @@
>  #define __LINUX_PAGE_OWNER_H
>  
>  #include <linux/jump_label.h>
> +#include <linux/stackdepot.h>
> +
> +struct hash_object {
> +	int count;
> +	depot_stack_handle_t trace_hash;
> +	struct rb_node rb_node;
> +};
>  
>  #ifdef CONFIG_PAGE_OWNER
>  extern struct static_key_false page_owner_inited;
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e4c6f3f..3d014fd 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -42,6 +42,12 @@ struct page_owner {
>  static depot_stack_handle_t early_handle;
>  
>  static void init_early_allocated_pages(void);
> +static void store_user_hash(depot_stack_handle_t trace_hash, int count);
> +static DEFINE_SPINLOCK(stack_hash_lock);
> +static struct hash_object ho_pool[8192];
> +static int ho_pool_free_count = ARRAY_SIZE(ho_pool);
> +struct rb_root user_hash_root = RB_ROOT;
> +
>  
>  static int __init early_page_owner_param(char *buf)
>  {
> @@ -152,6 +158,8 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  		page_owner->free_handle = handle;
>  		page_owner->free_ts_nsec = free_ts_nsec;
>  		page_ext = page_ext_next(page_ext);
> +		if (!i)
> +			store_user_hash(page_owner->handle, -(1 << order));
>  	}
>  }
>  
> @@ -190,6 +198,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
>  		return;
>  
>  	handle = save_stack(gfp_mask);
> +	store_user_hash(handle, 1 << order);
>  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
>  }
>  
> @@ -570,6 +579,105 @@ void __dump_page_owner(const struct page *page)
>  	return 0;
>  }
>  
> +static void store_user_hash(depot_stack_handle_t trace_hash, int count)
> +{
> +	struct rb_node *rb_parent;
> +	unsigned int trace_hash_parent;
> +	struct rb_node **link = &user_hash_root.rb_node;
> +	struct hash_object *hash_parent = NULL;
> +	struct hash_object *hash_object = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&stack_hash_lock, flags);
> +	while (*link) {
> +		rb_parent = *link;
> +		hash_parent = rb_entry(rb_parent, struct hash_object, rb_node);
> +		trace_hash_parent = hash_parent->trace_hash;
> +		if (trace_hash < trace_hash_parent)
> +			link = &hash_parent->rb_node.rb_left;
> +		else if (trace_hash_parent < trace_hash)
> +			link = &hash_parent->rb_node.rb_right;
> +		else {
> +			hash_object = rb_entry(*link, struct hash_object, rb_node);
> +			hash_object->count += count;
> +			if (!RB_EMPTY_ROOT(&user_hash_root)
> +					&& !hash_object->count) {
> +				rb_erase(&hash_object->rb_node, &user_hash_root);
> +			}
> +			spin_unlock_irqrestore(&stack_hash_lock, flags);
> +			return;
> +		}
> +	}
> +	/*
> +	 * hash_object is the 1st node represent this trace_hash
> +	 * insert it to user_hash_root
> +	 */
> +	hash_object = ho_pool_free_count ? &ho_pool[--ho_pool_free_count] : NULL;
> +	if (!hash_object) {
> +		spin_unlock_irqrestore(&stack_hash_lock, flags);
> +		return;
> +	}
> +	hash_object->trace_hash = trace_hash;
> +	/* add the node to rb tree*/
> +	rb_link_node(&hash_object->rb_node, rb_parent, link);
> +	rb_insert_color(&hash_object->rb_node, &user_hash_root);
> +	spin_unlock_irqrestore(&stack_hash_lock, flags);
> +	return;
> +}
> +static ssize_t print_owner_stack(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct hash_object *object;
> +	struct rb_node *rb;
> +	unsigned long *entries;
> +	unsigned int nr_entries;
> +	char *kbuf;
> +	int i, ret = 0;
> +	unsigned long flags;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	rb = file->private_data ? (struct rb_node *)file->private_data : rb_first(&user_hash_root);
> +	if(!rb)
> +		return 0;
> +	spin_lock_irqsave(&stack_hash_lock, flags);
> +	object = rb_entry(rb, struct hash_object, rb_node);
> +	if (object) {
> +		while (!object->trace_hash || object->count <= 0) {
> +			rb = rb_next(rb);
> +			object = rb ? rb_entry(rb, struct hash_object, rb_node) : NULL;
> +			if (!object) {
> +				spin_unlock_irqrestore(&stack_hash_lock, flags);
> +				kfree(kbuf);
> +				return 0;
> +			}
> +		}
> +		nr_entries = stack_depot_fetch(object->trace_hash, &entries);
> +		ret += snprintf(kbuf + ret, count - ret, "count %d\n", object->count);
> +		if (ret >= count)
> +			goto err;
> +		for (i = 0; i < nr_entries; i++) {
> +			void *ptr = (void *)entries[i];
> +			ret += snprintf(kbuf + ret, count - ret, "    [<%p>] %pS\n", ptr, ptr);
> +			if (ret >= count)
> +				goto err;
> +		}
> +	}
> +	file->private_data = (void *)rb_next(rb);
> +	spin_unlock_irqrestore(&stack_hash_lock, flags);
> +	if (copy_to_user(buf, kbuf, ret))
> +		ret = -EFAULT;
> +
> +	kfree(kbuf);
> +	return ret;
> +err:
> +	spin_unlock_irqrestore(&stack_hash_lock, flags);
> +	kfree(kbuf);
> +	return -ENOMEM;
> +}
> +
>  static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>  {
>  	unsigned long pfn = zone->zone_start_pfn;
> @@ -661,6 +769,9 @@ static void init_early_allocated_pages(void)
>  static const struct file_operations proc_page_owner_operations = {
>  	.read		= read_page_owner,
>  };
> +static const struct file_operations proc_page_owner_simple_operations = {
> +	.read		= print_owner_stack,
> +};
>  
>  static int __init pageowner_init(void)
>  {
> @@ -671,6 +782,8 @@ static int __init pageowner_init(void)
>  
>  	debugfs_create_file("page_owner", 0400, NULL, NULL,
>  			    &proc_page_owner_operations);
> +	debugfs_create_file("page_owner_simple", 0400, NULL, NULL,
> +			    &proc_page_owner_simple_operations);
>  
>  	return 0;
>  }

