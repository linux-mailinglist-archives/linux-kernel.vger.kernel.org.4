Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C226D8E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjDFDwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjDFDwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:52:45 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B73ABC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:52:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VfRGne1_1680753159;
Received: from 30.97.49.15(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfRGne1_1680753159)
          by smtp.aliyun-inc.com;
          Thu, 06 Apr 2023 11:52:40 +0800
Message-ID: <028a1b56-72c9-75f6-fb68-1dc5181bf2e8@linux.alibaba.com>
Date:   Thu, 6 Apr 2023 11:52:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] erofs: remove unnecessary kobject_del()
To:     Yangtao Li <frank.li@vivo.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230404142102.13226-1-frank.li@vivo.com>
 <20230404142102.13226-2-frank.li@vivo.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230404142102.13226-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On 2023/4/4 22:21, Yangtao Li wrote:
> kobject_put() actually covers kobject removal automatically, which is
> single stage removal. So it is safe to kill kobject_del() directly.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Would you mind taking a look at
commit a942da24abc5 ("fs: erofs: add sanity check for kobject in erofs_unregister_sysfs")

, which could be "git-blame"ed (I'd suggest looking into these
blame first), and the related discussion was:

https://lore.kernel.org/r/CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com
https://lore.kernel.org/r/20220315075152.63789-1-dzm91@hust.edu.cn

TL;DR: I guess it could be fixed as below if kobject_del() could
be killed safely:

	if (sbi->s_kobj.state_in_sysfs) {
		kobject_put(&sbi->s_kobj);
		wait_for_completion(&sbi->s_kobj_unregister);
	}

Thanks,
Gao Xiang


> ---
>   fs/erofs/sysfs.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 435e515c0792..c3ba981b4472 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -240,11 +240,8 @@ void erofs_unregister_sysfs(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> -	if (sbi->s_kobj.state_in_sysfs) {
> -		kobject_del(&sbi->s_kobj);
> -		kobject_put(&sbi->s_kobj);
> -		wait_for_completion(&sbi->s_kobj_unregister);
> -	}
> +	kobject_put(&sbi->s_kobj);
> +	wait_for_completion(&sbi->s_kobj_unregister);
>   }
>   
>   int __init erofs_init_sysfs(void)
