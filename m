Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD3D6563AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiLZPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLZPGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:06:36 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F673BD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:06:35 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E11FB1B7;
        Mon, 26 Dec 2022 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672066984;
        bh=+5+I8kVMAe1PJhM2RZzmZvx8+Iypae6sw+evuRRq3u0=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=BZX5JpKXTLFY6a7dypydZsdTyFrbQUuLzZljeUCMvbiQ3qlaijw+Yb8IYGMEbHB/G
         4531GgNva3XLzWa+1oNFeNwQ4k05OHsnyfq0eXDiWSsoPE0yivCbL2nqAXeL5t48/k
         FxvtAhZWw3vKrS2b2aPIME9bBg/RS+gcq7taKhss=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 37EE120F5;
        Mon, 26 Dec 2022 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672067193;
        bh=+5+I8kVMAe1PJhM2RZzmZvx8+Iypae6sw+evuRRq3u0=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=WCR/hfWKLkqSM8hgIQOtiYKYGnmpnM6hepTGRIUq5M3R3CoRqSqOwd41mg4HsZAci
         btahqt/R6baVNpYwxl+4S4Q3P54fhUIsLE4qwsf32GkPgQVGsQYnVFEm2R8fUKf3eU
         H0Mvv1vqLIJloSS88l8wDa7PFoikWtxxFrzedeYk=
Received: from [192.168.211.153] (192.168.211.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Dec 2022 18:06:32 +0300
Message-ID: <0e35ae5d-d2ba-dcba-2e37-61191b839eea@paragon-software.com>
Date:   Mon, 26 Dec 2022 19:06:31 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ntfs3: Fix memory leak if ntfs_read_mft failed
Content-Language: en-US
To:     Chen Zhongjin <chenzhongjin@huawei.com>, <ntfs3@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20221122092414.231084-1-chenzhongjin@huawei.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221122092414.231084-1-chenzhongjin@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.153]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2022 13:24, Chen Zhongjin wrote:
> Label ATTR_ROOT in ntfs_read_mft() sets is_root = true and
> ni->ni_flags |= NI_FLAG_DIR, then next attr will goto label ATTR_ALLOC
> and alloc ni->dir.alloc_run. However two states are not always
> consistent and can make memory leak.
>
>   1) attr_name in ATTR_ROOT does not fit the condition it will set
>   is_root = true but NI_FLAG_DIR is not set.
>   2) next attr_name in ATTR_ALLOC fits the condition and alloc
>   ni->dir.alloc_run
>   3) in cleanup function ni_clear(), when NI_FLAG_DIR is set, it frees
>   ni->dir.alloc_run, otherwise it frees ni->file.run
>   4) because NI_FLAG_DIR is not set in this case, ni->dir.alloc_run is
>   leaked as kmemleak reported:
>
> unreferenced object 0xffff888003bc5480 (size 64):
>    backtrace:
>      [<000000003d42e6b0>] __kmalloc_node+0x4e/0x1c0
>      [<00000000d8e19b8a>] kvmalloc_node+0x39/0x1f0
>      [<00000000fc3eb5b8>] run_add_entry+0x18a/0xa40 [ntfs3]
>      [<0000000011c9f978>] run_unpack+0x75d/0x8e0 [ntfs3]
>      [<00000000e7cf1819>] run_unpack_ex+0xbc/0x500 [ntfs3]
>      [<00000000bbf0a43d>] ntfs_iget5+0xb25/0x2dd0 [ntfs3]
>      [<00000000a6e50693>] ntfs_fill_super+0x218d/0x3580 [ntfs3]
>      [<00000000b9170608>] get_tree_bdev+0x3fb/0x710
>      [<000000004833798a>] vfs_get_tree+0x8e/0x280
>      [<000000006e20b8e6>] path_mount+0xf3c/0x1930
>      [<000000007bf15a5f>] do_mount+0xf3/0x110
>      ...
>
> Fix this by always setting is_root and NI_FLAG_DIR together.
>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>   fs/ntfs3/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index d5a3afbbbfd8..b7f60624b044 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -247,7 +247,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>   			goto out;
>   
>   		root = Add2Ptr(attr, roff);
> -		is_root = true;
>   
>   		if (attr->name_len != ARRAY_SIZE(I30_NAME) ||
>   		    memcmp(attr_name(attr), I30_NAME, sizeof(I30_NAME)))
> @@ -260,6 +259,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>   		if (!is_dir)
>   			goto next_attr;
>   
> +		is_root = true;
>   		ni->ni_flags |= NI_FLAG_DIR;
>   
>   		err = indx_init(&ni->dir, sbi, attr, INDEX_MUTEX_I30);
Thanks for patch, applied!
