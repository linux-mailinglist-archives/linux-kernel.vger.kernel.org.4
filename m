Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FAB6563DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiLZPld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLZPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:41:31 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A141088
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:41:29 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 852C01B7;
        Mon, 26 Dec 2022 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672069078;
        bh=TlzcMNZu1ovWQoSQAD3PXjyrNmnDTozhzJJwdXzf4Nw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=R8T/sYnEn8GYuZvIX+08kFtW8bA4UrZiXLc/BUveEmJ+z0j5UbXnCpDmAXGLodl9T
         saYXSR9BuVCV2dbMxMqyuhcHaJJEPid2pz8MOT3cbnh2B6UCrGEtv0ZUjJR2URCmTb
         9ZjfSmp3oTsPr0W+0lpz3IauTpMQGj2zepgYV2F8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CECFB1D33;
        Mon, 26 Dec 2022 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672069287;
        bh=TlzcMNZu1ovWQoSQAD3PXjyrNmnDTozhzJJwdXzf4Nw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=kapAm05Tn7Et37qzEtTpKYHE+tBuO75miXfvm6hF5RoXI54ndxMqMvRoDQAguOGSV
         pSQ6noanPET+FTjacynTUXPRIxT4JVT9nWjAXTYArEx7ip4WVsuGLG/1UITbUXm37R
         /fFUKYXOz6KklFHsTdlqjjj1z9Bjf/dyJHQjKp6k=
Received: from [192.168.211.153] (192.168.211.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Dec 2022 18:41:27 +0300
Message-ID: <49383f48-0796-3f84-d21b-1a92b92f64e3@paragon-software.com>
Date:   Mon, 26 Dec 2022 19:41:26 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ntfs3: Fix leaked mount_options if fill_super failed
Content-Language: en-US
To:     Chen Zhongjin <chenzhongjin@huawei.com>, <ntfs3@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
CC:     <kari.argillander@gmail.com>
References: <20221122092518.231347-1-chenzhongjin@huawei.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221122092518.231347-1-chenzhongjin@huawei.com>
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

On 22.11.2022 13:25, Chen Zhongjin wrote:
> '9b75450d6c58 ("fs/ntfs3: Fix memory leak if fill_super failed")'
> Previous patch fixed leaked sbi when fill_super failed but forgot to put
> mount_options and left it leaked as kmemleak reported:
>
> unreferenced object 0xffff888107c353c0 (size 32):
>    backtrace:
>      [<00000000cf2c8c32>] kmalloc_trace+0x27/0x110
>      [<000000000184a864>] ntfs_init_fs_context+0x4c/0x540 [ntfs3]
>      [<000000008ded85aa>] alloc_fs_context+0x50e/0x940
>      [<00000000c225e601>] path_mount+0x747/0x1930
>      [<000000007bf15a5f>] do_mount+0xf3/0x110
>      ...
> unreferenced object 0xffff888101fdc2d0 (size 8):
>    backtrace:
>      [<00000000d0cba437>] __kmalloc_node_track_caller+0x4c/0x1c0
>      [<00000000923513f8>] kmemdup_nul+0x37/0xb0
>      [<000000007a9b98ed>] vfs_parse_fs_string+0xc5/0x150
>      [<00000000afbd0594>] generic_parse_monolithic+0x140/0x1c0
>      [<00000000e97e814e>] path_mount+0xf09/0x1930
>      [<000000007bf15a5f>] do_mount+0xf3/0x110
>      ...
>
> Fixes: 610f8f5a7baf ("fs/ntfs3: Use new api for mounting")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>   fs/ntfs3/super.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 47012c9bf505..c0e45f170701 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1281,6 +1281,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   	 * Free resources here.
>   	 * ntfs_fs_free will be called with fc->s_fs_info = NULL
>   	 */
> +	put_mount_options(sbi->options);
>   	put_ntfs(sbi);
>   	sb->s_fs_info = NULL;
>   

Thanks for work, this bug has already been fixed:

https://lore.kernel.org/ntfs3/20220823103205.1380235-1-syoshida@redhat.com/

