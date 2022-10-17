Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9104960129F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJQPSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJQPSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:18:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298D511A13;
        Mon, 17 Oct 2022 08:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80A7561187;
        Mon, 17 Oct 2022 15:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D965DC433C1;
        Mon, 17 Oct 2022 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666019928;
        bh=iqw/3WA2qyIhH2do7CYJZ8d1CZH7Y7k8vGlGp3Knu9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/8AOih1SqhwQs0fWQttHSBOcOl3YEFnSRCUK4XFQwG6IuJeDAjKqfc1ATknz7D/T
         03+zVn/R2imKWiaPcgDmiJ+rEylq2OC+lzKZTaQfJjrPYtDtIGeY9uD0ejgch59D9F
         nWHkpfXBxlOv8Dg6YOF2LXA4h8KW6xK7pvnuhTAPhPI00ZjDPp0HnEr0wgUnTURVn9
         E5/kzXkHY23ptmN5sBtW3ufRs8+isIwSHa6ni+owHsxvNI0zCUHsR0Q9G7f3wKMBwL
         TJMInLd1nHXOwq1/s/q1i2Qa+QYfapz1e1IxhKpARbKLqA2B6SAntzwIU37FCraSje
         zwU2kzvOaEuLw==
Date:   Mon, 17 Oct 2022 08:18:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     dchinner@redhat.com, bfoster@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Fix unreferenced object reported by kmemleak in
 xfs_sysfs_init()
Message-ID: <Y01yWEYI23qGSZ3o@magnolia>
References: <20221017030029.3876512-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017030029.3876512-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:00:29AM +0800, Li Zetao wrote:
> kmemleak reported a sequence of memory leaks, and one of them indicated we
> failed to free a pointer:
>   comm "mount", pid 19610, jiffies 4297086464 (age 60.635s)
>     hex dump (first 8 bytes):
>       73 64 61 00 81 88 ff ff                          sda.....
>     backtrace:
>       [<00000000d77f3e04>] kstrdup_const+0x46/0x70
>       [<00000000e51fa804>] kobject_set_name_vargs+0x2f/0xb0
>       [<00000000247cd595>] kobject_init_and_add+0xb0/0x120
>       [<00000000f9139aaf>] xfs_mountfs+0x367/0xfc0
>       [<00000000250d3caf>] xfs_fs_fill_super+0xa16/0xdc0
>       [<000000008d873d38>] get_tree_bdev+0x256/0x390
>       [<000000004881f3fa>] vfs_get_tree+0x41/0xf0
>       [<000000008291ab52>] path_mount+0x9b3/0xdd0
>       [<0000000022ba8f2d>] __x64_sys_mount+0x190/0x1d0
> 
> As mentioned in kobject_init_and_add() comment, if this function
> returns an error, kobject_put() must be called to properly clean up
> the memory associated with the object. Apparently, xfs_sysfs_init()

Now there's a caller requirement that I didn't know about.

> does not follow such a requirement. When kobject_init_and_add()
> returns an error, the space of kobj->kobject.name alloced by
> kstrdup_const() is unfree, which will cause the above stack.
> 
> Fix it by adding kobject_put() when kobject_init_and_add returns an
> error.
> 
> Fixes: a31b1d3d89e4 ("xfs: add xfs_mount sysfs kobject")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Thanks for fixing this,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_sysfs.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
> index 43585850f154..513095e353a5 100644
> --- a/fs/xfs/xfs_sysfs.h
> +++ b/fs/xfs/xfs_sysfs.h
> @@ -33,10 +33,15 @@ xfs_sysfs_init(
>  	const char		*name)
>  {
>  	struct kobject		*parent;
> +	int err;
>  
>  	parent = parent_kobj ? &parent_kobj->kobject : NULL;
>  	init_completion(&kobj->complete);
> -	return kobject_init_and_add(&kobj->kobject, ktype, parent, "%s", name);
> +	err = kobject_init_and_add(&kobj->kobject, ktype, parent, "%s", name);
> +	if (err)
> +		kobject_put(&kobj->kobject);
> +
> +	return err;
>  }
>  
>  static inline void
> -- 
> 2.31.1
> 
