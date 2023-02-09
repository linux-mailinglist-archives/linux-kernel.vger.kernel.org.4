Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D13D68FE25
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjBID4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjBIDz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:55:59 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3E2B298
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:55:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEPl.i_1675914953;
Received: from 30.221.133.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEPl.i_1675914953)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:55:54 +0800
Message-ID: <33043e28-f0ad-852b-f338-c1ac1174a809@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 11:55:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: make kobj_type structures constant
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 11:21 AM, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index fd476961f742..435e515c0792 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -179,13 +179,13 @@ static const struct sysfs_ops erofs_attr_ops = {
>  	.store	= erofs_attr_store,
>  };
>  
> -static struct kobj_type erofs_sb_ktype = {
> +static const struct kobj_type erofs_sb_ktype = {
>  	.default_groups = erofs_groups,
>  	.sysfs_ops	= &erofs_attr_ops,
>  	.release	= erofs_sb_release,
>  };
>  
> -static struct kobj_type erofs_ktype = {
> +static const struct kobj_type erofs_ktype = {
>  	.sysfs_ops	= &erofs_attr_ops,
>  };
>  
> @@ -193,7 +193,7 @@ static struct kset erofs_root = {
>  	.kobj	= {.ktype = &erofs_ktype},
>  };
>  
> -static struct kobj_type erofs_feat_ktype = {
> +static const struct kobj_type erofs_feat_ktype = {
>  	.default_groups = erofs_feat_groups,
>  	.sysfs_ops	= &erofs_attr_ops,
>  };
> 
> ---
> base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
> change-id: 20230209-kobj_type-erofs-0f0f4c901045
> 
> Best regards,

-- 
Thanks,
Jingbo
