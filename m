Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A408745634
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGCHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:37:02 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592F4C1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:37:01 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id F06091D2D;
        Mon,  3 Jul 2023 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688369508;
        bh=Q1kxw7tFWb69BAN/Qf4UiHiFviYwxux4CDjZHUEvFaQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ipELvgRgCm7tKaHR3npGCFxP/Nn1HUTJ4/qAKpsmiNR72QfY/uYb4gdJ8LC6rxyYu
         L4tWva6Cv1JvEZ7FHiT1/8P3hp7xV0tYt8zlhdb8RBV37JqR8Mk5p38KXOO91R84O7
         DSv+o0e2cVXhp/D9/nfVbP5lpsQU6H7yIN9FnAOU=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:36:58 +0300
Message-ID: <34e1080f-6e87-5a9f-6a0b-5ce352a4b456@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:36:57 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/ntfs3: fix panic about slab-out-of-bounds caused by
 ntfs_list_ea()
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>
CC:     <weiyongjun1@huawei.com>, <xiexiuqi@huawei.com>,
        <ntfs3@lists.linux.dev>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20230420074622.210011-1-zengheng4@huawei.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20230420074622.210011-1-zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.138]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.2023 11:46, Zeng Heng wrote:
> Here is a BUG report about linux-6.1 from syzbot, but it still remains
> within upstream:
>
> BUG: KASAN: slab-out-of-bounds in ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
> BUG: KASAN: slab-out-of-bounds in ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
> Read of size 1 at addr ffff888021acaf3d by task syz-executor128/3632
>
> Call Trace:
>   kasan_report+0x139/0x170 mm/kasan/report.c:495
>   ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
>   ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
>   vfs_listxattr fs/xattr.c:457 [inline]
>   listxattr+0x293/0x2d0 fs/xattr.c:804
>   path_listxattr fs/xattr.c:828 [inline]
>   __do_sys_llistxattr fs/xattr.c:846 [inline]
>
> Before derefering field members of `ea` in unpacked_ea_size(), we need to
> check whether the EA_FULL struct is located in access validate range.
>
> Similarly, when derefering `ea->name` field member, we need to check
> whethe the ea->name is located in access validate range, too.
>
> Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
> Reported-by: syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>   fs/ntfs3/xattr.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index ff64302e87e5..27eb30453b9f 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -210,11 +210,15 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
>   	size = le32_to_cpu(info->size);
>   
>   	/* Enumerate all xattrs. */
> -	for (ret = 0, off = 0; off < size; off += ea_size) {
> +	for (ret = 0, off = 0; off + sizeof(struct EA_FULL) < size; off += ea_size) {
>   		ea = Add2Ptr(ea_all, off);
>   		ea_size = unpacked_ea_size(ea);
>   
>   		if (buffer) {
> +			/* Check if we can use field ea->name */
> +			if (off + ea_size > size)
> +				break;
> +
>   			if (ret + ea->name_len + 1 > bytes_per_buffer) {
>   				err = -ERANGE;
>   				goto out;
Thanks, your patch has been applied.
