Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBD46F9273
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjEFON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:13:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE11AEED
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 07:13:25 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vIf5pACTtunMHvIf6p93Sx; Sat, 06 May 2023 16:13:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683382404;
        bh=TBdQEF81l2nq+2j3jCyjruKKwsIfsnL8xmxfoM/hWZw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pcQOv4YU7ViB9jbXJSOhZQodkzuBNeNoudsrx1aUwzWMxwYs9ShCZwlZxnUCtx0Rl
         958YQ/zX/N2CrXt5L4pLAxI/QjacFEoeoQcNzfWO0cbFbFv3eohDegbGTkHo6RNIOU
         eO8+bn8qS5ehwXBu4l9sZns0hoSxySL9xzeQxoipfxlFs/chr8kN+4UQl2wy3cnPMu
         g8gDXEUBjEcRCwLoZsOm9AuKnclEFmT69jzgDssdSp9reKCW5GjoQyiCjA9JWYt3XJ
         yM+3WxwSCq9qoLkrbV/HVnhnpKKfwTi+gtYyuAlH3CsTEhUU+SxRZvpHc4GNrUzpEQ
         ScyvtCGt7JOeQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 16:13:24 +0200
X-ME-IP: 86.243.2.178
Message-ID: <d0da5b97-682d-9fef-3fb0-1381ead79667@wanadoo.fr>
Date:   Sat, 6 May 2023 16:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] f2fs: move the conditional statement after holding
 the inode lock in f2fs_move_file_range()
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230506113914.23419-1-frank.li@vivo.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230506113914.23419-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/05/2023 à 13:39, Yangtao Li a écrit :
> For judging the inode flag state, the inode lock must be held.
> BTW, add compressd file check and to avoid 'if' nesting.
> 
> Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 78aa8cff4b41..850e745ecf88 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2790,9 +2790,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	if (!S_ISREG(src->i_mode) || !S_ISREG(dst->i_mode))
>   		return -EINVAL;
>   
> -	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst))
> -		return -EOPNOTSUPP;
> -
>   	if (pos_out < 0 || pos_in < 0)
>   		return -EINVAL;
>   
> @@ -2804,12 +2801,17 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	}
>   
>   	inode_lock(src);
> -	if (src != dst) {
> +	if (src != dst && !inode_trylock(dst)) {
>   		ret = -EBUSY;
> -		if (!inode_trylock(dst))
> -			goto out;
> +		goto out;
>   	}
>   
> +	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst))
> +		return -EOPNOTSUPP;

ret = -EOPNOTSUPP;
goto out_unlock;

?

> +
> +	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst))
> +		return -EOPNOTSUPP;

Same

CJ

> +
>   	ret = -EINVAL;
>   	if (pos_in + len > src->i_size || pos_in + len < pos_in)
>   		goto out_unlock;

