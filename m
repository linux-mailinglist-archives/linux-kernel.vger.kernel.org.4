Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A1B6491DA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLKCXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLKCX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:23:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C00BC8E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:23:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C89260CF7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7571C433D2;
        Sun, 11 Dec 2022 02:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670725407;
        bh=k2fYp/k7d+wmxlOxjITMs8j1x3fl0GhBglBHCVYpTto=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fy1mPeKnj9Nf4VEcOIDW5boRfcXHhYS6bZhtBt7YrfHBWsSvlxb9UZVbCsQs3+9jR
         hT1OprozoTBAHdagvuGEUvgxus6WIClml96UHFTIJZ1Tlhn7UnZsYU8SE/SHRYgUYF
         st3c3FTfJYtxXDw1El6G/XGY4wEhl9EtT071nvIvrCh3Ec5ehfIcRljudqf2bGyvKY
         fXxznrQ2nLSNnMzDMmstqTJKcpITjMq3aIHvzBKR+4eMlOx9wZgW8b8yennnu72RmU
         0JUHBZt3tAydnmqjNNbOBVJcMIBeACagVga53ReHR7mLFPLIOLQTQL7T+9DUfi3A1l
         71rNvfZZfS5KA==
Message-ID: <38ab73c5-4865-188f-9554-6bcaec7cc78b@kernel.org>
Date:   Sun, 11 Dec 2022 10:23:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] f2fs: fix iostat parameter for discard
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221205145603.70779-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221205145603.70779-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/5 22:56, Yangtao Li wrote:
> Just like other data we count uses the number of bytes as the basic unit,
> but discard uses the number of cmds as the statistical unit. In fact the
> discard command contains the number of blocks, so let's change to the
> number of bytes as the base unit.
> 
> Fixes: b0af6d491a6b ("f2fs: add app/fs io stat")
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9486ca49ecb1..bc262e17b279 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1181,7 +1181,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   
>   		atomic_inc(&dcc->issued_discard);
>   
> -		f2fs_update_iostat(sbi, NULL, FS_DISCARD, 1);
> +		f2fs_update_iostat(sbi, NULL, FS_DISCARD, len * F2FS_BLKSIZE);

In order to avoid breaking its usage of application, how about keeping
FS_DISCARD as it is, and add FS_DISCARD_IO to account discard bytes?

Thanks,

>   
>   		lstart += len;
>   		start += len;
