Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754385F0F43
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiI3Pv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiI3Pvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:51:50 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF0C10462F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:51:26 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C66A21D0C;
        Fri, 30 Sep 2022 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1664552949;
        bh=co0dMmEoGmARvBRIH+x8b0r6owgzijM7+V2oU2F9A5g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=N7T0AdNtfVWvxuSkyTrLWo6pcs5QIg6ztWIiUuQRx/u26EWZhGX37dJz74425UYLk
         mEp1PliufVaThcXsiS2PyHTuToXdtR1aD0hHT/NAgZRjlr9M6NfZOqxalRl95q+weX
         iCojCSensY1OrQEUxGneTPrjCABIuQMMKug2uQXU=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D64D51E81;
        Fri, 30 Sep 2022 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1664553084;
        bh=co0dMmEoGmARvBRIH+x8b0r6owgzijM7+V2oU2F9A5g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jPbWnV0dg8J1idpqbeZtO2Kh0Ok1qw7Ql+TXjS2smAXYd862H4qzydX1ady6/4b25
         7jmf5//4xpA3Y9MSMCoTU8HYHtX7yV5F2RRh8dZLttx+LO95UXtZBpFv15Zwc9bSs5
         f4wJ+KmKCWtMAM21LZoqlLOWD6UjvNxgo3xG1aoI=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Sep 2022 18:51:24 +0300
Message-ID: <b37f7ee0-a141-3333-cdaf-47ac355c4161@paragon-software.com>
Date:   Fri, 30 Sep 2022 18:51:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fs/ntfs3: Fix memory leak on ntfs_fill_super() error path
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com>
References: <20220823103205.1380235-1-syoshida@redhat.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220823103205.1380235-1-syoshida@redhat.com>
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



On 8/23/22 13:32, Shigeru Yoshida wrote:
> syzbot reported kmemleak as below:
> 
> BUG: memory leak
> unreferenced object 0xffff8880122f1540 (size 32):
>    comm "a.out", pid 6664, jiffies 4294939771 (age 25.500s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 ed ff ed ff 00 00 00 00  ................
>    backtrace:
>      [<ffffffff81b16052>] ntfs_init_fs_context+0x22/0x1c0
>      [<ffffffff8164aaa7>] alloc_fs_context+0x217/0x430
>      [<ffffffff81626dd4>] path_mount+0x704/0x1080
>      [<ffffffff81627e7c>] __x64_sys_mount+0x18c/0x1d0
>      [<ffffffff84593e14>] do_syscall_64+0x34/0xb0
>      [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> This patch fixes this issue by freeing mount options on error path of
> ntfs_fill_super().
> 
> Reported-by: syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
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

Thanks for patch, applied!
