Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB9672EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjASCPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjASCPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF567963
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:15:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0B0261A00
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108E2C43392;
        Thu, 19 Jan 2023 02:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674094532;
        bh=/ltzt1Csvme38n0fgFnKgL3v4ZrlbvWtk/qKHYPTuKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZwBvMQ8J2a8d74b5+qWBj0Sg2Pz1MqrqBX5s/RCOY2CMm/15OKkU5OJo8TVJ50A3
         3MGsro7MojCMTSZAl5qwRz7BZxeACUgEB4rcengZCYoqFaJhEDUuMUEF5g+yFxyqNX
         mMkNLyXmIHr5yC+vz6oYt3SQa/yr1QIEg63rO7zVn0obUkpjlW/4xOb2sVtkNTLM7b
         b1obWw+aqf+rcZw8iiOgUFNK37IupLEIuou7nVE9a9ifMwN+DWzlXRBPw0b8NHXd1P
         61UlgHnPOdOCj9UXRdaTAWC56a6BPRDmFShuzEoAudtYVSjC6x86cQZvYP2uoGIBQz
         +um6MNQTFERCA==
Date:   Wed, 18 Jan 2023 18:15:30 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: add compression feature check for all compress
 mount opt
Message-ID: <Y8inwtRzVHXsxxyT@google.com>
References: <20230112201032.66300-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112201032.66300-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/13, Yangtao Li wrote:
> Opt_compress_chksum, Opt_compress_mode and Opt_compress_cache
> lack the necessary check to see if the image supports compression,
> let's add it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 55 +++++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 5fc83771042d..8ef1449272b3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -89,7 +89,7 @@ static struct shrinker f2fs_shrinker_info = {
>  	.seeks = DEFAULT_SEEKS,
>  };
>  
> -enum {
> +enum f2fs_mount_opt {
>  	Opt_gc_background,
>  	Opt_disable_roll_forward,
>  	Opt_norecovery,
> @@ -655,6 +655,30 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
>  #endif
>  #endif
>  
> +static bool f2fs_mount_opt_need_skip(struct f2fs_sb_info *sbi, enum f2fs_mount_opt opt)
> +{
> +	switch (opt) {
> +	case Opt_compress_algorithm:
> +	case Opt_compress_log_size:
> +	case Opt_compress_extension:
> +	case Opt_nocompress_extension:
> +	case Opt_compress_chksum:
> +	case Opt_compress_mode:
> +	case Opt_compress_cache:
> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> +		if (f2fs_sb_has_compression(sbi))
> +			return false;
> +
> +		f2fs_info(sbi, "Image doesn't support compression");
> +#else
> +		f2fs_info(sbi, "compression options not supported");
> +#endif
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> @@ -685,6 +709,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		args[0].to = args[0].from = NULL;
>  		token = match_token(p, f2fs_tokens, args);
>  
> +		if (f2fs_mount_opt_need_skip(sbi, token))
> +			continue;

It seems this changes the behavior?

> +
>  		switch (token) {
>  		case Opt_gc_background:
>  			name = match_strdup(&args[0]);
> @@ -1068,10 +1095,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			break;
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  		case Opt_compress_algorithm:
> -			if (!f2fs_sb_has_compression(sbi)) {
> -				f2fs_info(sbi, "Image doesn't support compression");
> -				break;
> -			}
>  			name = match_strdup(&args[0]);
>  			if (!name)
>  				return -ENOMEM;
> @@ -1122,10 +1145,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			kfree(name);
>  			break;
>  		case Opt_compress_log_size:
> -			if (!f2fs_sb_has_compression(sbi)) {
> -				f2fs_info(sbi, "Image doesn't support compression");
> -				break;
> -			}
>  			if (args->from && match_int(args, &arg))
>  				return -EINVAL;
>  			if (arg < MIN_COMPRESS_LOG_SIZE ||
> @@ -1137,10 +1156,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			F2FS_OPTION(sbi).compress_log_size = arg;
>  			break;
>  		case Opt_compress_extension:
> -			if (!f2fs_sb_has_compression(sbi)) {
> -				f2fs_info(sbi, "Image doesn't support compression");
> -				break;
> -			}
>  			name = match_strdup(&args[0]);
>  			if (!name)
>  				return -ENOMEM;
> @@ -1161,10 +1176,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			kfree(name);
>  			break;
>  		case Opt_nocompress_extension:
> -			if (!f2fs_sb_has_compression(sbi)) {
> -				f2fs_info(sbi, "Image doesn't support compression");
> -				break;
> -			}
>  			name = match_strdup(&args[0]);
>  			if (!name)
>  				return -ENOMEM;
> @@ -1204,16 +1215,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		case Opt_compress_cache:
>  			set_opt(sbi, COMPRESS_CACHE);
>  			break;
> -#else
> -		case Opt_compress_algorithm:
> -		case Opt_compress_log_size:
> -		case Opt_compress_extension:
> -		case Opt_nocompress_extension:
> -		case Opt_compress_chksum:
> -		case Opt_compress_mode:
> -		case Opt_compress_cache:
> -			f2fs_info(sbi, "compression options not supported");
> -			break;
>  #endif
>  		case Opt_atgc:
>  			set_opt(sbi, ATGC);
> -- 
> 2.25.1
