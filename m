Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C945965639F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLZOu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiLZOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:50:26 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2C0267E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:50:25 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6CDA32112;
        Mon, 26 Dec 2022 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672066014;
        bh=ukI9jakFh2yz57dp6fz506Kyb5zH5OmJfIaNBaXl9uc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UuJbpwy7R1SoG0u/35Psa2ByKT/cjSHdoreYvRo4vuTg5qLHb0vE79vA8rVYcJJNq
         24z+EUBu6kMeAN63xC3JAAT2XuLrHyauCD6qV0yF9fp0Ebj20BVus+5U0U5kzRlV3E
         8IXySIy9GQZ2d/g5lZhYQseB1UrO3xJgPgFKId1c=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B6393212B;
        Mon, 26 Dec 2022 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672066223;
        bh=ukI9jakFh2yz57dp6fz506Kyb5zH5OmJfIaNBaXl9uc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=CHvMNSpLPqLjdCbh7f6Rc/Qb03IalhWtAaBUqPIWOqxacU3TBLadOH0C0st+k6dpo
         pjbo4AwW748aNvxtCgdUcvGMfsU6wUWXFAx5hwpOFr6rHtRd60zxxiphh+xaE8GyC8
         qoQBCDgF4fGwVXVrpQu9pOB26xcfi/B0NDPEJae8=
Received: from [192.168.211.153] (192.168.211.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Dec 2022 17:50:23 +0300
Message-ID: <634b2664-a968-27ae-35f2-e3b3de6f6603@paragon-software.com>
Date:   Mon, 26 Dec 2022 18:50:22 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ntfs3: fix NULL pointer dereference in 'ni_write_inode'
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <trix@redhat.com>,
        <ntfs3@lists.linux.dev>
CC:     <yebin10@huawei.com>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>,
        <syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com>
References: <20221117091912.3436127-1-yebin@huaweicloud.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221117091912.3436127-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.153]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2022 13:19, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> Syzbot found the following issue:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000016
> Mem abort info:
>    ESR = 0x0000000096000006
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x06: level 2 translation fault
> Data abort info:
>    ISV = 0, ISS = 0x00000006
>    CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010af56000
> [0000000000000016] pgd=08000001090da003, p4d=08000001090da003, pud=08000001090ce003, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 3036 Comm: syz-executor206 Not tainted 6.0.0-rc6-syzkaller-17739-g16c9f284e746 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : is_rec_inuse fs/ntfs3/ntfs.h:313 [inline]
> pc : ni_write_inode+0xac/0x798 fs/ntfs3/frecord.c:3232
> lr : ni_write_inode+0xa0/0x798 fs/ntfs3/frecord.c:3226
> sp : ffff8000126c3800
> x29: ffff8000126c3860 x28: 0000000000000000 x27: ffff0000c8b02000
> x26: ffff0000c7502320 x25: ffff0000c7502288 x24: 0000000000000000
> x23: ffff80000cbec91c x22: ffff0000c8b03000 x21: ffff0000c8b02000
> x20: 0000000000000001 x19: ffff0000c75024d8 x18: 00000000000000c0
> x17: ffff80000dd1b198 x16: ffff80000db59158 x15: ffff0000c4b6b500
> x14: 00000000000000b8 x13: 0000000000000000 x12: ffff0000c4b6b500
> x11: ff80800008be1b60 x10: 0000000000000000 x9 : ffff0000c4b6b500
> x8 : 0000000000000000 x7 : ffff800008be1b50 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000008 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>   is_rec_inuse fs/ntfs3/ntfs.h:313 [inline]
>   ni_write_inode+0xac/0x798 fs/ntfs3/frecord.c:3232
>   ntfs_evict_inode+0x54/0x84 fs/ntfs3/inode.c:1744
>   evict+0xec/0x334 fs/inode.c:665
>   iput_final fs/inode.c:1748 [inline]
>   iput+0x2c4/0x324 fs/inode.c:1774
>   ntfs_new_inode+0x7c/0xe0 fs/ntfs3/fsntfs.c:1660
>   ntfs_create_inode+0x20c/0xe78 fs/ntfs3/inode.c:1278
>   ntfs_create+0x54/0x74 fs/ntfs3/namei.c:100
>   lookup_open fs/namei.c:3413 [inline]
>   open_last_lookups fs/namei.c:3481 [inline]
>   path_openat+0x804/0x11c4 fs/namei.c:3688
>   do_filp_open+0xdc/0x1b8 fs/namei.c:3718
>   do_sys_openat2+0xb8/0x22c fs/open.c:1311
>   do_sys_open fs/open.c:1327 [inline]
>   __do_sys_openat fs/open.c:1343 [inline]
>   __se_sys_openat fs/open.c:1338 [inline]
>   __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
>   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>   invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>   el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>   do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>   el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>   el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>   el0t_64_sync+0x18c/0x190
> Code: 97dafee4 340001b4 f9401328 2a1f03e0 (79402d14)
> ---[ end trace 0000000000000000 ]---
>
> Above issue may happens as follows:
> ntfs_new_inode
>    mi_init
>      mi->mrec = kmalloc(sbi->record_size, GFP_NOFS); -->failed to allocate memory
>        if (!mi->mrec)
>          return -ENOMEM;
> iput
>    iput_final
>      evict
>        ntfs_evict_inode
>          ni_write_inode
> 	  is_rec_inuse(ni->mi.mrec)-> As 'ni->mi.mrec' is NULL trigger NULL-ptr-deref
>
> To solve above issue if new inode failed make inode bad before call 'iput()' in
> 'ntfs_new_inode()'.
>
> Reported-by: syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/ntfs3/fsntfs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 567563771bf8..8de861ddec60 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -1683,6 +1683,7 @@ struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno, bool dir)
>   
>   out:
>   	if (err) {
> +		make_bad_inode(inode);
>   		iput(inode);
>   		ni = ERR_PTR(err);
>   	}
Thanks for patch, applied!
