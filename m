Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896A35F0F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiI3QKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiI3QJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:09:48 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF727DDD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:09:45 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6C0281D0C;
        Fri, 30 Sep 2022 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1664554048;
        bh=Cpjqbr3oteMa6FuwE7+YFQQstOqKDnvrWssgILEQknM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=kCm1sS14B9M5zn5FUxghhrZB5lZHZkWXs/bFXgZphaBi0Z9qv+YjJd1AIoSY547mR
         HGBFPinxHju+AXlnc0bnIQwwltWBzUNI5m25E6Wu5EOx69t17yjzPG6rlBkxsZ/8af
         cRxlzuzxsOLmCR6MTmppnzJ+ol5bf/oQqU4qQkfY=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Sep 2022 19:09:43 +0300
Message-ID: <a6ea95dc-0f44-8ee0-c030-6c87a0eca1b7@paragon-software.com>
Date:   Fri, 30 Sep 2022 19:09:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] fs/ntfs3: fix slab-out-of-bounds Read in run_unpack
Content-Language: en-US
To:     Hawkins Jiawei <yin31149@gmail.com>,
        <syzbot+8d6fbb27a6aded64b25b@syzkaller.appspotmail.com>
CC:     <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>,
        <syzkaller-bugs@googlegroups.com>, <18801353760@163.com>
References: <0000000000009145fc05e94bd5c3@google.com>
 <20220923110905.33588-1-yin31149@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220923110905.33588-1-yin31149@gmail.com>
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



On 9/23/22 14:09, Hawkins Jiawei wrote:
> Syzkaller reports slab-out-of-bounds bug as follows:
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in run_unpack+0x8b7/0x970 fs/ntfs3/run.c:944
> Read of size 1 at addr ffff88801bbdff02 by task syz-executor131/3611
> 
> [...]
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   print_address_description mm/kasan/report.c:317 [inline]
>   print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
>   kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
>   run_unpack+0x8b7/0x970 fs/ntfs3/run.c:944
>   run_unpack_ex+0xb0/0x7c0 fs/ntfs3/run.c:1057
>   ntfs_read_mft fs/ntfs3/inode.c:368 [inline]
>   ntfs_iget5+0xc20/0x3280 fs/ntfs3/inode.c:501
>   ntfs_loadlog_and_replay+0x124/0x5d0 fs/ntfs3/fsntfs.c:272
>   ntfs_fill_super+0x1eff/0x37f0 fs/ntfs3/super.c:1018
>   get_tree_bdev+0x440/0x760 fs/super.c:1323
>   vfs_get_tree+0x89/0x2f0 fs/super.c:1530
>   do_new_mount fs/namespace.c:3040 [inline]
>   path_mount+0x1326/0x1e20 fs/namespace.c:3370
>   do_mount fs/namespace.c:3383 [inline]
>   __do_sys_mount fs/namespace.c:3591 [inline]
>   __se_sys_mount fs/namespace.c:3568 [inline]
>   __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   [...]
>   </TASK>
> 
> The buggy address belongs to the physical page:
> page:ffffea00006ef600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bbd8
> head:ffffea00006ef600 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff88801bbdfe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88801bbdfe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff88801bbdff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                     ^
>   ffff88801bbdff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88801bbe0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Kernel will tries to read record and parse MFT from disk in
> ntfs_read_mft().
> 
> Yet the problem is that during enumerating attributes in record,
> kernel doesn't check whether run_off field loading from the disk
> is a valid value.
> 
> To be more specific, if attr->nres.run_off is larger than attr->size,
> kernel will passes an invalid argument run_buf_size in
> run_unpack_ex(), which having an integer overflow. Then this invalid
> argument will triggers the slab-out-of-bounds Read bug as above.
> 
> This patch solves it by adding the sanity check between
> the offset to packed runs and attribute size.
> 
> link: https://lore.kernel.org/all/0000000000009145fc05e94bd5c3@google.com/#t
> Reported-and-tested-by: syzbot+8d6fbb27a6aded64b25b@syzkaller.appspotmail.com
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v1 -> v2:
>    return -EINVAL when roff is out-of-bounds
> 
>   fs/ntfs3/inode.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 51363d4e8636..10723231e482 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -365,6 +365,13 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>   	roff = le16_to_cpu(attr->nres.run_off);
>   
>   	t64 = le64_to_cpu(attr->nres.svcn);
> +
> +	/* offset to packed runs is out-of-bounds */
> +	if (roff > asize) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>   	err = run_unpack_ex(run, sbi, ino, t64, le64_to_cpu(attr->nres.evcn),
>   			    t64, Add2Ptr(attr, roff), asize - roff);
>   	if (err < 0)

Thanks for patch, applied!
