Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E2619CE3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiKDQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:19:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4220F6C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:19:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FCDD219D0;
        Fri,  4 Nov 2022 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667578739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxkh44BNK58jGCReJRCB+RdW49A2w+L2p0jqqFrbYiE=;
        b=nFvrekBFLCrPaMrFa3xYrgidHPluNgHFcwDgpfx3OftXbRt+oCB2q6a2R3x1ESnukTE9o+
        YcDL/No7VHbPY8FdZKPo0PWn3KIV76zOO9wH6mnIivvV8RgSSqZ1O5sYluQKyRqT3sy3KW
        Ggsy7DOK3gXl1TMHSwX3gVZfGlwG0jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667578739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxkh44BNK58jGCReJRCB+RdW49A2w+L2p0jqqFrbYiE=;
        b=ausIb5Gz0Ya+BmacoDLQSfcZ2P3YBktOhTIUw1SGNMch1FNE8JxY5M+qJyY35n4f6yapBf
        bSr9F8RVl3avfLCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32A9A1346F;
        Fri,  4 Nov 2022 16:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id odlpC3M7ZWOPbgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Nov 2022 16:18:59 +0000
Message-ID: <06e84020-3794-c798-10a6-97282814fd3a@suse.cz>
Date:   Fri, 4 Nov 2022 17:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH] mm: introduce object accounting via backtrace on slub
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <1667550838-10639-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1667550838-10639-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	On 11/4/22 09:33, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Introduce a set of methods to account object via backtrace.

Can you describe what exactly it does, so we don't need to guess from 
the source code?

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>   include/linux/slub_def.h |   7 +++
>   mm/slub.c                | 155 ++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 161 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index f9c68a9..c90e5fb 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -139,9 +139,16 @@ struct kmem_cache {
>   	unsigned int useroffset;	/* Usercopy region offset */
>   	unsigned int usersize;		/* Usercopy region size */
>   
> +	struct rb_root user_hash_root;
> +
>   	struct kmem_cache_node *node[MAX_NUMNODES];
>   };
>   
> +struct hash_object {
> +	int count;
> +	depot_stack_handle_t trace_hash;
> +	struct rb_node rb_node;
> +};
>   #ifdef CONFIG_SYSFS
>   #define SLAB_SUPPORTS_SYSFS
>   void sysfs_slab_unlink(struct kmem_cache *);
> diff --git a/mm/slub.c b/mm/slub.c
> index 157527d..3ec02ff 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -337,6 +337,7 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
>    */
>   static struct workqueue_struct *flushwq;
>   
> +static struct kmem_cache *user_hash_cache;
>   /********************************************************************
>    * 			Core slab cache functions
>    *******************************************************************/
> @@ -759,12 +760,152 @@ static void set_track_update(struct kmem_cache *s, void *object,
>   	p->when = jiffies;
>   }
>   
> +static void store_user_hash(struct kmem_cache *s, void *object,
> +		depot_stack_handle_t trace_hash, enum track_item alloc)
> +{
> +	struct rb_node *rb_parent;
> +	unsigned int trace_hash_parent;
> +	struct rb_node **link = &s->user_hash_root.rb_node;
> +	struct hash_object *hash_parent = NULL;
> +	struct hash_object *hash_object = NULL;
> +	unsigned long flags;
> +	int count;
> +	int nid = slab_nid(virt_to_slab(object));
> +	struct kmem_cache_node *n = get_node(s, nid);
> +
> +	spin_lock_irqsave(&n->list_lock, flags);
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
> +			count = (alloc == TRACK_ALLOC) ? 1 : -1;
> +			hash_object->count += count;
> +			if (!RB_EMPTY_ROOT(&s->user_hash_root)
> +				&& !hash_object->count) {
> +				rb_erase(&hash_object->rb_node, &s->user_hash_root);
> +				kmem_cache_free(user_hash_cache, hash_object);
> +			}
> +			spin_unlock_irqrestore(&n->list_lock, flags);
> +			return;
> +		}
> +	}
> +	spin_unlock_irqrestore(&n->list_lock, flags);
> +	/*
> +	 * hash_object is the 1st node represent this trace_hash
> +	 * insert it to user_hash_root
> +	 */
> +	hash_object = kmem_cache_alloc(user_hash_cache, GFP_KERNEL);
> +	if (!hash_object)
> +		return;
> +	hash_object->trace_hash = trace_hash;
> +	/* add the node to rb tree*/
> +	spin_lock_irqsave(&n->list_lock, flags);
> +	rb_link_node(&hash_object->rb_node, rb_parent, link);
> +	rb_insert_color(&hash_object->rb_node, &s->user_hash_root);
> +	spin_unlock_irqrestore(&n->list_lock, flags);
> +	return;
> +}
> +
> +static ssize_t backtrace_acc_print(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct hash_object *object;
> +	struct rb_node *rb;
> +	unsigned long *entries;
> +	unsigned int nr_entries;
> +	char *kbuf;
> +	int i, ret = 0;
> +	unsigned long flags;
> +	struct kmem_cache_node *n;
> +	enum track_item alloc;
> +	int node;
> +	struct slab *slab;
> +	struct kmem_cache *s = file_inode(file)->i_private;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	/* iterate from node-0 */
> +	node = *ppos;
> +	if (node >= nr_node_ids)
> +		return 0;
> +
> +	if ((n = get_node(s, node))) {
> +		/* skip empty node */
> +		while (!atomic_long_read(&n->nr_slabs)) {
> +			if (++node >= nr_node_ids)
> +				return 0;
> +			n = get_node(s, node);
> +		}
> +
> +		rb = file->private_data ? (struct rb_node *)file->private_data : rb_first(&s->user_hash_root);
> +		/* current node finish, reset rb to next node's root */
> +		if(!rb) {
> +			ret += snprintf(kbuf + ret, count - ret, "\n");
> +			copy_to_user(buf, kbuf, ret);
> +			file->private_data = 0;
> +			*ppos = ++node;
> +			return ret;
> +		}
> +
> +		spin_lock_irqsave(&n->list_lock, flags);
> +		object = rb_entry(rb, struct hash_object, rb_node);
> +		if (object) {
> +			while (!object->trace_hash || object->count <= 0) {
> +				rb = rb_next(rb);
> +				object = rb ? rb_entry(rb, struct hash_object, rb_node) : NULL;
> +				if (!object) {
> +					spin_unlock_irqrestore(&n->list_lock, flags);
> +					ret += snprintf(kbuf + ret, count - ret, "\n");
> +					copy_to_user(buf, kbuf, ret);
> +					file->private_data = 0;
> +					*ppos = ++node;
> +					kfree(kbuf);
> +					return ret;
> +				}
> +			}
> +			nr_entries = stack_depot_fetch(object->trace_hash, &entries);
> +			ret += snprintf(kbuf + ret, count - ret, "count %d\n", object->count);
> +			if (ret >= count)
> +				goto err;
> +			for (i = 0; i < nr_entries; i++) {
> +				void *ptr = (void *)entries[i];
> +				ret += snprintf(kbuf + ret, count - ret, "    [<%p>] %pS\n", ptr, ptr);
> +				if (ret >= count)
> +					goto err;
> +			}
> +		}
> +		file->private_data = (void *)rb_next(rb);
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +		*ppos = ++node;
> +		if (copy_to_user(buf, kbuf, ret))
> +			ret = -EFAULT;
> +
> +		kfree(kbuf);
> +		return ret;
> +err:
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +		kfree(kbuf);
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
>   static __always_inline void set_track(struct kmem_cache *s, void *object,
>   				      enum track_item alloc, unsigned long addr)
>   {
>   	depot_stack_handle_t handle = set_track_prepare();
>   
>   	set_track_update(s, object, alloc, addr, handle);
> +	if (strcmp(s->name, "user_hash_cache") != 0)
> +		store_user_hash(s, object, handle, alloc);
>   }
>   
>   static void init_tracking(struct kmem_cache *s, void *object)
> @@ -4918,8 +5059,10 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>   		return err;
>   	}
>   
> -	if (s->flags & SLAB_STORE_USER)
> +	if (s->flags & SLAB_STORE_USER) {
> +		s->user_hash_root = RB_ROOT;
>   		debugfs_slab_add(s);
> +	}
>   
>   	return 0;
>   }
> @@ -6236,6 +6379,10 @@ static int slab_debug_trace_release(struct inode *inode, struct file *file)
>   	.release = slab_debug_trace_release,
>   };
>   
> +static const struct file_operations backtrace_accounting_operations = {
> +	.read		= backtrace_acc_print,
> +};
> +
>   static void debugfs_slab_add(struct kmem_cache *s)
>   {
>   	struct dentry *slab_cache_dir;
> @@ -6250,6 +6397,9 @@ static void debugfs_slab_add(struct kmem_cache *s)
>   
>   	debugfs_create_file("free_traces", 0400,
>   		slab_cache_dir, s, &slab_debugfs_fops);
> +
> +	debugfs_create_file("backtrace_accounting", 0400, NULL, NULL,
> +			    &backtrace_accounting_operations);
>   }
>   
>   void debugfs_slab_release(struct kmem_cache *s)
> @@ -6261,6 +6411,9 @@ static int __init slab_debugfs_init(void)
>   {
>   	struct kmem_cache *s;
>   
> +	user_hash_cache = kmem_cache_create("user_hash_cache",
> +			sizeof(struct hash_object),
> +			0, 0, NULL);
>   	slab_debugfs_root = debugfs_create_dir("slab", NULL);
>   
>   	list_for_each_entry(s, &slab_caches, list)

