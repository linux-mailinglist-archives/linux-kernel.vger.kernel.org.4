Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6A714704
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjE2JZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjE2JZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:25:13 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679189E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:25:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VjkSzUZ_1685352307;
Received: from 30.221.134.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjkSzUZ_1685352307)
          by smtp.aliyun-inc.com;
          Mon, 29 May 2023 17:25:08 +0800
Message-ID: <2fa6114d-9de2-9a0d-ae89-c012914bf682@linux.alibaba.com>
Date:   Mon, 29 May 2023 17:25:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/6] erofs: use struct lockref to replace handcrafted
 approach
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
References: <20230526201459.128169-6-hsiangkao@linux.alibaba.com>
 <20230529072923.91736-1-hsiangkao@linux.alibaba.com>
 <20230529171629.0000292b.zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230529171629.0000292b.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/29 17:16, Yue Hu wrote:
> On Mon, 29 May 2023 15:29:23 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> Let's avoid the current handcrafted lockref although `struct lockref`
>> inclusion usually increases extra 4 bytes with an explicit spinlock if
>> CONFIG_DEBUG_SPINLOCK is off.
>>
>> Apart from the size difference, note that the meaning of refcount is
>> also changed to active users. IOWs, it doesn't take an extra refcount
>> for XArray tree insertion.
>>
>> I don't observe any significant performance difference at least on
>> our cloud compute server but the new one indeed simplifies the
>> overall codebase a bit.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> changes since v1:
>>   - fix reference leaking due to improper fallback of
>>     erofs_workgroup_put().
>>
>>   fs/erofs/internal.h | 38 ++------------------
>>   fs/erofs/utils.c    | 86 ++++++++++++++++++++++-----------------------
>>   fs/erofs/zdata.c    | 15 ++++----
>>   3 files changed, 52 insertions(+), 87 deletions(-)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 0b8506c39145..e63f6cd424a0 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -208,46 +208,12 @@ enum {
>>   	EROFS_ZIP_CACHE_READAROUND
>>   };
>>   
>> -#define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
>> -
>>   /* basic unit of the workstation of a super_block */
>>   struct erofs_workgroup {
>> -	/* the workgroup index in the workstation */
>>   	pgoff_t index;
>> -
>> -	/* overall workgroup reference count */
>> -	atomic_t refcount;
>> +	struct lockref lockref;
>>   };
>>   
>> -static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
>> -						 int val)
>> -{
>> -	preempt_disable();
>> -	if (val != atomic_cmpxchg(&grp->refcount, val, EROFS_LOCKED_MAGIC)) {
>> -		preempt_enable();
>> -		return false;
>> -	}
>> -	return true;
>> -}
>> -
>> -static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
>> -					    int orig_val)
>> -{
>> -	/*
>> -	 * other observers should notice all modifications
>> -	 * in the freezing period.
>> -	 */
>> -	smp_mb();
>> -	atomic_set(&grp->refcount, orig_val);
>> -	preempt_enable();
>> -}
>> -
>> -static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>> -{
>> -	return atomic_cond_read_relaxed(&grp->refcount,
>> -					VAL != EROFS_LOCKED_MAGIC);
>> -}
>> -
>>   enum erofs_kmap_type {
>>   	EROFS_NO_KMAP,		/* don't map the buffer */
>>   	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
>> @@ -492,7 +458,7 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
>>   void erofs_release_pages(struct page **pagepool);
>>   
>>   #ifdef CONFIG_EROFS_FS_ZIP
>> -int erofs_workgroup_put(struct erofs_workgroup *grp);
>> +void erofs_workgroup_put(struct erofs_workgroup *grp);
>>   struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>>   					     pgoff_t index);
>>   struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>> diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
>> index 46627cb69abe..6ed79f10e2e2 100644
>> --- a/fs/erofs/utils.c
>> +++ b/fs/erofs/utils.c
>> @@ -33,22 +33,21 @@ void erofs_release_pages(struct page **pagepool)
>>   /* global shrink count (for all mounted EROFS instances) */
>>   static atomic_long_t erofs_global_shrink_cnt;
>>   
>> -static int erofs_workgroup_get(struct erofs_workgroup *grp)
>> +static bool erofs_workgroup_get(struct erofs_workgroup *grp)
>>   {
>> -	int o;
>> +	if (lockref_get_not_zero(&grp->lockref))
>> +		return true;
>>   
>> -repeat:
>> -	o = erofs_wait_on_workgroup_freezed(grp);
>> -	if (o <= 0)
>> -		return -1;
>> -
>> -	if (atomic_cmpxchg(&grp->refcount, o, o + 1) != o)
>> -		goto repeat;
>> +	spin_lock(&grp->lockref.lock);
>> +	if (__lockref_is_dead(&grp->lockref)) {
>> +		spin_unlock(&grp->lockref.lock);
>> +		return false;
>> +	}
>>   
>> -	/* decrease refcount paired by erofs_workgroup_put */
>> -	if (o == 1)
>> +	if (!grp->lockref.count++)
>>   		atomic_long_dec(&erofs_global_shrink_cnt);
>> -	return 0;
>> +	spin_unlock(&grp->lockref.lock);
>> +	return true;
>>   }
> 
> May use lockref_get_not_dead() to simplify it a bit?

we need to get spin_lock() in the slow path and decrease
erofs_global_shrink_cnt in the lock.

> 
>>   
>>   struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>> @@ -61,7 +60,7 @@ struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>>   	rcu_read_lock();
>>   	grp = xa_load(&sbi->managed_pslots, index);
>>   	if (grp) {
>> -		if (erofs_workgroup_get(grp)) {
>> +		if (!erofs_workgroup_get(grp)) {
>>   			/* prefer to relax rcu read side */
>>   			rcu_read_unlock();
>>   			goto repeat;
>> @@ -80,11 +79,10 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>>   	struct erofs_workgroup *pre;
>>   
>>   	/*
>> -	 * Bump up a reference count before making this visible
>> -	 * to others for the XArray in order to avoid potential
>> -	 * UAF without serialized by xa_lock.
>> +	 * Bump up before making this visible to others for the XArray in order
>> +	 * to avoid potential UAF without serialized by xa_lock.
>>   	 */
>> -	atomic_inc(&grp->refcount);
>> +	lockref_get(&grp->lockref);
>>   
>>   repeat:
>>   	xa_lock(&sbi->managed_pslots);
>> @@ -93,13 +91,13 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>>   	if (pre) {
>>   		if (xa_is_err(pre)) {
>>   			pre = ERR_PTR(xa_err(pre));
>> -		} else if (erofs_workgroup_get(pre)) {
>> +		} else if (!erofs_workgroup_get(pre)) {
>>   			/* try to legitimize the current in-tree one */
>>   			xa_unlock(&sbi->managed_pslots);
>>   			cond_resched();
>>   			goto repeat;
>>   		}
>> -		atomic_dec(&grp->refcount);
>> +		lockref_put_return(&grp->lockref);
> 
> Should check return error?

nope, just dec one since it always has a refcount to decrease.

> 
>>   		grp = pre;
>>   	}
>>   	xa_unlock(&sbi->managed_pslots);
>> @@ -112,38 +110,35 @@ static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
>>   	erofs_workgroup_free_rcu(grp);
>>   }
>>   
>> -int erofs_workgroup_put(struct erofs_workgroup *grp)
>> +void erofs_workgroup_put(struct erofs_workgroup *grp)
>>   {
>> -	int count = atomic_dec_return(&grp->refcount);
>> +	if (lockref_put_not_zero(&grp->lockref))
>> +		return;
> 
> May use lockref_put_or_lock() to avoid following lock?

Thanks! Let me try this.

Thanks,
Gao Xiang
