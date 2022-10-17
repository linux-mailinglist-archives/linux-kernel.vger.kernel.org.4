Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF060129B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiJQPQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJQPQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:16:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98421EA;
        Mon, 17 Oct 2022 08:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C541B81694;
        Mon, 17 Oct 2022 15:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB5CC433D6;
        Mon, 17 Oct 2022 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666019811;
        bh=AxG/oKpTNjJRaqY3ecYkHxm6nW1y5WxmtqL36IjFTmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8+8Mq9/ldgJpBcEnwDeZmhHO8wmnbzazCb22ZYrPbG6j7VggRvbcBXg2e7K/CHJu
         Tc6EondjSF8qiHy7SZPjW37oRq86IFln7pOAIrGXCFumsvROGX2JrP3tmHQvv6H5bT
         uqdnp6K6rlPli38SicRyl9VFxtbSyReoPAe1bZ8tp3ytkU50QHO6ElrGb+F6WrG4YL
         yFiXAwOn9PBK8PBQqolieFXSOCJc1AanQSiB9HOdOaQzNs8n9QmbFxkw5zmHx5w+Na
         2qKfHIoaZo8D5QED61rkmDSXH44XDevolQzEgkyriF7E17P+oIpQAhUNDWiMmnTrL/
         b0SaL1zYBveQw==
Date:   Mon, 17 Oct 2022 08:16:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     bfoster@redhat.com, cmaiolino@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
Subject: Re: [PATCH] xfs: fix memory leak in xfs_errortag_init
Message-ID: <Y01x4s9j7TXU/4CW@magnolia>
References: <20221017025155.1810277-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017025155.1810277-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:51:55AM +0800, Zeng Heng wrote:
> When `xfs_sysfs_init` returns failed, `mp->m_errortag` needs to free.
> Otherwise kmemleak would report memory leak after mounting xfs image:
> 
> unreferenced object 0xffff888101364900 (size 192):
>   comm "mount", pid 13099, jiffies 4294915218 (age 335.207s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000f08ad25c>] __kmalloc+0x41/0x1b0
>     [<00000000dca9aeb6>] kmem_alloc+0xfd/0x430
>     [<0000000040361882>] xfs_errortag_init+0x20/0x110
>     [<00000000b384a0f6>] xfs_mountfs+0x6ea/0x1a30
>     [<000000003774395d>] xfs_fs_fill_super+0xe10/0x1a80
>     [<000000009cf07b6c>] get_tree_bdev+0x3e7/0x700
>     [<00000000046b5426>] vfs_get_tree+0x8e/0x2e0
>     [<00000000952ec082>] path_mount+0xf8c/0x1990
>     [<00000000beb1f838>] do_mount+0xee/0x110
>     [<000000000e9c41bb>] __x64_sys_mount+0x14b/0x1f0
>     [<00000000f7bb938e>] do_syscall_64+0x3b/0x90
>     [<000000003fcd67a9>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Fixes: c68401011522 ("xfs: expose errortag knobs via sysfs")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  fs/xfs/xfs_error.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
> index 296faa41d81d..f417320ef9c0 100644
> --- a/fs/xfs/xfs_error.c
> +++ b/fs/xfs/xfs_error.c
> @@ -234,13 +234,18 @@ int
>  xfs_errortag_init(
>  	struct xfs_mount	*mp)
>  {
> +	int ret;

Nit: xfs naming convention is (usually) 'error' for return values that
are a negative errno or zero; and 'ret' when positive values have
significance.

I don't mind changing that on commit though since this is obviously
correct, so:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
>  	mp->m_errortag = kmem_zalloc(sizeof(unsigned int) * XFS_ERRTAG_MAX,
>  			KM_MAYFAIL);
>  	if (!mp->m_errortag)
>  		return -ENOMEM;
>  
> -	return xfs_sysfs_init(&mp->m_errortag_kobj, &xfs_errortag_ktype,
> -			       &mp->m_kobj, "errortag");
> +	ret = xfs_sysfs_init(&mp->m_errortag_kobj, &xfs_errortag_ktype,
> +				&mp->m_kobj, "errortag");
> +	if (ret)
> +		kmem_free(mp->m_errortag);
> +	return ret;
>  }
>  
>  void
> -- 
> 2.25.1
> 
