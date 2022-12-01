Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495E163E783
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLACLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLACLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:11:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654B9D811
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:11:02 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NN00C2S1xzmVtn;
        Thu,  1 Dec 2022 10:10:19 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 10:11:00 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 10:10:59 +0800
Subject: Re: [PATCH v3] dm thin: Fix ABBA deadlock between shrink_slab and
 dm_pool_abort_metadata
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <Martin.Wilck@suse.com>, <snitzer@kernel.org>, <jack@suse.cz>,
        <ejt@redhat.com>, <linux-kernel@vger.kernel.org>,
        <dm-devel@redhat.com>, <yi.zhang@huawei.com>
References: <20221130133134.2870646-1-chengzhihao1@huawei.com>
 <Y4eE4HVuXQZY4AMv@redhat.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <dc77578e-3fbc-d3f7-d38b-bd4ad34c09ee@huawei.com>
Date:   Thu, 1 Dec 2022 10:10:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <Y4eE4HVuXQZY4AMv@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 30 2022 at  8:31P -0500
> Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> 
>> Following concurrent processes:
>>
>>            P1(drop cache)                P2(kworker)
[...]
>> 2.31.1
>>
> 
> I've picked your patch up and folded into these following changes:
> 
> diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
> index 7729372519b8..1a62226ac34e 100644
> --- a/drivers/md/dm-thin-metadata.c
> +++ b/drivers/md/dm-thin-metadata.c
> @@ -776,12 +776,15 @@ static int __create_persistent_data_objects(struct dm_pool_metadata *pmd, bool f
>   	return r;
>   }
>   
> -static void __destroy_persistent_data_objects(struct dm_pool_metadata *pmd)
> +static void __destroy_persistent_data_objects(struct dm_pool_metadata *pmd,
> +					      bool destroy_bm)
>   {
>   	dm_sm_destroy(pmd->data_sm);
>   	dm_sm_destroy(pmd->metadata_sm);
>   	dm_tm_destroy(pmd->nb_tm);
>   	dm_tm_destroy(pmd->tm);
> +	if (destroy_bm)
> +		dm_block_manager_destroy(pmd->bm);
>   }
>   
>   static int __begin_transaction(struct dm_pool_metadata *pmd)
> @@ -987,10 +990,8 @@ int dm_pool_metadata_close(struct dm_pool_metadata *pmd)
>   			       __func__, r);
>   	}
>   	pmd_write_unlock(pmd);
> -	if (!pmd->fail_io) {
> -		__destroy_persistent_data_objects(pmd);
> -		dm_block_manager_destroy(pmd->bm);
> -	}
> +	if (!pmd->fail_io)
> +		__destroy_persistent_data_objects(pmd, true);
>   
>   	kfree(pmd);
>   	return 0;
> @@ -1863,9 +1864,16 @@ int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
>   	int r = -EINVAL;
>   	struct dm_block_manager *old_bm = NULL, *new_bm = NULL;
>   
> -	if (pmd->fail_io)
> -		return -EINVAL;
> +	/* fail_io is double-checked with pmd->root_lock held below */
> +	if (unlikely(pmd->fail_io))
> +		return r;
>   
> +	/*
> +	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
> +	 * pmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
> +	 * shrinker associated with the block manager's bufio client vs pmd root_lock).
> +	 * - must take shrinker_rwsem without holding pmd->root_lock
> +	 */
>   	new_bm = dm_block_manager_create(pmd->bdev, THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
>   					 THIN_MAX_CONCURRENT_LOCKS);
>   
> @@ -1876,11 +1884,10 @@ int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
>   	}
>   
>   	__set_abort_with_changes_flags(pmd);
> -	__destroy_persistent_data_objects(pmd);
> +	__destroy_persistent_data_objects(pmd, false);
>   	old_bm = pmd->bm;
>   	if (IS_ERR(new_bm)) {
> -		/* Return back if creating dm_block_manager failed. */
> -		DMERR("could not create block manager");
> +		DMERR("could not create block manager during abort");
>   		pmd->bm = NULL;
>   		r = PTR_ERR(new_bm);
>   		goto out_unlock;
> 

Hi,Mike
This version is great, thanks for reviewing and modifying.

