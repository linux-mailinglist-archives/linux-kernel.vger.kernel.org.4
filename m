Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD73D628E97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiKOAoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKOAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:44:11 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C61704B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:44:10 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NB6mX3SSZzJnfK;
        Tue, 15 Nov 2022 08:41:00 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 08:44:07 +0800
Message-ID: <9f69fc35-8767-c883-90a0-d57c5783ee01@huawei.com>
Date:   Tue, 15 Nov 2022 08:44:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] fs: Fix UBSAN detected shift-out-bounds error for bad
 superblock
To:     Randy Dunlap <rdunlap@infradead.org>, <willy@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <akpm@linux-foundation.org>,
        <jack@suse.cz>, <qhjin.dev@gmail.com>, <songmuchun@bytedance.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20221114024957.60916-1-liaochang1@huawei.com>
 <e781f927-07f4-9165-1123-f9b501c552b1@infradead.org>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <e781f927-07f4-9165-1123-f9b501c552b1@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/15 5:09, Randy Dunlap 写道:
> 
> 
> On 11/13/22 18:49, Liao Chang wrote:
>> UBSAN: shift-out-of-bounds in fs/minix/bitmap.c:103:3
>> shift exponent 8192 is too large for 32-bit type 'unsigned int'
>> CPU: 1 PID: 32273 Comm: syz-executor.0 Tainted: G        W
>> 6.1.0-rc4-dirty #11
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0xcd/0x134
>>  ubsan_epilogue+0xb/0x50
>>  __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x18d
>>  minix_count_free_blocks.cold+0x16/0x1b
>>  minix_statfs+0x22a/0x490
>>  statfs_by_dentry+0x133/0x210
>>  user_statfs+0xa9/0x160
>>  __do_sys_statfs+0x7a/0xf0
>>  do_syscall_64+0x35/0x80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> The superblock stores on disk contains the size of a data zone, which is
>> too large to used as the shift when kernel try to calculate the total
>> size of zones, so it needs to check the superblock when kernel mounts
>> MINIX-FS.
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  fs/minix/inode.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
>> index da8bdd1712a7..f1d1c2312817 100644
>> --- a/fs/minix/inode.c
>> +++ b/fs/minix/inode.c
>> @@ -166,6 +166,12 @@ static bool minix_check_superblock(struct super_block *sb)
>>  	    sb->s_maxbytes > (7 + 512 + 512*512) * BLOCK_SIZE)
>>  		return false;
>>  
>> +	/* the total size of zones must no exceed the limitation of U32_MAX. */
> 
> 	                           must not exceed

Thanks, i will correct it in next revision.

> 
>> +	if (sbi->s_log_zone_size && (sbi->s_nzones - sbi->s_firstdatazone) &&
>> +	    (__builtin_clzl((__u32)(sbi->s_nzones - sbi->s_firstdatazone)) <=
>> +	     sbi->s_log_zone_size))
>> +		return false;
>> +
>>  	return true;
>>  }
>>  
> 

-- 
BR,
Liao, Chang
