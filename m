Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DADF738570
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjFUNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjFUNj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C298419AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5127B614E9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF29C433C0;
        Wed, 21 Jun 2023 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687354764;
        bh=cPsPjRKWcEmtzMQaG/waG+l05hgrMv31+72e1daYl9M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=elAsHbJhVVL5byp6B61wcncTPmAifiqJYTATP71ljhJRJ772RaHrY/aysK1dWm1eQ
         wbWXf+Eg2zV58tzr5jHEQ/fNPLZFpmzc0Jn1JBj+HsB5bKArHRvvNhunaVGk50PE+1
         LSftbspqLEjjDpd2Suh3Lk3NFPWCOsZ/AMpkX/XaMH4MSdKNP4gKjPD78YNra37bPs
         VEWIxAWCXkHd62mLIDsfHqMCoIpHTK71SYQqdi09kfmD4RLLqLsbNFrl6tq6YV9f0u
         0swlglT7SRAtanxh51wMrFomm0mg1BdKefK+lJgKkWzmpUkkMkHoeu/UySWfouu2WE
         mN42R3oh6jZvg==
Message-ID: <9f3a5518-1de5-17b9-5aec-9820fe79c223@kernel.org>
Date:   Wed, 21 Jun 2023 21:39:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev][PATCH 1/2 v2] f2fs: update mtime and ctime in move
 file range method
To:     Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230621094359.3827832-1-heyunlei@oppo.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230621094359.3827832-1-heyunlei@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/21 17:43, Yunlei He wrote:
> Mtime and ctime stay old value without update after move
> file range ioctl. This patch add time update.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>
> ---
> v2:
> -update both src and dst inode
>   fs/f2fs/file.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index cb42d8464ad9..4adcf62e2665 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2884,8 +2884,22 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   
>   	if (src != dst)
>   		f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
> +

Unneeded blank line.

>   out_src:
>   	f2fs_up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
> +
> +	if (!ret) {
> +		src->i_mtime = src->i_ctime = current_time(src);
> +		f2fs_mark_inode_dirty_sync(src, false);
> +
> +		if (src != dst) {
> +			dst->i_mtime = dst->i_ctime = current_time(dst);
> +			f2fs_mark_inode_dirty_sync(dst, false);
> +		}
> +
> +		f2fs_update_time(F2FS_I_SB(src), REQ_TIME);

f2fs_update_time(sbi, REQ_TIME);

Thanks,

> +	}
> +
>   out_unlock:
>   	if (src != dst)
>   		inode_unlock(dst);
