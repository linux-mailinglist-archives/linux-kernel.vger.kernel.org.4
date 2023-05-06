Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7B6F9276
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjEFORi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:17:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACB1992E
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 07:17:35 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vIj6pu3sYpwRIvIj6pSGog; Sat, 06 May 2023 16:17:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683382654;
        bh=9YVwjWo5/vDdysTKQ2ElKQ8F4j2GH4XEIOM2THe87YU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Zm5kU3ok+O8Rx6LXy5OXsz5nPyFjuTjcuALaOEsZl2uuXu8QgnNTrkWmTWnvQtDqt
         Tewts/IjOl3WJ+bYase2oGW3dOvGEjEZOldfelWH8Q4npMjd61gOFEWq6UgbWHeQX7
         zURhUvSVLhm2U47kP5udiqE+n2SgU5XF5Zj2vNtisF0huNXXCYCC/ozMSvUJJ94tkf
         lkrQAh1x44hEBlN0DG0eoMxn5x3QuEP6hzQRONZQtiyCCy7BSc2mHFRIy8JwYPWkPI
         ZX3sHNfEDDJtYxNg5vrYKCYMPW/KflB8Sie7LkT/+iOuS+UFt0Y+TG5MOOdcLv83r6
         YYsJoDR8Lja3A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 16:17:34 +0200
X-ME-IP: 86.243.2.178
Message-ID: <7ab5fb52-8d5b-4de5-78d7-da32254d8d25@wanadoo.fr>
Date:   Sat, 6 May 2023 16:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] f2fs: move the conditional statement after holding
 the inode lock in f2fs_fallocate()
Content-Language: fr, en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230506114033.23908-1-frank.li@vivo.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230506114033.23908-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/05/2023 à 13:40, Yangtao Li a écrit :
> For judging the inode flag state, the inode lock must be held.
> 
> Fixes: fcc85a4d86b5 ("f2fs crypto: activate encryption support for fs APIs")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 850e745ecf88..0837c500b990 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1801,6 +1801,13 @@ static long f2fs_fallocate(struct file *file, int mode,
>   	if (!S_ISREG(inode->i_mode))
>   		return -EINVAL;
>   
> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> +			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
> +			FALLOC_FL_INSERT_RANGE))
> +		return -EOPNOTSUPP;
> +
> +	inode_lock(inode);
> +
>   	if (IS_ENCRYPTED(inode) &&
>   		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
>   		return -EOPNOTSUPP;

ret = -EOPNOTSUPP;
goto out;

here and in some other places below.

Maybe the code should de rearranged another way if 
trace_f2fs_fallocate() should not be called in such cases.

CJ

> @@ -1814,13 +1821,6 @@ static long f2fs_fallocate(struct file *file, int mode,
>   			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
>   		return -EOPNOTSUPP;
>   
> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> -			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
> -			FALLOC_FL_INSERT_RANGE))
> -		return -EOPNOTSUPP;
> -
> -	inode_lock(inode);
> -
>   	ret = file_modified(file);
>   	if (ret)
>   		goto out;

