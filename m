Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF4622CF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiKIN5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKIN5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:57:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAE6E75
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3B46B81EC7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E90C433D6;
        Wed,  9 Nov 2022 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668002238;
        bh=KwiACjdLcyiVh0MCd9x3j5YHdUGXO2t1t0ygrXm++pQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Su/0js4mWkYiSBI3zBkPjObgkTe8AM/FtMrjYu5uUz7/CuGARYpr3Eii5kXoLwq3W
         msY3jA6qdEmApuDYlCmSqoSVGZQPN5M3qvQkpfT3nxk2YZMJSWfepL1mnefuCpyyYu
         GzfyaymP584WCPfw+il41zQYy4zsLzNyfsWIY6ohHqd88xxIrIXdlmBJ70H454Kmhp
         aJFAx3lruoUJ7rphtiI9na5HxTHDq+WIyAGHsb2o2ZGkkSKOV1InZeQWGOgXftY23V
         70FeoFf70YdPH2ToWx9RXJIHs8COQj9lSuQsB/3V0rMtQ+CJAFpLYduLTca/aEmnzM
         c5WCqhs5fhyng==
Message-ID: <2a474126-ae64-ac31-9ba4-8d6b68f31bd6@kernel.org>
Date:   Wed, 9 Nov 2022 21:57:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: fix to enable compress for newly created file if
 extension matches
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221109110148.3674340-1-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221109110148.3674340-1-shengyong@oppo.com>
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

On 2022/11/9 19:01, Sheng Yong wrote:
> If compress_extension is set, and a newly created file matches the
> extension, the file could be marked as compression file. However,
> if inline_data is also enabled, there is no chance to check its
> extension since f2fs_should_compress() always returns false.
> 
> So if a new file is created (its inode has I_NEW flag and must have
> no pin/atomic/swap flag), instead of calling f2fs_should_compress(),
> checking its file type is enough here.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>   fs/f2fs/namei.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index e104409c3a0e5..99dbd051ae0ba 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -295,9 +295,14 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
> 
>          if (!f2fs_sb_has_compression(sbi) ||
>                          F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
> -                       !f2fs_may_compress(inode) ||
>                          (!ext_cnt && !noext_cnt))
>                  return;
> +       if (inode->i_state & I_NEW) {
> +               if (!S_ISREG(inode->i_mode))
> +                       return;
> +       } else if (!f2fs_may_compress(inode)) {
> +               return;
> +       }

How about moving set_compress_inode() into f2fs_new_inode()?

	if (f2fs_sb_has_compression(sbi)) {
		/* Inherit the compression flag in directory */
		if ((F2FS_I(dir)->i_flags & F2FS_COMPR_FL) &&
					f2fs_may_compress(inode))
			set_compress_context(inode);

		set_compress_inode(sbi, inode, name);
	}

	/* Should enable inline_data after compression set */
	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
		set_inode_flag(inode, FI_INLINE_DATA);

> 
>          f2fs_down_read(&sbi->sb_lock);
> 
> --
> 2.25.1
