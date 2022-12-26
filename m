Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CBE6562FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiLZODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiLZODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:03:32 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F5D5FCB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:03:31 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E2303210E;
        Mon, 26 Dec 2022 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672063200;
        bh=GmoPRUevTi/LS3JQhcCfpDWtzViNNRyUMDftWfbRZuE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NIfqmDRqAbZwj6vgfZeWDB884G0wksLNkUj2RF5no8LcedSf1NJlSFBgpyhhtOP68
         /bSc/Vn6zaqqWm/in6fMnottEF6n5q6yuh/5JDqEf8uExxpdLS/ZncfK/oXczYBM/U
         /2Mwtj3inL+I7hrSVYBaPDe5QqedL9067HmRZ7dY=
Received: from [192.168.211.153] (192.168.211.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Dec 2022 17:03:28 +0300
Message-ID: <827ff7b2-8246-378b-e389-150d22205e9b@paragon-software.com>
Date:   Mon, 26 Dec 2022 18:03:27 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ntfs3: Fix OOB read in indx_insert_into_buffer
To:     Peng Zhang <zhangpeng362@huawei.com>, <kari.argillander@gmail.com>,
        <paskripkin@gmail.com>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <hch@lst.de>, <akpm@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>,
        <syzbot+d882d57193079e379309@syzkaller.appspotmail.com>
References: <20221207094610.998485-1-zhangpeng362@huawei.com>
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221207094610.998485-1-zhangpeng362@huawei.com>
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


On 07.12.2022 13:46, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Syzbot reported a OOB read bug:
>
> BUG: KASAN: slab-out-of-bounds in indx_insert_into_buffer+0xaa3/0x13b0
> fs/ntfs3/index.c:1755
> Read of size 17168 at addr ffff8880255e06c0 by task syz-executor308/3630
>
> Call Trace:
>   <TASK>
>   memmove+0x25/0x60 mm/kasan/shadow.c:54
>   indx_insert_into_buffer+0xaa3/0x13b0 fs/ntfs3/index.c:1755
>   indx_insert_entry+0x446/0x6b0 fs/ntfs3/index.c:1863
>   ntfs_create_inode+0x1d3f/0x35c0 fs/ntfs3/inode.c:1548
>   ntfs_create+0x3e/0x60 fs/ntfs3/namei.c:100
>   lookup_open fs/namei.c:3413 [inline]
>
> If the member struct INDEX_BUFFER *index of struct indx_node is
> incorrect, that is, the value of __le32 used is greater than the value
> of __le32 total in struct INDEX_HDR. Therefore, OOB read occurs when
> memmove is called in indx_insert_into_buffer().
> Fix this by adding a check in hdr_find_e().
>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Reported-by: syzbot+d882d57193079e379309@syzkaller.appspotmail.com
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   fs/ntfs3/index.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 440328147e7e..28af0a5afbf2 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -679,9 +679,13 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
>   	u32 e_size, e_key_len;
>   	u32 end = le32_to_cpu(hdr->used);
>   	u32 off = le32_to_cpu(hdr->de_off);
> +	u32 total = le32_to_cpu(hdr->total);
>   	u16 offs[128];
>   
>   fill_table:
> +	if (end > total)
> +		return NULL;
> +
>   	if (off + sizeof(struct NTFS_DE) > end)
>   		return NULL;
>   
Applied, thanks for the patch!
