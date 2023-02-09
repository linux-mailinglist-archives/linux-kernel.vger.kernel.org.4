Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF6690036
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBIGIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIGIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:08:53 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C5A46A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:08:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbEcFJ0_1675922927;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbEcFJ0_1675922927)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 14:08:48 +0800
Message-ID: <d495d8d1-c37c-7e24-160b-efd7633ab20a@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 14:08:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/4] erofs: maintain cookies of share domain in
 self-contained list
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20230209051838.33297-1-jefflexu@linux.alibaba.com>
 <20230209051838.33297-3-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209051838.33297-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/9 13:18, Jingbo Xu wrote:
> We'd better not touch sb->s_inodes list and inode->i_count directly.
> Let's maintain cookies of share domain in a self-contained list in erofs.
> 
> Besides, relinquish cookie with the mutex held.  Otherwise if a cookie
> is registered when the old cookie with the same name in the same domain
> has been removed from the list but not relinquished yet, fscache may
> complain "Duplicate cookie detected".
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>   fs/erofs/fscache.c  | 48 ++++++++++++++++++++++-----------------------
>   fs/erofs/internal.h |  4 ++++
>   2 files changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 03de4dc99302..2f5930e177cc 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -7,8 +7,11 @@
>   #include "internal.h"
>   
>   static DEFINE_MUTEX(erofs_domain_list_lock);
> -static DEFINE_MUTEX(erofs_domain_cookies_lock);
>   static LIST_HEAD(erofs_domain_list);
> +
> +static DEFINE_MUTEX(erofs_domain_cookies_lock);
> +static LIST_HEAD(erofs_domain_cookies_list);


Redundant blank lines.

> +
>   static struct vfsmount *erofs_pseudo_mnt;
>   
>   struct erofs_fscache_request {
> @@ -318,8 +321,6 @@ const struct address_space_operations erofs_fscache_access_aops = {
>   
>   static void erofs_fscache_domain_put(struct erofs_domain *domain)
>   {
> -	if (!domain)
> -		return;
>   	mutex_lock(&erofs_domain_list_lock);
>   	if (refcount_dec_and_test(&domain->ref)) {
>   		list_del(&domain->list);
> @@ -434,6 +435,8 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>   	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return ERR_PTR(-ENOMEM);
> +	INIT_LIST_HEAD(&ctx->node);
> +	refcount_set(&ctx->ref, 1);
>   
>   	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
>   					name, strlen(name), NULL, 0, 0);
> @@ -479,6 +482,7 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
>   	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>   	fscache_relinquish_cookie(ctx->cookie, false);
>   	iput(ctx->inode);
> +	iput(ctx->anon_inode);
>   	kfree(ctx->name);
>   	kfree(ctx);
>   }
> @@ -511,6 +515,7 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
>   
>   	ctx->domain = domain;
>   	ctx->anon_inode = inode;
> +	list_add(&ctx->node, &erofs_domain_cookies_list);
>   	inode->i_private = ctx;
>   	refcount_inc(&domain->ref);
>   	return ctx;
> @@ -524,29 +529,23 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   						   char *name,
>   						   unsigned int flags)
>   {
> -	struct inode *inode;
>   	struct erofs_fscache *ctx;
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
> -	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>   
>   	mutex_lock(&erofs_domain_cookies_lock);
> -	spin_lock(&psb->s_inode_list_lock);
> -	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
> -		ctx = inode->i_private;
> -		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
> +	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
> +		if (ctx->domain != domain || strcmp(ctx->name, name))
>   			continue;
>   		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
> -			igrab(inode);
> +			refcount_inc(&ctx->ref);
>   		} else {
>   			erofs_err(sb, "%s already exists in domain %s", name,
>   				  domain->domain_id);
>   			ctx = ERR_PTR(-EEXIST);
>   		}
> -		spin_unlock(&psb->s_inode_list_lock);
>   		mutex_unlock(&erofs_domain_cookies_lock);
>   		return ctx;
>   	}
> -	spin_unlock(&psb->s_inode_list_lock);
>   	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
> @@ -563,23 +562,22 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>   
>   void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>   {
> -	bool drop;
> -	struct erofs_domain *domain;
> +	struct erofs_domain *domain = NULL;
>   
>   	if (!ctx)
>   		return;
> -	domain = ctx->domain;
> -	if (domain) {
> -		mutex_lock(&erofs_domain_cookies_lock);
> -		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
> -		iput(ctx->anon_inode);
> -		mutex_unlock(&erofs_domain_cookies_lock);
> -		if (!drop)
> -			return;
> -	}
> +	if (!ctx->domain)
> +		return erofs_fscache_relinquish_cookie(ctx);
>   
> -	erofs_fscache_relinquish_cookie(ctx);
> -	erofs_fscache_domain_put(domain);
> +	mutex_lock(&erofs_domain_cookies_lock);
> +	if (refcount_dec_and_test(&ctx->ref)) {
> +		domain = ctx->domain;
> +		list_del(&ctx->node);
> +		erofs_fscache_relinquish_cookie(ctx);
> +	}
> +	mutex_unlock(&erofs_domain_cookies_lock);
> +	if (domain)
> +		erofs_fscache_domain_put(domain);
>   }
>   
>   int erofs_fscache_register_fs(struct super_block *sb)
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 48a2f33de15a..8358cf5f731e 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -109,7 +109,11 @@ struct erofs_fscache {
>   	struct fscache_cookie *cookie;
>   	struct inode *inode;
>   	struct inode *anon_inode;
> +
> +	/* used for share domain mode */
>   	struct erofs_domain *domain;
> +	struct list_head node;
> +	refcount_t ref;
>   	char *name;
>   };
>   
