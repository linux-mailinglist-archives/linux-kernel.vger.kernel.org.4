Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A037D6416DA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLCNUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLCNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:20:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD2A2FC3B
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 05:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D16DB801BC
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 13:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB9C433D6;
        Sat,  3 Dec 2022 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670073622;
        bh=GLEPuyvQs5gzwFtLxd8Lh2bF/WYafKUaa6V6LtvXV/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lV4igYHZB/dmBAr2lFBZNCm07iMIi6c0bmjs39fHfsrxABERfvIUDf83+QLUq5ibj
         Go49lcXclXutaEoZXOiHrH2pjsb1FFZXjVA7WslvWOs/jk2BROBi83gTBUfSk7dR35
         9Ugfn2J2RWtRKJab7iMI2OtY8sw8/ayZWXJj6SdWrAwqwM9bzFI1klG1/b7/ZVhDrL
         c6IDbxKGc197n0vlJbJNtXCObzIIKkuAb0oFZvAK0QMlijgCXx00knio6yaRxbXkVK
         YIhLILhr5iUDL6Wqn8/HUOY8B2P+dJ5O56gBwvBXYdLl5lPY6Peln+6+qCBWoue9oB
         OejAD5uFQo2zQ==
Date:   Sat, 3 Dec 2022 21:20:17 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com
Subject: Re: [PATCH] erofs: Fix pcluster become inline when m_pa is zero
Message-ID: <Y4tNEUupN/1/AFOW@debian>
Mail-Followup-To: Chen Zhongjin <chenzhongjin@huawei.com>,
        syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com
References: <20221203094527.129869-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203094527.129869-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhongjin,

On Sat, Dec 03, 2022 at 05:45:27PM +0800, Chen Zhongjin wrote:
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
> ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index
> become zero although pcl is not an inline pcluster.

Thanks for the patch!

We should just fail out if map->m_pa / EROFS_BLKSIZ == 0.

> 
> Then following path adds refcount for grp, but the it won't be put
> because pcl is inline, which makes pcl not released when shrink.
> 
> z_erofs_readahead()
>   z_erofs_do_read_page() # for another page
>     z_erofs_collector_begin()
>       erofs_find_workgroup()
>         erofs_workgroup_get()
> 
> To fix this, add an attribute in z_erofs_pcluster to mark the inline
> state which not depends on index of grp.

I think the main reason is "inline pcluster _always_ did memory leak
before since I don't find any chance to these free inline pclusters
in the current codebase.

Actually I submitted a patch for this, could you check/review this
if possible?
https://lore.kernel.org/r/20221202033327.52702-1-hsiangkao@linux.alibaba.com

Thanks,
Gao Xiang

> 
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  fs/erofs/zdata.c | 2 +-
>  fs/erofs/zdata.h | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b792d424d774..fef2624d19e3 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -517,7 +517,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  	DBG_BUGON(!mutex_trylock(&pcl->lock));
>  
>  	if (ztailpacking) {
> -		pcl->obj.index = 0;	/* which indicates ztailpacking */
> +		pcl->is_inline = true;  /* which indicates ztailpacking */
>  		pcl->pageofs_in = erofs_blkoff(map->m_pa);
>  		pcl->tailpacking_size = map->m_plen;
>  	} else {
> diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> index d98c95212985..35051ad27521 100644
> --- a/fs/erofs/zdata.h
> +++ b/fs/erofs/zdata.h
> @@ -78,6 +78,9 @@ struct z_erofs_pcluster {
>  		unsigned short tailpacking_size;
>  	};
>  
> +	/* I:  whether it is inline or not */
> +	bool is_inline;
> +
>  	/* I: compression algorithm format */
>  	unsigned char algorithmformat;
>  
> @@ -115,7 +118,7 @@ struct z_erofs_decompressqueue {
>  
>  static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
>  {
> -	return !pcl->obj.index;
> +	return pcl->is_inline;
>  }
>  
>  static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
> -- 
> 2.17.1
> 
