Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047BA67F725
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjA1KeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjA1KeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:34:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5385BAD
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:34:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A800CB8049B
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA69AC433EF;
        Sat, 28 Jan 2023 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674902051;
        bh=MWBgHjqmJ5UVKw/d5uDkFlf3VaHDM1hciuxJKXsxf1U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jftSoJ6k2kx555974z7u8JSWnHrUYLp0CVc7nh4R6WBo2nIsx8NUbHve7YEE5ed/H
         nJycIw4+QtInWFvsRlJpEojmW6IbtXKaln7IR8qlOODnQlGQNErYWhQGqIDxwhttvo
         jZifC+TyfAw+mDcR10m/k7Zy6Y8oFw8wFdI09oDvBZHO24SHyJ2qXSkE0ArkKP2HNb
         EPJeCJo3zs4VDF8oSkXKwUN2Afvnlgl3B6nbS8UaqOOVaYYZb40qhQyMnutfB9esty
         76A1jLnBxOT024eG8H5p+lO6V6acyK6RXlQ6oIK0Eh7rh2UXLsuy/FFTuL/88HfPDm
         /tz6pMOBe7fbQ==
Message-ID: <c179d808-66ee-a4b5-b3f1-91ba336a68ca@kernel.org>
Date:   Sat, 28 Jan 2023 18:34:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION_V2 ioctl
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230112133503.16802-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230112133503.16802-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/12 21:35, Yangtao Li wrote:
> Added a new F2FS_IOC_SET_COMPRESS_OPTION_V2 ioctl to change file
> compression option of a file.
> 
> struct f2fs_comp_option_v2 {
> 	union {
> 		struct {
> 			__u8 algorithm;
> 			__u8 log_cluster_size;
> 			__u16 compress_flag;
> 		};
> 		struct f2fs_comp_option option;
> 	};
> };
> 
> struct f2fs_comp_option_v2 option;
> 
> option.algorithm = 2;
> option.log_cluster_size = 2;
> option.compress_flag = (5 << COMPRESS_LEVEL_OFFSET) | BIT(COMPRESS_CHKSUM);
> 
> ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION_V2, &option);
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h            |  8 +-------
>   fs/f2fs/file.c            | 41 ++++++++++++++++++++++++++++++++-------
>   include/uapi/linux/f2fs.h | 21 ++++++++++++++++++++
>   3 files changed, 56 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f3c5f7740c1a..c2267f44bcf8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -25,6 +25,7 @@
>   #include <linux/quotaops.h>
>   #include <linux/part_stat.h>
>   #include <crypto/hash.h>
> +#include <uapi/linux/f2fs.h>
>   
>   #include <linux/fscrypt.h>
>   #include <linux/fsverity.h>
> @@ -1501,11 +1502,6 @@ enum compress_algorithm_type {
>   	COMPRESS_MAX,
>   };
>   
> -enum compress_flag {
> -	COMPRESS_CHKSUM,
> -	COMPRESS_MAX_FLAG,
> -};
> -
>   #define	COMPRESS_WATERMARK			20
>   #define	COMPRESS_PERCENT			20
>   
> @@ -1521,8 +1517,6 @@ struct compress_data {
>   
>   #define F2FS_COMPRESSED_PAGE_MAGIC	0xF5F2C000
>   
> -#define	COMPRESS_LEVEL_OFFSET	8
> -
>   /* compress context */
>   struct compress_ctx {
>   	struct inode *inode;		/* inode the context belong to */
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f5c1b7814954..719706ef0d46 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -25,6 +25,8 @@
>   #include <linux/fileattr.h>
>   #include <linux/fadvise.h>
>   #include <linux/iomap.h>
> +#include <linux/zstd.h>
> +#include <linux/lz4.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> @@ -3910,12 +3912,13 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
>   	return 0;
>   }
>   
> -static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
> +static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg,
> +										unsigned int cmd)
>   {
>   	struct inode *inode = file_inode(filp);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct f2fs_comp_option option;
> -	int ret = 0;
> +	struct f2fs_comp_option_v2 option;
> +	int ret = 0, len;
>   
>   	if (!f2fs_sb_has_compression(sbi))
>   		return -EOPNOTSUPP;
> @@ -3923,8 +3926,12 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>   	if (!(filp->f_mode & FMODE_WRITE))
>   		return -EBADF;
>   
> -	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
> -				sizeof(option)))
> +	if (cmd == F2FS_IOC_SET_COMPRESS_OPTION_V2)
> +		len = sizeof(struct f2fs_comp_option_v2);
> +	else
> +		len = sizeof(struct f2fs_comp_option);
> +
> +	if (copy_from_user(&option, (void __user *)arg, len))
>   		return -EFAULT;
>   
>   	if (!f2fs_compressed_file(inode) ||
> @@ -3933,6 +3940,21 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>   			option.algorithm >= COMPRESS_MAX)
>   		return -EINVAL;
>   
> +	if (cmd == F2FS_IOC_SET_COMPRESS_OPTION_V2) {
> +		unsigned int level = GET_COMPRESS_LEVEL(option.compress_flag);
> +
> +		switch (option.algorithm) {
> +		case COMPRESS_LZ4:
> +			if (level < LZ4HC_MIN_CLEVEL || level > LZ4HC_MAX_CLEVEL)
> +				return -EINVAL;
> +			break;

level=0 indicates lz4, so it's allowed?

> +		case COMPRESS_ZSTD:
> +			if (!level || level > zstd_max_clevel())
> +				return -EINVAL;
> +			break;

default:
	return -EINVAL;

> +		}
> +	}
> +
>   	file_start_write(filp);
>   	inode_lock(inode);
>   
> @@ -3948,7 +3970,10 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>   
>   	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
>   	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
> -	F2FS_I(inode)->i_cluster_size = 1 << option.log_cluster_size;
> +	F2FS_I(inode)->i_cluster_size = BIT(option.log_cluster_size);
> +
> +	if (cmd == F2FS_IOC_SET_COMPRESS_OPTION_V2)
> +		F2FS_I(inode)->i_compress_flag = option.compress_flag & COMPRESS_OPTION_MASK;
>   	f2fs_mark_inode_dirty_sync(inode, true);
>   
>   	if (!f2fs_is_compress_backend_ready(inode))
> @@ -4221,7 +4246,9 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   	case F2FS_IOC_GET_COMPRESS_OPTION:
>   		return f2fs_ioc_get_compress_option(filp, arg);
>   	case F2FS_IOC_SET_COMPRESS_OPTION:
> -		return f2fs_ioc_set_compress_option(filp, arg);
> +		return f2fs_ioc_set_compress_option(filp, arg, F2FS_IOC_SET_COMPRESS_OPTION);
> +	case F2FS_IOC_SET_COMPRESS_OPTION_V2:
> +		return f2fs_ioc_set_compress_option(filp, arg, F2FS_IOC_SET_COMPRESS_OPTION_V2);

It needs to adapt f2fs_compat_ioctl() as well.

>   	case F2FS_IOC_DECOMPRESS_FILE:
>   		return f2fs_ioc_decompress_file(filp, arg);
>   	case F2FS_IOC_COMPRESS_FILE:
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index 955d440be104..aaf7f55273fb 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -43,6 +43,8 @@
>   #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
>   #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
>   #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
> +#define F2FS_IOC_SET_COMPRESS_OPTION_V2	_IOW(F2FS_IOCTL_MAGIC, 26,	\
> +						struct f2fs_comp_option_v2)
>   
>   /*
>    * should be same as XFS_IOC_GOINGDOWN.
> @@ -62,6 +64,15 @@
>   #define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
>   #define F2FS_TRIM_FILE_MASK		0x3
>   
> +/*
> + * Flags used by F2FS_IOC_SET_COMPRESS_OPTION_V2
> + */
> +#define COMPRESS_CHKSUM				0x0 /* enable chksum for compress file */
> +#define COMPRESS_LEVEL_OFFSET	8
> +#define COMPRESS_LEVEL_MASK		GENMASK(15, COMPRESS_LEVEL_OFFSET)
> +#define COMPRESS_OPTION_MASK	(COMPRESS_LEVEL_MASK | BIT(COMPRESS_CHKSUM))
> +#define GET_COMPRESS_LEVEL(x)	(((x) & COMPRESS_LEVEL_MASK) >> COMPRESS_LEVEL_OFFSET)
> +
>   struct f2fs_gc_range {
>   	__u32 sync;
>   	__u64 start;
> @@ -96,4 +107,14 @@ struct f2fs_comp_option {
>   	__u8 log_cluster_size;
>   };
>   
> +struct f2fs_comp_option_v2 {
> +	union {
> +		struct {
> +			__u8 algorithm;
> +			__u8 log_cluster_size;
> +			__u16 compress_flag;
> +		};
> +		struct f2fs_comp_option option;
> +	};
> +};

It looks using union may simply the implementation, but readability of new structure
becomes worse, since this structure will be exposed to user as an uapi interface, I
guess we'd better to consider more about its readability, thought?

Thanks,

>   #endif /* _UAPI_LINUX_F2FS_H */
