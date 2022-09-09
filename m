Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166265B3D67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIIQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiIIQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:48:09 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B960146D39
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:47:54 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id WhATopmnsPMmaWhAToUQN3; Fri, 09 Sep 2022 18:47:51 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 09 Sep 2022 18:47:51 +0200
X-ME-IP: 90.11.190.129
Message-ID: <2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr>
Date:   Fri, 9 Sep 2022 18:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
Content-Language: fr
To:     Chao Yu <chao@kernel.org>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jaegeuk@kernel.org, Chao Yu <chao.yu@oppo.com>, vbabka@kernel.org,
        muchun.song@linux.dev
References: <20220830141009.150075-1-chao@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220830141009.150075-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/08/2022 à 16:10, Chao Yu a écrit :
> From: Chao Yu <chao.yu@oppo.com>
> 
> In create_unique_id(), kmalloc(, GFP_KERNEL) can fail due to
> out-of-memory, if it fails, return errno correctly rather than
> triggering panic via BUG_ON();
> 
> kernel BUG at mm/slub.c:5893!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> 
> Call trace:
>   sysfs_slab_add+0x258/0x260 mm/slub.c:5973
>   __kmem_cache_create+0x60/0x118 mm/slub.c:4899
>   create_cache mm/slab_common.c:229 [inline]
>   kmem_cache_create_usercopy+0x19c/0x31c mm/slab_common.c:335
>   kmem_cache_create+0x1c/0x28 mm/slab_common.c:390
>   f2fs_kmem_cache_create fs/f2fs/f2fs.h:2766 [inline]
>   f2fs_init_xattr_caches+0x78/0xb4 fs/f2fs/xattr.c:808
>   f2fs_fill_super+0x1050/0x1e0c fs/f2fs/super.c:4149
>   mount_bdev+0x1b8/0x210 fs/super.c:1400
>   f2fs_mount+0x44/0x58 fs/f2fs/super.c:4512
>   legacy_get_tree+0x30/0x74 fs/fs_context.c:610
>   vfs_get_tree+0x40/0x140 fs/super.c:1530
>   do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>   path_mount+0x358/0x914 fs/namespace.c:3370
>   do_mount fs/namespace.c:3383 [inline]
>   __do_sys_mount fs/namespace.c:3591 [inline]
>   __se_sys_mount fs/namespace.c:3568 [inline]
>   __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
> 
> Cc: <stable@kernel.org>
> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
>   mm/slub.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..e6f3727b9ad2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5890,7 +5890,8 @@ static char *create_unique_id(struct kmem_cache *s)
>   	char *name = kmalloc(ID_STR_LENGTH, GFP_KERNEL);

Hi,

looks that ID_STR_LENGTH could even be reduced to 32 or 16.

The 2nd BUG_ON at the end of the function could certainly be just 
removed as well or remplaced by a:
    	if (p > name + ID_STR_LENGTH - 1) {
		kfree(name);
		return -E<something>;
	}

Just my 2c,

CJ

>   	char *p = name;
>   
> -	BUG_ON(!name);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
>   
>   	*p++ = ':';
>   	/*
> @@ -5948,6 +5949,8 @@ static int sysfs_slab_add(struct kmem_cache *s)
>   		 * for the symlinks.
>   		 */
>   		name = create_unique_id(s);
> +		if (IS_ERR(name))
> +			return PTR_ERR(name);
>   	}
>   
>   	s->kobj.kset = kset;

