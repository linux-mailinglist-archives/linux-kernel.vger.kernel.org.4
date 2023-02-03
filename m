Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A0B689084
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjBCHSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjBCHSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:18:01 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3E32713
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:17:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VanhLDp_1675408675;
Received: from 30.97.48.205(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VanhLDp_1675408675)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 15:17:56 +0800
Message-ID: <43821f3b-26f2-828f-c9bc-0185d6e29739@linux.alibaba.com>
Date:   Fri, 3 Feb 2023 15:17:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] erofs: simplify instantiation of pseudo mount in
 fscache mode
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com, houtao1@huawei.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20230203034720.24619-1-jefflexu@linux.alibaba.com>
 <20230203034720.24619-2-jefflexu@linux.alibaba.com>
 <57f8d2a3-e00c-d281-708a-f1eb66257c69@linux.alibaba.com>
In-Reply-To: <57f8d2a3-e00c-d281-708a-f1eb66257c69@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/3 15:14, Gao Xiang wrote:
> 
> 
> On 2023/2/3 11:47, Jingbo Xu wrote:
>> Introduce a pseudo fs type dedicated to the pseudo mount of fscache
>> mode, so that the logic of real mount won't be messed up with that of
>> pseudo mount, making the implementation of fscache mode more
>> self-contained.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>   fs/erofs/fscache.c  | 46 +++++++++++++++++++++++++++------------------
>>   fs/erofs/internal.h |  6 ++++++
>>   fs/erofs/super.c    | 35 +++++++---------------------------
>>   3 files changed, 41 insertions(+), 46 deletions(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index af6ba52bbe8b..2eb42bbc56a4 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -6,12 +6,13 @@
>>   #include <linux/fscache.h>
>>   #include <linux/file.h>
>>   #include <linux/anon_inodes.h>
>> +#include <linux/pseudo_fs.h>
>>   #include "internal.h"
>>   static DEFINE_MUTEX(erofs_domain_list_lock);
>>   static DEFINE_MUTEX(erofs_domain_cookies_lock);
>>   static LIST_HEAD(erofs_domain_list);
>> -static struct vfsmount *erofs_pseudo_mnt;
>> +static struct vfsmount *erofs_pseudo_mnt __read_mostly;
>>   struct erofs_fscache_request {
>>       struct erofs_fscache_request *primary;
>> @@ -471,10 +472,6 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
>>       mutex_lock(&erofs_domain_list_lock);
>>       if (refcount_dec_and_test(&domain->ref)) {
>>           list_del(&domain->list);
>> -        if (list_empty(&erofs_domain_list)) {
>> -            kern_unmount(erofs_pseudo_mnt);
>> -            erofs_pseudo_mnt = NULL;
>> -        }
>>           mutex_unlock(&erofs_domain_list_lock);
>>           fscache_relinquish_volume(domain->volume, NULL, false);
>>           kfree(domain->domain_id);
>> @@ -526,15 +523,10 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>>       }
>>       err = erofs_fscache_register_volume(sb);
>> -    if (err)
>> -        goto out;
>> -
>> -    if (!erofs_pseudo_mnt) {
>> -        erofs_pseudo_mnt = kern_mount(&erofs_fs_type);
>> -        if (IS_ERR(erofs_pseudo_mnt)) {
>> -            err = PTR_ERR(erofs_pseudo_mnt);
>> -            goto out;
>> -        }
>> +    if (err) {
>> +        kfree(domain->domain_id);
>> +        kfree(domain);
>> +        return err;
>>       }
>>       domain->volume = sbi->volume;
>> @@ -542,10 +534,6 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>>       list_add(&domain->list, &erofs_domain_list);
>>       sbi->domain = domain;
>>       return 0;
>> -out:
>> -    kfree(domain->domain_id);
>> -    kfree(domain);
>> -    return err;
>>   }
>>   static int erofs_fscache_register_domain(struct super_block *sb)
>> @@ -780,3 +768,25 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>>       sbi->volume = NULL;
>>       sbi->domain = NULL;
>>   }
>> +
>> +static int erofs_fc_anon_get_tree(struct fs_context *fc)
>> +{
>> +    return PTR_ERR_OR_ZERO(init_pseudo(fc, EROFS_SUPER_MAGIC));
>> +}
>> +
>> +int __init erofs_fscache_init(void)
>> +{
>> +    static struct file_system_type erofs_anon_fs = {
>> +        .name        = "erofs_anonfs",
>> +        .init_fs_context = erofs_fc_anon_get_tree,
>> +        .kill_sb    = kill_anon_super,
>> +    };
> 
> 
> Please don't add another filesystem type, thanks.

I think it can be cleaned up nicely with Christoph's patchset, please help
follow if possible,
https://lore.kernel.org/linux-fsdevel/20210310083723.GC5217@lst.de/

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
