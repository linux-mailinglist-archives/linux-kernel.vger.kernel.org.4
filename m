Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AD64AD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiLMBeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiLMBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:34:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED96260C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:34:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D687612F0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0231C433D2;
        Tue, 13 Dec 2022 01:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670895252;
        bh=5F/j4xwM/YBGfVvyNUwQ0f9CiSZeQmeQY4Oj9b1UjoM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nH+5/FLb6fsqT8duWXnGDiAkz8ogmkw7nQKpU5H2P8kggpAYHlXp8orKIJM97UfOJ
         b9i442J59MWt7/RRozxcSj+YIbzPFkyhsFccxr621c0NlZ1kDrEPGwkN8odFbIYgK9
         WdGwz4HnLWoWyuKOZJ9gma/dIwJ3npkEvM/x+lHzpLc3Ko3uTSL/XxQJPx1yL1LSby
         TWLLVDMqGRftoOuO1HIaIcAcAcP+ZoTbubOm9iT7BNQ1dPE1t+7pj2jVCRcQ1taz/r
         4uFZh8z7FrVd3O0m6qO3fe7yZzGgAGsPVFCQZ/gtceJjH+42EqVYQqJMTYhPnVPq66
         wJUY171WdL0PA==
Message-ID: <c1daf309-a44d-46a8-7f97-bf5aab63aa9a@kernel.org>
Date:   Tue, 13 Dec 2022 09:34:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: do some cleanup for f2fs module init
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221125114736.19423-1-frank.li@vivo.com>
 <b8c54a6b-1f6d-9a86-b87c-e980902aa3a3@kernel.org>
 <Y5ewzsPuCd5UbCCJ@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y5ewzsPuCd5UbCCJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/13 6:53, Jaegeuk Kim wrote:
> On 12/11, Chao Yu wrote:
>> On 2022/11/25 19:47, Yangtao Li wrote:
>>> Just for cleanup, no functional changes.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>    fs/f2fs/compress.c | 46 ++++++----------------------------------------
>>>    fs/f2fs/data.c     | 14 ++++----------
>>>    fs/f2fs/gc.c       |  4 +---
>>>    fs/f2fs/recovery.c |  4 +---
>>>    fs/f2fs/super.c    |  8 ++------
>>>    5 files changed, 14 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>> index d315c2de136f..f920ba8e0e85 100644
>>> --- a/fs/f2fs/compress.c
>>> +++ b/fs/f2fs/compress.c
>>> @@ -567,10 +567,7 @@ MODULE_PARM_DESC(num_compress_pages,
>>>    int f2fs_init_compress_mempool(void)
>>>    {
>>>    	compress_page_pool = mempool_create_page_pool(num_compress_pages, 0);
>>> -	if (!compress_page_pool)
>>> -		return -ENOMEM;
>>> -
>>> -	return 0;
>>> +	return compress_page_pool ? 0 : -ENOMEM;
>>
>> I don't think this needs cleanup, other part looks good to me.
> 
> What is the point here comparing to the below? fyi; I picked this change.

IIUC, the question is for Yangtao? :P

Thanks,

> 
>>
>> Thanks,
>>
>>>    }
>>>    void f2fs_destroy_compress_mempool(void)
>>> @@ -1983,9 +1980,7 @@ int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi)
>>>    	sbi->page_array_slab = f2fs_kmem_cache_create(slab_name,
>>>    					sbi->page_array_slab_size);
>>> -	if (!sbi->page_array_slab)
>>> -		return -ENOMEM;
>>> -	return 0;
>>> +	return sbi->page_array_slab ? 0 : -ENOMEM;
>>>    }
>>>    void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi)
>>> @@ -1993,53 +1988,24 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi)
>>>    	kmem_cache_destroy(sbi->page_array_slab);
>>>    }
>>> -static int __init f2fs_init_cic_cache(void)
>>> +int __init f2fs_init_compress_cache(void)
>>>    {
>>>    	cic_entry_slab = f2fs_kmem_cache_create("f2fs_cic_entry",
>>>    					sizeof(struct compress_io_ctx));
>>>    	if (!cic_entry_slab)
>>>    		return -ENOMEM;
>>> -	return 0;
>>> -}
>>> -
>>> -static void f2fs_destroy_cic_cache(void)
>>> -{
>>> -	kmem_cache_destroy(cic_entry_slab);
>>> -}
>>> -
>>> -static int __init f2fs_init_dic_cache(void)
>>> -{
>>>    	dic_entry_slab = f2fs_kmem_cache_create("f2fs_dic_entry",
>>>    					sizeof(struct decompress_io_ctx));
>>>    	if (!dic_entry_slab)
>>> -		return -ENOMEM;
>>> -	return 0;
>>> -}
>>> -
>>> -static void f2fs_destroy_dic_cache(void)
>>> -{
>>> -	kmem_cache_destroy(dic_entry_slab);
>>> -}
>>> -
>>> -int __init f2fs_init_compress_cache(void)
>>> -{
>>> -	int err;
>>> -
>>> -	err = f2fs_init_cic_cache();
>>> -	if (err)
>>> -		goto out;
>>> -	err = f2fs_init_dic_cache();
>>> -	if (err)
>>>    		goto free_cic;
>>>    	return 0;
>>>    free_cic:
>>> -	f2fs_destroy_cic_cache();
>>> -out:
>>> +	kmem_cache_destroy(cic_entry_slab);
>>>    	return -ENOMEM;
>>>    }
>>>    void f2fs_destroy_compress_cache(void)
>>>    {
>>> -	f2fs_destroy_dic_cache();
>>> -	f2fs_destroy_cic_cache();
>>> +	kmem_cache_destroy(dic_entry_slab);
>>> +	kmem_cache_destroy(cic_entry_slab);
>>>    }
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 560fa80590e9..35c19248b1e2 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -39,10 +39,8 @@ static struct bio_set f2fs_bioset;
>>>    int __init f2fs_init_bioset(void)
>>>    {
>>> -	if (bioset_init(&f2fs_bioset, F2FS_BIO_POOL_SIZE,
>>> -					0, BIOSET_NEED_BVECS))
>>> -		return -ENOMEM;
>>> -	return 0;
>>> +	return bioset_init(&f2fs_bioset, F2FS_BIO_POOL_SIZE,
>>> +					0, BIOSET_NEED_BVECS);
>>>    }
>>>    void f2fs_destroy_bioset(void)
>>> @@ -4090,9 +4088,7 @@ int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi)
>>>    	sbi->post_read_wq = alloc_workqueue("f2fs_post_read_wq",
>>>    						 WQ_UNBOUND | WQ_HIGHPRI,
>>>    						 num_online_cpus());
>>> -	if (!sbi->post_read_wq)
>>> -		return -ENOMEM;
>>> -	return 0;
>>> +	return sbi->post_read_wq ? 0 : -ENOMEM;
>>>    }
>>>    void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi)
>>> @@ -4105,9 +4101,7 @@ int __init f2fs_init_bio_entry_cache(void)
>>>    {
>>>    	bio_entry_slab = f2fs_kmem_cache_create("f2fs_bio_entry_slab",
>>>    			sizeof(struct bio_entry));
>>> -	if (!bio_entry_slab)
>>> -		return -ENOMEM;
>>> -	return 0;
>>> +	return bio_entry_slab ? 0 : -ENOMEM;
>>>    }
>>>    void f2fs_destroy_bio_entry_cache(void)
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 0f967b1e98f2..4b0d2fa3a769 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1903,9 +1903,7 @@ int __init f2fs_create_garbage_collection_cache(void)
>>>    {
>>>    	victim_entry_slab = f2fs_kmem_cache_create("f2fs_victim_entry",
>>>    					sizeof(struct victim_entry));
>>> -	if (!victim_entry_slab)
>>> -		return -ENOMEM;
>>> -	return 0;
>>> +	return victim_entry_slab ? 0 : -ENOMEM;
>>>    }
>>>    void f2fs_destroy_garbage_collection_cache(void)
>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>> index dea95b48b647..77fd453949b1 100644
>>> --- a/fs/f2fs/recovery.c
>>> +++ b/fs/f2fs/recovery.c
>>> @@ -923,9 +923,7 @@ int __init f2fs_create_recovery_cache(void)
>>>    {
>>>    	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
>>>    					sizeof(struct fsync_inode_entry));
>>> -	if (!fsync_entry_slab)
>>> -		return -ENOMEM;
>>> -	return 0;
>>> +	return fsync_entry_slab ? 0 : -ENOMEM;
>>>    }
>>>    void f2fs_destroy_recovery_cache(void)
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 31435c8645c8..1d56cba495a5 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -288,9 +288,7 @@ static int __init f2fs_create_casefold_cache(void)
>>>    {
>>>    	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
>>>    							F2FS_NAME_LEN);
>>> -	if (!f2fs_cf_name_slab)
>>> -		return -ENOMEM;
>>> -	return 0;
>>> +	return f2fs_cf_name_slab ? 0 : -ENOMEM;
>>>    }
>>>    static void f2fs_destroy_casefold_cache(void)
>>> @@ -4646,9 +4644,7 @@ static int __init init_inodecache(void)
>>>    	f2fs_inode_cachep = kmem_cache_create("f2fs_inode_cache",
>>>    			sizeof(struct f2fs_inode_info), 0,
>>>    			SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT, NULL);
>>> -	if (!f2fs_inode_cachep)
>>> -		return -ENOMEM;
>>> -	return 0;
>>> +	return f2fs_inode_cachep ? 0 : -ENOMEM;
>>>    }
>>>    static void destroy_inodecache(void)
