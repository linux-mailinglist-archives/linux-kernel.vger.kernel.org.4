Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABB6FB08E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjEHMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjEHMr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:47:26 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9313655C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:47:24 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6AABA21BF;
        Mon,  8 May 2023 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549755;
        bh=+RIZwKheUQEVK7fCvngM0V+Ns6xXNCmYVIblbPmQT/8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Y79BRSN/xl3DUV6ZASNvDqiyVQwl2/rrup9RX8XyoGQZ6/6EJk7FzvADmIEgq9KH1
         Lv/2IxLN9s9IUa+APrwkgpuK0bnRDXniEfqg0AH1q3PM2MgEaOWxabC1l4nL4zJSD3
         3ufeANTBHpMAhRhJhDNJqskyQqf60fWaL0OYeDhA=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:47:21 +0300
Message-ID: <93d571a1-ca88-4824-01db-3b16973627e0@paragon-software.com>
Date:   Mon, 8 May 2023 16:47:21 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] fs: ntfs3: Fix a possible null-pointer dereference in
 ni_clear()
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230111085943.1127-1-baijiaju1990@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20230111085943.1127-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous commit c1006bd13146, ni->mi.mrec in ni_write_inode()
> could be NULL, and thus a NULL check is added for this variable.
>
> However, in the same call stack, ni->mi.mrec can be also dereferenced
> in ni_clear():
>
> ntfs_evict_inode(inode)
>    ni_write_inode(inode, ...)
>      ni = ntfs_i(inode);
>      is_rec_inuse(ni->mi.mrec) -> Add a NULL check by previous commit
>    ni_clear(ntfs_i(inode))
>      is_rec_inuse(ni->mi.mrec) -> No check
>
> Thus, a possible null-pointer dereference may exist in ni_clear().
> To fix it, a NULL check is added in this function.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> ---
>   fs/ntfs3/frecord.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index f1df52dfab74..046ec4179d75 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -102,7 +102,7 @@ void ni_clear(struct ntfs_inode *ni)
>   {
>   	struct rb_node *node;
>   
> -	if (!ni->vfs_inode.i_nlink && is_rec_inuse(ni->mi.mrec))
> +	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
>   		ni_delete_all(ni);
>   
>   	al_destroy(ni);

I apologize for the delayed response.

Thank you for your work, applied!

