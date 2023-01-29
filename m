Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA04767FE23
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjA2KV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2KVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:21:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B8B22DD4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:21:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FBC160C95
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 10:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7217BC433EF;
        Sun, 29 Jan 2023 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674987681;
        bh=GSdKAo92nai0wbeJYq4a7V9fH+8wliaNJ599WdgV9W4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jOOOKQProIT7qWbY5uBYX46HpTgNT7wClnjsnmQg46EDdi7zaHDLshipccmPt7i9/
         zIa6XhEP4c65i22SwHgQ8eVlqcRbelxECL7ncJfrQLEGhY2Uc7lZm4gqBhk3r0lstt
         7zuBSDebOTVflwFcOr6F3Zjei0hzbQE6L+qbRiYFQ2OdSYPi9z3UtoiUorqCSeuLll
         7t5Z90o3///f6jD9Sqg2LFkn+C5SibCTtCfc7BUBZZkFNq5+97+iBmZy6/dE+x8y5M
         8brH30t2DN8W9lxAvsYRFWZ8gni/cbhsgr1VuWA3kBaMPD0CN5TrW8Q3r+4bhPuo+Y
         4i75tzicWS77Q==
Message-ID: <99e4e218-d9a4-93d1-c0d3-9ba01da21093@kernel.org>
Date:   Sun, 29 Jan 2023 18:21:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] f2fs: fix to check lz4hc compression when
 CONFIG_F2FS_FS_LZ4HC is not enabled
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230124153346.74881-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230124153346.74881-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/24 23:33, Yangtao Li wrote:
> f2fs supports lz4 compression algorithm and lz4hc compression algorithm,
> which the level parameter needs to be passed in. When CONFIG_F2FS_FS_LZ4HC
> is not enabled, even if there is no problem with the level parameter, add
> the level parameter to the lz4 algorithm will cause the mount to fail.
> 
> Let's change it to be the same as other compression algorithms. When the
> kernel does not enable the algorithm, ignore this parameter and print msg.
> 
> Fixes: 3fde13f817e2 ("f2fs: compress: support compress level")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/super.c | 31 ++++++++++++++-----------------
>   1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d8a65645ee48..ad5df4d5c39a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -588,19 +588,11 @@ static int f2fs_test_compress_extension(struct f2fs_sb_info *sbi)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_F2FS_FS_LZ4
> +#ifdef CONFIG_F2FS_FS_LZ4HC
>   static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
>   {
> -#ifdef CONFIG_F2FS_FS_LZ4HC
>   	unsigned int level;
> -#endif
>   
> -	if (strlen(str) == 3) {
> -		F2FS_OPTION(sbi).compress_level = 0;
> -		return 0;
> -	}
> -
> -#ifdef CONFIG_F2FS_FS_LZ4HC
>   	str += 3;
>   
>   	if (str[0] != ':') {
> @@ -617,10 +609,6 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
>   
>   	F2FS_OPTION(sbi).compress_level = level;
>   	return 0;
> -#else
> -	f2fs_info(sbi, "kernel doesn't support lz4hc compression");
> -	return -EINVAL;
> -#endif
>   }
>   #endif
>   
> @@ -1085,10 +1073,19 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   #endif
>   			} else if (!strncmp(name, "lz4", 3)) {
>   #ifdef CONFIG_F2FS_FS_LZ4
> -				ret = f2fs_set_lz4hc_level(sbi, name);
> -				if (ret) {
> -					kfree(name);
> -					return -EINVAL;
> +				if (strlen(name) == 3) {
> +					F2FS_OPTION(sbi).compress_level = 0;
> +				} else {
> +#ifdef CONFIG_F2FS_FS_LZ4HC
> +					ret = f2fs_set_lz4hc_level(sbi, name);
> +					if (ret) {
> +						kfree(name);
> +						return -EINVAL;
> +					}
> +#else
> +					f2fs_info(sbi, "kernel doesn't support lz4hc compression");

It needs to check <alg_name>:<compr_level> format to make sure user wants to
enable lz4hc w/ specified level, otherwise if parameter is lz4xx, it doesn't
make sense to print:

"kernel doesn't support lz4hc compression"

> +					break;

It will cause memory leak for name.

Thanks,

> +#endif
>   				}
>   				F2FS_OPTION(sbi).compress_algorithm =
>   								COMPRESS_LZ4;
