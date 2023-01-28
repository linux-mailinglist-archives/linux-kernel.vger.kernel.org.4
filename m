Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533FD67F764
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjA1Kwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjA1Kwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:52:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596C59023
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:52:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0289DB808C9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED95C433D2;
        Sat, 28 Jan 2023 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674903159;
        bh=mU2sofQsfLRtbvo6AS8tXDrNPsvRuHKvOKXxOJsK5ww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H8+yTe4zMaG4kMrrje1tbCEoSzqBK3kbi9G6RiLUrfEDxSAuxgHPwfUZE+wU+/4iN
         KcaUHqPOCdoy1yJZjJurz5omB73iS0rpuE+SWjrcBcLllKI76JUb0GaTmS5vfELYEg
         arjNt6Hnm8iu/0IZ9tjTV2/3/3pT6EdT1q/gffYNuXI5TGtc5lmH+BMQv6hffFmVzf
         gMw1EHEioncmp27vPIVzqbCfuj4Cp3/wn88MHnpM0LinFkpDaywdCsOxdvBWNsWsBH
         OIb0mRIrLZAFw0Au4mri+pTt5mp465NpQwe9XWzw1+WvSZolCfFqMK+npjDh5BJ+Jk
         /wjLBM0KqYIbw==
Message-ID: <70c2cbde-3443-7833-68cc-646a65b11d81@kernel.org>
Date:   Sat, 28 Jan 2023 18:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: convert is_extension_exist() to return bool type
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230112143151.23921-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230112143151.23921-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/12 22:31, Yangtao Li wrote:
> is_extension_exist() only return two values, 0 or 1.
> So there is no need to use int type.

It's too trivial to do such change one by one, how about merging all
similar changes into one patch?

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/namei.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 6032589099ce..516968cbc6d6 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -22,7 +22,7 @@
>   #include "acl.h"
>   #include <trace/events/f2fs.h>
>   
> -static inline int is_extension_exist(const unsigned char *s, const char *sub,
> +static inline bool is_extension_exist(const unsigned char *s, const char *sub,
>   						bool tmp_ext)
>   {
>   	size_t slen = strlen(s);
> @@ -30,19 +30,19 @@ static inline int is_extension_exist(const unsigned char *s, const char *sub,
>   	int i;
>   
>   	if (sublen == 1 && *sub == '*')
> -		return 1;
> +		return true;
>   
>   	/*
>   	 * filename format of multimedia file should be defined as:
>   	 * "filename + '.' + extension + (optional: '.' + temp extension)".
>   	 */
>   	if (slen < sublen + 2)
> -		return 0;
> +		return false;
>   
>   	if (!tmp_ext) {
>   		/* file has no temp extension */
>   		if (s[slen - sublen - 1] != '.')
> -			return 0;
> +			return false;
>   		return !strncasecmp(s + slen - sublen, sub, sublen);
>   	}
>   
> @@ -50,10 +50,10 @@ static inline int is_extension_exist(const unsigned char *s, const char *sub,
>   		if (s[i] != '.')
>   			continue;
>   		if (!strncasecmp(s + i + 1, sub, sublen))
> -			return 1;
> +			return true;
>   	}
>   
> -	return 0;
> +	return false;
>   }
>   
>   int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
