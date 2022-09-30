Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B125F0FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiI3QV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiI3QVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:21:54 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5000A2B61C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:21:53 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 339611D0C;
        Fri, 30 Sep 2022 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1664554776;
        bh=J+wfgllXwhLlahIGgqIBX6suMZ9PoYV9QymXeIuNwCc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=bNdPIHuapMl8Koo/PjBaYPQsAzsMr6saaO3CGJ5rIunkK1GpDENWC7JMMnJKngm7u
         mKcbVIu/Ky7WWweEWCpDT0ziFVXpTTYveDw3qlfW09CDp2PbGsslDqYIlwB1jDeL/D
         mAIg0kgRsB7rS7+dVSZ6fwtD8q68rQmcZluRFurc=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 43A161E81;
        Fri, 30 Sep 2022 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1664554911;
        bh=J+wfgllXwhLlahIGgqIBX6suMZ9PoYV9QymXeIuNwCc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ux6Q0Z9Px7xpCRJV5iyUCUxcTIEmVXbWJLM9Tr+SN5unkJbSR+5khsfttRre6sTYQ
         dQkBD+3fEVkwYWWfl/55qxa+cM3HXyz4vqDT0GR9mI7mRmSvAUsJK+1DSXuc8ZkmNe
         0DKnKFcBvDBe0zAy9SJ1LZ7M5j2bNU7Ja9L5lOLo=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Sep 2022 19:21:50 +0300
Message-ID: <6bb11497-c6bd-41ea-409a-fbddcf75ea97@paragon-software.com>
Date:   Fri, 30 Sep 2022 19:21:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fs/ntfs3: fix memory leak in put_ntfs()
Content-Language: en-US
To:     Karthik Alapati <mail@karthek.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
References: <Yw7k0VQm+8l8JKWr@karthik-strix-linux.karthek.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <Yw7k0VQm+8l8JKWr@karthik-strix-linux.karthek.com>
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



On 8/31/22 07:34, Karthik Alapati wrote:
> free options in put_ntfs() rather than in ntfs_put_super()
> 
> BUG: memory leak
> unreferenced object 0xffff8881104f3720 (size 32):
>    comm "syz-executor634", pid 3605, jiffies 4294945517 (age 12.630s)
>    hex dump (first 32 bytes):
>      e0 36 4f 10 81 88 ff ff 80 57 e1 85 ff ff ff ff  .6O......W......
>      00 00 00 00 00 00 00 00 c0 ff c0 ff 00 00 00 00  ................
>    backtrace:
>      [<ffffffff81b23ef2>] kmalloc include/linux/slab.h:600 [inline]
>      [<ffffffff81b23ef2>] kzalloc include/linux/slab.h:733 [inline]
>      [<ffffffff81b23ef2>] ntfs_init_fs_context+0x22/0x1e0 fs/ntfs3/super.c:1397
>      [<ffffffff81650045>] alloc_fs_context+0x225/0x3b0 fs/fs_context.c:290
>      [<ffffffff8162bed3>] do_new_mount fs/namespace.c:3025 [inline]
>      [<ffffffff8162bed3>] path_mount+0x6f3/0x10d0 fs/namespace.c:3370
>      [<ffffffff8162cffe>] do_mount fs/namespace.c:3383 [inline]
>      [<ffffffff8162cffe>] __do_sys_mount fs/namespace.c:3591 [inline]
>      [<ffffffff8162cffe>] __se_sys_mount fs/namespace.c:3568 [inline]
>      [<ffffffff8162cffe>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>      [<ffffffff845e4855>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>      [<ffffffff845e4855>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>      [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> BUG: memory leak
> unreferenced object 0xffff8881104f36e0 (size 32):
>    comm "syz-executor634", pid 3605, jiffies 4294945517 (age 12.630s)
>    hex dump (first 32 bytes):
>      6d 61 63 63 79 72 69 6c 6c 69 63 00 00 00 00 00  maccyrillic.....
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff814c5b1d>] kmemdup_nul+0x2d/0x70 mm/util.c:152
>      [<ffffffff8164f66e>] vfs_parse_fs_string+0x6e/0xd0 fs/fs_context.c:178
>      [<ffffffff8164f7b0>] generic_parse_monolithic+0xe0/0x130 fs/fs_context.c:224
>      [<ffffffff8162c374>] do_new_mount fs/namespace.c:3036 [inline]
>      [<ffffffff8162c374>] path_mount+0xb94/0x10d0 fs/namespace.c:3370
>      [<ffffffff8162cffe>] do_mount fs/namespace.c:3383 [inline]
>      [<ffffffff8162cffe>] __do_sys_mount fs/namespace.c:3591 [inline]
>      [<ffffffff8162cffe>] __se_sys_mount fs/namespace.c:3568 [inline]
>      [<ffffffff8162cffe>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>      [<ffffffff845e4855>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>      [<ffffffff845e4855>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>      [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Link: https://syzkaller.appspot.com/bug?id=332ba47915d0e39e94b42a622f195f0804ecb67f
> Reported-by: syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com
> Signed-off-by: Karthik Alapati <mail@karthek.com>
> ---
>   fs/ntfs3/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 47012c9bf505..ffb76a5bfd4f 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -439,6 +439,7 @@ static void init_once(void *foo)
>    */
>   static noinline void put_ntfs(struct ntfs_sb_info *sbi)
>   {
> +	put_mount_options(sbi->options);
>   	kfree(sbi->new_rec);
>   	kvfree(ntfs_put_shared(sbi->upcase));
>   	kfree(sbi->def_table);
> @@ -482,7 +483,6 @@ static void ntfs_put_super(struct super_block *sb)
>   	/* Mark rw ntfs as clear, if possible. */
>   	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
>   
> -	put_mount_options(sbi->options);
>   	put_ntfs(sbi);
>   	sb->s_fs_info = NULL;
>   

Hello
This patch failed our tests and caused email from kernel test robot,
so I can't accept it.
But the memory leak is a concern, thanks for the report.
