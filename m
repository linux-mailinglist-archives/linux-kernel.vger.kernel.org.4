Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F19611942
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ1R0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1R0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:26:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706A41D3A77
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E33DACE2BDA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6AAC433C1;
        Fri, 28 Oct 2022 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666977961;
        bh=PvReomNXtci5g9AZMQJxpfFHI9W77tJBy5ChK1R+KDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAQAyjPLWbYaO3bmUCsbuSIqe6EGHFVlSkBzdvRmW9YrnAzXtgFWdiE4yhBFE3urw
         7K1bn2U2CrlzZWrrdaaG8hLvdYXRU2byYTEDoNcRcbTC0zqCR4+HR7Nn0yAaUTvAgn
         3F16J5qOPL99XMVg9bTAwxZTcShbJVIGAWz2MPNQzIFQTUn/TPFqgBHwlA+WmtY5Dm
         zCK04Y/NGmgeisq49I8iilRRX4lEuP34JHpOrqHgRPHV520lqyg9L+RdP5370I6ir2
         ggnIu41lN/5r/I1wAXzdrwuVx2JORFBxFCf05EQ9QWRDyXhQpk6UksxDQs+AB+tCup
         fNtxqN9ZquLhQ==
Date:   Fri, 28 Oct 2022 10:25:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: remove gc_urgent_high_remaining node
Message-ID: <Y1wQp4Z9sHEqfWV1@google.com>
References: <20221028130716.80850-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028130716.80850-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I modified and integrated some patches as below. Could you please take a look?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d34f1e7212c1965a409d4581a32a92a1c91495fc

Thanks,

On 10/28, Yangtao Li wrote:
> As Jaegeuk suggested to remove it. And it is not a super critical node,
> which just for internal tests now.
> 
> Let's remove the testing gc_urgent_high_remaining sysfs node.
> As well as updating the description in the documentation to indicate
> that readers need to use the new node.
> 
> BTW, fill in a missing '>', :)
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 6 +++---
>  fs/f2fs/f2fs.h                          | 1 -
>  fs/f2fs/sysfs.c                         | 6 ------
>  3 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 374f0c98f8a9..e6b87522518d 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -241,7 +241,7 @@ Description:	Shows total written kbytes issued to disk.
>  What:		/sys/fs/f2fs/<disk>/features
>  Date:		July 2017
>  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> -Description:	<deprecated: should use /sys/fs/f2fs/<disk>/feature_list/
> +Description:	<deprecated>: should use /sys/fs/f2fs/<disk>/feature_list/
>  		Shows all enabled features in current device.
>  		Supported features:
>  		encryption, blkzoned, extra_attr, projquota, inode_checksum,
> @@ -601,10 +601,10 @@ Description:	With "mode=fragment:block" mount options, we can scatter block allo
>  What:		/sys/fs/f2fs/<disk>/gc_urgent_high_remaining
>  Date:		December 2021
>  Contact:	"Daeho Jeong" <daehojeong@google.com>
> -Description:	You can set the trial count limit for GC urgent high mode with this value.
> +Description:	<deprecated>: should use /sys/fs/f2fs/<disk>/gc_urgent_idle_remaining
> +		You can set the trial count limit for GC urgent high mode with this value.
>  		If GC thread gets to the limit, the mode will turn back to GC normal mode.
>  		By default, the value is zero, which means there is no limit like before.
> -		<deprecated>
>  
>  What:		/sys/fs/f2fs/<disk>/gc_urgent_idle_remaining
>  Date:		October 2022
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b467c0ca1118..d0a279605f20 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1747,7 +1747,6 @@ struct f2fs_sb_info {
>  	spinlock_t gc_urgent_idle_lock;
>  	/* remaining trial count for GC_URGENT_* and GC_IDLE_* */
>  	unsigned int gc_urgent_idle_remaining;
> -	unsigned int gc_urgent_high_remaining;	/* deprecated */
>  
>  	/* for skip statistic */
>  	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 9312954ec03b..9db77f18e8a7 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -538,10 +538,6 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> -	/* deprecated */
> -	if (!strcmp(a->attr.name, "gc_urgent_high_remaining"))
> -		return -EINVAL;
> -
>  	if (!strcmp(a->attr.name, "gc_urgent_idle_remaining")) {
>  		spin_lock(&sbi->gc_urgent_idle_lock);
>  		sbi->gc_urgent_idle_remaining = t;
> @@ -836,7 +832,6 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
>  #endif
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
> -F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_high_remaining, gc_urgent_high_remaining);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_idle_remaining, gc_urgent_idle_remaining);
>  F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
>  F2FS_GENERAL_RO_ATTR(dirty_segments);
> @@ -966,7 +961,6 @@ static struct attribute *f2fs_attrs[] = {
>  #endif
>  	ATTR_LIST(data_io_flag),
>  	ATTR_LIST(node_io_flag),
> -	ATTR_LIST(gc_urgent_high_remaining),
>  	ATTR_LIST(gc_urgent_idle_remaining),
>  	ATTR_LIST(ckpt_thread_ioprio),
>  	ATTR_LIST(dirty_segments),
> -- 
> 2.25.1
