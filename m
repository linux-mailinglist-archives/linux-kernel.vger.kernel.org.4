Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5832872D434
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbjFLWOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFLWOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406210C2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E20EB62C03
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA97C433D2;
        Mon, 12 Jun 2023 22:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686608084;
        bh=/4GR9Hf1ASwJkuX0BXgNzC6bOV/3dAkzoO7nR0gcVMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tf3wLXVKRuYFAJRgyhnirYHZlD6zj0nqI8Iz1cWqkKsSY0W/Oc7Uc6+c1aedVtb3u
         fIPtW7zHHHWCNTu0KtyyAcpQfJL2goJieV7p9ysE7kwDVK0nfJ/Y/AX19UQP9EeoWu
         cAp0wwjx7jbTOY15d5ILJuYz8f4ODEL4arghzgYQE5X18OxfULSjm8MxwZ8QV/6z36
         TEgBMUwGGNBcV1dToYTIfyOTbs1hYLkWIZcwKC2FlZzCxeADlUfx5f0blhWX/XSG/h
         GMEqFphosIyzkwUanZVeHqaPfp+q0TAyYqjO8XivKq4jDtaOhsX2SgOcJWrkISVAnt
         vYA2mhy0+GP4Q==
Date:   Mon, 12 Jun 2023 15:14:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sheng Yong <shengyong@oppo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v4 1/6] f2fs: add helper to check compression level
Message-ID: <ZIeY0qNjXgx419NZ@google.com>
References: <20230612030121.2393541-1-shengyong@oppo.com>
 <20230612030121.2393541-2-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612030121.2393541-2-shengyong@oppo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please check this version?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=9c84aad379019a0d86655bb50bd7b4bc92683c4b

On 06/12, Sheng Yong wrote:
> This patch adds a helper function to check if compression level is
> valid.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>  fs/f2fs/compress.c | 31 +++++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h     |  2 ++
>  fs/f2fs/super.c    |  4 ++--
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 1132d3cd8f337..63a496137ebe7 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -55,6 +55,7 @@ struct f2fs_compress_ops {
>  	int (*init_decompress_ctx)(struct decompress_io_ctx *dic);
>  	void (*destroy_decompress_ctx)(struct decompress_io_ctx *dic);
>  	int (*decompress_pages)(struct decompress_io_ctx *dic);
> +	bool (*is_level_valid)(int level);
>  };
>  
>  static unsigned int offset_in_cluster(struct compress_ctx *cc, pgoff_t index)
> @@ -308,11 +309,23 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
>  	return 0;
>  }
>  
> +static bool lz4_is_level_valid(int lvl)
> +{
> +	if (lvl == 0)
> +		return true;
> +#ifdef CONFIG_F2FS_FS_LZ4HC
> +	if (lvl >= LZ4HC_MIN_CLEVEL && lvl <= LZ4HC_MAX_CLEVEL)
> +		return true;
> +#endif
> +	return false;
> +}
> +
>  static const struct f2fs_compress_ops f2fs_lz4_ops = {
>  	.init_compress_ctx	= lz4_init_compress_ctx,
>  	.destroy_compress_ctx	= lz4_destroy_compress_ctx,
>  	.compress_pages		= lz4_compress_pages,
>  	.decompress_pages	= lz4_decompress_pages,
> +	.is_level_valid		= lz4_is_level_valid,
>  };
>  #endif
>  
> @@ -477,6 +490,13 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
>  	return 0;
>  }
>  
> +static bool zstd_is_level_valid(int lvl)
> +{
> +	if (lvl < zstd_min_clevel() || lvl > zstd_max_clevel())
> +		return false;
> +	return true;
> +}
> +
>  static const struct f2fs_compress_ops f2fs_zstd_ops = {
>  	.init_compress_ctx	= zstd_init_compress_ctx,
>  	.destroy_compress_ctx	= zstd_destroy_compress_ctx,
> @@ -484,6 +504,7 @@ static const struct f2fs_compress_ops f2fs_zstd_ops = {
>  	.init_decompress_ctx	= zstd_init_decompress_ctx,
>  	.destroy_decompress_ctx	= zstd_destroy_decompress_ctx,
>  	.decompress_pages	= zstd_decompress_pages,
> +	.is_level_valid		= zstd_is_level_valid,
>  };
>  #endif
>  
> @@ -542,6 +563,16 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
>  	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
>  }
>  
> +bool f2fs_is_compress_level_valid(int alg, int lvl)
> +{
> +	const struct f2fs_compress_ops *cops = f2fs_cops[alg];
> +
> +	if (cops->is_level_valid)
> +		return cops->is_level_valid(lvl);
> +
> +	return lvl == 0;
> +}
> +
>  static mempool_t *compress_page_pool;
>  static int num_compress_pages = 512;
>  module_param(num_compress_pages, uint, 0444);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 80c783215b5a3..1b17bbe7e8656 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4236,6 +4236,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
>  int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
>  void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
>  bool f2fs_is_compress_backend_ready(struct inode *inode);
> +bool f2fs_is_compress_level_valid(int alg, int lvl);
>  int __init f2fs_init_compress_mempool(void);
>  void f2fs_destroy_compress_mempool(void);
>  void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task);
> @@ -4300,6 +4301,7 @@ static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
>  	/* not support compression */
>  	return false;
>  }
> +static inline bool f2fs_is_compress_level_valid(int alg, int lvl) { return false; }
>  static inline struct page *f2fs_compress_control_page(struct page *page)
>  {
>  	WARN_ON_ONCE(1);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 8fd23caa1ed99..023981824d240 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -606,7 +606,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
>  	if (kstrtouint(str + 1, 10, &level))
>  		return -EINVAL;
>  
> -	if (level < LZ4HC_MIN_CLEVEL || level > LZ4HC_MAX_CLEVEL) {
> +	if (!f2fs_is_compress_level_valid(COMPRESS_LZ4, level)) {
>  		f2fs_info(sbi, "invalid lz4hc compress level: %d", level);
>  		return -EINVAL;
>  	}
> @@ -640,7 +640,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
>  	if (kstrtouint(str + 1, 10, &level))
>  		return -EINVAL;
>  
> -	if (!level || level > zstd_max_clevel()) {
> +	if (!f2fs_is_compress_level_valid(COMPRESS_ZSTD, level)) {
>  		f2fs_info(sbi, "invalid zstd compress level: %d", level);
>  		return -EINVAL;
>  	}
> -- 
> 2.40.1
