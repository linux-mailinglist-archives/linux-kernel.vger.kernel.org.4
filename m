Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82CB6421F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiLEDqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiLEDqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:46:37 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C3DFFA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 19:46:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=8;SR=0;TI=SMTPD_---0VWMSRjo_1670211991;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWMSRjo_1670211991)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 11:46:32 +0800
Date:   Mon, 5 Dec 2022 11:46:30 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com
Subject: Re: [PATCH v2] erofs: Fix pcluster memleak when m_pa is zero
Message-ID: <Y41plqKOpuhhpsCi@B-P7TQMD6M-0146.local>
References: <20221205015024.66868-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221205015024.66868-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:50:24AM +0800, Chen Zhongjin wrote:
> syzkaller reported a memleak:
> https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed
> 
> unreferenced object 0xffff88811009c7f8 (size 136):
>   ...
>   backtrace:
>     [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
>     [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
>     [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
>     ...
> 
> syzkaller constructed a case: in z_erofs_register_pcluster(),
> ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index be
> zero although pcl is not a inline pcluster.
> 
> Then following path adds refcount for grp, but the refcount won't be put
> because pcl is inline.
> 
> z_erofs_readahead()
>   z_erofs_do_read_page() # for another page
>     z_erofs_collector_begin()
>       erofs_find_workgroup()
>         erofs_workgroup_get()
> 
> Since it's illegal for map->m_pa to be zero, add check here to avoid

			the block address of a pcluster to be zero,

not just map->m_pa == 0.

Also subject line needs to be updated as well,
"Fix pcluster memleak when its block address is zero"

> registering the pcluster which would be leaked.
> 
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Otherwise it looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(Would you mind sending a next version for this so I can apply it?)

Thanks,
Gao Xiang

> ---
> As Gao's advice, we should fail to register pcluster if m_pa is zero.
> Maked it this way and changed the commit message.
> ---
>  fs/erofs/zdata.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b792d424d774..7826634f4f51 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -488,7 +488,8 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  	struct erofs_workgroup *grp;
>  	int err;
>  
> -	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
> +	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
> +		!(map->m_pa >> PAGE_SHIFT)) {
>  		DBG_BUGON(1);
>  		return -EFSCORRUPTED;
>  	}
> -- 
> 2.17.1
