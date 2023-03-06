Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0976AB6FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCFHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCFHZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:25:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F581E9E4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:24:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso12274233pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678087490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKlzZQBbx8Ter2lhATPYQcJay8VqdR1ZSrNzv2WTgbQ=;
        b=COO17Sc1AVr9krdlvXQjuBwlqbLnJQqKkGLTxweRsYfhJe4OZWfyJr/VzmZP5vMZmO
         CDgcz5Nt66+SI7X48YHMgLQNYEdxsdL1RkEtHEUiusYcYb0HaMLDTdAQ1scO45uD+ic6
         DXsNEEyQPLOHSHx5XA1xrMX9ANxw62pG32xRilICvMKoJFQASK66sAJ40tazPO1IZPxo
         9TqC2SJv92w+QxFXYFZkY9qB6j+baCKKJfMJofdCqBjjKqel45Bt06FmRMEoZeaJ/J5C
         c/S6+hIXZdsps9gGmuRjI46pTDvq+gX6AJnPi8Km/4odLmrikwbYSQdyUq631zANi1Kp
         mTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678087490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKlzZQBbx8Ter2lhATPYQcJay8VqdR1ZSrNzv2WTgbQ=;
        b=IALRvMnv0isO82gulYRnJfji1EzDhFD+tq1y4HUtt1jQ5Fd2doVKWrz0Cs88SCEoVs
         txOtK3DBTtg0JzH+XkeDofyUYixWSfDqFMJTinnxIEedE0bEFYs+4ts8tJnbymX8j24n
         Y4sXP7oV640x8boxaOql8CgJ7gNKquX/Q7vpKpnkZUIyQg9WaurCu/LaLBPifzwRAEfG
         47bEpDZYUMF97XcVzWl5tgPECRfg21dn3JbAv6DR34Slvhgo78cZIuamjN/CHXsPBqQT
         oeIJVGIvrIOndiuobfoQ3NjkOvie2qwLXzRy50i++WG+q/IKr1FE/NSPFm1n2o8X8t8N
         XJtg==
X-Gm-Message-State: AO0yUKV6mt0u6i/q2rnYNBu/UYRy9kQfA/RchVSz4KPGTlYXv/qX3R/U
        OinZiYvha+iSYa62XUf4aMM=
X-Google-Smtp-Source: AK7set8caiGRvGIczzdy6Wj3C4F2SQY4MG/++pZaGOaHwQJwScl66NEye7GjrW9nRqyjOx4+28x38A==
X-Received: by 2002:a17:902:8a96:b0:19e:61cc:6793 with SMTP id p22-20020a1709028a9600b0019e61cc6793mr9747516plo.48.1678087490256;
        Sun, 05 Mar 2023 23:24:50 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b0019a97a4324dsm5994537plg.5.2023.03.05.23.24.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Mar 2023 23:24:50 -0800 (PST)
Date:   Mon, 6 Mar 2023 15:31:08 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH v4 2/2] erofs: set block size to the on-disk block size
Message-ID: <20230306153108.00006877.zbestahu@gmail.com>
In-Reply-To: <20230302143915.111739-3-jefflexu@linux.alibaba.com>
References: <20230302143915.111739-1-jefflexu@linux.alibaba.com>
        <20230302143915.111739-3-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Mar 2023 22:39:15 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Set the block size to that specified in on-disk superblock.
> 
> Also remove the hard constraint of PAGE_SIZE block size for the
> uncompressed device backend.  This constraint is temporarily remained
> for compressed device and fscache backend, as there is more work needed
> to handle the condition where the block size is not equal to PAGE_SIZE.
> 
> It is worth noting that the on-disk block size is read prior to
> erofs_superblock_csum_verify(), as the read block size is needed in the
> latter.
> 
> Besides, later we are going to make erofs refer to tar data blobs (which
> is 512-byte aligned) for OCI containers, where the block size is 512
> bytes.  In this case, the 512-byte block size may not be adequate for a
> directory to contain enough dirents.  To fix this, we are also going to
> introduce directory block size independent on the block size.
> 
> Due to we have already supported block size smaller than PAGE_SIZE now,
> disable all these images with such separated directory block size until
> we supported this feature later.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h |  5 +++--
>  fs/erofs/inode.c    |  3 ++-
>  fs/erofs/internal.h | 11 ++---------
>  fs/erofs/super.c    | 46 +++++++++++++++++++++++++++++----------------
>  4 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index dbcd24371002..ac9c2ff3aa66 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -53,7 +53,7 @@ struct erofs_super_block {
>  	__le32 magic;           /* file system magic number */
>  	__le32 checksum;        /* crc32c(super_block) */
>  	__le32 feature_compat;
> -	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> +	__u8 blkszbits;         /* filesystem block size */

/* filesystem block size in bit shift */

>  	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
>  
>  	__le16 root_nid;	/* nid of root directory */
> @@ -75,7 +75,8 @@ struct erofs_super_block {
>  	} __packed u1;
>  	__le16 extra_devices;	/* # of devices besides the primary device */
>  	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
> -	__u8 reserved[6];
> +	__u8 dirblkbits;	/* directory block size */

Ditto.

> +	__u8 reserved[5];
>  	__le64 packed_nid;	/* nid of the special packed inode */
>  	__u8 reserved2[24];
>  };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index de26dac4e07e..0e6ff8a98c68 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -291,7 +291,8 @@ static int erofs_fill_inode(struct inode *inode)
>  	}
>  
>  	if (erofs_inode_is_data_compressed(vi->datalayout)) {
> -		if (!erofs_is_fscache_mode(inode->i_sb))
> +		if (!erofs_is_fscache_mode(inode->i_sb) &&
> +		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
>  			err = z_erofs_fill_inode(inode);
>  		else
>  			err = -EOPNOTSUPP;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index d8019d835405..f99ba4061a3b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -148,7 +148,8 @@ struct erofs_sb_info {
>  	u16 device_id_mask;	/* valid bits of device id to be used */
>  
>  	unsigned char islotbits;	/* inode slot unit size in bit shift */
> -	unsigned char blkszbits;
> +	unsigned char blkszbits;	/* filesystem block size */

Ditto.

> +	unsigned char dirblkbits;	/* directory block size */

Ditto.

>  
>  	u32 sb_size;			/* total superblock size */
>  	u32 build_time_nsec;
> @@ -240,14 +241,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>  					VAL != EROFS_LOCKED_MAGIC);
>  }
>  
> -/* we strictly follow PAGE_SIZE and no buffer head yet */
> -#define LOG_BLOCK_SIZE		PAGE_SHIFT
> -#define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
> -
> -#if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
> -#error erofs cannot be used in this platform
> -#endif
> -
>  enum erofs_kmap_type {
>  	EROFS_NO_KMAP,		/* don't map the buffer */
>  	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c97615c96ef8..d5fa0f582cbe 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -330,7 +330,6 @@ static int erofs_read_superblock(struct super_block *sb)
>  	struct erofs_sb_info *sbi;
>  	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	struct erofs_super_block *dsb;
> -	unsigned int blkszbits;
>  	void *data;
>  	int ret;
>  
> @@ -349,6 +348,17 @@ static int erofs_read_superblock(struct super_block *sb)
>  		goto out;
>  	}
>  
> +	sbi->blkszbits  = dsb->blkszbits;
> +	sbi->dirblkbits = dsb->dirblkbits;
> +	if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
> +		erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
> +		goto out;
> +	}
> +	if (sbi->dirblkbits) {
> +		erofs_err(sb, "dirblkbits %u isn't supported", sbi->dirblkbits);
> +		goto out;
> +	}
> +
>  	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
>  	if (erofs_sb_has_sb_chksum(sbi)) {
>  		ret = erofs_superblock_csum_verify(sb, data);
> @@ -357,19 +367,11 @@ static int erofs_read_superblock(struct super_block *sb)
>  	}
>  
>  	ret = -EINVAL;
> -	blkszbits = dsb->blkszbits;
> -	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
> -	if (blkszbits != LOG_BLOCK_SIZE) {
> -		erofs_err(sb, "blkszbits %u isn't supported on this platform",
> -			  blkszbits);
> -		goto out;
> -	}
> -
>  	if (!check_layout_compatibility(sb, dsb))
>  		goto out;
>  
>  	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
> -	if (sbi->sb_size > EROFS_BLKSIZ) {
> +	if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
>  		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
>  			  sbi->sb_size);
>  		goto out;
> @@ -736,8 +738,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	sbi->blkszbits = PAGE_SHIFT;
>  	if (erofs_is_fscache_mode(sb)) {
> -		sb->s_blocksize = EROFS_BLKSIZ;
> -		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
> +		sb->s_blocksize = PAGE_SIZE;
> +		sb->s_blocksize_bits = PAGE_SHIFT;
>  
>  		err = erofs_fscache_register_fs(sb);
>  		if (err)
> @@ -747,8 +749,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  		if (err)
>  			return err;
>  	} else {
> -		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
> -			erofs_err(sb, "failed to set erofs blksize");
> +		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
> +			errorfc(fc, "failed to set initial blksize");
>  			return -EINVAL;
>  		}
>  
> @@ -761,12 +763,24 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (err)
>  		return err;
>  
> -	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
> -		BUILD_BUG_ON(EROFS_BLKSIZ != PAGE_SIZE);
> +	if (sb->s_blocksize_bits != sbi->blkszbits) {
> +		if (erofs_is_fscache_mode(sb)) {
> +			errorfc(fc, "unsupported blksize for fscache mode");
> +			return -EINVAL;
> +		}
> +		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
> +			errorfc(fc, "failed to set erofs blksize");
> +			return -EINVAL;
> +		}
> +	}
>  
> +	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
>  		if (!sbi->dax_dev) {
>  			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
>  			clear_opt(&sbi->opt, DAX_ALWAYS);
> +		} else if (sbi->blkszbits != PAGE_SHIFT) {
> +			errorfc(fc, "unsupported blocksize for DAX");
> +			clear_opt(&sbi->opt, DAX_ALWAYS);
>  		}
>  	}
>  

