Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED773701B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjFTPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjFTPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2CB1BD9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D86FF6109A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A98CC433C9;
        Tue, 20 Jun 2023 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687274068;
        bh=xpcefpiU++C3oDlU0Wn9zWuqnqGHuvxn4dXB9f/77gc=;
        h=Date:To:References:From:Subject:In-Reply-To:From;
        b=XVd6YKmm8EBcElAd/EJEKG/h9U6xpexYpoor74O3uNCtx2gkzActiCDE6QrDXA9J3
         5BBGVdLtf4f0OQ0dF8KgMWEW+i+a8m1NG8OyhKG85WbFr+wXK9VGNmZDzQR0rb5WSf
         xzK+BF7Fe3n9NHC6slatcOk0z1OA82vICaKfkj/lrDb6NaE8eoQYA6CJYKCXG4Din/
         z3L5pvwT44BcSTU5ld3QWFCZ5A80DeCAvpG5OTI355ctSsShPriLKz3cwkTU7ulBdQ
         R3PHLKeufyGiId8yYSKzI7EZ/32CaDSjfXU76Y7PrKQfJ/Iknn4JhJjFLP+pp/fLET
         IIU4bxmySWwXg==
Message-ID: <a1a84df4-aa7a-d684-8694-fa8489baa9c2@kernel.org>
Date:   Tue, 20 Jun 2023 23:14:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
 <ZIjqKHDUmN6u9pXa@google.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress tmp files given extension
In-Reply-To: <ZIjqKHDUmN6u9pXa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/14 6:14, Jaegeuk Kim wrote:
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
> 
>   Change log from v1:
>    - refactor to allow abc.ext.dontcare only
> 
>   fs/f2fs/namei.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 3e35eb7dbb8f..49573ef4115d 100644
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

Do you mean?

if (i == slen - sublen - 1 && s[i + 1 + sublen] == '.')

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
> +		if (is_extension_exist(name, extlist[i], false, false))

Parameters should be consistent w/ the one in set_file_temperature()?

if (is_extension_exist(name, extlist[i], true, false))

>   			break;
>   	f2fs_up_read(&sbi->sb_lock);
>   	if (i < (cold_count + hot_count))
> @@ -156,12 +160,12 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
>   
>   	/* Don't compress unallowed extension. */
>   	for (i = 0; i < noext_cnt; i++)
> -		if (is_extension_exist(name, noext[i], false))
> +		if (is_extension_exist(name, noext[i], false, false))

is_extension_exist(name, noext[i], true, true) ?

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
