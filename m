Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664FA61288A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 07:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJ3Gve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 02:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJ3GvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 02:51:16 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31D6460;
        Sat, 29 Oct 2022 23:40:40 -0700 (PDT)
Received: from [192.168.43.182] (unknown [62.168.35.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 430FE422D9;
        Sun, 30 Oct 2022 06:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667111553;
        bh=xkSnknPxxVweECBoJ9f7wG975t4vI0S18ubt+rSkvkE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=aPokHxtPE9dQDYINLvcJyOW155igJoYuYTp0A2CpLja10lpAxuMSFfeEdpYYPedPb
         vTW/53O9f2nU690wO5GqmIHwIKWJJkKSQhPkPE699FxBIQrm9j62YMPdxdUCMyyJ72
         ADmgzdduI5a1hy938VRxdXjmwh2dEpTKLpeRwsdELEEoUJklDVco/calIRMoNMOdnX
         cwH5r4BybIxOsF0TzE04EGgMp8AYp2TAMhh65Jfn2J4TlyfQD6eaJZ2c3Pjbrl61/I
         8WrdhkahqNT7JlThehY2COe0z6vF9W7gs8GcWtYADka0FvY25QHhyq7YFOefyQeQCe
         DhptmBmXheuQg==
Message-ID: <3acbdcfc-4763-f720-8897-03a5670452d1@canonical.com>
Date:   Sat, 29 Oct 2022 23:32:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: apparmor: global buffers spin lock may get contended
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <YO2S+C7Cw7AS7bsg@google.com>
 <20221030013028.3557-1-hdanton@sina.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221030013028.3557-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 18:30, Hillf Danton wrote:
> On 28 Oct 2022 02:34:07 -0700 John Johansen <john.johansen@canonical.com>
>> On 7/13/21 06:19, Sergey Senozhatsky wrote:
>>> Hi,
>>>
>>> We've notices that apparmor has switched from using per-CPU buffer pool
>>> and per-CPU spin_lock to a global spin_lock in df323337e507a0009d3db1ea.
>>>
>>> This seems to be causing some contention on our build machines (with
>>> quite a bit of cores). Because that global spin lock is a part of the
>>> stat() sys call (and perhaps some other)
>>>
>>> E.g.
>>>
>>> -    9.29%     0.00%  clang++          [kernel.vmlinux]
>>>      - 9.28% entry_SYSCALL_64_after_hwframe
>>>         - 8.98% do_syscall_64
>>>            - 7.43% __do_sys_newlstat
>>>               - 7.43% vfs_statx
>>>                  - 7.18% security_inode_getattr
>>>                     - 7.15% apparmor_inode_getattr
>>>                        - aa_path_perm
>>>                           - 3.53% aa_get_buffer
>>>                              - 3.47% _raw_spin_lock
>>>                                   3.44% native_queued_spin_lock_slowpath
>>>                           - 3.49% aa_put_buffer.part.0
>>>                              - 3.45% _raw_spin_lock
>>>                                   3.43% native_queued_spin_lock_slowpath
>>>
>>> Can we fix this contention?
>>
>> sorry for the delay on this. Below is a proposed patch that I have been testing
>> to deal with this issue.
>>
>>
>>   From d026988196fdbda7234fb87bc3e4aea22edcbaf9 Mon Sep 17 00:00:00 2001
>> From: John Johansen <john.johansen@canonical.com>
>> Date: Tue, 25 Oct 2022 01:18:41 -0700
>> Subject: [PATCH] apparmor: cache buffers on percpu list if there is lock contention
>>
>> On a heavily loaded machine there can be lock contention on the
>> global buffers lock. Add a percpu list to cache buffers on when
>> lock contention is encountered.
>>
>> When allocating buffers attempt to use cached buffers first,
>> before taking the global buffers lock. When freeing buffers
>> try to put them back to the global list but if contention is
>> encountered, put the buffer on the percpu list.
>>
>> The length of time a buffer is held on the percpu list is dynamically
>> adjusted based on lock contention.  The amount of hold time is rapidly
>> increased and slow ramped down.
>>
>> Signed-off-by: John Johansen <john.johansen@canonical.com>
>> ---
>>    security/apparmor/lsm.c | 74 ++++++++++++++++++++++++++++++++++++++---
>>    1 file changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 25114735bc11..0ab70171bdb6 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -49,12 +49,19 @@ union aa_buffer {
>>    	char buffer[1];
>>    };
>>    
>> +struct aa_local_cache {
>> +	unsigned int contention;
>> +	unsigned int hold;
>> +	struct list_head head;
>> +};
>> +
>>    #define RESERVE_COUNT 2
>>    static int reserve_count = RESERVE_COUNT;
>>    static int buffer_count;
>>    
>>    static LIST_HEAD(aa_global_buffers);
>>    static DEFINE_SPINLOCK(aa_buffers_lock);
>> +static DEFINE_PER_CPU(struct aa_local_cache, aa_local_buffers);
>>    
>>    /*
>>     * LSM hook functions
>> @@ -1622,14 +1629,44 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
>>    	return 0;
>>    }
>>    
>> +static void update_contention(struct aa_local_cache *cache)
>> +{
>> +	cache->contention += 3;
>> +	if (cache->contention > 9)
>> +		cache->contention = 9;
>> +	cache->hold += 1 << cache->contention;		/* 8, 64, 512 */
>> +}
>> +
>>    char *aa_get_buffer(bool in_atomic)
>>    {
>>    	union aa_buffer *aa_buf;
>> +	struct aa_local_cache *cache;
>>    	bool try_again = true;
>>    	gfp_t flags = (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>>    
>> +	/* use per cpu cached buffers first */
>> +	cache = get_cpu_ptr(&aa_local_buffers);
>> +	if (!list_empty(&cache->head)) {
>> +		aa_buf = list_first_entry(&cache->head, union aa_buffer, list);
>> +		list_del(&aa_buf->list);
>> +		cache->hold--;
>> +		put_cpu_ptr(&aa_local_buffers);
>> +		return &aa_buf->buffer[0];
>> +	}
>> +	put_cpu_ptr(&aa_local_buffers);
>> +
>> +	if (!spin_trylock(&aa_buffers_lock)) {
>> +		cache = get_cpu_ptr(&aa_local_buffers);
>> +		update_contention(cache);
>> +		put_cpu_ptr(&aa_local_buffers);
>> +		spin_lock(&aa_buffers_lock);
>> +	} else {
>> +		cache = get_cpu_ptr(&aa_local_buffers);
>> +		if (cache->contention)
>> +			cache->contention--;
>> +		put_cpu_ptr(&aa_local_buffers);
>> +	}
>>    retry:
>> -	spin_lock(&aa_buffers_lock);
>>    	if (buffer_count > reserve_count ||
>>    	    (in_atomic && !list_empty(&aa_global_buffers))) {
>>    		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
>> @@ -1655,6 +1692,7 @@ char *aa_get_buffer(bool in_atomic)
>>    	if (!aa_buf) {
>>    		if (try_again) {
>>    			try_again = false;
>> +			spin_lock(&aa_buffers_lock);
>>    			goto retry;
>>    		}
>>    		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
>> @@ -1666,15 +1704,32 @@ char *aa_get_buffer(bool in_atomic)
>>    void aa_put_buffer(char *buf)
>>    {
>>    	union aa_buffer *aa_buf;
>> +	struct aa_local_cache *cache;
>>    
>>    	if (!buf)
>>    		return;
>>    	aa_buf = container_of(buf, union aa_buffer, buffer[0]);
>>    
>> -	spin_lock(&aa_buffers_lock);
>> -	list_add(&aa_buf->list, &aa_global_buffers);
>> -	buffer_count++;
>> -	spin_unlock(&aa_buffers_lock);
>> +	cache = get_cpu_ptr(&aa_local_buffers);
>> +	if (!cache->hold) {
>> +		put_cpu_ptr(&aa_local_buffers);
>> +		if (spin_trylock(&aa_buffers_lock)) {
>> +			list_add(&aa_buf->list, &aa_global_buffers);
>> +			buffer_count++;
> 
> Given !hold and trylock, right time to drain the perpcu cache?
> 

yes hold is a count of how long (or in this case a count of how many
times) to allocate from the local from the percpu cache before trying
to return to the global buffer pool. When the time/count hits zero
its time to try and return it.

If we succeed the try lock then we succeeded taking the global buffer
pool lock without contention and we can add the buffer back in.

As for the other cases

hold == 0 and fail to grab the lock
- contention is recorded and we add the buffer back to the percpu cache

hold > 0
- decrease hold and add back to the percpu cache

Since we never try and grab the spinlock if hold > 0, the lock variations
do not need to be considered.

>> +			spin_unlock(&aa_buffers_lock);
>> +			cache = get_cpu_ptr(&aa_local_buffers);
>> +			if (cache->contention)
>> +				cache->contention--;
>> +			put_cpu_ptr(&aa_local_buffers);
>> +			return;
>> +		}
>> +		cache = get_cpu_ptr(&aa_local_buffers);
>> +		update_contention(cache);
>> +	}
>> +
>> +	/* cache in percpu list */
>> +	list_add(&aa_buf->list, &cache->head);
>> +	put_cpu_ptr(&aa_local_buffers);
>>    }
>>    
>>    /*
>> @@ -1716,6 +1771,15 @@ static int __init alloc_buffers(void)
>>    	union aa_buffer *aa_buf;
>>    	int i, num;
>>    
>> +	/*
>> +	 * per cpu set of cached allocated buffers used to help reduce
>> +	 * lock contention
>> +	 */
>> +	for_each_possible_cpu(i) {
>> +		per_cpu(aa_local_buffers, i).contention = 0;
>> +		per_cpu(aa_local_buffers, i).hold = 0;
>> +		INIT_LIST_HEAD(&per_cpu(aa_local_buffers, i).head);
>> +	}
>>    	/*
>>    	 * A function may require two buffers at once. Usually the buffers are
>>    	 * used for a short period of time and are shared. On UP kernel buffers
>> -- 
>> 2.34.1

