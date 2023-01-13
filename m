Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE36693A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjAMKGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjAMKGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:06:01 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFEF1BEA8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:05:59 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5C7601D37;
        Fri, 13 Jan 2023 10:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1673604133;
        bh=Y9eT1AQ2nLSPlGy+01IEzMKkV5ZBkCn+StmV6WQ5bJs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HATPBCey0/6YxPidpPlhO/bFDFl7FuKwFf92FGuRCXyqf+MSI+9Zx1T5ilAsFacn1
         K0yuiCcXLyxLOayR2lXITszLscStJdZavqcgFpBUG7Z0JY/x/4fIs1dyP04ZU0ncGq
         dz+QCo2qC8ccBh4qraOIKo4cKjSJVl2JcH6mcPQ8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E11751FE3;
        Fri, 13 Jan 2023 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1673604357;
        bh=Y9eT1AQ2nLSPlGy+01IEzMKkV5ZBkCn+StmV6WQ5bJs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=K+qGQ9fT1B4bvGHxpbmUNCi6w++3rIjzcg6iJu1+SgpWk62n/xVgvUJ9ycabhEgQn
         /jA4W7WkaLNJ25SYrWcOXdGhwxT1pQNPborz1cGw6lFvbfyAL8BY9sHoPRbTy5+346
         nLo2A0VW010U5rXluQfCxcxdypd3rj9EbWqzwt+M=
Received: from [192.168.211.54] (192.168.211.54) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 13 Jan 2023 13:05:57 +0300
Message-ID: <808288ae-bf1a-ccc6-ab37-d1b2022b44b5@paragon-software.com>
Date:   Fri, 13 Jan 2023 14:05:56 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH -next] fs/ntfs3: Fix potential NULL/IS_ERR bug in
 ntfs_lookup()
Content-Language: en-US
To:     Peng Zhang <zhangpeng362@huawei.com>, <kari.argillander@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230112013248.2464556-1-zhangpeng362@huawei.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20230112013248.2464556-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.54]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.2023 05:32, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Dan Carpenter reported a Smatch static checker warning:
>
> fs/ntfs3/namei.c:96 ntfs_lookup()
> error: potential NULL/IS_ERR bug 'inode'
> It will cause null-ptr-deref when dir_search_u() returns NULL if the
> file is not found.
> Fix this by replacing IS_ERR() with IS_ERR_OR_NULL() to add a check for
> NULL.
>
> Fixes: fb6b59b5a2d6 ("fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   fs/ntfs3/namei.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index 3db34d5c03dc..f23c2c26dd08 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -93,7 +93,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
>   	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
>   	 * This causes null pointer dereference in d_splice_alias().
>   	 */
> -	if (!IS_ERR(inode) && inode->i_op == NULL) {
> +	if (!IS_ERR_OR_NULL(inode) && inode->i_op == NULL) {
>   		iput(inode);
>   		inode = ERR_PTR(-EINVAL);
>   	}

Hello.

We have added a patch with this check just before the New Year. (here 
https://lore.kernel.org/lkml/ee705b24-865b-26ff-157d-4cb2a303a962@paragon-software.com/)

Thank you for your attention!

