Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4868FDE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjBIDWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBIDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:22:44 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7316A8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:22:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbE36X2_1675912957;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbE36X2_1675912957)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:22:40 +0800
Message-ID: <f01cda32-8540-b213-c221-2670f0669c5d@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 11:22:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: make kobj_type structures constant
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/9 11:21, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/sysfs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index fd476961f742..435e515c0792 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -179,13 +179,13 @@ static const struct sysfs_ops erofs_attr_ops = {
>   	.store	= erofs_attr_store,
>   };
>   
> -static struct kobj_type erofs_sb_ktype = {
> +static const struct kobj_type erofs_sb_ktype = {
>   	.default_groups = erofs_groups,
>   	.sysfs_ops	= &erofs_attr_ops,
>   	.release	= erofs_sb_release,
>   };
>   
> -static struct kobj_type erofs_ktype = {
> +static const struct kobj_type erofs_ktype = {
>   	.sysfs_ops	= &erofs_attr_ops,
>   };
>   
> @@ -193,7 +193,7 @@ static struct kset erofs_root = {
>   	.kobj	= {.ktype = &erofs_ktype},
>   };
>   
> -static struct kobj_type erofs_feat_ktype = {
> +static const struct kobj_type erofs_feat_ktype = {
>   	.default_groups = erofs_feat_groups,
>   	.sysfs_ops	= &erofs_attr_ops,
>   };
> 
> ---
> base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
> change-id: 20230209-kobj_type-erofs-0f0f4c901045
> 
> Best regards,
