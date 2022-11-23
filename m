Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1401636460
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiKWPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiKWPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:46:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F32C5618
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:46:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E75C761DB4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96649C433C1;
        Wed, 23 Nov 2022 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669218410;
        bh=fMHohl1y+955lLmTpi2tLvD/r7UkVxQuFIwe8yXhFKU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=kZ54ClvGRAcCRbo4yafEeK1LZ+WQvZGty/fSORkFZ6PEfvLkzVyHVTOf7G3NVOGjW
         lB83NmIgIjrbdCowUVihhcit5mfRHW98PK1dwP1e1y0WRZOmvI5EAczJDOHPm0qZ8/
         R1QfEnq8wDpPBzxf0HO7pRPfhUx1Vh5jTfwFPC+ONEHt3k+jcCh2XvgdK8vvSRUcXY
         JsjLXwQY9sG4L0tb5XOhL2pQ6KL9SwHnOhD26l6XjKtvpErzxSCuFjVfm9mI1Xhq1C
         yh6/wnCK+sAkLeaYlh1VDQKZrmDkScMvjynJvhDgsXKp+ho8Sdq2NUOjjWlsaRDlxz
         7X9FqAWzaO2pQ==
Message-ID: <6565e795-d0bb-1e96-7c8e-94409dfd69cb@kernel.org>
Date:   Wed, 23 Nov 2022 23:46:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221118180208.66578-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: define DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY
 macro
In-Reply-To: <20221118180208.66578-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/19 2:02, Yangtao Li wrote:
> Do cleanup in f2fs_tuning_parameters(), let's use macro
> instead of number.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h  | 2 ++
>   fs/f2fs/super.c | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f0833638f59e..86c651884d26 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -329,6 +329,8 @@ struct discard_entry {
>   	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
>   };
>   
> +/* default discard granularity for small device, unit: block count */
> +#define DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY 1

/* minimum discard granularity, unit: block count */
#define MIN_DISCARD_GRANULARITY		1

>   /* default discard granularity of inner discard thread, unit: block count */
>   #define DEFAULT_DISCARD_GRANULARITY		16
>   /* default maximum discard granularity of ordered discard, unit: block count */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 31435c8645c8..7c32eabcf50c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4080,7 +4080,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>   	/* adjust parameters according to the volume size */
>   	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
>   		if (f2fs_block_unit_discard(sbi))
> -			SM_I(sbi)->dcc_info->discard_granularity = 1;
> +			SM_I(sbi)->dcc_info->discard_granularity = DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY;

			SM_I(sbi)->dcc_info->discard_granularity =
						MIN_DISCARD_GRANULARITY;

Thanks,

>   		SM_I(sbi)->ipu_policy = 1 << F2FS_IPU_FORCE |
>   					1 << F2FS_IPU_HONOR_OPU_WRITE;
>   	}
