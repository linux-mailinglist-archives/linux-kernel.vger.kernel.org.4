Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD0663EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjAJLGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjAJLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:05:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C6C3D9D0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:04:46 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NrnwW75j9znVDC;
        Tue, 10 Jan 2023 19:03:07 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 19:04:41 +0800
Message-ID: <ca708dc7-cd97-2b64-37e9-1abf84df28c9@huawei.com>
Date:   Tue, 10 Jan 2023 19:04:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ntfs: fix panic about slab-out-of-bounds caused by
 ntfs_listxattr()
Content-Language: en-US
From:   Zeng Heng <zengheng4@huawei.com>
To:     <almaz.alexandrovich@paragon-software.com>
CC:     <ntfs3@lists.linux.dev>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
References: <20221207162807.227498-1-zengheng4@huawei.com>
In-Reply-To: <20221207162807.227498-1-zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/8 0:28, Zeng Heng wrote:
> Here is a BUG report from syzbot:
>
> BUG: KASAN: slab-out-of-bounds in ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
> BUG: KASAN: slab-out-of-bounds in ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
> Read of size 1 at addr ffff888021acaf3d by task syz-executor128/3632
>
> Call Trace:
>   ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
>   ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
>   vfs_listxattr fs/xattr.c:457 [inline]
>   listxattr+0x293/0x2d0 fs/xattr.c:804
>
> Fix the logic of ea_all iteration. When the ea->name_len is 0,
> return immediately, or Add2Ptr() would visit invalid memory
> in the next loop.
>
> Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
> Reported-by: syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>   fs/ntfs3/xattr.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 7de8718c68a9..911e110b8d6e 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -178,6 +178,9 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
>   	for (ret = 0, off = 0; off < size; off += unpacked_ea_size(ea)) {
>   		ea = Add2Ptr(ea_all, off);
>   
> +		if (!ea->name_len)
> +			break;
> +
>   		if (buffer) {
>   			if (ret + ea->name_len + 1 > bytes_per_buffer) {
>   				err = -ERANGE;

Is there any comment about this patch?

Thanks for advance.


Zeng Heng


