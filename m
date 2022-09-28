Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10655ED2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiI1CVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiI1CVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:21:09 -0400
Received: from p3plwbeout25-03.prod.phx3.secureserver.net (p3plsmtp25-03-2.prod.phx3.secureserver.net [216.69.139.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB19C7D5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:21:03 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id dMh2oD5S2109PdMh3okY8A; Tue, 27 Sep 2022 19:21:01 -0700
X-CMAE-Analysis: v=2.4 cv=M+qIlw8s c=1 sm=1 tr=0 ts=6333af8f
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10 a=i0EeH86SAAAA:8
 a=IFiPfz1IdY6BvD80mjEA:9 a=QEXdDO2ut3YA:10 a=PeBjCNOBO-z05RTt9keq:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  dMh2oD5S2109P
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp10.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1odMh1-0002lq-Ot; Wed, 28 Sep 2022 03:21:00 +0100
Message-ID: <b3018490-b951-01f0-2b86-84049d9470a0@squashfs.org.uk>
Date:   Wed, 28 Sep 2022 03:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/2] squashfs: add the mount parameter
 theads=<single|multi|percpu>
To:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org
Cc:     wangle6@huawei.com, yi.zhang@huawei.com, wangbing6@huawei.com,
        zhongjubin@huawei.com, chenjianguo3@huawei.com
References: <20220902094855.22666-1-nixiaoming@huawei.com>
 <20220916083604.33408-1-nixiaoming@huawei.com>
 <20220916083604.33408-2-nixiaoming@huawei.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220916083604.33408-2-nixiaoming@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfLt+YC+V61+bPXwx1hXMcvUwR0BP9Fdt0Nv/ik/vGhROr+UCVdcIFai9UPRrHbOCOi0AY7+CflQNiT7wYYH/nmeNgq6qstbVKqWUeJwfMc8gwyxaOUw0
 lUf0n9qunJC6VUzKUqFLKmxqKC0zdx5a3bj8p2Gmlou+S6YZ8FxUxm45pxv63T4h/AqNSiFdRBJ7eshtWfLsPF19MA1imqpYC2Q=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 09:36, Xiaoming Ni wrote:
> Squashfs supports three decompression concurrency modes:
> 	Single-thread mode: concurrent reads are blocked and the memory
> 		overhead is small.
> 	Multi-thread mode/percpu mode: reduces concurrent read blocking but
> 		increases memory overhead.
> 
> The corresponding schema must be fixed at compile time. During mounting,
> the concurrent decompression mode cannot be adjusted based on file read
> blocking.
> 
> The mount parameter theads=<single|multi|percpu> is added to select
> the concurrent decompression mode of a single SquashFS file system
> image.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>   
> +#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
> +	opts->thread_ops = &squashfs_decompressor_single;
> +#elif CONFIG_SQUASHFS_DECOMP_MULTI
> +	opts->thread_ops = &squashfs_decompressor_multi;
> +#elif CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU

In my previous review I asked you to fix the above two #elif
lines.  You have done so in this patch series, but, only in the
second patch which seems perverse.

The reason why this isn't a good approach.  If you *only* apply this 
patch, with the following Squashfs configuration options

phillip@phoenix:/external/stripe/linux$ grep SQUASHFS .config
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3


You will get the following build warning

phillip@phoenix:/external/stripe/linux$ make bzImage
   SYNC    include/config/auto.conf.cmd
   CALL    scripts/checksyscalls.sh
   CALL    scripts/atomic/check-atomics.sh
   DESCEND objtool
   CHK     include/generated/compile.h
   UPD     kernel/config_data
   GZIP    kernel/config_data.gz
   CC      kernel/configs.o
   AR      kernel/built-in.a
   CC      fs/squashfs/block.o
   CC      fs/squashfs/cache.o
   CC      fs/squashfs/dir.o
   CC      fs/squashfs/export.o
   CC      fs/squashfs/file.o
   CC      fs/squashfs/fragment.o
   CC      fs/squashfs/id.o
   CC      fs/squashfs/inode.o
   CC      fs/squashfs/namei.o
   CC      fs/squashfs/super.o
fs/squashfs/super.c: In function ‘squashfs_init_fs_context’:
fs/squashfs/super.c:492:7: warning: "CONFIG_SQUASHFS_DECOMP_MULTI" is 
not defined, evaluates to 0 [-Wundef]
   492 | #elif CONFIG_SQUASHFS_DECOMP_MULTI
       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This strictly breaks the git bisectability rule.  Every patch should
be compilable and not break the build or produce warnings.  If not
it makes git bisect difficult to use to find regressions.

This can be avoided by fixing the issue in *this* patch.  So
please do so.

Thanks

Phillip

> +	opts->thread_ops = &squashfs_decompressor_percpu;
> +#endif
>   	fc->fs_private = opts;
>   	fc->ops = &squashfs_context_ops;
>   	return 0;
> @@ -478,7 +526,7 @@ static void squashfs_put_super(struct super_block *sb)
>   		squashfs_cache_delete(sbi->block_cache);
>   		squashfs_cache_delete(sbi->fragment_cache);
>   		squashfs_cache_delete(sbi->read_page);
> -		squashfs_decompressor_destroy(sbi);
> +		sbi->thread_ops->destroy(sbi);
>   		kfree(sbi->id_table);
>   		kfree(sbi->fragment_index);
>   		kfree(sbi->meta_index);

