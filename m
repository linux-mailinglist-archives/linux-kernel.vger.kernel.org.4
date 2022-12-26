Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514136563AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiLZO7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiLZO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:59:21 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161E1138
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:59:19 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B37902113;
        Mon, 26 Dec 2022 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672066548;
        bh=Fn1Dqc6XWORUjQACbPZss3I5gZqdvuNA6MIHW/CYL2A=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=aKTd4fLrVdz1puMuzrws7uhWhqw8LtUC67H+CAu1hb7x+HRbqtGRTfWrlEfkbvxYg
         eYRTU2Pf0syPc40qMoXjUIoER3bQcbNX+bgS/ZoFWyewsji+JySeimSrz4S/AP0gkF
         148Cfu+WoTm8mQ/lwSvC0bzSZPuwh5AlBiDYJJ+o=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 095DB212B;
        Mon, 26 Dec 2022 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672066758;
        bh=Fn1Dqc6XWORUjQACbPZss3I5gZqdvuNA6MIHW/CYL2A=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TZ37FJ2QGQWLGMz6DttrSwABzxjJmG9h786gsmvKJIarP2P5dogya8kcAFqIyRxfy
         WY4PDLRRmgE3FA8oL3clg7Z07r1KBeKi0OTJcF5CjYSMvJTzeO7+wfPEXMWk3HW2iW
         vVXaXoRWYlTGja7hwJWot6hfUA6VngeeV3/NhLoE=
Received: from [192.168.211.153] (192.168.211.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Dec 2022 17:59:17 +0300
Message-ID: <718222b6-0291-dcdc-30d8-9b2a7e4e434c@paragon-software.com>
Date:   Mon, 26 Dec 2022 18:59:16 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ntfs3: Fix null-ptr-deref on inode->i_op in
 ntfs_lookup()
To:     Peng Zhang <zhangpeng362@huawei.com>, <kari.argillander@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>,
        <syzbot+a8f26a403c169b7593fe@syzkaller.appspotmail.com>
References: <20221125102159.91591-1-zhangpeng362@huawei.com>
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221125102159.91591-1-zhangpeng362@huawei.com>
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

On 25.11.2022 14:21, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Syzbot reported a null-ptr-deref bug:
>
> ntfs3: loop0: Different NTFS' sector size (1024) and media sector size
> (512)
> ntfs3: loop0: Mark volume as dirty due to NTFS errors
> general protection fault, probably for non-canonical address
> 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> RIP: 0010:d_flags_for_inode fs/dcache.c:1980 [inline]
> RIP: 0010:__d_add+0x5ce/0x800 fs/dcache.c:2796
> Call Trace:
>   <TASK>
>   d_splice_alias+0x122/0x3b0 fs/dcache.c:3191
>   lookup_open fs/namei.c:3391 [inline]
>   open_last_lookups fs/namei.c:3481 [inline]
>   path_openat+0x10e6/0x2df0 fs/namei.c:3688
>   do_filp_open+0x264/0x4f0 fs/namei.c:3718
>   do_sys_openat2+0x124/0x4e0 fs/open.c:1310
>   do_sys_open fs/open.c:1326 [inline]
>   __do_sys_open fs/open.c:1334 [inline]
>   __se_sys_open fs/open.c:1330 [inline]
>   __x64_sys_open+0x221/0x270 fs/open.c:1330
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> If the MFT record of ntfs inode is not a base record, inode->i_op can be
> NULL. And a null-ptr-deref may happen:
>
> ntfs_lookup()
>      dir_search_u() # inode->i_op is set to NULL
>      d_splice_alias()
>          __d_add()
>              d_flags_for_inode() # inode->i_op->get_link null-ptr-deref
>
> Fix this by adding a Check on inode->i_op before calling the
> d_splice_alias() function.
>
> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> Reported-by: syzbot+a8f26a403c169b7593fe@syzkaller.appspotmail.com
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   fs/ntfs3/namei.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index bc22cc321a74..7760aedc0672 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -86,6 +86,16 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
>   		__putname(uni);
>   	}
>   
> +	/*
> +	 * Check for a null pointer
> +	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
> +	 * This causes null pointer dereference in d_splice_alias().
> +	 */
> +	if (!IS_ERR(inode) && inode->i_op == NULL) {
> +		iput(inode);
> +		inode = ERR_PTR(-EINVAL);
> +	}
> +
>   	return d_splice_alias(inode, dentry);
>   }
>   
Applied, thanks!
