Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05B2600613
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJQE7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQE65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:58:57 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242244F66E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:58:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSHTNAs_1665982730;
Received: from 30.221.131.120(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VSHTNAs_1665982730)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 12:58:51 +0800
Message-ID: <a8fee658-5538-0f6c-c6fb-d3dd56099e76@linux.alibaba.com>
Date:   Mon, 17 Oct 2022 12:58:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2] erofs: protect s_inodes with s_inode_list_lock
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, xiang@kernel.org,
        chao@kernel.org
Cc:     zhujia.zj@bytedance.com, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/22 9:55 AM, Dawei Li wrote:
> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
> 
> v2: update the locking mechanisim to protect mutual-exclusive access
> both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as the
> reviewing comments from Jia Zhu.
> 
> v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> 
> base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Fixes: 7d41963759fe ("erofs: Support sharing cookies in the same domain")

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/erofs/fscache.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 998cd26a1b3b..fe05bc51f9f2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -590,14 +590,17 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>  	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>  
>  	mutex_lock(&erofs_domain_cookies_lock);
> +	spin_lock(&psb->s_inode_list_lock);
>  	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>  		ctx = inode->i_private;
>  		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
>  			continue;
>  		igrab(inode);
> +		spin_unlock(&psb->s_inode_list_lock);
>  		mutex_unlock(&erofs_domain_cookies_lock);
>  		return ctx;
>  	}
> +	spin_unlock(&psb->s_inode_list_lock);
>  	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
>  	mutex_unlock(&erofs_domain_cookies_lock);
>  	return ctx;

-- 
Thanks,
Jingbo
