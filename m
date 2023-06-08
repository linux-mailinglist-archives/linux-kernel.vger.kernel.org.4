Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F7728A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbjFHVfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjFHVfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:35:46 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E472D63;
        Thu,  8 Jun 2023 14:35:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qccdv3tJDz9v7Jk;
        Fri,  9 Jun 2023 05:23:47 +0800 (CST)
Received: from [10.81.214.99] (unknown [10.81.214.99])
        by APP2 (Coremail) with SMTP id GxC2BwCXUkmdSYJkKw0ZAw--.4340S2;
        Thu, 08 Jun 2023 22:35:31 +0100 (CET)
Message-ID: <77fb9677-8d5c-73e0-41d2-6b3c5040053e@huaweicloud.com>
Date:   Thu, 8 Jun 2023 23:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] shmem: Use ramfs_kill_sb() for kill_sb method of
 ramfs-based tmpfs
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
References: <20230607161523.2876433-1-roberto.sassu@huaweicloud.com>
 <20230607104313.2909afb61021a1431dc56a28@linux-foundation.org>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20230607104313.2909afb61021a1431dc56a28@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCXUkmdSYJkKw0ZAw--.4340S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47WF45Gw1DZrWUAF48Xrb_yoW5JFWDpF
        1kAF18Cr40gFyUZas29a10v34Sgw4kKr1vk34vv34rtasxtr1kKF1vkr4a9ryrurW0gryF
        vr4qgFy3uFWYyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBF1jj45wWwAAsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/2023 7:43 PM, Andrew Morton wrote:
> (cc's added)

Ok. Recently, I started to automatize the recipients of the emails with 
a script that takes the output of get_maintainer.pl and takes only the 
maintainer, supporter and reviewer lines. Maybe I should add also 
blamed_fixes.

> On Wed,  7 Jun 2023 18:15:23 +0200 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> As the ramfs-based tmpfs uses ramfs_init_fs_context() for the
>> init_fs_context method, which allocates fc->s_fs_info, use ramfs_kill_sb()
>> to free it and avoid a memory leak.
>>
>> Cc: stable@vger.kernel.org # v5.4.x
>> Fixes: f32356261d44 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")

As I mentioned in the other thread, the correct Fixes tag is:

Fixes: c3b1b1cbf002 ("ramfs: add support for "mode=" mount option")

of course, if it can be modified at this stage.

Thanks

Roberto

>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   fs/ramfs/inode.c      | 2 +-
>>   include/linux/ramfs.h | 1 +
>>   mm/shmem.c            | 2 +-
>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
>> index 5ba580c7883..fef477c7810 100644
>> --- a/fs/ramfs/inode.c
>> +++ b/fs/ramfs/inode.c
>> @@ -278,7 +278,7 @@ int ramfs_init_fs_context(struct fs_context *fc)
>>   	return 0;
>>   }
>>   
>> -static void ramfs_kill_sb(struct super_block *sb)
>> +void ramfs_kill_sb(struct super_block *sb)
>>   {
>>   	kfree(sb->s_fs_info);
>>   	kill_litter_super(sb);
>> diff --git a/include/linux/ramfs.h b/include/linux/ramfs.h
>> index 917528d102c..d506dc63dd4 100644
>> --- a/include/linux/ramfs.h
>> +++ b/include/linux/ramfs.h
>> @@ -7,6 +7,7 @@
>>   struct inode *ramfs_get_inode(struct super_block *sb, const struct inode *dir,
>>   	 umode_t mode, dev_t dev);
>>   extern int ramfs_init_fs_context(struct fs_context *fc);
>> +extern void ramfs_kill_sb(struct super_block *sb);
>>   
>>   #ifdef CONFIG_MMU
>>   static inline int
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index e40a08c5c6d..74abb97ea55 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -4196,7 +4196,7 @@ static struct file_system_type shmem_fs_type = {
>>   	.name		= "tmpfs",
>>   	.init_fs_context = ramfs_init_fs_context,
>>   	.parameters	= ramfs_fs_parameters,
>> -	.kill_sb	= kill_litter_super,
>> +	.kill_sb	= ramfs_kill_sb,
>>   	.fs_flags	= FS_USERNS_MOUNT,
>>   };
>>   
>> -- 
>> 2.25.1

