Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7973AE66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFWBl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjFWBl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765072114
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A12C61939
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7AAC433C0;
        Fri, 23 Jun 2023 01:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687484514;
        bh=I2aZF3V0Z194tldhoqu9fKjJ+bgd1Czgm3Eg3VR8zX8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=rlph2JL+wWLr52ep9ZVnZ0edZ7FFq80p8L3yLNatM0oeTsYwPig61CKK2hWB8BocS
         cTR9vIzo8Oh5xDhxkAzlWo79OyyKna/THtGn4GrYiR4fgOZ/CWMryT/0eynODfEPP/
         eJ3x1ZgLgRPfZ0Tn47D8YGgseG8azaJ5mZac6PIpKJb35Yi5Ld+AK4BgMIDoCxU7/r
         doI5wmjMdB1oa7NKWdpOfvVRgkk6VbQsLvr4XhvlKUbK0KJPsJFhmktvVUTgCosmdE
         2Ls1oteh5t72Ah2VjAvKpzHGLCkK8Ax0aU6YKQ0vm7x+bxAmJZXUv77OmXHEBnLH/J
         H7W1h0A5OuQSQ==
Message-ID: <768b0591-ba30-ba0e-0992-2f312ac76f16@kernel.org>
Date:   Fri, 23 Jun 2023 09:41:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress tmp files given extension
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
 <ZIjqKHDUmN6u9pXa@google.com> <ZJP0aoy03Vx2Q2K1@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZJP0aoy03Vx2Q2K1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/22 15:12, Jaegeuk Kim wrote:
> Let's compress tmp files for the given extension list.
> 
> This patch does not change the previous behavior, but allow the cases as below.
> 
> Extention example: "ext"
> 
> - abc.ext : allow
> - abc.ext.abc : allow
> - abc.extm : not allow
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>    Change log from v2:
>     - fix parameters
> 
>    Change log from v1:
>     - refactor to allow abc.ext.dontcare only
> 
>   fs/f2fs/namei.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 3e35eb7dbb8f..80806ce1289f 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -23,7 +23,7 @@
>   #include <trace/events/f2fs.h>
>   
>   static inline bool is_extension_exist(const unsigned char *s, const char *sub,
> -						bool tmp_ext)
> +						bool tmp_ext, bool tmp_dot)
>   {
>   	size_t slen = strlen(s);
>   	size_t sublen = strlen(sub);
> @@ -49,8 +49,12 @@ static inline bool is_extension_exist(const unsigned char *s, const char *sub,
>   	for (i = 1; i < slen - sublen; i++) {
>   		if (s[i] != '.')
>   			continue;
> -		if (!strncasecmp(s + i + 1, sub, sublen))
> -			return true;
> +		if (!strncasecmp(s + i + 1, sub, sublen)) {
> +			if (!tmp_dot)
> +				return true;
> +			if (i == slen - sublen - 1 || s[i + 1 + sublen] == '.')
> +				return true;
> +		}
>   	}
>   
>   	return false;
> @@ -148,7 +152,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
>   	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
>   	hot_count = sbi->raw_super->hot_ext_count;
>   	for (i = cold_count; i < cold_count + hot_count; i++)
> -		if (is_extension_exist(name, extlist[i], false))
> +		if (is_extension_exist(name, extlist[i], true, false))
>   			break;
>   	f2fs_up_read(&sbi->sb_lock);
>   	if (i < (cold_count + hot_count))
> @@ -156,12 +160,12 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
>   
>   	/* Don't compress unallowed extension. */
>   	for (i = 0; i < noext_cnt; i++)
> -		if (is_extension_exist(name, noext[i], false))
> +		if (is_extension_exist(name, noext[i], true, false))

is_extension_exist(name, ext[i], true, true) ?

Thanks,

>   			return;
>   
>   	/* Compress wanting extension. */
>   	for (i = 0; i < ext_cnt; i++) {
> -		if (is_extension_exist(name, ext[i], false)) {
> +		if (is_extension_exist(name, ext[i], true, true)) {
>   			set_compress_context(inode);
>   			return;
>   		}
> @@ -189,7 +193,7 @@ static void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
>   	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
>   	hot_count = sbi->raw_super->hot_ext_count;
>   	for (i = 0; i < cold_count + hot_count; i++)
> -		if (is_extension_exist(name, extlist[i], true))
> +		if (is_extension_exist(name, extlist[i], true, false))
>   			break;
>   	f2fs_up_read(&sbi->sb_lock);
>   
