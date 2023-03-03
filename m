Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9156A9213
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCCH7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:59:23 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B27559EE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:59:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vd-aexD_1677830342;
Received: from 30.97.48.241(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd-aexD_1677830342)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 15:59:03 +0800
Message-ID: <83454c5d-bcae-cead-c9a8-47d1f08178ca@linux.alibaba.com>
Date:   Fri, 3 Mar 2023 15:59:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
To:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230303063731.66760-1-frank.li@vivo.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230303063731.66760-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/3 14:37, Yangtao Li wrote:
> They are used during the erofs module init phase. Let's mark it as
> __init like any other function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> v2:
> -change in internal.h
>   fs/erofs/decompressor_lzma.c | 2 +-
>   fs/erofs/internal.h          | 4 ++--
>   fs/erofs/pcpubuf.c           | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 091fd5adf818..307b37f0b9f5 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -47,7 +47,7 @@ void z_erofs_lzma_exit(void)
>   	}
>   }
>   
> -int z_erofs_lzma_init(void)
> +int __init z_erofs_lzma_init(void)
>   {
>   	unsigned int i;
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3f3561d37d1b..1db018f8c2e8 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -486,7 +486,7 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>   void *erofs_get_pcpubuf(unsigned int requiredpages);
>   void erofs_put_pcpubuf(void *ptr);
>   int erofs_pcpubuf_growsize(unsigned int nrpages);
> -void erofs_pcpubuf_init(void);
> +void __init erofs_pcpubuf_init(void);
>   void erofs_pcpubuf_exit(void);
>   
>   int erofs_register_sysfs(struct super_block *sb);
> @@ -545,7 +545,7 @@ static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP;
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
>   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
> -int z_erofs_lzma_init(void);
> +int __init z_erofs_lzma_init(void);
>   void z_erofs_lzma_exit(void);
>   int z_erofs_load_lzma_config(struct super_block *sb,
>   			     struct erofs_super_block *dsb,
> diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
> index a2efd833d1b6..c7a4b1d77069 100644
> --- a/fs/erofs/pcpubuf.c
> +++ b/fs/erofs/pcpubuf.c
> @@ -114,7 +114,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
>   	return ret;
>   }
>   
> -void erofs_pcpubuf_init(void)
> +void __init erofs_pcpubuf_init(void)
>   {
>   	int cpu;
>   
