Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3663DAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiK3Qan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiK3Qa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5B1E73C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669825767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ksypm4g/dHsSdYfI6/rLPDOiA9C/16H1SAqXGRIbHCs=;
        b=Lmc7QLHksA6ed97S4MRY16QHIDLl3gOHrf1XLTYTA5wudt4ptLpEk9wLI3QXgyhdx81J4Z
        y267hmDmX+aDeNxzV9EQ5gik8makbJn9rbfJJDo8ZON7+eNnyIQzYACefu54BSYEB1KDyD
        8LeK0UV6IP9cFPgZx8yZnt0nzlDQo6I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-185-65uKdFJAOt674Mh6MrKjhw-1; Wed, 30 Nov 2022 11:29:25 -0500
X-MC-Unique: 65uKdFJAOt674Mh6MrKjhw-1
Received: by mail-qt1-f197.google.com with SMTP id n12-20020ac85a0c000000b003a5849497f9so30114663qta.20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ksypm4g/dHsSdYfI6/rLPDOiA9C/16H1SAqXGRIbHCs=;
        b=PkTz8j+6trcWRrikm05vPGrKs46v88mz8EJoRlWgkvaXDDO5gfXyAdB2G5meOO8JtZ
         yZ/mP2dwoZUgb0NupJJSgBlpg5oScBiIx6FVzZj1r/twQzl7p1/HFHbIRNZIVcfqc/6L
         UJMGSBBhSwIyxPa7bcHjA3SPGfd7AGaNR7bKYsYZD+euukQ+65inFQE24X2ovjelYY7u
         K+bYpoeN10a0sPPM9+3su2MA/kZ+eJPphLuVpAAgYaNsB3nyi6j/W+tQvVVg9GRLR+JA
         khM2C2nKwtkRjLGj8LcwpJbGzwn4yOKYsquV48jMwyGro7i2m5nDVU25c59gKjIKjXLe
         jJKg==
X-Gm-Message-State: ANoB5pl8QQ/aTR+ExOQNQuiXM9wYvTNkq5lM/tfC7NhuijHingkythmy
        oDeN1jZu+HZTTc3kQ0zBTzuk5wCg3C/GQabyXc8weo/RAFEV044aXNI8BaKQPCNXX/1Z8LySqVJ
        pRyXObJSvjW4U6+SzMII6Y6A=
X-Received: by 2002:a0c:ee45:0:b0:4c6:e866:cccb with SMTP id m5-20020a0cee45000000b004c6e866cccbmr24214686qvs.42.1669825762807;
        Wed, 30 Nov 2022 08:29:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf58i74E4ozsHVqy3QaFXNW2a5FlzSd2OBkLkZvnKJ5pGAzXNyi3AjqZofl0YN8GWTW1NZMIMA==
X-Received: by 2002:a0c:ee45:0:b0:4c6:e866:cccb with SMTP id m5-20020a0cee45000000b004c6e866cccbmr24214655qvs.42.1669825762469;
        Wed, 30 Nov 2022 08:29:22 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a440f00b006ecfb2c86d3sm1431829qkp.130.2022.11.30.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:29:21 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:29:20 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Martin.Wilck@suse.com, snitzer@kernel.org, jack@suse.cz,
        ejt@redhat.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3] dm thin: Fix ABBA deadlock between shrink_slab and
 dm_pool_abort_metadata
Message-ID: <Y4eE4HVuXQZY4AMv@redhat.com>
References: <20221130133134.2870646-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130133134.2870646-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30 2022 at  8:31P -0500,
Zhihao Cheng <chengzhihao1@huawei.com> wrote:

> Following concurrent processes:
> 
>           P1(drop cache)                P2(kworker)
> drop_caches_sysctl_handler
>  drop_slab
>   shrink_slab
>    down_read(&shrinker_rwsem)  - LOCK A
>    do_shrink_slab
>     super_cache_scan
>      prune_icache_sb
>       dispose_list
>        evict
>         ext4_evict_inode
> 	 ext4_clear_inode
> 	  ext4_discard_preallocations
> 	   ext4_mb_load_buddy_gfp
> 	    ext4_mb_init_cache
> 	     ext4_read_block_bitmap_nowait
> 	      ext4_read_bh_nowait
> 	       submit_bh
> 	        dm_submit_bio
> 		                 do_worker
> 				  process_deferred_bios
> 				   commit
> 				    metadata_operation_failed
> 				     dm_pool_abort_metadata
> 				      down_write(&pmd->root_lock) - LOCK B
> 		                      __destroy_persistent_data_objects
> 				       dm_block_manager_destroy
> 				        dm_bufio_client_destroy
> 				         unregister_shrinker
> 					  down_write(&shrinker_rwsem)
> 		 thin_map                            |
> 		  dm_thin_find_block                 ↓
> 		   down_read(&pmd->root_lock) --> ABBA deadlock
> 
> , which triggers hung task:
> 
> [   76.974820] INFO: task kworker/u4:3:63 blocked for more than 15 seconds.
> [   76.976019]       Not tainted 6.1.0-rc4-00011-g8f17dd350364-dirty #910
> [   76.978521] task:kworker/u4:3    state:D stack:0     pid:63    ppid:2
> [   76.978534] Workqueue: dm-thin do_worker
> [   76.978552] Call Trace:
> [   76.978564]  __schedule+0x6ba/0x10f0
> [   76.978582]  schedule+0x9d/0x1e0
> [   76.978588]  rwsem_down_write_slowpath+0x587/0xdf0
> [   76.978600]  down_write+0xec/0x110
> [   76.978607]  unregister_shrinker+0x2c/0xf0
> [   76.978616]  dm_bufio_client_destroy+0x116/0x3d0
> [   76.978625]  dm_block_manager_destroy+0x19/0x40
> [   76.978629]  __destroy_persistent_data_objects+0x5e/0x70
> [   76.978636]  dm_pool_abort_metadata+0x8e/0x100
> [   76.978643]  metadata_operation_failed+0x86/0x110
> [   76.978649]  commit+0x6a/0x230
> [   76.978655]  do_worker+0xc6e/0xd90
> [   76.978702]  process_one_work+0x269/0x630
> [   76.978714]  worker_thread+0x266/0x630
> [   76.978730]  kthread+0x151/0x1b0
> [   76.978772] INFO: task test.sh:2646 blocked for more than 15 seconds.
> [   76.979756]       Not tainted 6.1.0-rc4-00011-g8f17dd350364-dirty #910
> [   76.982111] task:test.sh         state:D stack:0     pid:2646  ppid:2459
> [   76.982128] Call Trace:
> [   76.982139]  __schedule+0x6ba/0x10f0
> [   76.982155]  schedule+0x9d/0x1e0
> [   76.982159]  rwsem_down_read_slowpath+0x4f4/0x910
> [   76.982173]  down_read+0x84/0x170
> [   76.982177]  dm_thin_find_block+0x4c/0xd0
> [   76.982183]  thin_map+0x201/0x3d0
> [   76.982188]  __map_bio+0x5b/0x350
> [   76.982195]  dm_submit_bio+0x2b6/0x930
> [   76.982202]  __submit_bio+0x123/0x2d0
> [   76.982209]  submit_bio_noacct_nocheck+0x101/0x3e0
> [   76.982222]  submit_bio_noacct+0x389/0x770
> [   76.982227]  submit_bio+0x50/0xc0
> [   76.982232]  submit_bh_wbc+0x15e/0x230
> [   76.982238]  submit_bh+0x14/0x20
> [   76.982241]  ext4_read_bh_nowait+0xc5/0x130
> [   76.982247]  ext4_read_block_bitmap_nowait+0x340/0xc60
> [   76.982254]  ext4_mb_init_cache+0x1ce/0xdc0
> [   76.982259]  ext4_mb_load_buddy_gfp+0x987/0xfa0
> [   76.982263]  ext4_discard_preallocations+0x45d/0x830
> [   76.982274]  ext4_clear_inode+0x48/0xf0
> [   76.982280]  ext4_evict_inode+0xcf/0xc70
> [   76.982285]  evict+0x119/0x2b0
> [   76.982290]  dispose_list+0x43/0xa0
> [   76.982294]  prune_icache_sb+0x64/0x90
> [   76.982298]  super_cache_scan+0x155/0x210
> [   76.982303]  do_shrink_slab+0x19e/0x4e0
> [   76.982310]  shrink_slab+0x2bd/0x450
> [   76.982317]  drop_slab+0xcc/0x1a0
> [   76.982323]  drop_caches_sysctl_handler+0xb7/0xe0
> [   76.982327]  proc_sys_call_handler+0x1bc/0x300
> [   76.982331]  proc_sys_write+0x17/0x20
> [   76.982334]  vfs_write+0x3d3/0x570
> [   76.982342]  ksys_write+0x73/0x160
> [   76.982347]  __x64_sys_write+0x1e/0x30
> [   76.982352]  do_syscall_64+0x35/0x80
> [   76.982357]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Function metadata_operation_failed() is called when operations failed
> on dm pool metadata, dm pool will destroy and recreate metadata. So,
> shrinker will be unregistered and registered, which could down write
> shrinker_rwsem under pmd_write_lock.
> 
> Fix it by allocating dm_block_manager before locking pmd->root_lock
> and destroying old dm_block_manager after unlocking pmd->root_lock,
> then old dm_block_manager is replaced with new dm_block_manager under
> pmd->root_lock. So, shrinker register/unregister could be done without
> holding pmd->root_lock.
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216676
> Fixes: e49e582965b3 ("dm thin: add read only and fail io modes")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  v1->v2: Update fix strategy. Allocating/Destroying dm_block_manager
> 	 outside of lock pmd->root.
>  v2->v3: Move fail_io setting inside pmd->root lock.
>  drivers/md/dm-thin-metadata.c | 40 +++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
> index a27395c8621f..7729372519b8 100644
> --- a/drivers/md/dm-thin-metadata.c
> +++ b/drivers/md/dm-thin-metadata.c
> @@ -782,7 +782,6 @@ static void __destroy_persistent_data_objects(struct dm_pool_metadata *pmd)
>  	dm_sm_destroy(pmd->metadata_sm);
>  	dm_tm_destroy(pmd->nb_tm);
>  	dm_tm_destroy(pmd->tm);
> -	dm_block_manager_destroy(pmd->bm);
>  }
>  
>  static int __begin_transaction(struct dm_pool_metadata *pmd)
> @@ -988,8 +987,10 @@ int dm_pool_metadata_close(struct dm_pool_metadata *pmd)
>  			       __func__, r);
>  	}
>  	pmd_write_unlock(pmd);
> -	if (!pmd->fail_io)
> +	if (!pmd->fail_io) {
>  		__destroy_persistent_data_objects(pmd);
> +		dm_block_manager_destroy(pmd->bm);
> +	}
>  
>  	kfree(pmd);
>  	return 0;
> @@ -1860,19 +1861,46 @@ static void __set_abort_with_changes_flags(struct dm_pool_metadata *pmd)
>  int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
>  {
>  	int r = -EINVAL;
> +	struct dm_block_manager *old_bm = NULL, *new_bm = NULL;
>  
> -	pmd_write_lock(pmd);
>  	if (pmd->fail_io)
> +		return -EINVAL;
> +
> +	new_bm = dm_block_manager_create(pmd->bdev, THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
> +					 THIN_MAX_CONCURRENT_LOCKS);
> +
> +	pmd_write_lock(pmd);
> +	if (pmd->fail_io) {
> +		pmd_write_unlock(pmd);
>  		goto out;
> +	}
>  
>  	__set_abort_with_changes_flags(pmd);
>  	__destroy_persistent_data_objects(pmd);
> -	r = __create_persistent_data_objects(pmd, false);
> +	old_bm = pmd->bm;
> +	if (IS_ERR(new_bm)) {
> +		/* Return back if creating dm_block_manager failed. */
> +		DMERR("could not create block manager");
> +		pmd->bm = NULL;
> +		r = PTR_ERR(new_bm);
> +		goto out_unlock;
> +	}
> +
> +	pmd->bm = new_bm;
> +	r = __open_or_format_metadata(pmd, false);
> +	if (r) {
> +		pmd->bm = NULL;
> +		goto out_unlock;
> +	}
> +	new_bm = NULL;
> +out_unlock:
>  	if (r)
>  		pmd->fail_io = true;
> -
> -out:
>  	pmd_write_unlock(pmd);
> +	dm_block_manager_destroy(old_bm);
> +out:
> +	if (new_bm && !IS_ERR(new_bm))
> +		dm_block_manager_destroy(new_bm);
>  
>  	return r;
>  }
> -- 
> 2.31.1
> 

I've picked your patch up and folded into these following changes:

diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 7729372519b8..1a62226ac34e 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -776,12 +776,15 @@ static int __create_persistent_data_objects(struct dm_pool_metadata *pmd, bool f
 	return r;
 }
 
-static void __destroy_persistent_data_objects(struct dm_pool_metadata *pmd)
+static void __destroy_persistent_data_objects(struct dm_pool_metadata *pmd,
+					      bool destroy_bm)
 {
 	dm_sm_destroy(pmd->data_sm);
 	dm_sm_destroy(pmd->metadata_sm);
 	dm_tm_destroy(pmd->nb_tm);
 	dm_tm_destroy(pmd->tm);
+	if (destroy_bm)
+		dm_block_manager_destroy(pmd->bm);
 }
 
 static int __begin_transaction(struct dm_pool_metadata *pmd)
@@ -987,10 +990,8 @@ int dm_pool_metadata_close(struct dm_pool_metadata *pmd)
 			       __func__, r);
 	}
 	pmd_write_unlock(pmd);
-	if (!pmd->fail_io) {
-		__destroy_persistent_data_objects(pmd);
-		dm_block_manager_destroy(pmd->bm);
-	}
+	if (!pmd->fail_io)
+		__destroy_persistent_data_objects(pmd, true);
 
 	kfree(pmd);
 	return 0;
@@ -1863,9 +1864,16 @@ int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
 	int r = -EINVAL;
 	struct dm_block_manager *old_bm = NULL, *new_bm = NULL;
 
-	if (pmd->fail_io)
-		return -EINVAL;
+	/* fail_io is double-checked with pmd->root_lock held below */
+	if (unlikely(pmd->fail_io))
+		return r;
 
+	/*
+	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
+	 * pmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
+	 * shrinker associated with the block manager's bufio client vs pmd root_lock).
+	 * - must take shrinker_rwsem without holding pmd->root_lock
+	 */
 	new_bm = dm_block_manager_create(pmd->bdev, THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
 					 THIN_MAX_CONCURRENT_LOCKS);
 
@@ -1876,11 +1884,10 @@ int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
 	}
 
 	__set_abort_with_changes_flags(pmd);
-	__destroy_persistent_data_objects(pmd);
+	__destroy_persistent_data_objects(pmd, false);
 	old_bm = pmd->bm;
 	if (IS_ERR(new_bm)) {
-		/* Return back if creating dm_block_manager failed. */
-		DMERR("could not create block manager");
+		DMERR("could not create block manager during abort");
 		pmd->bm = NULL;
 		r = PTR_ERR(new_bm);
 		goto out_unlock;

