Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56E5ED346
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiI1DHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiI1DGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:06:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DA91CE915
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:06:51 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mch9Q3B31z9t6K;
        Wed, 28 Sep 2022 11:02:02 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 11:06:49 +0800
Subject: Re: [PATCH v4 1/2] squashfs: add the mount parameter
 theads=<single|multi|percpu>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        <linux-kernel@vger.kernel.org>
CC:     <wangle6@huawei.com>, <yi.zhang@huawei.com>,
        <wangbing6@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
References: <20220902094855.22666-1-nixiaoming@huawei.com>
 <20220916083604.33408-1-nixiaoming@huawei.com>
 <20220916083604.33408-2-nixiaoming@huawei.com>
 <b3018490-b951-01f0-2b86-84049d9470a0@squashfs.org.uk>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <336305b4-439c-edac-a21e-56e2604de127@huawei.com>
Date:   Wed, 28 Sep 2022 11:06:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <b3018490-b951-01f0-2b86-84049d9470a0@squashfs.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/28 10:20, Phillip Lougher wrote:
> On 16/09/2022 09:36, Xiaoming Ni wrote:
>> Squashfs supports three decompression concurrency modes:
>>     Single-thread mode: concurrent reads are blocked and the memory
>>         overhead is small.
>>     Multi-thread mode/percpu mode: reduces concurrent read blocking but
>>         increases memory overhead.
>>
>> The corresponding schema must be fixed at compile time. During mounting,
>> the concurrent decompression mode cannot be adjusted based on file read
>> blocking.
>>
>> The mount parameter theads=<single|multi|percpu> is added to select
>> the concurrent decompression mode of a single SquashFS file system
>> image.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> +#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
>> +    opts->thread_ops = &squashfs_decompressor_single;
>> +#elif CONFIG_SQUASHFS_DECOMP_MULTI
>> +    opts->thread_ops = &squashfs_decompressor_multi;
>> +#elif CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
> 
> In my previous review I asked you to fix the above two #elif
> lines.  You have done so in this patch series, but, only in the
> second patch which seems perverse.
> 
> The reason why this isn't a good approach.  If you *only* apply this 
> patch, with the following Squashfs configuration options
> 
I'm so sorry.
I made a low-level mistake in patching.
I will re-check the previous review comments and resend the patch.

Thanks



> phillip@phoenix:/external/stripe/linux$ grep SQUASHFS .config
> CONFIG_SQUASHFS=y
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
> # CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
> # CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE is not set
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
> CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU=y
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_SQUASHFS_LZ4=y
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> CONFIG_SQUASHFS_ZSTD=y
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> 
> 
> You will get the following build warning
> 
> phillip@phoenix:/external/stripe/linux$ make bzImage
>    SYNC    include/config/auto.conf.cmd
>    CALL    scripts/checksyscalls.sh
>    CALL    scripts/atomic/check-atomics.sh
>    DESCEND objtool
>    CHK     include/generated/compile.h
>    UPD     kernel/config_data
>    GZIP    kernel/config_data.gz
>    CC      kernel/configs.o
>    AR      kernel/built-in.a
>    CC      fs/squashfs/block.o
>    CC      fs/squashfs/cache.o
>    CC      fs/squashfs/dir.o
>    CC      fs/squashfs/export.o
>    CC      fs/squashfs/file.o
>    CC      fs/squashfs/fragment.o
>    CC      fs/squashfs/id.o
>    CC      fs/squashfs/inode.o
>    CC      fs/squashfs/namei.o
>    CC      fs/squashfs/super.o
> fs/squashfs/super.c: In function ‘squashfs_init_fs_context’:
> fs/squashfs/super.c:492:7: warning: "CONFIG_SQUASHFS_DECOMP_MULTI" is 
> not defined, evaluates to 0 [-Wundef]
>    492 | #elif CONFIG_SQUASHFS_DECOMP_MULTI
>        |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This strictly breaks the git bisectability rule.  Every patch should
> be compilable and not break the build or produce warnings.  If not
> it makes git bisect difficult to use to find regressions.
> 
> This can be avoided by fixing the issue in *this* patch.  So
> please do so.
> 
> Thanks
> 
> Phillip
> 
>> +    opts->thread_ops = &squashfs_decompressor_percpu;
>> +#endif
>>       fc->fs_private = opts;
>>       fc->ops = &squashfs_context_ops;
>>       return 0;
>> @@ -478,7 +526,7 @@ static void squashfs_put_super(struct super_block 
>> *sb)
>>           squashfs_cache_delete(sbi->block_cache);
>>           squashfs_cache_delete(sbi->fragment_cache);
>>           squashfs_cache_delete(sbi->read_page);
>> -        squashfs_decompressor_destroy(sbi);
>> +        sbi->thread_ops->destroy(sbi);
>>           kfree(sbi->id_table);
>>           kfree(sbi->fragment_index);
>>           kfree(sbi->meta_index);
> 
> 
> .

