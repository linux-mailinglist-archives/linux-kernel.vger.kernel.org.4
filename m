Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373566C6B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCWOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjCWOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:42:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8E82311F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E052B82142
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64B3C433A1;
        Thu, 23 Mar 2023 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679582515;
        bh=Vlg7H3iswuM5SaVZgxQDjdnUoBhjPiMEv9IlvCOSVCs=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=moaZguZ/J3waAJf4kCmha0ZzZ93nG9vf/r6CkBqy/vkc696vUfAOvgqBzW40wPeJl
         3q13nAaqKIiFJrZImZiTgn660O42ZCsl9rvyJ2/5Q63b6g3nZKLvXlyJRD35DmqXrc
         RmFMPoK61a3C4RAAXdYL7Gd1dvB9ECwxmP1nyQPB9APmuKI7905/sJi8vYqXVFaVFU
         6nKWYMmOfequny+COOzLUC6YVIUyQoRAKPUo3unRhUxV2fh81F6nO6+/4UjT2uvXDW
         MPzKkJvqQdPUYpI1Sh+b0B+AQuVWns4w+E9bOWxbREBbXMSlspK66uZnqqZJfZDbNb
         cSVmxBZOQ/KGw==
Message-ID: <0f1704e5-4a4f-d920-9c69-e01ed2f0dde5@kernel.org>
Date:   Thu, 23 Mar 2023 22:41:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Wang Shilong <wangshilong1991@gmail.com>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org
References: <20230221144550.46557-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: handle dqget error in f2fs_transfer_project_quota()
In-Reply-To: <20230221144550.46557-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Shilong,

Hi, Shilong,

Could you please help to check this patch? in original patch, it tries to
ignore such error intentionally? or it is a bug?

On 2023/2/21 22:45, Yangtao Li wrote:
> We should set the error code when dqget() failed.
> 
> Fixes: 2c1d03056991 ("f2fs: support F2FS_IOC_FS{GET,SET}XATTR")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ca1720fc1187..f25e58680984 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3009,15 +3009,16 @@ int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
>   	struct dquot *transfer_to[MAXQUOTAS] = {};
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct super_block *sb = sbi->sb;
> -	int err = 0;
> +	int err;
>   
>   	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
> -	if (!IS_ERR(transfer_to[PRJQUOTA])) {
> -		err = __dquot_transfer(inode, transfer_to);
> -		if (err)
> -			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> -		dqput(transfer_to[PRJQUOTA]);
> -	}
> +	if (IS_ERR(transfer_to[PRJQUOTA]))
> +		return PTR_ERR(transfer_to[PRJQUOTA]);
> +
> +	err = __dquot_transfer(inode, transfer_to);
> +	if (err)
> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> +	dqput(transfer_to[PRJQUOTA]);
>   	return err;
>   }
>   
