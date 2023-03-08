Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158096AFC69
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCHBb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCHBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:31:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640ED32CDC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:31:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25F16B81B4F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BD5C433EF;
        Wed,  8 Mar 2023 01:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678239078;
        bh=I10H3LCRynxbID+LAh2eXQNF43+fQKoY+xvwLhKFR5c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jCpFjJZtSzM3h3ToioEEQGRsNEC4NWiKXflrV6Y49nzZzn8WGmoxZ//hXVssshpz2
         9iCXUnVA8TPWU77K5VIGmZGbnllwlc0m2BeppetfkmyHWzV5s9zv5Dv/YEG7Mpq+Lw
         JbT7xO+J2Z0z2toKR+/NHy9UYV9D1xRIs+DFLDAleXAaBn48cmRIYlsomH4yAPC00Z
         voc5n3dNe3Ac2ndx2TW++F+PYyTBrx0rw+CUOOTlz6uNGvUNFm0YFkSmn9cYRQS6l3
         gXtkjdgHPS+9TBCu//G5e8TsVDbslJKFuuVTginj+y9SEnUnEiGLOtICNWiHTqA4v8
         HmviJLVjWhCgw==
Message-ID: <db33ea53-c4e9-42f5-3101-88f806263f76@kernel.org>
Date:   Wed, 8 Mar 2023 09:31:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] f2fs: fix unaligned field offset in 32-bits platform
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Zhiguo Niu <zhiguo.niu@unisoc.com>
References: <20230307151408.58490-1-chao@kernel.org>
 <ZAdzwt+DZ0emPd30@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZAdzwt+DZ0emPd30@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/8 1:26, Jaegeuk Kim wrote:
> Cc'ed stable. Thanks.

Oh, thanks for adding the missed tag! Jaegeuk.

Thanks,

> 
> On 03/07, Chao Yu wrote:
>> F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
>> ------------[ cut here ]------------
>> kernel BUG at fs/f2fs/gc.c:602!
>> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>> PC is at get_victim_by_default+0x13c0/0x1498
>> LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
>> ....
>> [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
>> [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
>> [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
>> [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>>
>> The reason is there is __packed attribute in struct rb_entry, but there
>> is no __packed attribute in struct victim_entry, so wrong offset of key
>> field will be parsed in struct rb_entry in f2fs_check_rb_tree_consistence,
>> it describes memory layouts of struct rb_entry and struct victim_entry in
>> 32-bits platform as below:
>>
>> struct rb_entry {
>>     [0] struct rb_node rb_node;
>>         union {
>>             struct {...};
>>    [12]     unsigned long long key;
>>         } __packed;
>> }
>> size of struct rb_entry: 20
>>
>> struct victim_entry {
>>     [0] struct rb_node rb_node;
>>         union {
>>             struct {...};
>>    [16]     struct victim_info vi;
>>         };
>>    [32] struct list_head list;
>> }
>> size of struct victim_entry: 40
>>
>> This patch tries to add __packed attribute in below structure:
>> - discard_info, discard_cmd
>> - extent_info, extent_node
>> - victim_info, victim_entry
>> in order to fix this unaligned field offset issue in 32-bits platform.
>>
>> Fixes: 004b68621897 ("f2fs: use rb-tree to track pending discard commands")
>> Fixes: 13054c548a1c ("f2fs: introduce infra macro and data structure of rb-tree extent cache")
>> Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/f2fs.h | 6 +++---
>>   fs/f2fs/gc.h   | 4 ++--
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index b0ab2062038a..17fa7572ceed 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -349,7 +349,7 @@ struct discard_info {
>>   	block_t lstart;			/* logical start address */
>>   	block_t len;			/* length */
>>   	block_t start;			/* actual start address in dev */
>> -};
>> +} __packed;
>>   
>>   struct discard_cmd {
>>   	struct rb_node rb_node;		/* rb node located in rb-tree */
>> @@ -361,7 +361,7 @@ struct discard_cmd {
>>   		};
>>   		struct discard_info di;	/* discard info */
>>   
>> -	};
>> +	} __packed;
>>   	struct list_head list;		/* command list */
>>   	struct completion wait;		/* compleation */
>>   	struct block_device *bdev;	/* bdev */
>> @@ -660,7 +660,7 @@ struct extent_info {
>>   			unsigned long long last_blocks;
>>   		};
>>   	};
>> -};
>> +} __packed;
>>   
>>   struct extent_node {
>>   	struct rb_node rb_node;		/* rb node located in rb-tree */
>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
>> index 15bd1d680f67..304937d9a084 100644
>> --- a/fs/f2fs/gc.h
>> +++ b/fs/f2fs/gc.h
>> @@ -58,7 +58,7 @@ struct gc_inode_list {
>>   struct victim_info {
>>   	unsigned long long mtime;	/* mtime of section */
>>   	unsigned int segno;		/* section No. */
>> -};
>> +} __packed;
>>   
>>   struct victim_entry {
>>   	struct rb_node rb_node;		/* rb node located in rb-tree */
>> @@ -68,7 +68,7 @@ struct victim_entry {
>>   			unsigned int segno;		/* segment No. */
>>   		};
>>   		struct victim_info vi;	/* victim info */
>> -	};
>> +	} __packed;
>>   	struct list_head list;
>>   };
>>   
>> -- 
>> 2.36.1
