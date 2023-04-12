Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19096DE9E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDLDYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDLDY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:24:29 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E8630C8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:24:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VfuYNYL_1681269862;
Received: from 30.97.48.227(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfuYNYL_1681269862)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 11:24:24 +0800
Message-ID: <7ea88962-1cda-55d3-04f9-2e471b4e89ad@linux.alibaba.com>
Date:   Wed, 12 Apr 2023 11:24:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs: don't access kobject object members directly
To:     Yangtao Li <frank.li@vivo.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Huang Jianan <jnhuang@linux.alibaba.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230412031110.8965-1-frank.li@vivo.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230412031110.8965-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Greg, Huang Jianan, Dongliang Mu)

On 2023/4/12 11:11, Yangtao Li wrote:
> It is better not to directly access the internal members of the
> kobject object, especially kobject_init_and_add() may failure.
> BTW remove unnecessary kobject_del(), kobject_put() actually covers
> kobject removal automatically, which is single stage removal.

Please at least Cc the proper people --- and write
the previous background to the commit message *again*.

I'd like to know the preferred way to do this since
the previous discussion is unfinished.

Also if you grep `state_in_sysfs`, actually there are
some similar in-tree usage, also device_is_registered() is
implemented like this:

static inline int device_is_registered(struct device *dev)
{
	return dev->kobj.state_in_sysfs;
}

Again, I'm not against this patch (I even prefer this one),
but you should Cc the proper people and finish the previous
topic first.

Thanks,
Gao Xiang

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/erofs/internal.h | 1 +
>   fs/erofs/sysfs.c    | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index f675050af2bb..f364b1e9b35b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -177,6 +177,7 @@ struct erofs_sb_info {
>   	/* sysfs support */
>   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>   	struct completion s_kobj_unregister;
> +	bool sysfs_registered;
>   
>   	/* fscache support */
>   	struct fscache_volume *volume;
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 435e515c0792..c38018d3c442 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -228,6 +228,7 @@ int erofs_register_sysfs(struct super_block *sb)
>   	kfree(str);
>   	if (err)
>   		goto put_sb_kobj;
> +	sbi->sysfs_registered = true;
>   	return 0;
>   
>   put_sb_kobj:
> @@ -240,8 +241,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> -	if (sbi->s_kobj.state_in_sysfs) {
> -		kobject_del(&sbi->s_kobj);
> +	if (sbi->sysfs_registered) {
>   		kobject_put(&sbi->s_kobj);
>   		wait_for_completion(&sbi->s_kobj_unregister);
>   	}
