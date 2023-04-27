Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DCD6EFFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbjD0DOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbjD0DOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:14:34 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD363AAA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:14:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vh5kO3u_1682565269;
Received: from 30.97.48.233(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vh5kO3u_1682565269)
          by smtp.aliyun-inc.com;
          Thu, 27 Apr 2023 11:14:30 +0800
Message-ID: <f42cb722-cdbe-4c87-1afb-3a81470a243c@linux.alibaba.com>
Date:   Thu, 27 Apr 2023 11:14:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: do not build pcpubuf.c for uncompressed data
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com
References: <20230427030346.5624-1-zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230427030346.5624-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/27 11:03, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The function of pcpubuf.c is just for low-latency decompression
> algorithms (e.g. lz4).
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>


Subject: erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang


> ---
>   fs/erofs/Makefile   |  4 ++--
>   fs/erofs/internal.h | 12 +++++++-----
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 99bbc597a3e9..a3a98fc3e481 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -1,8 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   obj-$(CONFIG_EROFS_FS) += erofs.o
> -erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
> +erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
> -erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
> +erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index af0431a40647..65dbfa76f854 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -472,11 +472,6 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>   	return NULL;
>   }
>   
> -void *erofs_get_pcpubuf(unsigned int requiredpages);
> -void erofs_put_pcpubuf(void *ptr);
> -int erofs_pcpubuf_growsize(unsigned int nrpages);
> -void __init erofs_pcpubuf_init(void);
> -void erofs_pcpubuf_exit(void);
>   
>   int erofs_register_sysfs(struct super_block *sb);
>   void erofs_unregister_sysfs(struct super_block *sb);
> @@ -512,6 +507,11 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>   			    struct z_erofs_lz4_cfgs *lz4, int len);
>   int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
>   			    int flags);
> +void *erofs_get_pcpubuf(unsigned int requiredpages);
> +void erofs_put_pcpubuf(void *ptr);
> +int erofs_pcpubuf_growsize(unsigned int nrpages);
> +void __init erofs_pcpubuf_init(void);
> +void erofs_pcpubuf_exit(void);
>   #else
>   static inline void erofs_shrinker_register(struct super_block *sb) {}
>   static inline void erofs_shrinker_unregister(struct super_block *sb) {}
> @@ -529,6 +529,8 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
>   	}
>   	return 0;
>   }
> +static inline void erofs_pcpubuf_init(void) {}
> +static inline void erofs_pcpubuf_exit(void) {}
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
>   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
