Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84F635279
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbiKWIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiKWIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:25:05 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA71FBAB3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:25:03 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHDgf2pBKzmVyP;
        Wed, 23 Nov 2022 16:24:30 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:25:01 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:25:01 +0800
Message-ID: <bc2c6314-7c94-8096-19f0-0c11882479e4@huawei.com>
Date:   Wed, 23 Nov 2022 16:25:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [RFC PATCH v1 1/4] zram: introduce merge identical pages
 mechanism
To:     Alexey Romanov <avromanov@sberdevices.ru>, <minchan@kernel.org>,
        <senozhatsky@chromium.org>, <ngupta@vflare.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <ddrokosov@sberdevices.ru>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <20221121190020.66548-2-avromanov@sberdevices.ru>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20221121190020.66548-2-avromanov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100002.china.huawei.com (7.185.36.179)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/22 3:00, Alexey Romanov 写道:
> zram maps each page (struct page) to a zsmalloc object that
> contains a compressed buffer of that page's data. This fact
> generates data redundancy: for example, two identical pages
> will be store in compressed form in zsmalloc allocator twice.
>
> This patch adds a mechanism to scan zram_table_entry array
> and frees all identical objects in zsmalloc allocator, leaving
> only one. All zram_table_entry elements which reference this
> freed objects now refer to the same, not freed, object.
>
> To implement this mechanism, we sequentially scan the
> zram_table_entry array, counting the hash from the contents of
> the compressed pages (zsmalloc objects) and enter the index of
> the object into the hash table (hlist_head). If the hash matches,
> we remove the identical zsmalloc (zs_free) objects and update
> the link rbtree.
>
> Also, we can't just call zs_free() function during zram_free_page().
> Before calling this function we have to make sure that no one else
> refers to this zsmalloc object.
>
> To implement the mechanism for merging identical compressed
> pages (zsmalloc objects), a rbtree is needed.
>
> The tree node key is a reference to the zsmalloc object
> (handle), and the value is the number of references to
> this object (atomic counter). This is necessary for data
> consistency so that we do not zs_free the object referenced
> by any element of the zram_table_entry array.
>
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   drivers/block/zram/zram_drv.c | 278 +++++++++++++++++++++++++++++++++-
>   drivers/block/zram/zram_drv.h |   6 +
>   2 files changed, 283 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index e290d6d97047..716c2f72805e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -33,12 +33,15 @@
>   #include <linux/debugfs.h>
>   #include <linux/cpuhotplug.h>
>   #include <linux/part_stat.h>
> +#include <linux/hashtable.h>
> +#include <linux/xxhash.h>
>   
>   #include "zram_drv.h"
>   
>   static DEFINE_IDR(zram_index_idr);
>   /* idr index must be protected */
>   static DEFINE_MUTEX(zram_index_mutex);
> +static DEFINE_MUTEX(zram_rbtree_mutex);
>   
>   static int zram_major;
>   static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
> @@ -57,6 +60,16 @@ static void zram_free_page(struct zram *zram, size_t index);
>   static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
>   				u32 index, int offset, struct bio *bio);
>   
> +struct zram_rbtree_node {
> +	struct rb_node node;
> +	unsigned long key;
> +	unsigned long cnt;
> +};
> +
> +struct zram_hash_node {
> +	unsigned long index;
> +	struct hlist_node next;
> +};
>   
>   static int zram_slot_trylock(struct zram *zram, u32 index)
>   {
> @@ -1283,6 +1296,247 @@ static DEVICE_ATTR_RO(bd_stat);
>   #endif
>   static DEVICE_ATTR_RO(debug_stat);
>   
> +static bool zram_rbtree_insert(struct rb_root *root, struct zram_rbtree_node *data)
> +{
> +	struct rb_node **new = &(root->rb_node), *parent = NULL;
> +	struct zram_rbtree_node *this;
> +
> +	while (*new) {
> +		this = rb_entry(*new, struct zram_rbtree_node, node);
> +		parent = *new;
> +		if (data->key < this->key)
> +			new = &((*new)->rb_left);
> +		else if (data->key > this->key)
> +			new = &((*new)->rb_right);
> +		else
> +			return false;
> +	}
> +
> +	rb_link_node(&data->node, parent, new);
> +	rb_insert_color(&data->node, root);
> +	return true;
> +}
> +
> +static struct zram_rbtree_node *zram_rbtree_search(struct rb_root *root,
> +		unsigned long key)
> +{
> +	struct rb_node *node = root->rb_node;
> +	struct zram_rbtree_node *data;
> +
> +	while (node) {
> +		data = rb_entry(node, struct zram_rbtree_node, node);
> +		if (key < data->key)
> +			node = node->rb_left;
> +		else if (key > data->key)
> +			node = node->rb_right;
> +		else
> +			return data;
> +	}
> +
> +	return NULL;
> +}
> +
> +static unsigned long zram_calc_hash(void *src, size_t len)
> +{
> +	return xxhash(src, len, 0);
> +}
> +
> +static int zram_cmp_obj_and_merge(struct zram *zram, struct hlist_head *htable,
> +		size_t htable_size, size_t index)
> +{
> +	struct zram_rbtree_node *rb_node;
> +	struct zram_hash_node *node;
> +	unsigned long handle, cur_handle;
> +	size_t obj_size;
> +	char *src, *buf;
> +	unsigned long hash;
> +	int ret = 0;
> +
> +	handle = zram_get_handle(zram, index);
> +	if (!handle)
> +		return ret;
> +
> +	obj_size = zram_get_obj_size(zram, index);
> +	buf = kmalloc(obj_size, GFP_KERNEL);
> +	if (!buf) {
> +		pr_err("Failed to allocate zs_map_object buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
> +	memcpy(buf, src, obj_size);
> +	zs_unmap_object(zram->mem_pool, handle);
> +	hash = zram_calc_hash(buf, obj_size);
> +
> +	mutex_lock(&zram_rbtree_mutex);
> +	hlist_for_each_entry(node, &htable[hash % htable_size], next) {
> +		int cmp;
> +
> +		zram_slot_lock(zram, node->index);
> +
> +		/*
> +		 * Page may change as the hash table is being formed,
> +		 * so the checks below are necessary.
> +		 */
> +		cur_handle = zram_get_handle(zram, node->index);
> +		if (handle == cur_handle ||
> +			obj_size != zram_get_obj_size(zram, node->index)) {
> +			zram_slot_unlock(zram, node->index);
> +			continue;
> +		}
> +
> +		src = zs_map_object(zram->mem_pool, cur_handle, ZS_MM_RO);
> +		cmp = memcmp(buf, src, obj_size);
> +		zs_unmap_object(zram->mem_pool, cur_handle);
> +
> +		if (!cmp) {
> +			rb_node = zram_rbtree_search(&zram->sph_rbtree, handle);
> +
> +			/*
> +			 * This check is necessary in order not to zs_free an object
> +			 * that someone already refers to. This situation is possible
> +			 * when with repeated calls to zram_do_scan(). For example:
> +			 *
> +			 * [slot0] [slot1] [slot2] [slot3] [slot4]
> +			 * [obj0]  [obj1]  [obj2]  [obj3]  [obj4]
> +			 *
> +			 * Let's imagine that obj2 and obj3 are equal, and we called
> +			 * zram_do_scan() function:
> +			 *
> +			 * [slot0] [slot1] [slot2] [slot3] [slot4]
> +			 * [obj0]  [obj1]  [obj2]  [obj2]  [obj4]
> +			 *
> +			 * Now, slot2 and slot3 refers to obj2 zsmalloc object.
> +			 * Time passed, now slot0 refres to obj0_n, which is equal
> +			 * to obj2:
> +			 *
> +			 * [slot0]  [slot1] [slot2] [slot3] [slot4]
> +			 * [obj0_n] [obj1]  [obj2]  [obj2]  [obj4]
> +			 *
> +			 * Now we call zram_do_scan() function again. We get to slot2,
> +			 * and we understand that obj2 and obj0_n hashes are the same. We
> +			 * try to zs_free(obj2), but slot3 also already refers to it.
> +			 *
> +			 * This is not correct!
> +			 */
In this case, it seem like can't merge all same object, is that right?

how about let slot2 point to obj0_n and decrease the rb_node ref of 
slot2/slot3 in the first loop,
let slot3 point to obj0_n and decrease the rb_node ref in the next 
loop,  then the obj2 can be free.
> +			if (unlikely(rb_node))
> +				if (rb_node->cnt > 1) {
> +					zram_slot_unlock(zram, node->index);
> +					continue;
> +				}
> +
> +			zram_set_handle(zram, index, cur_handle);
> +			zs_free(zram->mem_pool, handle);
> +
> +			rb_node = zram_rbtree_search(&zram->sph_rbtree, cur_handle);
> +
> +			if (!rb_node) {
> +				rb_node = kzalloc(sizeof(struct zram_rbtree_node),
> +								GFP_KERNEL);
> +				if (!rb_node) {
> +					pr_err("Failed to allocate rb_node\n");
> +					ret = -ENOMEM;
> +					zram_slot_unlock(zram, node->index);
> +					mutex_unlock(&zram_rbtree_mutex);
> +					goto merged_or_err;
> +				}
> +
> +				rb_node->key = cur_handle;
> +				/* Two slots refers to an zsmalloc object with cur_handle key */
> +				rb_node->cnt = 2;
> +				zram_rbtree_insert(&zram->sph_rbtree, rb_node);
> +			} else {
> +				rb_node->cnt++;
> +			}
> +
> +			atomic64_sub(obj_size, &zram->stats.compr_data_size);
> +			zram_set_flag(zram, index, ZRAM_MERGED);
> +			zram_set_flag(zram, node->index, ZRAM_MERGED);
> +
> +			zram_slot_unlock(zram, node->index);
> +			mutex_unlock(&zram_rbtree_mutex);
> +			goto merged_or_err;
> +		}
> +
> +		zram_slot_unlock(zram, node->index);
> +	}
> +
> +	mutex_unlock(&zram_rbtree_mutex);
> +
> +	node = kmalloc(sizeof(struct zram_hash_node), GFP_KERNEL);
> +	if (!node) {
> +		ret = -ENOMEM;
> +		goto merged_or_err;
> +	}
> +
> +	node->index = index;
> +	hlist_add_head(&node->next, &htable[hash % htable_size]);
> +
> +merged_or_err:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static void zram_free_htable_entries(struct hlist_head *htable,
> +		size_t htable_size)
> +{
> +	struct hlist_node *n;
> +	struct zram_hash_node *node;
> +
> +	hlist_for_each_entry_safe(node, n, htable, next) {
> +		hlist_del(&node->next);
> +		kfree(node);
> +	}
> +}
> +
> +static int zram_do_scan(struct zram *zram)
> +{
> +	size_t num_pages = zram->disksize >> PAGE_SHIFT;
> +	size_t htable_size = num_pages;
> +	size_t index;
> +	struct hlist_head *htable;
> +	int i, ret = 0;
> +
> +	htable = vzalloc(htable_size * sizeof(struct hlist_head));
> +	if (!htable) {
> +		pr_err("Failed to allocate hash table\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < htable_size; i++)
> +		INIT_HLIST_HEAD(&htable[i]);
> +
> +	for (index = 0; index < num_pages; index++) {
> +		zram_slot_lock(zram, index);
> +
> +		if (!zram_allocated(zram, index)) {
> +			zram_slot_unlock(zram, index);
> +			continue;
> +		}
> +
> +		if (zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
> +			zram_test_flag(zram, index, ZRAM_WB) ||
> +			zram_test_flag(zram, index, ZRAM_SAME)) {
> +			zram_slot_unlock(zram, index);
> +			continue;
> +		}
> +
> +		/* Ignore pages that have been recompressed */
> +		if (zram_get_priority(zram, index) != 0)
> +			continue;
> +
> +		ret = zram_cmp_obj_and_merge(zram, htable, htable_size, index);
> +		zram_slot_unlock(zram, index);
> +		if (ret != 0)
> +			goto out;
> +	}
> +
> +out:
> +	zram_free_htable_entries(htable, htable_size);
> +	vfree(htable);
> +	return ret;
> +}
> +
>   static void zram_meta_free(struct zram *zram, u64 disksize)
>   {
>   	size_t num_pages = disksize >> PAGE_SHIFT;
> @@ -1324,6 +1578,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
>   static void zram_free_page(struct zram *zram, size_t index)
>   {
>   	unsigned long handle;
> +	struct zram_rbtree_node *node;
>   
>   #ifdef CONFIG_ZRAM_MEMORY_TRACKING
>   	zram->table[index].ac_time = 0;
> @@ -1361,7 +1616,26 @@ static void zram_free_page(struct zram *zram, size_t index)
>   	if (!handle)
>   		return;
>   
> -	zs_free(zram->mem_pool, handle);
> +	if (zram_test_flag(zram, index, ZRAM_MERGED)) {
> +		zram_clear_flag(zram, index, ZRAM_MERGED);
> +		mutex_lock(&zram_rbtree_mutex);
> +
> +		node = zram_rbtree_search(&zram->sph_rbtree, handle);
> +		BUG_ON(!node);
> +
> +		node->cnt--;
> +		if (node->cnt == 0) {
> +			rb_erase(&node->node, &zram->sph_rbtree);
> +			mutex_unlock(&zram_rbtree_mutex);
> +
> +			zs_free(zram->mem_pool, handle);
> +			kfree(node);
> +		} else {
> +			mutex_unlock(&zram_rbtree_mutex);
> +		}
> +	} else {
> +		zs_free(zram->mem_pool, handle);
> +	}
>   
>   	atomic64_sub(zram_get_obj_size(zram, index),
>   			&zram->stats.compr_data_size);
> @@ -2421,6 +2695,8 @@ static int zram_add(void)
>   
>   	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
>   
> +	zram->sph_rbtree = RB_ROOT;
> +
>   	zram_debugfs_register(zram);
>   	pr_info("Added device: %s\n", zram->disk->disk_name);
>   	return device_id;
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index c5254626f051..4a7151c94523 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -56,6 +56,7 @@ enum zram_pageflags {
>   
>   	ZRAM_COMP_PRIORITY_BIT1, /* First bit of comp priority index */
>   	ZRAM_COMP_PRIORITY_BIT2, /* Second bit of comp priority index */
> +	ZRAM_MERGED,	/* page was merged */
>   
>   	__NR_ZRAM_PAGEFLAGS,
>   };
> @@ -140,5 +141,10 @@ struct zram {
>   #ifdef CONFIG_ZRAM_MEMORY_TRACKING
>   	struct dentry *debugfs_dir;
>   #endif
> +	/*
> +	 * This is same pages handle's rb tree, where the key is a handle
> +	 * to same pages and the value is a link counter
> +	 */
> +	struct rb_root sph_rbtree;
>   };
>   #endif

