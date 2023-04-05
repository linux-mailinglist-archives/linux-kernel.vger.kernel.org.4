Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4966D7299
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjDECwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjDECv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBC035BB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82176622B7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1957DC433EF;
        Wed,  5 Apr 2023 02:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680663117;
        bh=1fWeJBdYiBKbc3l99oUMDbBH7uYf9rS5M3WkIzgGIGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KmJ67J2KKMHo6NlKpq988i4aesqcBIiO0vVXFFxrNDf03IH7JKCNPWRKVOE1vMYbE
         6Rn3o0CsycQqUoebDo6oCYfNviz7+v0J5qNjqvE8rF+zMNuxw3iN9NQJPuG6Yc5bzf
         oD3SsMjCTvBHltjrmCeqww9GH9rrZlhqEqWNJHO/xy9osfiCnmcL2ElY5uuCw/NSsk
         lkd6vJRSlJPXmzDt2i/3pXuGelXOycarQJVGAXO7ftVSZBQBs6s4bwebYbk9eisxCx
         1yMIhX8JLVd/pvYHkuYYij7yYE8eu3bMyEoSCxANQiQLnzeCrz6rmV7ZDwopFWH141
         vaZv2C5kiuQCg==
Message-ID: <b5f99276-29cd-ca61-abc2-a927d992f40a@kernel.org>
Date:   Wed, 5 Apr 2023 10:51:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND] f2fs: set default compress option only when
 sb_has_compression
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230330165648.33907-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230330165648.33907-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 0:56, Yangtao Li wrote:
> If the compress feature is not enabled, there is no need to set
> compress-related parameters.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Patch looks fine, but it's better to fix similar issues in one
patch.

e.g.
f2fs: add compression feature check for all compress mount opt

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/super.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 768be1c76a47..b5828a67f7c1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2073,10 +2073,12 @@ static void default_options(struct f2fs_sb_info *sbi)
>   	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
>   	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
>   	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
> -	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
> -	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
> -	F2FS_OPTION(sbi).compress_ext_cnt = 0;
> -	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
> +	if (f2fs_sb_has_compression(sbi)) {
> +		F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
> +		F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
> +		F2FS_OPTION(sbi).compress_ext_cnt = 0;
> +		F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
> +	}
>   	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
>   	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
>   
