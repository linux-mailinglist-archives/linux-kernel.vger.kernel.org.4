Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD7705CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjEQB6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjEQB6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5B40C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC06E63F1E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C58C433EF;
        Wed, 17 May 2023 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684288686;
        bh=iZPh21wWGEBlWp0JhELY/nnSc0qMTktgaIMhNOa939Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lccZN5Z72cMdKzTCsD8HEpTEg348OV+fYQvFpY+yBaJW9dd0IRieqEZXcaK5E9hV4
         NNzHD2l+2ZuMwY1ibFhGmgv07BeKp+LSZrGZmcGIiUt/kaGa0mdjYMWv/syN8MWvXI
         ioYoGte6fx/AJhwCFQeJfH/PketNR2dOxJdG/wcWZhJj3cMjP1lgZIN/BcvH+GSm3i
         N9sGY8fyiJFB5kW7IknjlGsVJMDe4PqKJmEGZFbbyp9P1V+YSS1DvM2aZZXJ+uMwNv
         BLiLEi6UsikOXuPwCjL8r6lBX+PEt+E5Uhjuxt03FWkZCpRSj0FPKHM7yvgXFe4oad
         508O7ZlYAhhgw==
Message-ID: <2c8e3028-ea3c-d751-1ee6-74b1aca14992@kernel.org>
Date:   Wed, 17 May 2023 09:58:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] f2fs: move the conditional statement after holding
 the inode lock in f2fs_move_file_range()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20230506144257.9611-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230506144257.9611-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/6 22:42, Yangtao Li wrote:
> For judging the inode flag state, the inode lock must be held.
> BTW, add compressd file check and to avoid 'if' nesting.

Please describe what's the detail problem if we check the flag w/o inode
lock.

Can we use one single patch to fix all similar issues?

Thanks,

> 
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -add unlock
>   fs/f2fs/file.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 78aa8cff4b41..42a9b683118c 100644
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
> @@ -2804,10 +2801,19 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	}
>   
>   	inode_lock(src);
> -	if (src != dst) {
> +	if (src != dst && !inode_trylock(dst)) {
>   		ret = -EBUSY;
> -		if (!inode_trylock(dst))
> -			goto out;
> +		goto out;
> +	}
> +
> +	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
> +	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
>   	}
>   
>   	ret = -EINVAL;
