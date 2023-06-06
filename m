Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A377237F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjFFGn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFGnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF4C7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E493161F48
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDFCC433A4;
        Tue,  6 Jun 2023 06:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686033830;
        bh=iuTfu26glfb8E1WFTPHNw0lExwnuCUbJYgkCjPpeHcA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FDPka2ENBwIPSxTnzOoEx1HTMgEMn5YtVGOMtTaTohqpcM4Qh/uaBlq1HEHQZHY5k
         91M/IXd+qG59sNGGOXi/TgXD04zKRk2QJdX3d8Cp2fTqg4NgjC2L1Y9WQYOwBB6ZaU
         1ZruUwmdAanKJOA1jh+GPWePUT2hA5QMuO+XiAKWGMlBCSuzdndHqATN3NIqtHoFzY
         eN45H6BFFzkt7WwEcyJeqnZjYLH5uz+G8SmdZfCurjOVyaKF28a1gJFAyXBVcle7BY
         LIDIo/YQd77HCQjw5k7uRn9QTUPKc5jsSd32R2n7gkRVtVxwfQoYCpyc1kmfys4il9
         8ILd7eMDiDfTA==
Message-ID: <e8e4758f-5895-acd7-27d2-4b72b69722b3@kernel.org>
Date:   Tue, 6 Jun 2023 14:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] f2fs: enable nowait async buffered writes
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230531144006.7307-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230531144006.7307-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/31 22:40, Yangtao Li wrote:
> This adds the async buffered write support to f2fs,
> the following is the relevant test data.

Yangtao,

Could you please provide detailed test command?

Thanks,

> 
> iodepth      | 1    | 2    | 4    | 8    | 16   |
> before(M/s)  | 1012 | 1133 | 894  | 981  | 866  |
> after(M/s)   | 1488 | 1896 | 2081 | 2188 | 2207 |
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 23c68ee946e5..4faf2c04e325 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -546,7 +546,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>   	if (err)
>   		return err;
>   
> -	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
> +	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
>   
>   	return dquot_file_open(inode, filp);
>   }
> @@ -4515,9 +4515,6 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
>   	struct inode *inode = file_inode(file);
>   	ssize_t ret;
>   
> -	if (iocb->ki_flags & IOCB_NOWAIT)
> -		return -EOPNOTSUPP;
> -
>   	current->backing_dev_info = inode_to_bdi(inode);
>   	ret = generic_perform_write(iocb, from);
>   	current->backing_dev_info = NULL;
