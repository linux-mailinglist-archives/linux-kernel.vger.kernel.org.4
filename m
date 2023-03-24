Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6536B6C7AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjCXJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjCXJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:03:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3851BFE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:03:27 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PjbnV1qFQzrWGT;
        Fri, 24 Mar 2023 17:02:22 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 17:03:25 +0800
Subject: Re: [PATCH -next v6 2/2] mm/zswap: delay the initializaton of zswap
To:     Christoph Hellwig <hch@lst.de>
References: <20230322102006.780624-1-liushixin2@huawei.com>
 <20230322102006.780624-3-liushixin2@huawei.com>
 <20230323080443.GC20444@lst.de>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <d1cc88a1-4df2-977d-c1d1-018c2fbded62@huawei.com>
Date:   Fri, 24 Mar 2023 17:03:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230323080443.GC20444@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/23 16:04, Christoph Hellwig wrote:
> On Wed, Mar 22, 2023 at 06:20:06PM +0800, Liu Shixin wrote:
>> Since some users may not use zswap, the zswap_pool is wasted. Save memory
>> by delaying the initialization of zswap until enabled.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  mm/zswap.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 41 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 09fa956920fa..3aed3b26524a 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -81,6 +81,8 @@ static bool zswap_pool_reached_full;
>>  
>>  #define ZSWAP_PARAM_UNSET ""
>>  
>> +static int zswap_setup(void);
>> +
>>  /* Enable/disable zswap */
>>  static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
>>  static int zswap_enabled_param_set(const char *,
>> @@ -220,6 +222,9 @@ static bool zswap_init_started;
>>  /* fatal error during init */
>>  static bool zswap_init_failed;
>>  
>> +/* used to ensure the integrity of initialization */
>> +static DEFINE_MUTEX(zswap_init_lock);
>> +
>>  /* init completed, but couldn't create the initial pool */
>>  static bool zswap_has_pool;
>>  
>> @@ -272,13 +277,13 @@ static void zswap_update_total_size(void)
>>  **********************************/
>>  static struct kmem_cache *zswap_entry_cache;
>>  
>> -static int __init zswap_entry_cache_create(void)
>> +static int zswap_entry_cache_create(void)
>>  {
>>  	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
>>  	return zswap_entry_cache == NULL;
>>  }
> Please add a cleanup patch to remove this helper first, it just
> massivel confuses the reader.
I will, thanks.
>
>> -static void __init zswap_entry_cache_destroy(void)
>> +static void zswap_entry_cache_destroy(void)
>>  {
>>  	kmem_cache_destroy(zswap_entry_cache);
>>  }
> Same here.
>
>> @@ -663,7 +668,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>  	return NULL;
>>  }
>>  
>> -static __init struct zswap_pool *__zswap_pool_create_fallback(void)
>> +static struct zswap_pool *__zswap_pool_create_fallback(void)
>>  {
>>  	bool has_comp, has_zpool;
>>  
>> @@ -784,8 +789,15 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>>  	/* if this is load-time (pre-init) param setting,
>>  	 * don't create a pool; that's done during init.
>>  	 */
>> -	if (!zswap_init_started)
>> -		return param_set_charp(s, kp);
>> +	if (!zswap_init_started) {
>> +		mutex_lock(&zswap_init_lock);
>> +		if (!zswap_init_started) {
>> +			ret = param_set_charp(s, kp);
>> +			mutex_unlock(&zswap_init_lock);
>> +			return ret;
>> +		}
>> +		mutex_unlock(&zswap_init_lock);
>> +	}
> Just take the lock around the whole function.  No need to micro-optimize
> setting a kernel paramter.
I will, thanks.
>
>> @@ -884,6 +896,15 @@ static int zswap_enabled_param_set(const char *val,
>>  	if (res == *(bool *)kp->arg)
>>  		return 0;
>>  
>> +	if (!zswap_init_started && (system_state == SYSTEM_RUNNING)) {
> No need for the inner braces.  But directly looking at
> SYSTEM_RUNNING, especially without a comment is a bit of a mess.
> Is there any better way to deal with this?
I have no idea about better way.
>
> Also the zswap_init_started variable name has always been a bit
> confusing.  If everything around it takes zswap_init_lock now,
> it can be replaced with a check for successful zswap initialization
> as all the initializtion is covered by the lock.  That would really
> help to clean up the code.
I will, thanks.
>
>> +static int zswap_debugfs_init(void)
>>  {
>>  	if (!debugfs_initialized())
>>  		return -ENODEV;
>> @@ -1482,7 +1503,7 @@ static int __init zswap_debugfs_init(void)
>>  	return 0;
>>  }
>>  #else
>> -static int __init zswap_debugfs_init(void)
>> +static int zswap_debugfs_init(void)
> Is there any reason to not just always initialize debugfs and
> only defer the expensive allocations?
It seems there is no need to initialize debugfs if zswap is not used.

>
> .
>

