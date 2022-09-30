Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8CE5F0F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiI3P4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiI3P4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:56:19 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1F3E0079
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:56:17 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A0BF61D0C;
        Fri, 30 Sep 2022 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1664553240;
        bh=zk1fzejNWhXf8dklKo6mhDoZBtMvpGqc/KyM+XvcHzc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Er4HbEcRn3G0OpR5ZgkIsAGmqb10tHuOJTYZHGRuEnQ95PuIO/0Nn+8hIRKrYhA3L
         YZsCeqYKceZHAhfExMtOyARP/zNUJTKMLyVJX8BobH9SvG2ksJgGhsKli+ngzQr2Vm
         xkMq/g6nr9C4Y186g+ZKzRAkQ5h1DBGbMHZK+wDw=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Sep 2022 18:56:15 +0300
Message-ID: <02ef1f71-93da-4a16-f781-0337e87d38a0@paragon-software.com>
Date:   Fri, 30 Sep 2022 18:56:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ntfs3: fix junction point resolution
Content-Language: en-US
To:     Daniel Pinto <danielpinto52@gmail.com>, <ntfs3@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
CC:     "Artem S. Tashkinov" <aros@gmx.com>
References: <7839ac04-f93c-a897-70eb-2505d72f936c@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <7839ac04-f93c-a897-70eb-2505d72f936c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/22 04:45, Daniel Pinto wrote:
> The ntfs3 file system driver does not convert the target path of
> junction points to a proper Linux path. As junction points targets
> are always absolute paths (they start with a drive letter), all
> junctions will result in broken links.
> 
> Translate the targets of junction points to relative paths so they
> point to directories inside the mounted volume. Note that Windows
> allows junction points to reference directories in another drive.
> However, as there is no way to know which drive the junctions refer
> to, we assume they always target the same file system they are in.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214833
> Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
> ---
>   fs/ntfs3/inode.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 51363d4e8636..f7e8876f56d3 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1749,7 +1749,101 @@ void ntfs_evict_inode(struct inode *inode)
>   	ni_clear(ntfs_i(inode));
>   }
>   
> -static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
> +/*
> + * ntfs_translate_junction
> + *
> + * Translate a Windows junction target to the Linux equivalent.
> + * On junctions, targets are always absolute (they include the drive
> + * letter). We have no way of knowing if the target is for the current
> + * mounted device or not so we just assume it is.
> + */
> +static int ntfs_translate_junction(const struct super_block *sb,
> +				   const struct dentry *link_de, char *target,
> +				   int target_len, int target_max)
> +{
> +	int tl_len, err = target_len;
> +	char *link_path_buffer = NULL, *link_path;
> +	char *translated = NULL;
> +	char *target_start;
> +	int copy_len;
> +
> +	link_path_buffer = kmalloc(PATH_MAX, GFP_NOFS);
> +	if (!link_path_buffer) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	/* Get link path, relative to mount point */
> +	link_path = dentry_path_raw(link_de, link_path_buffer, PATH_MAX);
> +	if (IS_ERR(link_path)) {
> +		ntfs_err(sb, "Error getting link path");
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	translated = kmalloc(PATH_MAX, GFP_NOFS);
> +	if (!translated) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Make translated path a relative path to mount point */
> +	strcpy(translated, "./");
> +	++link_path;	/* Skip leading / */
> +	for (tl_len = sizeof("./") - 1; *link_path; ++link_path) {
> +		if (*link_path == '/') {
> +			if (PATH_MAX - tl_len < sizeof("../")) {
> +				ntfs_err(sb, "Link path %s has too many components",
> +					 link_path);
> +				err = -EINVAL;
> +				goto out;
> +			}
> +			strcpy(translated + tl_len, "../");
> +			tl_len += sizeof("../") - 1;
> +		}
> +	}
> +
> +	/* Skip drive letter */
> +	target_start = target;
> +	while (*target_start && *target_start != ':')
> +		++target_start;
> +
> +	if (!*target_start) {
> +		ntfs_err(sb, "Link target (%s) missing drive separator", target);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Skip drive separator and leading /, if exists */
> +	target_start += 1 + (target_start[1] == '/');
> +	copy_len = target_len - (target_start - target);
> +
> +	if (PATH_MAX - tl_len <= copy_len) {
> +		ntfs_err(sb, "Link target %s too large for buffer (%d <= %d)",
> +			 target_start, PATH_MAX - tl_len, copy_len);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* translated path has a trailing / and target_start does not */
> +	strcpy(translated + tl_len, target_start);
> +	tl_len += copy_len;
> +	if (target_max <= tl_len) {
> +		ntfs_err(sb, "Target path %s too large for buffer (%d <= %d)",
> +			 translated, target_max, tl_len);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +	strcpy(target, translated);
> +	err = tl_len;
> +
> +out:
> +	kfree(link_path_buffer);
> +	kfree(translated);
> +	return err;
> +}
> +
> +static noinline int ntfs_readlink_hlp(const struct dentry *link_de,
> +				      struct inode *inode, char *buffer,
>   				      int buflen)
>   {
>   	int i, err = -EINVAL;
> @@ -1892,6 +1986,11 @@ static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
>   
>   	/* Always set last zero. */
>   	buffer[err] = 0;
> +
> +	/* If this is a junction, translate the link target. */
> +	if (rp->ReparseTag == IO_REPARSE_TAG_MOUNT_POINT)
> +		err = ntfs_translate_junction(sb, link_de, buffer, err, buflen);
> +
>   out:
>   	kfree(to_free);
>   	return err;
> @@ -1910,7 +2009,7 @@ static const char *ntfs_get_link(struct dentry *de, struct inode *inode,
>   	if (!ret)
>   		return ERR_PTR(-ENOMEM);
>   
> -	err = ntfs_readlink_hlp(inode, ret, PAGE_SIZE);
> +	err = ntfs_readlink_hlp(de, inode, ret, PAGE_SIZE);
>   	if (err < 0) {
>   		kfree(ret);
>   		return ERR_PTR(err);
> 

Thank you for your work, applied!
