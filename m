Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732376ACFAA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCFU7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCFU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:59:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136C37F15
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:59:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DBD06066C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3DDC433EF;
        Mon,  6 Mar 2023 20:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678136350;
        bh=Td2oETyX1QBxClU/naoSicJ6WFgZEGEe5e4OXOkJa10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbfJXqEPx/kpIEhWjonlmITYb/haomjFE6k8TxtuCLtxpHuYSVm9rtmsfrFveQ3Of
         s3qNohojGY6eFs2ZuIsrZwT0UHoNUO3O6ytTPE5ymsYzd3UXFLLfjKAGCOU7yM7/yJ
         bERG1Zts6+DzHZvn9Ax/UVLYaJDwpx5wsWAoSMla7O6pqOzezxpSlwCiY7DLRQbPGu
         m6ipR94qiXqEOc7kYPlhDf144F0kBKEDof9A75AkdSQHV+FpAeWXo2qWT1av7pJGRk
         ygsub/WfCb+SwGI1/MEdBDc+dnZvM4UEMMDpKhGiDhiB0PdaQdgnseOZs32OXxmQvn
         jH2RBXvPz1mmg==
Date:   Mon, 6 Mar 2023 12:59:09 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to check quota inums
Message-ID: <ZAZUHQz1GIpPG4jf@google.com>
References: <20230223073222.81702-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223073222.81702-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23, Yangtao Li wrote:
> We should check quota file ino before enable quota, and not only 0.
> 
> BTW fix following check error:
> 
> WARNING: Do not crash the kernel unless it is absolutely
> unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible)
> instead of BUG() or variants.
> 
> Fixes: ea6767337f86 ("f2fs: support quota sys files")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 54 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index aa55dc12aff2..c7e0639892e2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2652,22 +2652,40 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly)
>  	return enabled;
>  }
>  
> +static inline bool f2fs_check_quota_inum(int type, unsigned long qf_inum)
> +{
> +	switch (type) {
> +	case USRQUOTA:
> +		return qf_inum == 4;
> +	case GRPQUOTA:
> +		return qf_inum == 5;
> +	case PRJQUOTA:
> +		return qf_inum == 6;

I don't want to make this dependency of the inode numbers.

> +	default:
> +		return false;
> +	}
> +}
> +
>  static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
>  			     unsigned int flags)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	struct inode *qf_inode;
>  	unsigned long qf_inum;
>  	int err;
>  
> -	BUG_ON(!f2fs_sb_has_quota_ino(F2FS_SB(sb)));
> +	f2fs_bug_on(sbi, !f2fs_sb_has_quota_ino(sbi));
>  
>  	qf_inum = f2fs_qf_ino(sb, type);
> -	if (!qf_inum)
> -		return -EPERM;
> +	if (!f2fs_check_quota_inum(type, qf_inum)) {
> +		f2fs_err(sbi, "Bad quota inum: %lu, type: %d",
> +				qf_inum, type);
> +		return -EFSCORRUPTED;
> +	}
>  
>  	qf_inode = f2fs_iget(sb, qf_inum);
>  	if (IS_ERR(qf_inode)) {
> -		f2fs_err(F2FS_SB(sb), "Bad quota inode %u:%lu", type, qf_inum);
> +		f2fs_err(sbi, "Bad quota inode %u:%lu", type, qf_inum);
>  		return PTR_ERR(qf_inode);
>  	}
>  
> @@ -2682,7 +2700,7 @@ static int f2fs_enable_quotas(struct super_block *sb)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	int type, err = 0;
> -	unsigned long qf_inum;
> +	char count = MAXQUOTAS;
>  	bool quota_mopt[MAXQUOTAS] = {
>  		test_opt(sbi, USRQUOTA),
>  		test_opt(sbi, GRPQUOTA),
> @@ -2696,21 +2714,21 @@ static int f2fs_enable_quotas(struct super_block *sb)
>  
>  	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE;
>  
> -	for (type = 0; type < MAXQUOTAS; type++) {
> -		qf_inum = f2fs_qf_ino(sb, type);
> -		if (qf_inum) {
> -			err = f2fs_quota_enable(sb, type, QFMT_VFS_V1,
> +	if (!f2fs_sb_has_project_quota(sbi))
> +		count--;
> +
> +	for (type = 0; type < count; type++) {
> +		err = f2fs_quota_enable(sb, type, QFMT_VFS_V1,
>  				DQUOT_USAGE_ENABLED |
>  				(quota_mopt[type] ? DQUOT_LIMITS_ENABLED : 0));
> -			if (err) {
> -				f2fs_err(sbi, "Failed to enable quota tracking (type=%d, err=%d). Please run fsck to fix.",
> -					 type, err);
> -				for (type--; type >= 0; type--)
> -					dquot_quota_off(sb, type);
> -				set_sbi_flag(F2FS_SB(sb),
> -						SBI_QUOTA_NEED_REPAIR);
> -				return err;
> -			}
> +		if (err) {
> +			f2fs_err(sbi, "Failed to enable quota tracking (type=%d, err=%d). Please run fsck to fix.",
> +				 type, err);
> +			for (type--; type >= 0; type--)
> +				dquot_quota_off(sb, type);
> +			set_sbi_flag(F2FS_SB(sb),
> +					SBI_QUOTA_NEED_REPAIR);
> +			return err;
>  		}
>  	}
>  	return 0;
> -- 
> 2.25.1
