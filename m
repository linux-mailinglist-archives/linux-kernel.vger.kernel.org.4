Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E73672EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjASCaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASCaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:30:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61FA24E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:30:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B59FF6171D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3E4C433EF;
        Thu, 19 Jan 2023 02:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674095399;
        bh=pN9R2E0B/Qjp/Xb3oCFgvcSd081HoaaZOUInpZCqutQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGO84BP5hZkNvaFRTC4KLfYy6k7olcxM5LGOP+7a/PD7r5OUtPrM6gd9YOZvg3nau
         8zR5h5QsUESYw26U0m2qPJZvwgnTmj8zt4PyGaD+B0rm2dO3Rz2JJqkKWrzASaTSHG
         O0zIsvbN3xqDeeClY4prpV9P06rhhu4Sc4Mb4RZFUN9+wK2ympV/hAlrQU7EXEO9pI
         7hwYYr1Iy1KzrkB+L+Wb8/OfKNjoFTDBixREBllfJs3HDgsA+RaHJ1gys/99SWytPB
         f/N51kNlIp8e+cqDogwsWlRWBOe7aHTBfF7gc0rmpYKPPzptDq61T+ARkFWFi308Mo
         FALFQt7dqTqWA==
Date:   Wed, 18 Jan 2023 18:29:57 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: export compress_percent and compress_watermark
 entries
Message-ID: <Y8irJdc4vTCC9gKj@google.com>
References: <20230117131740.76597-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117131740.76597-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/17, Yangtao Li wrote:
> This patch export below sysfs entries for better control cached
> compress page count.
> 
> /sys/fs/f2fs/<disk>/compress_watermark
> /sys/fs/f2fs/<disk>/compress_percent
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 17 +++++++++++++++++
>  fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 75420c242cc4..920562742655 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -717,3 +717,20 @@ Description:	Controls background discard granularity of inner discard thread
>  		is smaller than granularity. The unit size is one block(4KB), now only
>  		support configuring in range of [0, 512].
>  		Default: 512
> +
> +what:		/sys/fs/f2fs/<disk>/compress_watermark
> +date:		january 2023
> +contact:	"yangtao li" <frank.li@vivo.com>
> +description:	when compress_cache is on, it controls free memory watermark
> +		in order to limit caching compress page. If free memory is lower
> +		than watermark, then deny caching compress page. The value should be in
> +		range of [0, 100], by default it was initialized as 20(%).
> +
> +what:		/sys/fs/f2fs/<disk>/compress_percent
> +date:		january 2023
> +contact:	"yangtao li" <frank.li@vivo.com>
> +description:	when compress_cache is on, it controls cached page
> +		percent(compress pages / free_ram) in order to limit caching compress page.
> +		If cached page percent exceed threshold, then deny caching compress page.
> +		The value should be in range of [0, 100], by default it was initialized
> +		as 20(%).
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index e396851a6dd1..37c6ef080f7e 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -598,6 +598,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		sbi->compr_new_inode = 0;
>  		return count;
>  	}
> +
> +	if (!strcmp(a->attr.name, "compress_percent")) {
> +		if (t > 100)

t=0 also doesn't make sense.

> +			return -EINVAL;
> +		*ui = t;
> +		return count;
> +	}
> +
> +	if (!strcmp(a->attr.name, "compress_watermark")) {
> +		if (t > 100)
> +			return -EINVAL;
> +		*ui = t;
> +		return count;
> +	}
>  #endif
>  
>  	if (!strcmp(a->attr.name, "atgc_candidate_ratio")) {
> @@ -932,6 +946,8 @@ F2FS_FEATURE_RO_ATTR(compression);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compress_percent, compress_percent);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compress_watermark, compress_watermark);
>  #endif
>  F2FS_FEATURE_RO_ATTR(pin_file);
>  
> @@ -1038,6 +1054,8 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(compr_written_block),
>  	ATTR_LIST(compr_saved_block),
>  	ATTR_LIST(compr_new_inode),
> +	ATTR_LIST(compress_percent),
> +	ATTR_LIST(compress_watermark),
>  #endif
>  	/* For ATGC */
>  	ATTR_LIST(atgc_candidate_ratio),
> -- 
> 2.25.1
